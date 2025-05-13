--
-- https://github.com/justinsgithub/wezterm-types/blob/main/wezterm.lua
--
-- ---@type Wezterm
-- local wezterm = require("wezterm")
--
-- local act = wezterm.action
--
-- ---@type Config
--local config = {}-- Pull in the wezterm API

local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action

config.color_scheme = "catppuccin-frappe"
config.font_size = 14.0

config.keys = {
	{
		key = "p",
		mods = "CMD",
		action = wezterm.action.ShowLauncher,
	},

	{
		key = "d",
		mods = "CMD",
		action = wezterm.action.SplitPane({
			direction = "Down",
		}),
	},

	{
		key = "d",
		mods = "CMD|SHIFT",
		action = wezterm.action.SplitPane({
			direction = "Right",
		}),
	},

	{
		key = "[",
		mods = "CMD",
		action = act.ActivatePaneDirection("Prev"),
	},

	{
		key = "]",
		mods = "CMD",
		action = act.ActivatePaneDirection("Next"),
	},

	{
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},

	{
		key = "t",
		mods = "CMD",
		-- https://github.com/wez/wezterm/issues/909
		action = wezterm.action_callback(function(win, pane)
			local mux_win = win:mux_window()
			for _, item in ipairs(mux_win:tabs_with_info()) do
				if item.is_active then
					mux_win:spawn_tab({})
					win:perform_action(wezterm.action.MoveTab(item.index + 1), pane)
					return
				end
			end
		end),
	},
}

-- and finally, return the configuration to wezterm
return config
