vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Hightlight when yanking text",
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        map("gl", vim.diagnostic.open_float, "Open Diagnostic Float")
        map("<leader>f", vim.lsp.buf.format, "Format")
        map("K", function()
            vim.lsp.buf.hover({ border = "rounded" })
        end, "Hover Documentation")
    end,
})
