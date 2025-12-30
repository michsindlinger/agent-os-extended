export interface ElectronAPI {
  ping: () => Promise<string>

  skills: {
    list: () => Promise<any[]>
    read: (name: string) => Promise<any>
    write: (name: string, content: string) => Promise<void>
    delete: (name: string) => Promise<void>
    override: (name: string) => Promise<void>
    revert: (name: string) => Promise<void>
    diff: (name: string) => Promise<any>
  }

  agents: {
    list: () => Promise<any[]>
    read: (name: string) => Promise<any>
    write: (name: string, content: string) => Promise<void>
    delete: (name: string) => Promise<void>
    override: (name: string) => Promise<void>
    revert: (name: string) => Promise<void>
  }

  templates: {
    list: () => Promise<any[]>
    read: (path: string) => Promise<any>
    write: (path: string, content: string) => Promise<void>
  }

  config: {
    read: () => Promise<any>
    write: (content: string) => Promise<void>
  }

  system: {
    getPaths: () => Promise<any>
    refresh: () => Promise<void>
    setProjectPath: (path: string | null) => Promise<any>
  }

  dialog: {
    selectFolder: () => Promise<string | null>
  }
}

declare global {
  interface Window {
    electronAPI: ElectronAPI
  }
}
