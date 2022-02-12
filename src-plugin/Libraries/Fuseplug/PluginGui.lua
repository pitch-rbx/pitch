--[[
	Component for creating dock widgets.
]]

return function(plugin, Fusion)
	local Hydrate = Fusion.Hydrate

	local function PluginGui(props)
		local pluginGui = plugin:CreateDockWidgetPluginGui(
			props.ID,
			DockWidgetPluginGuiInfo.new(
				if typeof(props.InitialDockTo) == "string" then Enum.InitialDockState[props.InitialDockTo] else props.InitialDockTo,
				props.InitialEnabled,
				props.ForceInitialEnabled,
				props.FloatingSize.X, props.FloatingSize.Y,
				props.MinimumSize.X, props.MinimumSize.Y
			)
		)

		-- get rid of the 'initial' props
		props.ID = nil
		props.InitialDockTo = nil
		props.InitialEnabled = nil
		props.ForceInitialEnabled = nil
		props.FloatingSize = nil
		props.MinimumSize = nil

		-- sync name with title
		props.Name = props.Title

		return Hydrate(pluginGui)(props)
	end

	return PluginGui
end