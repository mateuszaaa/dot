-- ensure the packer plugin manager is installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    -- vim.cmd("[[packadd packer.nvim]]")
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

require("packer").startup(function(use)
  -- Packer can manage itself
  use("wbthomason/packer.nvim")

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'},
      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'L3MON4D3/LuaSnip'},
      -- Rust tools for RustRunnables & RustDebuggables
      { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }
    }
  }

  -- Adds extra functionality over rust analyzer
  use("nvim-lua/popup.nvim")
  use {
  'nvim-telescope/telescope-ui-select.nvim',
  requires = { "nvim-telescope/telescope.nvim" },
  config = function ()
    require("telescope").setup {
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown {}
        }
      }
    }
    require("telescope").load_extension("ui-select")
  end
  }
  use { "simrat39/rust-tools.nvim"}

  
  -- Fuzzy Finder
  use {"junegunn/fzf", run = ":call fzf#install()" }
  use {"junegunn/fzf.vim" }
  
  -- Statusline
  use("nvim-lualine/lualine.nvim")
  -- tab or space
  use("tpope/vim-sleuth")
  
  use("dominikduda/vim_current_word")
  use("machakann/vim-highlightedyank")
  use({
    "phaazon/hop.nvim",
    config = function()
      require("hop").setup()
    end
  })
  
  use("tpope/vim-fugitive")
  use("airblade/vim-gitgutter")
  use("tomtom/tcomment_vim")
  use("tanvirtin/monokai.nvim")
  
  -- treesitter
  use("nvim-treesitter/nvim-treesitter")
  use("p00f/nvim-ts-rainbow")
  use("windwp/nvim-autopairs")
  
  use("ruanyl/vim-gh-line")
  
  -- -- Lua
  -- use { "folke/trouble.nvim",
  -- requires = "kyazdani42/nvim-web-devicons",
  -- config = function()
  --   require("trouble").setup {
  --    mode = "document_diagnostics",
  --    auto_preview = false,
  --    auto_fold = false,
  --    use_diagnostic_signs = false,
  --    -- signs = {
  --    --    -- icons / text used for a diagnostic
  --    --    error = "",
  --    --    warning = "",
  --    --    hint = "",
  --    --    information = "",
  --    --    other = "﫠"
  --    --  },
  --   }
  -- end
  -- }

  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup()
    end
  })

  use {
  'pwntester/octo.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'kyazdani42/nvim-web-devicons',
  },
  config = function ()
    require"octo".setup()
  end
}

end)



-- the first run will install packer and our plugins
if packer_bootstrap then
  require("packer").sync()
  return
end

require('user.config')
