local function config()
  local builtin = require("telescope.builtin")
  vim.keymap.set("n", "<leader>ff", builtin.find_files)
  vim.keymap.set("n", "<leader>fb", builtin.buffers)
  vim.keymap.set("n", "<leader>fh", builtin.help_tags)
  vim.keymap.set("n", "<leader>fp", builtin.live_grep)
  vim.keymap.set("n", "<leader>fs", builtin.grep_string)
  vim.keymap.set("n", "<leader>fd", builtin.diagnostics)
  vim.keymap.set("n", "<leader>fr", builtin.lsp_references)
end

return {
  "nvim-telescope/telescope.nvim",
  config = config
}

