vim.g.mapleader = " "

-- misc
vim.keymap.set("n", "<Esc>", ":<BS>")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader><Tab>", "<C-6>")

-- chdir
vim.keymap.set("n", "<leader>c", ":cd")
vim.keymap.set("n", "<leader>C", function()
  bufpath = vim.api.nvim_buf_get_name(0)
  dirpath = vim.fn.fnamemodify(bufpath, ":h")
  print(dirpath)
  vim.cmd.cd(dirpath)
end)

-- wipe out buffers
vim.keymap.set("n", "<leader>bd", vim.cmd.bd)
vim.keymap.set("n", "<leader>bD", function() vim.cmd("%bd") end)

-- terminal mode
vim.keymap.set("n", "<leader>T", vim.cmd.term)
vim.keymap.set("t", "<leader>\\", "<C-\\><C-n>")

-- replace word under cursor globally
vim.keymap.set("n", "S", ":%s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>")
vim.keymap.set("x", "S", ":s/<C-r><C-w>/<C-r><C-w>/g<Left><Left>")

-- paste and select the pasted text
vim.keymap.set("n", "<C-p>", "mzgpkV'zj")

-- void register
vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("x", "<leader>d", "\"_d")

-- smooth jumping
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- window management
vim.keymap.set("n", "<leader>wv", "<C-w>v")
vim.keymap.set("n", "<leader>wh", "<C-w>s")
vim.keymap.set("n", "<leader>wx", "<C-w>c")

vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

-- tab management
vim.keymap.set("n", "<leader>to", function()
  bufpath = vim.api.nvim_buf_get_name(0)
  vim.cmd.tabe(bufpath)
end)
vim.keymap.set("n", "<leader>tx", vim.cmd.tabclose)
vim.keymap.set("n", "<leader>tp", function() vim.cmd("silent! -tabm") end)
vim.keymap.set("n", "<leader>tn", function() vim.cmd("silent! +tabm") end)

