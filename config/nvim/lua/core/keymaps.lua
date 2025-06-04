vim.g.mapleader = " "

-- misc
vim.keymap.set("n", "<Esc>", ":<BS>")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader><Tab>", "<C-6>")
vim.keymap.set("n", "<leader>w", "<C-w>")
vim.keymap.set("n", "<C-n>", "-")
-- vim.keymap.set({"i", "c"}, "<C-l>", "<Del>")

-- visual just pasted text
vim.keymap.set("n", "<C-p>", "mzgpkV'zj")

-- replace globally word under cursor
vim.keymap.set("n", "S", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>")

-- chdir
vim.keymap.set("n", "<leader>c", ":cd ")
vim.keymap.set("n", "<leader>C", function()
  bufpath = vim.api.nvim_buf_get_name(0)
  dirpath = vim.fn.fnamemodify(bufpath, ":h")
  print(dirpath)
  vim.cmd.cd(dirpath)
end)

-- move
vim.keymap.set("n", "<C-M-j>", function()
  return pcall(vim.cmd, "m+" .. vim.v.count1)
end)
vim.keymap.set("n", "<C-M-k>", function()
  return pcall(vim.cmd, "m-" .. vim.v.count1 + 1)
end)

-- void register
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("x", "<leader>d", "\"_d")

-- jump
vim.keymap.set({"n", "x"}, "n", "nzz")
vim.keymap.set({"n", "x"}, "N", "Nzz")
vim.keymap.set({"n", "x"}, "<M-k>", "{")
vim.keymap.set({"n", "x"}, "<M-j>", "}")

-- buffer
vim.keymap.set("n", "<M-l>", vim.cmd.bn)
vim.keymap.set("n", "<M-h>", vim.cmd.bN)

-- tab
vim.keymap.set("n", "<leader>to", function()
  bufpath = vim.api.nvim_buf_get_name(0)
  pcall(vim.cmd.tabe, bufpath)
end)
vim.keymap.set("n", "<leader>tx", function() pcall(vim.cmd.tabc) end)

-- terminal mode
vim.keymap.set("n", "<leader>T", vim.cmd.term)
vim.keymap.set("t", "<leader>\\", "<C-\\><C-n>")

