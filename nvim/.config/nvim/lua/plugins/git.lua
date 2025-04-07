return {
  {
    "tpope/vim-fugitive",
    opt = true,
    cmd = {
      "G", "Git", "Gdiffsplit", "Gvdiffsplit", "Gedit", "Gsplit",
      "Gread", "Gwrite", "Ggrep", "Glgrep", "Gmove",
      "Gdelete", "Gremove", "GBrowse",
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    version = '*',
    opts = {},
  },
  {
    'sindrets/diffview.nvim',
    event = 'VeryLazy',
    dependencies = 'nvim-lua/plenary.nvim',
    opts = {
      use_icons = true,
      enhanced_diff_hl = true,
      keymaps = {
        file_panel = {
          ['q'] = "<Cmd>DiffviewClose<CR>",
        },
      }
    }
  },
}
