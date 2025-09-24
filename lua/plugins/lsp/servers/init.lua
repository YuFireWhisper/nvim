local common = require("plugins.lsp.common")

require("plugins.lsp.servers.python")
require("plugins.lsp.servers.typescript")
require("plugins.lsp.servers.web")
require("plugins.lsp.servers.c_cpp")
require("plugins.lsp.servers.json")
require("plugins.lsp.servers.lua")
require("plugins.lsp.servers.toml")

common.setup_diagnostics()

return {}
