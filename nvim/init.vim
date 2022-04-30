call plug#begin()

" RUST SUPPORT
Plug 'tpope/vim-fugitive'
Plug 'timonv/vim-cargo'
Plug 'sheerun/vim-polyglot'

" LSP basic tweaking
Plug 'neovim/nvim-lspconfig'
" Plug 'simrat39/rust-tools.nvim'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'


Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'              " find files

" utils
Plug 'tpope/vim-sleuth'              " tabs or spaces
Plug 'inkarkat/vim-ingo-library'
Plug 'inkarkat/vim-mark'             " multimark
Plug 'nvim-telescope/telescope.nvim' " octo dependency
Plug 'kyazdani42/nvim-web-devicons'
Plug 'pwntester/octo.nvim'           " github support
Plug 'dominikduda/vim_current_word'  " highlight current word
Plug 'phaazon/hop.nvim'		     " easy motion
Plug 'airblade/vim-gitgutter'	     " modified lines indicator
Plug 'tomtom/tcomment_vim'           " multilanguage comments support
Plug 'machakann/vim-highlightedyank' " highlihgt yanked text
Plug 'tpope/vim-fugitive'            " git support

" Syntactic language support
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'stephpy/vim-yaml'

" Styling
Plug 'tanvirtin/monokai.nvim'        " modern monokai style
Plug 'itchyny/lightline.vim'         " status line


" Debugging (needs plenary from above as well)
Plug 'mfussenegger/nvim-dap'

Plug 'ruanyl/vim-gh-line'



call plug#end()

colorscheme monokai
set termguicolors
"
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'cocstatus'] ]
      \ },
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \   'cocstatus': 'LspStatus',
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ "theme" : "tokyonight",
      \ }
function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

if executable('rg')
	set grepprg=rg\ --no-heading\ --vimgrep
	set grepformat=%f:%l:%c:%m
endif


syntax enable
filetype plugin indent on
set nomousefocus
set tabpagemax=100
set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set smarttab
set ignorecase
set smartcase
set number
set list listchars=tab:▸\ ,trail:·,precedes:←,extends:→,eol:↲,nbsp:␣

"open editor in last place
if has("autocmd")
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
\| exe "normal! g'\"" | endif
endif

"configuration edit shortcuts
nnoremap <Leader>ve :e ~/.config/nvim/init.vim<CR>
nnoremap <Leader>vs :source ~/.config/nvim/init.vim<CR>
map H ^
map L $

packadd termdebug
let g:cargo_command="/home/dev/.cargo/bin/cargo"
compiler cargo

set updatetime=2000

" Statusline
function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif
  return ''
endfunction

" autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', enabled = {"ChainingHint", "TypeHint", "ParameterHint"} }
"autocmd BufEnter * lua require'completion'.on_attach()


let g:completion_matching_ignore_case = 0
let g:completion_enable_auto_signature = 0 
let g:completion_enable_auto_popup = 1 
let g:mwDefaultHighlightingPalette = 'maximum'
set completeopt=menu,noinsert,noselect

" auto formatting
" autocmd BufWritePre *.ts LspFormat!

nnoremap <C-p> <cmd>Files<cr>
nnoremap <leader>; <cmd>Buffers<cr>
nnoremap <leader>q; lua require('lsp_extensions.workspace.diagnostic').set_qf_list()<cr>

" sign define LspDiagnosticsSignError text=
" sign define LspDiagnosticsSignWarning text=
" sign define LspDiagnosticsSignInformation text=
" sign define LspDiagnosticsSignHint text=

hi HopNextKey guifg=Red gui=bold
hi HopNextKey1 guifg=Orange gui=bold
hi HopNextKey2 guifg=Orange gui=bold
hi HopUnmatched guifg=#999999
hi CurrentWordTwins guifg=None guibg=#8CCBEA guifg=#000000 gui=underline,bold
hi CurrentWord guifg=None guibg=None gui=bold

set cursorcolumn
set cursorline
set signcolumn=auto:2

nmap <Leader>g :GitGutterToggle<cr>
nmap <Leader><Leader> :HopWord<cr>

" autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
au BufRead,BufNewFile *.md setlocal textwidth=120

function! s:format_qf_line(line)
  let parts = split(a:line, ':')
  return { 'filename': parts[0]
         \,'lnum': parts[1]
         \,'col': parts[2]
         \,'text': join(parts[3:], ':')
         \ }
endfunction

function! s:qf_to_fzf(key, line) abort
  let l:filepath = expand('#' . a:line.bufnr . ':p')
  return l:filepath . ':' . a:line.lnum . ':' . a:line.col . ':' . a:line.text
endfunction

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

lua require('lspsetup')
