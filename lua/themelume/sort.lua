local M = {}

local config = require('themelume.config')

function M.colors_sort(colors_table)
	-- Colorschemes to be moved to the end
	local move_to_end = {
		-- default colorschemes
		"blue", "darkblue", "delek", "desert", "elflord",
		"evening", "industry", "koehler", "morning",
		"murphy", "pablo", "peachpuff", "ron",
		"shine", "slate", "sorbet", "torte", "zellner", "lunaperche",
		"default", "quiet", "habamax",
		-- white colorschemes
		"catppuccin-latte", "kanagawa-lotus", "rose-pine",
		"rose-pine-dawn", "solarized-osaka-day", "tokyonight-day",
		"modus_operandi",
		-- problematic themes
		"noirbuddy"
	}

	for _, v in ipairs(config.settings.push_to_bottom) do
		table.insert(move_to_end, v)
	end

	-- add to move_to_end the colorschemes that have 'light' in their name
	for _, color in ipairs(colors_table) do
		if string.find(color, 'light') then
			table.insert(move_to_end, color)
		end
	end

	-- Create a table to store the reordered colorschemes
	local reordered_table = {}

	-- Add colorschemes not in move_to_end to the reordered_table
	for _, color in ipairs(colors_table) do
		if not vim.tbl_contains(move_to_end, color) then
			table.insert(reordered_table, color)
		end
	end

	-- Add colorschemes in move_to_end to the end of the reordered_table
	for _, color in ipairs(move_to_end) do
		table.insert(reordered_table, color)
	end

	return reordered_table
end

return M
