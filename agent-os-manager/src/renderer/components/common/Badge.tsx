import React from 'react'

interface BadgeProps {
  type: 'global' | 'project'
  children?: React.ReactNode
}

export function Badge({ type, children }: BadgeProps) {
  if (type === 'global') {
    return (
      <span className="badge-global">
        ✅ {children || 'Global'}
      </span>
    )
  }

  return (
    <span className="badge-project">
      🔶 {children || 'Project'}
    </span>
  )
}
