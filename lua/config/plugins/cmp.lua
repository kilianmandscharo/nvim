return {
    {
        'saghen/blink.cmp',
        dependencies = 'rafamadriz/friendly-snippets',
        version = '*',
        opts = {
            keymap = {
                preset = 'none',
                ["<Tab>"] = { 'select_next', 'fallback' },
                ["<S-Tab>"] = { 'select_prev', 'fallback' },
                ["<CR>"] = { 'accept', 'fallback' },
            },
            appearance = {
                use_nvim_cmp_as_default = true,
                nerd_font_variant = 'mono'
            },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            cmdline = {
                completion = {
                    ghost_text = {
                        enabled = true
                    }
                }
            },
            signature = { enabled = true },
        },
        completion = {
            ghost_text = {
                enabled = true,
            }
        },
        opts_extend = { "sources.default" }
    }
}
