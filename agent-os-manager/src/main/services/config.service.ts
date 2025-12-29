import { readFile, writeFile } from 'fs/promises'
import { join } from 'path'
import { existsSync } from 'fs'
import yaml from 'js-yaml'
import { getAllPaths } from '../utils/paths'

export interface AgentOSConfig {
  active_profile?: string
  profiles?: {
    inheritance?: boolean
    auto_load_skills?: boolean
  }
  skills?: {
    enabled?: boolean
    path?: string
    symlink_to_claude?: boolean
  }
  team_system?: {
    enabled?: boolean
    lookup_order?: string[]
    coordination_mode?: string
    task_routing?: {
      enabled?: boolean
      auto_delegate?: boolean
    }
    specialists?: {
      backend_dev?: any
      frontend_dev?: any
      qa_specialist?: any
      devops_specialist?: any
    }
    quality_gates?: any
  }
  market_validation?: {
    enabled?: boolean
    lookup_order?: string[]
    [key: string]: any
  }
  [key: string]: any
}

/**
 * Read config.yml from project
 */
export async function readConfig(): Promise<AgentOSConfig | null> {
  const paths = getAllPaths()

  if (!paths.projectAgentOS) {
    throw new Error('No project found. Please open a project directory.')
  }

  const configPath = join(paths.projectAgentOS, 'config.yml')

  if (!existsSync(configPath)) {
    return null
  }

  try {
    const content = await readFile(configPath, 'utf-8')
    const config = yaml.load(content) as AgentOSConfig
    return config
  } catch (error) {
    throw new Error(`Error parsing config.yml: ${(error as Error).message}`)
  }
}

/**
 * Write config.yml to project
 */
export async function writeConfig(config: AgentOSConfig): Promise<void> {
  const paths = getAllPaths()

  if (!paths.projectAgentOS) {
    throw new Error('No project found. Please open a project directory.')
  }

  const configPath = join(paths.projectAgentOS, 'config.yml')

  try {
    // Validate by attempting to dump to YAML
    const yamlContent = yaml.dump(config, {
      indent: 2,
      lineWidth: -1,
      noRefs: true
    })

    await writeFile(configPath, yamlContent, 'utf-8')
  } catch (error) {
    throw new Error(`Error writing config.yml: ${(error as Error).message}`)
  }
}

/**
 * Validate config structure
 */
export function validateConfig(config: AgentOSConfig): { valid: boolean; errors: string[] } {
  const errors: string[] = []

  // Basic structure validation
  if (typeof config !== 'object' || config === null) {
    errors.push('Config must be an object')
    return { valid: false, errors }
  }

  // Validate team_system if present
  if (config.team_system) {
    if (typeof config.team_system.enabled !== 'undefined' && typeof config.team_system.enabled !== 'boolean') {
      errors.push('team_system.enabled must be a boolean')
    }

    if (config.team_system.specialists) {
      // Validate each specialist
      const specialists = ['backend_dev', 'frontend_dev', 'qa_specialist', 'devops_specialist']
      for (const specialist of specialists) {
        const spec = config.team_system.specialists[specialist]
        if (spec && typeof spec.enabled !== 'undefined' && typeof spec.enabled !== 'boolean') {
          errors.push(`team_system.specialists.${specialist}.enabled must be a boolean`)
        }
      }
    }

    if (config.team_system.quality_gates) {
      const gates = config.team_system.quality_gates
      if (typeof gates.coverage_minimum !== 'undefined' && typeof gates.coverage_minimum !== 'number') {
        errors.push('team_system.quality_gates.coverage_minimum must be a number')
      }
    }
  }

  // Validate market_validation if present
  if (config.market_validation) {
    if (typeof config.market_validation.enabled !== 'undefined' && typeof config.market_validation.enabled !== 'boolean') {
      errors.push('market_validation.enabled must be a boolean')
    }
  }

  return {
    valid: errors.length === 0,
    errors
  }
}
