return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local nvimtree = require("nvim-tree")

		--Disable standard netrw (Vim's ugly default file viewer)
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		nvimtree.setup({
			view = {
				width = 35, -- The width of the sidebar panel
				relativenumber = true, -- Creat for jumping up/down lines quickly
			},
			renderer = {
				indent_markers = {
					enable = true, -- Draws nice vertical lines for folder hierarchy
				},
			},

			-- Prevent the explorer window from breaking your active splits
			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_Store" },
			},
		})
		-- The Keymaps (space + e commands)
		-- Space + e + e: Open/Close the file explorer panel
		vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

		-- Space + e + f: Instantly open the sidebar and focus on the file you have open
		vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Find current file in tree " })
	end,
}
