local M = {}

local getJestCommand = function()
    local line = vim.api.nvim_get_current_line()

    local test_name = line:match("describe%(\"(.-)\"") or line:match("it%(\"(.-)\"")
    if not test_name then
        return nil
    end

    local file_path = vim.fn.expand("%:p")
    local cmd = string.format("npx jest \"%s\" -t \"%s\"", file_path, test_name)

    return cmd
end

M.runTest = function()
    local file_name = vim.fn.expand("%:t")
    local cmd = nil

    if
        file_name:match(".test.ts") or
        file_name:match(".test.js") or
        file_name:match(".spec.ts") or
        file_name:match(".spec.js")
    then
        cmd = getJestCommand()
    end

    if not cmd then
        return
    end

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

M.live_multigrep = function()
    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local make_entry = require "telescope.make_entry"
    local conf = require "telescope.config".values

    local opts = { cwd = vim.fn.getcwd() }

    local finder = finders.new_async_job {
        command_generator = function(prompt)
            if not prompt or prompt == "" then
                return nil
            end

            local pieces = vim.split(prompt, "  ")
            local args = { "rg" }
            if pieces[1] then
                table.insert(args, "-e")
                table.insert(args, pieces[1])
            end

            if pieces[2] then
                table.insert(args, "-g")
                table.insert(args, pieces[2])
            end

            return vim.iter {
                args,
                { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
            }:flatten():totable()
        end,
        entry_maker = make_entry.gen_from_vimgrep(opts),
        cwd = opts.cwd,
    }

    pickers.new(opts, {
        debounce = 100,
        prompt_title = "Multi-Grep",
        finder = finder,
        previewer = conf.grep_previewer(opts),
        sorter = require("telescope.sorters").empty(),
    }):find()
end

return M
