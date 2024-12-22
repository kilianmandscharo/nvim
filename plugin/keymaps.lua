local set = vim.keymap.set;

-- Formatting
set("n", "<leader>f", function()
    local filetype = vim.bo.filetype
    if filetype == "python" then
        vim.cmd("write")
        vim.cmd("!black %")
        vim.cmd("edit")
    elseif filetype == "javascript" or filetype == "typescript" or filetype == "json" then
        vim.cmd("write")
        vim.cmd("!prettier % --write --tab-width 4")
        vim.cmd("edit")
    else
        vim.lsp.buf.format()
    end
end)

-- Window navigation
set("n", "<C-h>", "<C-w>h")
set("n", "<C-j>", "<C-w>j")
set("n", "<C-k>", "<C-w>k")
set("n", "<C-l>", "<C-w>l")

-- Buffer navigation
set("n", "<S-l>", ":bnext<CR>")
set("n", "<S-h>", ":bprevious<CR>")
set("n", "<leader>c", ":bdelete<CR>")

-- Terminal
set("t", "<Esc>", "<C-\\><C-n>")

-- Toggle Quick Fix List
set("n", "<leader>b", function()
    local qf_open = false

    for _, win in pairs(vim.fn.getwininfo()) do
        if win["quickfix"] == 1 then
            qf_open = true
            break
        end
    end

    if qf_open == true then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end)
