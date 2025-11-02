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

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Remove log files in state folder",
  callback = function()
    local logfiles = vim.fn.globpath(
      vim.fn.stdpath('state'),
      '{log,*.log}',
      1, 1
    )
    local luv = vim.uv or vim.loop
    local max_size = 10 * 1024 * 1024
    for _, logfile in ipairs(logfiles) do
      if luv.fs_stat(logfile).size < max_size then return end
      os.remove(logfile)
    end
  end,
})

