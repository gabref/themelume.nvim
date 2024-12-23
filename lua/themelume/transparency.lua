local M = {}

local config = require("themelume.config")

function M.apply_transparency_fallback(enable)
	if enable then
		vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
		vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
	else
		vim.cmd('highlight clear Normal')
		vim.cmd('highlight clear NormalFloat')
	end
end

function M.apply_transparency(enable)
	if enable then
		vim.cmd(':TransparentEnable')
	else
		vim.cmd(':TransparentDisable')
	end
end

function M.setup()
	M.set_colorscheme(config.settings.default_colorscheme, config.settings.transparency_enabled)

	Has_trasp = false
	local status, transparent = pcall(require, 'transparent')
	if not status then
		vim.notify("Dependency Transparent not installed...", vim.log.levels.WARN)
		return
	end
	Has_trasp = true
	transparent.setup({
		extra_groups = {
			"BufferLineTabClose",
			"BufferlineBufferSelected",
			"BufferLineFill",
			"BufferLineBackground",
			"BufferLineSeparator",
			"BufferLineIndicatorSelected",
			"NormalFloat",
		},
		exclude_groups = {},
	})
end

function M.set_colorscheme(colorscheme, enable_transparency)
	vim.cmd.colorscheme(colorscheme)
	if Has_trasp then
		M.apply_transparency(enable_transparency)
	else
		M.apply_transparency_fallback(enable_transparency)
	end
end

return M
