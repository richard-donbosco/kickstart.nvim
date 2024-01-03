-- Move selected block of text with correct auto indent in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected block of text down with correct auto indent" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected block of text up with correct auto indent" })

-- Window resizing in normal mode with Ctrl + arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Half page scrolling in normal mode with Ctrl + u/d and window curson centered
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll half page up" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half page down" })

-- Moving between windows with Ctrl + hjkl in normal mode
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to down window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to up window" })

--------------------
-- Neotest mappings
--------------------
-- Re run the last ran test
vim.keymap.set("n", "<leader>?l", require('neotest').run.run_last,
	{ desc = "[?] Re-run the last ran test" })
-- Run the test under the cursor
vim.keymap.set("n", "<leader>??", require('neotest').run.run,
	{ desc = "[?] Run test function [b]lock on hover" })
-- Run the tests in the current file
vim.keymap.set("n", "<leader>?f", function() require('neotest').run.run(vim.fn.expand('%')) end,
	{ desc = "[?] Run tests in current [f]ile" })
-- Run the tests in the current directory, works based on the current buffer
vim.keymap.set("n", "<leader>?d", function() require('neotest').run.run(vim.fn.expand('%:p:h')) end,
	{ desc = "[?] Run tests in current [d]irectory" })
-- Run the tests based on the input path and args
vim.keymap.set("n", "<leader>?i",
	function()
		local input_path = vim.fn.input({ prompt = "Enter path:" })
		local args = vim.fn.input({ prompt = "[Optional] Enter args:" })
		require('neotest').run.run({ "" .. input_path, extra_args = { args } })
	end,
	{ desc = "[?] Run tests in [i]nput relative path (to vim root dir) and args." })
-- Run the tests in the project root directory (vim root dir)
vim.keymap.set("n", "<leader>?p",
	function()
		require('neotest').run.run(vim.fn.getcwd())
	end,
	{ desc = "[?] Run tests in [r]relative path" })

-- Test summary toggle open/close
vim.keymap.set("n", "<leader>?s", require('neotest').summary.toggle,
	{ desc = "[?] Test [s]ummary window toggle open/close" })
