return {
  "folke/tokyonight.nvim", tag = 'v4.8.0',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    vim.cmd.colorscheme('tokyonight-night')
  end
}