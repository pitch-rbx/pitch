--[[
	The entry point for Fuseplug.
]]

local cache = {}
local function Fuseplug(plugin, Fusion)
	if cache[plugin] == nil then
		cache[plugin] = {}
		plugin.Unloading:Connect(function()
			cache[plugin] = nil
		end)
	end

	if cache[plugin][Fusion] ~= nil then
		return cache[plugin][Fusion]
	end

	local Fuseplug = {
		PluginGui = require(script.PluginGui)(plugin, Fusion),
		Toolbar = require(script.Toolbar)(plugin, Fusion)
	}

	cache[plugin][Fusion] = Fuseplug
	return Fuseplug
end

return Fuseplug