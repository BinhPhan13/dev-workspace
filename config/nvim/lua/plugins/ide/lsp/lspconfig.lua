local function config()
  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
      vim.diagnostic.config({
        virtual_text = true,
        underline = true,
        signs = false,
      })

      local opts = { buffer = event.buf }
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<F3>", vim.lsp.buf.code_action, opts)

      vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_prev({ float = false }) end, opts)
      vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_next({ float = false }) end, opts)
      vim.keymap.set("n", "<leader>/", vim.diagnostic.open_float, opts)
    end,
  })

  vim.keymap.set("n", "<leader>lr", vim.cmd.LspRestart)
  vim.keymap.set("n", "<leader>li", vim.cmd.LspInfo)
  vim.keymap.set("n", "<leader>ld", ":LspStop")
  vim.keymap.set("n", "<leader>ls", ":LspStart")


  local lsp = require("lspconfig")
  -- Add cmp_nvim_lsp capabilities
  lsp.util.default_config.capabilities = vim.tbl_deep_extend(
    "force",
    lsp.util.default_config.capabilities,
    require("cmp_nvim_lsp").default_capabilities()
  )

  ------------------------------ LSPs ------------------------------
  local mason = require("mason-registry")

  local lsp_mapping = {}
  lsp_mapping["lua-language-server"] = "lua_ls"

  local function setup_lsp(name, opts)
    local lsp_name = lsp_mapping[name]
    if lsp_name == nil then lsp_name = name end
    if mason.is_installed(name) then lsp[lsp_name].setup(opts) end
  end

  -- basedpyright
  local opts = {
    analysis = {
      autoImportCompletions = true,
      autoSearchPaths = true,
      useLibraryCodeForTypes = true,

      typeCheckingMode = "standard",
      diagnosticMode = "openFilesOnly",
    },
  }
  local opts = { settings = { basedpyright = opts } }
  setup_lsp("basedpyright", opts)

  -- ruff
  local opts = {
    lineLength = 80,
    lint = { enable = false }
  }
  local opts = { init_options = { settings = opts } }
  setup_lsp("ruff", opts)

  -- gopls
  local opts = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  }
  local opts = { settings = opts }
  setup_lsp("gopls", opts)

end

return {
  "neovim/nvim-lspconfig",
  config = config
}

