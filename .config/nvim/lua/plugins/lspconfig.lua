local function config()
  vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
      local tele = require('telescope.builtin')
      local opts = {buffer = event.buf}

      vim.diagnostic.config({
        virtual_text = false,
        underline = false,
      })

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
      vim.keymap.set('n', '<leader>fr', tele.lsp_references, opts)
      vim.keymap.set('n', 'gs', vim.lsp.buf.rename, opts)

      vim.keymap.set('n', '[d', function()
        vim.diagnostic.goto_prev({ float = false }) end, opts)
      vim.keymap.set('n', ']d', function()
        vim.diagnostic.goto_next({ float = false }) end, opts)
      vim.keymap.set('n', '<leader>?', vim.diagnostic.open_float, opts)
      vim.keymap.set('n', '<leader>fd', tele.diagnostics, opts)

      vim.keymap.set({'n', 'x'}, '<F3>', vim.lsp.buf.code_action, opts)
    end,
  })


  local lsp = require('lspconfig')
  -- Add cmp_nvim_lsp capabilities
  lsp.util.default_config.capabilities = vim.tbl_deep_extend(
    'force',
    lsp.util.default_config.capabilities,
    require('cmp_nvim_lsp').default_capabilities()
  )

  local opts = {
    analysis = {
      autoImportCompletions = true,
      autoSearchPaths = true,
      useLibraryCodeForTypes = true,
    },
  }
  lsp.basedpyright.setup{
    settings = { basedpyright = opts }
  }

  local opts = {
    lineLength = 80,
    lint = { enable = false }
  }
  lsp.ruff.setup({
    init_options = { settings = opts }
  })
end

return {
  'neovim/nvim-lspconfig', tag = 'v0.1.8',
  config = config
}

