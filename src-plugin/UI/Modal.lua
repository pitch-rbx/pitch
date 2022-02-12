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

local function Modal(props)
	return New "TextButton" {
		Name = "ModalSmoke",

		BackgroundColor3 = Theme.smoke,
		BackgroundTransparency = 0.1,

		Size = UDim2.fromScale(1, 1),
		ZIndex = 1000,

		[Children] = New "ScrollingFrame" {
			Name = "ModalScroll",

		}
	}
end

return Modal