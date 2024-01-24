return {
  {
    "mfussenegger/nvim-lint",
    config = function()
      require('lint').linters_by_ft = {
        go = { 'golangcilint', },
        groovy = { 'npm-groovy-lint', },
        python = { 'flake8', 'pylint' },
      }
    end
  },
}
