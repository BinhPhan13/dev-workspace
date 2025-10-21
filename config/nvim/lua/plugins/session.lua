return {
  'stevearc/resession.nvim',
  dependencies = {
    'romgrk/barbar.nvim',
  },
  config = function()
    rs = require("resession")
    rs.setup({
      dir = 'session', -- vim.fn.stdpath('data') .. dir
      load_detail = false,
      extensions = {
        barbar = {},
      },
    })

    vim.keymap.set("n", "<leader>ss", function()
      vim.ui.input({ prompt = 'Session name: ' }, function(input)
        if input then rs.save(input) end
      end)
    end)
    vim.keymap.set("n", "<leader>sl", rs.load)
    vim.keymap.set("n", "<leader>sd", rs.delete)

    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function() rs.save_all({ notify = false }) end
    })
  end
}

