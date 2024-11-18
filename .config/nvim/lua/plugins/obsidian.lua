local function config()
  local obsidian = require("obsidian")
  obsidian.setup({
    workspaces = {
      {
        name = "personal",
        path = "~/Obsidian",
      },
    },
    completion = {
      nvim_cmp = true,
      min_chars = 1,
    },
    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["<leader>of"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>oc"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<leader>oo"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      }
    },
    new_notes_location = "current_dir",
    preferred_link_style = "wiki",
    disable_frontmatter = true,

    follow_url_func = function(url)
      vim.fn.jobstart({"web", url})
    end,
    follow_img_func = function(img)
      vim.fn.jobstart({"web", img})
    end,
  })

  vim.opt.conceallevel = 1

end

return {
  -- "epwalsh/obsidian.nvim", tag = "v3.9.0",
  -- lazy = true,
  -- event = {
  --   "BufNewFile " .. vim.fn.expand "~" .. "/Obsidian/*.md",
  --   "BufReadPre " .. vim.fn.expand "~" .. "/Obsidian/*.md",
  -- },
  -- config = config
}

