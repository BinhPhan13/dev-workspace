local function config()
  local ir = require("iron.core")
  local iv = require("iron.view")
  local ic = require("iron.fts.common")

  ir.setup {
    config = {
      scratch_repl = true,
      repl_definition = {
        sh = {
          command = {"bash"}
        },
        python = {
          command = { "python" },
          format = ic.bracketed_paste_python,
          block_dividers = { "# %%", "#%%" },
        }
      },
      repl_filetype = function(bufnr, ft) return ft end,
      repl_open_cmd = {
        iv.split.vertical.rightbelow("%50"),
        iv.split.rightbelow("%30"),
      }
    },

    keymaps = {
      toggle_repl_with_cmd_1 = "<leader>rv",
      toggle_repl_with_cmd_2 = "<leader>rh",
      restart_repl = "<leader>rr",
      send_motion = "<leader>rg",
      visual_send = "<leader>rg",
      send_file = "<leader>rf",
      send_line = "<leader>rl",
      send_paragraph = "<leader>rp",
      send_code_block = "<leader>rb",
      send_code_block_and_move = "<leader>rn",
      cr = "<leader>r<cr>",
      interrupt = "<leader>r<leader>",
      exit = "<leader>rq",
      clear = "<leader>rc",
    },
    highlight = { italic = true },
    ignore_blank_lines = false,
  }
end

return {
  "Vigemus/iron.nvim",
  config = config
}

