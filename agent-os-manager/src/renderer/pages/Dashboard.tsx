import React, { useEffect, useState } from 'react'
import { Card } from '../components/common/Card'
import { Button } from '../components/common/Button'
import { useApp } from '../contexts/AppContext'
import { FolderOpen, X } from 'lucide-react'

export default function Dashboard() {
  const { paths, selectProject, clearProject } = useApp()
  const [stats, setStats] = useState({
    skills: { total: 0, global: 0, project: 0 },
    agents: { total: 0, global: 0, project: 0 },
    templates: { total: 0, global: 0, project: 0 }
  })

  useEffect(() => {
    loadStats()
  }, [])

  const loadStats = async () => {
    try {
      // Load skills
      const skills = await window.electronAPI.skills.list()
      const skillsGlobal = skills.filter((s) => s.source === 'global').length
      const skillsProject = skills.filter((s) => s.source === 'project').length

      // Load agents
      const agents = await window.electronAPI.agents.list()
      const agentsGlobal = agents.filter((a) => a.source === 'global').length
      const agentsProject = agents.filter((a) => a.source === 'project').length

      // Load templates
      const templates = await window.electronAPI.templates.list()
      const templatesGlobal = templates.filter((t) => t.source === 'global').length
      const templatesProject = templates.filter((t) => t.source === 'project').length

      setStats({
        skills: { total: skills.length, global: skillsGlobal, project: skillsProject },
        agents: { total: agents.length, global: agentsGlobal, project: agentsProject },
        templates: { total: templates.length, global: templatesGlobal, project: templatesProject }
      })
    } catch (error) {
      console.error('Error loading stats:', error)
    }
  }

  const handleSelectProject = async () => {
    await selectProject()
    // Reload stats after project selection
    await loadStats()
  }

  const handleClearProject = async () => {
    await clearProject()
    // Reload stats after clearing project
    await loadStats()
  }

  return (
    <div>
      <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">Dashboard</h1>
      <p className="text-gray-600 dark:text-gray-400 mb-8">
        Overview of Agent OS Extended components
      </p>

      {/* Stats Cards */}
      <div className="grid grid-cols-3 gap-6 mb-8">
        <Card>
          <div className="text-center">
            <div className="text-4xl font-bold text-blue-600 dark:text-blue-400 mb-2">
              {stats.skills.total}
            </div>
            <div className="text-sm font-medium text-gray-900 dark:text-white mb-3">Skills</div>
            <div className="flex justify-center gap-4 text-sm text-gray-600 dark:text-gray-400">
              <div>✅ {stats.skills.global}</div>
              <div>🔶 {stats.skills.project}</div>
            </div>
          </div>
        </Card>

        <Card>
          <div className="text-center">
            <div className="text-4xl font-bold text-blue-600 dark:text-blue-400 mb-2">
              {stats.agents.total}
            </div>
            <div className="text-sm font-medium text-gray-900 dark:text-white mb-3">Agents</div>
            <div className="flex justify-center gap-4 text-sm text-gray-600 dark:text-gray-400">
              <div>✅ {stats.agents.global}</div>
              <div>🔶 {stats.agents.project}</div>
            </div>
          </div>
        </Card>

        <Card>
          <div className="text-center">
            <div className="text-4xl font-bold text-blue-600 dark:text-blue-400 mb-2">
              {stats.templates.total}
            </div>
            <div className="text-sm font-medium text-gray-900 dark:text-white mb-3">Templates</div>
            <div className="flex justify-center gap-4 text-sm text-gray-600 dark:text-gray-400">
              <div>✅ {stats.templates.global}</div>
              <div>🔶 {stats.templates.project}</div>
            </div>
          </div>
        </Card>
      </div>

      {/* Project Info */}
      {paths && (
        <Card title="Project Information">
          <div className="space-y-3 text-sm">
            <div>
              <div className="font-medium text-gray-700 dark:text-gray-300 mb-1">Global Location</div>
              <div className="font-mono text-gray-600 dark:text-gray-400 bg-gray-50 dark:bg-gray-900 px-3 py-2 rounded">
                {paths.globalAgentOS}
              </div>
            </div>

            {paths.projectAgentOS ? (
              <div>
                <div className="font-medium text-gray-700 dark:text-gray-300 mb-1 flex items-center justify-between">
                  <span>Project Location</span>
                  <Button variant="ghost" size="sm" onClick={handleClearProject}>
                    <X size={14} className="mr-1" />
                    Clear
                  </Button>
                </div>
                <div className="font-mono text-gray-600 dark:text-gray-400 bg-gray-50 dark:bg-gray-900 px-3 py-2 rounded">
                  {paths.projectRoot}
                </div>
                <div className="font-mono text-xs text-gray-500 dark:text-gray-500 mt-1">
                  agent-os: {paths.projectAgentOS}
                </div>
              </div>
            ) : (
              <div>
                <div className="text-gray-500 dark:text-gray-400 italic mb-3">
                  No project detected. Open a project directory to enable project-specific overrides.
                </div>
                <Button variant="primary" size="md" onClick={handleSelectProject}>
                  <FolderOpen size={16} className="mr-2" />
                  Open Project...
                </Button>
              </div>
            )}
          </div>
        </Card>
      )}
    </div>
  )
}
