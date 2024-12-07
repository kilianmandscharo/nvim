return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require 'nvim-treesitter.configs'.setup {
                ensure_installed = {
                    "c",
                    "cmake",
                    "make",
                    "lua",
                    "vim",
                    "vimdoc",
                    "go",
                    "gomod",
                    "gosum",
                    "gotmpl",
                    "rust",
                    "typescript",
                    "javascript",
                    "tsx",
                    "bash",
                    "css",
                    "csv",
                    "diff",
                    "dockerfile",
                    "git_config",
                    "git_rebase",
                    "gitattributes",
                    "gitcommit",
                    "gitignore",
                    "helm",
                    "html",
                    "http",
                    "json",
                    "json5",
                    "jsdoc",
                    "ocaml",
                    "ocaml_interface",
                    "ocamllex",
                    "pem",
                    "powershell",
                    "python",
                    "regex",
                    "scss",
                    "sql",
                    "templ",
                    "tmux",
                    "toml",
                    "vue",
                    "xml",
                    "yaml",
                },
                sync_install = false,
                auto_install = false,
                highlight = {
                    enable = true,
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                    additional_vim_regex_highlighting = false,
                },
                autopairs = {
                    enable = true,
                },
                indent = { enable = true },
            }
        end,
    }
}
