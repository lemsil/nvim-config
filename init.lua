-- options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.signcolumn = "number"
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.termguicolors = true
vim.opt.guicursor = 'n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'
vim.g.mapleader = ' '

-- make tree style the default netrw style
vim.g.netrw_liststyle = 3

-- custom commands
vim.api.nvim_create_user_command('Reso', 'source "$MYVIMRC"', {})

-- keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<C-y>', '<C-y>k', {})
vim.keymap.set('n', '<C-e>', '<C-e>j', {})
vim.keymap.set('n', '<leader>e', ':Ex<CR>', {})
vim.keymap.set('n', '<leader>E', ':tabnew<CR>:Ex<CR>', {})
vim.keymap.set('n', '{', ':-tabnext<CR>', {})
vim.keymap.set('n', '}', ':tabnext<CR>', {})
vim.keymap.set('n', '<leader>t', ':tabnew<CR>:Ex<CR>', {})
vim.keymap.set('n', '<leader>w', ':tabclose<CR>', {})
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", {})
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", {})
vim.keymap.set('t', '<leader><Esc>', '<C-\\><C-n>', {})
vim.keymap.set('t', '<C-w>', '<C-\\><C-n><C-w>', {})
vim.keymap.set('n', '<leader>v', ':vsplit<CR>', {})
vim.keymap.set('n', '<leader>s', ':split<CR>', {})
vim.keymap.set('n', '<leader>j', '<C-w>j', {})
vim.keymap.set('n', '<leader>k', '<C-w>k', {})
vim.keymap.set('n', '<leader>h', '<C-w>h', {})
vim.keymap.set('n', '<leader>l', '<C-w>l', {})

-- plugins
require('plugins')
require('lualine').setup()
require('telescope').load_extension('fzf')
-- require'nvim-treesitter'.setup()

-- comments
require('nvim_comment').setup()

-- make packer do a update and compile whenever plugins.lua is changed to update the plugins
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- colorscheme
vim.cmd("colorscheme tokyonight-night")
