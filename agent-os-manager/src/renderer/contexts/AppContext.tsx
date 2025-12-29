import React, { createContext, useContext, useState, useEffect, ReactNode } from 'react'

interface PathInfo {
  globalAgentOS: string
  projectAgentOS: string | null
  globalClaude: string
  projectClaude: string | null
}

interface AppContextType {
  theme: 'light' | 'dark'
  toggleTheme: () => void
  paths: PathInfo | null
  refreshPaths: () => Promise<void>
  loading: boolean
}

const AppContext = createContext<AppContextType | undefined>(undefined)

export function AppProvider({ children }: { children: ReactNode }) {
  const [theme, setTheme] = useState<'light' | 'dark'>('light')
  const [paths, setPaths] = useState<PathInfo | null>(null)
  const [loading, setLoading] = useState(true)

  // Initialize theme from system preference
  useEffect(() => {
    const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches
    setTheme(prefersDark ? 'dark' : 'light')
  }, [])

  // Apply theme to document
  useEffect(() => {
    if (theme === 'dark') {
      document.documentElement.classList.add('dark')
    } else {
      document.documentElement.classList.remove('dark')
    }
  }, [theme])

  // Load paths on mount
  useEffect(() => {
    loadPaths()
  }, [])

  const loadPaths = async () => {
    try {
      setLoading(true)
      const pathInfo = await window.electronAPI.system.getPaths()
      setPaths(pathInfo)
    } catch (error) {
      console.error('Error loading paths:', error)
    } finally {
      setLoading(false)
    }
  }

  const toggleTheme = () => {
    setTheme((prev) => (prev === 'light' ? 'dark' : 'light'))
  }

  const refreshPaths = async () => {
    await loadPaths()
  }

  return (
    <AppContext.Provider
      value={{
        theme,
        toggleTheme,
        paths,
        refreshPaths,
        loading
      }}
    >
      {children}
    </AppContext.Provider>
  )
}

export function useApp() {
  const context = useContext(AppContext)
  if (!context) {
    throw new Error('useApp must be used within AppProvider')
  }
  return context
}
