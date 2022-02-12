local Package = script.Parent.Parent
local Fusion = require(Package.Libraries.Fusion)
local Value = Fusion.Value
local Computed = Fusion.Computed

local COLOURS = {
	background = {
		light = Color3.fromHSV(0, 0, 0.97),
		dark = Color3.fromHSV(0, 0, 0.18)
	},
	text = {
		light = Color3.fromHSV(0, 0, 0.18),
		dark = Color3.fromHSV(0, 0, 0.87)
	},
	solidDark = {
		light = Color3.fromHSV(0, 0, 0.3),
		dark = Color3.fromHSV(0, 0, 0.8)
	},
	solidLight = {
		light = Color3.fromHSV(0, 0, 0.8),
		dark = Color3.fromHSV(0, 0, 0.3)
	},

	accent = {
		light = Color3.fromHSV(0.3972, 0.8, 0.66),
		dark = Color3.fromHSV(0.3972, 0.8, 0.66)
	},
	accentContent = {
		light = Color3.fromHSV(0, 0, 1),
		dark = Color3.fromHSV(0, 0, 1)
	},
	accentText = {
		light = Color3.fromHSV(0.3972, 0.81, 0.16),
		dark = Color3.fromHSV(0.3972, 0.29, 0.93)
	},

	titleBar = {
		light = Color3.fromHSV(0.3972, 0.8, 0.66),
		dark = Color3.fromHSV(0, 0, 0.24)
	},
	titleBarText = {
		light = Color3.fromHSV(0, 0, 1),
		dark = Color3.fromHSV(0, 0, 0.87)
	},
	titleBarButton = {
		light = Color3.fromHSV(0, 0, 1),
		dark = Color3.fromHSV(0.3972, 0.8, 0.66)
	},
	titleBarButtonText = {
		light = Color3.fromHSV(0.3972, 0.8, 0.66),
		dark = Color3.fromHSV(0, 0, 1)
	}
}

local currentTheme = Value()

local function updateCurrentTheme()
	local studioBG = settings().Studio.Theme:GetColor("MainBackground")
	local isDark = studioBG.r + studioBG.g + studioBG.g < 1.5
	currentTheme:set(if isDark then "dark" else "light")
end
updateCurrentTheme()
settings().Studio.ThemeChanged:Connect(updateCurrentTheme)

local Theme = {}

for colourName, colours in pairs(COLOURS) do
	Theme[colourName] = Computed(function()
		return colours[currentTheme:get()]
	end)
end

Theme.isDark = Computed(function()
	return currentTheme:get() == "dark"
end)

return Theme