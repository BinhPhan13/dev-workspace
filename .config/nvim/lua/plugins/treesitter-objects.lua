local objects = {
  select = {
    enable = true,
    lookahead = true,
    keymaps = {
      ["ib"] = "@block.inner",
      ["ab"] = "@block.outer",
      ["ia"] = "@parameter.inner",
      ["aa"] = "@parameter.outer",
      ["if"] = "@function.inner",
      ["af"] = "@function.outer",
      ["i0"] = "@number.inner",
    }
  },
  swap = {
    enable = true,
    swap_next = {
      ["<leader>>b"] = "@block.outer",
      ["<leader>>a"] = "@parameter.inner",
      ["<leader>>f"] = "@function.outer",
    },
    swap_previous = {
      ["<leader><b"] = "@block.outer",
      ["<leader><a"] = "@parameter.inner",
      ["<leader><f"] = "@function.outer",
    },
  },
  move = {
    enable = true,
    set_jumps = true,
    goto_next_start = {
      ["]b"] = "@block.outer",
      ["]a"] = "@parameter.inner",
      ["]f"] = "@function.outer",
    },
    goto_next_end = {
      ["]B"] = "@block.outer",
      ["]A"] = "@parameter.inner",
      ["]F"] = "@function.outer",
    },
    goto_previous_start = {
      ["[b"] = "@block.outer",
      ["[a"] = "@parameter.inner",
      ["[f"] = "@function.outer",
    },
    goto_previous_end = {
      ["[B"] = "@block.outer",
      ["[A"] = "@parameter.inner",
      ["[F"] = "@function.outer",
    },
  }
}

local function config()
  configs = require("nvim-treesitter.configs")
  configs.setup({
    textobjects = objects,
  })

  local ts_repeat = require("nvim-treesitter.textobjects.repeatable_move")
  vim.keymap.set({ "n", "x", "o" }, "<leader>;", ts_repeat.repeat_last_move)
  vim.keymap.set({ "n", "x", "o" }, "<leader>,", ts_repeat.repeat_last_move_opposite)
end

return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  config = config
}

