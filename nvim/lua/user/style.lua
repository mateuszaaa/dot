vim.cmd[[ colorscheme monokai ]]

vim.opt.mousefocus=false
vim.opt.tabpagemax=100
vim.opt.backup=false
vim.opt.writebackup=false
vim.opt.swapfile=false
vim.opt.tabstop=4
vim.opt.shiftwidth=4
vim.opt.expandtab=true
vim.opt.autoindent=ture
vim.opt.smartindent=true
vim.opt.smarttab=true
vim.opt.ignorecase=true
vim.opt.smartcase=true
vim.opt.number=true
vim.opt.termguicolors=true
vim.opt.guifont="DejaVuSansMono Nerd Font:h8"

-- whitespaces
vim.opt.listchars.tabtab='▸ '
vim.opt.listchars.precedes='←'
vim.opt.listchars.extends='→'
vim.opt.listchars.eol='↲'
vim.opt.listchars.nbsp='␣'

-- colors for \\ 
vim.cmd("hi HopNextKey guifg=Red gui=bold")
vim.cmd("hi HopNextKey1 guifg=Orange gui=bold")
vim.cmd("hi HopNextKey2 guifg=Orange gui=bold")
vim.cmd("hi HopUnmatched guifg=#999999")

-- highlight currently selected word
vim.cmd("hi CurrentWordTwins guifg=None guibg=#8CCBEA guifg=#000000 gui=underline,bold")
vim.cmd("hi CurrentWord guifg=None guibg=None gui=bold")

-- view
vim.opt.cursorcolumn = true
vim.opt.cursorline = true
vim.opt.signcolumn = "auto:2"
vim.opt.completeopt = "menu,noinsert,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"
