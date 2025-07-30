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

local getGoTestCommand = function()
    local line = vim.api.nvim_get_current_line()

    local test_name = line:match("func (.+)%(")
    if not test_name then
        return nil
    end

    local cmd = string.format("go test -run %s ./...", test_name)

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

    if file_name:match("_test.go") then
        cmd = getGoTestCommand()
    end

    if not cmd then
        return
    end

    vim.cmd("vsplit | terminal")
    vim.fn.chansend(vim.b.terminal_job_id, cmd .. "\n")
end

local use_conform_formatter = {
    python = true,
    javascript = true,
    typescript = true,
    json = true,
    javascriptreact = true,
    typescriptreact = true,
}

M.formatFile = function()
    local filetype = vim.bo.filetype
    if use_conform_formatter[filetype] then
        require("conform").format({
            bufnr = vim.api.nvim_get_current_buf(),
            lsp_fallback = true,
            async = false,
        })
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
        vim.cmd("botright copen")
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

M.pick_global_mark = function()
    local all_marks = vim.fn.getmarklist();
    local entries = {}

    for _, mark in ipairs(all_marks) do
        local byte = string.byte(string.sub(mark.mark, #mark.mark))
        if byte < 65 or byte > 90 then goto continue end

        local filename = mark.file
        local row = mark.pos[2]
        local col = mark.pos[3]

        table.insert(entries, {
            display = string.format("%s  %s:%d:%d", mark.mark, filename, row, col),
            ordinal = filename .. row .. col,
            filename = filename,
            lnum = row,
            col = col,
        })

        ::continue::
    end

    local pickers = require("telescope.pickers")
    local finders = require("telescope.finders")
    local sorters = require("telescope.sorters")
    local themes = require("telescope.themes")

    pickers.new(themes.get_dropdown({
        prompt_title = "Marks",
    }), {
        finder = finders.new_table {
            results = entries,
            entry_maker = function(entry)
                return {
                    value = entry,
                    display = entry.display,
                    ordinal = entry.ordinal,
                    filename = entry.filename,
                    lnum = entry.lnum,
                    col = entry.col,
                }
            end
        },
        sorter = sorters.get_generic_fuzzy_sorter(),
    }):find()
end

return M
