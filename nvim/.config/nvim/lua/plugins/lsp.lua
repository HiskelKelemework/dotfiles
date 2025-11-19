-- Plugin configuration for nvim-lspconfig and nvim-cmreturn {
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Mason for managing LSP servers
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    -- Existing CMP dependencies
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "hrsh7th/cmp-path" },
    { "hrsh7th/cmp-cmdline" },
  },
  config = function()
    -- Initialize Mason
    require("mason").setup()

    -- Initialize Mason-LSPConfig
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "pyright", "ts_ls", "clangd", "jdtls", "prismals", "rust_analyzer", "elixirls" }, -- Match your servers
      automatic_installation = true,                                                                                   -- Auto-install servers
    })

    -- LSP settings
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Define on_attach function to enable inlay hints
    local on_attach = function(client, bufnr)
      -- Enable inlay hints for the current buffer
      if client.server_capabilities.inlayHintProvider then
        -- vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
      end
      -- Optional: Add keymap to toggle inlay hints
      vim.keymap.set('n', '<leader>th', function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }))
      end, { buffer = bufnr, desc = "Toggle Inlay Hints" })
    end

    -- Define server configurations
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT", -- For Neovim
            },
            diagnostics = {
              globals = { "vim" }, -- Recognize Neovim globals
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true), -- Include Neovim runtime files
              checkThirdParty = false,                           -- Avoid third-party prompts
            },
            telemetry = {
              enable = false, -- Disable telemetry
            },
          },
        },
      },
      pyright = {},  -- No specific settings needed
      ts_ls = {},    -- No specific settings needed
      clangd = {},   -- No specific settings needed
      jdtls = {},    -- No specific settings needed
      prismals = {}, -- No specific settings needed
      elixirls = {
        cmd = { "elixir-ls" }
      },                       -- No specific settings needed
      rust_analyzer = {
        on_attach = on_attach, -- Attach the on_attach function
        settings = {
          ['rust-analyzer'] = {
            inlayHints = {
              enable = true,
              bindingModeHints = { enable = false },
              chainingHints = { enable = true },
              closingBraceHints = { enable = true, minLines = 25 },
              closureReturnTypeHints = { enable = "never" },
              lifetimeElisionHints = { enable = "always", useParameterNames = true },
              maxLength = 25,
              parameterHints = { enable = true },
              reborrowHints = { enable = "never" },
              renderColons = true,
              typeHints = { enable = true, hideClosureInitialization = false, hideNamedConstructor = false },
            },
          },
        }, -- No specific settings needed
      }
    }

    -- Set up each server with its configuration
    for lsp, config in pairs(servers) do
      vim.lsp.config(lsp, config)
    end

    -- CMP settings (unchanged from your config)
    local cmp = require("cmp")
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "path" },
      }),
    })
  end,
}
