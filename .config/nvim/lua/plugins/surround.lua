local function config()
  require("nvim-surround").setup({
    keymaps = {
      insert = "<C-s>",
      normal = "s",
      normal_cur = "ss",
      visual = "s",
    },
    aliases = {
      ["a"] = ">",
      ["p"] = ")",
      ["c"] = "}",
      ["r"] = "]",
      ["b"] = { "}", "]", ")", ">" },

      ["A"] = "<",
      ["P"] = "(",
      ["C"] = "{",
      ["R"] = "[",
      ["B"] = { "<", "(", "{", "[" },

      ["j"] = '"',
      ["k"] = "'",
      ["l"] = "`",
      ["q"] = { '"', "'", "`" },

      ["s"] = { "}", "]", ")", ">", '"', "'", "`" },
    },
    indent_lines = false
  })
end

return {
  "kylechui/nvim-surround", tag = "v2.3.0",
  event = "VeryLazy",
  config = config
}

