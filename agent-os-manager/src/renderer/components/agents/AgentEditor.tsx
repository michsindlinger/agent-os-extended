import React, { useState } from 'react'
import Editor from '@monaco-editor/react'
import { Button } from '../common/Button'
import { Badge } from '../common/Badge'
import { Save, X, AlertCircle } from 'lucide-react'
import { useApp } from '../../contexts/AppContext'

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

interface AgentEditorProps {
  agent: Agent
  onSave: (name: string, content: string) => Promise<void>
  onClose: () => void
}

export function AgentEditor({ agent, onSave, onClose }: AgentEditorProps) {
  const { theme } = useApp()
  const [content, setContent] = useState(agent.content)
  const [saving, setSaving] = useState(false)
  const [error, setError] = useState<string | null>(null)

  const handleSave = async () => {
    try {
      setSaving(true)
      setError(null)
      await onSave(agent.name, content)
      onClose()
    } catch (err) {
      setError((err as Error).message)
    } finally {
      setSaving(false)
    }
  }

  const hasChanges = content !== agent.content

  return (
    <div className="fixed inset-0 bg-black/50 flex items-center justify-center z-50">
      <div className="bg-white dark:bg-gray-800 rounded-lg shadow-2xl w-[90vw] h-[90vh] flex flex-col">
        {/* Header */}
        <div className="px-6 py-4 border-b border-gray-200 dark:border-gray-700 flex items-center justify-between">
          <div className="flex items-center gap-3">
            {agent.color && (
              <div
                className="w-4 h-4 rounded-full"
                style={{ backgroundColor: agent.color }}
              />
            )}
            <h2 className="text-xl font-semibold text-gray-900 dark:text-white">
              {agent.name}
            </h2>
            <Badge type={agent.source} />
          </div>
          <div className="flex items-center gap-2">
            <Button variant="secondary" size="sm" onClick={onClose} disabled={saving}>
              <X size={16} className="mr-1" />
              Cancel
            </Button>
            <Button
              variant="primary"
              size="sm"
              onClick={handleSave}
              disabled={!hasChanges || saving}
            >
              <Save size={16} className="mr-1" />
              {saving ? 'Saving...' : 'Save'}
            </Button>
          </div>
        </div>

        {/* Agent info */}
        <div className="px-6 py-2 bg-gray-50 dark:bg-gray-900 border-b border-gray-200 dark:border-gray-700">
          <div className="flex items-center gap-4 text-xs text-gray-600 dark:text-gray-400">
            <div className="font-mono">{agent.path}</div>
            {agent.tools && Array.isArray(agent.tools) && agent.tools.length > 0 && (
              <div className="flex items-center gap-1">
                <span className="font-semibold">Tools:</span>
                <span>{agent.tools.join(', ')}</span>
              </div>
            )}
          </div>
          {agent.source === 'project' && agent.globalPath && (
            <div className="text-xs text-gray-500 dark:text-gray-500 font-mono mt-1">
              Global: {agent.globalPath}
            </div>
          )}
        </div>

        {/* Error message */}
        {error && (
          <div className="mx-6 mt-4 px-4 py-3 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded flex items-start gap-2">
            <AlertCircle size={20} className="text-red-600 dark:text-red-400 flex-shrink-0 mt-0.5" />
            <div className="text-sm text-red-700 dark:text-red-300">{error}</div>
          </div>
        )}

        {/* Editor */}
        <div className="flex-1 overflow-hidden">
          <Editor
            height="100%"
            defaultLanguage="markdown"
            value={content}
            onChange={(value) => setContent(value || '')}
            theme={theme === 'dark' ? 'vs-dark' : 'vs-light'}
            options={{
              minimap: { enabled: false },
              fontSize: 14,
              lineNumbers: 'on',
              rulers: [80, 120],
              wordWrap: 'on',
              scrollBeyondLastLine: false,
              automaticLayout: true
            }}
          />
        </div>

        {/* Footer */}
        <div className="px-6 py-3 bg-gray-50 dark:bg-gray-900 border-t border-gray-200 dark:border-gray-700 flex items-center justify-between">
          <div className="text-sm text-gray-600 dark:text-gray-400">
            {hasChanges && <span className="text-orange-600 dark:text-orange-400">● Unsaved changes</span>}
          </div>
          <div className="text-xs text-gray-500 dark:text-gray-500">
            Monaco Editor - Markdown with YAML frontmatter
          </div>
        </div>
      </div>
    </div>
  )
}
