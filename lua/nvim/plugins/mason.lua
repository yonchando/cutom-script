return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
        "dcampos/cmp-emmet-vim",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        local util = require 'lspconfig.util'

        vim.keymap.set("n", "<leader>ms", function()
            vim.cmd("Mason")
        end)

        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        local mason_lspconfig = require("mason-lspconfig")

        local handler = {
            function(server_name)
                local mason_registry = require('mason-registry')
                local vue_language_server_path = "";
                if mason_registry.is_installed('vue-language-server') then
                    vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() ..
                        '/node_modules/@vue/language-server'
                end

                local configs = {
                    yamlls = {
                        settings = {
                            yaml = {
                                schemas = {
                                    ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json"] =
                                    "/aws.yaml",
                                    ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] =
                                    "/docker-compose.yaml"
                                }
                            }
                        },
                    },
                    emmet_ls = {
                        filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "svelte", "pug", "typescriptreact", "vue" },
                        init_options = {
                            html = {
                                options = {
                                    -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                                    ["bem.enabled"] = true,
                                },
                            },
                        },
                    },
                    lua_ls = {
                        settings = {
                            Lua = {
                                completion = {
                                    callSnippet = "Replace"
                                },
                                workspace = {
                                    checkThirdParty = false,
                                },
                                globals = {
                                    "vim",
                                    "describe",
                                    "it"
                                },
                                diagnostics = {
                                    globals = { "vim" }
                                }
                            }
                        }
                    },
                    bashls = {
                        filetypes = {
                            "sh",
                            "zsh",
                        }
                    },
                    html = {
                        filetypes = {
                            "html",
                            "blade",
                        }
                    },
                    denols = {
                        root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
                    },
                    ts_ls = {
                        root_dir = lspconfig.util.root_pattern("package.json"),
                        single_file_support = false,
                        init_options = {
                            plugins = {
                                {
                                    name = "@vue/typescript-plugin",
                                    location = vue_language_server_path,
                                    languages = { "vue" },
                                }
                            }
                        },
                        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
                    },
                    volar = {}
                }

                capabilities.textDocument = {
                    completion = {
                        completionItem = {
                            snipetSupport = true
                        }
                    }
                }
                local config = configs[server_name]

                if config == nil then
                    config = {}
                end

                config.capabilities = capabilities

                lspconfig[server_name].setup(config)

                lspconfig.clangd.setup(config)
            end,
        }

        mason_lspconfig.setup({
            ensure_installed = {
                "lua_ls",
                "bashls"
            },
            automatic_installation = false,
            handlers = handler,
        })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                vim.keymap.set('n', '<C-q>', vim.lsp.buf.hover, { desc = "Hover", silent = true })
                vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = "Rename", silent = true })
                vim.keymap.set('n', 'gs', vim.lsp.buf.signature_help, { desc = "signature_help", silent = true })
                vim.keymap.set({ 'n', 'v' }, '<space>i', vim.lsp.buf.code_action,
                    { desc = "Code Actions", silent = true })
            end,
        })
    end
}
