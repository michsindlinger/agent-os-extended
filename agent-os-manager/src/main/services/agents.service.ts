import { readFile, writeFile, unlink, mkdir } from 'fs/promises'
import { join } from 'path'
import { existsSync } from 'fs'
import { glob } from 'glob'
import { getAllPaths } from '../utils/paths'
import { parseFrontmatter, validateAgentFrontmatter } from '../utils/frontmatter'

export interface Agent {
  name: string
  description: string
  tools?: string[]
  color?: string
  mcp_integrations?: string[]
  source: 'global' | 'project'
  path: string
  globalPath?: string
  content: string
}

/**
 * List all agents (global + project, merged)
 */
export async function listAgents(): Promise<Agent[]> {
  const paths = getAllPaths()
  const agentsMap = new Map<string, Agent>()

  // Get global agents
  const globalPattern = join(paths.globalClaude, 'agents', '*.md')
  const globalFiles = await glob(globalPattern)

  for (const filePath of globalFiles) {
    try {
      const content = await readFile(filePath, 'utf-8')
      const { frontmatter } = parseFrontmatter(content)

      if (frontmatter.name) {
        agentsMap.set(frontmatter.name, {
          name: frontmatter.name,
          description: frontmatter.description || '',
          tools: frontmatter.tools,
          color: frontmatter.color,
          mcp_integrations: frontmatter.mcp_integrations,
          source: 'global',
          path: filePath,
          content
        })
      }
    } catch (error) {
      console.error(`Error reading agent: ${filePath}`, error)
    }
  }

  // Get project agents (override global)
  if (paths.projectClaude) {
    const projectPattern = join(paths.projectClaude, 'agents', '*.md')
    const projectFiles = await glob(projectPattern)

    for (const filePath of projectFiles) {
      try {
        const content = await readFile(filePath, 'utf-8')
        const { frontmatter } = parseFrontmatter(content)

        if (frontmatter.name) {
          const globalAgent = agentsMap.get(frontmatter.name)

          agentsMap.set(frontmatter.name, {
            name: frontmatter.name,
            description: frontmatter.description || '',
            tools: frontmatter.tools,
            color: frontmatter.color,
            mcp_integrations: frontmatter.mcp_integrations,
            source: 'project',
            path: filePath,
            globalPath: globalAgent?.path,
            content
          })
        }
      } catch (error) {
        console.error(`Error reading project agent: ${filePath}`, error)
      }
    }
  }

  return Array.from(agentsMap.values()).sort((a, b) => a.name.localeCompare(b.name))
}

/**
 * Read a specific agent by name
 */
export async function readAgent(name: string): Promise<Agent | null> {
  const agents = await listAgents()
  return agents.find((a) => a.name === name) || null
}

/**
 * Write agent to project location
 */
export async function writeAgent(name: string, content: string): Promise<void> {
  const paths = getAllPaths()

  if (!paths.projectClaude) {
    throw new Error('No project found. Please open a project directory.')
  }

  // Validate frontmatter
  const { frontmatter } = parseFrontmatter(content)
  const validation = validateAgentFrontmatter(frontmatter)

  if (!validation.valid) {
    throw new Error(`Invalid agent frontmatter:\n${validation.errors.join('\n')}`)
  }

  // Ensure agents directory exists
  const agentsDir = join(paths.projectClaude, 'agents')
  if (!existsSync(agentsDir)) {
    await mkdir(agentsDir, { recursive: true })
  }

  // Write to project
  const filePath = join(agentsDir, `${name}.md`)
  await writeFile(filePath, content, 'utf-8')
}

/**
 * Delete agent from project (revert to global)
 */
export async function deleteAgent(name: string): Promise<void> {
  const agent = await readAgent(name)

  if (!agent) {
    throw new Error(`Agent not found: ${name}`)
  }

  if (agent.source === 'global') {
    throw new Error(`Cannot delete global agent: ${name}`)
  }

  await unlink(agent.path)
}

/**
 * Override agent to project
 */
export async function overrideAgentToProject(name: string): Promise<void> {
  const agent = await readAgent(name)

  if (!agent) {
    throw new Error(`Agent not found: ${name}`)
  }

  if (agent.source === 'project') {
    throw new Error(`Agent is already a project override: ${name}`)
  }

  const content = await readFile(agent.path, 'utf-8')
  await writeAgent(name, content)
}

/**
 * Get diff between global and project versions
 */
export async function diffAgent(name: string): Promise<{
  globalContent: string | null
  projectContent: string | null
} | null> {
  const agent = await readAgent(name)

  if (!agent) {
    return null
  }

  if (agent.source === 'global') {
    return {
      globalContent: agent.content,
      projectContent: null
    }
  }

  const globalContent = agent.globalPath ? await readFile(agent.globalPath, 'utf-8') : null

  return {
    globalContent,
    projectContent: agent.content
  }
}
