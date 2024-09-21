local sections = {
  lualine_a = { "mode" },
  lualine_b = { "hostname" },
  lualine_c = { "%{fnamemodify(expand('%'), ':~:.')} %m%r" },

  lualine_x = { "filetype" },
  lualine_y = { "branch" },
  lualine_z = { "location" },
}

local function config()
  require("lualine").setup({
    sections = sections
  })

  vim.opt.showmode = false
  vim.opt.laststatus = 3
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = config
}

