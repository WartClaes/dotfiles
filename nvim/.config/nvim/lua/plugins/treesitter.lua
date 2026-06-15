return {
    {
        'nvim-treesitter/nvim-treesitter',
        branch = 'main',
        event = { 'BufReadPost', 'BufNewFile' },
        cmd = { "TSUpdateSync" },
        build = ':TSUpdate',
        keys = {
            { "<M-Down>", desc = "Increment selection" },
            { "<M-Up>",   desc = "Decrement selection", mode = "x" },
        },
        dependencies = {
            {
                'nvim-treesitter/nvim-treesitter-context',
                config = function()
                    require 'treesitter-context'.setup {
                        enable = true,
                        max_lines = 4,
                        min_window_height = 0,
                        line_numbers = true,
                        multiline_threshold = 20,
                        trim_scope = 'outer',
                        mode = 'cursor',
                        separator = nil,
                        zindex = 20,
                        on_attach = nil,
                    }
                end,
            }
        },
        config = function()
            require('nvim-treesitter').install({
                'lua', 'rust', 'typescript', 'vim', 'vimdoc', 'markdown', 'html', 'css', 'javascript', 'json',
            })
            vim.api.nvim_create_autocmd('FileType', {
                group = vim.api.nvim_create_augroup('treesitter.setup', {}),
                callback = function(args)
                    local buf = args.buf
                    local filetype = args.match
                    local language = vim.treesitter.language.get_lang(filetype) or filetype
                    if not vim.treesitter.language.add(language) then
                        local known = require('nvim-treesitter.parsers')
                        if known[language] then
                            require('nvim-treesitter').install({ language })
                        end
                        return
                    end
                    vim.wo.foldmethod = 'expr'
                    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    vim.treesitter.start(buf, language)
                end,
            })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        branch = 'main',
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
    },
    {
        'Wansmer/treesj',
        keys = {
            { '<leader>m', vim.cmd.TSJToggle, desc = 'Split/Join' },
        },
        opts = {
            max_join_length = 240,
            use_default_keymaps = false,
        },
    }
}
