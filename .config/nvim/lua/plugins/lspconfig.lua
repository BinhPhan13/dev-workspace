local function config()
  vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(event)
      local opts = { buffer = event.buf }

      vim.diagnostic.config({
        virtual_text = false,
        underline = true,
        signs = false,
      })

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


  local lsp = require("lspconfig")
  -- Add cmp_nvim_lsp capabilities
  lsp.util.default_config.capabilities = vim.tbl_deep_extend(
    "force",
    lsp.util.default_config.capabilities,
    require("cmp_nvim_lsp").default_capabilities()
  )

  ------------------------------ LSPs ------------------------------
  local mason = require("mason-registry")
  local function setup_lsp(name, opts)
    if mason.is_installed(name) then lsp[name].setup(opts) end
  end

  -- basedpyright
  local opts = {
    analysis = {
      autoImportCompletions = true,
      autoSearchPaths = true,
      useLibraryCodeForTypes = true,
    },
  }
  local opts = { settings = { basedpyright = opts }, autostart = false }
  setup_lsp("basedpyright", opts)

  -- ruff
  local opts = {
    lineLength = 80,
    lint = { enable = false }
  }
  local opts = { init_options = { settings = opts } }
  setup_lsp("ruff", opts)

end

return {
  "neovim/nvim-lspconfig", tag = "v0.1.8",
  config = config
}

