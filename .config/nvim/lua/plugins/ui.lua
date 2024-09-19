return {
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    version = '*',
    init = function()
      local wk = require('which-key')

      wk.register({
        b = {
          name = 'Buffer',
          d = { '<cmd>bd<cr>', 'Delete buffer' },
          n = { '<cmd>bn<cr>', 'Next buffer' },
          p = { '<cmd>bp<cr>', 'Previous buffer' },
          r = { '<cmd>Telescope buffers<cr>', 'Open recent buffer' },
          s = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Search buffer' },
        },
        f = {
          name = 'File',
          b = { '<cmd>Telescope buffers<cr>', 'Open buffers' },
          d = { '<cmd>Telescope diagnostics<cr>', 'Search diagnostics' },
          f = { '<cmd>Telescope find_files<cr>', '[F]ind [F]iles' },
          g = { '<cmd>Telescope git_files<cr>', '[F]ind [G]it files' },
          r = { '<cmd>Telescope oldfiles<cr>', '[F]ind [R]ecent files' },
          S = { '<cmd>Telescope live_grep_args<cr>', 'Search string' },
          s = {
            function()
              require('telescope.builtin').grep_string({
                shorten_path = true,
                word_match = "-w",
                only_sort_text = true,
                search = ''
              }) end, '[F]uzzy [S]earch words',
            },
            w = { '<cmd>Telescope grep_string<cr>', 'Search word under cursor' },
          },
          h = { name = 'Harpoon' },
          p = {
            name = 'Packages',
            s = { function() require('package-info').show() end, 'Show dependency versions' },
            c = { function() require('package-info').hide() end, 'Hide dependency versions' },
            t = { function() require('package-info').toggle() end, 'Toggle dependency versions' },
            u = { function() require('package-info').update() end, 'Update dependency on the line' },
            d = { function() require('package-info').delete() end, 'Delete dependency on the line' },
            i = { function() require('package-info').install() end, 'Install a new dependency' },
            p = { function() require('package-info').change_version() end, 'Install a different version' },
          },
        }, { prefix = '<leader>' })

        wk.register({
          B = { '<cmd>bfirst<cr>', 'First buffer' },
          b = { '<cmd>bprev<cr>', 'Previous buffer' },
          h = { function() require('harpoon.ui').nav_prev() end, 'Previous harpoon mark' },
        }, { prefix = '[' })

        wk.register({
          B = { '<cmd>blast<cr>', 'Last buffer' },
          b = { '<cmd>bnext<cr>', 'Next buffer' },
          h = { function() require('harpoon.ui').nav_next() end, 'Next harpoon mark' },
        }, { prefix = ']' })
      end,
      opts = {}
    },
  }
