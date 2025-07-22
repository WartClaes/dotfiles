return {
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    lazy = true
  },
  {
    'echasnovski/mini.comment',
    event = 'VeryLazy',
    version = '*',
    opts = {
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring').calculate_commentstring() or vim.bo
          .commentstring
        end,
      },
    },
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
       "nvim-treesitter/nvim-treesitter",
       "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require("aerial").setup({
        layout = {
          max_width = { 40, 0.2 },
          width = nil,
          min_width = 10,
          default_direction = "float",
          placement = "window",
          resize_to_content = true,
          preserve_equality = false,
        },

        on_attach = function(bufnr)
          -- Jump forwards/backwards with '{' and '}'
          vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end

      })

      vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
    end
  },
  {
    'echasnovski/mini.surround',
    event = 'VeryLazy',
    version = '*',
    opts = {},
  },
  {
    'jinh0/eyeliner.nvim',
    event = 'VeryLazy',
    opts = {
      highlight_on_key = true,
      dim = true,
    }
  },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    version = '*',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-live-grep-args.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build =
        'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
      },
    },
    opts = {
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = { prompt_position = 'top' },
        sorting_strategy = 'ascending',
        winblend = 0,
      },
      pickers = {
        oldfiles = {
          cwd_only = true,
        },
        find_files = {
          previewer = false,
        },
        git_files = {
          previewer = false,
        },
        buffers = {
          show_all_buffers = true,
          sort_lastused = true,
          mappings = {
            i = { ['<c-d>'] = 'delete_buffer' }
          }
        },
        lsp_references = {
          show_line = false,
        }
      }
    },
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      }
    },
    config = function(_, opts)
      local telescope = require 'telescope';
      telescope.setup(opts);

      telescope.load_extension('live_grep_args');
      telescope.load_extension('fzf');
    end
  }
}
