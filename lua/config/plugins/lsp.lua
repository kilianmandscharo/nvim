return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "folke/lazydev.nvim",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            local lspconfig = require("lspconfig")

            local servers = {
                gopls = {
                    settings = {
                        gopls = {
                            semanticTokens = true,
                            hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                            },
                        }
                    }
                },
                lua_ls = {
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                library = {
                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.stdpath("config") .. "/lua"] = true,
                                },
                            },
                        },
                    },
                },
                ts_ls = {
                    server_capabilities = {
                        documentFormattingProvider = false,
                    },
                },
                tailwindcss = {},
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "off",
                            },
                        },
                    },
                },
                cssls = {},
                clangd = {},
                rust_analyzer = {},
                html = {},
                templ = {},
                eslint = {},
                htmx = {
                    filetypes = { "html", "templ" }
                },
            }

            vim.filetype.add({ extension = { templ = "templ" } })

            require("mason").setup({
                ui = {
                    border = "none",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                },
                log_level = vim.log.levels.INFO,
                max_concurrent_installers = 4,
            })

            require("mason-lspconfig").setup({
                ensure_installed = servers,
                automatic_installation = true,
            })

            local on_attach = function(client, bufnr)
                local opts = { noremap = true, silent = true }
                local keymap = vim.api.nvim_buf_set_keymap
                keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
                keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
                keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
                keymap(bufnr, "n", "gn", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
                keymap(bufnr, "n", "gp", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
                local success, illuminate = pcall(require, "illuminate")
                if not success then
                    return
                end
                illuminate.on_attach(client)
            end

            local capabilities = require('blink.cmp').get_lsp_capabilities()

            for server, server_opts in pairs(servers) do
                local opts = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                }
                opts = vim.tbl_deep_extend("force", server_opts, opts)
                lspconfig[server].setup(opts)
            end

            local signs = {
                { name = "DiagnosticSignError", text = "" },
                { name = "DiagnosticSignWarn", text = "" },
                { name = "DiagnosticSignHint", text = "" },
                { name = "DiagnosticSignInfo", text = "" },
            }
            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
            end

            vim.diagnostic.config({
                virtual_text = true,
                underline = true,
                update_in_insert = true,
                severity_sort = true,
                float = {
                    border = "rounded",
                    source = true,
                    header = "",
                    prefix = ""
                },
            })

            -- Set rounded borders globally
            local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
            function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
                opts = opts or {}
                opts.border = opts.border or "rounded"
                return orig_util_open_floating_preview(contents, syntax, opts, ...)
            end
        end,
    },
}
