import React from 'react'
import { ChevronDown, ChevronRight } from 'lucide-react'

interface ConfigFormProps {
  config: any
  onChange: (config: any) => void
}

interface SectionProps {
  title: string
  children: React.ReactNode
  defaultExpanded?: boolean
}

function Section({ title, children, defaultExpanded = false }: SectionProps) {
  const [expanded, setExpanded] = React.useState(defaultExpanded)

  return (
    <div className="border border-gray-200 dark:border-gray-700 rounded-lg overflow-hidden mb-4">
      <button
        onClick={() => setExpanded(!expanded)}
        className="w-full px-6 py-4 bg-gray-50 dark:bg-gray-800 flex items-center justify-between hover:bg-gray-100 dark:hover:bg-gray-700 transition-colors"
      >
        <h3 className="text-lg font-semibold text-gray-900 dark:text-white">{title}</h3>
        {expanded ? (
          <ChevronDown size={20} className="text-gray-500" />
        ) : (
          <ChevronRight size={20} className="text-gray-500" />
        )}
      </button>
      {expanded && <div className="p-6 bg-white dark:bg-gray-900">{children}</div>}
    </div>
  )
}

function ToggleField({ label, value, onChange, help }: { label: string; value: boolean; onChange: (v: boolean) => void; help?: string }) {
  return (
    <div className="flex items-start justify-between py-3 border-b border-gray-200 dark:border-gray-700 last:border-b-0">
      <div className="flex-1">
        <label className="block text-sm font-medium text-gray-700 dark:text-gray-300">{label}</label>
        {help && <p className="text-xs text-gray-500 dark:text-gray-400 mt-1">{help}</p>}
      </div>
      <button
        onClick={() => onChange(!value)}
        className={`relative inline-flex h-6 w-11 items-center rounded-full transition-colors ${
          value ? 'bg-blue-600' : 'bg-gray-300 dark:bg-gray-600'
        }`}
      >
        <span className={`inline-block h-4 w-4 transform rounded-full bg-white transition-transform ${value ? 'translate-x-6' : 'translate-x-1'}`} />
      </button>
    </div>
  )
}

function SelectField({ label, value, options, onChange, help }: { label: string; value: string; options: string[]; onChange: (v: string) => void; help?: string }) {
  return (
    <div className="py-3 border-b border-gray-200 dark:border-gray-700 last:border-b-0">
      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">{label}</label>
      {help && <p className="text-xs text-gray-500 dark:text-gray-400 mb-2">{help}</p>}
      <select
        value={value}
        onChange={(e) => onChange(e.target.value)}
        className="w-full px-3 py-2 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
      >
        {options.map((opt) => (
          <option key={opt} value={opt}>
            {opt}
          </option>
        ))}
      </select>
    </div>
  )
}

function NumberField({ label, value, onChange, min, max, help }: { label: string; value: number; onChange: (v: number) => void; min?: number; max?: number; help?: string }) {
  return (
    <div className="py-3 border-b border-gray-200 dark:border-gray-700 last:border-b-0">
      <label className="block text-sm font-medium text-gray-700 dark:text-gray-300 mb-2">{label}</label>
      {help && <p className="text-xs text-gray-500 dark:text-gray-400 mb-2">{help}</p>}
      <input
        type="number"
        value={value}
        onChange={(e) => onChange(Number(e.target.value))}
        min={min}
        max={max}
        className="w-full px-3 py-2 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded text-gray-900 dark:text-white focus:outline-none focus:ring-2 focus:ring-blue-500"
      />
    </div>
  )
}

export function ConfigForm({ config, onChange }: ConfigFormProps) {
  const updateConfig = (path: string[], value: any) => {
    const newConfig = { ...config }
    let current: any = newConfig

    for (let i = 0; i < path.length - 1; i++) {
      if (!current[path[i]]) {
        current[path[i]] = {}
      }
      current = current[path[i]]
    }

    current[path[path.length - 1]] = value
    onChange(newConfig)
  }

  return (
    <div className="space-y-4">
      {/* General Settings */}
      <Section title="General Settings" defaultExpanded={true}>
        <SelectField
          label="Active Profile"
          value={config.active_profile || 'base'}
          options={['base', 'java-spring-boot', 'react-frontend', 'angular-frontend']}
          onChange={(v) => updateConfig(['active_profile'], v)}
          help="Tech stack profile for this project"
        />
      </Section>

      {/* Skills */}
      <Section title="Skills System">
        <ToggleField
          label="Skills Enabled"
          value={config.skills?.enabled ?? true}
          onChange={(v) => updateConfig(['skills', 'enabled'], v)}
          help="Enable Claude Code Skills integration"
        />
        <ToggleField
          label="Symlink to Claude"
          value={config.skills?.symlink_to_claude ?? true}
          onChange={(v) => updateConfig(['skills', 'symlink_to_claude'], v)}
          help="Create symlinks in .claude/skills/"
        />
      </Section>

      {/* Team Development System */}
      <Section title="Team Development System">
        <ToggleField
          label="Team System Enabled"
          value={config.team_system?.enabled ?? false}
          onChange={(v) => updateConfig(['team_system', 'enabled'], v)}
          help="Enable smart task routing with specialist agents"
        />

        {config.team_system?.enabled && (
          <>
            <ToggleField
              label="Task Routing Enabled"
              value={config.team_system?.task_routing?.enabled ?? true}
              onChange={(v) => updateConfig(['team_system', 'task_routing', 'enabled'], v)}
              help="Automatically route tasks to specialists"
            />

            <div className="mt-6">
              <h4 className="text-sm font-semibold text-gray-900 dark:text-white mb-4">Backend Developer</h4>
              <ToggleField
                label="Enabled"
                value={config.team_system?.specialists?.backend_dev?.enabled ?? true}
                onChange={(v) => updateConfig(['team_system', 'specialists', 'backend_dev', 'enabled'], v)}
              />
              <SelectField
                label="Default Stack"
                value={config.team_system?.specialists?.backend_dev?.default_stack || 'java_spring_boot'}
                options={['java_spring_boot', 'nodejs_express']}
                onChange={(v) => updateConfig(['team_system', 'specialists', 'backend_dev', 'default_stack'], v)}
              />
              <SelectField
                label="Code Generation"
                value={config.team_system?.specialists?.backend_dev?.code_generation || 'full'}
                options={['full', 'scaffolding', 'guidance']}
                onChange={(v) => updateConfig(['team_system', 'specialists', 'backend_dev', 'code_generation'], v)}
              />
            </div>

            <div className="mt-6">
              <h4 className="text-sm font-semibold text-gray-900 dark:text-white mb-4">Frontend Developer</h4>
              <ToggleField
                label="Enabled"
                value={config.team_system?.specialists?.frontend_dev?.enabled ?? true}
                onChange={(v) => updateConfig(['team_system', 'specialists', 'frontend_dev', 'enabled'], v)}
              />
              <SelectField
                label="Default Framework"
                value={config.team_system?.specialists?.frontend_dev?.default_framework || 'react'}
                options={['react', 'angular']}
                onChange={(v) => updateConfig(['team_system', 'specialists', 'frontend_dev', 'default_framework'], v)}
              />
            </div>

            <div className="mt-6">
              <h4 className="text-sm font-semibold text-gray-900 dark:text-white mb-4">QA Specialist</h4>
              <ToggleField
                label="Enabled"
                value={config.team_system?.specialists?.qa_specialist?.enabled ?? true}
                onChange={(v) => updateConfig(['team_system', 'specialists', 'qa_specialist', 'enabled'], v)}
              />
              <NumberField
                label="Coverage Target (%)"
                value={config.team_system?.specialists?.qa_specialist?.coverage_target || 80}
                onChange={(v) => updateConfig(['team_system', 'specialists', 'qa_specialist', 'coverage_target'], v)}
                min={0}
                max={100}
                help="Minimum code coverage percentage"
              />
              <NumberField
                label="Auto-Fix Attempts"
                value={config.team_system?.specialists?.qa_specialist?.auto_fix_attempts || 3}
                onChange={(v) => updateConfig(['team_system', 'specialists', 'qa_specialist', 'auto_fix_attempts'], v)}
                min={1}
                max={10}
                help="Maximum auto-fix iterations for test failures"
              />
            </div>

            <div className="mt-6">
              <h4 className="text-sm font-semibold text-gray-900 dark:text-white mb-4">Quality Gates</h4>
              <ToggleField
                label="Unit Tests Required"
                value={config.team_system?.quality_gates?.unit_tests_required ?? true}
                onChange={(v) => updateConfig(['team_system', 'quality_gates', 'unit_tests_required'], v)}
              />
              <ToggleField
                label="Integration Tests Required"
                value={config.team_system?.quality_gates?.integration_tests_required ?? true}
                onChange={(v) => updateConfig(['team_system', 'quality_gates', 'integration_tests_required'], v)}
              />
              <NumberField
                label="Coverage Minimum (%)"
                value={config.team_system?.quality_gates?.coverage_minimum || 80}
                onChange={(v) => updateConfig(['team_system', 'quality_gates', 'coverage_minimum'], v)}
                min={0}
                max={100}
              />
            </div>
          </>
        )}
      </Section>

      {/* Market Validation */}
      <Section title="Market Validation System">
        <ToggleField
          label="Market Validation Enabled"
          value={config.market_validation?.enabled ?? false}
          onChange={(v) => updateConfig(['market_validation', 'enabled'], v)}
          help="Enable market validation system"
        />
      </Section>
    </div>
  )
}
