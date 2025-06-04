return {
  'neovim/nvim-lspconfig',
  config = function()
    vim.diagnostic.config({
      virtual_text = true,
      underline = true,
      signs = false,
    })
    vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev({ float = false }) end)
    vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next({ float = false }) end)
    vim.keymap.set("n", "g/", vim.diagnostic.open_float)

    vim.keymap.set("n", "<leader>lr", vim.cmd.LspRestart)
    vim.keymap.set("n", "<leader>li", vim.cmd.LspInfo)
    vim.keymap.set("n", "<leader>ld", ":LspStop")
    vim.keymap.set("n", "<leader>ls", ":LspStart")

    vim.lsp.enable({
      'basedpyright',
      'ruff',
    })
  end
}

