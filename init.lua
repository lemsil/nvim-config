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
    ensure_installed = { "sumneko_lua", "tsserver", "jedi_language_server", "quick_lint_js" },
}

-- Completions


-- LSP stuff
local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
end

require'lspconfig'.sumneko_lua.setup{
  on_attach = on_attach
}
require'lspconfig'.tsserver.setup{
  on_attach = on_attach;
}
-- require'lspconfig'.jedi_language_server.setup{
-- on_attach = on_attach;
-- }
require'lspconfig'.quick_lint_js.setup{
  on_attach = on_attach;
}
require'lspconfig'.pyright.setup{
  on_attach = on_attach;
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
