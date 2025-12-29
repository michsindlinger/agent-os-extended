import React, { useEffect, useState } from 'react'
import { AgentsList } from '../components/agents/AgentsList'
import { AgentEditor } from '../components/agents/AgentEditor'
import { Button } from '../components/common/Button'
import { Search, RefreshCw } from 'lucide-react'

interface Agent {
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

export default function Agents() {
  const [agents, setAgents] = useState<Agent[]>([])
  const [loading, setLoading] = useState(true)
  const [searchTerm, setSearchTerm] = useState('')
  const [selectedAgent, setSelectedAgent] = useState<Agent | null>(null)
  const [refreshing, setRefreshing] = useState(false)

  useEffect(() => {
    loadAgents()
  }, [])

  const loadAgents = async () => {
    try {
      setLoading(true)
      const agentsList = await window.electronAPI.agents.list()
      setAgents(agentsList)
    } catch (error) {
      console.error('Error loading agents:', error)
    } finally {
      setLoading(false)
    }
  }

  const handleRefresh = async () => {
    setRefreshing(true)
    await loadAgents()
    setRefreshing(false)
  }

  const handleEdit = (agent: Agent) => {
    setSelectedAgent(agent)
  }

  const handleSave = async (name: string, content: string) => {
    try {
      await window.electronAPI.agents.write(name, content)
      await loadAgents()
    } catch (error) {
      throw error
    }
  }

  const handleOverride = async (agent: Agent) => {
    try {
      await window.electronAPI.agents.override(agent.name)
      await loadAgents()

      // Open editor with newly overridden agent
      const updated = await window.electronAPI.agents.read(agent.name)
      if (updated) {
        setSelectedAgent(updated)
      }
    } catch (error) {
      console.error('Error overriding agent:', error)
      alert(`Error overriding agent: ${(error as Error).message}`)
    }
  }

  const handleRevert = async (agent: Agent) => {
    if (!confirm(`Revert "${agent.name}" to global version? This will delete the project override.`)) {
      return
    }

    try {
      await window.electronAPI.agents.revert(agent.name)
      await loadAgents()
    } catch (error) {
      console.error('Error reverting agent:', error)
      alert(`Error reverting agent: ${(error as Error).message}`)
    }
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center h-full">
        <div className="text-gray-500 dark:text-gray-400">Loading agents...</div>
      </div>
    )
  }

  return (
    <div>
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">Agents</h1>
          <p className="text-gray-600 dark:text-gray-400">
            Manage specialist agents ({agents.length} total)
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
            placeholder="Search agents by name or description..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="w-full pl-10 pr-4 py-2.5 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-lg text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          />
        </div>
      </div>

      {/* Agents List */}
      <AgentsList
        agents={agents}
        onEdit={handleEdit}
        onOverride={handleOverride}
        onRevert={handleRevert}
        searchTerm={searchTerm}
      />

      {/* Editor Modal */}
      {selectedAgent && (
        <AgentEditor
          agent={selectedAgent}
          onSave={handleSave}
          onClose={() => setSelectedAgent(null)}
        />
      )}
    </div>
  )
}
