return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Telescope and stuff required for telescope
  use "nvim-lua/plenary.nvim"

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { 
      {'nvim-lua/plenary.nvim'},
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
    },
    config = function()
      require("telescope").load_extension("live_grep_args")
    end
  }

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  -- Commenting
  use "terrortylor/nvim-comment"
  require('nvim_comment').setup()

  -- THEME
  -- use {
  -- 'nvim-lualine/lualine.nvim',
  -- requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  -- }

  use 'bluz71/vim-nightfly-colors'

  use "EdenEast/nightfox.nvim"

  use 'folke/tokyonight.nvim'

  -- Debugging
  use 'mfussenegger/nvim-dap'

end)

