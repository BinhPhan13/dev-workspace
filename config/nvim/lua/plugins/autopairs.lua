local config = function()
  local npairs = require("nvim-autopairs")
  npairs.setup({
    map_cr = true,
    map_bs = true,
    map_c_h = false,
    map_c_w = false,

    break_undo = false,
    enable_afterquote = false,
    enable_abbr = false,
  })
  npairs.clear_rules()

  local Rule = require("nvim-autopairs.rule")
  local cond = require("nvim-autopairs.conds")

  local pair = function(...)
    return Rule(...)
    :use_undo(false)
    :with_move(cond.move_right())
    :with_pair(cond.not_before_regex("[%%\\%d]"))
    :with_move(cond.not_before_regex("[%%\\]"))
  end

  npairs.add_rules({
    -- brackets
    pair('[', ']'),
    pair('{', '}'),
    pair('(', ')'),
    pair('<', '>')
    :with_pair(function(opts) return
      cond.before_regex("[^%s]")(opts)
      or cond.before_regex("^%s*$", -1)(opts)
      or cond.before_regex("^#include%s+$", -1)(opts)
    end),

    -- quotes
    pair('"', '"'),
    pair('`', '`'),
    pair("'", "'")
    :with_pair(cond.not_before_regex("[%a&]")),

    -- triple quotes
    Rule(
      '"""', '"""',
      { "python", "elixir", "julia", "kotlin", "scala", "sbt" }
    ):with_pair(cond.not_before_char('"', 3)),
    Rule(
      '""".*$', '"""',
      { "python", "elixir", "julia", "kotlin", "scala", "sbt" }
    ):use_regex(true):only_cr(),

    Rule(
      "```", "```",
      { "markdown", "vimwiki", "rmarkdown", "rmd", "pandoc", "quarto", "typst" }
    ):with_pair(cond.not_before_char('"', 3)),
    Rule(
      "```.*$", "```",
      { "markdown", "vimwiki", "rmarkdown", "rmd", "pandoc", "quarto", "typst" }
    ):use_regex(true):only_cr(),
  })
end

return {
  'windwp/nvim-autopairs',
  event = "InsertEnter",
  config = config,
}

