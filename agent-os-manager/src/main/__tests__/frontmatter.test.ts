import {
  parseFrontmatter,
  serializeFrontmatter,
  validateSkillFrontmatter,
  validateAgentFrontmatter,
  extractFrontmatter,
  hasFrontmatter
} from '../utils/frontmatter'

describe('frontmatter utils', () => {
  describe('parseFrontmatter', () => {
    it('parses valid frontmatter and content', () => {
      const content = `---
name: test-skill
description: Test skill
globs: ["**/*.ts"]
---

# Test Skill

This is the content.`

      const result = parseFrontmatter(content)

      expect(result.frontmatter.name).toBe('test-skill')
      expect(result.frontmatter.description).toBe('Test skill')
      expect(result.frontmatter.globs).toEqual(['**/*.ts'])
      expect(result.content).toContain('# Test Skill')
    })

    it('handles content without frontmatter', () => {
      const content = '# Just Content\n\nNo frontmatter here.'

      const result = parseFrontmatter(content)

      expect(result.frontmatter).toEqual({})
      expect(result.content).toContain('# Just Content')
    })
  })

  describe('serializeFrontmatter', () => {
    it('creates valid markdown with frontmatter', () => {
      const frontmatter = {
        name: 'test-skill',
        description: 'Test',
        globs: ['**/*.ts']
      }
      const content = '# Test Skill'

      const result = serializeFrontmatter(frontmatter, content)

      expect(result).toContain('---')
      expect(result).toContain('name: test-skill')
      expect(result).toContain('# Test Skill')
    })
  })

  describe('validateSkillFrontmatter', () => {
    it('validates valid skill frontmatter', () => {
      const frontmatter = {
        name: 'test-skill',
        description: 'Test skill',
        globs: ['**/*.ts']
      }

      const result = validateSkillFrontmatter(frontmatter)

      expect(result.valid).toBe(true)
      expect(result.errors).toHaveLength(0)
    })

    it('rejects missing name', () => {
      const frontmatter = {
        description: 'Test',
        globs: ['**/*.ts']
      }

      const result = validateSkillFrontmatter(frontmatter)

      expect(result.valid).toBe(false)
      expect(result.errors).toContain('Missing required field: name')
    })

    it('rejects missing description', () => {
      const frontmatter = {
        name: 'test',
        globs: ['**/*.ts']
      }

      const result = validateSkillFrontmatter(frontmatter)

      expect(result.valid).toBe(false)
      expect(result.errors).toContain('Missing required field: description')
    })

    it('rejects missing globs', () => {
      const frontmatter = {
        name: 'test',
        description: 'Test'
      }

      const result = validateSkillFrontmatter(frontmatter)

      expect(result.valid).toBe(false)
      expect(result.errors).toContain('Missing required field: globs')
    })

    it('rejects invalid globs (not array)', () => {
      const frontmatter = {
        name: 'test',
        description: 'Test',
        globs: '**/*.ts' // Should be array
      }

      const result = validateSkillFrontmatter(frontmatter)

      expect(result.valid).toBe(false)
      expect(result.errors).toContain('Invalid field: globs must be an array')
    })

    it('rejects empty globs array', () => {
      const frontmatter = {
        name: 'test',
        description: 'Test',
        globs: []
      }

      const result = validateSkillFrontmatter(frontmatter)

      expect(result.valid).toBe(false)
      expect(result.errors).toContain('Invalid field: globs array cannot be empty')
    })
  })

  describe('validateAgentFrontmatter', () => {
    it('validates valid agent frontmatter', () => {
      const frontmatter = {
        name: 'test-agent',
        description: 'Test agent',
        tools: ['Read', 'Write']
      }

      const result = validateAgentFrontmatter(frontmatter)

      expect(result.valid).toBe(true)
      expect(result.errors).toHaveLength(0)
    })

    it('allows missing tools (optional)', () => {
      const frontmatter = {
        name: 'test-agent',
        description: 'Test agent'
      }

      const result = validateAgentFrontmatter(frontmatter)

      expect(result.valid).toBe(true)
    })

    it('rejects invalid tools (not array)', () => {
      const frontmatter = {
        name: 'test-agent',
        description: 'Test',
        tools: 'Read,Write' // Should be array
      }

      const result = validateAgentFrontmatter(frontmatter)

      expect(result.valid).toBe(false)
      expect(result.errors).toContain('Invalid field: tools must be an array')
    })
  })

  describe('extractFrontmatter', () => {
    it('extracts only frontmatter data', () => {
      const content = `---
name: test
description: Test
---

Content here`

      const result = extractFrontmatter(content)

      expect(result.name).toBe('test')
      expect(result.description).toBe('Test')
    })
  })

  describe('hasFrontmatter', () => {
    it('returns true for content with frontmatter', () => {
      const content = `---
name: test
---

Content`

      expect(hasFrontmatter(content)).toBe(true)
    })

    it('returns false for content without frontmatter', () => {
      const content = '# Just content'

      expect(hasFrontmatter(content)).toBe(false)
    })
  })
})
