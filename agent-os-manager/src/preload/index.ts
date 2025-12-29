import { contextBridge, ipcRenderer } from 'electron'

// Expose protected methods that allow the renderer process to use
// the ipcRenderer without exposing the entire object
contextBridge.exposeInMainWorld('electronAPI', {
  // Basic ping for testing
  ping: () => ipcRenderer.invoke('ping'),

  // Skills API (to be implemented)
  skills: {
    list: () => ipcRenderer.invoke('skills:list'),
    read: (name: string) => ipcRenderer.invoke('skills:read', name),
    write: (name: string, content: string) => ipcRenderer.invoke('skills:write', name, content),
    delete: (name: string) => ipcRenderer.invoke('skills:delete', name),
    override: (name: string) => ipcRenderer.invoke('skills:override', name),
    revert: (name: string) => ipcRenderer.invoke('skills:revert', name),
    diff: (name: string) => ipcRenderer.invoke('skills:diff', name)
  },

  // Agents API (to be implemented)
  agents: {
    list: () => ipcRenderer.invoke('agents:list'),
    read: (name: string) => ipcRenderer.invoke('agents:read', name),
    write: (name: string, content: string) => ipcRenderer.invoke('agents:write', name, content),
    delete: (name: string) => ipcRenderer.invoke('agents:delete', name),
    override: (name: string) => ipcRenderer.invoke('agents:override', name),
    revert: (name: string) => ipcRenderer.invoke('agents:revert', name)
  },

  // Templates API (to be implemented)
  templates: {
    list: () => ipcRenderer.invoke('templates:list'),
    read: (path: string) => ipcRenderer.invoke('templates:read', path),
    write: (path: string, content: string) => ipcRenderer.invoke('templates:write', path, content)
  },

  // Config API (to be implemented)
  config: {
    read: () => ipcRenderer.invoke('config:read'),
    write: (content: string) => ipcRenderer.invoke('config:write', content)
  },

  // System API (to be implemented)
  system: {
    getPaths: () => ipcRenderer.invoke('system:getPaths'),
    refresh: () => ipcRenderer.invoke('system:refresh')
  }
})
