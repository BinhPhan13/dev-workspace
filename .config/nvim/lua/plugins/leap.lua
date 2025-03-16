local function config()
  local leap = require("leap")
  leap.opts.equivalence_classes = { " \t\r\n", "([{<>}])", "'\"`" }
  leap.opts.max_highlighted_traversal_targets = 0
  leap.opts.labels = ""
  leap.opts.safe_labels =
  "fdsajkl;ghtrewquiopvcxznm,./" ..
  "FDSAJKL:GHTREWQUIOPVCXZNM<>?"

  vim.keymap.set({"n", "x", "o"}, "<leader>l", "<Plug>(leap-anywhere)")

end

return {
  "ggandor/leap.nvim",
  config = config
}

