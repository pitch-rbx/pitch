local Package = script.Parent.Parent
local Fusion  = require(Package.Libraries.Fusion)
local New = Fusion.New
local Hydrate = Fusion.Hydrate
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local Ref = Fusion.Ref
local Value = Fusion.Value
local Computed = Fusion.Computed
local ComputedPairs = Fusion.ComputedPairs

local Theme = require(Package.UI.Theme)
local Switch = require(Package.UI.Switch)

local function UpdateNotice(props)
	return New "TextLabel" {
		Name = "UpdateNotice",

		BackgroundColor3 = Theme.accent,
		BackgroundTransparency = 0.75,

		AutomaticSize = "XY",
		LayoutOrder = 1,

		Visible = props.Visible,

		Text = "Update available",
		TextColor3 = Theme.accentText,

		[Children] = {
			New "UIPadding" {
				PaddingLeft = UDim.new(0, 6),
				PaddingRight = UDim.new(0, 6)
			},

			New "UICorner" {
				CornerRadius = UDim.new(1, 0)
			}
		}
	}
end

local function PluginListEntry(props)
	return New "Frame" {
		Name = Computed(function()
			return (if props.Info.Enabled:get() then "a" else "z")
				.. (if props.Info.UpdateAvailable:get() then "a" else "z")
				.. props.Info.Title
		end),

		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 50),

		[Children] = {
			New "Frame" {
				Name = "Divider",

				Position = UDim2.fromScale(0, 1),
				Size = UDim2.new(1, 0, 0, 1),

				BackgroundColor3 = Theme.text,
				BackgroundTransparency = 0.9
			},

			New "ImageLabel" {
				Name = "Icon",

				BackgroundTransparency = 1,

				Position = UDim2.new(0, 12, 0.5, 0),
				AnchorPoint = Vector2.new(0, 0.5),
				Size = UDim2.fromOffset(32, 32),

				Image = Computed(function()
					return if Theme.isDark:get() then props.Info.Icons.Dark else props.Info.Icons.Light
				end)
			},

			New "Frame" {
				Name = "NameStack",

				Position = UDim2.new(0, 52, 0.5, 0),
				AutomaticSize = "XY",
				AnchorPoint = Vector2.new(0, 0.5),

				BackgroundTransparency = 1,

				[Children] = {
					New "UIListLayout" {
						SortOrder = "LayoutOrder"
					},

					New "TextLabel" {
						Name = "Title",

						BackgroundTransparency = 1,
						AutomaticSize = "XY",
						Size = UDim2.fromOffset(0, 16),
						LayoutOrder = 1,

						Text = props.Info.Title,
						TextColor3 = Theme.text,

						TextXAlignment = "Left"
					},

					New "TextLabel" {
						Name = "Author",

						BackgroundTransparency = 1,
						AutomaticSize = "XY",
						LayoutOrder = 2,

						Text = "By " .. props.Info.Author,
						TextColor3 = Theme.text,
						TextTransparency = 0.4,

						TextXAlignment = "Left"
					}
				}
			},

			New "Frame" {
				Name = "Actions",

				Position = UDim2.new(1, -12, 0.5, 0),
				AutomaticSize = "XY",
				AnchorPoint = Vector2.new(1, 0.5),

				BackgroundTransparency = 1,

				[Children] = {
					New "UIListLayout" {
						Padding = UDim.new(0, 8),
						SortOrder = "LayoutOrder",
						FillDirection = "Horizontal",
						HorizontalAlignment = "Right"
					},

					New "ImageButton" {
						Name = "Settings",

						BackgroundTransparency = 1,
						Size = UDim2.fromOffset(16, 16),
						LayoutOrder = 3,
					},

					Switch {
						Enabled = props.Info.Enabled,
						LayoutOrder = 2
					},

					UpdateNotice {
						Visible = props.Info.UpdateAvailable
					}
				}
			}
		}
	}
end

local function PluginList(props)
	return New "Frame" {
		Name = "PluginList",

		BackgroundTransparency = 1,

		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0, 1, -32),
		AnchorPoint = Vector2.new(0, 1),

		[Children] = {
			New "UIListLayout" {
				SortOrder = "Name"
			},

			ComputedPairs(props.Contents, function(pluginInfo)
				return PluginListEntry {
					Info = pluginInfo
				}
			end)
		}
	}
end

return PluginList