local lsp = require('lsp-zero').preset({})
lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
end)

lsp.ensure_installed({
  'tsserver',
  -- 'pylsp',
  'rust_analyzer'
})
lsp.skip_server_setup({'rust_analyzer'})
lsp.setup()

local path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/packages/codelldb/extension/")
local codelldb_path = path .. "adapter/codelldb"
local liblldb_path = path .. "lldb/lib/liblldb.so"

local rust_tools = require('rust-tools')
rust_tools.setup({
  server = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          enable = false,
          command = "check",
          extraArgs = {},
        },
        procMacro = { enable = true },
        diagnostics = {
          enable = true,
          disabled = {"unresolved", "unresolved-proc-macro", "unresolved-macro-call"},
          enableExperimental = true,
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
      },
    },
    on_attach = function()
      -- vim.keymap.set('n', '<leader>ca', rust_tools.hover_actions.hover_actions, {buffer = bufnr})
    end,
    dap = {
      adatper = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path)
    }
  }
})


local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-j>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-X><C-O>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp_signature_help' },
    { name = "nvim_lsp" },
    -- { name = "vsnip" },
    -- { name = "path" },
  }
  ),
})
