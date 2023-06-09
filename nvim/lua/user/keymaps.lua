
vim.cmd [[ tnoremap <Esc> <C-\><C-n> ]]

vim.keymap.set({'n', 'v'}, 'H', '^', {noremap = true, silent = true})
vim.keymap.set({'n', 'v'}, 'L', '$', {noremap = true, silent = true})
vim.keymap.set({'n', 'v'}, '*', '*``', {noremap = true, silent = true})
vim.keymap.set({'n', 'v'}, '<C-l>', '<cmd>let @/=""<cr>', {noremap = true, silent = true})
vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<cr>', {noremap = true, silent = true})
vim.keymap.set('n', '<Leader><Leader>', '<cmd>HopWord<cr>', {noremap = true, silent = true})
vim.keymap.set('n', '<Leader>t', '<cmd>TroubleToggle document_diagnostics<cr>', {noremap = true, silent = true})
vim.keymap.set('n', '<Leader>r', '<cmd>RustRunnables<cr>', {noremap = true, silent = true})
vim.keymap.set('n', '<leader>do', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>d[', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>d]', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })


vim.cmd([[
  set updatetime=100
]])

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

vim.cmd([[
  au TermOpen * tnoremap <Esc> <c-\><c-n>
  au FileType fzf tunmap <Esc>
]])



vim.cmd([[command! R RustLastRun ]])
vim.cmd([[command! RCA RustCodeAction ]])
vim.cmd([[command! D RustLastDebug ]])
vim.cmd([[command! RR RustRunnables ]])
vim.cmd([[command! DD RustDebuggables ]])
vim.cmd([[command! TT Telescope treesitter  ]])
vim.cmd([[command! L LspStart ]])
vim.cmd([[command! LS LspStop ]])
vim.cmd([[command! LR LspRestart ]])
vim.cmd([[command! HM lua require("harpoon.mark").add_file() ]])
vim.cmd([[command! GG lua require("harpoon.mark").add_file() ]])
vim.cmd([[command! H lua require("harpoon.ui").toggle_quick_menu() ]])
vim.cmd([[command! G lua require("harpoon.ui").toggle_quick_menu() ]])

vim.cmd([[highlight Normal guibg=none ]])

vim.cmd([[
    cnoreabbrev W! w!
    cnoreabbrev W1 w!
    cnoreabbrev w1 w!
    cnoreabbrev Q! q!
    cnoreabbrev Q1 q!
    cnoreabbrev q1 q!
    cnoreabbrev Qa! qa!
    cnoreabbrev Qall! qall!
    cnoreabbrev Wa wa
    cnoreabbrev Wq wq
    cnoreabbrev wQ wq
    cnoreabbrev WQ wq
    cnoreabbrev wq1 wq!
    cnoreabbrev Wq1 wq!
    cnoreabbrev wQ1 wq!
    cnoreabbrev WQ1 wq!
    cnoreabbrev W w
    cnoreabbrev Q q
    cnoreabbrev Qa qa
    cnoreabbrev Qall qall
]])

