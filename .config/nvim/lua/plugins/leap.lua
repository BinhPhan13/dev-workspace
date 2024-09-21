local function config()
  vim.keymap.set({"n", "x", "o"}, "<leader>l", "<Plug>(leap)")
  require("leap").opts.equivalence_classes = { " \t\r\n", "([{<>}])", "'\"`" }
end

return {
  "ggandor/leap.nvim",
  config = config
}

