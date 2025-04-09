require("mason").setup()
require("danielloney.cmp")

local lsp=require('lspconfig')

require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

local function on_attach(client)
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
end

local function luals_on_attach(client)
  if client.workspace_folders then
    local path = client.workspace_folders[1].name
    if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
      return
    end
  end

  client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
    runtime = {
      -- Tell the language server which version of Lua you're using
      -- (most likely LuaJIT in the case of Neovim)
      version = 'LuaJIT'
    },
    -- Make the server aware of Neovim runtime files
    workspace = {
      checkThirdParty = false,
      library = {
        vim.env.VIMRUNTIME,
        -- Depending on the usage, you might want to add additional paths here.
        "${3rd}/luv/library",
        "${3rd}/busted/library",
      }
      -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
      -- library = vim.api.nvim_get_runtime_file("", true)
    }
  })
end

vim.lsp.config['luals'] = {
  -- Command and arguments to start the server.
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  globals = {'vim'},
  root_markers = { '.luarc.json', '.luarc.jsonc' },
  -- Specific settings to send to the server. The schema for this is
  -- defined by the server. For example the schema for lua-language-server
  -- can be found here https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      }
    }
  },
  on_init = luals_on_attach
}

vim.lsp.enable('luals')

-- require'lspconfig'.lua_ls.setup {
--   on_init = function(client)
--     if client.workspace_folders then
--       local path = client.workspace_folders[1].name
--       if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
--         return
--       end
--     end

--     client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
--       runtime = {
--         -- Tell the language server which version of Lua you're using
--         -- (most likely LuaJIT in the case of Neovim)
--         version = 'LuaJIT'
--       },
--       -- Make the server aware of Neovim runtime files
--       workspace = {
--         checkThirdParty = false,
--         library = {
--           vim.env.VIMRUNTIME
--           -- Depending on the usage, you might want to add additional paths here.
--           -- "${3rd}/luv/library"
--           -- "${3rd}/busted/library",
--         }
--         -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
--         -- library = vim.api.nvim_get_runtime_file("", true)
--       }
--     })
--   end,
--   settings = {
--     Lua = {}
--   }
-- }

-- Python
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


-- C/C++
lsp.clangd.setup{on_attach = on_attach}

-- Rust
lsp.rust_analyzer.setup{
    on_attach = on_attach,
    settings = {
        ['rust-analyzer'] = {
            checkOnSave = {
                allFeatures = true,
                overrideCommand = {
                    'cargo', 'clippy', '--workspace', '--message-format=json',
                    '--all-targets', '--all-features'
                }
            }
        }
    }
}

-- Go
local util = require "lspconfig/util"

lsp.gopls.setup {
    cmd = {"gopls", "serve"},
    filetypes = {"go", "gomod"},
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        analyses = {
          unusedparams = true,
        },
        staticcheck = true,
      },
    },
}

-- Diagnostics
require 'diagnosticls-configs'.init {
    on_attach = on_attach
}

local pylint = require 'diagnosticls-configs.linters.pylint'
pylint.securities.refactor = 'hint'

local black = require 'diagnosticls-configs.formatters.black'

require 'diagnosticls-configs'.setup {
    ['python'] = {
        linter = pylint,
        formatter = black,
    },
}
