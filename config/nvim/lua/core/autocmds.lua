vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Make help buffers listed",
  pattern = "*.txt",
  callback = function()
    if vim.bo.filetype == "help" then
      vim.bo.buflisted = true
    end
  end,
})

