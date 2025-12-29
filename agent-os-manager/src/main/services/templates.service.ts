import { readFile, writeFile, mkdir } from 'fs/promises'
import { join, relative } from 'path'
import { existsSync } from 'fs'
import { glob } from 'glob'
import { getAllPaths } from '../utils/paths'

export interface Template {
  name: string
  path: string
  relativePath: string
  category: string
  system: string
  source: 'global' | 'project'
  globalPath?: string
  content?: string
}

/**
 * List all templates in hierarchical structure
 */
export async function listTemplates(): Promise<Template[]> {
  const paths = getAllPaths()
  const templatesMap = new Map<string, Template>()

  // Get global templates
  const globalPattern = join(paths.globalAgentOS, 'templates/**/*.md')
  const globalFiles = await glob(globalPattern)

  for (const filePath of globalFiles) {
    const relativePath = relative(join(paths.globalAgentOS, 'templates'), filePath)
    const parts = relativePath.split('/')

    // Extract system and category from path
    // e.g., 'team-development/backend/api-spec.md'
    const system = parts[0] || 'other'
    const category = parts.length > 2 ? parts[1] : 'root'
    const name = parts[parts.length - 1].replace(/\.md$/, '')

    templatesMap.set(relativePath, {
      name,
      path: filePath,
      relativePath,
      category,
      system,
      source: 'global'
    })
  }

  // Get project templates (override global)
  if (paths.projectAgentOS) {
    const projectPattern = join(paths.projectAgentOS, 'templates/**/*.md')
    const projectFiles = await glob(projectPattern)

    for (const filePath of projectFiles) {
      const relativePath = relative(join(paths.projectAgentOS, 'templates'), filePath)
      const parts = relativePath.split('/')

      const system = parts[0] || 'other'
      const category = parts.length > 2 ? parts[1] : 'root'
      const name = parts[parts.length - 1].replace(/\.md$/, '')

      const globalTemplate = templatesMap.get(relativePath)

      templatesMap.set(relativePath, {
        name,
        path: filePath,
        relativePath,
        category,
        system,
        source: 'project',
        globalPath: globalTemplate?.path
      })
    }
  }

  return Array.from(templatesMap.values()).sort((a, b) => {
    // Sort by system, then category, then name
    if (a.system !== b.system) return a.system.localeCompare(b.system)
    if (a.category !== b.category) return a.category.localeCompare(b.category)
    return a.name.localeCompare(b.name)
  })
}

/**
 * Read template by relative path
 */
export async function readTemplate(relativePath: string): Promise<Template | null> {
  const templates = await listTemplates()
  const template = templates.find((t) => t.relativePath === relativePath)

  if (!template) {
    return null
  }

  // Load content
  const content = await readFile(template.path, 'utf-8')

  return {
    ...template,
    content
  }
}

/**
 * Write template to project location
 */
export async function writeTemplate(relativePath: string, content: string): Promise<void> {
  const paths = getAllPaths()

  if (!paths.projectAgentOS) {
    throw new Error('No project found. Please open a project directory.')
  }

  const filePath = join(paths.projectAgentOS, 'templates', relativePath)

  // Ensure directory exists
  await mkdir(join(filePath, '..'), { recursive: true })

  // Write to project
  await writeFile(filePath, content, 'utf-8')
}

/**
 * Override template to project
 */
export async function overrideTemplateToProject(relativePath: string): Promise<void> {
  const template = await readTemplate(relativePath)

  if (!template || !template.content) {
    throw new Error(`Template not found: ${relativePath}`)
  }

  if (template.source === 'project') {
    throw new Error(`Template is already a project override: ${relativePath}`)
  }

  await writeTemplate(relativePath, template.content)
}
