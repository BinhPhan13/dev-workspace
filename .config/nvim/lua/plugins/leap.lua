local function config()
  require('leap.user').set_repeat_keys("<CR>", "<BS>", {
    relative_directions = true,
  })

  local leap = require("leap")
  leap.opts.equivalence_classes = { " \t\r\n", "([{<>}])", "'\"`" }
  leap.opts.max_highlighted_traversal_targets = 0
  leap.opts.labels = ""
  leap.opts.safe_labels =
  "fdsajkl;ghtrewquiopvcxznm,./" ..
  "FDSAJKL:GHTREWQUIOPVCXZNM<>?"


  vim.keymap.set({"n", "x", "o"}, "f", function()
    leap.leap({ offset = 0, inclusive_op = true })
  end)

  vim.keymap.set({"n", "x", "o"}, "F", function()
    leap.leap({ offset = 0, inclusive_op = true, backward = true })
  end)

  vim.keymap.set({"n", "x", "o"}, "t", function()
    leap.leap({ offset = -1, inclusive_op = true })
  end)

  vim.keymap.set({"n", "x", "o"}, "T", function()
    leap.leap({ offset = 1, inclusive_op = true, backward = true })
  end)

end

return {
  "ggandor/leap.nvim",
  config = config
}

