-- Copy "filename:start:end (count lines)" for a visual selection — no edits
vim.keymap.set('x', '<leader>yl', function()
  -- Get current visual selection boundaries (more reliable than marks)
  local start_pos = vim.fn.getpos 'v' -- Visual selection start
  local end_pos = vim.fn.getpos '.' -- Current cursor position (visual end)
  local s = math.min(start_pos[2], end_pos[2])
  local e = math.max(start_pos[2], end_pos[2])

  if s == 0 or e == 0 then
    return
  end
  local count = e - s + 1

  local file = vim.api.nvim_buf_get_name(0)
  file = (file == '' and '[No Name]') or vim.fn.fnamemodify(file, ':p')

  local text = (count == 1) and string.format('%s:%d', file, s) or string.format('%s:%d:%d (%d lines)', file, s, e, count)

  vim.fn.setreg('+', text)
  vim.notify('Copied ' .. text, vim.log.levels.INFO, { title = 'yl' })
end, { desc = 'Copy filename with selected line range + count to clipboard', silent = true })

--
-- Move selected block of text with correct auto indent in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected block of text down with correct auto indent' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected block of text up with correct auto indent' })

-- Window resizing in normal mode with Ctrl + arrow keys
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- Half page scrolling in normal mode with Ctrl + u/d and window curson centered
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll half page up' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll half page down' })

-- Moving between windows with Ctrl + hjkl in normal mode
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to down window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to up window' })

-- --------------------
-- -- Neotest mappings
-- --------------------
-- Re run the last ran test
vim.keymap.set('n', '<leader>?l', require('neotest').run.run_last, { desc = '[?] Re-run the last ran test' })
-- Run the test under the cursor
vim.keymap.set('n', '<leader>??', require('neotest').run.run, { desc = '[?] Run test function [b]lock on hover' })
-- Debug file with dap
vim.keymap.set('n', '<leader>?!', function()
  require('neotest').run.run { strategy = 'dap' }
end, { desc = '[?] Debug hovered function with [!] dap' })

-- Run the tests in the current file
vim.keymap.set('n', '<leader>?f', function()
  require('neotest').run.run(vim.fn.expand '%')
end, { desc = '[?] Run tests in current [f]ile' })
-- Run the tests in the current directory, works based on the current buffer
vim.keymap.set('n', '<leader>?d', function()
  require('neotest').run.run(vim.fn.expand '%:p:h')
end, { desc = '[?] Run tests in current [d]irectory' })
-- Run the tests based on the input path and args
vim.keymap.set('n', '<leader>?i', function()
  local input_path = vim.fn.input { prompt = 'Enter path:' }
  local args = vim.fn.input { prompt = '[Optional] Enter args:' }
  require('neotest').run.run { '' .. input_path, extra_args = { args } }
end, { desc = '[?] Run tests in [i]nput relative path (to vim root dir) and args.' })
-- Run the tests in the project root directory (vim root dir)
vim.keymap.set('n', '<leader>?p', function()
  require('neotest').run.run(vim.fn.getcwd())
end, { desc = '[?] Run tests in [r]relative path' })

-- Test summary toggle open/close
vim.keymap.set('n', '<leader>?s', require('neotest').summary.toggle, { desc = '[?] Test [s]ummary window toggle open/close' })

-------------------
--- Crates mapping
------------------
local crates = require 'crates'
local wk = require 'which-key'

wk.add {
  { '<leader>rc', group = 'crates' },
  { '<leader>rct', crates.toggle, desc = 'Toggle crates', mode = 'n' },
  { '<leader>rcr', crates.reload, desc = 'Reload crates', mode = 'n' },

  { '<leader>rcv', crates.show_versions_popup, desc = 'Show versions popup', mode = 'n' },
  { '<leader>rcf', crates.show_features_popup, desc = 'Show features popup', mode = 'n' },
  { '<leader>rcd', crates.show_dependencies_popup, desc = 'Show dependencies popup', mode = 'n' },

  { '<leader>rcu', crates.update_crate, desc = 'Update crate', mode = 'n' },
  { '<leader>rcu', crates.update_crates, desc = 'Update crates', mode = 'v' },
  { '<leader>rca', crates.update_all_crates, desc = 'Update all crates', mode = 'n' },
  { '<leader>rcU', crates.upgrade_crate, desc = 'Upgrade crate', mode = 'n' },
  { '<leader>rcU', crates.upgrade_crates, desc = 'Upgrade crates', mode = 'v' },
  { '<leader>rcA', crates.upgrade_all_crates, desc = 'Upgrade all crates', mode = 'n' },

  { '<leader>rcx', crates.expand_plain_crate_to_inline_table, desc = 'Expand plain crate to inline table', mode = 'n' },
  { '<leader>rcX', crates.extract_crate_into_table, desc = 'Extract crate into table', mode = 'n' },

  { '<leader>rcH', crates.open_homepage, desc = 'Open homepage', mode = 'n' },
  { '<leader>rcR', crates.open_repository, desc = 'Open repository', mode = 'n' },
  { '<leader>rcD', crates.open_documentation, desc = 'Open documentation', mode = 'n' },
  { '<leader>rcC', crates.open_crates_io, desc = 'Open crates.io', mode = 'n' },
  { '<leader>rcL', crates.open_lib_rs, desc = 'Open lib.rs', mode = 'n' },
}

-------------------
--- Rustaceanvim mappings
------------------
wk.add {
  -- Main rustaceanvim group
  { '<leader>rs', group = 'rustaceanvim' },

  -- LSP Client Management (RustAnalyzer commands)
  { '<leader>rsl', group = 'lsp client' },
  { '<leader>rsls', '<cmd>RustAnalyzer start<cr>', desc = 'Start LSP client', mode = 'n' },
  { '<leader>rslS', '<cmd>RustAnalyzer stop<cr>', desc = 'Stop LSP client', mode = 'n' },
  { '<leader>rslr', '<cmd>RustAnalyzer restart<cr>', desc = 'Restart LSP client', mode = 'n' },
  { '<leader>rslR', '<cmd>RustAnalyzer reloadSettings<cr>', desc = 'Reload LSP settings', mode = 'n' },
  {
    '<leader>rslt',
    function()
      local target = vim.fn.input 'Target architecture (empty for default): '
      vim.cmd('RustAnalyzer target ' .. target)
    end,
    desc = 'Set target architecture',
    mode = 'n',
  },

  -- Run commands
  { '<leader>rsR', group = 'run' },
  { '<leader>rsRr', '<cmd>RustLsp runnables<cr>', desc = 'Run runnables', mode = 'n' },
  { '<leader>rsRl', '<cmd>RustLsp!<cr>', desc = 'Run last runnable', mode = 'n' },
  { '<leader>rsRc', '<cmd>RustLsp run<cr>', desc = 'Run at cursor', mode = 'n' },
  { '<leader>rsRt', '<cmd>RustLsp testables<cr>', desc = 'Run testables', mode = 'n' },

  -- Debug commands
  { '<leader>rsd', group = 'debug' },
  { '<leader>rsdd', '<cmd>RustLsp debuggables<cr>', desc = 'Debug debuggables', mode = 'n' },
  { '<leader>rsdl', '<cmd>RustLsp! debuggables<cr>', desc = 'Debug last debuggable', mode = 'n' },
  { '<leader>rsdc', '<cmd>RustLsp debug<cr>', desc = 'Debug at cursor', mode = 'n' },

  -- Code actions and refactoring
  { '<leader>rsa', group = 'actions' },
  { '<leader>rsaa', '<cmd>RustLsp codeAction<cr>', desc = 'Code actions', mode = 'n' },
  { '<leader>rsah', '<cmd>RustLsp hover actions<cr>', desc = 'Hover actions', mode = 'n' },
  { '<leader>rsar', '<cmd>RustLsp hover range<cr>', desc = 'Hover range', mode = 'v' },
  { '<leader>rsam', '<cmd>RustLsp expandMacro<cr>', desc = 'Expand macro', mode = 'n' },
  { '<leader>rsau', '<cmd>RustLsp moveItem up<cr>', desc = 'Move item up', mode = 'n' },
  { '<leader>rsad', '<cmd>RustLsp moveItem down<cr>', desc = 'Move item down', mode = 'n' },
  { '<leader>rsaj', '<cmd>RustLsp joinLines<cr>', desc = 'Join lines', mode = 'n' },
  {
    '<leader>rsas',
    function()
      local query = vim.fn.input 'SSR query: '
      vim.cmd('RustLsp ssr ' .. query)
    end,
    desc = 'Structural search replace',
    mode = 'n',
  },

  -- Diagnostics with cycling support
  {
    '<leader>rse',
    function()
      -- Explain error and set up temporary cycling keymaps
      vim.cmd 'RustLsp explainError'

      -- Set up temporary keymaps for cycling
      local opts = { buffer = true, silent = true }
      vim.keymap.set('n', '>', '<cmd>RustLsp explainError cycle<cr>', opts)
      vim.keymap.set('n', '<', '<cmd>RustLsp explainError cycle_prev<cr>', opts)
      vim.keymap.set('n', '<Esc>', function()
        -- Clear the temporary keymaps when Esc is pressed
        pcall(vim.keymap.del, 'n', '>', { buffer = true })
        pcall(vim.keymap.del, 'n', '<', { buffer = true })
        pcall(vim.keymap.del, 'n', '<Esc>', { buffer = true })
        -- Clear any lingering messages
        vim.cmd 'echo ""'
        vim.notify('Error explanation mode exited', vim.log.levels.INFO, { timeout = 1000 })
      end, opts)

      -- Show message about available keys with shorter timeout
      vim.notify('Error explanation active. Use > (next), < (prev), Esc (exit)', vim.log.levels.INFO, { timeout = 3000 })
    end,
    desc = 'Explain error (then > next, < prev)',
    mode = 'n',
  },

  {
    '<leader>rsr',
    function()
      -- Render diagnostic and set up temporary cycling keymaps
      vim.cmd 'RustLsp renderDiagnostic'

      -- Set up temporary keymaps for cycling
      local opts = { buffer = true, silent = true }
      vim.keymap.set('n', '>', '<cmd>RustLsp renderDiagnostic cycle<cr>', opts)
      vim.keymap.set('n', '<', '<cmd>RustLsp renderDiagnostic cycle_prev<cr>', opts)
      vim.keymap.set('n', '<Esc>', function()
        -- Clear the temporary keymaps when Esc is pressed
        pcall(vim.keymap.del, 'n', '>', { buffer = true })
        pcall(vim.keymap.del, 'n', '<', { buffer = true })
        pcall(vim.keymap.del, 'n', '<Esc>', { buffer = true })
        -- Clear any lingering messages
        vim.cmd 'echo ""'
        vim.notify('Diagnostic rendering mode exited', vim.log.levels.INFO, { timeout = 1000 })
      end, opts)

      -- Show message about available keys with shorter timeout
      vim.notify('Diagnostic rendering active. Use > (next), < (prev), Esc (exit)', vim.log.levels.INFO, { timeout = 3000 })
    end,
    desc = 'Render diagnostic (then > next, < prev)',
    mode = 'n',
  },

  -- Individual diagnostic commands (Error group)
  { '<leader>rsEl', '<cmd>RustLsp relatedDiagnostics<cr>', desc = 'Related diagnostics', mode = 'n' },

  -- Navigation
  { '<leader>rsn', group = 'navigation' },
  { '<leader>rsnc', '<cmd>RustLsp openCargo<cr>', desc = 'Open Cargo.toml', mode = 'n' },
  { '<leader>rsnd', '<cmd>RustLsp openDocs<cr>', desc = 'Open docs.rs', mode = 'n' },
  { '<leader>rsnp', '<cmd>RustLsp parentModule<cr>', desc = 'Parent module', mode = 'n' },
  { '<leader>rsns', '<cmd>RustLsp workspaceSymbol<cr>', desc = 'Workspace symbols', mode = 'n' },
  { '<leader>rsnS', '<cmd>RustLsp workspaceSymbol onlyTypes<cr>', desc = 'Workspace symbols (types)', mode = 'n' },
  { '<leader>rsna', '<cmd>RustLsp workspaceSymbol allSymbols<cr>', desc = 'Workspace symbols (all)', mode = 'n' },

  -- View commands
  { '<leader>rsv', group = 'view' },
  { '<leader>rsvs', '<cmd>RustLsp syntaxTree<cr>', desc = 'Syntax tree', mode = 'n' },
  { '<leader>rsvm', '<cmd>RustLsp view mir<cr>', desc = 'View MIR', mode = 'n' },
  { '<leader>rsvh', '<cmd>RustLsp view hir<cr>', desc = 'View HIR', mode = 'n' },
  { '<leader>rsvg', '<cmd>RustLsp crateGraph svg crategraph.svg<cr>', desc = 'Crate graph', mode = 'n' },

  -- Fly check
  { '<leader>rsf', group = 'flycheck' },
  { '<leader>rsfr', '<cmd>RustLsp flyCheck run<cr>', desc = 'Run flycheck', mode = 'n' },
  { '<leader>rsfc', '<cmd>RustLsp flyCheck clear<cr>', desc = 'Clear flycheck', mode = 'n' },
  { '<leader>rsfx', '<cmd>RustLsp flyCheck cancel<cr>', desc = 'Cancel flycheck', mode = 'n' },

  -- Utilities
  { '<leader>rsu', group = 'utilities' },
  { '<leader>rsul', '<cmd>RustLsp logFile<cr>', desc = 'Open log file', mode = 'n' },

  -- Rustc commands
  { '<leader>rsc', group = 'rustc' },
  {
    '<leader>rscu',
    function()
      local args = vim.fn.input 'Unpretty args: '
      vim.cmd('Rustc unpretty ' .. args)
    end,
    desc = 'Rustc unpretty',
    mode = 'n',
  },
}
