return {
  "catppuccin/nvim", name = "catppuccin",
  priority = 1000,
  config = function()
    vim.opt.cursorline = true
    vim.opt.colorcolumn = "81"
    vim.opt.signcolumn = "yes"
    require("catppuccin").setup({
      transparent_background = true,
      dim_inactive = { enable = false },
      no_italic = true,
      -- no_bold = true,
      no_underline = true,
      default_integrations = true,
      integrations = {
        treesitter = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      }
    })
    vim.cmd.colorscheme("catppuccin-mocha")
  end,
}

