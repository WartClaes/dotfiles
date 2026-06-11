vim.o.autocomplete = true
vim.o.completeopt = 'menu,menuone,noinsert,noselect,fuzzy,popup'

-- Keymaps are set after VeryLazy fires so copilot.vim (lazy=false) can't overwrite them.
-- copilot.vim sets its own <Tab> mapping during its config, which runs before VeryLazy.
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  once = true,
  callback = function()
    vim.keymap.set('i', '<Tab>', function()
      return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
    end, { expr = true, silent = true })

    vim.keymap.set('i', '<S-Tab>', function()
      return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
    end, { expr = true, silent = true })

    vim.keymap.set('i', '<CR>', function()
      if vim.fn.pumvisible() == 1 and vim.fn.complete_info()['selected'] ~= -1 then
        return '<C-y>'
      end
      return '<CR>'
    end, { expr = true, silent = true })

    vim.keymap.set('i', '<C-Space>', '<C-x><C-o>', { silent = true })
  end,
})

return {
  {
    'github/copilot.vim',
    lazy = false,
    config = function()
      vim.g.copilot_enabled = false
      vim.g.copilot_no_tab_map = true

      vim.keymap.set('n', '<leader>ce', ':Copilot enable<CR>')
      vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>')

      vim.keymap.set('i', '<M-j>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })

      vim.keymap.set('i', '<M-l>', '<Plug>(copilot-accept-word)')

      vim.g.copilot_filetypes = {
        gitcommit = true
      }
    end
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "stevearc/dressing.nvim",
    },
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
    },
    opts = {
      strategies = {
        chat = { adapter = "anthropic" },
        inline = { adapter = "anthropic" },
        agent = { adapter = "anthropic" },
      }
    },
  },
  {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    opts = {},
  },
}
