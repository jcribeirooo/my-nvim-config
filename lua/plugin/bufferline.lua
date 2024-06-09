local M = {}

function M.setup()
	require("bufferline").setup({
		options = {
			offsets = {
				{
					filetype = "NvimTree",
					text = "Explorer",
					separator = true,
					text_align = "center",
				},
			},
			diagnostics = "nvim_lsp",
			separator_style = { "", "" },
			modified_icon = "●",
			show_close_icon = false,
			show_buffer_close_icons = false,
		},
	})
	local fixBufferLineSeparator = function()
		local separator = vim.api.nvim_get_hl(0, { name = "NvimTreeWinSeparator" })
		local hl_sep_table = {}
		for key, value in pairs(separator) do
			hl_sep_table[key] = value
		end
		vim.api.nvim_set_hl(0, "BufferLineOffsetSeparator", hl_sep_table)
	end
	vim.api.nvim_create_autocmd("ColorScheme", {
		callback = fixBufferLineSeparator,
	})
	fixBufferLineSeparator()
end

return M
