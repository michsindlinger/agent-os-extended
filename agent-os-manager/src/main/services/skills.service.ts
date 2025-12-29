import { readFile, writeFile, unlink, mkdir } from 'fs/promises'
import { join, dirname } from 'path'
import { existsSync } from 'fs'
import { glob } from 'glob'
import { getAllPaths, listComponentFiles } from '../utils/paths'
import { parseFrontmatter, validateSkillFrontmatter, serializeFrontmatter } from '../utils/frontmatter'

export interface Skill {
  name: string
  description: string
  globs: string[]
  source: 'global' | 'project'
  path: string
  globalPath?: string
  content: string
}

/**
 * List all skills (global + project, merged with project overriding global)
 */
export async function listSkills(): Promise<Skill[]> {
  const paths = getAllPaths()
  const skillsMap = new Map<string, Skill>()

  // Get global skills
  const globalPatterns = [
    join(paths.globalAgentOS, 'skills/**/*.md'),
    join(paths.globalClaude, 'skills/**/*.md')
  ]

  for (const pattern of globalPatterns) {
    const files = await glob(pattern)

    for (const filePath of files) {
      try {
        const content = await readFile(filePath, 'utf-8')
        const { frontmatter } = parseFrontmatter(content)

        if (frontmatter.name) {
          skillsMap.set(frontmatter.name, {
            name: frontmatter.name,
            description: frontmatter.description || '',
            globs: frontmatter.globs || [],
            source: 'global',
            path: filePath,
            content
          })
        }
      } catch (error) {
        console.error(`Error reading skill: ${filePath}`, error)
      }
    }
  }

  // Get project skills (override global if same name)
  if (paths.projectClaude) {
    const projectPattern = join(paths.projectClaude, 'skills/**/*.md')
    const projectFiles = await glob(projectPattern)

    for (const filePath of projectFiles) {
      try {
        const content = await readFile(filePath, 'utf-8')
        const { frontmatter } = parseFrontmatter(content)

        if (frontmatter.name) {
          const globalSkill = skillsMap.get(frontmatter.name)

          skillsMap.set(frontmatter.name, {
            name: frontmatter.name,
            description: frontmatter.description || '',
            globs: frontmatter.globs || [],
            source: 'project',
            path: filePath,
            globalPath: globalSkill?.path,
            content
          })
        }
      } catch (error) {
        console.error(`Error reading project skill: ${filePath}`, error)
      }
    }
  }

  return Array.from(skillsMap.values()).sort((a, b) => a.name.localeCompare(b.name))
}

/**
 * Read a specific skill by name
 */
export async function readSkill(name: string): Promise<Skill | null> {
  const skills = await listSkills()
  return skills.find((s) => s.name === name) || null
}

/**
 * Write skill to project location
 */
export async function writeSkill(name: string, content: string): Promise<void> {
  const paths = getAllPaths()

  if (!paths.projectClaude) {
    throw new Error('No project found. Please open a project directory.')
  }

  // Validate frontmatter before writing
  const { frontmatter } = parseFrontmatter(content)
  const validation = validateSkillFrontmatter(frontmatter)

  if (!validation.valid) {
    throw new Error(`Invalid skill frontmatter:\n${validation.errors.join('\n')}`)
  }

  // Ensure skills directory exists
  const skillsDir = join(paths.projectClaude, 'skills')
  if (!existsSync(skillsDir)) {
    await mkdir(skillsDir, { recursive: true })
  }

  // Write to project
  const filePath = join(skillsDir, `${name}.md`)
  await writeFile(filePath, content, 'utf-8')
}

/**
 * Delete skill from project (revert to global)
 */
export async function deleteSkill(name: string): Promise<void> {
  const skill = await readSkill(name)

  if (!skill) {
    throw new Error(`Skill not found: ${name}`)
  }

  if (skill.source === 'global') {
    throw new Error(`Cannot delete global skill: ${name}`)
  }

  await unlink(skill.path)
}

/**
 * Override skill to project (copy global → project)
 */
export async function overrideSkillToProject(name: string): Promise<void> {
  const skill = await readSkill(name)

  if (!skill) {
    throw new Error(`Skill not found: ${name}`)
  }

  if (skill.source === 'project') {
    throw new Error(`Skill is already a project override: ${name}`)
  }

  // Read global content
  const content = await readFile(skill.path, 'utf-8')

  // Write to project
  await writeSkill(name, content)
}

/**
 * Get diff between global and project versions
 */
export async function diffSkill(name: string): Promise<{
  globalContent: string | null
  projectContent: string | null
} | null> {
  const skill = await readSkill(name)

  if (!skill) {
    return null
  }

  if (skill.source === 'global') {
    // No project override
    return {
      globalContent: skill.content,
      projectContent: null
    }
  }

  // Has project override
  const globalContent = skill.globalPath ? await readFile(skill.globalPath, 'utf-8') : null

  return {
    globalContent,
    projectContent: skill.content
  }
}
