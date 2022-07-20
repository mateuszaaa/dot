require 'user.lsp'
require 'user.line'
require 'user.style'

vim.cmd [[ autocmd BufWinLeave *.* mkview! ]]
vim.cmd [[ autocmd BufWinEnter *.* silent! loadview ]]

vim.cmd [[ autocmd BufRead,BufNewfile *.rs compiler cargo]]
