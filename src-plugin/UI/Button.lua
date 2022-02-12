local Package = script.Parent.Parent
local Fusion  = require(Package.Libraries.Fusion)
local New = Fusion.New
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local Ref = Fusion.Ref
local Value = Fusion.Value
local Computed = Fusion.Computed
local Spring = Fusion.Spring

local Theme = require(Package.UI.Theme)

local function Button(props)
	local isHovering = Value(false)
	local isPressed = Value(false)

	return New "TextButton" {
		Name = "Button",

		Position = props.Position,
		AnchorPoint = props.AnchorPoint,
		LayoutOrder = props.LayoutOrder,
		Visible = props.Visible,
		ZIndex = props.ZIndex,

		BackgroundColor3 = props.Color or Theme.accent,
		Size = UDim2.fromOffset(0, 24),
		AutomaticSize = "X",

		Text = props.Text,
		TextColor3 = props.TextColor or Theme.accentContent,

		[OnEvent "MouseEnter"] = function()
			isHovering:set(true)
		end,

		[OnEvent "MouseLeave"] = function()
			isHovering:set(false)
			isPressed:set(false)
		end,

		[OnEvent "MouseButton1Down"] = function()
			isPressed:set(true)
		end,

		[OnEvent "MouseButton1Up"] = function()
			isPressed:set(false)
		end,

		[Children] = {
			New "UIPadding" {
				PaddingLeft = UDim.new(0, 6),
				PaddingRight = UDim.new(0, 6)
			},

			New "UICorner" {
				CornerRadius = UDim.new(0, 4)
			},

			New "Frame" {
				Name = "Overlay",

				BackgroundColor3 = Color3.new(0, 0, 0),
				BackgroundTransparency = Spring(Computed(function()
					return if isPressed:get() then 0.75 elseif isHovering:get() then 0.9 else 1
				end), 50),

				Size = UDim2.new(1, 12, 1, 0),
				AnchorPoint = Vector2.new(.5, .5),
				Position = UDim2.fromScale(.5, .5),

				[Children] = New "UICorner" {
					CornerRadius = UDim.new(0, 4)
				}
			}
		}
	}
end

return Button