import React, { useState } from 'react'
import { Badge } from '../common/Badge'
import { Button } from '../common/Button'
import { Edit, ChevronRight, ChevronDown, Folder, File } from 'lucide-react'

interface Template {
  name: string
  path: string
  relativePath: string
  category: string
  system: string
  source: 'global' | 'project'
  globalPath?: string
}

interface TemplatesTreeProps {
  templates: Template[]
  onEdit: (template: Template) => void
  searchTerm: string
}

interface TreeNode {
  name: string
  type: 'system' | 'category' | 'template'
  templates?: Template[]
  children?: TreeNode[]
  expanded?: boolean
}

export function TemplatesTree({ templates, onEdit, searchTerm }: TemplatesTreeProps) {
  const [expandedNodes, setExpandedNodes] = useState<Set<string>>(new Set(['team-development', 'market-validation']))

  // Build tree structure
  const buildTree = (): TreeNode[] => {
    const systemsMap = new Map<string, TreeNode>()

    const filteredTemplates = templates.filter(
      (t) =>
        t.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        t.category.toLowerCase().includes(searchTerm.toLowerCase()) ||
        t.system.toLowerCase().includes(searchTerm.toLowerCase())
    )

    for (const template of filteredTemplates) {
      // Get or create system node
      if (!systemsMap.has(template.system)) {
        systemsMap.set(template.system, {
          name: template.system,
          type: 'system',
          children: [],
          expanded: expandedNodes.has(template.system)
        })
      }

      const systemNode = systemsMap.get(template.system)!

      // Get or create category node
      let categoryNode = systemNode.children?.find((c) => c.name === template.category)
      if (!categoryNode) {
        categoryNode = {
          name: template.category,
          type: 'category',
          templates: [],
          expanded: expandedNodes.has(`${template.system}/${template.category}`)
        }
        systemNode.children?.push(categoryNode)
      }

      // Add template to category
      categoryNode.templates?.push(template)
    }

    return Array.from(systemsMap.values()).sort((a, b) => a.name.localeCompare(b.name))
  }

  const toggleNode = (path: string) => {
    setExpandedNodes((prev) => {
      const next = new Set(prev)
      if (next.has(path)) {
        next.delete(path)
      } else {
        next.add(path)
      }
      return next
    })
  }

  const tree = buildTree()

  if (tree.length === 0) {
    return (
      <div className="text-center py-12 text-gray-500 dark:text-gray-400">
        {searchTerm ? `No templates found matching "${searchTerm}"` : 'No templates found'}
      </div>
    )
  }

  return (
    <div className="bg-white dark:bg-gray-800 rounded-lg shadow border border-gray-200 dark:border-gray-700">
      {tree.map((systemNode) => (
        <div key={systemNode.name} className="border-b border-gray-200 dark:border-gray-700 last:border-b-0">
          {/* System Level */}
          <div
            className="px-4 py-3 flex items-center gap-2 cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-700/50 transition-colors"
            onClick={() => toggleNode(systemNode.name)}
          >
            {expandedNodes.has(systemNode.name) ? (
              <ChevronDown size={18} className="text-gray-400" />
            ) : (
              <ChevronRight size={18} className="text-gray-400" />
            )}
            <Folder size={18} className="text-blue-500" />
            <span className="font-semibold text-gray-900 dark:text-white">{systemNode.name}</span>
            <span className="text-xs text-gray-500 dark:text-gray-400">
              ({systemNode.children?.reduce((acc, cat) => acc + (cat.templates?.length || 0), 0)} templates)
            </span>
          </div>

          {/* Categories */}
          {expandedNodes.has(systemNode.name) && systemNode.children && (
            <div className="pl-6">
              {systemNode.children.map((categoryNode) => (
                <div key={`${systemNode.name}/${categoryNode.name}`}>
                  {/* Category Level */}
                  <div
                    className="px-4 py-2.5 flex items-center gap-2 cursor-pointer hover:bg-gray-50 dark:hover:bg-gray-700/50 transition-colors"
                    onClick={() => toggleNode(`${systemNode.name}/${categoryNode.name}`)}
                  >
                    {expandedNodes.has(`${systemNode.name}/${categoryNode.name}`) ? (
                      <ChevronDown size={16} className="text-gray-400" />
                    ) : (
                      <ChevronRight size={16} className="text-gray-400" />
                    )}
                    <Folder size={16} className="text-orange-500" />
                    <span className="font-medium text-gray-800 dark:text-gray-200">{categoryNode.name}</span>
                    <span className="text-xs text-gray-500 dark:text-gray-400">
                      ({categoryNode.templates?.length})
                    </span>
                  </div>

                  {/* Templates */}
                  {expandedNodes.has(`${systemNode.name}/${categoryNode.name}`) && categoryNode.templates && (
                    <div className="pl-6">
                      {categoryNode.templates.map((template) => (
                        <div
                          key={template.relativePath}
                          className="px-4 py-2 flex items-center justify-between hover:bg-gray-50 dark:hover:bg-gray-700/50 transition-colors"
                        >
                          <div className="flex items-center gap-2 flex-1">
                            <File size={14} className="text-gray-400" />
                            <span className="text-sm text-gray-700 dark:text-gray-300">{template.name}</span>
                            <Badge type={template.source} />
                          </div>
                          <Button variant="ghost" size="sm" onClick={() => onEdit(template)}>
                            <Edit size={14} className="mr-1" />
                            Edit
                          </Button>
                        </div>
                      ))}
                    </div>
                  )}
                </div>
              ))}
            </div>
          )}
        </div>
      ))}
    </div>
  )
}
