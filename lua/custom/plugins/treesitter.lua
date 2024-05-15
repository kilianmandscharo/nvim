return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    lazy = false,
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = "all",
        highlight = {
          enable = true,
        },
        autopairs = {
          enable = true,
        },
        indent = { enable = true },
      })
    end,
  }
}
