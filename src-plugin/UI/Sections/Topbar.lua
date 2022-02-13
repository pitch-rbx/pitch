local Package = script.Parent.Parent.Parent
local Fusion  = require(Package.Libraries.Fusion)
local New = Fusion.New
local Hydrate = Fusion.Hydrate
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local Ref = Fusion.Ref
local Value = Fusion.Value

local Theme = require(Package.UI.Theme)
local Button = require(Package.UI.Components.Button)

local function Topbar(props)
	return New "Frame" {
		Name = "Topbar",

		BackgroundColor3 = Theme.titleBar,
		Size = UDim2.new(1, 0, 0, 32),

		[Children] = {
			New "UIPadding" {
				PaddingTop = UDim.new(0, 12),
				PaddingBottom = UDim.new(0, 12),
				PaddingLeft = UDim.new(0, 12),
				PaddingRight = UDim.new(0, 12)
			},

			New "TextLabel" {
				Name = "Title",

				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0, .5),
				AutomaticSize = "X",
				Size = UDim2.fromScale(1, 0),

				Text = "Your installed plugins",
				TextColor3 = Theme.titleBarText,
				TextXAlignment = "Left"
			},

			Button {
				Position = UDim2.fromScale(1, .5),
				AnchorPoint = Vector2.new(1, .5),
				Visible = props.UpdatesAvailable,

				Text = "Update all",
				Color = Theme.titleBarButton,
				TextColor = Theme.titleBarButtonText
			}
		}
	}
end

return Topbar