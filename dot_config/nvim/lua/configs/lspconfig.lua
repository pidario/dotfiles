require("nvchad.configs.lspconfig").defaults()

vim.lsp.config("html", {})
vim.lsp.config("cssls", {})
vim.lsp.config("ts_ls", {})
vim.lsp.config("angularls", {})

local servers = { "html", "cssls", "ts_ls", "angularls" }
vim.lsp.enable(servers)
