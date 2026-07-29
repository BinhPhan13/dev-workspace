local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim/"

local function setup()
  vim.opt.rtp:prepend(lazypath)
  require("lazy").setup({
    defaults = { version = "*" },
    spec = {
      { import = "plugins" },
    },
    checker = { notify = false },
    change_detection = {
      enable = false,
      notify = false,
    },
  })
end
if (vim.uv or vim.loop).fs_stat(lazypath) then setup(); return end

vim.notify("Bootstrapping lazy.nvim in background...", vim.log.levels.INFO)

local lazyrepo = "https://github.com/folke/lazy.nvim.git"
vim.system({
  "git",
  "clone",
  "--filter=blob:none",
  "--branch=stable",
  lazyrepo,
  lazypath,
}, {text = true},
function(obj)
  vim.schedule(function()
    if obj.code == 0 then
      vim.notify("lazy.nvim ready! Setting up...", vim.log.levels.INFO)
      setup()
    else
      vim.notify("Failed to clone lazy.nvim:\n" .. (obj.stderr or ""), vim.log.levels.ERROR)
    end
  end)
end)
