return {
    {
        'williamboman/mason.nvim',
        build = ":MasonUpdate",
        cmd = "Mason",
        opts = {},
    },
    {
        'j-hui/fidget.nvim',
        event = 'LspAttach',
        opts = {
            notification = {
                window = {
                    winblend = 0,
                },
            },
        },
    },
    {
        'neovim/nvim-lspconfig',
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            'mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'b0o/schemastore.nvim',
            'yioneko/nvim-vtsls',
        },
        config = function()
            local vstlsLanguageSettings = {
                updateImportsOnFileMove = { enabled = "always" },
                suggest = {
                    completeFunctionCalls = true,
                },
                inlayHints = {
                    enumMemberValues = { enabled = true },
                    functionLikeReturnTypes = { enabled = true },
                    parameterNames = { enabled = "literals" },
                    parameterTypes = { enabled = true },
                    propertyDeclarationTypes = { enabled = true },
                    variableTypes = { enabled = false },
                },
            }

            local servers = {
                eslint = {},
                jsonls = {
                    settings = {
                        json = {
                            schemas = require('schemastore').json.schemas(),
                            validate = { enable = true },
                        },
                    },
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            hint = {
                                enable = true,
                            },
                            workspace = { checkThirdParty = false },
                            format = {
                                enable = true,
                                defaultConfig = {
                                    indent_style = "space",
                                    indent_size = "4",
                                }
                            },
                            diagnostics = {
                                globals = { 'vim' }
                            }
                        }
                    }
                },
                harper_ls = {},
                templ = {},
                vimls = {},
                vtsls = {
                    settings = {
                        complete_function_calls = true,
                        vtsls = {
                            enableMoveToFileCodeAction = true,
                            autoUseWorkspaceTsdk = true,
                            experimental = {
                                completion = {
                                    enableServerSideFuzzyMatch = true,
                                },
                            },
                        },
                        typescript = vstlsLanguageSettings,
                        javascript = vstlsLanguageSettings,
                    },
                },
                yamlls = {},
            }

            require('mason').setup({})

            require('mason-lspconfig').setup({
                ensure_installed = vim.tbl_keys(servers),
            })

            for server_name, server_settings in pairs(servers) do
                vim.lsp.config(server_name, server_settings)
                vim.lsp.enable(server_name)
            end

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp_native_completion', { clear = true }),
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client then
                        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
                    end
                end,
            })

            -- remove vim.lsp.config defaults
            vim.keymap.del('n', 'gra')
            vim.keymap.del('n', 'gri')
            vim.keymap.del('n', 'grn')
            vim.keymap.del('n', 'grr')

            local keyBindOpts = { noremap = true, silent = true }

            local function with_desc(desc)
                return vim.tbl_extend('force', keyBindOpts, { desc = desc })
            end

            vim.keymap.set('n', 'gl', vim.diagnostic.open_float, with_desc('Show inline diagnostics'))
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, with_desc('Go to declaration'))
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, with_desc('Go to definition'))
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, with_desc('Show hover'))
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, with_desc('Go to implementation'))
            vim.keymap.set({ 'n', 'i' }, '<c-s>', vim.lsp.buf.signature_help, with_desc('Show signature help'))
            local function code_action_with_diags()
                local bufnr = vim.api.nvim_get_current_buf()
                local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
                local diags = vim.diagnostic.get(bufnr, { lnum = lnum })
                local lsp_diags = vim.tbl_map(function(d)
                    return {
                        range = {
                            start = { line = d.lnum, character = d.col },
                            ['end'] = { line = d.end_lnum or d.lnum, character = d.end_col or d.col },
                        },
                        severity = d.severity,
                        message = d.message,
                        source = d.source,
                        code = d.code,
                        data = d.user_data and d.user_data.lsp or nil,
                    }
                end, diags)
                vim.lsp.buf.code_action({ context = { diagnostics = lsp_diags } })
            end
            vim.keymap.set('n', '<leader>ca', code_action_with_diags, with_desc('Show code actions'))
            vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, with_desc('Add workspace folder'))
            vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, with_desc('Remove workspace folder'))
            vim.keymap.set('n', '<leader>wl', function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end, with_desc('List workspace folders'))
            vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, with_desc('Rename symbol'))
            vim.keymap.set('n', 'g.', code_action_with_diags, with_desc('Code action'))
            vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, with_desc('Show references'))
        end
    },
}
