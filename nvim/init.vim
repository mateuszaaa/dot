call plug#begin()

" RUST SUPPORT
Plug 'tpope/vim-fugitive'
Plug 'timonv/vim-cargo'
Plug 'sheerun/vim-polyglot'

" LSP basic tweaking
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/vim-vsnip'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" Debugging (needs plenary from above as well)
Plug 'mfussenegger/nvim-dap'

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
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Plug 'itchyny/lightline.vim'         " status line
Plug 'nvim-lualine/lualine.nvim'
Plug 'p00f/nvim-ts-rainbow'



Plug 'ruanyl/vim-gh-line'



call plug#end()


nmap <Leader><Leader> :HopWord<cr>
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

lua require('user.config')
