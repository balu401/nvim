return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = 15,
			open_mapping = [[<C-\>]],
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mapping = true,
			persist_size = true,
			direction = "horizontal",
			close_on_exit = true,
			shell = vim.o.shell,
		})

		--The "Escape Hatch" keymaps
		-- Neovim terminals are notorious for trapping you inside them.
		-- This code allows you to press 'Esc' or 'jk' to exit typing mode and
		-- use normal Neovim shortcuts to jump back to your code.
		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
			vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)

			-- Let you use Ctrl + arrow keys to jump between the terminal and your code
			vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd h<CR>]], opts)
			vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd h<CR>]], opts)
		end

		-- Tell Neovim to apply those rules every time a terminal opens
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
