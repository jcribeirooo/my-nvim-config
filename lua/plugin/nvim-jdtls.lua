local M = {}

function M.setup()
    local jdtls_path = vim.fn.stdpath("data") .. "/mason/share/jdtls"
    local path_to_lsp_server = jdtls_path .. "/config"
    local path_to_launcher = jdtls_path .. "/plugins/org.eclipse.equinox.launcher.jar"
    local lombok_path = jdtls_path .. "/lombok.jar"
    local root_markers = { "mvnw", "gradlew", "pom.xml", "build.gradle" }
    local root_dir = require("jdtls.setup").find_root(root_markers)
    if root_dir == "" then
        return
    end
    local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
    local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name
    os.execute("mkdir -p " .. workspace_dir)
    local jdtls = require("jdtls")
    local bundles = {
        vim.fn.glob(vim.fn.stdpath("config") .. "/resources/java-debug.jar", true),
    }
    vim.list_extend(
        bundles,
        vim.split(vim.fn.glob(vim.fn.stdpath("config") .. "/resources/vscode-java-test-main/server/*.jar", true), "\n")
    )

    local config = {
        cmd = {
            os.getenv("JAVA_HOME") .. "bin/java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.protocol=true",
            "-Dlog.level=ALL",
            "-javaagent:" .. lombok_path,
            "-Xmx1g",
            "--add-modules=ALL-SYSTEM",
            "--add-opens",
            "java.base/java.util=ALL-UNNAMED",
            "--add-opens",
            "java.base/java.lang=ALL-UNNAMED",
            "-jar",
            path_to_launcher,
            "-configuration",
            path_to_lsp_server,
            "-data",
            workspace_dir,
        },

        root_dir = root_dir,

        settings = {
            java = {
                home = os.getenv("JAVA_HOME"),
                eclipse = {
                    downloadSources = true,
                },
                configuration = {
                    updateBuildConfiguration = "interactive",
                    runtimes = {
                        {
                            name = "JavaSE-18",
                            path = os.getenv("JAVA_HOME"),
                        },
                    },
                },
                maven = {
                    downloadSources = true,
                },
                implementationsCodeLens = {
                    enabled = true,
                },
                referencesCodeLens = {
                    enabled = true,
                },
                references = {
                    includeDecompiledSources = true,
                },
                format = {
                    enabled = true,
                    settings = {
                        url = vim.fn.stdpath("config") .. "/resources/java-google-style.xml",
                        profile = "GoogleStyle",
                    },
                },
            },
            signatureHelp = { enabled = true },
            completion = {
                favoriteStaticMembers = {
                    "org.hamcrest.MatcherAssert.assertThat",
                    "org.hamcrest.Matchers.*",
                    "org.hamcrest.CoreMatchers.*",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
                importOrder = {
                    "java",
                    "javax",
                    "com",
                    "org",
                },
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999,
                },
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                },
                useBlocks = true,
            },
        },

        flags = {
            allow_incremental_sync = true,
        },

        init_options = {
            bundles = bundles
        },
    }

    vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
            jdtls.start_or_attach(config)
            vim.keymap.set("n", "<F9>", function() require'jdtls'.test_class() end)
            vim.keymap.set('n', '<leader><F5>', function() require'jdtls'.test_nearest_method() end)
            vim.keymap.set("n", "<leader>gf", function()
                require("jdtls").organize_imports()
                vim.lsp.buf.format()
            end, {})
        end,
    })
end

return M
