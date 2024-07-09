return {
  'nexus.nvim',
  url = "git@github.pie.apple.com:AI-for-Devs-Community/nexus.nvim.git",
  -- branch = "dev", -- if you want use use the dev branch, upcoming features
  -- tag = "v2.0.0-beta", -- if you want use a specifically tagged version
  event = 'VeryLazy',
  config = function()
    require('nexus').setup({
      provider = { name = "codelm" },
    })
  end,
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'folke/trouble.nvim',
    'nvim-telescope/telescope.nvim'
  }
}
