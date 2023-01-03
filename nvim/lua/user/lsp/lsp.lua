local nvim_lsp = require('lspconfig')
local cmp = require('cmp')


local extension_path = vim.env.HOME .. ".vscode-oss/extensions/vadimcn.vscode-lldb-1.8.1-universal/"
local codelldb_path = extension_path .. "adapter/codelldb"
local liblldb_path = extension_path .. "lldb/lib/liblldb.so"


require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust", "typescript", "javascript" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}

local on_attach = function(client, bufnr)

  -- Show diagnostic popup on cursor hover
  vim.opt.updatetime = 100
  local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
  vim.api.nvim_create_autocmd("CursorHold", {
	  callback = function()
		  vim.diagnostic.open_float(nil, { focusable = false })
	  end,
	  group = diag_float_grp,
  })

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev({ border = "single" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next({ border = "single" })<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.cmd [[ autocmd BufWritePre <buffer=bufnr> lua vim.lsp.buf.formatting_sync() ]]

end

local rt = require("rust-tools")
rt.setup({
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
	  disabled = {"unresolved", "unresolved-proc-macro"},
	  enableExperimental = true,
	},
	cargo = {
	  allFeatures = {enable = true},
	  buildScripts = {enable = false},
	},
      },
    },
    standalone = false,
    on_attach = function(_, bufnr)
      -- Hover actions
      -- vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- -- Code action groups
      -- vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })

      vim.opt.updatetime = 100
      local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
      vim.api.nvim_create_autocmd("CursorHold", {
	      callback = function()
		      vim.diagnostic.open_float(nil, { focusable = false })
	      end,
	      group = diag_float_grp,
      })
      local opts = { noremap=true, silent=true }
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev({ border = "single" })<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next({ border = "single" })<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cd', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')


      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>db', '<cmd>lua require\'dap\'.toggle_breakpoint()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dc', '<cmd>lua require\'dap\'.continue()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dO', '<cmd>lua require\'dap\'.step_out()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dn', '<cmd>lua require\'dap\'.step_into()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dN', '<cmd>lua require\'dap\'.step_over()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dd', '<cmd>lua require\'dap\'.run_last()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dg', '<cmd>lua require\'dap\'.run_to_cursor()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dC', '<cmd>lua require\'dap\'.close()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>dt', '<cmd>lua require\'dap\'.repl.open()<CR>', opts)

    --       nnoremap <silent> <F5> <Cmd>lua require'dap'.continue()<CR>
    -- nnoremap <silent> <F10> <Cmd>lua require'dap'.step_over()<CR>
    -- nnoremap <silent> <F11> <Cmd>lua require'dap'.step_into()<CR>
    -- nnoremap <silent> <F12> <Cmd>lua require'dap'.step_out()<CR>
    -- nnoremap <silent> <Leader>b <Cmd>lua require'dap'.toggle_breakpoint()<CR>
    -- nnoremap <silent> <Leader>B <Cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
    -- nnoremap <silent> <Leader>lp <Cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
    -- nnoremap <silent> <Leader>dr <Cmd>lua require'dap'.repl.open()<CR>
    -- nnoremap <silent> <Leader>dl <Cmd>lua require'dap'.run_last()<CR>

	end,
      },
      dap = {
	adatper = {
	  type = "server",
	  port = "${port}",
	  host = "127.0.0.1",
	  executable = {
	    command = "/usr/bin/lldb-vscode",
	    args = {  "--port", "${port}" },
	  },
	}
      }
    })

require("dapui").setup({})
local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

nvim_lsp.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities
  })

nvim_lsp.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities
  })

local signs = {
  { name = "DiagnosticSignError", text = "" },
  { name = "DiagnosticSignWarn", text = "" },
  { name = "DiagnosticSignHint", text = "" },
  { name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
  virtual_text = true,
  -- enables lsp_lines but we want to start disabled
  virtual_lines = false,
  -- show signs
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focus = false,
    focusable = false,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
}

vim.diagnostic.config(config)

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
--     vim.lsp.diagnostic.on_publish_diagnostics, {
--     virtual_text = true,
--     signs = true,
--     update_in_insert = true,
--   }
-- )

vim.lsp.handlers["textDocument/hover"] =
  vim.lsp.with(
  vim.lsp.handlers.hover,
  {
    border = "single"
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "single"
  }
)

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
      ["<CR>"] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp_signature_help' },
      { name = "nvim_lsp" },
      { name = "vsnip" },
      { name = "path" },
      { name = "buffer" },
    }
    ),
  })

