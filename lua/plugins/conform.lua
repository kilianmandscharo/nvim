return {
    {
        'stevearc/conform.nvim',
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    python = { "black" },
                    javascript = { "prettier" },
                    javascriptreact = { "prettier" },
                    typescript = { "prettier" },
                    typescriptreact = { "prettier" },
                    json = { "prettier" },
                },
            })
        end
    }
}
