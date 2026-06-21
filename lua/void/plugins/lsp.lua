return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- Prepare us for the autocomplete menu later
  },
  config = function()
    local lspconfig = require("lspconfig")

    --1. tell Neovim to start these servers automatically
    local servers = {
      "ts_ls", -- JS/TS
      "pyright", -- Python
      "jdtls", -- java
      "sqlls", -- SQL
      "lua_ls", -- Lua
    }

    for _, lsp in ipairs(servers) do
      lspconfig{lsp}.setup({})
    end

    --2. Create the LSP keyboard Shortcuts
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("userLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }

        -- Press 'K' to see hover documentation for a function/veriable in the file at once
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        -- Press 'gd' to instantly jump to where a function is defined
        vim.keymap.set("n", "gd", vim.lsp.buf.defination, opts)

        -- Press 'Space + rn' to rename a veriable everywhere in the file at once
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.renamem, opts)

        -- Press 'Space + ca' to see suggested quick-fixes for an error
        vim.keymap.set("n", "leader>ca", vim.lsp.buf.code_action, opts)
      end,
    })
  end, 
}
