local library = {}

local CloneRef = cloneref or function(v) return v end

local Players = CloneRef(game:GetService("Players"))
local RunService = CloneRef(game:GetService("RunService"))
local UserInputService = CloneRef(game:GetService("UserInputService"))
local TweenService = CloneRef(game:GetService("TweenService"))
local CoreGui = CloneRef(game:GetService("CoreGui"))
local HttpService = CloneRef(game:GetService("HttpService"))
local Workspace = CloneRef(game:GetService("Workspace"))
local GuiService = CloneRef(game:GetService("GuiService"))
local MarketplaceService = CloneRef(game:GetService("MarketplaceService"))

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local CurrentPage = "Main"

library.theme = {
	fontsize = 14,
	smallfontsize = 12,

	font = Font.new(
		"rbxasset://fonts/families/SourceSansPro.json",
		Enum.FontWeight.Regular,
		Enum.FontStyle.Normal
	),

	colors = {
		-- Main
		backgroundcolor = Color3.fromRGB(25, 20, 36),

		-- Tabs
		activetabscolor = Color3.fromRGB(53, 38, 77),
		inactivetabscolor = Color3.fromRGB(36, 27, 51),

		-- Accent
		primarycolor = Color3.fromRGB(183, 117, 245),
		secondarycolor = Color3.fromRGB(72, 47, 107),

		-- Text
		titlecolor = Color3.fromRGB(205,201,212),
		inactivefontcolor = Color3.fromRGB(111,88,145),
		descriptioncolor = Color3.fromRGB(111,104,122),

		-- Border
		strokecolor = Color3.fromRGB(183,117,245),
		shadowcolor = Color3.fromRGB(183,117,245),
	},

	transparency = {
		primary = 0.3,
		secondary = 0.7,
	}
}

local charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

local tweeninfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

function library:tween(object, goal, callback)
	local tween = TweenService:Create(object, tweeninfo, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end

local function SetupTopButton(button, scaleObject, stroke, shadow)
	button.MouseEnter:Connect(function()
		library:tween(scaleObject, {
			Scale = 1.08
		})

		library:tween(button, {
			BackgroundColor3 = Color3.fromRGB(35, 29, 49)
		})

		library:tween(stroke, {
			Transparency = 0.25
		})

		library:tween(shadow, {
			Transparency = 0.35
		})
	end)

	button.MouseLeave:Connect(function()
		library:tween(scaleObject, {
			Scale = 1
		})

		library:tween(button, {
			BackgroundColor3 = Color3.fromRGB(26, 21, 37)
		})

		library:tween(stroke, {
			Transparency = 0.8
		})

		library:tween(shadow, {
			Transparency = 0.7
		})
	end)

	button.MouseButton1Down:Connect(function()
		library:tween(scaleObject, {
			Scale = 0.96
		})
	end)

	button.MouseButton1Up:Connect(function()
		library:tween(scaleObject, {
			Scale = 1.08
		})
	end)
end

function library:randomcode(length)
	local result = table.create(length)

	for i = 1, length do
		local index = math.random(#charset)
		result[i] = charset:sub(index, index)
	end

	return table.concat(result)
end

function library:CreateWindow(hidebutton)
	local window = {}
	local settings = {}
	window.size = UDim2.fromOffset(500, 300)
	window.hidebutton = hidebutton or Enum.KeyCode.Insert
	window.theme = library.theme

	local updateevent = Instance.new("BindableEvent")

	local function ShowMain()
		window.frame.Visible = not window.frame.Visible
	end

	local function CloseUI()
		window.main:Destroy()
	end

	local function ShowSettings()
		settings.settingsframe.Visible = not settings.settingsframe.Visible
	end

	window.main = Instance.new("ScreenGui", CoreGui)
	window.main.IgnoreGuiInset = true
	window.main.DisplayOrder = 15
	window.main.ZIndexBehavior = Enum.ZIndexBehavior.Global
	window.main.ResetOnSpawn = false
	window.main.Name = ("BrrPatapimpum-%s"):format(library:randomcode(10))

	window.background = Instance.new("Frame", window.main)
	window.background.ZIndex = -15
	window.background.BorderSizePixel = 0
	window.background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	window.background.Size = UDim2.new(1, 0, 1, 0)
	window.background.Name = [[background]]
	window.background.BackgroundTransparency = 0.3

	window.topbuttons = Instance.new("Frame", window.main)
	window.topbuttons.ZIndex = -14
	window.topbuttons.BorderSizePixel = 0
	window.topbuttons.AnchorPoint = Vector2.new(0.5, 0)
	window.topbuttons.AutomaticSize = Enum.AutomaticSize.X
	window.topbuttons.Size = UDim2.new(0, 0, 0, 50)
	window.topbuttons.Position = UDim2.new(0.5, 0, 0, 0)
	window.topbuttons.Name = [[topbuttons]]
	window.topbuttons.BackgroundTransparency = 1

	window.UILisLayouttop = Instance.new("UIListLayout", window.topbuttons)
	window.UILisLayouttop.HorizontalAlignment = Enum.HorizontalAlignment.Center
	window.UILisLayouttop.Padding = UDim.new(0, 10)
	window.UILisLayouttop.VerticalAlignment = Enum.VerticalAlignment.Center
	window.UILisLayouttop.SortOrder = Enum.SortOrder.LayoutOrder
	window.UILisLayouttop.FillDirection = Enum.FillDirection.Horizontal

	window.mainbutton = Instance.new("ImageButton", window.topbuttons)
	window.mainbutton.BorderSizePixel = 0
	window.mainbutton.AutoButtonColor = false
	window.mainbutton.BackgroundColor3 = Color3.fromRGB(26, 21, 37)
	window.mainbutton.ImageColor3 = Color3.fromRGB(184, 118, 246)
	window.mainbutton.Image = [[rbxassetid://87935137285541]]
	window.mainbutton.Size = UDim2.new(0, 35, 0, 35)
	window.mainbutton.Name = [[MainButton]]

	local cornermain = Instance.new("UICorner", window.mainbutton)
	cornermain.CornerRadius = UDim.new(0, 5)

	local strokemain = Instance.new("UIStroke", window.mainbutton)
	strokemain.Transparency = 0.8
	strokemain.Color = Color3.fromRGB(184, 118, 246)

	local shadowmain = Instance.new("UIShadow", window.mainbutton)
	shadowmain.Transparency = 0.7
	shadowmain.Color = Color3.fromRGB(184, 118, 246)
	shadowmain.BlurRadius = UDim.new(0, 10)

	local uiscalemain = Instance.new("UIScale", window.mainbutton)
	uiscalemain.Scale = 1

	SetupTopButton(window.mainbutton, uiscalemain, strokemain, shadowmain)
	window.mainbutton.MouseButton1Click:Connect(ShowMain)

	window.settingsbutton = Instance.new("ImageButton", window.topbuttons)
	window.settingsbutton.BorderSizePixel = 0
	window.settingsbutton.AutoButtonColor = false
	window.settingsbutton.BackgroundColor3 = Color3.fromRGB(26, 21, 37)
	window.settingsbutton.ImageColor3 = Color3.fromRGB(184, 118, 246)
	window.settingsbutton.Image = [[rbxassetid://78199313138278]]
	window.settingsbutton.Size = UDim2.new(0, 35, 0, 35)
	window.settingsbutton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	window.settingsbutton.Name = [[SettingsButton]]

	local cornersettings = Instance.new("UICorner", window.settingsbutton)
	cornersettings.CornerRadius = UDim.new(0, 5)

	local strokemain = Instance.new("UIStroke", window.settingsbutton)
	strokemain.Transparency = 0.8
	strokemain.Color = Color3.fromRGB(184, 118, 246)

	local shadowsettings = Instance.new("UIShadow", window.settingsbutton)
	shadowsettings.Transparency = 0.7
	shadowsettings.Color = Color3.fromRGB(184, 118, 246)
	shadowsettings.BlurRadius = UDim.new(0, 10)

	local uiscalesettings = Instance.new("UIScale", window.settingsbutton)
	uiscalesettings.Scale = 1

	SetupTopButton(window.settingsbutton, uiscalesettings, strokemain, shadowsettings)
	window.settingsbutton.MouseButton1Click:Connect(ShowSettings)

	window.closebutton = Instance.new("ImageButton", window.topbuttons)
	window.closebutton.BorderSizePixel = 0
	window.closebutton.AutoButtonColor = false
	window.closebutton.BackgroundColor3 = Color3.fromRGB(26, 21, 37)
	window.closebutton.ImageColor3 = Color3.fromRGB(184, 118, 246)
	window.closebutton.Image = [[rbxassetid://139770332609021]]
	window.closebutton.Size = UDim2.new(0, 35, 0, 35)
	window.closebutton.BorderColor3 = Color3.fromRGB(0, 0, 0)
	window.closebutton.Name = [[CloseButton]]

	local cornerclose = Instance.new("UICorner", window.closebutton)
	cornerclose.CornerRadius = UDim.new(0, 5)

	local strokeclose = Instance.new("UIStroke", window.closebutton)
	strokeclose.Transparency = 0.8
	strokeclose.Color = Color3.fromRGB(184, 118, 246)

	local shadowclose = Instance.new("UIShadow", window.closebutton)
	shadowclose.Transparency = 0.7
	shadowclose.Color = Color3.fromRGB(184, 118, 246)
	shadowclose.BlurRadius = UDim.new(0, 10)

	local uiscaleclose = Instance.new("UIScale", window.closebutton)
	uiscaleclose.Scale = 1

	SetupTopButton(window.closebutton, uiscaleclose, strokeclose, shadowclose)
	window.closebutton.MouseButton1Click:Connect(CloseUI)

	settings.settingsframe = Instance.new("Frame", window.main)
	settings.settingsframe.BorderSizePixel = 0
	settings.settingsframe.BackgroundColor3 = library.theme.colors.backgroundcolor
	settings.settingsframe.AnchorPoint = Vector2.new(0.5, 0.5)
	settings.settingsframe.Size = UDim2.new(0, 250, 0, 300)
	settings.settingsframe.Position = UDim2.new(0.70423, 0, 0.5, 0)
	settings.settingsframe.Name = [[settings]]

	settings.settingscrolling = Instance.new("ScrollingFrame", settings.settingsframe)
	settings.settingscrolling.Active = true
	settings.settingscrolling.BorderSizePixel = 0
	settings.settingscrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
	settings.settingscrolling.Name = [[settingscrolling]]
	settings.settingscrolling.ScrollBarImageTransparency = 0.87
	settings.settingscrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
	settings.settingscrolling.Size = UDim2.new(1, -10, 1, -10)
	settings.settingscrolling.Position = UDim2.new(0, 5, 0, 5)
	settings.settingscrolling.ScrollBarThickness = 0
	settings.settingscrolling.BackgroundTransparency = 1

	settings.settingscrollinglayout = Instance.new("UIListLayout", settings.settingscrolling)
	settings.settingscrollinglayout.SortOrder = Enum.SortOrder.LayoutOrder

	settings.shadowsett = Instance.new("UIShadow", settings.settingsframe)
	settings.shadowsett.Color = library.theme.colors.primarycolor
	settings.shadowsett.BlurRadius = UDim.new(0, 10)
	settings.shadowsett.Transparency = window.theme.transparency.secondary

	settings.cornersett = Instance.new("UICorner", settings.settingsframe)
	settings.cornersett.CornerRadius = UDim.new(0, 5)

	settings.strokesett = Instance.new("UIStroke", settings.settingsframe)
	settings.strokesett.Transparency = 0.8
	settings.strokesett.Color = library.theme.colors.primarycolor

	local function CreateKeyBind(title, default, changedCallback, callback)
		local keybind = {}
		keybind.title = title or ""
		keybind.default = default or "none"
		keybind.value = keybind.default
		keybind.listening = false
		keybind.changedCallback = changedCallback or function() end
		keybind.callback = callback or function() end

		keybind.main = Instance.new("Frame", settings.settingscrolling)
		keybind.main.BorderSizePixel = 0
		keybind.main.BackgroundTransparency = 1
		keybind.main.Size = UDim2.new(1, 0, 0, 30)
		keybind.main.Name = [[keybind]]

		keybind.titlelabel = Instance.new("TextLabel", keybind.main)
		keybind.titlelabel.AnchorPoint = Vector2.new(0, 0.5)
		keybind.titlelabel.BorderSizePixel = 0
		keybind.titlelabel.BackgroundTransparency = 1
		keybind.titlelabel.TextSize = 14
		keybind.titlelabel.TextXAlignment = Enum.TextXAlignment.Left
		keybind.titlelabel.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		keybind.titlelabel.TextColor3 = library.theme.colors.titlecolor
		keybind.titlelabel.Size = UDim2.new(1, -60, 1, -20)
		keybind.titlelabel.Position = UDim2.new(0, 10, 0.5, 0)
		keybind.titlelabel.Text = keybind.title
		keybind.titlelabel.Name = [[title]]

		keybind.input = Instance.new("TextButton", keybind.main)
		keybind.input.BorderSizePixel = 0
		keybind.input.AutoButtonColor = false
		keybind.input.BackgroundColor3 = library.theme.colors.secondarycolor
		keybind.input.TextSize = 14
		keybind.input.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		keybind.input.TextColor3 = library.theme.colors.titlecolor
		keybind.input.Size = UDim2.new(0, 50, 0, 15)
		keybind.input.AnchorPoint = Vector2.new(0, 0.5)
		keybind.input.Position = UDim2.new(1, -60, 0.5, 0)
		keybind.input.Text = [[none]]
		keybind.input.Name = [[input]]

		local shadowkey = Instance.new("UIShadow", keybind.input)
		shadowkey.Color = library.theme.colors.primarycolor
		shadowkey.BlurRadius = UDim.new(0, 5)
		shadowkey.Transparency = 1

		local strokekey = Instance.new("UIStroke", keybind.input)
		strokekey.Color = library.theme.colors.primarycolor
		strokekey.Transparency = 1
		strokekey.Thickness = 1
		strokekey.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

		local cornerinput = Instance.new("UICorner", keybind.input)
		cornerinput.CornerRadius = UDim.new(0, 5)

		local shorter_keycodes = {
			["LeftShift"] = "LSHIFT",
			["RightShift"] = "RSHIFT",
			["LeftControl"] = "LCTRL",
			["RightControl"] = "RCTRL",
			["LeftAlt"] = "LALT",
			["RightAlt"] = "RALT"
		}

		local function getKeyText(key)
			if typeof(key) == "EnumItem" and key.EnumType == Enum.KeyCode then
				return shorter_keycodes[key.Name] or key.Name
			elseif type(key) == "string" then
				return key
			end
			return [[none]]
		end

		function keybind:Set(key)
			if typeof(key) == "EnumItem" and key.EnumType == Enum.KeyCode then
				keybind.value = key
				keybind.input.Text = getKeyText(key)
			elseif type(key) == "string" and key:lower() == [[none]] then
				keybind.value = [[none]]
				keybind.input.Text = [[none]]
			else
				keybind.value = [[none]]
				keybind.input.Text = [[none]]
			end
			keybind.input.TextColor3 = library.theme.colors.titlecolor
			pcall(keybind.changedCallback, keybind.value)
		end

		function keybind:Get()
			return keybind.value
		end

		local function stopListening()
			keybind.listening = false
			if keybind.input and keybind.input.Parent then
				if keybind.input.Text == [[waiting]] then
					keybind.input.Text = getKeyText(keybind.value)
				end
				keybind.input.TextColor3 = library.theme.colors.titlecolor
				library:tween(shadowkey, { Transparency = 1 })
				library:tween(strokekey, { Transparency = 1 })
			end
		end

		keybind.input.MouseButton1Click:Connect(function()
			keybind.listening = true
			keybind.input.Text = [[waiting]]
			keybind.input.TextColor3 = library.theme.colors.primarycolor
			library:tween(shadowkey, { Transparency = 0 })
			library:tween(strokekey, { Transparency = 0 })
		end)

		UserInputService.InputBegan:Connect(function(input, gameProcessed)
			if gameProcessed then
				return
			end

			if keybind.listening then
				if input.UserInputType == Enum.UserInputType.Keyboard then
					keybind:Set(input.KeyCode)
				else
					keybind:Set([[none]])
				end
				stopListening()
				return
			end

			if keybind.value ~= [[none]] and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == keybind.value then
				pcall(keybind.callback, keybind.value)
			end
		end)

		keybind:Set(keybind.default)

		return keybind
	end

	CreateKeyBind("Hide Menu", Enum.KeyCode.Insert, function(value)
		print("Key changed:", value)
	end, function(value)
		window.main.Enabled = not window.main.Enabled
	end)

	window.frame = Instance.new("Frame", window.main)
	window.frame.BorderSizePixel = 0
	window.frame.BackgroundColor3 = library.theme.colors.backgroundcolor
	window.frame.AnchorPoint = Vector2.new(0.5, 0.5)
	window.frame.Size = UDim2.new(0, 500, 0, 300)
	window.frame.Position = UDim2.new(0.38155, 0, 0.5, 0)
	window.frame.Name = [[main]]
	window.frame.Active = true
	window.frame.Selectable = true

	local function makedraggable(frame)
		local DRAG_BORDER = 20
		local DRAG_SPEED = 18

		local dragging = false

		local dragStartMouse
		local dragStartPos

		local targetPosition = frame.Position
		local currentPosition = frame.Position

		local function IsOnBorder(mousePos)
			local absPos = frame.AbsolutePosition
			local absSize = frame.AbsoluteSize

			local x = mousePos.X - absPos.X
			local y = mousePos.Y - absPos.Y

			return (
				x <= DRAG_BORDER
					or x >= absSize.X - DRAG_BORDER
					or y <= DRAG_BORDER
					or y >= absSize.Y - DRAG_BORDER
			)
		end

		frame.InputBegan:Connect(function(input)
			if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
				return
			end

			if not IsOnBorder(input.Position) then
				return
			end

			dragging = true
			dragStartMouse = UserInputService:GetMouseLocation()
			dragStartPos = targetPosition
		end)

		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = false
			end
		end)

		RunService.RenderStepped:Connect(function(dt)

			if dragging then
				local mouse = UserInputService:GetMouseLocation()
				local delta = mouse - dragStartMouse

				targetPosition = UDim2.new(
					dragStartPos.X.Scale,
					dragStartPos.X.Offset + delta.X,

					dragStartPos.Y.Scale,
					dragStartPos.Y.Offset + delta.Y
				)
			end

			local alpha = math.clamp(dt * DRAG_SPEED,0,1)

			currentPosition = UDim2.new(
				currentPosition.X.Scale + (targetPosition.X.Scale-currentPosition.X.Scale)*alpha,

				currentPosition.X.Offset + (targetPosition.X.Offset-currentPosition.X.Offset)*alpha,

				currentPosition.Y.Scale + (targetPosition.Y.Scale-currentPosition.Y.Scale)*alpha,

				currentPosition.Y.Offset + (targetPosition.Y.Offset-currentPosition.Y.Offset)*alpha
			)

			frame.Position = currentPosition
		end)
	end

	makedraggable(window.frame)
	makedraggable(settings.settingsframe)

	window.shadow = Instance.new("UIShadow", window.frame)
	window.shadow.Color = library.theme.colors.primarycolor
	window.shadow.BlurRadius = UDim.new(0, 10)
	window.shadow.Transparency = window.theme.transparency.secondary

	window.corner = Instance.new("UICorner", window.frame)
	window.corner.CornerRadius = UDim.new(0, 5)

	window.stroke = Instance.new("UIStroke", window.frame)
	window.stroke.Transparency = 0.8
	window.stroke.Color = library.theme.colors.primarycolor

	window.tabholder = Instance.new("Frame", window.frame)
	window.tabholder.BorderSizePixel = 0
	window.tabholder.Size = UDim2.new(0, 100, 1, -10)
	window.tabholder.Position = UDim2.new(0, 5, 0, 5)
	window.tabholder.Name = [[tabholder]]
	window.tabholder.BackgroundTransparency = 1

	window.tabscrolling = Instance.new("ScrollingFrame", window.tabholder)
	window.tabscrolling.BorderSizePixel = 0
	window.tabscrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
	window.tabscrolling.Name = [[tabscrolling]]
	window.tabscrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
	window.tabscrolling.Size = UDim2.new(1, 0, 1, -35)
	window.tabscrolling.Position = UDim2.new(0, 0, 0, 35)
	window.tabscrolling.ScrollBarThickness = 0
	window.tabscrolling.BackgroundTransparency = 1

	window.listlayout = Instance.new("UIListLayout", window.tabscrolling)
	window.listlayout.Padding = UDim.new(0, 3)
	window.listlayout.SortOrder = Enum.SortOrder.LayoutOrder

	window.linegradient = Instance.new("Frame", window.tabholder)
	window.linegradient.BorderSizePixel = 0
	window.linegradient.BackgroundColor3 = library.theme.colors.primarycolor
	window.linegradient.Size = UDim2.new(0, 2, 1, 0)
	window.linegradient.Position = UDim2.new(1, 0, 0, 0)
	window.linegradient.Name = [[linegradient]]
	window.linegradient.BackgroundTransparency = 0.5

	window.gradient = Instance.new("UIGradient", window.linegradient)
	window.gradient.Rotation = 90
	window.gradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 1),NumberSequenceKeypoint.new(0.500, 0),NumberSequenceKeypoint.new(1.000, 1)}

	window.icon = Instance.new("ImageLabel", window.tabholder)
	window.icon.BorderSizePixel = 0
	window.icon.ScaleType = Enum.ScaleType.Fit
	window.icon.ImageColor3 = library.theme.colors.primarycolor
	window.icon.Image = [[rbxassetid://96366914337885]]
	window.icon.Size = UDim2.new(0, 100, 0, 35)
	window.icon.BackgroundTransparency = 1
	window.icon.Name = [[icon]]

	window.OpenedColorPickers = {}
	window.Tabs = {}

	function window:CreateTab(title, lefttitle, righttitle)
		local tab = {}
		tab.title = title or ""
		tab.lefttitlee = lefttitle or ""
		tab.righttitlee = righttitle or ""

		tab.button = Instance.new("TextButton", window.tabscrolling)
		tab.button.BorderSizePixel = 0
		tab.button.TextSize = 14
		tab.button.AutoButtonColor = false
		tab.button.BackgroundColor3 = library.theme.colors.inactivetabscolor
		tab.button.Size = UDim2.new(1, 0, 0, 30)
		tab.button.Text = [[]]
		tab.button.Name = tab.title

		tab.gradient = Instance.new("UIGradient", tab.button)
		tab.gradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.000, 0),NumberSequenceKeypoint.new(1.000, 1)}

		tab.titlelabel = Instance.new("TextLabel", tab.button)
		tab.titlelabel.BorderSizePixel = 0
		tab.titlelabel.TextSize = 14
		tab.titlelabel.TextXAlignment = Enum.TextXAlignment.Left
		tab.titlelabel.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		tab.titlelabel.TextColor3 = library.theme.colors.inactivefontcolor
		tab.titlelabel.BackgroundTransparency = 1
		tab.titlelabel.Size = UDim2.new(1, -10, 1, 0)
		tab.titlelabel.Text = tab.title
		tab.titlelabel.Name = [[title]]
		tab.titlelabel.Position = UDim2.new(0, 10, 0, 0)

		tab.corner = Instance.new("UICorner", tab.button)
		tab.corner.CornerRadius = UDim.new(0, 5)

		tab.sector = Instance.new("Frame", window.frame)
		tab.sector.BorderSizePixel = 0
		tab.sector.Size = UDim2.new(1, -107, 1, -10)
		tab.sector.Position = UDim2.new(0, 107, 0, 5)
		tab.sector.Name = tab.title..[[sector]]
		tab.sector.BackgroundTransparency = 1
		tab.sector.Visible = false

		tab.left = Instance.new("Frame", tab.sector)
		tab.left.BorderSizePixel = 0
		tab.left.Size = UDim2.new(0.5, -2, 1, 0)
		tab.left.Name = [[left]]
		tab.left.BackgroundTransparency = 1

		tab.lefttitle = Instance.new("TextLabel", tab.left)
		tab.lefttitle.BorderSizePixel = 0
		tab.lefttitle.TextSize = 14
		tab.lefttitle.TextXAlignment = Enum.TextXAlignment.Left
		tab.lefttitle.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		tab.lefttitle.TextColor3 = library.theme.colors.secondarycolor
		tab.lefttitle.BackgroundTransparency = 1
		tab.lefttitle.Size = UDim2.new(1, -5, 0, 25)
		tab.lefttitle.Text = tab.lefttitlee
		tab.lefttitle.Name = [[title]]
		tab.lefttitle.Position = UDim2.new(0, 5, 0, 0)

		tab.leftscrolling = Instance.new("ScrollingFrame", tab.left)
		tab.leftscrolling.BorderSizePixel = 0
		tab.leftscrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
		tab.leftscrolling.Name = [[leftscrolling]]
		tab.leftscrolling.TopImage = [[rbxasset://textures/ui/Scroll/scroll-middle.png]]
		tab.leftscrolling.MidImage = [[rbxasset://textures/ui/Scroll/scroll-middle.png]]
		tab.leftscrolling.BottomImage = [[rbxasset://textures/ui/Scroll/scroll-middle.png]]
		tab.leftscrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
		tab.leftscrolling.Size = UDim2.new(1, 0, 1, -25)
		tab.leftscrolling.ScrollBarImageColor3 = library.theme.colors.primarycolor
		tab.leftscrolling.Position = UDim2.new(0, 0, 0, 25)
		tab.leftscrolling.ScrollBarThickness = 2
		tab.leftscrolling.BackgroundTransparency = 1

		tab.leftlayout = Instance.new("UIListLayout", tab.leftscrolling)
		tab.leftlayout.SortOrder = Enum.SortOrder.LayoutOrder

		tab.right = Instance.new("Frame", tab.sector)
		tab.right.BorderSizePixel = 0
		tab.right.Size = UDim2.new(0.5, -2, 1, 0)
		tab.right.Position = UDim2.new(0.5, 0, 0, 0)
		tab.right.Name = [[right]]
		tab.right.BackgroundTransparency = 1

		tab.righttitle = Instance.new("TextLabel", tab.right)
		tab.righttitle.BorderSizePixel = 0
		tab.righttitle.TextSize = 14
		tab.righttitle.TextXAlignment = Enum.TextXAlignment.Left
		tab.righttitle.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
		tab.righttitle.TextColor3 = library.theme.colors.secondarycolor
		tab.righttitle.BackgroundTransparency = 1
		tab.righttitle.Size = UDim2.new(1, -5, 0, 25)
		tab.righttitle.Text = tab.righttitlee
		tab.righttitle.Name = [[title]]
		tab.righttitle.Position = UDim2.new(0, 5, 0, 0)

		tab.rightscrolling = Instance.new("ScrollingFrame", tab.right)
		tab.rightscrolling.BorderSizePixel = 0
		tab.rightscrolling.CanvasSize = UDim2.new(0, 0, 0, 0)
		tab.rightscrolling.Name = [[rightscrolling]]
		tab.rightscrolling.TopImage = [[rbxasset://textures/ui/Scroll/scroll-middle.png]]
		tab.rightscrolling.MidImage = [[rbxasset://textures/ui/Scroll/scroll-middle.png]]
		tab.rightscrolling.BottomImage = [[rbxasset://textures/ui/Scroll/scroll-middle.png]]
		tab.rightscrolling.AutomaticCanvasSize = Enum.AutomaticSize.Y
		tab.rightscrolling.Size = UDim2.new(1, 0, 1, -25)
		tab.rightscrolling.ScrollBarImageColor3 = library.theme.colors.primarycolor
		tab.rightscrolling.Position = UDim2.new(0, 0, 0, 25)
		tab.rightscrolling.ScrollBarThickness = 2
		tab.rightscrolling.BackgroundTransparency = 1

		tab.rightlayout = Instance.new("UIListLayout", tab.rightscrolling)
		tab.rightlayout.SortOrder = Enum.SortOrder.LayoutOrder

		function tab:SelectTab()
			for _, otherTab in ipairs(window.Tabs) do
				local isActive = (otherTab == tab)

				library:tween(otherTab.button, {
					BackgroundColor3 = isActive and window.theme.colors.activetabscolor or window.theme.colors.inactivetabscolor
				})

				library:tween(otherTab.titlelabel, {
					TextColor3 = isActive and window.theme.colors.titlecolor or window.theme.colors.inactivefontcolor
				})

				otherTab.sector.Visible = isActive
			end
		end

		table.insert(window.Tabs, tab)

		tab.button.MouseButton1Click:Connect(function()
			tab:SelectTab()
		end)

		if window.Tabs[1] == tab then
			tab:SelectTab()
		end

		function tab:CreateButton(title, side, callback)
			local button = {}
			button.title = title or ""
			button.side = (side or "left"):lower()
			button.side = button.side == "right" and "right" or "left"
			button.callback = callback or function() end

			local parent = button.side == "left" and tab.leftscrolling or tab.rightscrolling

			button.main = Instance.new("Frame", parent)
			button.main.BorderSizePixel = 0
			button.main.Size = UDim2.new(1, 0, 0, 18)
			button.main.Name = "button"
			button.main.BackgroundTransparency = 1

			button.clickable = Instance.new("TextButton", button.main)
			button.clickable.BorderSizePixel = 0
			button.clickable.AutoButtonColor = false
			button.clickable.BackgroundColor3 = library.theme.colors.secondarycolor
			button.clickable.AnchorPoint = Vector2.new(0, 0.5)
			button.clickable.Size = UDim2.new(1, -20, 0, 18)
			button.clickable.Text = ""
			button.clickable.Name = "buttonclickhere"
			button.clickable.Position = UDim2.new(0, 10, 0.5, 0)

			button.titlelabel = Instance.new("TextLabel", button.clickable)
			button.titlelabel.BorderSizePixel = 0
			button.titlelabel.TextSize = 14
			button.titlelabel.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			button.titlelabel.TextColor3 = library.theme.colors.titlecolor
			button.titlelabel.BackgroundTransparency = 1
			button.titlelabel.Size = UDim2.new(1, 0, 1, 0)
			button.titlelabel.Text = button.title
			button.titlelabel.Name = "title"

			button.clickable.MouseButton1Down:Connect(button.callback)

			return button
		end

		function tab:CreateToggle(title, description, side, default, callback)
			local toggle = {}
			toggle.title = title or ""
			toggle.description = description or ""
			toggle.side = (side or "left"):lower()
			toggle.side = toggle.side == "right" and "right" or "left"

			local defaultValue = false
			local callbackFn = callback or function() end

			if type(default) == "boolean" then
				defaultValue = default
			elseif type(default) == "function" then
				callbackFn = default
			end

			if type(callback) == "function" and type(default) ~= "function" then
				callbackFn = callback
			end

			toggle.callback = callbackFn
			toggle.value = defaultValue

			local parent = toggle.side == "left" and tab.leftscrolling or tab.rightscrolling

			toggle.main = Instance.new("Frame", parent)
			toggle.main.BorderSizePixel = 0
			toggle.main.Size = UDim2.new(1, 0, 0, 40)
			toggle.main.Name = [[toggle]]
			toggle.main.BackgroundTransparency = 1

			toggle.titlelabel = Instance.new("TextLabel", toggle.main)
			toggle.titlelabel.BorderSizePixel = 0
			toggle.titlelabel.TextSize = 14
			toggle.titlelabel.TextXAlignment = Enum.TextXAlignment.Left
			toggle.titlelabel.TextYAlignment = Enum.TextYAlignment.Bottom
			toggle.titlelabel.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			toggle.titlelabel.TextColor3 = library.theme.colors.titlecolor
			toggle.titlelabel.BackgroundTransparency = 1
			toggle.titlelabel.Size = UDim2.new(1, -60, 1, -20)
			toggle.titlelabel.Text = toggle.title
			toggle.titlelabel.Name = [[title]]
			toggle.titlelabel.Position = UDim2.new(0, 10, 0, 0)

			toggle.descriptionlabel = Instance.new("TextLabel", toggle.main)
			toggle.descriptionlabel.TextTruncate = Enum.TextTruncate.AtEnd
			toggle.descriptionlabel.BorderSizePixel = 0
			toggle.descriptionlabel.TextSize = 12
			toggle.descriptionlabel.TextXAlignment = Enum.TextXAlignment.Left
			toggle.descriptionlabel.TextYAlignment = Enum.TextYAlignment.Top
			toggle.descriptionlabel.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			toggle.descriptionlabel.TextColor3 = library.theme.colors.descriptioncolor
			toggle.descriptionlabel.BackgroundTransparency = 1
			toggle.descriptionlabel.Size = UDim2.new(1, -60, 1, -20)
			toggle.descriptionlabel.Text = toggle.description
			toggle.descriptionlabel.Name = [[description]]
			toggle.descriptionlabel.Position = UDim2.new(0, 10, 0, 20)

			toggle.switch = Instance.new("TextButton", toggle.main)
			toggle.switch.BorderSizePixel = 0
			toggle.switch.AutoButtonColor = false
			toggle.switch.BackgroundColor3 = library.theme.colors.secondarycolor
			toggle.switch.Size = UDim2.new(0, 30, 0, 15)
			toggle.switch.Text = [[]]
			toggle.switch.Name = [[switchbutton]]
			toggle.switch.Position = UDim2.new(1, -40, 0, 12)

			local shadow = Instance.new("UIShadow", toggle.switch)
			shadow.Color = library.theme.colors.primarycolor
			shadow.BlurRadius = UDim.new(0, 5)
			shadow.Transparency = 1

			local switchCorner = Instance.new("UICorner", toggle.switch)
			switchCorner.CornerRadius = UDim.new(0, 999)

			toggle.knob = Instance.new("Frame", toggle.switch)
			toggle.knob.BorderSizePixel = 0
			toggle.knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			toggle.knob.Size = UDim2.new(0, 12, 0, 12)
			toggle.knob.Position = UDim2.new(0, 2, 0.5, -6)
			toggle.knob.Name = [[knob]]

			local knobCorner = Instance.new("UICorner", toggle.knob)
			knobCorner.CornerRadius = UDim.new(0, 999)

			function toggle:SetValue(value)
				self.value = value
				local switchColor = value and library.theme.colors.primarycolor or library.theme.colors.secondarycolor
				local knobPosition = value and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
				local shadowtransparency = value and 0 or 1

				library:tween(self.switch, {
					BackgroundColor3 = switchColor
				})

				library:tween(self.knob, {
					Position = knobPosition
				})

				library:tween(shadow, {
					Transparency = shadowtransparency
				})

				self.callback(value)
			end

			toggle.switch.MouseButton1Click:Connect(function()
				toggle:SetValue(not toggle.value)
			end)

			toggle:SetValue(toggle.value)

			return toggle
		end

		function tab:CreateTextBox(title, side, default, callback)
			local textbox = {}
			textbox.title = title or ""
			textbox.side = (side or "left"):lower()
			textbox.side = textbox.side == "right" and "right" or "left"
			textbox.callback = callback or function(value) end
			textbox.value = default or ""

			local parent = textbox.side == "left" and tab.leftscrolling or tab.rightscrolling

			textbox.main = Instance.new("Frame", parent)
			textbox.main.BorderSizePixel = 0
			textbox.main.Size = UDim2.new(1, 0, 0, 30)
			textbox.main.Name = [[textbox]]
			textbox.main.BackgroundTransparency = 1

			textbox.titlelabel = Instance.new("TextLabel", textbox.main)
			textbox.titlelabel.BorderSizePixel = 0
			textbox.titlelabel.TextSize = 14
			textbox.titlelabel.TextXAlignment = Enum.TextXAlignment.Left
			textbox.titlelabel.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			textbox.titlelabel.TextColor3 = library.theme.colors.titlecolor
			textbox.titlelabel.BackgroundTransparency = 1
			textbox.titlelabel.Size = UDim2.new(1, -60, 1, -20)
			textbox.titlelabel.Text = textbox.title
			textbox.titlelabel.Name = [[title]]
			textbox.titlelabel.Position = UDim2.new(0, 10, 0.5, 0)

			textbox.input = Instance.new("TextBox", textbox.main)
			textbox.input.BorderSizePixel = 0
			textbox.input.TextSize = 14
			textbox.input.TextColor3 = library.theme.colors.titlecolor
			textbox.input.PlaceholderColor3 = library.theme.colors.descriptioncolor
			textbox.input.BackgroundColor3 = library.theme.colors.secondarycolor
			textbox.input.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			textbox.input.Text = textbox.value
			textbox.input.PlaceholderText = [[none]]
			textbox.input.Size = UDim2.new(0, 50, 0, 15)
			textbox.input.Position = UDim2.new(1, -60, 0.5, 0)
			textbox.input.Name = [[input]]

			local shadowtextbox = Instance.new("UIShadow", textbox.input)
			shadowtextbox.Color = library.theme.colors.primarycolor
			shadowtextbox.BlurRadius = UDim.new(0, 5)
			shadowtextbox.Transparency = 1

			local stroke = Instance.new("UIStroke", textbox.input)
			stroke.Color = library.theme.colors.primarycolor
			stroke.Transparency = 1
			stroke.Thickness = 1
			stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

			textbox.input.Focused:Connect(function()
				library:tween(shadowtextbox, {
					Transparency = 0
				})
				library:tween(stroke, {
					Transparency = 0
				})
			end)

			textbox.input.FocusLost:Connect(function(enterPressed)
				textbox.value = textbox.input.Text
				textbox.callback(textbox.value, enterPressed)
				library:tween(shadowtextbox, {
					Transparency = 1
				})
				library:tween(stroke, {
					Transparency = 1
				})
			end)

			return textbox
		end

		function tab:CreateDropdown(title, side, items, callback)
			local dropdown = {}
			dropdown.title = title or ""
			dropdown.side = (side or "left"):lower()
			dropdown.side = dropdown.side == "right" and "right" or "left"
			dropdown.items = items or {}
			dropdown.callback = callback or function() end
			dropdown.value = dropdown.items[1] or [[Select]]

			local parent = dropdown.side == "left" and tab.leftscrolling or tab.rightscrolling

			dropdown.main = Instance.new("Frame", parent)
			dropdown.main.BorderSizePixel = 0
			dropdown.main.BackgroundTransparency = 1
			dropdown.main.AutomaticSize = Enum.AutomaticSize.Y
			dropdown.main.Size = UDim2.new(1, 0, 0, 40)
			dropdown.main.Name = [[dropdown]]

			dropdown.titlelabel = Instance.new("TextLabel", dropdown.main)
			dropdown.titlelabel.BorderSizePixel = 0
			dropdown.titlelabel.TextSize = 14
			dropdown.titlelabel.TextXAlignment = Enum.TextXAlignment.Left
			dropdown.titlelabel.TextYAlignment = Enum.TextYAlignment.Bottom
			dropdown.titlelabel.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			dropdown.titlelabel.TextColor3 = Color3.fromRGB(206, 202, 213)
			dropdown.titlelabel.BackgroundTransparency = 1
			dropdown.titlelabel.Size = UDim2.new(1, -60, 0, 15)
			dropdown.titlelabel.Position = UDim2.new(0, 10, 0, 0)
			dropdown.titlelabel.Text = dropdown.title
			dropdown.titlelabel.Name = [[title]]

			dropdown.clickButton = Instance.new("TextButton", dropdown.main)
			dropdown.clickButton.BorderSizePixel = 0
			dropdown.clickButton.TextSize = 14
			dropdown.clickButton.AutoButtonColor = false
			dropdown.clickButton.TextColor3 = Color3.fromRGB(0, 0, 0)
			dropdown.clickButton.BackgroundColor3 = Color3.fromRGB(73, 48, 108)
			dropdown.clickButton.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			dropdown.clickButton.Size = UDim2.new(1, -20, 0, 20)
			dropdown.clickButton.Position = UDim2.new(0, 10, 0, 20)
			dropdown.clickButton.Text = [[]]
			dropdown.clickButton.Name = [[dropdownclickhere]]

			dropdown.nameSelected = Instance.new("TextLabel", dropdown.clickButton)
			dropdown.nameSelected.BorderSizePixel = 0
			dropdown.nameSelected.TextSize = 14
			dropdown.nameSelected.TextXAlignment = Enum.TextXAlignment.Left
			dropdown.nameSelected.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			dropdown.nameSelected.TextColor3 = Color3.fromRGB(206, 202, 213)
			dropdown.nameSelected.BackgroundTransparency = 1
			dropdown.nameSelected.Size = UDim2.new(1, -5, 1, 0)
			dropdown.nameSelected.Position = UDim2.new(0, 5, 0, 0)
			dropdown.nameSelected.Text = dropdown.value
			dropdown.nameSelected.Name = [[nameselected]]

			dropdown.options = Instance.new("Frame", dropdown.clickButton)
			dropdown.options.Visible = false
			dropdown.options.ZIndex = 5
			dropdown.options.BorderSizePixel = 0
			dropdown.options.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			dropdown.options.AutomaticSize = Enum.AutomaticSize.Y
			dropdown.options.Size = UDim2.new(1, 0, 0, 0)
			dropdown.options.Position = UDim2.new(0, 0, 0, 22)
			dropdown.options.BackgroundTransparency = 1
			dropdown.options.Name = [[dropdownoptions]]

			dropdown.layout = Instance.new("UIListLayout", dropdown.options)
			dropdown.layout.SortOrder = Enum.SortOrder.LayoutOrder

			dropdown.isOpen = false

			local function close()
				dropdown.options.Visible = false
				dropdown.isOpen = false
				dropdown.clickButton.BackgroundColor3 = Color3.fromRGB(73, 48, 108)
				if tab.currentDropdown == dropdown then
					tab.currentDropdown = nil
				end
			end

			local function open()
				if tab.currentDropdown and tab.currentDropdown ~= dropdown then
					tab.currentDropdown:Close()
				end
				dropdown.options.Visible = true
				dropdown.isOpen = true
				dropdown.clickButton.BackgroundColor3 = library.theme.colors.primarycolor
				tab.currentDropdown = dropdown
			end

			function dropdown:Close()
				close()
			end

			function dropdown:Set(value)
				if type(value) ~= "string" then
					value = tostring(value)
				end
				local found = false
				for _, item in ipairs(dropdown.items) do
					if item == value then
						dropdown.value = item
						found = true
						break
					end
				end
				if not found then
					dropdown.value = dropdown.items[1] or [[Select]]
				end
				dropdown.nameSelected.Text = dropdown.value
				pcall(dropdown.callback, dropdown.value)
			end

			function dropdown:Get()
				return dropdown.value
			end

			local function addOption(option)
				local optionButton = Instance.new("TextButton", dropdown.options)
				optionButton.BorderSizePixel = 0
				optionButton.TextSize = 14
				optionButton.AutoButtonColor = false
				optionButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				optionButton.BackgroundColor3 = Color3.fromRGB(66, 45, 99)
				optionButton.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
				optionButton.ZIndex = 2
				optionButton.Size = UDim2.new(1, 0, 0, 20)
				optionButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				optionButton.Text = [[]]
				optionButton.Name = option:gsub("%s", "_")

				local optionTitle = Instance.new("TextLabel", optionButton)
				optionTitle.ZIndex = 2
				optionTitle.BorderSizePixel = 0
				optionTitle.TextSize = 14
				optionTitle.TextXAlignment = Enum.TextXAlignment.Left
				optionTitle.TextTransparency = 0.5
				optionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				optionTitle.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				optionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
				optionTitle.BackgroundTransparency = 1
				optionTitle.Size = UDim2.new(1, -5, 1, 0)
				optionTitle.Position = UDim2.new(0, 5, 0, 0)
				optionTitle.Text = option
				optionTitle.Name = [[title]]

				optionButton.MouseButton1Click:Connect(function()
					dropdown:Set(option)
					close()
				end)
			end

			for _, option in ipairs(dropdown.items) do
				addOption(option)
			end

			dropdown.clickButton.MouseButton1Click:Connect(function()
				if dropdown.isOpen then
					close()
				else
					open()
				end
			end)

			dropdown:Set(dropdown.items[1] or [[Select]])

			return dropdown
		end

		function tab:CreateColorpicker(title, description, side, default, callback)
			local colorpicker = {}
			colorpicker.title = title or ""
			colorpicker.description = description or ""
			colorpicker.side = (side or "left"):lower()
			colorpicker.side = colorpicker.side == "right" and "right" or "left"
			colorpicker.default = typeof(default) == "Color3" and default or Color3.fromRGB(255, 255, 255)
			colorpicker.value = colorpicker.default
			colorpicker.callback = callback or function() end
			colorpicker.color = 1

			local parent = colorpicker.side == "left" and tab.leftscrolling or tab.rightscrolling

			colorpicker.main = Instance.new("Frame", parent)
			colorpicker.main.BorderSizePixel = 0
			colorpicker.main.BackgroundTransparency = 1
			colorpicker.main.AutomaticSize = Enum.AutomaticSize.Y
			colorpicker.main.Size = UDim2.new(1, 0, 0, 40)
			colorpicker.main.Name = [[colorpicker]]

			colorpicker.titlelabel = Instance.new("TextLabel", colorpicker.main)
			colorpicker.titlelabel.BorderSizePixel = 0
			colorpicker.titlelabel.TextSize = 14
			colorpicker.titlelabel.TextXAlignment = Enum.TextXAlignment.Left
			colorpicker.titlelabel.TextYAlignment = Enum.TextYAlignment.Bottom
			colorpicker.titlelabel.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			colorpicker.titlelabel.TextColor3 = library.theme.colors.titlecolor
			colorpicker.titlelabel.BackgroundTransparency = 1
			colorpicker.titlelabel.Size = UDim2.new(1, -60, 0, 20)
			colorpicker.titlelabel.Position = UDim2.new(0, 10, 0, 0)
			colorpicker.titlelabel.Text = colorpicker.title
			colorpicker.titlelabel.Name = [[title]]

			colorpicker.descriptionlabel = Instance.new("TextLabel", colorpicker.main)
			colorpicker.descriptionlabel.TextTruncate = Enum.TextTruncate.AtEnd
			colorpicker.descriptionlabel.BorderSizePixel = 0
			colorpicker.descriptionlabel.TextSize = 12
			colorpicker.descriptionlabel.TextXAlignment = Enum.TextXAlignment.Left
			colorpicker.descriptionlabel.TextYAlignment = Enum.TextYAlignment.Top
			colorpicker.descriptionlabel.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			colorpicker.descriptionlabel.TextColor3 = Color3.fromRGB(112, 105, 123)
			colorpicker.descriptionlabel.BackgroundTransparency = 1
			colorpicker.descriptionlabel.Size = UDim2.new(1, -60, 0, 20)
			colorpicker.descriptionlabel.Position = UDim2.new(0, 10, 0, 20)
			colorpicker.descriptionlabel.Text = colorpicker.description

			colorpicker.button = Instance.new("TextButton", colorpicker.main)
			colorpicker.button.Active = true
			colorpicker.button.BorderSizePixel = 0
			colorpicker.button.AutoButtonColor = false
			colorpicker.button.BackgroundColor3 = colorpicker.value
			colorpicker.button.Text = [[]]
			colorpicker.button.Size = UDim2.new(0, 30, 0, 15)
			colorpicker.button.Position = UDim2.new(1, -40, 0, 12)
			colorpicker.button.Name = [[colorbutton]]
			colorpicker.button.ZIndex = 90

			local shadow = Instance.new("UIShadow", colorpicker.button)
			shadow.Color = colorpicker.value
			shadow.BlurRadius = UDim.new(0, 5)
			updateevent.Event:Connect(function(theme)
				shadow.Color = colorpicker.value
			end)

			local buttonRound = Instance.new("UICorner", colorpicker.button)
			buttonRound.CornerRadius = UDim.new(0, 5)

			local buttonGradient = Instance.new("UIGradient", colorpicker.button)
			buttonGradient.Rotation = 90

			local buttonStroke = Instance.new("UIStroke", colorpicker.button)
			buttonStroke.Color = library.theme.colors.primarycolor
			buttonStroke.Thickness = 1
			buttonStroke.Transparency = 0.8
			buttonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

			colorpicker.panel = Instance.new("Frame", colorpicker.main)
			colorpicker.panel.Active = true
			colorpicker.panel.BorderSizePixel = 0
			colorpicker.panel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			colorpicker.panel.Size = UDim2.new(0, 180, 0, 196)
			colorpicker.panel.Position = UDim2.new(0, 0, 0, 45)
			colorpicker.panel.Visible = false
			colorpicker.panel.Name = [[picker]]
			colorpicker.panel.ZIndex = 95

			local panelRound = Instance.new("UICorner", colorpicker.panel)
			panelRound.CornerRadius = UDim.new(0, 8)

			local panelStroke = Instance.new("UIStroke", colorpicker.panel)
			panelStroke.Color = library.theme.colors.primarycolor
			panelStroke.Thickness = 1
			panelStroke.Transparency = 0.8
			panelStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

			colorpicker.hue = Instance.new("ImageLabel", colorpicker.panel)
			colorpicker.hue.Active = true
			colorpicker.hue.BorderSizePixel = 0
			colorpicker.hue.BackgroundColor3 = Color3.new(1, 0, 0)
			colorpicker.hue.Size = UDim2.new(0, 172, 0, 172)
			colorpicker.hue.Position = UDim2.new(0, 4, 0, 4)
			colorpicker.hue.Image = [[rbxassetid://4155801252]]
			colorpicker.hue.ScaleType = Enum.ScaleType.Stretch
			colorpicker.hue.Name = [[hue]]
			colorpicker.hue.ZIndex = 96

			colorpicker.hueselectorpointer = Instance.new("ImageLabel", colorpicker.hue)
			colorpicker.hueselectorpointer.BorderSizePixel = 0
			colorpicker.hueselectorpointer.BackgroundTransparency = 1
			colorpicker.hueselectorpointer.Size = UDim2.new(0, 10, 0, 10)
			colorpicker.hueselectorpointer.Image = [[rbxassetid://6885856475]]
			colorpicker.hueselectorpointer.Name = [[hueselectorpointer]]
			colorpicker.hueselectorpointer.AnchorPoint = Vector2.new(0.5, 0.5)
			colorpicker.hueselectorpointer.Position = UDim2.new(0, 5, 0, 5)
			colorpicker.hueselectorpointer.ZIndex = 97

			colorpicker.selector = Instance.new("Frame", colorpicker.panel)
			colorpicker.selector.Active = true
			colorpicker.selector.BorderSizePixel = 0
			colorpicker.selector.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			colorpicker.selector.Size = UDim2.new(0, 173, 0, 10)
			colorpicker.selector.Position = UDim2.new(0, 4, 0, 182)
			colorpicker.selector.Name = [[selector]]
			colorpicker.selector.ZIndex = 96

			local selectorRound = Instance.new("UICorner", colorpicker.selector)
			selectorRound.CornerRadius = UDim.new(0, 4)

			colorpicker.gradient = Instance.new("UIGradient", colorpicker.selector)
			colorpicker.gradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.new(1, 0, 0)),
				ColorSequenceKeypoint.new(0.17, Color3.new(1, 0, 1)),
				ColorSequenceKeypoint.new(0.33, Color3.new(0, 0, 1)),
				ColorSequenceKeypoint.new(0.5, Color3.new(0, 1, 1)),
				ColorSequenceKeypoint.new(0.67, Color3.new(0, 1, 0)),
				ColorSequenceKeypoint.new(0.83, Color3.new(1, 1, 0)),
				ColorSequenceKeypoint.new(1, Color3.new(1, 0, 0))
			})

			colorpicker.pointer = Instance.new("Frame", colorpicker.selector)
			colorpicker.pointer.BorderSizePixel = 0
			colorpicker.pointer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			colorpicker.pointer.Size = UDim2.new(0, 2, 1, 0)
			colorpicker.pointer.Position = UDim2.new(0, 0, 0, 0)
			colorpicker.pointer.Name = [[pointer]]
			colorpicker.pointer.ZIndex = 97

			local pointerRound = Instance.new("UICorner", colorpicker.pointer)
			pointerRound.CornerRadius = UDim.new(0, 2)

			local dragging_selector = false
			local dragging_hue = false

			function colorpicker:Set(value)
				local color = typeof(value) == "Color3" and Color3.new(math.clamp(value.R, 0, 1), math.clamp(value.G, 0, 1), math.clamp(value.B, 0, 1)) or Color3.fromRGB(255, 255, 255)
				colorpicker.value = color
				colorpicker.button.BackgroundColor3 = color
				if shadow then
					shadow.Color = color
				end
				pcall(colorpicker.callback, color)
			end

			function colorpicker:Get()
				return colorpicker.value
			end

			function colorpicker:RefreshSelector()
				local pos = math.clamp((Mouse.X - colorpicker.selector.AbsolutePosition.X) / math.max(colorpicker.selector.AbsoluteSize.X, 1), 0, 1)
				colorpicker.color = 1 - pos
				colorpicker.pointer:TweenPosition(UDim2.new(pos, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
				colorpicker.hue.BackgroundColor3 = Color3.fromHSV(1 - pos, 1, 1)

				local x = (colorpicker.hueselectorpointer.AbsolutePosition.X - colorpicker.hue.AbsolutePosition.X) / math.max(colorpicker.hue.AbsoluteSize.X, 1)
				local y = (colorpicker.hueselectorpointer.AbsolutePosition.Y - colorpicker.hue.AbsolutePosition.Y) / math.max(colorpicker.hue.AbsoluteSize.Y, 1)
				colorpicker:Set(Color3.fromHSV(colorpicker.color, math.clamp(x, 0, 1), 1 - math.clamp(y, 0, 1)))
			end

			function colorpicker:RefreshHue()
				local x = (Mouse.X - colorpicker.hue.AbsolutePosition.X) / math.max(colorpicker.hue.AbsoluteSize.X, 1)
				local y = (Mouse.Y - colorpicker.hue.AbsolutePosition.Y) / math.max(colorpicker.hue.AbsoluteSize.Y, 1)
				colorpicker.hueselectorpointer:TweenPosition(UDim2.new(math.clamp(x, 0, 1), 0, math.clamp(y, 0, 1), 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.05)
				colorpicker:Set(Color3.fromHSV(colorpicker.color, math.clamp(x, 0, 1), 1 - math.clamp(y, 0, 1)))
			end

			colorpicker.selector.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging_selector = true
					colorpicker:RefreshSelector()
				end
			end)

			colorpicker.selector.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging_selector = false
					colorpicker:RefreshSelector()
				end
			end)

			colorpicker.hue.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging_hue = true
					colorpicker:RefreshHue()
				end
			end)

			colorpicker.hue.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging_hue = false
					colorpicker:RefreshHue()
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if dragging_selector and input.UserInputType == Enum.UserInputType.MouseMovement then
					colorpicker:RefreshSelector()
				end
				if dragging_hue and input.UserInputType == Enum.UserInputType.MouseMovement then
					colorpicker:RefreshHue()
				end
			end)

			local function closeOthers()
				for picker, open in pairs(window.OpenedColorPickers) do
					if open and picker ~= colorpicker.panel then
						picker.Visible = false
						window.OpenedColorPickers[picker] = false
					end
				end
			end

			local function togglePicker()
				closeOthers()
				colorpicker.panel.Visible = not colorpicker.panel.Visible
				window.OpenedColorPickers[colorpicker.panel] = colorpicker.panel.Visible
			end

			colorpicker.button.MouseButton1Click:Connect(togglePicker)

			colorpicker:Set(colorpicker.default)

			return colorpicker
		end

		function tab:CreateSlider(title, side, min, max, default, maxdecimal, callback)
			local slider = {}
			slider.title = title or ""
			slider.side = (side or "left"):lower()
			slider.side = slider.side == "right" and "right" or "left"
			slider.min = min or 0
			slider.max = max or 100
			slider.default = default or slider.min
			if type(maxdecimal) == "function" then
				callback = maxdecimal
				maxdecimal = 0
			end
			slider.maxdecimal = math.max(0, tonumber(maxdecimal) or 0)
			slider.step = slider.maxdecimal > 0 and 1 / (10 ^ slider.maxdecimal) or 1
			slider.callback = callback or function() end
			slider.value = math.clamp(slider.default, slider.min, slider.max)
			local dragging = false

			local parent = slider.side == "left" and tab.leftscrolling or tab.rightscrolling

			slider.main = Instance.new("Frame", parent)
			slider.main.BorderSizePixel = 0
			slider.main.Size = UDim2.new(1, 0, 0, 40)
			slider.main.Name = [[slider]]
			slider.main.BackgroundTransparency = 1

			slider.titlelabel = Instance.new("TextLabel", slider.main)
			slider.titlelabel.BorderSizePixel = 0
			slider.titlelabel.TextSize = 14
			slider.titlelabel.TextXAlignment = Enum.TextXAlignment.Left
			slider.titlelabel.TextYAlignment = Enum.TextYAlignment.Bottom
			slider.titlelabel.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			slider.titlelabel.TextColor3 = library.theme.colors.titlecolor
			slider.titlelabel.BackgroundTransparency = 1
			slider.titlelabel.Size = UDim2.new(1, -60, 0, 20)
			slider.titlelabel.Text = slider.title
			slider.titlelabel.Name = [[title]]
			slider.titlelabel.Position = UDim2.new(0, 10, 0, 0)

			slider.sliderholder = Instance.new("Frame", slider.main)
			slider.sliderholder.BorderSizePixel = 0
			slider.sliderholder.Size = UDim2.new(1, -20, 1, -20)
			slider.sliderholder.Position = UDim2.new(0, 10, 0, 20)
			slider.sliderholder.Name = [[sliderholder]]
			slider.sliderholder.BackgroundTransparency = 1

			slider.slidebackground = Instance.new("Frame", slider.sliderholder)
			slider.slidebackground.BorderSizePixel = 0
			slider.slidebackground.BackgroundColor3 = library.theme.colors.secondarycolor
			slider.slidebackground.AnchorPoint = Vector2.new(0, 0.5)
			slider.slidebackground.Size = UDim2.new(1, 0, 0, 2)
			slider.slidebackground.Position = UDim2.new(0, 0, 0.5, 0)
			slider.slidebackground.Name = [[sliderbackground]]

			slider.bar = Instance.new("Frame", slider.slidebackground)
			slider.bar.BorderSizePixel = 0
			slider.bar.BackgroundColor3 = library.theme.colors.primarycolor
			slider.bar.Size = UDim2.new(0, 0, 1, 0)
			slider.bar.Name = [[bar]]

			slider.dot = Instance.new("Frame", slider.slidebackground)
			slider.dot.BorderSizePixel = 0
			slider.dot.BackgroundColor3 = library.theme.colors.primarycolor
			slider.dot.AnchorPoint = Vector2.new(0.5, 0.5)
			slider.dot.Size = UDim2.new(0, 10, 0, 10)
			slider.dot.Position = UDim2.new(0, 0, 0.5, 0)
			slider.dot.Name = [[dot]]

			local uicornerdot = Instance.new("UICorner", slider.dot)
			uicornerdot.CornerRadius = UDim.new(1, 0)

			local uistrokedot = Instance.new("UIStroke", slider.dot)
			uistrokedot.Thickness = 2
			uistrokedot.Color = Color3.fromRGB(23, 22, 35)

			slider.percentage = Instance.new("TextLabel", slider.main)
			slider.percentage.BorderSizePixel = 0
			slider.percentage.TextSize = 14
			slider.percentage.TextYAlignment = Enum.TextYAlignment.Bottom
			slider.percentage.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			slider.percentage.TextColor3 = library.theme.colors.titlecolor
			slider.percentage.BackgroundTransparency = 1
			slider.percentage.Size = UDim2.new(0, 40, 0, 20)
			slider.percentage.Text = [[0]]
			slider.percentage.Name = [[percentage]]
			slider.percentage.Position = UDim2.new(1, -50, 0, 0)

			slider.percentageinput = Instance.new("TextBox", slider.main)
			slider.percentageinput.BorderSizePixel = 0
			slider.percentageinput.TextSize = 14
			slider.percentageinput.TextXAlignment = Enum.TextXAlignment.Right
			slider.percentageinput.TextYAlignment = Enum.TextYAlignment.Bottom
			slider.percentageinput.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			slider.percentageinput.TextColor3 = library.theme.colors.titlecolor
			slider.percentageinput.BackgroundTransparency = 1
			slider.percentageinput.Size = slider.percentage.Size
			slider.percentageinput.Position = slider.percentage.Position
			slider.percentageinput.Text = slider.percentage.Text
			slider.percentageinput.ClearTextOnFocus = false
			slider.percentageinput.TextEditable = true
			slider.percentageinput.Visible = false
			slider.percentageinput.Name = [[percentageinput]]

			local lastPercentageClick = 0
			local function openPercentageEditor()
				slider.percentageinput.Text = slider.percentage.Text
				slider.percentageinput.Visible = true
				slider.percentage.Visible = false
				slider.percentageinput:CaptureFocus()
				slider.percentageinput.SelectionStart = 1
				slider.percentageinput.CursorPosition = #slider.percentageinput.Text + 1
			end

			local function closePercentageEditor()
				slider.percentageinput.Visible = false
				slider.percentage.Visible = true
			end

			slider.percentage.InputBegan:Connect(function(input, gameProcessed)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and not gameProcessed then
					local now = tick()
					if now - lastPercentageClick <= 0.25 then
						openPercentageEditor()
					end
					lastPercentageClick = now
				end
			end)

			slider.percentageinput.FocusLost:Connect(function(enterPressed)
				local rawText = tostring(slider.percentageinput.Text or "")
				local normalizedText = rawText:gsub("%%", ""):gsub(",", ".")
				local parsedValue = tonumber(normalizedText)

				if parsedValue then
					local value = math.clamp(parsedValue, slider.min, slider.max)
					if slider.maxdecimal > 0 then
						value = math.round(value * (10 ^ slider.maxdecimal)) / (10 ^ slider.maxdecimal)
					else
						value = math.round(value)
					end
					slider:SetValue(value)
				end

				closePercentageEditor()
			end)

			slider.hitbox = Instance.new("TextButton", slider.sliderholder)
			slider.hitbox.BorderSizePixel = 0
			slider.hitbox.AutoButtonColor = false
			slider.hitbox.Text = [[]]
			slider.hitbox.BackgroundTransparency = 1
			slider.hitbox.Size = UDim2.new(1, 0, 1, 0)
			slider.hitbox.Position = UDim2.new(0, 0, 0, 0)
			slider.hitbox.Name = [[hitbox]]

			local function roundToStep(value)
				if slider.step <= 0 then
					return value
				end
				return math.round(value / slider.step) * slider.step
			end

			local function formatValue(value)
				local precision = tonumber(slider.maxdecimal) or 0
				value = math.clamp(value, slider.min, slider.max)
				if precision > 0 then
					return string.format("%." .. tostring(precision) .. "f", value)
				end
				return tostring(math.round(value))
			end

			local function updateVisuals(self)
				local percent = self.max ~= self.min and ((self.value - self.min) / (self.max - self.min)) or 0
				percent = math.clamp(percent, 0, 1)
				local trackWidth = math.max(self.slidebackground.AbsoluteSize.X, 1)
				local dotHalfWidth = math.max((self.dot.Size.X.Offset or self.dot.AbsoluteSize.X) / 2, 0)
				local minOffset = dotHalfWidth
				local maxOffset = math.max(trackWidth - dotHalfWidth, dotHalfWidth)
				local dotOffset = math.clamp(percent * trackWidth, minOffset, maxOffset)
				self.bar.Size = UDim2.new(percent, 0, 1, 0)
				self.dot.Position = UDim2.new(0, dotOffset, 0.5, 0)
				self.percentage.Text = formatValue(self.value)
			end

			local function updateFromMouse(x)
				local trackStart = slider.slidebackground.AbsolutePosition.X
				local trackSize = slider.slidebackground.AbsoluteSize.X
				local percent = math.clamp((x - trackStart) / math.max(trackSize, 1), 0, 1)
				local range = slider.max - slider.min
				local value = slider.min + (percent * range)
				value = roundToStep(value)
				value = math.clamp(value, slider.min, slider.max)
				slider:SetValue(value)
			end

			function slider:SetValue(value, notify)
				local clampedValue = math.clamp(value, self.min, self.max)
				local roundedValue = roundToStep(clampedValue)
				roundedValue = math.clamp(roundedValue, self.min, self.max)

				if roundedValue ~= self.value then
					self.value = roundedValue
					updateVisuals(self)
					if notify ~= false then
						self.callback(self.value)
					end
				else
					updateVisuals(self)
				end
			end

			slider.hitbox.MouseButton1Down:Connect(function()
				dragging = true
				updateFromMouse(UserInputService:GetMouseLocation().X)
			end)

			UserInputService.InputEnded:Connect(function(input, gameProcessed)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)

			RunService.RenderStepped:Connect(function()
				if not dragging then return end
				updateFromMouse(UserInputService:GetMouseLocation().X)
			end)

			slider.slidebackground:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				slider:SetValue(slider.value, false)
			end)

			slider:SetValue(slider.value, false)

			return slider
		end

		function tab:CreateKeyBind(title, side, default, changedCallback, callback)
			local keybind = {}
			keybind.title = title or ""
			keybind.side = (side or "left"):lower()
			keybind.side = keybind.side == "right" and "right" or "left"
			keybind.default = default or "none"
			keybind.value = keybind.default
			keybind.listening = false
			keybind.changedCallback = changedCallback or function() end
			keybind.callback = callback or function() end

			local parent = keybind.side == "left" and tab.leftscrolling or tab.rightscrolling

			keybind.main = Instance.new("Frame", parent)
			keybind.main.BorderSizePixel = 0
			keybind.main.BackgroundTransparency = 1
			keybind.main.Size = UDim2.new(1, 0, 0, 30)
			keybind.main.Name = [[keybind]]

			keybind.titlelabel = Instance.new("TextLabel", keybind.main)
			keybind.titlelabel.AnchorPoint = Vector2.new(0, 0.5)
			keybind.titlelabel.BorderSizePixel = 0
			keybind.titlelabel.BackgroundTransparency = 1
			keybind.titlelabel.TextSize = 14
			keybind.titlelabel.TextXAlignment = Enum.TextXAlignment.Left
			keybind.titlelabel.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			keybind.titlelabel.TextColor3 = library.theme.colors.titlecolor
			keybind.titlelabel.Size = UDim2.new(1, -60, 1, -20)
			keybind.titlelabel.Position = UDim2.new(0, 10, 0.5, 0)
			keybind.titlelabel.Text = keybind.title
			keybind.titlelabel.Name = [[title]]

			keybind.input = Instance.new("TextButton", keybind.main)
			keybind.input.BorderSizePixel = 0
			keybind.input.AutoButtonColor = false
			keybind.input.BackgroundColor3 = library.theme.colors.secondarycolor
			keybind.input.TextSize = 14
			keybind.input.FontFace = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal)
			keybind.input.TextColor3 = library.theme.colors.titlecolor
			keybind.input.Size = UDim2.new(0, 50, 0, 15)
			keybind.input.AnchorPoint = Vector2.new(0, 0.5)
			keybind.input.Position = UDim2.new(1, -60, 0.5, 0)
			keybind.input.Text = [[none]]
			keybind.input.Name = [[input]]

			local shadowkey = Instance.new("UIShadow", keybind.input)
			shadowkey.Color = library.theme.colors.primarycolor
			shadowkey.BlurRadius = UDim.new(0, 5)
			shadowkey.Transparency = 1

			local strokekey = Instance.new("UIStroke", keybind.input)
			strokekey.Color = library.theme.colors.primarycolor
			strokekey.Transparency = 1
			strokekey.Thickness = 1
			strokekey.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

			local cornerinput = Instance.new("UICorner", keybind.input)
			cornerinput.CornerRadius = UDim.new(0, 5)

			local shorter_keycodes = {
				["LeftShift"] = "LSHIFT",
				["RightShift"] = "RSHIFT",
				["LeftControl"] = "LCTRL",
				["RightControl"] = "RCTRL",
				["LeftAlt"] = "LALT",
				["RightAlt"] = "RALT"
			}

			local function getKeyText(key)
				if typeof(key) == "EnumItem" and key.EnumType == Enum.KeyCode then
					return shorter_keycodes[key.Name] or key.Name
				elseif type(key) == "string" then
					return key
				end
				return [[none]]
			end

			function keybind:Set(key)
				if typeof(key) == "EnumItem" and key.EnumType == Enum.KeyCode then
					keybind.value = key
					keybind.input.Text = getKeyText(key)
				elseif type(key) == "string" and key:lower() == [[none]] then
					keybind.value = [[none]]
					keybind.input.Text = [[none]]
				else
					keybind.value = [[none]]
					keybind.input.Text = [[none]]
				end
				keybind.input.TextColor3 = library.theme.colors.titlecolor
				pcall(keybind.changedCallback, keybind.value)
			end

			function keybind:Get()
				return keybind.value
			end

			local function stopListening()
				keybind.listening = false
				if keybind.input and keybind.input.Parent then
					if keybind.input.Text == [[waiting]] then
						keybind.input.Text = getKeyText(keybind.value)
					end
					keybind.input.TextColor3 = library.theme.colors.titlecolor
					library:tween(shadowkey, { Transparency = 1 })
					library:tween(strokekey, { Transparency = 1 })
				end
			end

			keybind.input.MouseButton1Click:Connect(function()
				keybind.listening = true
				keybind.input.Text = [[waiting]]
				keybind.input.TextColor3 = library.theme.colors.primarycolor
				library:tween(shadowkey, { Transparency = 0 })
				library:tween(strokekey, { Transparency = 0 })
			end)

			UserInputService.InputBegan:Connect(function(input, gameProcessed)
				if gameProcessed then
					return
				end

				if keybind.listening then
					if input.UserInputType == Enum.UserInputType.Keyboard then
						keybind:Set(input.KeyCode)
					else
						keybind:Set([[none]])
					end
					stopListening()
					return
				end

				if keybind.value ~= [[none]] and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == keybind.value then
					pcall(keybind.callback, keybind.value)
				end
			end)

			keybind:Set(keybind.default)

			return keybind
		end

		return tab
	end

	return window
end

return library
