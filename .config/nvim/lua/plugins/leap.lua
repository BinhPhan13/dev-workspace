local function config()
  vim.keymap.set("n",        "<leader>l", "<Plug>(leap)")
  vim.keymap.set("n",        "<leader>L", "<Plug>(leap-from-window)")
  vim.keymap.set({"x", "o"}, "<leader>l", "<Plug>(leap-forward)")
  vim.keymap.set({"x", "o"}, "<leader>L", "<Plug>(leap-backward)")

  require("leap").opts.equivalence_classes = { " \t\r\n", "([{", ")]}", "'\"`" }
  require("leap.user").set_repeat_keys("<enter>", "<backspace>")
end

return {
  { "tpope/vim-repeat", tag = "v1.2" },
  {
    "ggandor/leap.nvim",
    dependencies = { "tpope/vim-repeat" },
    config = config
  }
}

