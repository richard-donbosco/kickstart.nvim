return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-python",

    -- Your other test adapters here
    'mfussenegger/nvim-dap',
    'leoluz/nvim-dap-go',
  },
  config = function()
    -- get neotest namespace (api call creates or returns namespace)
    local neotest_ns = vim.api.nvim_create_namespace("neotest")
    vim.diagnostic.config({
      virtual_text = {
        format = function(diagnostic)
          local message =
              diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
          return message
        end,
      },
    }, neotest_ns)

    require("neotest").setup({
      -- your neotest config here
      adapters = {
        require("neotest-python"),
        require("neotest-go"),
      },
    })
  end,
}
