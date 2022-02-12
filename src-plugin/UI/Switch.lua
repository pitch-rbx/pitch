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

local function Switch(props)

	local animEnabled = Spring(Computed(function()
		return if props.Enabled:get() then 1 else 0
	end), 50)

	return New "TextButton" {
		Name = "Track",

		Position = props.Position,
		AnchorPoint = props.AnchorPoint,
		LayoutOrder = props.LayoutOrder,
		Visible = props.Visible,
		ZIndex = props.ZIndex,

		BackgroundColor3 = Computed(function()
			return Theme.solidLight:get():Lerp(Theme.accent:get(), animEnabled:get())
		end),

		Size = UDim2.fromOffset(32, 16),

		[OnEvent "Activated"] = props.OnClick or function()
			props.Enabled:set(not props.Enabled:get())
		end,

		[Children] = {
			New "UICorner" {
				CornerRadius = UDim.new(1, 0)
			},

			New "UIPadding" {
				PaddingTop = UDim.new(0, 2),
				PaddingBottom= UDim.new(0, 2),
				PaddingLeft = UDim.new(0, 2),
				PaddingRight = UDim.new(0, 2)
			},

			New "Frame" {
				Name = "Knob",

				BackgroundColor3 = Computed(function()
					return Theme.solidDark:get():Lerp(Theme.accentContent:get(), animEnabled:get())
				end),
				Position = Computed(function()
					return UDim2.fromScale(animEnabled:get(), 0)
				end),
				Size = Computed(function()
					return UDim2.fromScale(1, 1)
				end),
				SizeConstraint = "RelativeYY",
				AnchorPoint = Computed(function()
					return Vector2.new(animEnabled:get(), 0)
				end),

				[Children] = New "UICorner" {
					CornerRadius = UDim.new(1, 0)
				}
			}
		}
	}
end

return Switch