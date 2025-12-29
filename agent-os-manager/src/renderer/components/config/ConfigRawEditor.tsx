import React from 'react'
import Editor from '@monaco-editor/react'
import { useApp } from '../../contexts/AppContext'

interface ConfigRawEditorProps {
  content: string
  onChange: (content: string) => void
}

export function ConfigRawEditor({ content, onChange }: ConfigRawEditorProps) {
  const { theme } = useApp()

  return (
    <div className="h-[600px] border border-gray-200 dark:border-gray-700 rounded-lg overflow-hidden">
      <Editor
        height="100%"
        defaultLanguage="yaml"
        value={content}
        onChange={(value) => onChange(value || '')}
        theme={theme === 'dark' ? 'vs-dark' : 'vs-light'}
        options={{
          minimap: { enabled: false },
          fontSize: 14,
          lineNumbers: 'on',
          wordWrap: 'on',
          scrollBeyondLastLine: false,
          automaticLayout: true,
          tabSize: 2
        }}
      />
    </div>
  )
}
