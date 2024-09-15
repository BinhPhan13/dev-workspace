local function config()
  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "tf", builtin.find_files)
  vim.keymap.set("n", "tb", builtin.buffers)
  vim.keymap.set("n", "th", builtin.help_tags)
  vim.keymap.set("n", "tp", builtin.live_grep)
  vim.keymap.set("n", "ts", builtin.grep_string)
  vim.keymap.set("n", "td", builtin.diagnostics)
  vim.keymap.set("n", "tr", builtin.lsp_references)
end

return {
  { "nvim-lua/plenary.nvim", tag = "v0.1.4"},
  {
    "nvim-telescope/telescope.nvim", tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = config
  }
}

