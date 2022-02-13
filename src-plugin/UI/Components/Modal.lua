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

local function Modal(props)
	local animVisible = Spring(Computed(function()
		return if props.Visible:get() then 1 else 0
	end), 50)

	return New "TextButton" {
		Name = "ModalSmoke",

		BackgroundColor3 = Theme.smoke,
		BackgroundTransparency = Computed(function()
			return 1 - (0.9 * animVisible:get())
		end),

		Visible = Computed(function()
			return animVisible:get() > 0.001
		end),

		Size = UDim2.fromScale(1, 1),
		ZIndex = 1000,

		[Children] = New "ScrollingFrame" {
			Name = "ModalScroll",

		}
	}
end

return Modal