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

lspconfig.elixirls.setup {
  on_attach = on_attach,
  cmd = { '/home/mkultra/Programs/elixir-ls/language_server.sh' },
  capabilities = capabilites,
}
