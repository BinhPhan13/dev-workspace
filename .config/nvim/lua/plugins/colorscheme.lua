return {
  "catppuccin/nvim", name = "catppuccin", tag = "v1.7.0",
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

