-- options
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.opt.clipboard = "unnamedplus"

vim.opt.ignorecase = true

vim.opt.termguicolors = true
vim.opt.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'


-- keymaps
vim.g.mapleader = ' '

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})


-- plugins
require('plugins')
-- require('lualine').setup()
require('telescope').load_extension('fzf')
require'nvim-treesitter'.setup()
require("mason").setup()
require("mason-lspconfig").setup {
    ensure_installed = { "sumneko_lua", "tsserver", "pylsp", "quick_lint_js" },
}


-- Completions
local cmp = require'cmp'
  cmp.setup({
    snippet = {
      -- Specifying he required snippet engine
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-a>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }
    },
    {
      { name = 'buffer' },
    })
  })

require("luasnip.loaders.from_vscode").lazy_load()

-- LSP stuff
local capabilities = require('cmp_nvim_lsp').default_capabilities()

  require('lspconfig')['sumneko_lua'].setup {
  }

local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
end

require'lspconfig'.sumneko_lua.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  -- get the lsp to recognize the vim global variable
  settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
}
require'lspconfig'.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
require'lspconfig'.quick_lint_js.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
require'lspconfig'.pylsp.setup{
  on_attach = on_attach,
  capabilities = capabilities
}

-- make packer do a update and compile whenever plugins.lua is changed to update the plugins
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- colorscheme
vim.cmd [[colorscheme nightfly]]
