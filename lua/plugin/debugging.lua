local M = {}

function M.setup()
	local dap = require("dap")
	local dapui = require("dapui")
	local dapgo = require("dap-go")
	local nvimtree = require("nvim-tree.api")
	require("dapui").setup({
		layouts = {
			{
				elements = {
					{
						id = "stacks",
						size = 0.7,
					},
					{
						id = "scopes",
						size = 0.3,
					},
				},
				position = "left",
				size = 40,
			},
			{
				elements = {
					{
						id = "repl",
						size = 1,
					},
				},
				position = "bottom",
				size = 10,
			},
		},
	})

	dapgo.setup()

	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
		nvimtree.tree.close()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
		nvimtree.tree.close()
	end
	dap.listeners.before.event_terminated.dapui_config = function()
		dapui.close()
		nvimtree.tree.open()
	end
	dap.listeners.before.event_exited.dapui_config = function()
		dapui.close()
		nvimtree.tree.open()
	end
end

return M
