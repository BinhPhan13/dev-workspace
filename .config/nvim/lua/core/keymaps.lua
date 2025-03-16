vim.g.mapleader = " "

-- misc
vim.keymap.set("n", "<Esc>", ":<BS>")
vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<leader><Tab>", "<C-6>")
vim.keymap.set({"n", "v"}, "<M-k>", "{zz")
vim.keymap.set({"n", "v"}, "<M-j>", "}zz")

-- chdir
vim.keymap.set("n", "<leader>c", ":cd")
vim.keymap.set("n", "<leader>C", function()
  bufpath = vim.api.nvim_buf_get_name(0)
  dirpath = vim.fn.fnamemodify(bufpath, ":h")
  print(dirpath)
  vim.cmd.cd(dirpath)
end)

-- terminal mode
vim.keymap.set("n", "<leader>T", vim.cmd.term)
vim.keymap.set("t", "<leader>\\", "<C-\\><C-n>")

-- replace word under cursor globally
vim.keymap.set("n", "S", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>")
vim.keymap.set("x", "S", ":s/\\<<C-r><C-w>\\>/<C-r><C-w>/g<Left><Left>")

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

-- move
vim.keymap.set("n", "<C-M-j>", function()
  return pcall(vim.cmd, "m+" .. vim.v.count1)
end)
vim.keymap.set("n", "<C-M-k>", function()
  return pcall(vim.cmd, "m-" .. vim.v.count1 + 1)
end)

-- text objects
vim.keymap.set({"x", "o"}, "ic", "iB")
vim.keymap.set({"x", "o"}, "ac", "aB")
vim.keymap.set({"x", "o"}, "ir", "i[")
vim.keymap.set({"x", "o"}, "ar", "a[")
vim.keymap.set({"x", "o"}, "il", "i<")
vim.keymap.set({"x", "o"}, "al", "a<")

vim.keymap.set({"x", "o"}, "ij", "i\"")
vim.keymap.set({"x", "o"}, "aj", "a\"")
vim.keymap.set({"x", "o"}, "ik", "i\'")
vim.keymap.set({"x", "o"}, "ak", "a\'")
vim.keymap.set({"x", "o"}, "iz", "i`")
vim.keymap.set({"x", "o"}, "az", "a`")


-- window
vim.keymap.set("n", "<leader>wv", "<C-w>v")
vim.keymap.set("n", "<leader>wh", "<C-w>s")
vim.keymap.set("n", "<leader>wx", "<C-w>c")

vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

-- tab
vim.keymap.set("n", "<leader>to", function()
  bufpath = vim.api.nvim_buf_get_name(0)
  pcall(vim.cmd.tabe, bufpath)
end)
vim.keymap.set("n", "<leader>tx", function() pcall(vim.cmd.tabc) end)

-- buffer
vim.keymap.set("n", "<leader>bd", vim.cmd.bw)
vim.keymap.set("n", "<M-l>", vim.cmd.bn)
vim.keymap.set("n", "<M-h>", vim.cmd.bN)
vim.keymap.set("n", "<M-b>", function()
  local buffers = vim.api.nvim_list_bufs()
  local listed_buffers = {}

  for _, bufnr in ipairs(buffers) do
    if vim.bo[bufnr].buflisted then
      table.insert(listed_buffers, bufnr)
    end
  end

  local k = vim.v.count1
  if k <= #listed_buffers then 
    return vim.cmd("b" .. listed_buffers[k])
  end
end)

