local sections = {
  lualine_a = { "mode" },
  lualine_b = { "hostname" },
  lualine_c = { "%{fnamemodify(expand('%'), ':~:.')} %m%r" },

  lualine_x = { "filetype" },
  lualine_y = { "progress" },
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
  config = config
}

