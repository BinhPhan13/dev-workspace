local function config()
  vim.g.undotree_WindowLayout = 3
  vim.g.undotree_SetFocusWhenToggle = 1
  vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
end

return {
  "mbbill/undotree",
  config = config
}

