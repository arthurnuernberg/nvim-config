return {
	{
		"mbbill/undotree",
		cmd = { "UndotreeToggle", "UndotreeShow" },
		init = function()
			vim.opt.undofile = true
			local undodir = vim.fn.stdpath("state") .. "/undo"
			if vim.fn.isdirectory(undodir) == 0 then
				vim.fn.mkdir(undodir, "p")
			end

			vim.opt.undodir = undodir
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {
				noremap = true,
				silent = true,
				desc = "Toggle Undotree",
			})
		end,
	},
}
