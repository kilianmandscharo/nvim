local function bind(op, outer_opts)
  outer_opts = outer_opts or { noremap = true }
  return function(lhs, rhs, opts)
    opts = vim.tbl_extend("force",
      outer_opts,
      opts or {}
    )
    vim.keymap.set(op, lhs, rhs, opts)
  end
end

local nnoremap = bind("n")
local tnoremap = bind("t")
-- local nmap = bind("n", { noremap = false })
-- local vnoremap = bind("v")
-- local xnoremap = bind("x")
-- local inoremap = bind("i")

-- Telescope
nnoremap("<leader>p", "<cmd>Telescope find_files<CR>")
nnoremap("<leader>g", "<cmd>Telescope live_grep<CR>")

-- Netrw
nnoremap("<leader>e", ":Ex<CR>")

-- Formatting
nnoremap("<leader>f", ":lua vim.lsp.buf.format()<CR>")

-- Window navigation
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")

-- Buffer navigation
nnoremap("<S-l>", ":bnext<CR>")
nnoremap("<S-h>", ":bprevious<CR>")
nnoremap("<leader>c", ":bdelete<CR>")

-- Trouble
nnoremap("<leader>t", ":TroubleToggle<CR>")

-- Close Quick Fix List
nnoremap("<leader>b", ":cclose<CR>")

-- Terminal
tnoremap("<Esc>", "<C-\\><C-n>")
