vim.g.mapleader = " "

vim.keymap.set({"n", "x"}, "Q", "<nop>")

-- alternate key options
vim.keymap.set("n", "<leader><Tab>", "<C-6>")
vim.keymap.set("n", "<leader>w", "<C-w>")

vim.keymap.set("n", "<C-n>", "-")
vim.keymap.set({"i", "c"}, "<C-l>", "<Del>")

vim.keymap.set({"n", "x"}, "<M-k>", "{")
vim.keymap.set({"n", "x"}, "<M-j>", "}")

-- quit and save
vim.keymap.set("n", "<M-q>", function() vim.cmd('silent! qa') end)
vim.keymap.set("n", "<M-Q>", function() vim.cmd('qa!') end)
vim.keymap.set("n", "<M-w>", function() vim.cmd('silent! w') end)
vim.keymap.set("n", "<M-W>", function() vim.cmd('silent! wa') end)

-- resize window
vim.keymap.set("n", "<S-Right>", "3<C-w>>")
vim.keymap.set("n", "<S-Left>", "3<C-w><")
vim.keymap.set("n", "<S-Down>", "3<C-w>-")
vim.keymap.set("n", "<S-Up>", "3<C-w>+")

vim.keymap.set("i", "<M-h>", "<C-g>U<Left>")
vim.keymap.set("i", "<M-l>", "<C-g>U<Right>")

-- yank into '+' register
vim.keymap.set({ "n", "x" }, "<M-y>", '"+y')

-- visual just pasted text
vim.keymap.set("n", "<C-p>", "mzgpkV'zj")

-- clear command line
vim.keymap.set("n", "<Esc>", ":<BS>")

-- toggle hlsearch
vim.keymap.set("n", "gh", function() vim.cmd.set('hlsearch!') end)

-- remove trailspace
vim.keymap.set("n", "Q", function()
  vim.cmd("silent! %s/\\s\\+$//g")
  vim.cmd("normal! ''")
end)

-- substitute globally word under cursor
vim.keymap.set("n", "S", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>")

-- void register
vim.keymap.set("x", "<M-p>", "\"_dP")
vim.keymap.set("x", "<M-d>", "\"_d")

-- tab
vim.keymap.set("n", "<leader>to", function()
  bufpath = vim.api.nvim_buf_get_name(0)
  pcall(vim.cmd.tabe, bufpath)
end)
vim.keymap.set("n", "<leader>tx", function() pcall(vim.cmd.tabc) end)

-- terminal mode
vim.keymap.set("n", "<leader>T", vim.cmd.term)
vim.keymap.set("t", "<leader>\\", "<C-\\><C-n>")

