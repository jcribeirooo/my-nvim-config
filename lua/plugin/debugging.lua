local M = {}

function M.setup()
    local dap = require("dap")
    local dapgo = require("dap-go")
    require("dapui").setup({
        controls = {
            enabled = false,
        },
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

    dap.configurations.java = {
        {
            type = "java",
            request = "run",
            name = "Run Java",
            cmd = os.getenv("JAVA_HOME") .. "/bin/java",
        },
        {
            type = "java",
            request = "attach",
            name = "Debug (Attach Port 5005)",
            hostName = "127.0.0.1",
            port = 5005,
        },
    }
end

return M
