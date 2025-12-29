import React from 'react'
import { Badge } from '../common/Badge'
import { Button } from '../common/Button'
import { Edit, Copy, RotateCcw } from 'lucide-react'

interface Agent {
  name: string
  description: string
  tools?: string[]
  color?: string
  source: 'global' | 'project'
  path: string
  globalPath?: string
  content: string
}

interface AgentsListProps {
  agents: Agent[]
  onEdit: (agent: Agent) => void
  onOverride: (agent: Agent) => void
  onRevert: (agent: Agent) => void
  searchTerm: string
}

export function AgentsList({ agents, onEdit, onOverride, onRevert, searchTerm }: AgentsListProps) {
  const filteredAgents = agents.filter(
    (agent) =>
      agent.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
      agent.description.toLowerCase().includes(searchTerm.toLowerCase())
  )

  if (filteredAgents.length === 0) {
    return (
      <div className="text-center py-12 text-gray-500 dark:text-gray-400">
        {searchTerm ? `No agents found matching "${searchTerm}"` : 'No agents found'}
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
              Tools
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
          {filteredAgents.map((agent) => (
            <tr
              key={agent.name}
              className="hover:bg-gray-50 dark:hover:bg-gray-700/50 transition-colors"
            >
              <td className="px-6 py-4 whitespace-nowrap">
                <div className="flex items-center gap-2">
                  {agent.color && (
                    <div
                      className="w-3 h-3 rounded-full"
                      style={{ backgroundColor: agent.color }}
                      title={`Color: ${agent.color}`}
                    />
                  )}
                  <div className="font-medium text-gray-900 dark:text-white">{agent.name}</div>
                </div>
              </td>
              <td className="px-6 py-4">
                <div className="text-sm text-gray-700 dark:text-gray-300 line-clamp-2">
                  {agent.description}
                </div>
              </td>
              <td className="px-6 py-4">
                {agent.tools && agent.tools.length > 0 && (
                  <div className="text-xs text-gray-600 dark:text-gray-400 font-mono">
                    {agent.tools.slice(0, 3).join(', ')}
                    {agent.tools.length > 3 && ` +${agent.tools.length - 3}`}
                  </div>
                )}
              </td>
              <td className="px-6 py-4 whitespace-nowrap">
                <Badge type={agent.source} />
              </td>
              <td className="px-6 py-4 whitespace-nowrap text-right">
                <div className="flex items-center justify-end gap-2">
                  <Button variant="ghost" size="sm" onClick={() => onEdit(agent)}>
                    <Edit size={16} className="mr-1" />
                    Edit
                  </Button>

                  {agent.source === 'global' && (
                    <Button variant="secondary" size="sm" onClick={() => onOverride(agent)}>
                      <Copy size={16} className="mr-1" />
                      Override
                    </Button>
                  )}

                  {agent.source === 'project' && (
                    <Button variant="danger" size="sm" onClick={() => onRevert(agent)}>
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
          Showing {filteredAgents.length} of {agents.length} agents
        </div>
      </div>
    </div>
  )
}
