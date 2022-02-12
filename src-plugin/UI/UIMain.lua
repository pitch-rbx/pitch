return function(plugin)
	local Package = script.Parent.Parent
	local Fusion  = require(Package.Libraries.Fusion)
	local Fuseplug = require(Package.Libraries.Fuseplug)(plugin, Fusion)
	local New = Fusion.New
	local Children = Fusion.Children
	local OnEvent = Fusion.OnEvent
	local Ref = Fusion.Ref
	local Value = Fusion.Value
	local Computed = Fusion.Computed

	local Theme = require(Package.UI.Theme)
	local Topbar = require(Package.UI.Topbar)
	local PluginList = require(Package.UI.PluginList)
	local Modal = require(Package.UI.Modal)

	local function UIMain()
		local refManagePlugins = Value()

		local guiVisible = Value(false)
		local pluginSet = Value({
			[{
				Title = "Reclass",
				Author = "Elttob",
				Version = "v2.0.3",
				Source = "elttob.itch.io/reclass",
				Icons = {Light = "rbxassetid://6408091702", Dark = "rbxassetid://6408092072"},
				UpdateAvailable = Value(false),
				Enabled = Value(true)
			}] = true,

			[{
				Title = "Imiji",
				Author = "Elttob",
				Version = "v2.0.3",
				Source = "elttob.itch.io/reclass",
				Icons = {Light = "rbxassetid://6408091702", Dark = "rbxassetid://6408092072"},
				UpdateAvailable = Value(true),
				Enabled = Value(true)
			}] = true,

			[{
				Title = "Atmos",
				Author = "Elttob",
				Version = "v2.0.3",
				Source = "elttob.itch.io/reclass",
				Icons = {Light = "rbxassetid://6408091702", Dark = "rbxassetid://6408092072"},
				UpdateAvailable = Value(false),
				Enabled = Value(false)
			}] = true,

			[{
				Title = "InCommand",
				Author = "Elttob",
				Version = "v2.0.3",
				Source = "elttob.itch.io/reclass",
				Icons = {Light = "rbxassetid://6408091702", Dark = "rbxassetid://6408092072"},
				UpdateAvailable = Value(false),
				Enabled = Value(false)
			}] = true
		})

		local updatesAvailable = Computed(function()
			local pluginSet = pluginSet:get()

			for pluginInfo in pairs(pluginSet) do
				if pluginInfo.UpdateAvailable then
					return true
				end
			end

			return false
		end)

		local toolbar = Fuseplug.Toolbar {
			Name = "Pitch",

			Buttons = {
				managePlugins = {
					Name = "Manage Plugins",
					Tooltip = "Manage your Pitch plugins",
					Icon = "",

					[Ref] = refManagePlugins,
					[OnEvent "Click"] = function()
						guiVisible:set(not guiVisible:get())
					end
				}
			}
		}

		local pluginGui = Fuseplug.PluginGui {
			ID = "Pitch_ManagePlugins",
			InitialDockTo = "Float",
			InitialEnabled = false,
			ForceInitialEnabled = true,
			FloatingSize = Vector2.new(400, 300),
			MinimumSize = Vector2.new(300, 200),

			Title = "Manage Plugins",
			Enabled = guiVisible,

			[Children] = New "Frame" {
				Name = "Content",

				BackgroundColor3 = Theme.background,
				Size = UDim2.fromScale(1, 1),

				[Children] = {
					Topbar {
						UpdatesAvailable = updatesAvailable
					},
					PluginList {
						Contents = pluginSet,
						OpenPluginSettings = function(pluginToInspect)
							currentModal:set(
								Modal {}
							)
						end,
					},
					Modal {

					}
				}
			}
		}

		return {
			toolbar = toolbar,
			pluginGui = pluginGui
		}
	end

	return UIMain
end