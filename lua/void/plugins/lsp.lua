return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp", -- Prepares us for the autocomplete menu later
	},
	config = function()
		-- local lspconfig = require("lspconfig")

		-- 1. Tell Neovim to start these servers automatically
		local servers = {
			"ts_ls", -- JavaScript/TypeScript
			"pyright", -- Python
			"rust_analyzer", -- Rust
			"jdtls", -- Java
			"sqlls", -- SQL
			"lua_ls", -- Lua
		}

		-- Enable standard servers the mordern way
		for _, lsp in ipairs(servers) do
			vim.lsp.enable(lsp)
		end

		-- Configure and enable lua_ls special settings the modern way
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						global = { "vim" },
					},
				},
			},
		})
		vim.lsp.enable("lua_ls")

		-- 2. Create the LSP Keyboard Shortcuts
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				-- Press 'K' to see hover documentation for a function/variable
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

				-- Press 'gd' to instantly jump to where a function is defined
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)

				-- Press 'Space + rn' to rename a variable everywhere in the file at once
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				-- Press 'Space + ca' to see suggested quick-fixes for an error
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			end,
		})
	end,
}
