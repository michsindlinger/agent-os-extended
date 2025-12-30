import React from 'react'
import { CheckCircle, XCircle } from 'lucide-react'

interface SystemStatus {
  name: string
  installed: boolean
  agents: number
  skills: number
  templates: number
}

interface SystemsStatusProps {
  skills: any[]
  agents: any[]
  templates: any[]
}

export function SystemsStatus({ skills, agents, templates }: SystemsStatusProps) {
  // Detect Market Validation System
  const marketValidationAgents = [
    'product-strategist',
    'market-researcher',
    'content-creator',
    'seo-specialist',
    'web-developer',
    'validation-specialist',
    'business-analyst'
  ]
  const hasMarketValidation = marketValidationAgents.every((name) =>
    agents.some((a) => a.name === name)
  )
  const marketValidationAgentCount = agents.filter((a) =>
    marketValidationAgents.includes(a.name)
  ).length
  const marketValidationSkillCount = skills.filter(
    (s) =>
      s.name.includes('product-strategy') ||
      s.name.includes('market-research') ||
      s.name.includes('business-analysis') ||
      s.name.includes('validation-strategies') ||
      s.name.includes('copywriting') ||
      s.name.includes('seo-optimization') ||
      s.name.includes('content-writing')
  ).length
  const marketValidationTemplateCount = templates.filter((t) =>
    t.system.includes('market-validation')
  ).length

  // Detect Team Development System
  const teamSystemAgents = ['backend-dev', 'frontend-dev', 'qa-specialist', 'devops-specialist', 'mock-generator']
  const hasTeamSystem = teamSystemAgents.every((name) => agents.some((a) => a.name === name))
  const teamSystemAgentCount = agents.filter((a) => teamSystemAgents.includes(a.name)).length
  const teamSystemSkillCount = skills.filter(
    (s) => s.name.includes('testing-best-practices') || s.name.includes('devops-patterns')
  ).length
  const teamSystemTemplateCount = templates.filter((t) =>
    t.system.includes('team-development')
  ).length

  const systems: SystemStatus[] = [
    {
      name: 'Market Validation System',
      installed: hasMarketValidation,
      agents: marketValidationAgentCount,
      skills: marketValidationSkillCount,
      templates: marketValidationTemplateCount
    },
    {
      name: 'Team Development System',
      installed: hasTeamSystem,
      agents: teamSystemAgentCount,
      skills: teamSystemSkillCount,
      templates: teamSystemTemplateCount
    }
  ]

  return (
    <div className="bg-white dark:bg-gray-800 rounded-lg shadow border border-gray-200 dark:border-gray-700">
      <div className="px-6 py-4 border-b border-gray-200 dark:border-gray-700">
        <h3 className="text-lg font-semibold text-gray-900 dark:text-white">Installed Systems</h3>
      </div>
      <div className="p-6 space-y-4">
        {systems.map((system) => (
          <div
            key={system.name}
            className="flex items-start gap-3 p-4 rounded-lg bg-gray-50 dark:bg-gray-900"
          >
            {system.installed ? (
              <CheckCircle size={20} className="text-green-600 dark:text-green-400 flex-shrink-0 mt-0.5" />
            ) : (
              <XCircle size={20} className="text-gray-400 dark:text-gray-600 flex-shrink-0 mt-0.5" />
            )}
            <div className="flex-1">
              <div className="font-medium text-gray-900 dark:text-white mb-1">
                {system.name}
              </div>
              {system.installed ? (
                <div className="text-sm text-gray-600 dark:text-gray-400">
                  {system.agents} agents, {system.skills} skills, {system.templates} templates
                </div>
              ) : (
                <div className="text-sm text-gray-500 dark:text-gray-500 italic">
                  Not installed
                </div>
              )}
            </div>
          </div>
        ))}
      </div>
    </div>
  )
}
