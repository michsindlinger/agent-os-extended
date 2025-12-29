import React, { ReactNode } from 'react'
import { NavLink } from 'react-router-dom'
import { LayoutDashboard, FileCode, Users, FileText, Settings, Moon, Sun } from 'lucide-react'
import { useApp } from '../../contexts/AppContext'

interface LayoutProps {
  children: ReactNode
}

export default function Layout({ children }: LayoutProps) {
  const { theme, toggleTheme, paths } = useApp()

  const navItems = [
    { to: '/dashboard', icon: LayoutDashboard, label: 'Dashboard' },
    { to: '/skills', icon: FileCode, label: 'Skills' },
    { to: '/agents', icon: Users, label: 'Agents' },
    { to: '/templates', icon: FileText, label: 'Templates' },
    { to: '/config', icon: Settings, label: 'Config' }
  ]

  return (
    <div className="flex h-screen bg-gray-50 dark:bg-gray-900">
      {/* Sidebar */}
      <div className="w-64 bg-white dark:bg-gray-800 border-r border-gray-200 dark:border-gray-700 flex flex-col">
        {/* Header */}
        <div className="p-6 border-b border-gray-200 dark:border-gray-700">
          <h1 className="text-xl font-bold text-gray-900 dark:text-white">Agent OS Manager</h1>
          <p className="text-sm text-gray-500 dark:text-gray-400 mt-1">Component Manager</p>
        </div>

        {/* Navigation */}
        <nav className="flex-1 p-4 space-y-1">
          {navItems.map((item) => (
            <NavLink
              key={item.to}
              to={item.to}
              className={({ isActive }) =>
                `flex items-center gap-3 px-4 py-2.5 rounded-lg transition-colors ${
                  isActive
                    ? 'bg-blue-50 text-blue-700 dark:bg-blue-900/30 dark:text-blue-400'
                    : 'text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-700'
                }`
              }
            >
              <item.icon size={20} />
              <span>{item.label}</span>
            </NavLink>
          ))}
        </nav>

        {/* Footer */}
        <div className="p-4 border-t border-gray-200 dark:border-gray-700">
          {/* Theme toggle */}
          <button
            onClick={toggleTheme}
            className="w-full flex items-center gap-3 px-4 py-2.5 rounded-lg text-gray-700 hover:bg-gray-100 dark:text-gray-300 dark:hover:bg-gray-700 transition-colors"
          >
            {theme === 'light' ? <Moon size={20} /> : <Sun size={20} />}
            <span>{theme === 'light' ? 'Dark Mode' : 'Light Mode'}</span>
          </button>

          {/* Paths info */}
          {paths && (
            <div className="mt-4 px-4 py-2 text-xs text-gray-500 dark:text-gray-400">
              <div className="font-semibold mb-1">Locations:</div>
              <div className="truncate" title={paths.globalAgentOS}>
                Global: .../{paths.globalAgentOS.split('/').slice(-2).join('/')}
              </div>
              {paths.projectAgentOS && (
                <div className="truncate mt-1" title={paths.projectAgentOS}>
                  Project: .../{paths.projectAgentOS.split('/').slice(-2).join('/')}
                </div>
              )}
            </div>
          )}
        </div>
      </div>

      {/* Main content */}
      <div className="flex-1 overflow-auto">
        <div className="p-8">{children}</div>
      </div>
    </div>
  )
}
