import React from 'react'
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom'
import { AppProvider } from './contexts/AppContext'
import Layout from './components/layout/Layout'
import Dashboard from './pages/Dashboard'
import Skills from './pages/Skills'
import Agents from './pages/Agents'
import Templates from './pages/Templates'
import Config from './pages/Config'

function App() {
  return (
    <AppProvider>
      <Router>
        <Layout>
          <Routes>
            <Route path="/" element={<Navigate to="/dashboard" replace />} />
            <Route path="/dashboard" element={<Dashboard />} />
            <Route path="/skills" element={<Skills />} />
            <Route path="/agents" element={<Agents />} />
            <Route path="/templates" element={<Templates />} />
            <Route path="/config" element={<Config />} />
          </Routes>
        </Layout>
      </Router>
    </AppProvider>
  )
}

export default App
