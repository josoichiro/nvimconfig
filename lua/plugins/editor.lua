-- ~/.config/nvim/lua/plugins/editor.lua

return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
			{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
			{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
		},
		opts = {},
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle left<cr>", desc = "Toggle file explorer" },
			{ "<leader>E", "<cmd>Neotree reveal left<cr>", desc = "Reveal current file" },
		},
		opts = {
			close_if_last_window = false,
			enable_git_status = true,
			enable_diagnostics = true,
			default_component_configs = {
				name = {
					use_git_status_colors = true,
				},

				git_status = {
					symbols = {
						-- Change type
						added = "",
						modified = "",
						deleted = "",
						renamed = "",

						-- Status type
						untracked = "",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "",
					},
				},
			},

			commands = {
				preview_image_wezterm = function(state)
					local node = state.tree:get_node()
					if not node or node.type ~= "file" then
						return
					end

					require("utils.image_preview").preview_in_wezterm(node.path)
				end,
			},

			filesystem = {
				hijack_netrw_behavior = "open_default",

				follow_current_file = {
					enabled = true,
				},

				use_libuv_file_watcher = true,

				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
			},

			window = {
				position = "left",
				width = 26,
				mappings = {
					["<space>"] = "none",
					["<cr>"] = "open",
					["s"] = "open_vsplit",
					["S"] = "open_split",
					["P"] = "preview_image_wezterm",
				},
			},
		},
	},
}

