import { app, BrowserWindow, ipcMain } from 'electron'
import path from 'path'
import yaml from 'js-yaml'
import * as skillsService from './services/skills.service'
import * as agentsService from './services/agents.service'
import * as templatesService from './services/templates.service'
import * as configService from './services/config.service'
import { getAllPaths } from './utils/paths'

let mainWindow: BrowserWindow | null = null

function createWindow(): void {
  mainWindow = new BrowserWindow({
    width: 1200,
    height: 800,
    minWidth: 800,
    minHeight: 600,
    title: 'Agent OS Manager',
    webPreferences: {
      preload: path.join(__dirname, '../preload/index.js'),
      contextIsolation: true,
      nodeIntegration: false,
      sandbox: false
    }
  })

  // Load the app
  if (process.env.NODE_ENV === 'development') {
    mainWindow.loadURL('http://localhost:5173')
    mainWindow.webContents.openDevTools()
  } else {
    mainWindow.loadFile(path.join(__dirname, '../renderer/index.html'))
  }

  mainWindow.on('closed', () => {
    mainWindow = null
  })
}

// App lifecycle
app.whenReady().then(() => {
  createWindow()

  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) {
      createWindow()
    }
  })
})

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit()
  }
})

// Basic IPC handler
ipcMain.handle('ping', async () => {
  return 'pong'
})

// Skills IPC handlers
ipcMain.handle('skills:list', async () => {
  try {
    return await skillsService.listSkills()
  } catch (error) {
    console.error('Error listing skills:', error)
    throw error
  }
})

ipcMain.handle('skills:read', async (_, name: string) => {
  try {
    return await skillsService.readSkill(name)
  } catch (error) {
    console.error(`Error reading skill ${name}:`, error)
    throw error
  }
})

ipcMain.handle('skills:write', async (_, name: string, content: string) => {
  try {
    await skillsService.writeSkill(name, content)
  } catch (error) {
    console.error(`Error writing skill ${name}:`, error)
    throw error
  }
})

ipcMain.handle('skills:delete', async (_, name: string) => {
  try {
    await skillsService.deleteSkill(name)
  } catch (error) {
    console.error(`Error deleting skill ${name}:`, error)
    throw error
  }
})

ipcMain.handle('skills:override', async (_, name: string) => {
  try {
    await skillsService.overrideSkillToProject(name)
  } catch (error) {
    console.error(`Error overriding skill ${name}:`, error)
    throw error
  }
})

ipcMain.handle('skills:revert', async (_, name: string) => {
  try {
    await skillsService.deleteSkill(name)
  } catch (error) {
    console.error(`Error reverting skill ${name}:`, error)
    throw error
  }
})

ipcMain.handle('skills:diff', async (_, name: string) => {
  try {
    return await skillsService.diffSkill(name)
  } catch (error) {
    console.error(`Error diffing skill ${name}:`, error)
    throw error
  }
})

// Agents IPC handlers
ipcMain.handle('agents:list', async () => {
  try {
    return await agentsService.listAgents()
  } catch (error) {
    console.error('Error listing agents:', error)
    throw error
  }
})

ipcMain.handle('agents:read', async (_, name: string) => {
  try {
    return await agentsService.readAgent(name)
  } catch (error) {
    console.error(`Error reading agent ${name}:`, error)
    throw error
  }
})

ipcMain.handle('agents:write', async (_, name: string, content: string) => {
  try {
    await agentsService.writeAgent(name, content)
  } catch (error) {
    console.error(`Error writing agent ${name}:`, error)
    throw error
  }
})

ipcMain.handle('agents:delete', async (_, name: string) => {
  try {
    await agentsService.deleteAgent(name)
  } catch (error) {
    console.error(`Error deleting agent ${name}:`, error)
    throw error
  }
})

ipcMain.handle('agents:override', async (_, name: string) => {
  try {
    await agentsService.overrideAgentToProject(name)
  } catch (error) {
    console.error(`Error overriding agent ${name}:`, error)
    throw error
  }
})

ipcMain.handle('agents:revert', async (_, name: string) => {
  try {
    await agentsService.deleteAgent(name)
  } catch (error) {
    console.error(`Error reverting agent ${name}:`, error)
    throw error
  }
})

// Templates IPC handlers
ipcMain.handle('templates:list', async () => {
  try {
    return await templatesService.listTemplates()
  } catch (error) {
    console.error('Error listing templates:', error)
    throw error
  }
})

ipcMain.handle('templates:read', async (_, relativePath: string) => {
  try {
    return await templatesService.readTemplate(relativePath)
  } catch (error) {
    console.error(`Error reading template ${relativePath}:`, error)
    throw error
  }
})

ipcMain.handle('templates:write', async (_, relativePath: string, content: string) => {
  try {
    await templatesService.writeTemplate(relativePath, content)
  } catch (error) {
    console.error(`Error writing template ${relativePath}:`, error)
    throw error
  }
})

// Config IPC handlers
ipcMain.handle('config:read', async () => {
  try {
    return await configService.readConfig()
  } catch (error) {
    console.error('Error reading config:', error)
    throw error
  }
})

ipcMain.handle('config:write', async (_, content: string) => {
  try {
    const config = yaml.load(content) as configService.AgentOSConfig
    const validation = configService.validateConfig(config)

    if (!validation.valid) {
      throw new Error(`Invalid config:\n${validation.errors.join('\n')}`)
    }

    await configService.writeConfig(config)
  } catch (error) {
    console.error('Error writing config:', error)
    throw error
  }
})

// System IPC handlers
ipcMain.handle('system:getPaths', async () => {
  try {
    return getAllPaths()
  } catch (error) {
    console.error('Error getting paths:', error)
    throw error
  }
})

ipcMain.handle('system:refresh', async () => {
  // Refresh handled by re-calling list methods
  return true
})
