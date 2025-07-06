return {
  {
    'mfussenegger/nvim-lint',
    cond = false,
    config = function()
      require('lint').linters_by_ft = {
        go = { 'golangcilint' },
        -- groovy = { 'npm-groovy-lint', },
        python = { 'flake8', 'pylint' },
      }
    end,
  },
}
