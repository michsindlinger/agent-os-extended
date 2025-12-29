import React, { useEffect, useState } from 'react'

function App() {
  const [response, setResponse] = useState<string>('')

  useEffect(() => {
    // Test IPC communication
    window.electronAPI.ping().then((result: string) => {
      setResponse(result)
    })
  }, [])

  return (
    <div className="min-h-screen bg-gray-50 dark:bg-gray-900 p-8">
      <div className="max-w-4xl mx-auto">
        <h1 className="text-4xl font-bold text-gray-900 dark:text-white mb-4">
          Agent OS Manager
        </h1>
        <p className="text-lg text-gray-600 dark:text-gray-400 mb-8">
          Visual management for Agent OS Extended components
        </p>

        {/* Test IPC */}
        <div className="bg-white dark:bg-gray-800 rounded-lg shadow p-6">
          <h2 className="text-xl font-semibold mb-2">IPC Test</h2>
          <p className="text-gray-600 dark:text-gray-400">
            Response from main process: <span className="font-mono text-green-600">{response || 'Loading...'}</span>
          </p>
        </div>

        {/* Badge examples */}
        <div className="mt-8 flex gap-4">
          <span className="badge-global">✅ Global</span>
          <span className="badge-project">🔶 Project</span>
        </div>
      </div>
    </div>
  )
}

export default App
