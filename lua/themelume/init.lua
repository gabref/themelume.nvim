local config = require('themelume.config')
local picker = require('themelume.picker')
local transparency = require('themelume.transparency')

local themelume = {}

function themelume.setup(user_config)
	config.setup(user_config)
	picker.setup()
	transparency.setup()
end

return themelume
