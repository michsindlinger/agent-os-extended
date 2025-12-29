import React, { useEffect, useState } from 'react'
import { TemplatesTree } from '../components/templates/TemplatesTree'
import { TemplateEditor } from '../components/templates/TemplateEditor'
import { Button } from '../components/common/Button'
import { Search, RefreshCw } from 'lucide-react'

interface Template {
  name: string
  path: string
  relativePath: string
  category: string
  system: string
  source: 'global' | 'project'
  globalPath?: string
  content?: string
}

export default function Templates() {
  const [templates, setTemplates] = useState<Template[]>([])
  const [loading, setLoading] = useState(true)
  const [searchTerm, setSearchTerm] = useState('')
  const [selectedTemplate, setSelectedTemplate] = useState<Template | null>(null)
  const [refreshing, setRefreshing] = useState(false)

  useEffect(() => {
    loadTemplates()
  }, [])

  const loadTemplates = async () => {
    try {
      setLoading(true)
      const templatesList = await window.electronAPI.templates.list()
      setTemplates(templatesList)
    } catch (error) {
      console.error('Error loading templates:', error)
    } finally {
      setLoading(false)
    }
  }

  const handleRefresh = async () => {
    setRefreshing(true)
    await loadTemplates()
    setRefreshing(false)
  }

  const handleEdit = async (template: Template) => {
    try {
      // Load template content
      const fullTemplate = await window.electronAPI.templates.read(template.relativePath)
      if (fullTemplate) {
        setSelectedTemplate(fullTemplate)
      }
    } catch (error) {
      console.error('Error loading template:', error)
      alert(`Error loading template: ${(error as Error).message}`)
    }
  }

  const handleSave = async (relativePath: string, content: string) => {
    try {
      await window.electronAPI.templates.write(relativePath, content)
      await loadTemplates()
    } catch (error) {
      throw error
    }
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center h-full">
        <div className="text-gray-500 dark:text-gray-400">Loading templates...</div>
      </div>
    )
  }

  return (
    <div>
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">Templates</h1>
          <p className="text-gray-600 dark:text-gray-400">
            Manage template files ({templates.length} total)
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
            placeholder="Search templates by name, category, or system..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
            className="w-full pl-10 pr-4 py-2.5 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-lg text-gray-900 dark:text-white placeholder-gray-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent"
          />
        </div>
      </div>

      {/* Templates Tree */}
      <TemplatesTree
        templates={templates}
        onEdit={handleEdit}
        searchTerm={searchTerm}
      />

      {/* Editor Modal */}
      {selectedTemplate && selectedTemplate.content && (
        <TemplateEditor
          template={selectedTemplate}
          onSave={handleSave}
          onClose={() => setSelectedTemplate(null)}
        />
      )}
    </div>
  )
}
