local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({

  "nvim-lua/plenary.nvim",

  {'nvim-telescope/telescope-live-grep-args.nvim'},

  {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },


  {
   'nvim-telescope/telescope.nvim', tag = '0.1.4',
   dependencies = { 
     {'nvim-lua/plenary.nvim'},
     { 'nvim-telescope/telescope-live-grep-args.nvim' },

   },
   config = function()
     require("telescope").load_extension("live_grep_args")
   end
 },

 {
   'nvim-treesitter/nvim-treesitter',
   run = function()
     local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
     ts_update()
   end,
 },

  "terrortylor/nvim-comment"
}, opts)

 
require('nvim_comment').setup()
require('telescope').setup()
require('nvim-treesitter').setup()


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

-- lua functions
function OpenTerminalSplitView()
  vim.cmd('split')
  vim.cmd('term')
end

function AutoSwitchDirectory()
  vim.cmd('autocmd BufEnter * silent! lcd %:p:h')
end
AutoSwitchDirectory()

-- custom commands
vim.api.nvim_create_user_command('Reso', 'source $MYVIMRC', {})

vim.api.nvim_create_user_command('ST', 'lua OpenTerminalSplitView()', {})
vim.api.nvim_create_user_command('BP', "lua require'dap'.toggle_breakpoint()", {})
vim.api.nvim_create_user_command('DB', "lua require'dap'.continue()", {})
vim.api.nvim_create_user_command('DBO', "lua require'dap'.repl.open()", {})

vim.api.nvim_create_user_command('M', "make", {})
vim.api.nvim_create_user_command('MR', "make run", {})
vim.api.nvim_create_user_command('MRR', "make rrun", {})

vim.api.nvim_create_user_command('HEX', "%!xxd", {})
vim.api.nvim_create_user_command('CCA', "lua vim.opt.colorcolumn = '80'", {})
vim.api.nvim_create_user_command('CCO', "lua vim.opt.colorcolumn = '0'", {})

vim.opt.colorcolumn = "0"

-- vim.cmd([[
-- autocmd!
-- autocmd BufEnter *.m :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
-- autocmd BufFilePost *.m :lua vim.api.nvim_buf_set_option(0, "commentstring", "// %s")
-- augroup END
-- ]])


-- -- keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>")
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
vim.keymap.set('n', '<C-=>', '<C-w>+', {})
vim.keymap.set('n', '<C-->', '<C-w>-', {})
vim.keymap.set('n', '<leader>n', ':CommentToggle<CR>', {})
vim.keymap.set('v', '<leader>n', ':CommentToggle<CR>', {})
vim.keymap.set('n', 'U', '<C-r>', {})
vim.keymap.set('v', 'U', '<C-r>', {})
vim.keymap.set('n', '<leader>p', '80|bi<CR><Esc>', {})


vim.keymap.set('n', '<leader>i', "lua require'dap'.step_over()<CR>", {})
vim.keymap.set('n', '<leader>o', "lua require'dap'.step_into()<CR>", {})

vim.cmd("colorscheme torte")
-- vim.g.colors_name = "torte"
