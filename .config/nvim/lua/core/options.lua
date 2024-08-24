vim.cmd("let g:netrw_liststyle = 3")
vim.cmd("let g:loaded_matchparen = 1")
vim.cmd("colorscheme default")

local opt = vim.opt

opt.number = true
opt.relativenumber = true

-- indent
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- search
opt.wrap = true
opt.wrapscan = false
opt.incsearch = true
opt.hlsearch = true

-- case
opt.ignorecase = true
opt.smartcase = true
opt.wildignorecase = true

-- split windows
opt.splitright = true
opt.splitbelow = true

-- whitespace display
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- misc
-- opt.clipboard:append("unnamedplus")
opt.termguicolors = true
opt.cursorline = true
opt.mouse = 'a'
opt.signcolumn = "yes"
opt.scrolloff = 7
opt.inccommand = 'split'
opt.backspace = "indent,eol,start"
opt.swapfile = false

