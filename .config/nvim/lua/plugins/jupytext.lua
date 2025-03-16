local function config()
  if vim.fn.executable("jupytext") == 0 then return end
  require("jupytext").setup {
    style = "hydrogen",
    output_extension = "py",
    force_ft = "python"
  }
end

return {
  "GCBallesteros/jupytext.nvim",
  config = config
}

