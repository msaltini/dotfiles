set nocompatible
call plug#begin("~/.config/nvim/plugins")
 Plug 'voldikss/vim-floaterm'
 Plug 'sonph/onehalf', { 'rtp': 'vim' }
 Plug 'norcalli/nvim-colorizer.lua'
 Plug 'mhinz/vim-startify'
 Plug 'kyazdani42/nvim-web-devicons' " for file icons
 Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
 Plug 'kyazdani42/nvim-tree.lua'
 Plug 'nvim-lualine/lualine.nvim'
 Plug 'junegunn/fzf'
 Plug 'godlygeek/tabular'
 Plug 'neovim/nvim-lspconfig'
 Plug 'preservim/tagbar'
 Plug 'williamboman/mason.nvim'
 Plug 'williamboman/mason-lspconfig.nvim'
 Plug 'mrcjkb/rustaceanvim'
 " Completion Framework
 Plug 'hrsh7th/nvim-cmp'

" LSP Completion source
Plug 'hrsh7th/cmp-nvim-lsp'  

" Useful completion sources:
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-vsnip'                             
Plug 'hrsh7th/cmp-path'                              
Plug 'hrsh7th/cmp-buffer'                            
Plug 'hrsh7th/vim-vsnip'


call plug#end()

set encoding=UTF-8
set number
set relativenumber
set showmatch
set hlsearch
set tabstop=2
set shiftwidth=2
set expandtab
set noautoindent
set nosmartindent
filetype plugin on
set cursorline
"set noswapfile
set t_Co=256
"colorscheme dracula
colorscheme onehalfdark
set termguicolors

"let g:cpp_attributes_highlight = 1
"let g:cpp_member_highlight = 1
""let g:airline_theme='onehalfdark'
""let g:lightline = { 'colorscheme': 'onehalfdark' }
"let g:cpp_simple_highlight = 1
"let g:polyglot_disabled = ['sensible']

"Save b
nnoremap <C-s> :w<CR>
"Exit file and save
nnoremap <C-w> :wq<CR>
"Exit file without saving
nnoremap <C-q> :q!<CR>
"Toggle NERDTree using ctrl + n
nnoremap <C-n> :NvimTreeToggle<CR>  
"Toogle fuzzy file finder wit ctrl+f
nnoremap <C-f> :FZF<CR>
"Toggle tagbar with ctrl+t
nnoremap <C-t> :TagbarToggle<CR>
"Setup the bar line
nnoremap <C-S-\> :FloatermToggle <CR>


lua << EOF
require('lualine').setup() 
require('colorizer').setup()
require('nvim-tree').setup()
require("nvim-web-devicons")
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
  },
  ensure_installed = {
    "c",
    "cpp",
		"markdown",
    "lua",
    "python",
    "vim",
    "javascript",
    "typescript",
    "html",
    "css",
    "rust",
    "toml",
  },
  auto_install = true,
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }

}

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

require('mason').setup()
require('mason-lspconfig').setup {
  ensure_installed = {
    'pyright',
    'lua_ls',
    'rust_analyzer',
  },
}	

--require('rust-tools').setup {
--  server = {
--    on_attach = function(_, bufnr)
--      -- Hover actions
--      vim.keymap.set('n', '<C-space>', rt.hover_actions.hover_actions, { buffer = bufnr })
--      -- Code action groups
--      vim.keymap.set('n', '<Leader>a', rt.code_action_group.code_action_group, { buffer = bufnr })
--    end,
--  },
--}

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
})

vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false, border = rounded })
]])
--
---- Completion Plugin Setup
  -- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

      -- For `mini.snippets` users:
      -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
      -- insert({ body = args.body }) -- Insert at cursor
      -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
      -- require("cmp.config").set_onetime({ sources = {} })
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
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

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
)
equire("cmp_git").setup() ]]--

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
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
vim.lsp.config('pyright', {
  capabilities = capabilities
})
vim.lsp.enable('pyright')
EOF

