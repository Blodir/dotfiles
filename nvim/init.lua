vim.cmd [[
  call plug#begin('~/.vim/plugged')
  Plug 'rebelot/kanagawa.nvim', { 'as': 'kanagawa' }
  Plug 'navarasu/onedark.nvim'

  Plug 'nvim-telescope/telescope.nvim', {'do': ':UpdateRemotePlugins'}
  Plug 'nvim-lua/plenary.nvim'

  Plug 'williamboman/mason.nvim'
  Plug 'williamboman/mason-lspconfig.nvim'
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-path'
  Plug 'hrsh7th/cmp-cmdline'
  Plug 'hrsh7th/nvim-cmp'

  Plug 'hrsh7th/cmp-vsnip'
  Plug 'hrsh7th/vim-vsnip'

  Plug 'tpope/vim-fugitive'
  Plug 'lukas-reineke/indent-blankline.nvim'

  call plug#end()
]]

vim.cmd("cd D:\\git\\")

-- neovide
if vim.g.neovide then
  vim.o.guifont = "Consolas:h16"
  vim.opt.linespace = 0

  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5

  vim.g.neovide_scroll_animation_length = 0.1
  vim.g.neovide_cursor_animation_length = 0.02
end

-- colors
if vim.fn.has("termguicolors") == 1 then
  vim.o.termguicolors = true
end

require('onedark').setup  {
  style = 'warm', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
}

vim.cmd('colorscheme onedark')

-- line numbers
vim.o.number = true
vim.o.relativenumber = true

-- wrap
vim.o.wrap = false
vim.cmd('autocmd FileType markdown set wrap')

-- indent
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true

-- terminal
if vim.fn.has('win32') == 1 then
  vim.o.shell = 'powershell.exe'
  vim.cmd("command! Config edit C:/Users/Pyry/AppData/Local/nvim/init.lua")
end

-- misc
vim.cmd('set noautochdir')

-- keymaps
vim.api.nvim_set_keymap('n', '<F1>', ':Telescope find_files<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<F3>', ':Telescope live_grep<CR>', { noremap = true })

vim.api.nvim_set_keymap('t', '<C-w><C-w>', '<C-\\><C-n>', { noremap = true })

vim.api.nvim_set_keymap('x', '<leader>p', '\"_dP', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>p', '\"+p', { noremap = true })
vim.api.nvim_set_keymap('x', '<leader>y', '\"+y', { noremap = true })

-- keymaps - lsp
vim.api.nvim_set_keymap('n', 'gd', ':lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', ':lua vim.lsp.buf.references()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', ':lua vim.lsp.buf.hover()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Esc>', ':lua smart_esc()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[d', ':lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', ':lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F2>', ':lua vim.lsp.buf.rename()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('x', '<leader>ca', ':lua vim.lsp.buf.range_code_action()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-Space>', 'pumvisible() ? "\\<C-n>" : "\\<C-x>\\<C-o>"', { noremap = true, expr = true })

function _G.smart_esc()
    local current_win = vim.api.nvim_get_current_win()
    if vim.api.nvim_win_get_config(current_win).relative ~= "" then
        vim.api.nvim_win_close(current_win, true)
    else
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
    end
end

-- highlighting
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  ensure_installed = {
    "typescript",
    "haskell",
    "lua",
    "html",
    "rust",
    "css",
    "scss"
  },
  indent = {
    enable = true, -- enable indentation
  }
}

-- autocompletion
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- lsp

local lspconfig = require('lspconfig')

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    'tsserver',
    'hls',
    'eslint',
    'html',
    'cssls',
    'angularls',
    'rust_analyzer'
  },
  handlers = {
    function(server)
      lspconfig[server].setup({
        capabilities = lsp_capabilities,
      })
    end
  }
})

vim.diagnostic.config {
  update_in_insert = true,
}

-- telescope

require('telescope').setup{
  defaults = {
    -- Default configuration for Telescope goes here:
    -- config_key = value,
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    file_ignore_patterns = {}
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

-- indentation
require('ibl').setup {
  scope = { enabled = true }
}

