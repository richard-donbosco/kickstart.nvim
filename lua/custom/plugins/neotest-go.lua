return {
  'nvim-neotest/neotest',
  cond = true,
  dependencies = {
    'nvim-neotest/nvim-nio',
    'nvim-lua/plenary.nvim',
    { 'fredrikaverpil/neotest-golang', version = '*' },
    -- 'nvim-neotest/neotest-go',
    'nvim-neotest/neotest-python',
    'antoinemadec/FixCursorHold.nvim',
    -- Your other test adapters here
    'mfussenegger/nvim-dap',
    'leoluz/nvim-dap-go',
  },
  config = function()
    local neotest_golang_opts = {}
    require('neotest').setup {
      adapters = {
        require 'neotest-python',
        require 'neotest-golang'(neotest_golang_opts),
        -- require 'neotest-go',
      },
    }
  end,
}
