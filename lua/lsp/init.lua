local ok, packages = require("lsp.packages").all()
if not ok then
  return
end

local servers = require("lsp.servers")
local utils = require("lsp.utils")

utils.setup_mason(packages.mason)
utils.setup_mason_lspconfig(packages.mason_lspconfig, servers)

utils.attach_servers_to_lspconfig(packages.lspconfig, packages.cmp_nvim_lsp, servers)
utils.setup_lspconfig()

utils.setup_null_ls(packages.null_ls)
