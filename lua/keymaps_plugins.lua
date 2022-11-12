-- Picker
vim.keymap.set('n', '<Leader>pe', ':PickerEdit<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>ps', ':PickerVsplit<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>ph', ':PickerSplit<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>pb', ':PickerBuffer<CR>', { noremap = true })

-- Commentary
vim.keymap.set({ 'n', 'v' }, '<C-_>', ':Commentary<CR>', { noremap = true })

-- Zen
vim.keymap.set('n', '<Space>ze', ':ZenMode<CR>', { noremap = true })

-- Twilight
vim.keymap.set('n', '<Space>tw', ':Twilight<CR>', { noremap = true })

-- Gitsigns
vim.keymap.set('n', '<Space>hs', ':Gitsigns stage_hunk<CR>', { noremap = true })
vim.keymap.set('n', '<Space>hr', ':Gitsigns reset_hunk<CR>', { noremap = true })

-- Projectionist
vim.keymap.set('n', '<Leader>aa', ':A<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>as', ':AS<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>av', ':AV<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>at', ':AT<CR>', { noremap = true })

-- NVim Tree
vim.keymap.set('n', '<Leader>tr', ':NvimTreeFocus<CR>', { noremap = true })
vim.keymap.set('n', '<Leader>tt', ':NvimTreeToggle<CR>', { noremap = true })

require 'nvim-treesitter.configs'.setup {
  ensure_installed = { "elixir", "heex", "eex", "java" },
  sync_install = false,
  ignore_install = {},
  highlight = {
    enable = true,
    disable = {},
  },
}

local cmp = require('cmp')

cmp.setup({
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn["vsnip#available"](1) == 1 then
        vim.api.feedkey("<Plug>(vsnip-expand-or-jump)", "")
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<S-Tab>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        vim.api.feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" })
  },
})
