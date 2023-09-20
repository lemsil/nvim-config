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

vim.g.netrw_liststyle = 3

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
-- vim.keymap.set('n', '<C-w>', ':tabclose<CR>', {})
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
vim.keymap.set('n', '<leader>c', '^<C-v>', {})

-- plugins
require('plugins')
-- require('lualine').setup()
require('telescope').load_extension('fzf')
require'nvim-treesitter'.setup()

-- Comments
-- require('nvim_comment').setup()

-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
  -- bg       = '#202328',
  bg       = '#182638',
  -- bg       = '#222222',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    -- local filepath = vim.fn.expand('%:p:h')
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {
      {
        -- 'filename',
        -- show_filename_only = false,
        -- path = 1,
      }
    },
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {
      {
        -- 'filename',
        -- show_filename_only = false,
        -- path = 1
      }
    },
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    -- return '▊'
    return ''
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
  -- mode component
  function()
    --       ⏾    ██ ☺@
    -- return ' #####'
    -- return ' ██'
    -- return ' ░▒▓▒░'
    -- return '▓▒░'
    -- return ' ░░'
    return ''
    -- return ' ░▒░'
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 0 },
}

-- ins_left {
--   -- filesize component
--   'filesize',
--   cond = conditions.buffer_not_empty,
-- }

ins_left {
  'filename',
  path = 1,
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  -- symbols = { error = ' ', warn = ' ', info = ' ' },
  symbols = { error = 'X ', warn = '‼ ', info = '! ', hint = '» ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

ins_right {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  -- icon = 'LSP:',
  icon = '',
  -- color = { fg = '#444444', gui = 'bold' },
  -- color = { fg = '#444444' },
  color = { fg = '#555555' },
}

-- Add components to right sections
-- ins_right {
--   'o:encoding', -- option component same as &encoding in viml
--   fmt = string.upper, -- I'm not sure why it's upper case either ;)
--   cond = conditions.hide_in_width,
--   color = { fg = colors.green, gui = 'bold' },
-- }

-- ins_right {
--   'fileformat',
--   fmt = string.upper,
--   icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
--   color = { fg = colors.green, gui = 'bold' },
-- }

ins_right {
  'branch',
  -- '╬',
  -- icon = '->',
  icon = '',
  color = { fg = colors.violet },
}

ins_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  --  柳   ≈
  symbols = { added = '+ ', modified = ' ≡ ', removed = ' - ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_right {
  function()
    -- return '▊'
    return ''
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

-- Now don't forget to initialize lualine
lualine.setup(config)

-- make packer do a update and compile whenever plugins.lua is changed to update the plugins
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- colorscheme
-- vim.cmd [[colorscheme nightfly]]
vim.cmd("colorscheme tokyonight-night")

