local lsp=require('lspconfig')

require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

-- Python

local function on_attach(client)
    vim.cmd [[autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync()]]
end

lsp.jedi_language_server.setup{on_attach = on_attach}
-- pyright still bugging out arghhhhhh
-- require("lspconfig").pyright.setup {
--   settings = {
--     python = {
--       analysis = {
--         typeCheckingMode = "off",
--       },
--     },
--   },
-- }

-- C/C++

lsp.clangd.setup{on_attach = on_attach}



require 'diagnosticls-nvim'.init {
    on_attach = on_attach
}


local pylint = require 'diagnosticls-nvim.linters.pylint'
pylint.securities.refactor = 'hint'

local black = require 'diagnosticls-nvim.formatters.black'

require 'diagnosticls-nvim'.setup {
    ['python'] = {
        linter = pylint,
        formatter = black,
    },
}
