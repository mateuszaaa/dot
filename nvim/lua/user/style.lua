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
vim.cmd("hi HopNextKey guibg=black guifg=Red gui=bold")
vim.cmd("hi HopNextKey1 guibg=black guifg=Cyan gui=bold")
vim.cmd("hi HopNextKey2 guibg=black guifg=Orange gui=bold")
vim.cmd("hi Hopmatched guifg=#999999")
vim.cmd("hi DiffText guifg=#ffffff guibg=#FB5607")
vim.cmd("hi DiffChange guibg=#6F2783")

-- highlight currently selected word
vim.cmd("hi CurrentWordTwins guifg=None guibg=#6F2783 guifg=#000000 gui=underline,bold")
vim.cmd("hi CurrentWord guifg=None guibg=None gui=bold")

vim.cmd("hi Visual guibg=#6F2783")
vim.cmd("hi CursorLine guibg=#095D5E")
vim.cmd("hi CursorColumn guibg=#095D5E")

-- view
vim.opt.cursorcolumn = true
vim.opt.cursorline = false
vim.opt.signcolumn = "auto:2"
vim.opt.completeopt = "menu,noinsert,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"

vim.g.gitgutter_sign_added = '┃'
vim.g.gitgutter_sign_removed = '┃'
vim.g.gitgutter_sign_modified = '┃'

-- highlight GitGutterAdd    guifg=#009900 ctermfg=2
-- highlight GitGutterChange guifg=#bbbb00 ctermfg=3
-- highlight GitGutterDelete guifg=#ff2222 ctermfg=1

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
