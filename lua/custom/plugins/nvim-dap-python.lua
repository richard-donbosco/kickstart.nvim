return {
  'mfussenegger/nvim-dap-python',
  dependencies = { 'mfussenegger/nvim-dap' },
  config = function()
    -- Python adapter setup
    require('dap-python').setup 'uv'
    -- require('dap-python').setup '~/.virtualenvs/debugpy/bin/python'
    require('dap-python').test_runner = 'pytest'

    -- Find all the config options here https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings#code-execution-settings
    local dap = require 'dap'

    -- Launch module
    table.insert(dap.configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'module',
      module = function()
        return vim.fn.input 'Module name: '
      end,
      console = 'integratedTerminal',
      justMyCode = true,
    })

    -- Launch module (include import code)
    table.insert(dap.configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'module (include import code)',
      module = function()
        return vim.fn.input 'Module name: '
      end,
      console = 'integratedTerminal',
      justMyCode = false,
    })

    -- Debug all code (including libraries)
    table.insert(dap.configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'file (include import code)',
      program = '${file}',
      console = 'integratedTerminal',
      justMyCode = false,
    })
  end,
}
