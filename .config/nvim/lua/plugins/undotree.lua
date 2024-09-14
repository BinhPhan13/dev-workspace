local function config()
  vim.g.undotree_WindowLayout = 3
  vim.g.undotree_SetFocusWhenToggle = 1
  vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
end

return {
  "mbbill/undotree", tag = "rel_6.1",
  config = config
}

