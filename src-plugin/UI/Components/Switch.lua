local Package = script.Parent.Parent.Parent
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
	local isHovering = Value(false)
	local isPressed = Value(false)

	local animKnobPosition = Spring(Computed(function()
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
			return Theme.solidLight:get():Lerp(Theme.accent:get(), animKnobPosition:get())
		end),

		Size = UDim2.fromOffset(32, 16),

		[OnEvent "Activated"] = props.OnClick or function()
			props.Enabled:set(not props.Enabled:get())
		end,

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
					Theme.isDark:get()
					return Theme.solidDark:get():Lerp(Theme.accentContent:get(), animKnobPosition:get())
				end),
				Position = Computed(function()
					return UDim2.fromScale(animKnobPosition:get(), 0)
				end),
				Size = UDim2.fromScale(1, 1),
				AnchorPoint = Computed(function()
					return Vector2.new(animKnobPosition:get(), 0)
				end),

				[Children] = {
					New "UICorner" {
						CornerRadius = UDim.new(1, 0)
					},

					New "UIAspectRatioConstraint" {
						AspectRatio = Spring(Computed(function()
							return if isPressed:get() then 1.5 else 1
						end), 50)
					}
				}
			}
		}
	}
end

return Switch