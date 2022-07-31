require 'user.lsp.lsp'
require 'user.line'
require 'user.style'
require 'user.keymaps'

vim.cmd [[ autocmd BufWinLeave *.* mkview! ]]
vim.cmd [[ autocmd BufWinEnter *.* silent! loadview ]]

vim.cmd [[ autocmd BufRead,BufNewfile *.rs compiler cargo]]
vim.cmd [[ packadd termdebug ]]
