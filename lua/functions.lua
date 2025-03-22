local M = {}

M.runTest = function()
    local line = vim.api.nvim_get_current_line()
    local test_name = line:match("describe%(\"(.-)\"") or line:match("it%(\"(.-)\"")
    if not test_name then
        return
    end

    local file_path = vim.fn.expand("%:p")
    local cmd = string.format("npx jest \"%s\" -t \"%s\"", file_path, test_name)

    vim.cmd("vsplit | terminal")
    vim.fn.chansend(vim.b.terminal_job_id, cmd .. "\n")
end

M.formatFile = function()
    local filetype = vim.bo.filetype
    if filetype == "python" then
        vim.cmd("write")
        vim.cmd("!black %")
        vim.cmd("edit")
    elseif filetype == "javascript" or filetype == "typescript" or filetype == "json" or filetype == "typescriptreact" or filetype == "javascriptreact" then
        vim.cmd("write")
        vim.cmd("!prettier % --write --tab-width 4")
        vim.cmd("edit")
    else
        vim.lsp.buf.format()
    end
end

M.toggleQuickFix = function()
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
end

return M
