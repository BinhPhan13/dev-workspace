return {
  'mbbill/undotree',
  config = function()
    vim.keymap.set('n', '<M-u>', vim.cmd.UndotreeShow)
    vim.keymap.set('n', '<M-U>', function()
      if not vim.bo.buflisted then return end
      vim.ui.input({ prompt = 'Clear undo history? [y/N]: '}, function(input)
        vim.cmd.normal(':')
        local answer = (input or ""):lower()
        if not vim.tbl_contains({'y', 'yes'}, answer) then return end

        local old = vim.bo.undolevels
        vim.bo.undolevels = -1

        vim.cmd.normal({'O', bang = true})
        vim.cmd.normal({'dd', bang = true})
        vim.cmd.write({mods = { silent = true }})

        vim.bo.undolevels = old
        vim.notify("Undo history cleared!")
      end)
    end)

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

