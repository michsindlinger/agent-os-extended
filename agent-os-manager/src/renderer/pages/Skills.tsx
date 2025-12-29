import React, { useEffect, useState } from 'react'
import { SkillsList } from '../components/skills/SkillsList'
import { SkillEditor } from '../components/skills/SkillEditor'
import { Button } from '../components/common/Button'
import { Search, RefreshCw, Plus } from 'lucide-react'

interface Skill {
  name: string
  description: string
  globs: string[]
  source: 'global' | 'project'
  path: string
  globalPath?: string
  content: string
}

export default function Skills() {
  const [skills, setSkills] = useState<Skill[]>([])
  const [loading, setLoading] = useState(true)
  const [searchTerm, setSearchTerm] = useState('')
  const [selectedSkill, setSelectedSkill] = useState<Skill | null>(null)
  const [refreshing, setRefreshing] = useState(false)

  useEffect(() => {
    loadSkills()
  }, [])

  const loadSkills = async () => {
    try {
      setLoading(true)
      const skillsList = await window.electronAPI.skills.list()
      setSkills(skillsList)
    } catch (error) {
      console.error('Error loading skills:', error)
    } finally {
      setLoading(false)
    }
  }

  const handleRefresh = async () => {
    setRefreshing(true)
    await loadSkills()
    setRefreshing(false)
  }

  const handleEdit = (skill: Skill) => {
    setSelectedSkill(skill)
  }

  const handleSave = async (name: string, content: string) => {
    try {
      await window.electronAPI.skills.write(name, content)
      await loadSkills()
    } catch (error) {
      throw error
    }
  }

  const handleOverride = async (skill: Skill) => {
    try {
      await window.electronAPI.skills.override(skill.name)
      await loadSkills()

      // Open editor with newly overridden skill
      const updated = await window.electronAPI.skills.read(skill.name)
      if (updated) {
        setSelectedSkill(updated)
      }
    } catch (error) {
      console.error('Error overriding skill:', error)
      alert(`Error overriding skill: ${(error as Error).message}`)
    }
  }

  const handleRevert = async (skill: Skill) => {
    if (!confirm(`Revert "${skill.name}" to global version? This will delete the project override.`)) {
      return
    }

    try {
      await window.electronAPI.skills.revert(skill.name)
      await loadSkills()
    } catch (error) {
      console.error('Error reverting skill:', error)
      alert(`Error reverting skill: ${(error as Error).message}`)
    }
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center h-full">
        <div className="text-gray-500 dark:text-gray-400">Loading skills...</div>
      </div>
    )
  }

  return (
    <div>
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">Skills</h1>
          <p className="text-gray-600 dark:text-gray-400">
            Manage Claude Code skills ({skills.length} total)
          </p>
        </div>
        <div className="flex items-center gap-2">
          <Button variant="secondary" size="md" onClick={handleRefresh} disabled={refreshing}>
            <RefreshCw size={16} className={`mr-2 ${refreshing ? 'animate-spin' : ''}`} />
            Refresh
          </Button>
        </div>
      </div>

      {/* Search */}
      <div className="mb-6">
        <div className="relative">
          <Search size={20} className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
          <input
            type="text"
            placeholder="Search skills by name or description..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="w-full pl-10 pr-4 py-2.5 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-lg text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          />
        </div>
      </div>

      {/* Skills List */}
      <SkillsList
        skills={skills}
        onEdit={handleEdit}
        onOverride={handleOverride}
        onRevert={handleRevert}
        searchTerm={searchTerm}
      />

      {/* Editor Modal */}
      {selectedSkill && (
        <SkillEditor
          skill={selectedSkill}
          onSave={handleSave}
          onClose={() => setSelectedSkill(null)}
        />
      )}
    </div>
  )
}
