vim.cmd("colorscheme monokai")

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
vim.opt.completeopt = "menu,noinsert"

