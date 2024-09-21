local function config()
  require("Comment").setup({
    padding = true,
    sticky = true,
    ignore = nil,

    toggler = {
      line = "gcc",
      -- block = "gbc",
    },

    opleader = {
      line = "gc",
      -- block = "gb",
    },

    extra = {
      above = "gcO",
      below = "gco",
      eol = "gcA",
    },

    ---NOTE: `false` -> no mappings
    mappings = {
      basic = true,
      extra = true,
    },

    pre_hook = nil,
    post_hook = nil,
  })
end

return {
  "numToStr/Comment.nvim", tag = "v0.8.0",
  opts = {},
  config = config
}

