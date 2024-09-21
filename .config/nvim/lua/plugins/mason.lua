local function config()
  require("mason").setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })
end

return {
  {
    "williamboman/mason.nvim", tag = "v1.10.0",
    config = config
  },
}

