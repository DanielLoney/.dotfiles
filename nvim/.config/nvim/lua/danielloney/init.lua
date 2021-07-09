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

lsp.diagnosticls.setup {
  filetypes = { "python" },
  init_options = {
    filetypes = {
      python = {"pylint"},
    },
    linters = {
      pylint = {
        sourceName = 'pylint',
        command = 'pylint',
        args = {
          '--output-format',
          'text',
          '--score',
          'no',
          '--msg-template',
          [['{line}:{column}:{category}:{msg} ({msg_id}:{symbol})']],
          '%file',
        },
        offsetColumn = 1,
        formatLines = 1,
        formatPattern = {
          [[^(\d+?):(\d+?):([a-z]+?):(.*)$]],
          {
            line = 1,
            column = 2,
            security = 3,
            message = 4
          }
        },
        securities = {
          informational = 'hint',
          refactor = 'hint',
          convention = 'info',
          warning = 'warning',
          error = 'error',
          fatal = 'error'
        },
        rootPatterns = {
          '.git',
          'pyproject.toml',
          'setup.py',
        },
      }
    },
  }
}

