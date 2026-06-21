return {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- Start the Mason App Store
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Tell Mason exactly which servers to auto-download for your languages
    require("mason-lspconfig").setup({
      ensure_installed = {
        "ts_ls",         -- JavaScript
        "pyright",       -- Python
        "rust_analyzer", -- Rust
        "jdtls",         -- Java
        "sqlls",         -- PostgreSQL/SQL
        "lua_ls",        -- Lua (for your Neovim config)
      },
      automatic_installation = true,
    })
  end,
}
