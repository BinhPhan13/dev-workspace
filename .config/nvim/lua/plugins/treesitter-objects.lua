local objects = {
  select = {
    enable = true,
    lookahead = true,
    keymaps = {
      ["ia"] = "@assignment.inner",
      ["aa"] = "@assignment.outer",

      ["iv"] = "@parameter.inner",
      ["av"] = "@parameter.outer",

      ["ii"] = "@block.inner",
      ["ai"] = "@block.outer",

      ["if"] = "@function.inner",
      ["af"] = "@function.outer",

      ["in"] = "@number.inner",
    }
  },
  swap = {
    enable = true,
    swap_next = {
      ["<leader>>a"] = "@assignment.inner",
      ["<leader>>v"] = "@parameter.inner",
      ["<leader>>i"] = "@block.outer",
      ["<leader>>f"] = "@function.outer",
      ["<leader>>n"] = "@number.inner",
    },
    swap_previous = {
      ["<leader><a"] = "@assignment.inner",
      ["<leader><v"] = "@parameter.inner",
      ["<leader><i"] = "@block.outer",
      ["<leader><f"] = "@function.outer",
      ["<leader><n"] = "@number.inner",
    },
  },
  move = {
    enable = true,
    set_jumps = true,
    goto_next_start = {
      ["[a"] = "@assignment.inner",
      ["[v"] = "@parameter.inner",
      ["[i"] = "@block.outer",
      ["[f"] = "@function.outer",
      ["[n"] = "@number.inner",
    },
    goto_next_end = {
      ["]a"] = "@assignment.inner",
      ["]v"] = "@parameter.inner",
      ["]i"] = "@block.outer",
      ["]f"] = "@function.outer",
      ["]n"] = "@number.inner",
    },
  }
}

local function config()
  local configs = require("nvim-treesitter.configs")
  configs.setup({
    textobjects = objects,
  })

  local ts_repeat = require("nvim-treesitter.textobjects.repeatable_move")
  vim.keymap.set({ "n", "x", "o" }, "<A-j>", ts_repeat.repeat_last_move)
  vim.keymap.set({ "n", "x", "o" }, "<A-k>", ts_repeat.repeat_last_move_opposite)
end

return {
  -- "nvim-treesitter/nvim-treesitter-textobjects",
  -- config = config
}

