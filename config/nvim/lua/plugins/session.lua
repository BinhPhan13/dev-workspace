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
      vim.ui.input({ prompt = 'Session name: ', default = rs.get_current() },
      function(input)
        input = (input or ''):match('^%s*(.-)%s*$')
        if input ~= '' then rs.save(input) end
        vim.cmd.normal(':')
      end)
    end)

    local function save_current()
      if not rs.get_current() then return end
      rs.save(nil, { notify = false })
    end
    rs.add_hook('pre_load', save_current)
    vim.keymap.set("n", "<leader>sl", rs.load)

    vim.keymap.set("n", "<leader>sd", rs.delete)

    vim.api.nvim_create_autocmd("VimLeavePre", { callback = save_current })
  end
}

