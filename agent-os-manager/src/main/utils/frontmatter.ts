import matter from 'gray-matter'

export interface FrontmatterData {
  name?: string
  description?: string
  globs?: string[]
  tools?: string[]
  color?: string
  mcp_integrations?: string[]
  [key: string]: any
}

export interface ParsedContent {
  frontmatter: FrontmatterData
  content: string
  raw: string
}

export interface ValidationResult {
  valid: boolean
  errors: string[]
}

/**
 * Parse frontmatter from markdown file content
 */
export function parseFrontmatter(fileContent: string): ParsedContent {
  const { data, content } = matter(fileContent)

  return {
    frontmatter: data as FrontmatterData,
    content: content.trim(),
    raw: fileContent
  }
}

/**
 * Serialize frontmatter + content back to markdown
 */
export function serializeFrontmatter(frontmatter: FrontmatterData, content: string): string {
  return matter.stringify(content, frontmatter)
}

/**
 * Validate skill frontmatter
 */
export function validateSkillFrontmatter(frontmatter: FrontmatterData): ValidationResult {
  const errors: string[] = []

  if (!frontmatter.name || frontmatter.name.trim() === '') {
    errors.push('Missing required field: name')
  }

  if (!frontmatter.description || frontmatter.description.trim() === '') {
    errors.push('Missing required field: description')
  }

  if (!frontmatter.globs) {
    errors.push('Missing required field: globs')
  } else if (!Array.isArray(frontmatter.globs)) {
    errors.push('Invalid field: globs must be an array')
  } else if (frontmatter.globs.length === 0) {
    errors.push('Invalid field: globs array cannot be empty')
  }

  return {
    valid: errors.length === 0,
    errors
  }
}

/**
 * Validate agent frontmatter
 */
export function validateAgentFrontmatter(frontmatter: FrontmatterData): ValidationResult {
  const errors: string[] = []

  if (!frontmatter.name || frontmatter.name.trim() === '') {
    errors.push('Missing required field: name')
  }

  if (!frontmatter.description || frontmatter.description.trim() === '') {
    errors.push('Missing required field: description')
  }

  // tools is optional but if present must be array
  if (frontmatter.tools && !Array.isArray(frontmatter.tools)) {
    errors.push('Invalid field: tools must be an array')
  }

  // color is optional
  // mcp_integrations is optional but if present must be array
  if (frontmatter.mcp_integrations && !Array.isArray(frontmatter.mcp_integrations)) {
    errors.push('Invalid field: mcp_integrations must be an array')
  }

  return {
    valid: errors.length === 0,
    errors
  }
}

/**
 * Extract frontmatter from file content
 */
export function extractFrontmatter(fileContent: string): FrontmatterData {
  const { data } = matter(fileContent)
  return data as FrontmatterData
}

/**
 * Check if content has valid frontmatter
 */
export function hasFrontmatter(fileContent: string): boolean {
  try {
    const { data } = matter(fileContent)
    return Object.keys(data).length > 0
  } catch {
    return false
  }
}
