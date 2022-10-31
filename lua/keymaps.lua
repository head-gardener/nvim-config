-- Picker
vim.keymap.set('n', '<Leader>pe', ':PickerEdit<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>ps', ':PickerVsplit<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>ph', ':PickerSplit<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>pb', ':PickerBuffer<CR>', { noremap = true })

-- Commentary
vim.keymap.set({ 'n', 'v' }, '<C-_>', ':Commentary<CR>', { noremap = true })

-- Splits navigation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { noremap = true })

-- Extras
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true })
vim.keymap.set('n', '<Leader>w', ':w<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>q', ':q<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>mm', ':!make<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>mt', ':!make test<CR>', { noremap = true })
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- NVim Tree
vim.keymap.set('n', '<Leader>tr', ':NvimTreeFocus<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>tt', ':NvimTreeToggle<CR>', { noremap = true })


-- LSP
local configs = require('lspconfig.configs')
local lspconfig = require('lspconfig')

local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

if not configs.lua_ls then
  configs.lua_ls = {
    default_config = {
      cmd = { 'lua-language-server' },
      root_dir = lspconfig.util.root_pattern('.git', 'init.lua'),
      filetypes = { 'lua' },
      init_options = {
        command = {},
      },
    },
  }
end

local workspace_dir = "/home/mkultra/.jdtls_workspaces/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

lspconfig.java_language_server.setup {
  on_attach = on_attach,
  cmd = {
    '/home/mkultra/Programs/jdt-eclipse-ls/bin/jdtls',
    '-data',
    workspace_dir,
  },
  capabilities = capabilites,
  root_dir = lspconfig.util.root_pattern('src'),
}

lspconfig.clangd.setup {
  on_attach = on_attach,
  cmd = { 'clangd' },
  capabilities = capabilites,
}

lspconfig.lua_ls.setup {
  on_attach = on_attach,
  cmd = { '/home/mkultra/Programs/LuaLS/bin/lua-language-server' },
  capabilities = capabilites,
}

local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        feedkey("<Plug>(vsnip-expand-or-jump)", "")
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" })
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'buffer' }
  })
})

require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "elixir", "heex", "eex", "java" },
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = {},
  },
}
