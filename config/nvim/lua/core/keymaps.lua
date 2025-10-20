vim.g.mapleader = " "

-- misc
vim.keymap.set({"n", "x"}, "Q", "<nop>")
vim.keymap.set({"i", "c"}, "<C-l>", "<Del>")
vim.keymap.set("n", "<leader><Tab>", "<C-6>")
vim.keymap.set("n", "<leader>w", "<C-w>")
vim.keymap.set("n", "<C-n>", "-")

-- clear command line
vim.keymap.set("n", "<Esc>", ":<BS>")

-- remove trailspace
vim.keymap.set("n", "Q", function() vim.cmd("silent! %s/\\s\\+$//g") end)

-- visual just pasted text
vim.keymap.set("n", "<C-p>", "mzgpkV'zj")

-- substitute globally word under cursor
vim.keymap.set("n", "S", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>")

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

-- tab
vim.keymap.set("n", "<leader>to", function()
  bufpath = vim.api.nvim_buf_get_name(0)
  pcall(vim.cmd.tabe, bufpath)
end)
vim.keymap.set("n", "<leader>tn", function() pcall(vim.cmd.tabnew) end)
vim.keymap.set("n", "<leader>tx", function() pcall(vim.cmd.tabc) end)

-- terminal mode
vim.keymap.set("n", "<leader>T", vim.cmd.term)
vim.keymap.set("t", "<leader>\\", "<C-\\><C-n>")

