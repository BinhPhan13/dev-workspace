return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>F",
      function() require("conform").format({ async = true }) end,
      mode = "n",
    },
  },
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      -- lua = { "stylua" },
      -- python = { "isort", "black" },
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
      sh = { "shfmt" },
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- format_on_save = { timeout_ms = 3000 },

    formatters = {
      shfmt = {
        append_args = { "-i", "2", "-ci" },
      },
    },
  },
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}

