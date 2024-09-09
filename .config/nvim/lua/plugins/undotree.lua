return {
  "mbbill/undotree", tag = "rel_6.1",
  config = function()
    vim.keymap.set("n", "<leader>u",
    function()
      vim.cmd.UndotreeToggle()
      vim.cmd.UndotreeFocus()
    end)
  end
}

