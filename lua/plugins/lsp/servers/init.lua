local common = require("plugins.lsp.common")

vim.lsp.config('*', {
  capabilities = common.capabilities,
  on_attach = common.on_attach,
})

require("plugins.lsp.servers.python")
require("plugins.lsp.servers.typescript")
require("plugins.lsp.servers.web")
require("plugins.lsp.servers.c_cpp")
require("plugins.lsp.servers.lua")
require("plugins.lsp.servers.toml")

common.setup_diagnostics()

return {}
