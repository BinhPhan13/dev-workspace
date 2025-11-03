return {
  'mbbill/undotree',
  config = function()
    vim.keymap.set('n', '<M-u>', vim.cmd.UndotreeShow)

    vim.keymap.set('n', '<leader>us', function()
      if not vim.bo.ma then return end
      vim.bo.undofile = true
      vim.cmd.write({mods = { silent = true }})
      vim.notify("Undo history saved!")
    end, {desc = 'Save undo history'})

    vim.keymap.set('n', '<leader>uc', function()
      if not vim.bo.ma then return end
      local answer
      vim.ui.input({ prompt = 'Clear undo history? [y/N]: '}, function(input)
        vim.cmd.normal(':')
        answer = (input or ""):lower()
      end)
      if not vim.tbl_contains({'y', 'yes'}, answer) then return end

      local old = vim.bo.undolevels
      vim.bo.undolevels = -1
      vim.bo.undofile = true

      vim.cmd.normal({'O', bang = true})
      vim.cmd.normal({'dd', bang = true})
      vim.cmd.write({mods = { silent = true }})

      vim.bo.undolevels = old
      vim.bo.undofile = false

      vim.notify("Undo history cleared!")
    end, {desc = 'Clear undo history'})

    vim.g.undotree_WindowLayout = 4
    vim.g.undotree_SplitWidth = 30
    vim.g.undotree_DiffAutoOpen = 0
    vim.g.undotree_DiffpanelHeight = 30
    vim.g.undotree_SetFocusWhenToggle = 1
    vim.g.undotree_DisabledBuftypes = {
      'terminal', 'prompt', 'quickfix',
      'nofile', 'help',
    }
  end
}

