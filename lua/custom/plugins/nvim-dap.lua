return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  cond = false,
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
      },
    }

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '  ',
          play = '  ',
          step_into = '',
          step_over = '  ',
          step_out = '  ',
          step_back = '  ',
          run_last = '  ',
          terminate = '  ',
          disconnect = '  ',
        },
      },
    }

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.open
    dap.listeners.before.event_exited['dapui_config'] = dapui.open

    -- Install golang specific config
    require('dap-go').setup {
      -- Additional dap configurations can be added.
      -- dap_configurations accepts a list of tables where each entry
      -- represents a dap configuration. For more details do:
      -- :help dap-configuration
      dap_configurations = {
        {
          type = 'go',
          name = 'Attach remote',
          mode = 'remote',
          request = 'attach',
        },
        -- {
        --   type = "go",
        --   name = "Debug",
        --   request = "launch",
        --   program = "${file}"
        -- },
        -- {
        --   type = "go",
        --   name = "Debug test", -- configuration for debugging test files
        --   request = "launch",
        --   mode = "test",
        --   program = "${file}"
        -- },
        -- -- works with go.mod packages and sub packages
        -- {
        --   type = "go",
        --   name = "Debug test (go.mod)",
        --   request = "launch",
        --   mode = "test",
        --   program = "./${relativeFileDirname}"
        -- }
      },
      -- delve configurations
      delve = {
        -- the path to the executable dlv which will be used for debugging.
        -- by default, this is the "dlv" executable on your PATH.
        path = 'dlv',
        -- time to wait for delve to initialize the debug session.
        -- default to 20 seconds
        initialize_timeout_sec = 20,
        -- a string that defines the port to start delve debugger.
        -- default to string "${port}" which instructs nvim-dap
        -- to start the process in a random available port
        port = '${port}',

        -- additional args to pass to dlv
        args = {}, -- 'dap', '-l', '127.0.0.1:${port}' },
        -- the build flags that are passed to delve.
        -- defaults to empty string, but can be used to provide flags
        -- such as "-tags=unit" to make sure the test suite is
        -- compiled during debugging, for example.
        -- passing build flags using args is ineffective, as those are
        -- ignored by delve in dap mode.
        build_flags = '',
      },
    }

    -- Python adapter setup
    require('dap-python').setup '~/.virtualenvs/debugpy/bin/python'
  end,
}
