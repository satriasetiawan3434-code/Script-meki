MEKI HUB - ROBLOX SCRIPT
-- LocalScript
-- Place: StarterPlayer > StarterPlayerScripts
--==================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")

local Player = Players.LocalPlayer

--==================================================
-- SETTINGS
--==================================================

local FlySpeed = 60
local WalkSpeed = 16

local Flying = false
local Noclip = false
local ESPEnabled = false
local InfiniteJump = false
local Fullbright = false
local SpeedEnabled = false

local FlyConnection
local NoclipConnection
local JumpConnection
local ESPConnections = {}

--==================================================
-- CHARACTER
--==================================================

local function GetCharacter()
	return Player.Character
end

local function GetHumanoid()
	local Character = GetCharacter()
	return Character and Character:FindFirstChildOfClass("Humanoid")
end

local function GetRoot()
	local Character = GetCharacter()
	return Character and Character:FindFirstChild("HumanoidRootPart")
end

--==================================================
-- FLY
--==================================================

local FlyVelocity
local FlyGyro

local function StopFly()
	Flying = false

	if FlyConnection then
		FlyConnection:Disconnect()
		FlyConnection = nil
	end

	if FlyVelocity then
		FlyVelocity:Destroy()
		FlyVelocity = nil
	end

	if FlyGyro then
		FlyGyro:Destroy()
		FlyGyro = nil
	end

	local Humanoid = GetHumanoid()

	if Humanoid then
		Humanoid.AutoRotate = true
		Humanoid.PlatformStand = false
	end
end

local function StartFly()
	StopFly()

	local Humanoid = GetHumanoid()
	local Root = GetRoot()

	if not Humanoid or not Root then
		return
	end

	Flying = true
	Humanoid.AutoRotate = false
	Humanoid.PlatformStand = false

	FlyVelocity = Instance.new("BodyVelocity")
	FlyVelocity.Name = "MekiFlyVelocity"
	FlyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
	FlyVelocity.P = 10000
	FlyVelocity.Velocity = Vector3.zero
	FlyVelocity.Parent = Root

	FlyGyro = Instance.new("BodyGyro")
	FlyGyro.Name = "MekiFlyGyro"
	FlyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
	FlyGyro.P = 10000
	FlyGyro.D = 500
	FlyGyro.Parent = Root

	FlyConnection = RunService.RenderStepped:Connect(function()
		if not Flying then
			return
		end

		local CurrentHumanoid = GetHumanoid()
		local CurrentRoot = GetRoot()
		local Camera = workspace.CurrentCamera

		if not CurrentHumanoid or not CurrentRoot or not Camera then
			StopFly()
			return
		end

		local MoveDirection = CurrentHumanoid.MoveDirection
		local Direction = Vector3.zero

		if MoveDirection.Magnitude > 0.05 then
			local CameraLook = Camera.CFrame.LookVector
			local CameraRight = Camera.CFrame.RightVector

			local FlatLook = Vector3.new(CameraLook.X, 0, CameraLook.Z)
			local FlatRight = Vector3.new(CameraRight.X, 0, CameraRight.Z)

			if FlatLook.Magnitude > 0 then
				FlatLook = FlatLook.Unit
			end

			if FlatRight.Magnitude > 0 then
				FlatRight = FlatRight.Unit
			end

			local ForwardAmount = MoveDirection:Dot(FlatLook)
			local SideAmount = MoveDirection:Dot(FlatRight)

			Direction =
				CameraLook * ForwardAmount
				+ CameraRight * SideAmount

			if Direction.Magnitude > 0.05 then
				Direction = Direction.Unit * FlySpeed
			else
				Direction = Vector3.zero
			end
		end

		FlyVelocity.Velocity = Direction

		FlyGyro.CFrame = CFrame.lookAt(
			CurrentRoot.Position,
			CurrentRoot.Position + Camera.CFrame.LookVector
		)
	end)
end

--==================================================
-- SPEED
--==================================================

local function UpdateSpeed()
	local Humanoid = GetHumanoid()

	if Humanoid then
		if SpeedEnabled then
			Humanoid.WalkSpeed = WalkSpeed
		else
			Humanoid.WalkSpeed = 16
		end
	end
end

--==================================================
-- NOCLIP
--==================================================

local function StopNoclip()
	Noclip = false

	if NoclipConnection then
		NoclipConnection:Disconnect()
		NoclipConnection = nil
	end

	local Character = GetCharacter()

	if Character then
		for _, Object in ipairs(Character:GetDescendants()) do
			if Object:IsA("BasePart") then
				Object.CanCollide = true
			end
		end
	end
end

local function StartNoclip()
	StopNoclip()

	Noclip = true

	NoclipConnection = RunService.Stepped:Connect(function()
		if not Noclip then
			return
		end

		local Character = GetCharacter()

		if not Character then
			return
		end

		for _, Object in ipairs(Character:GetDescendants()) do
			if Object:IsA("BasePart") then
				Object.CanCollide = false
			end
		end
	end)
end

--==================================================
-- ESP
--==================================================

local function ClearESP()
	for _, Connection in ipairs(ESPConnections) do
		pcall(function()
			Connection:Disconnect()
		end)
	end

	table.clear(ESPConnections)

	for _, Target in ipairs(Players:GetPlayers()) do
		if Target ~= Player and Target.Character then
			local Head = Target.Character:FindFirstChild("Head")

			if Head then
				local ESPObject = Head:FindFirstChild("MekiESP")

				if ESPObject then
					ESPObject:Destroy()
				end
			end
		end
	end
end

local function AddESP(Target)
	if Target == Player then
		return
	end

	local function CreateESP(Character)
		if not ESPEnabled then
			return
		end

		local Head = Character:WaitForChild("Head", 5)

		if not Head then
			return
		end

		local Old = Head:FindFirstChild("MekiESP")

		if Old then
			Old:Destroy()
		end

		local Billboard = Instance.new("BillboardGui")
		Billboard.Name = "MekiESP"
		Billboard.Size = UDim2.fromOffset(180, 45)
		Billboard.StudsOffset = Vector3.new(0, 3, 0)
		Billboard.AlwaysOnTop = true
		Billboard.Parent = Head

		local NameLabel = Instance.new("TextLabel")
		NameLabel.Size = UDim2.new(1, 0, 0.55, 0)
		NameLabel.BackgroundTransparency = 1
		NameLabel.Text = Target.DisplayName
		NameLabel.TextColor3 = Color3.new(1, 1, 1)
		NameLabel.TextStrokeTransparency = 0
		NameLabel.Font = Enum.Font.GothamBold
		NameLabel.TextSize = 13
		NameLabel.Parent = Billboard

		local DistanceLabel = Instance.new("TextLabel")
		DistanceLabel.Size = UDim2.new(1, 0, 0.45, 0)
		DistanceLabel.Position = UDim2.new(0, 0, 0.55, 0)
		DistanceLabel.BackgroundTransparency = 1
		DistanceLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
		DistanceLabel.TextStrokeTransparency = 0
		DistanceLabel.Font = Enum.Font.Gotham
		DistanceLabel.TextSize = 11
		DistanceLabel.Parent = Billboard

		local Connection

		Connection = RunService.RenderStepped:Connect(function()
			if not ESPEnabled or not Billboard.Parent then
				Connection:Disconnect()
				return
			end

			local MyRoot = GetRoot()
			local TargetRoot = Character:FindFirstChild("HumanoidRootPart")

			if MyRoot and TargetRoot then
				local Distance = math.floor(
					(MyRoot.Position - TargetRoot.Position).Magnitude
				)

				DistanceLabel.Text = Distance .. " studs"
			end
		end)

		table.insert(ESPConnections, Connection)
	end

	if Target.Character then
		CreateESP(Target.Character)
	end

	local Connection = Target.CharacterAdded:Connect(function(Character)
		task.wait(0.5)

		if ESPEnabled then
			CreateESP(Character)
		end
	end)

	table.insert(ESPConnections, Connection)
end

local function SetESP(State)
	ESPEnabled = State

	ClearESP()

	if not State then
		return
	end

	for _, Target in ipairs(Players:GetPlayers()) do
		AddESP(Target)
	end
end

--==================================================
-- FULLBRIGHT
--==================================================

local function SetFullbright(State)
	Fullbright = State

	if State then
		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000
		Lighting.GlobalShadows = false
		Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
	else
		Lighting.Brightness = 1
		Lighting.ClockTime = 14
		Lighting.FogEnd = 10000
		Lighting.GlobalShadows = true
		Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
	end
end

--==================================================
-- INFINITE JUMP
--==================================================

local function SetInfiniteJump(State)
	InfiniteJump = State

	if JumpConnection then
		JumpConnection:Disconnect()
		JumpConnection = nil
	end

	if State then
		JumpConnection = UIS.JumpRequest:Connect(function()
			if not InfiniteJump then
				return
			end

			local Humanoid = GetHumanoid()

			if Humanoid then
				Humanoid:ChangeState(
					Enum.HumanoidStateType.Jumping
				)
			end
		end)
	end
end

--==================================================
-- GUI
--==================================================

local Gui = Instance.new("ScreenGui")
Gui.Name = "MekiHub"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Gui.Parent = Player:WaitForChild("PlayerGui")

--==================================================
-- MAIN
--==================================================

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Size = UDim2.fromOffset(600, 420)
Main.Position = UDim2.new(0.5, -300, 0.5, -210)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
Main.BorderSizePixel = 0
Main.Active = true
Main.Parent = Gui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = Main

--==================================================
-- TOP BAR
--==================================================

local Top = Instance.new("Frame")
Top.Size = UDim2.new(1, 0, 0, 48)
Top.BackgroundColor3 = Color3.fromRGB(14, 14, 19)
Top.BorderSizePixel = 0
Top.Parent = Main

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = Top

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -150, 1, 0)
Title.Position = UDim2.fromOffset(15, 0)
Title.BackgroundTransparency = 1
Title.Text = "MEKI HUB"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 17
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Top

local Status = Instance.new("TextLabel")
Status.Size = UDim2.fromOffset(80, 48)
Status.Position = UDim2.new(1, -120, 0, 0)
Status.BackgroundTransparency = 1
Status.Text = "● ONLINE"
Status.TextColor3 = Color3.fromRGB(0, 255, 120)
Status.Font = Enum.Font.GothamBold
Status.TextSize = 9
Status.Parent = Top

--==================================================
-- MINIMIZE BUTTON
--==================================================

local Minimize = Instance.new("TextButton")
Minimize.Name = "Minimize"
Minimize.Size = UDim2.fromOffset(30, 30)
Minimize.Position = UDim2.new(1, -72, 0, 9)
Minimize.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
Minimize.Text = "−"
Minimize.TextColor3 = Color3.new(1, 1, 1)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 18
Minimize.BorderSizePixel = 0
Minimize.ZIndex = 10
Minimize.Parent = Top

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 7)
MinCorner.Parent = Minimize

--==================================================
-- CLOSE BUTTON
--==================================================

local Close = Instance.new("TextButton")
Close.Size = UDim2.fromOffset(30, 30)
Close.Position = UDim2.new(1, -38, 0, 9)
Close.BackgroundColor3 = Color3.fromRGB(190, 45, 55)
Close.Text = "×"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 18
Close.BorderSizePixel = 0
Close.Parent = Top

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 7)
CloseCorner.Parent = Close

--==================================================
-- MINI BUTTON
--==================================================

local MiniButton = Instance.new("TextButton")
MiniButton.Name = "MiniButton"
MiniButton.Size = UDim2.fromOffset(58, 58)
MiniButton.Position = Main.Position
MiniButton.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
MiniButton.Text = "MEKI"
MiniButton.TextColor3 = Color3.new(1, 1, 1)
MiniButton.Font = Enum.Font.GothamBlack
MiniButton.TextSize = 11
MiniButton.BorderSizePixel = 0
MiniButton.Visible = false
MiniButton.Active = true
MiniButton.ZIndex = 100
MiniButton.Parent = Gui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0, 12)
MiniCorner.Parent = MiniButton

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Thickness = 2
MiniStroke.Color = Color3.fromRGB(110, 70, 255)
MiniStroke.Parent = MiniButton

--==================================================
-- MINIMIZE / RESTORE
--==================================================

Minimize.MouseButton1Click:Connect(function()
	MiniButton.Position = Main.Position
	Main.Visible = false
	MiniButton.Visible = true
end)

MiniButton.MouseButton1Click:Connect(function()
	Main.Position = MiniButton.Position
	MiniButton.Visible = false
	Main.Visible = true
end)

--==================================================
-- DRAG MAIN
--==================================================

local Dragging = false
local DragStart
local StartPosition

Top.InputBegan:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		Dragging = true
		DragStart = Input.Position
		StartPosition = Main.Position
	end
end)

UIS.InputChanged:Connect(function(Input)
	if not Dragging then
		return
	end

	if Input.UserInputType == Enum.UserInputType.MouseMovement
		or Input.UserInputType == Enum.UserInputType.Touch then

		local Delta = Input.Position - DragStart

		Main.Position = UDim2.new(
			StartPosition.X.Scale,
			StartPosition.X.Offset + Delta.X,
			StartPosition.Y.Scale,
			StartPosition.Y.Offset + Delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		Dragging = false
	end
end)

--==================================================
-- DRAG MINI BUTTON
--==================================================

local MiniDragging = false
local MiniDragStart
local MiniStartPosition

MiniButton.InputBegan:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		MiniDragging = true
		MiniDragStart = Input.Position
		MiniStartPosition = MiniButton.Position
	end
end)

UIS.InputChanged:Connect(function(Input)
	if not MiniDragging then
		return
	end

	if Input.UserInputType == Enum.UserInputType.MouseMovement
		or Input.UserInputType == Enum.UserInputType.Touch then

		local Delta = Input.Position - MiniDragStart

		MiniButton.Position = UDim2.new(
			MiniStartPosition.X.Scale,
			MiniStartPosition.X.Offset + Delta.X,
			MiniStartPosition.Y.Scale,
			MiniStartPosition.Y.Offset + Delta.Y
		)
	end
end)

UIS.InputEnded:Connect(function(Input)
	if Input.UserInputType == Enum.UserInputType.MouseButton1
		or Input.UserInputType == Enum.UserInputType.Touch then

		MiniDragging = false
	end
end)

--==================================================
-- CLOSE
--==================================================

Close.MouseButton1Click:Connect(function()
	StopFly()
	StopNoclip()
	SetESP(false)
	SetInfiniteJump(false)

	if Gui then
		Gui:Destroy()
	end
end)

--==================================================
-- SIDEBAR
--==================================================

local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.fromOffset(140, 360)
Sidebar.Position = UDim2.fromOffset(5, 53)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Main

local SideCorner = Instance.new("UICorner")
SideCorner.CornerRadius = UDim.new(0, 8)
SideCorner.Parent = Sidebar

--==================================================
-- CONTENT
--==================================================

local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -152, 1, -58)
Content.Position = UDim2.fromOffset(147, 53)
Content.BackgroundColor3 = Color3.fromRGB(27, 27, 34)
Content.BorderSizePixel = 0
Content.ClipsDescendants = true
Content.Parent = Main

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 8)
ContentCorner.Parent = Content

--==================================================
-- TABS
--==================================================

local Tabs = {}

local TabNames = {
	"Home",
	"Movement",
	"ESP",
	"Teleport",
	"Player"
}

local function CreateTab(Name, Index)
	local ButtonObject = Instance.new("TextButton")

	ButtonObject.Size = UDim2.new(1, -12, 0, 42)
	ButtonObject.Position = UDim2.fromOffset(
		6,
		7 + (Index - 1) * 48
	)

	ButtonObject.BackgroundColor3 = Color3.fromRGB(28, 28, 35)
	ButtonObject.BorderSizePixel = 0
	ButtonObject.Text = Name
	ButtonObject.TextColor3 = Color3.fromRGB(225, 225, 230)
	ButtonObject.Font = Enum.Font.GothamSemibold
	ButtonObject.TextSize = 11
	ButtonObject.AutoButtonColor = false
	ButtonObject.Parent = Sidebar

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 7)
	Corner.Parent = ButtonObject

	local Page = Instance.new("ScrollingFrame")

	Page.Size = UDim2.new(1, -10, 1, -10)
	Page.Position = UDim2.fromOffset(5, 5)
	Page.BackgroundTransparency = 1
	Page.BorderSizePixel = 0
	Page.ScrollBarThickness = 3
	Page.ScrollBarImageColor3 = Color3.fromRGB(110, 70, 255)
	Page.CanvasSize = UDim2.fromOffset(0, 0)
	Page.Visible = false
	Page.Parent = Content

	Tabs[Name] = {
		Button = ButtonObject,
		Page = Page
	}

	ButtonObject.MouseButton1Click:Connect(function()
		for _, Tab in pairs(Tabs) do
			Tab.Page.Visible = false
			Tab.Button.BackgroundColor3 =
				Color3.fromRGB(28, 28, 35)
		end

		Page.Visible = true
		ButtonObject.BackgroundColor3 =
			Color3.fromRGB(110, 70, 255)
	end)
end

for Index, Name in ipairs(TabNames) do
	CreateTab(Name, Index)
end

--==================================================
-- UI HELPERS
--==================================================

local function Label(Parent, Text, Y)
	local Object = Instance.new("TextLabel")

	Object.Size = UDim2.new(0.9, 0, 0, 25)
	Object.Position = UDim2.new(0.05, 0, 0, Y)
	Object.BackgroundTransparency = 1
	Object.Text = Text
	Object.TextColor3 = Color3.fromRGB(175, 175, 185)
	Object.Font = Enum.Font.GothamBold
	Object.TextSize = 10
	Object.TextXAlignment = Enum.TextXAlignment.Left
	Object.Parent = Parent

	return Object
end

local function Button(Parent, Text, Y, Callback)
	local Object = Instance.new("TextButton")

	Object.Size = UDim2.new(0.9, 0, 0, 38)
	Object.Position = UDim2.new(0.05, 0, 0, Y)
	Object.BackgroundColor3 = Color3.fromRGB(38, 38, 47)
	Object.BorderSizePixel = 0
	Object.Text = Text
	Object.TextColor3 = Color3.new(1, 1, 1)
	Object.Font = Enum.Font.GothamSemibold
	Object.TextSize = 10
	Object.Parent = Parent

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 7)
	Corner.Parent = Object

	Object.MouseButton1Click:Connect(function()
		pcall(Callback)
	end)

	return Object
end

local function Toggle(Parent, Text, Y, Default, Callback)
	local Object = Instance.new("TextButton")

	Object.Size = UDim2.new(0.9, 0, 0, 40)
	Object.Position = UDim2.new(0.05, 0, 0, Y)
	Object.BackgroundColor3 = Color3.fromRGB(38, 38, 47)
	Object.BorderSizePixel = 0
	Object.Text = ""
	Object.Parent = Parent

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 7)
	Corner.Parent = Object

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, -65, 1, 0)
	TextLabel.Position = UDim2.fromOffset(12, 0)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = Text
	TextLabel.TextColor3 = Color3.new(1, 1, 1)
	TextLabel.Font = Enum.Font.GothamSemibold
	TextLabel.TextSize = 10
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = Object

	local Switch = Instance.new("Frame")

	Switch.Size = UDim2.fromOffset(42, 22)
	Switch.Position = UDim2.new(1, -52, 0.5, -11)
	Switch.BackgroundColor3 = Color3.fromRGB(65, 65, 75)
	Switch.BorderSizePixel = 0
	Switch.Parent = Object

	local SwitchCorner = Instance.new("UICorner")
	SwitchCorner.CornerRadius = UDim.new(1, 0)
	SwitchCorner.Parent = Switch

	local Dot = Instance.new("Frame")

	Dot.Size = UDim2.fromOffset(18, 18)
	Dot.Position = UDim2.fromOffset(2, 2)
	Dot.BackgroundColor3 = Color3.new(1, 1, 1)
	Dot.BorderSizePixel = 0
	Dot.Parent = Switch

	local DotCorner = Instance.new("UICorner")
	DotCorner.CornerRadius = UDim.new(1, 0)
	DotCorner.Parent = Dot

	local State = Default

	local function Update()
		if State then
			Switch.BackgroundColor3 =
				Color3.fromRGB(80, 210, 130)

			Dot.Position =
				UDim2.new(1, -20, 0, 2)
		else
			Switch.BackgroundColor3 =
				Color3.fromRGB(65, 65, 75)

			Dot.Position =
				UDim2.fromOffset(2, 2)
		end
	end

	Update()

	Object.MouseButton1Click:Connect(function()
		State = not State
		Update()

		pcall(function()
			Callback(State)
		end)
	end)

	return Object
end

local function Slider(
	Parent,
	Text,
	Y,
	Min,
	Max,
	Default,
	Callback
)
	local Frame = Instance.new("Frame")

	Frame.Size = UDim2.new(0.9, 0, 0, 62)
	Frame.Position = UDim2.new(0.05, 0, 0, Y)
	Frame.BackgroundColor3 = Color3.fromRGB(38, 38, 47)
	Frame.BorderSizePixel = 0
	Frame.Parent = Parent

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 7)
	Corner.Parent = Frame

	local TextLabel = Instance.new("TextLabel")

	TextLabel.Size = UDim2.new(1, -20, 0, 22)
	TextLabel.Position = UDim2.fromOffset(10, 4)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Text = Text .. ": " .. Default
	TextLabel.TextColor3 = Color3.new(1, 1, 1)
	TextLabel.Font = Enum.Font.GothamSemibold
	TextLabel.TextSize = 10
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.Parent = Frame

	local Bar = Instance.new("Frame")

	Bar.Size = UDim2.new(1, -20, 0, 7)
	Bar.Position = UDim2.fromOffset(10, 36)
	Bar.BackgroundColor3 = Color3.fromRGB(65, 65, 75)
	Bar.BorderSizePixel = 0
	Bar.Parent = Frame

	local BarCorner = Instance.new("UICorner")
	BarCorner.CornerRadius = UDim.new(1, 0)
	BarCorner.Parent = Bar

	local Fill = Instance.new("Frame")

	Fill.Size = UDim2.new(
		(Default - Min) / (Max - Min),
		0,
		1,
		0
	)

	Fill.BackgroundColor3 = Color3.fromRGB(110, 70, 255)
	Fill.BorderSizePixel = 0
	Fill.Parent = Bar

	local FillCorner = Instance.new("UICorner")
	FillCorner.CornerRadius = UDim.new(1, 0)
	FillCorner.Parent = Fill

	local DraggingSlider = false

	local function SetValue(X)
		local Percent = math.clamp(
			(X - Bar.AbsolutePosition.X)
			/ Bar.AbsoluteSize.X,
			0,
			1
		)

		local Value = math.floor(
			Min + (Max - Min) * Percent
		)

		Fill.Size = UDim2.new(
			Percent,
			0,
			1,
			0
		)

		TextLabel.Text = Text .. ": " .. Value

		Callback(Value)
	end

	Bar.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1
			or Input.UserInputType == Enum.UserInputType.Touch then

			DraggingSlider = true
			SetValue(Input.Position.X)
		end
	end)

	UIS.InputChanged:Connect(function(Input)
		if not DraggingSlider then
			return
		end

		if Input.UserInputType == Enum.UserInputType.MouseMovement
			or Input.UserInputType == Enum.UserInputType.Touch then

			SetValue(Input.Position.X)
		end
	end)

	UIS.InputEnded:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.MouseButton1
			or Input.UserInputType == Enum.UserInputType.Touch then

			DraggingSlider = false
		end
	end)

	return Frame
end

--==================================================
-- HOME
--==================================================

local Home = Tabs.Home.Page

Label(Home, "MEKI HUB", 10)

local Welcome = Instance.new("TextLabel")
Welcome.Size = UDim2.new(0.9, 0, 0, 45)
Welcome.Position = UDim2.new(0.05, 0, 0, 35)
Welcome.BackgroundTransparency = 1
Welcome.Text = "Welcome, " .. Player.DisplayName
Welcome.TextColor3 = Color3.new(1, 1, 1)
Welcome.Font = Enum.Font.GothamBlack
Welcome.TextSize = 18
Welcome.TextXAlignment = Enum.TextXAlignment.Left
Welcome.Parent = Home

Label(Home, "QUICK SETTINGS", 90)

Toggle(Home, "Fullbright", 120, false, function(State)
	SetFullbright(State)
end)

Button(Home, "Reset Character", 170, function()
	local Humanoid = GetHumanoid()

	if Humanoid then
		Humanoid.Health = 0
	end
end)

Button(Home, "Disable All", 215, function()
	StopFly()
	StopNoclip()
	SetESP(false)
	SetInfiniteJump(false)

	SpeedEnabled = false
	WalkSpeed = 16
	UpdateSpeed()
end)

Home.CanvasSize = UDim2.fromOffset(0, 280)

--==================================================
-- MOVEMENT
--==================================================

local Movement = Tabs.Movement.Page

Label(Movement, "MOVEMENT", 10)

Toggle(Movement, "Enable Speed", 38, false, function(State)
	SpeedEnabled = State
	UpdateSpeed()
end)

Slider(
	Movement,
	"Walk Speed",
	88,
	16,
	300,
	16,
	function(Value)
		WalkSpeed = Value
		UpdateSpeed()
	end
)

Label(Movement, "FLY", 165)

Toggle(Movement, "Enable Fly", 195, false, function(State)
	if State then
		StartFly()
	else
		StopFly()
	end
end)

Slider(
	Movement,
	"Fly Speed",
	245,
	10,
	300,
	60,
	function(Value)
		FlySpeed = Value
	end
)

Label(Movement, "NOCLIP", 320)

Toggle(Movement, "Enable Noclip", 350, false, function(State)
	if State then
		StartNoclip()
	else
		StopNoclip()
	end
end)

local FlyInfo = Instance.new("TextLabel")
FlyInfo.Size = UDim2.new(0.9, 0, 0, 65)
FlyInfo.Position = UDim2.new(0.05, 0, 0, 400)
FlyInfo.BackgroundTransparency = 1
FlyInfo.Text =
	"Mobile Fly:\n" ..
	"Joystick maju + kamera ke atas = naik\n" ..
	"Joystick maju + kamera ke bawah = turun"
FlyInfo.TextColor3 = Color3.fromRGB(175, 175, 185)
FlyInfo.Font = Enum.Font.Gotham
FlyInfo.TextSize = 10
FlyInfo.TextXAlignment = Enum.TextXAlignment.Left
FlyInfo.Parent = Movement

Movement.CanvasSize = UDim2.fromOffset(0, 480)

--==================================================
-- ESP
--==================================================

local ESP = Tabs.ESP.Page

Label(ESP, "PLAYER ESP", 10)

Toggle(ESP, "Enable ESP", 40, false, function(State)
	SetESP(State)
end)

Button(ESP, "Refresh ESP", 90, function()
	if ESPEnabled then
		SetESP(false)
		task.wait()
		SetESP(true)
	end
end)

ESP.CanvasSize = UDim2.fromOffset(0, 180)

--==================================================
-- TELEPORT
--==================================================

local Teleport = Tabs.Teleport.Page

Label(Teleport, "PLAYER TELEPORT", 10)

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(0.9, 0, 0, 270)
PlayerList.Position = UDim2.new(0.05, 0, 0, 40)
PlayerList.BackgroundColor3 = Color3.fromRGB(35, 35, 42)
PlayerList.BorderSizePixel = 0
PlayerList.ScrollBarThickness = 3
PlayerList.Parent = Teleport

local List = Instance.new("UIListLayout")
List.Padding = UDim.new(0, 5)
List.Parent = PlayerList

local function RefreshPlayers()
	for _, Child in ipairs(PlayerList:GetChildren()) do
		if Child:IsA("TextButton") then
			Child:Destroy()
		end
	end

	for _, Target in ipairs(Players:GetPlayers()) do
		if Target ~= Player then
			local PlayerButton = Instance.new("TextButton")

			PlayerButton.Size =
				UDim2.new(1, -10, 0, 35)

			PlayerButton.BackgroundColor3 =
				Color3.fromRGB(45, 45, 55)

			PlayerButton.BorderSizePixel = 0
			PlayerButton.Text = Target.DisplayName
			PlayerButton.TextColor3 = Color3.new(1, 1, 1)
			PlayerButton.Font = Enum.Font.GothamSemibold
			PlayerButton.TextSize = 10
			PlayerButton.Parent = PlayerList

			local Corner = Instance.new("UICorner")
			Corner.CornerRadius = UDim.new(0, 6)
			Corner.Parent = PlayerButton

			PlayerButton.MouseButton1Click:Connect(function()
				local MyRoot = GetRoot()
				local TargetCharacter = Target.Character

				local TargetRoot =
					TargetCharacter
					and TargetCharacter:FindFirstChild(
						"HumanoidRootPart"
					)

				if MyRoot and TargetRoot then
					MyRoot.CFrame =
						TargetRoot.CFrame
						* CFrame.new(3, 0, 0)
				end
			end)
		end
	end

	task.wait()

	PlayerList.CanvasSize = UDim2.fromOffset(
		0,
		List.AbsoluteContentSize.Y + 10
	)
end

RefreshPlayers()

Players.PlayerAdded:Connect(function()
	task.wait()
	RefreshPlayers()
end)

Players.PlayerRemoving:Connect(function()
	task.wait()
	RefreshPlayers()
end)

Button(
	Teleport,
	"Refresh Players",
	325,
	RefreshPlayers
)

Teleport.CanvasSize = UDim2.fromOffset(0, 390)

--==================================================
-- PLAYER
--==================================================

local PlayerPage = Tabs.Player.Page

Label(PlayerPage, "PLAYER", 10)

Slider(
	PlayerPage,
	"FOV",
	40,
	30,
	120,
	70,
	function(Value)
		local Camera = workspace.CurrentCamera

		if Camera then
			Camera.FieldOfView = Value
		end
	end
)

Button(PlayerPage, "Reset FOV", 115, function()
	local Camera = workspace.CurrentCamera

	if Camera then
		Camera.FieldOfView = 70
	end
end)

Toggle(
	PlayerPage,
	"Infinite Jump",
	165,
	false,
	function(State)
		SetInfiniteJump(State)
	end
)

Button(
	PlayerPage,
	"Reset WalkSpeed",
	215,
	function()
		WalkSpeed = 16
		SpeedEnabled = false
		UpdateSpeed()
	end
)

PlayerPage.CanvasSize = UDim2.fromOffset(0, 280)

--==================================================
-- DEFAULT TAB
--==================================================

Tabs.Home.Page.Visible = true
Tabs.Home.Button.BackgroundColor3 =
	Color3.fromRGB(110, 70, 255)

--==================================================
-- RESPAWN
--==================================================

Player.CharacterAdded:Connect(function()
	task.wait(0.7)

	UpdateSpeed()

	if Noclip then
		StartNoclip()
	end

	if ESPEnabled then
		SetESP(true)
	end
end)

--==================================================
-- NEW PLAYER ESP
--==================================================

Players.PlayerAdded:Connect(function(Target)
	if ESPEnabled then
		task.wait(0.5)
		AddESP(Target)
	end
end)

--==================================================
-- RIGHT CONTROL
--==================================================

UIS.InputBegan:Connect(function(Input, Processed)
	if Processed then
		return
	end

	if Input.KeyCode == Enum.KeyCode.RightControl then
		if Main.Visible then
			Main.Visible = false
			MiniButton.Position = Main.Position
			MiniButton.Visible = true
		else
			Main.Position = MiniButton.Position
			MiniButton.Visible = false
			Main.Visible = true
		end
	end
end)

--==================================================
-- MOBILE SCALE
--==================================================

if UIS.TouchEnabled then
	local Scale = Instance.new("UIScale")
	Scale.Scale = 0.82
	Scale.Parent = Main
end

print("================================")
print("MEKI HUB LOADED")
print("v1.0 Version")
print("Minimize + Draggable Mini Button")
print("================================")
