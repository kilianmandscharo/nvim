return {
  "folke/trouble.nvim",
  config = function()
    vim.keymap.set("n", "<leader>t", ":TroubleToggle<CR>")
  end
}
