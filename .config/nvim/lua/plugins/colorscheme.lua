return {
  "catppuccin/nvim", name = "catppuccin",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd.colorscheme("catppuccin-mocha")
    vim.opt.cursorline = true
    vim.opt.colorcolumn = "81"
    vim.opt.signcolumn = "yes"
  end
}

