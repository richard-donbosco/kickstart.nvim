return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      '<leader>cf',
      function()
        require('conform').format { async = true, lsp_fallback = true }
      end,
      mode = '',
      desc = '[C]onform [F]ormat buffer',
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      swift = { 'swiftformat' },
      lua = { 'stylua' },
      python = { 'ruff_format' },
      go = { 'gofumpt', 'golines', 'goimports' },
      rust = { 'rustfmt', lsp_format = 'fallback' },
      typescript = { 'biome', 'biome-organize-imports' },
      typescriptreact = { 'biome', 'biome-organize-imports' },
      -- groovy = { "groovyfmt" },
      -- javascript = { { "prettierd", "prettier" } },
    },
    -- Set up format-on-save
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 2000, lsp_fallback = true }
    end,

    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { '-i', '2' },
      },
      isort = {
        prepend_args = { '--profile', 'black' },
      },
      black = {
        prepend_args = { '--fast' },
      },
      -- groovyfmt = {
      --   command = "npm-groovy-lint",
      --   args = { "--format", "$FILENAME" },
      --   stdin = false,
      -- },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })

    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })
  end,
}
