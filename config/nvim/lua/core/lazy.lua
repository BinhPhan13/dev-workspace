local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim/"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--branch=stable",
    lazyrepo,
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "plugins.utils" },
    { import = "plugins.ui" },
    -- { import = "plugins.ide" },
    -- { import = "plugins.ide.lsp" },
    -- { import = "plugins.utils.python" },
  },
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
})

