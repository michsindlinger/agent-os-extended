import React, { useState } from 'react'
import { Badge } from '../common/Badge'
import { Button } from '../common/Button'
import { Edit, Copy, RotateCcw } from 'lucide-react'

interface Skill {
  name: string
  description: string
  globs: string[]
  source: 'global' | 'project'
  path: string
  globalPath?: string
  content: string
}

interface SkillsListProps {
  skills: Skill[]
  onEdit: (skill: Skill) => void
  onOverride: (skill: Skill) => void
  onRevert: (skill: Skill) => void
  searchTerm: string
}

export function SkillsList({ skills, onEdit, onOverride, onRevert, searchTerm }: SkillsListProps) {
  const filteredSkills = skills.filter(
    (skill) =>
      skill.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      skill.description.toLowerCase().includes(searchTerm.toLowerCase())
  )

  if (filteredSkills.length === 0) {
    return (
      <div className="text-center py-12 text-gray-500 dark:text-gray-400">
        {searchTerm ? `No skills found matching "${searchTerm}"` : 'No skills found'}
      </div>
    )
  }

  return (
    <div className="bg-white dark:bg-gray-800 rounded-lg shadow border border-gray-200 dark:border-gray-700 overflow-hidden">
      <table className="w-full">
        <thead className="bg-gray-50 dark:bg-gray-900 border-b border-gray-200 dark:border-gray-700">
          <tr>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
              Name
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
              Description
            </th>
            <th className="px-6 py-3 text-left text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
              Source
            </th>
            <th className="px-6 py-3 text-right text-xs font-medium text-gray-500 dark:text-gray-400 uppercase tracking-wider">
              Actions
            </th>
          </tr>
        </thead>
        <tbody className="divide-y divide-gray-200 dark:divide-gray-700">
          {filteredSkills.map((skill) => (
            <tr
              key={skill.name}
              className="hover:bg-gray-50 dark:hover:bg-gray-700/50 transition-colors"
            >
              <td className="px-6 py-4 whitespace-nowrap">
                <div className="font-medium text-gray-900 dark:text-white">{skill.name}</div>
                <div className="text-xs text-gray-500 dark:text-gray-400 font-mono mt-0.5">
                  {skill.globs.join(', ')}
                </div>
              </td>
              <td className="px-6 py-4">
                <div className="text-sm text-gray-700 dark:text-gray-300 line-clamp-2">
                  {skill.description}
                </div>
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <Badge type={skill.source} />
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-right">
                <div className="flex items-center justify-end gap-2">
                  <Button variant="ghost" size="sm" onClick={() => onEdit(skill)}>
                    <Edit size={16} className="mr-1" />
                    Edit
                  </Button>

                  {skill.source === 'global' && (
                    <Button variant="secondary" size="sm" onClick={() => onOverride(skill)}>
                      <Copy size={16} className="mr-1" />
                      Override
                    </Button>
                  )}

                  {skill.source === 'project' && (
                    <Button variant="danger" size="sm" onClick={() => onRevert(skill)}>
                      <RotateCcw size={16} className="mr-1" />
                      Revert
                    </Button>
                  )}
                </div>
              </td>
            </tr>
          ))}
        </tbody>
      </table>

      <div className="px-6 py-3 bg-gray-50 dark:bg-gray-900 border-t border-gray-200 dark:border-gray-700">
        <div className="text-sm text-gray-600 dark:text-gray-400">
          Showing {filteredSkills.length} of {skills.length} skills
        </div>
      </div>
    </div>
  )
}
