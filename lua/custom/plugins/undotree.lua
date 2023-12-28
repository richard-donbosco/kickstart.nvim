return {
  {
    "mbbill/undotree",
    lazy = false,
    priority = 100,
    keys = {
      {"<leader><F5>", vim.cmd.UndotreeToggle, desc="UndotreeToggle"},
    },
  },
}
