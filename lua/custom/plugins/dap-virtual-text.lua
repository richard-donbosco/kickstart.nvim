return {
  'theHamsta/nvim-dap-virtual-text',
  cond = false,
  config = function()
    require('nvim-dap-virtual-text').setup()
  end,
}
