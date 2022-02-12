--[[
	Component for creating plugin toolbars.
]]

return function(plugin, Fusion)
	local Hydrate = Fusion.Hydrate

	local function Toolbar(props)
		local toolbar = plugin:CreateToolbar(props.Name)

		for buttonID, buttonInfo in pairs(props.Buttons) do
			-- TODO: make this support dynamic icons
			local button = toolbar:CreateButton(buttonID, buttonInfo.Tooltip, buttonInfo.Icon, buttonInfo.Name)
			buttonInfo.Tooltip = nil

			Hydrate(button)(buttonInfo)
		end

		return toolbar
	end

	return Toolbar
end