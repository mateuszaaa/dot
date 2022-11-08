-- ensure the packer plugin manager is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")
  -- Collection of common configurations for the Nvim LSP client
  use("neovim/nvim-lspconfig")
  -- Autocompletion framework
  use("hrsh7th/nvim-cmp")
  use({
    -- cmp LSP completion
    "hrsh7th/cmp-nvim-lsp",
    -- cmp Snippet completion
    "hrsh7th/cmp-vsnip",
    -- cmp Path completion
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    after = { "hrsh7th/nvim-cmp" },
    requires = { "hrsh7th/nvim-cmp" },
  })
  use('hrsh7th/vim-vsnip')

  -- Adds extra functionality over rust analyzer
  use("simrat39/rust-tools.nvim")

  -- Optional
  use("nvim-lua/popup.nvim")
  use("nvim-lua/plenary.nvim")
  use("nvim-telescope/telescope.nvim")
  use("mfussenegger/nvim-dap")

  -- Fuzzy Finder
  use {"junegunn/fzf", run = ":call fzf#install()" }
  use {"junegunn/fzf.vim" }

  -- Statusline
  use("nvim-lualine/lualine.nvim")
  use("nvim-lua/lsp-status.nvim")
  -- tab or space
  use("tpope/vim-sleuth")

  use("dominikduda/vim_current_word")
  use("machakann/vim-highlightedyank")
  use("phaazon/hop.nvim")

  use("tpope/vim-fugitive")
  use("airblade/vim-gitgutter")

  use("tomtom/tcomment_vim")

  use("tanvirtin/monokai.nvim")

  -- treesitter
  use("nvim-treesitter/nvim-treesitter")
  use("p00f/nvim-ts-rainbow")
  use("windwp/nvim-autopairs")

  use("ruanyl/vim-gh-line")

  -- Lua
  use { "folke/trouble.nvim",
  requires = "kyazdani42/nvim-web-devicons",
  config = function()
    require("trouble").setup {
      -- your configuration comes here
    }
  end
}

end)

-- the first run will install packer and our plugins
if packer_bootstrap then
  require("packer").sync()
  return
end

require('user.config')
