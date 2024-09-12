vim.g.netrw_liststyle = 0
vim.g.loaded_matchparen = 1

local opt = vim.opt

-- number
opt.number = true
opt.relativenumber = true

-- indent
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- search
opt.wrap = false
opt.wrapscan = true
opt.incsearch = true
opt.hlsearch = false

-- case
opt.ignorecase = true
opt.smartcase = true
opt.wildignorecase = true

-- split windows
opt.splitright = true
opt.splitbelow = true

-- whitespace display
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- misc
opt.termguicolors = true
opt.mouse = "a"
opt.guicursor = ""
opt.scrolloff = 3
opt.inccommand = "nosplit"
opt.backspace = "indent,eol,start"
opt.swapfile = false
opt.timeoutlen = 3000

