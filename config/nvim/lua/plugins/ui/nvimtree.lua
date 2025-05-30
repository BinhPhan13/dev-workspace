local function on_attach(bufnr)
  local api = require("nvim-tree.api")
  api.config.mappings.default_on_attach(bufnr)
  local function opts(desc)
    return {
      desc = "nvim-tree: " .. desc,
      buffer = bufnr,
      noremap = true, silent = true, nowait = true
    }
  end

  -- custom mappings
  local nav = api.node.navigate
  local copy = api.fs.copy

  vim.keymap.set("n", "<CR>", api.tree.change_root_to_node, opts("CD"))
  vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
  vim.keymap.set("n", "y", copy.absolute_path, opts("Copy Absolute Path"))
  vim.keymap.set("n", "gy", copy.filename, opts("Copy Filename"))

  vim.keymap.set("n", "h", nav.parent_close, opts("Close Directory"))
  vim.keymap.set("n", "J", nav.sibling.next, opts("Next sibling"))
  vim.keymap.set("n", "K", nav.sibling.prev, opts("Prev sibling"))
  vim.keymap.set("n", ">", nav.sibling.last, opts("Last Sibling"))
  vim.keymap.set("n", "<", nav.sibling.first, opts("First Sibling"))
end

local function config()
  -- disable netrw
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  require("nvim-tree").setup({
    on_attach = on_attach,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    actions = {
      change_dir = { global = true },
      open_file = { quit_on_open = true },
    },
    git = { enable = false },
    renderer = { icons = { show = {
      file = false,
      folder = false,
      folder_arrow = false,
    }}}
  })
  vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)
end

return {
  "nvim-tree/nvim-tree.lua",
  config = config
}

