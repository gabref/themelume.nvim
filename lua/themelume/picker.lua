local status, _ = pcall(require, 'telescope')
if not status then
	vim.notify("Telescope not installed...", vim.log.levels.ERROR)
	return
end
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local actions_state = require('telescope.actions.state')
local themes = require('telescope.themes')
local config = require('themelume.config')
local transparency = require('themelume.transparency')
local tr_sort = require('themelume.sort')

local M = {}

local tlgroup = vim.api.nvim_create_augroup("ThemeLumeGroup", { clear = true })

local function enter_action(prompt_bufnr)
	local selected = actions_state.get_selected_entry()
	local enable_transparency = vim.fn.confirm("Set background transparent?", "&Yes\n&No", 1) == 1
	transparency.set_colorscheme(selected[1], enable_transparency)
	actions.close(prompt_bufnr)
end

local function preview_colorscheme(prompt_bufnr, direction)
	direction(prompt_bufnr)
	local selected = actions_state.get_selected_entry()
	transparency.set_colorscheme(selected[1], config.settings.transparency_enabled)
end

local function themelumePicker()
	-- loads wanted colorschemes
	for _, color in ipairs(config.settings.colorschemes) do
		if color.name ~= nil then
			vim.cmd("Lazy load " .. color.name)
		end
	end

	-- clear he existing autocommands in the group (if any)
	vim.api.nvim_clear_autocmds({ group = tlgroup })

	vim.api.nvim_create_autocmd("FileType", {
		group = tlgroup,
		pattern = "TelescopePrompt",
		callback = function()
			vim.defer_fn(function()
				local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
				vim.api.nvim_feedkeys(esc, "i", false)
				vim.defer_fn(function()
					local i = vim.api.nvim_replace_termcodes("i", true, false, true)
					vim.api.nvim_feedkeys(i, "n", false)
				end, 50)
			end, 50)
		end
	})

	local available_colors_table = tr_sort.colors_sort(vim.fn.getcompletion("", "color"))
	local opts = {
		prompt_title = "Choose a Colorscheme",
		finder = finders.new_table(available_colors_table),
		sorter = sorters.get_generic_fuzzy_sorter({}),
		attach_mappings = function(_, map)
			map("n", "<cr>", enter_action)
			map("i", "<cr>", enter_action)
			map("i", "<C-j>",
				function(prompt_bufnr)
					preview_colorscheme(prompt_bufnr, actions.move_selection_next)
				end)
			map("i", "<C-k>",
				function(prompt_bufnr)
					preview_colorscheme(prompt_bufnr, actions.move_selection_previous)
				end)
			return true
		end,
	}

	local theme = nil
	if config.settings.theme == 'dropdown' then
		theme = themes.get_dropdown()
	elseif config.settings.theme == 'ivy' then
		theme = themes.get_ivy()
	else
		theme = themes.get_cursor()
	end

	pickers.new(theme, opts):find()

	vim.api.nvim_clear_autocmds({ group = tlgroup })
end

function M.setup()
	vim.api.nvim_create_user_command('ThemelumePicker', themelumePicker, {})

	local default_opts = { noremap = true, silent = true }
	vim.api.nvim_set_keymap("n", config.settings.keymap, ":ThemelumePicker<CR>", default_opts)
end

return M
