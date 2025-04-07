return {
  { 'echasnovski/mini.nvim', version = false },
  { 'nvim-tree/nvim-web-devicons', version = false },
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    version = '*',
    init = function()
      local wk = require('which-key')

      wk.add({
        -- buffers
        { '<leader>b',  group = 'Buffer' },
        { '<leader>bd', '<cmd>bd<cr>',                                  desc = 'Delete buffer' },
        { '<leader>bn', '<cmd>bn<cr>',                                  desc = 'Next buffer' },
        { '<leader>bp', '<cmd>bp<cr>',                                  desc = 'Previous buffer' },
        { '<leader>br', '<cmd>Telescope buffers<cr>',                   desc = 'Open recent buffer' },
        { '<leader>bs', '<cmd>Telescope current_buffer_fuzzy_find<cr>', desc = 'Search buffer' },
        { '[b',         '<cmd>bprev<cr>',                               desc = 'Previous buffer' },
        { '[B',         '<cmd>bfirst<cr>',                              desc = 'First buffer' },
        { ']b',         '<cmd>bnext<cr>',                               desc = 'Next buffer' },
        { ']B',         '<cmd>blast<cr>',                               desc = 'Last buffer' },


        -- files
        { '<leader>f',  group = 'File' },
        { '<leader>fb', '<cmd>Telescope buffers<cr>',                   desc = 'Open buffer' },
        { '<leader>fd', '<cmd>Telescope diagnostics<cr>',               desc = 'Search diagnostics' },
        { '<leader>ff', '<cmd>Telescope find_files<cr>',                desc = '[F]ind [F]iles' },
        { '<leader>fg', '<cmd>Telescope git_files<cr>',                 desc = '[F]ind [G]it files' },
        { '<leader>fh', '<cmd>Telescope help_tags<cr>',                 desc = '[F]ind [H]elp' },
        { '<leader>fr', '<cmd>Telescope oldfiles<cr>',                  desc = '[F]ind [R]ecent files' },
        { '<leader>fs', '<cmd>Telescope live_grep_args<cr>',            desc = 'Search string' },
        { '<leader>fw', '<cmd>Telescope grep_string<cr>',               desc = 'Search word under cursor' },

        { '<leader>lt', '<cmd>TodoTelescope<cr>',                       desc = 'Show Todos' },
        {
          '<leader>fw',
          function()
            local live_grep_args_shortcuts = require("telescope-live-grep-args.shortcuts")
            live_grep_args_shortcuts.grep_visual_selection()
          end,
          desc = 'Search visual selection',
          mode = 'v'
        },
        {
          '<leader>fS',
          function()
            require('telescope.builtin').grep_string({
              shorten_path = true,
              word_match = "-w",
              only_sort_text = true,
              search = ''
            })
          end,
          desc = '[F]uzzy [S]earch words',
        },
        -- { '<leader>fS', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', desc = 'Search symbol' },

        -- harpoon
        { '<leader>h',  group = 'Harpoon' },
        { '[h',         function() require('harpoon.ui').nav_prev() end,         desc = 'Previous harpoon mark' },
        { ']h',         function() require('harpoon.ui').nav_next() end,         desc = 'Next harpoon mark' },

        -- packages
        { '<leader>p',  group = 'Packages' },
        { '<leader>ps', function() require('package-info').show() end,           desc = 'Show dependency versions' },
        { '<leader>pc', function() require('package-info').hide() end,           desc = 'Hide dependency versions' },
        { '<leader>pt', function() require('package-info').toggle() end,         desc = 'Toggle dependency versions' },
        { '<leader>pu', function() require('package-info').update() end,         desc = 'Update dependency on the line' },
        { '<leader>pd', function() require('package-info').delete() end,         desc = 'Delete dependency on the line' },
        { '<leader>pi', function() require('package-info').install() end,        desc = 'Install a new dependency' },
        { '<leader>pp', function() require('package-info').change_version() end, desc = 'Install a different version' },
      })
    end,
    opts = {
      preset = 'modern'
    }
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    keys = {
      { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { title = "Keys", section = "keys", icon = " ", padding = 1, indent = 2 },
          { title = "Projects", section = "projects", icon = " ", padding = 1, indent = 2 },
          { section = "startup" },
          {
            pane = 2,
            section = "terminal",
            cmd = "chafa ~/clippy.png --format symbols --symbols vhalf --size 50x50; sleep .5",
            height = 20,
            padding = 1,
          },
          -- {
          --   section = "terminal",
          --   cmd = "pokemon-colorscripts -r 1 --no-title; sleep .5",
          --   random = 10,
          --   pane = 2,
          --   indent = 4,
          --   height = 30,
          -- },
        },
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command
        end,
      })
    end,
    config = function(_, opts)
      require("snacks").setup(opts)
    end,
  },
  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy", -- Or `LspAttach`
    priority = 1000, -- needs to be loaded in first
    config = function()
      require('tiny-inline-diagnostic').setup()
    end
  }
}
