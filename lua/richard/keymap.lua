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

--------------------
-- Neotest mappings
--------------------
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

--------------------
-- Trouble mappings
--------------------
vim.keymap.set('n', '<leader>xx', function()
  require('trouble').toggle()
end)
vim.keymap.set('n', '<leader>xw', function()
  require('trouble').toggle 'workspace_diagnostics'
end)
vim.keymap.set('n', '<leader>xd', function()
  require('trouble').toggle 'document_diagnostics'
end)
vim.keymap.set('n', '<leader>xq', function()
  require('trouble').toggle 'quickfix'
end)
vim.keymap.set('n', '<leader>xl', function()
  require('trouble').toggle 'loclist'
end)
vim.keymap.set('n', 'gR', function()
  require('trouble').toggle 'lsp_references'
end)

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
