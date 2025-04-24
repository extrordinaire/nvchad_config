require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = {
  "html",
  "cssls",
  "oxlint",
  "zls",
  "rust_analyzer",
  "eslint",
  "ts_ls",
  "tailwindcss",
  -- "verible",
  "svlangserver",
  -- "svls",
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

lspconfig.mdx_analyzer.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  filetypes = { "mdx", "markdown" },
}

lspconfig.emmet_language_server.setup({
  filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "markdown", "mdx" },
  -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
  -- **Note:** only the options listed in the table are supported.
  init_options = {
    ---@type table<string, string>
    includeLanguages = {},
    --- @type string[]
    excludeLanguages = {},
    --- @type string[]
    extensionsPath = {},
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
    preferences = {},
    --- @type boolean Defaults to `true`
    showAbbreviationSuggestions = true,
    --- @type "always" | "never" Defaults to `"always"`
    showExpandedAbbreviation = "always",
    --- @type boolean Defaults to `false`
    showSuggestionsAsSnippets = false,
    --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
    syntaxProfiles = {},
    --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
    variables = {},
  },
})


lspconfig.volar.setup({
  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  init_options = {
    vue = {
      hybridMode = false, -- disables hybrid mode for full takeover
    },
  },
  on_attach = function(client, bufnr)
    -- Your existing on_attach logic
    if nvlsp and nvlsp.on_attach then
      nvlsp.on_attach(client, bufnr)
    end

    -- Stop tsserver if it's active
    for _, other_client in pairs(vim.lsp.get_clients({ bufnr = bufnr })) do
      if other_client.name == 'ts_ls' then
        other_client.stop()
      end
    end
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
})

-- lspconfig.svls.setup({
--   filetypes = { "systemverilog", "verilog" },
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
--   --optionally point to your project-level .svls.toml :contentReference[oaicite:4]{index=4}
--   -- settings = {
--   --   verilog = {
--   --     include_paths = { "src/header", "lib" },
--   --     defines       = { "SYNTHESIS", "DEBUG=1" },
--   --     plugins       = {},
--   --   },
--   --   option = { linter = true },
--   -- },
--   cmd = { "svls" },
-- })

-- lspconfig.svlangserver.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = require("cmp_nvim_lsp").default_capabilities(nvlsp.capabilities),
-- }

-- Set up the LSP handler for signature help
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help,
  {
    border = "rounded", -- Optional: adds a rounded border to the floating window
    focusable = false,  -- Prevents the window from stealing focus
    max_width = 80,     -- Optional: sets the maximum width of the window
    max_height = 12,    -- Optional: sets the maximum height of the window
    wrap = true,        -- Optional: enables text wrapping within the window
  }
)

-- vim.lsp.enable(servers)
