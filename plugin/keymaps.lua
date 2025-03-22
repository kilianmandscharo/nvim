local set = vim.keymap.set;
local functions = require("functions")

-- Formatting
set("n", "<leader>f", functions.formatFile)

-- Testing
set("n", "<leader>rt", functions.runTest)

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
set("n", "<leader>b", functions.toggleQuickFix)

-- Custom Telescope Picker
vim.keymap.set("n", "<leader>fg", functions.live_multigrep)
