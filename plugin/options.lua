vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.incsearch = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.signcolumn = "yes"

vim.g.netrw_banner = 0
vim.g.netrw_keepdir = 0
vim.g.netrw_winsize = 20

vim.opt.colorcolumn = "80"
vim.opt.laststatus = 3
vim.opt.winbar = "%=%m %f"

vim.cmd.colorscheme("catppuccin-mocha")

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Hightlight when yanking text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end
})
