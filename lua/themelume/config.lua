local M = {}

---@class Colorscheme
---@field name string # The name of the colorscheme

---@class ThemelumeConfig
---@field colorschemes Colorscheme[] # List of colorschemes
---@field lazy_load string[] # Plugins to lazy load
---@field default_colorscheme string # Default colorscheme
---@field transparency_enabled boolean # Default transparency setting
---@field push_to_bottom string[] # colorschemes to be the last in the list
---@field keymap string # Keybinding for invoking the picker
---@field theme 'ivy' | 'dropdown' | 'cursor'

---@type ThemelumeConfig
M.settings = {
	colorschemes = {},
	lazy_load = {},
	default_colorscheme = 'rose-pine',
	transparency_enabled = false,
	push_to_bottom = {},
	keymap = "<leader>t",
	theme = 'dropdown',
}

---@param user_config ThemelumeConfig?
function M.setup(user_config)
	M.settings = vim.tbl_deep_extend("force", M.settings, user_config or {})
end

return M
