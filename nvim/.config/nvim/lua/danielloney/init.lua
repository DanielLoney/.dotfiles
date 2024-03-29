local lsp=require('lspconfig')

require'nvim-treesitter.configs'.setup { highlight = { enable = true } }

local function on_attach(client)
    vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
end


-- Lua
local system_name
if vim.fn.has("mac") == 1 then
  system_name = "macOS"
elseif vim.fn.has("unix") == 1 then
  system_name = "Linux"
elseif vim.fn.has('win32') == 1 then
  system_name = "Windows"
else
  print("Unsupported system for sumneko")
end

-- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
local sumneko_root_path = "/home/daniel/Programs/Sumneko/lua-language-server"
local sumneko_binary = sumneko_root_path.."/bin/"..system_name.."/lua-language-server"

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"};
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}


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
