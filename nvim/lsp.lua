local nvim_lsp = require('lspconfig')
local coq = require('coq')
local toggleDiag = require('toggle_lsp_diagnostics')

-- Setup the toggle diagnostic script
toggleDiag.init()

local get_number_of_diagnostics_for_line = function(diagnostic)
  local diagnostic_for_line = {}
  if diagnostic_for_line[diagnostic.lnum] then
    diagnostic_for_line[diagnostic.lnum] = diagnostic_for_line[diagnostic.lnum] + 1
    return diagnostic_for_line[diagnostic.lnum]
  else
    diagnostic_for_line[diagnostic.lnum] = 1
    return 1
  end
end

-- https://neovim.discourse.group/t/right-align-virtual-text/2135
local rightAlignFormatFunction = function(diagnostic)
  local line = diagnostic.lnum
  local line_len = #(vim.api.nvim_buf_get_lines(0, line, line + 1, false)[1] or "")

  -- get the display line width subtract 10 because reasons
  -- local total_line_width = vim.api.nvim_get_option("columns") - 10

  -- calculate the space needed to right align
  local space_len = string.rep(" ", 80 - line_len) --total_line_width - line_len - string.len(diagnostic.message) )
  local n_diagnostics = string.rep("■", get_number_of_diagnostics_for_line(diagnostic))
  return string.format("%s%s %s", space_len, n_diagnostics, diagnostic.message)
end


local lsp_configs = require('lspconfig.configs')

lsp_configs.prosemd = {
  default_config = {
    cmd = { "/home/anders/.cargo/bin/prosemd-lsp", "--stdio" },
    filetypes = { "markdown" },
    root_dir = function(fname)
      return vim.fn.getcwd()
    end,
    settings = {},
  }
}

lsp_configs.cmake = {
  default_config = {
    cmd= {"cmake-language-server", },
    filetypes = {"cmake" },
    root_dir = function()
      return vim.fn.getcwd()
    end,
    settings = {
      initializationOptions = {
        buildDirectory = "build",
      },
    }
  }
}

local rust_opts = {
  tools = { -- rust-tools options
    inlay_hints = {
      show_parameter_hints = true,
      -- prefix for parameter hints
      parameter_hints_prefix = "<- ",
      -- prefix for all the other hints (type, chaining)
      other_hints_prefix = "=> ",

      -- whether to align to the extreme right or not
      right_align = false,

    },
    hover_actions = {
      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      border = {
        {"╭", "FloatBorder"}, {"─", "FloatBorder"},
        {"╮", "FloatBorder"}, {"│", "FloatBorder"},
        {"╯", "FloatBorder"}, {"─", "FloatBorder"},
        {"╰", "FloatBorder"}, {"│", "FloatBorder"}
      },

      -- whether the hover action window gets automatically focused
      auto_focus = false
    },
  },


  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    standalone = false,
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = function(client, bufnr)
      -- Mappings.
      vim.keymap.set('n', 'K', '<cmd>RustHoverActions<CR>', {buffer = bufnr})
      vim.keymap.set('n', '<leader>ca', '<cmd>RustCodeAction<CR>', {buffer = bufnr})
    end,

    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        -- enable clippy on save
        checkOnSave = {
          enable = true,
          command = "clippy",
          features = "all",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true
        },
        inlayHints = {
          lifetimeElisionHints = {
            enable = true,
            useParameterNames = true
          }
        },
      }
    }
  },
}

local clangd_extentions_opts =  {
    extensions = {
        -- defaults:
        -- Automatically set inlay hints (type hints)
        autoSetHints = true,
        -- These apply to the default ClangdSetInlayHints command
        inlay_hints = {
            inline = vim.fn.has("nvim-0.10") == 1,
            -- Only show inlay hints for the current line
            only_current_line = false,
            -- Event which triggers a refersh of the inlay hints.
            -- You can make this "CursorMoved" or "CursorMoved,CursorMovedI" but
            -- not that this may cause  higher CPU usage.
            -- This option is only respected when only_current_line and
            -- autoSetHints both are true.
            only_current_line_autocmd = { "CursorHold" },
            -- whether to show parameter hints with the inlay hints or not
            show_parameter_hints = true,
            -- prefix for parameter hints
            parameter_hints_prefix = "<- ",
            -- prefix for all the other hints (type, chaining)
            other_hints_prefix = "=> ",
            -- whether to align to the length of the longest line in the file
            max_len_align = false,
            -- padding from the left if max_len_align is true
            max_len_align_padding = 1,
            -- whether to align to the extreme right or not
            right_align = true,
            -- padding from the right if right_align is true
            right_align_padding = 7,
            -- The color of the hints
            highlight = "Comment",
            -- The highlight group priority for extmark
            priority = 100,
        },
        ast = {
            -- These are unicode, should be available in any font
            role_icons = {
                 type = "🄣",
                 declaration = "🄓",
                 expression = "🄔",
                 statement = ";",
                 specifier = "🄢",
                 ["template argument"] = "🆃",
            },
            kind_icons = {
                Compound = "🄲",
                Recovery = "🅁",
                TranslationUnit = "🅄",
                PackExpansion = "🄿",
                TemplateTypeParm = "🅃",
                TemplateTemplateParm = "🅃",
                TemplateParamObject = "🅃",
            },
            --[[ These require codicons (https://github.com/microsoft/vscode-codicons)
            role_icons = {
                type = "",
                declaration = "",
                expression = "",
                specifier = "",
                statement = "",
                ["template argument"] = "",
            },

            kind_icons = {
                Compound = "",
                Recovery = "",
                TranslationUnit = "",
                PackExpansion = "",
                TemplateTypeParm = "",
                TemplateTemplateParm = "",
                TemplateParamObject = "",
            }, ]]

            highlights = {
                detail = "Comment",
            },
        },
        memory_usage = {
            border = "none",
        },
        symbol_info = {
            border = "none",
        },
    },
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pylsp', 'rust_analyzer', 'clangd', 'prosemd', 'tsserver', 'cmake'}
for _, lsp in ipairs(servers) do
  -- set loglevel to OFF
  vim.lsp.set_log_level(4)
  if lsp == 'rust_analyzer' then
    -- rust-tools will automatically start the rust_analyzer lsp and do what is
    -- needed
    require('rust-tools').setup(coq.lsp_ensure_capabilities(rust_opts))
  elseif lsp == 'clangd' then
    nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities(clangd_extentions_opts))
    require("clangd_extensions.inlay_hints").setup_autocmd()
    require("clangd_extensions.inlay_hints").set_inlay_hints()
    vim.diagnostic.config({
      virtual_text = false,
      severity_sort = true,
    })
  else
    nvim_lsp[lsp].setup(coq.lsp_ensure_capabilities{ })
  end
end