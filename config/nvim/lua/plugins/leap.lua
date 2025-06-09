return {
  "ggandor/leap.nvim",
  config = function()
    local leap = require("leap")
    leap.opts.case_sensitive = false
    leap.opts.equivalence_classes = { " \t\r\n", "([{<>}])", "'\"`" }
    leap.opts.max_highlighted_traversal_targets = 0
    leap.opts.safe_labels =
    "fdsajkl;ghtrewquiopvcxznm,./" ..
    "FDSAJKL:GHTREWQUIOPVCXZNM<>?"
    leap.opts.labels = ""
    vim.keymap.set({"n", "x", "o"}, "r", "<Plug>(leap-anywhere)")
    vim.keymap.set({"n", "x", "o"}, "R", "<Plug>(leap)")
  end
}

