local lsp=require('lspconfig')

require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

lsp.jedi_language_server.setup{}

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
local function on_attach(client)
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
end

require 'diagnosticls-nvim'.init {
    on_attach = on_attach
}


local black = {
  sourceName = 'black',
  command = 'black',
  args = { '%filepath' },
  doesWriteToFile = true,
  rootPatterns = {
      '.git',
      'pyproject.toml',
      'setup.py',
  },
}

local pylint = require 'diagnosticls-nvim.linters.pylint'
pylint.securities.refactor = 'hint'

-- local black = require 'diagnosticls-nvim.formatters.black'

require 'diagnosticls-nvim'.setup {
    ['python'] = {
        linter = pylint,
        formatter = black,
    },
}
