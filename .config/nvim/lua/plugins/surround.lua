local function config()
  require("nvim-surround").setup({
    keymaps = {
      insert = "<C-s>",
      normal = "s",
      normal_cur = "ss",
      visual = "s",
    },
    aliases = {
      ["l"] = ">",
      ["b"] = ")",
      ["c"] = "}",
      ["r"] = "]",
      ["p"] = { "}", "]", ")", ">" },

      ["L"] = "<",
      ["B"] = "(",
      ["C"] = "{",
      ["R"] = "[",
      ["P"] = { "<", "(", "{", "[" },

      ["j"] = '"',
      ["k"] = "'",
      ["z"] = "`",
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

