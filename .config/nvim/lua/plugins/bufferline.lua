local function config()
  local options = {
    mode = "tabs",
    numbers = "ordinal",

    tab_size = 17,
    max_name_length = 17,
    show_tab_indicators = false,

    show_buffer_close_icons = false,
    show_duplicate_prefix = true,

    close_command = nil,
    right_mouse_command = nil,
    left_mouse_command = nil,
    middle_mouse_command = nil,

    name_formatter = function(buf)
      return vim.fn.fnamemodify(buf.path, ":~:.")
    end
  }
  require("bufferline").setup({ options = options })
end

return {
  "akinsho/bufferline.nvim", tag = "v4.7.0",
  config = config
}

