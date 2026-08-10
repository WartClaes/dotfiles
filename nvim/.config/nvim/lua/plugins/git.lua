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
    'dlyongemallo/diffview-plus.nvim',
    enabled = not vim.g.vscode,
    opts = {
      use_icons = true,
      enhanced_diff_hl = true,
      hooks = {
        diff_buf_win_enter = function(bufnr, winid, ctx)
          if ctx.layout_name:match("^diff2") then
            if ctx.symbol == "a" then
              vim.opt_local.winhl = table.concat({
                "DiffAdd:DiffviewDiffAddAsDelete",
                "DiffDelete:DiffviewDiffDelete",
              }, ",")
            elseif ctx.symbol == "b" then
              vim.opt_local.winhl = table.concat({
                "DiffDelete:DiffviewDiffDelete",
              }, ",")
            end
          end
        end,
      },
      keymaps = {
        view = {
          ['q'] = "<Cmd>DiffviewClose<CR>",
        },
        file_panel = {
          ['q'] = "<Cmd>DiffviewClose<CR>",
        },
        file_history_panel = {
          ['q'] = "<Cmd>DiffviewClose<CR>",
        },
      }
    }
  },
}
