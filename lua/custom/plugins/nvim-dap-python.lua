return {
  -- Python adapter setup
  require('dap-python').setup '~/.virtualenvs/debugpy/bin/python',

  -- Find all the config options here https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings#code-execution-settings
  -- Launch module
  table.insert(require('dap').configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'module',
    module = function()
      return vim.fn.input 'Module name: '
    end,
    console = 'integratedTerminal',
    justMyCode = true,
  }),

  -- Launch module
  table.insert(require('dap').configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'module (include import code)',
    module = function()
      return vim.fn.input 'Module name: '
    end,
    console = 'integratedTerminal',
    justMyCode = false,
  }),

  -- Debug all code (including libraries)
  table.insert(require('dap').configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'file (include import code)',
    program = '${file}',
    console = 'integratedTerminal',
    justMyCode = false,
  }),
}
