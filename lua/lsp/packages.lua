local M = {}

M.all = function()
  local package_names = {
    "mason",
    "mason-lspconfig",
    "lspconfig",
    "null-ls",
    "cmp_nvim_lsp",
  }

  local packages = {}

  for _, pkg_name in pairs(package_names) do
    local ok, pkg = pcall(require, pkg_name)
    if not ok then
      return false, packages
    end
    packages[string.gsub(pkg_name, "-", "_")] = pkg
  end

  return true, packages
end

M.test = "hello"

return M
