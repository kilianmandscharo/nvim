local set = vim.keymap.set;
local functions = require("util.functions")

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

-- Show all global marks
set("n", "<leader>m", functions.pick_global_mark)

-- Custom Telescope Picker
-- vim.keymap.set("n", "<leader>mg", functions.live_multigrep)
