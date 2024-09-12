local function config()
  local mason = require("mason")
  local masonlsp = require("mason-lspconfig")

  mason.setup({
    ui = {
      icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗",
      },
    },
  })

  masonlsp.setup({
    ensure_installed = {
      "basedpyright",
      "ruff",
    },
  })
end

return {
  {"williamboman/mason-lspconfig.nvim", tag = "v1.30.0"},
  {
    "williamboman/mason.nvim", tag = "v1.10.0",
    config = config
  },
}

