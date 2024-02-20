local cfg = {
  debug = false,
  log_path = vim.fn.stdpath("cache") .. "/lsp_signature.log",
  verbose = false,
  bind = true,
  floating_window = false,
  hint_enable = true,
  hint_prefix = "-> ",
  hint_scheme = "String",
  hint_inline = function() return false end,
  hi_parameter = "LspSignatureActiveParameter",
  toggle_key = nil,
}

require('lsp_signature').setup(cfg)
