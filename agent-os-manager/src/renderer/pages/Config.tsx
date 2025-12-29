import React, { useEffect, useState } from 'react'
import { ConfigForm } from '../components/config/ConfigForm'
import { ConfigRawEditor } from '../components/config/ConfigRawEditor'
import { Button } from '../components/common/Button'
import { Save, RefreshCw, Code, FormInput, AlertCircle } from 'lucide-react'
import yaml from 'js-yaml'

export default function Config() {
  const [config, setConfig] = useState<any>(null)
  const [rawContent, setRawContent] = useState('')
  const [loading, setLoading] = useState(true)
  const [saving, setSaving] = useState(false)
  const [refreshing, setRefreshing] = useState(false)
  const [mode, setMode] = useState<'form' | 'raw'>('form')
  const [error, setError] = useState<string | null>(null)
  const [hasChanges, setHasChanges] = useState(false)

  useEffect(() => {
    loadConfig()
  }, [])

  const loadConfig = async () => {
    try {
      setLoading(true)
      setError(null)
      const configData = await window.electronAPI.config.read()
      if (configData) {
        setConfig(configData)
        setRawContent(yaml.dump(configData, { indent: 2, lineWidth: -1 }))
      } else {
        setError('No config.yml found in project')
      }
    } catch (err) {
      setError((err as Error).message)
    } finally {
      setLoading(false)
    }
  }

  const handleRefresh = async () => {
    setRefreshing(true)
    await loadConfig()
    setRefreshing(false)
    setHasChanges(false)
  }

  const handleFormChange = (newConfig: any) => {
    setConfig(newConfig)
    setRawContent(yaml.dump(newConfig, { indent: 2, lineWidth: -1 }))
    setHasChanges(true)
  }

  const handleRawChange = (content: string) => {
    setRawContent(content)
    setHasChanges(true)

    // Try to parse YAML to update form view
    try {
      const parsed = yaml.load(content)
      setConfig(parsed)
      setError(null)
    } catch (err) {
      setError(`YAML parse error: ${(err as Error).message}`)
    }
  }

  const handleSave = async () => {
    try {
      setSaving(true)
      setError(null)

      // Save raw content (which should be valid YAML)
      await window.electronAPI.config.write(rawContent)

      setHasChanges(false)
      await loadConfig()
    } catch (err) {
      setError((err as Error).message)
    } finally {
      setSaving(false)
    }
  }

  const toggleMode = () => {
    if (mode === 'form') {
      // Switching to raw: serialize config to YAML
      setRawContent(yaml.dump(config, { indent: 2, lineWidth: -1 }))
      setMode('raw')
    } else {
      // Switching to form: parse YAML to config
      try {
        const parsed = yaml.load(rawContent)
        setConfig(parsed)
        setMode('form')
        setError(null)
      } catch (err) {
        setError(`Cannot switch to form view: ${(err as Error).message}`)
      }
    }
  }

  if (loading) {
    return (
      <div className="flex items-center justify-center h-full">
        <div className="text-gray-500 dark:text-gray-400">Loading configuration...</div>
      </div>
    )
  }

  if (error && !config) {
    return (
      <div className="flex items-center justify-center h-full">
        <div className="text-center">
          <AlertCircle size={48} className="mx-auto mb-4 text-red-500" />
          <div className="text-red-600 dark:text-red-400">{error}</div>
          <Button className="mt-4" onClick={loadConfig}>
            Retry
          </Button>
        </div>
      </div>
    )
  }

  return (
    <div>
      {/* Header */}
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-3xl font-bold text-gray-900 dark:text-white mb-2">Configuration</h1>
          <p className="text-gray-600 dark:text-gray-400">
            Manage config.yml settings
          </p>
        </div>
        <div className="flex items-center gap-2">
          <Button
            variant="ghost"
            size="md"
            onClick={toggleMode}
          >
            {mode === 'form' ? (
              <>
                <Code size={16} className="mr-2" />
                Raw YAML
              </>
            ) : (
              <>
                <FormInput size={16} className="mr-2" />
                Visual Form
              </>
            )}
          </Button>
          <Button variant="secondary" size="md" onClick={handleRefresh} disabled={refreshing}>
            <RefreshCw size={16} className={`mr-2 ${refreshing ? 'animate-spin' : ''}`} />
            Refresh
          </Button>
          <Button
            variant="primary"
            size="md"
            onClick={handleSave}
            disabled={!hasChanges || saving}
          >
            <Save size={16} className="mr-2" />
            {saving ? 'Saving...' : 'Save Changes'}
          </Button>
        </div>
      </div>

      {/* Error Message */}
      {error && (
        <div className="mb-6 px-4 py-3 bg-red-50 dark:bg-red-900/20 border border-red-200 dark:border-red-800 rounded flex items-start gap-2">
          <AlertCircle size={20} className="text-red-600 dark:text-red-400 flex-shrink-0 mt-0.5" />
          <div className="text-sm text-red-700 dark:text-red-300">{error}</div>
        </div>
      )}

      {/* Unsaved Changes Warning */}
      {hasChanges && (
        <div className="mb-6 px-4 py-3 bg-orange-50 dark:bg-orange-900/20 border border-orange-200 dark:border-orange-800 rounded">
          <div className="text-sm text-orange-700 dark:text-orange-300">
            ● You have unsaved changes
          </div>
        </div>
      )}

      {/* Editor */}
      {mode === 'form' ? (
        <ConfigForm config={config} onChange={handleFormChange} />
      ) : (
        <ConfigRawEditor content={rawContent} onChange={handleRawChange} />
      )}
    </div>
  )
}
