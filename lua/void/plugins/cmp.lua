return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- Only load this when you actually start typing
  dependencies = {
    "hrsh7th/cmp-buffer",           -- Suggests words from your current file
    "hrsh7th/cmp-path",             -- Suggests file paths (great for imports)
    "L3MON4D3/LuaSnip",             -- The snippet engine
    "saadparwaiz1/cmp_luasnip",     -- Connects the snippet engine to cmp
    "rafamadriz/friendly-snippets", -- A massive library of pre-built snippets
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Load the friendly-snippets library
    require("luasnip.loaders.from_vscode").lazy_load()

    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      snippet = {
        -- Tell cmp how to expand snippets
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping.select_prev_item(), -- Navigate up the list
        ["<C-j>"] = cmp.mapping.select_next_item(), -- Navigate down the list
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),    -- Scroll preview window up
        ["<C-f>"] = cmp.mapping.scroll_docs(4),     -- Scroll preview window down
        ["<C-Space>"] = cmp.mapping.complete(),     -- Manually trigger the menu
        ["<C-e>"] = cmp.mapping.abort(),            -- Close the menu
        ["<CR>"] = cmp.mapping.confirm({ select = false }), -- Press Enter to accept
      }),
      -- The order of these sources dictates priority in the menu
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- Top priority: actual code syntax from LSP
        { name = "luasnip" },  -- Second priority: Snippets
        { name = "buffer" },   -- Third priority: Words already in your file
        { name = "path" },     -- Fourth priority: File paths
      }),
    })
  end,
}






