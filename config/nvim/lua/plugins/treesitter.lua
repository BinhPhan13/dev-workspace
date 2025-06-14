local function config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      -- MUST installed
      "markdown_inline",
      "markdown",
      "query",
      "vimdoc",
      "vim",
      "lua",
      "c",

      "python",
      "sql",
      "go",
    },
    sync_install = false,
    auto_install = false,

    -- HIGHLIGHT config
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,

      -- disable for large files
      disable = function(lang, buf)
        local maxsize = 300 * 1024 -- 300 KB
        local ok, stats = pcall(
          (vim.uv or vim.loop).fs_stat,
          vim.api.nvim_buf_get_name(buf)
        )
        return ok and stats and stats.size > maxsize
      end
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-s>",
        node_incremental = "<C-s>",
        scope_incremental = false,
        node_decremental = "<BS>",
      }
    },
  })
end

return {
  "nvim-treesitter/nvim-treesitter",
  enable = false,
  build = ":TSUpdate",
  config = config,
}

