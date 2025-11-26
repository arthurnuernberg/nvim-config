local M = {}
local cached_gblame_wins = {}

function M.center_cursor_horizontally()
	local win_width = vim.api.nvim_win_get_width(0)
	local current_col = vim.fn.virtcol(".")
	local new_leftcol = current_col - math.floor(win_width / 2)
	if new_leftcol < 0 then
		new_leftcol = 0
	end
	vim.fn.winrestview({ leftcol = new_leftcol })
end

function M.format_file()
	local view = vim.fn.winsaveview()
	vim.cmd("normal! ggVG=")
	vim.fn.winrestview(view)
end

function M.fugitive_diff_is_open()
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local buf = vim.api.nvim_win_get_buf(win)
		local name = vim.api.nvim_buf_get_name(buf)
		if name:match("fugitive://") then
			return true
		end
	end
	return false
end

function M.toggle_gblame()
	if #cached_gblame_wins > 0 then
		for _, win in ipairs(cached_gblame_wins) do
			if vim.api.nvim_win_is_valid(win) then
				pcall(vim.api.nvim_win_close, win, true)
			end
		end
		cached_gblame_wins = {}
		return
	end

	vim.cmd("Git blame")

	vim.schedule(function()
		local wins = {}
		for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
			local ok, buf = pcall(vim.api.nvim_win_get_buf, win)
			if ok and buf then
				local name = vim.api.nvim_buf_get_name(buf) or ""
				local ok2, ft = pcall(vim.api.nvim_buf_get_option, buf, "filetype")
				ft = (ok2 and ft) and ft or ""
				-- On considère comme Fugitive/blame les buffers fugitive ou les filetypes liés
				if name:match("fugitive://") or ft:match("fugitive") or ft:match("git") then
					table.insert(wins, win)
				end
			end
		end
		cached_gblame_wins = wins
	end)
end

return M
