local set = vim.keymap.set;
local utils = require("util.functions")

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
set("n", "<leader>b", utils.toggleQuickFix)

-- Show all global marks
set("n", "<leader>m", utils.pick_global_mark)

-- Diagnostic
set("n", "gl", vim.diagnostic.open_float)
set("n", "gn", function() vim.diagnostic.jump({ count = vim.v.count1 }) end)
set("n", "gp", function() vim.diagnostic.jump({ count = -vim.v.count1 }) end)

-- LSP
set("n", "gd", vim.lsp.buf.definition)
set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end)
set("n", "<leader>f", utils.formatFile)
