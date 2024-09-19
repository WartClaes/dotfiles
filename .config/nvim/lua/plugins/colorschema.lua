return {
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      style = 'storm',
      styles = {
        floats = 'normal',
        keywords = { italic = false },
      },
      lualine_bold = true,
    },
    config = function(_, opts)
      require('tokyonight').setup(opts)
      -- vim.cmd('colorscheme tokyonight')
    end
  },
  {
    'Rigellute/shades-of-purple.vim',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd('colorscheme shades_of_purple')
    end
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme duskfox')
    end
  },
  {
    'liuchengxu/space-vim-dark',
    lazy = false,
    priority = 1000,
    config = function()
      -- vim.cmd('colorscheme space-vim-dark')
    end
  }
}
