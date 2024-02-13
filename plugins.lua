return {

  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    config = function ()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.clang_format,
        },
        on_attach = function (client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({
              group = augroup,
              buffer = bufnr
            })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function ()
                vim.lsp.buf.format({bufnr =  bufnr})
              end
            })
          end
        end
      })
    end,
  },

  {
    "folke/which-key.nvim",
--    enabled = false,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "rust",
        "c",
        "cpp",
        "cuda",
        "glsl",
        "hlsl",
        "c",
        "zig",
        "cmake",
        "make",
        "markdown",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      local base = require("plugins.configs.lspconfig")

      local on_attach = base.on_attach
      local capabilities = base.capabilities

      local lspconfig = require("lspconfig")

      lspconfig.clangd.setup({
        on_attach = function (client, bufnr)
          client.server_capabilities.signatureHelpProvider = false
          on_attach(client, bufnr)
        end,
        capabilities = capabilities,
      })

      lspconfig.cmake.setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "lua-language-server",
        "clangd",
        "clang-format",
        "cmake-language-server"
      },
    }
  },

  {
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = "mfussenegger/nvim-dap",
    config = function ()
      local dap = require("dap")
      local dapui = require("dapui")
      local isdapui = false
      dapui.setup()
      
      dap.listeners.before.attach.dapui_config = function()
        vim.keymap.set(
          "n",
          "<leader>du", function ()
            dapui.open();
            isdapui = true;
          end,
          {desc = "Open Dap-UI"})
      end

      dap.listeners.before.launch.dapui_config = function()
        vim.keymap.set(
          "n",
          "<leader>du", function ()
            dapui.open();
            isdapui = true;
          end,
          {desc = "Open Dap-UI"})
      end

      dap.listeners.before.event_terminated.dapui_config = function()
        if isdapui then
          isdapui = false;
          dapui.close();
        end
      end

      dap.listeners.before.event_exited.dapui_config = function()
        if isdapui then
          isdapui = false;
          dapui.close();
        end
      end

    end
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
      ensure_installed = {
        "codelldb",
      },
    },
  },

  {
    "mfussenegger/nvim-dap",
    config = function ()
      require("core.utils").load_mappings("dap")
    end

  },
  {
    'mrcjkb/rustaceanvim',
    version = '^3', 
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    ft = { 'rust' },
    opts = function (client, bufnr)
      return {}
    end,
    config = function (_, opts)
      
      vim.keymap.set(
        'n',
        "<leader>ca",
        function ()
          vim.lsp.buf.code_action()
        end,
        {desc = "Rust code action"}
      )

      vim.keymap.set(
        'n',
        "<leader>dr",
        "<cmd> RustLsp debuggables <CR>",
        {desc = "Rust debug"}
      )

      vim.keymap.set(
        'n',
        "<leader>rr",
        "<cmd> :RustLsp runnables <CR>",
        {desc = "Rust run"}
      )

      vim.keymap.set(
        'n',
        "<leader>ch",
        "<cmd>RustLsp hover actions <CR>",
        {desc = "Rust hover action"}
      )

    end
  },

  {
    'saecki/crates.nvim',
    dependencies = "hrsh7th/nvim-cmp",
    ft = { "rust" , "toml"},
    tag = 'stable',
    config = function()
      local crates= require("crates")
      crates.setup()
      crates.show()
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function ()
      local M = require("plugins.configs.cmp")
      table.insert(M.sources, {name = "creates"})
      return M
    end,
  },


  {
    "nvim-telescope/telescope.nvim",
    opts = { 
      defaults = { 
        file_ignore_patterns = { 
          "target",
          "build"
        }
      }
    },
    config = function (_, opts)
      require("telescope").setup(opts)
    end
  },

  {
    "Shatur/neovim-tasks",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-lua/plenary.nvim"
    },
    event = "VeryLazy",
    config = function ()
      require("tasks").setup({})
    end,
  },
}
