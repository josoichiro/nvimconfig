-- ~/.config/nvim/lua/plugins/ai.lua

return {
	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- mcp-hub をすでに自分で npm install していて、
		-- shell から mcp-hub が実行できるなら build は不要
		config = function()
			require("mcphub").setup({
				-- PATH 上の mcp-hub を使う
				cmd = "mcp-hub",

				-- MCPHub の global config
				config = vim.fn.expand("~/.config/mcphub/servers.json"),

				-- 最初は確認ありがおすすめ
				auto_approve = false,

				workspace = {
					enabled = true,
					look_for = {
						".mcphub/servers.json",
						".vscode/mcp.json",
						".cursor/mcp.json",
					},
					reload_on_dir_changed = true,
					port_range = { min = 40000, max = 41000 },
				},
			})
		end,
	},

	{
		"olimorris/codecompanion.nvim",
		version = "^19.0.0",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"ravitemer/mcphub.nvim",
		},
		opts = {
			adapters = {
				acp = {
					codex = function()
						return require("codecompanion.adapters").extend("codex", {
							-- PATH 上の codex-acp を使う
							commands = {
								default = {
									"codex-acp",
								},
							},

							defaults = {
								-- ChatGPT 認証で使う場合
								auth_method = "chatgpt",

								-- API key 認証で使う場合はこちらに変更
								-- auth_method = "openai-api-key",

								timeout = 20000,

								-- 最初は model 未指定でよいです
								-- 必要なら後で指定
								-- session_config_options = {
								--   model = "gpt-5-codex",
								-- },
							},

							-- API key 認証にする場合だけ有効化
							-- env = {
							--   OPENAI_API_KEY = vim.env.OPENAI_API_KEY,
							-- },
						})
					end,
				},
			},

			interactions = {
				chat = {
					-- :CodeCompanionChat のデフォルトを Codex にする
					adapter = "codex",
				},
			},

			extensions = {
				mcphub = {
					callback = "mcphub.extensions.codecompanion",
					opts = {
						make_tools = true,
						show_server_tools_in_chat = true,
						show_result_in_chat = true,

						-- make_vars = true,
						make_vars = false,
						make_slash_commands = true,
					},
				},
			},
		},

		keys = {
			{
				"<leader>aa",
				"<cmd>CodeCompanionActions<cr>",
				mode = { "n", "v" },
				desc = "CodeCompanion actions",
			},
			{
				"<leader>ac",
				"<cmd>CodeCompanionChat Toggle<cr>",
				mode = "n",
				desc = "CodeCompanion chat",
			},
			{
				"<leader>ae",
				"<cmd>CodeCompanion /explain<cr>",
				mode = "v",
				desc = "Explain selection",
			},
			{
				"<leader>af",
				"<cmd>CodeCompanion /fix<cr>",
				mode = "v",
				desc = "Fix selection",
			},
		},
	},

	{
		--		"MeanderingProgrammer/render-markdown.nvim",
		--		ft = { "markdown", "codecompanion" },
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = false,
	},
}
