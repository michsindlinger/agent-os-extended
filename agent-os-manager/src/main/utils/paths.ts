import { homedir } from 'os'
import { join, dirname } from 'path'
import { existsSync } from 'fs'
import { glob } from 'glob'

export interface PathInfo {
  globalAgentOS: string
  projectAgentOS: string | null
  globalClaude: string
  projectClaude: string | null
  projectRoot: string | null
}

// Store custom project path
let customProjectPath: string | null = null

export function setCustomProjectPath(path: string | null): void {
  customProjectPath = path
}

export function getCustomProjectPath(): string | null {
  return customProjectPath
}

/**
 * Get global Agent OS directory
 * Priority: ~/.agent-os/ > agent-os-extended/agent-os/
 */
export function getGlobalAgentOSPath(): string {
  const homeAgentOS = join(homedir(), '.agent-os')

  if (existsSync(homeAgentOS)) {
    return homeAgentOS
  }

  // Check if running from agent-os-extended repo
  const repoAgentOS = join(process.cwd(), '..', 'agent-os')
  if (existsSync(repoAgentOS)) {
    return repoAgentOS
  }

  // Default to ~/.agent-os even if doesn't exist
  return homeAgentOS
}

/**
 * Get global .claude directory
 */
export function getGlobalClaudePath(): string {
  return join(homedir(), '.claude')
}

/**
 * Find project root by looking for agent-os/ or .agent-os/ directory
 * Searches up from current directory or uses custom project path if set
 */
export function findProjectRoot(startPath?: string): string | null {
  // Use custom project path if set
  if (customProjectPath) {
    // Verify it has agent-os/ or .agent-os/
    if (existsSync(join(customProjectPath, 'agent-os')) || existsSync(join(customProjectPath, '.agent-os'))) {
      return customProjectPath
    }
  }

  // Fall back to searching from startPath or cwd
  let currentPath = startPath || process.cwd()

  // Search up to root
  while (currentPath !== dirname(currentPath)) {
    // Check for agent-os/ or .agent-os/
    if (existsSync(join(currentPath, 'agent-os')) || existsSync(join(currentPath, '.agent-os'))) {
      return currentPath
    }

    currentPath = dirname(currentPath)
  }

  return null
}

/**
 * Get project Agent OS directory (agent-os/ or .agent-os/)
 */
export function getProjectAgentOSPath(projectRoot?: string): string | null {
  const root = projectRoot || findProjectRoot()
  if (!root) return null

  // Check agent-os/ first (v2.0 structure)
  const agentOS = join(root, 'agent-os')
  if (existsSync(agentOS)) {
    return agentOS
  }

  // Check .agent-os/ (v1.x structure)
  const dotAgentOS = join(root, '.agent-os')
  if (existsSync(dotAgentOS)) {
    return dotAgentOS
  }

  return null
}

/**
 * Get project .claude directory
 */
export function getProjectClaudePath(projectRoot?: string): string | null {
  const root = projectRoot || findProjectRoot()
  if (!root) return null

  const claudePath = join(root, '.claude')
  return existsSync(claudePath) ? claudePath : null
}

/**
 * Get all paths (global + project)
 */
export function getAllPaths(): PathInfo {
  const projectRoot = findProjectRoot()

  return {
    globalAgentOS: getGlobalAgentOSPath(),
    projectAgentOS: getProjectAgentOSPath(),
    globalClaude: getGlobalClaudePath(),
    projectClaude: getProjectClaudePath(),
    projectRoot
  }
}

/**
 * Resolve component path with priority (project > global)
 *
 * @param relativePath - Relative path from agent-os/ or .claude/ (e.g., 'skills/base/testing.md')
 * @param type - Component type ('agent-os' or 'claude')
 */
export async function resolveComponentPath(
  relativePath: string,
  type: 'agent-os' | 'claude'
): Promise<{ source: 'global' | 'project'; path: string } | null> {
  const paths = getAllPaths()

  // 1. Check project location first
  if (type === 'agent-os' && paths.projectAgentOS) {
    const projectPath = join(paths.projectAgentOS, relativePath)
    if (existsSync(projectPath)) {
      return { source: 'project', path: projectPath }
    }
  } else if (type === 'claude' && paths.projectClaude) {
    const projectPath = join(paths.projectClaude, relativePath)
    if (existsSync(projectPath)) {
      return { source: 'project', path: projectPath }
    }
  }

  // 2. Check global location
  const globalBase = type === 'agent-os' ? paths.globalAgentOS : paths.globalClaude
  const globalPath = join(globalBase, relativePath)

  if (existsSync(globalPath)) {
    return { source: 'global', path: globalPath }
  }

  // 3. For skills/agents, search with glob (might be in subdirectories)
  if (type === 'claude' || relativePath.startsWith('skills/')) {
    const pattern = join(globalBase, '**', relativePath.split('/').pop() || '')
    const found = await glob(pattern)

    if (found.length > 0) {
      return { source: 'global', path: found[0] }
    }
  }

  return null
}

/**
 * List all files in directory (global + project, merged)
 */
export async function listComponentFiles(
  baseRelativePath: string,
  type: 'agent-os' | 'claude',
  pattern: string = '**/*.md'
): Promise<Array<{ name: string; source: 'global' | 'project'; path: string }>> {
  const paths = getAllPaths()
  const results: Map<string, { name: string; source: 'global' | 'project'; path: string }> = new Map()

  // Get global files
  const globalBase = type === 'agent-os' ? paths.globalAgentOS : paths.globalClaude
  const globalPattern = join(globalBase, baseRelativePath, pattern)
  const globalFiles = await glob(globalPattern)

  for (const filePath of globalFiles) {
    const name = getComponentNameFromPath(filePath)
    results.set(name, { name, source: 'global', path: filePath })
  }

  // Get project files (override if name matches)
  const projectBase = type === 'agent-os' ? paths.projectAgentOS : paths.projectClaude
  if (projectBase) {
    const projectPattern = join(projectBase, baseRelativePath, pattern)
    const projectFiles = await glob(projectPattern)

    for (const filePath of projectFiles) {
      const name = getComponentNameFromPath(filePath)
      results.set(name, { name, source: 'project', path: filePath })
    }
  }

  return Array.from(results.values()).sort((a, b) => a.name.localeCompare(b.name))
}

/**
 * Extract component name from file path
 * e.g., '/path/to/skills/base/testing.md' → 'testing'
 */
function getComponentNameFromPath(filePath: string): string {
  const parts = filePath.split('/')
  const fileName = parts[parts.length - 1]
  return fileName.replace(/\.md$/, '')
}
