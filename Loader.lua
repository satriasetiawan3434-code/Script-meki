local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MekiScripterLoader"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true

local ok = pcall(function()
	screenGui.Parent = game:GetService("CoreGui")
end)
if not ok then
	screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
end

local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleText"
titleLabel.Size = UDim2.new(1, 0, 1, -40)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = ""
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 68
titleLabel.Font = Enum.Font.Gotham
titleLabel.TextTransparency = 1
titleLabel.Parent = screenGui

local LOADER_URL = "https://raw.githubusercontent.com/satriasetiawan3434-code/Script-meki/refs/heads/main/Meki.json"
local prefetchConfig, prefetchConfigErr
local prefetchScript, prefetchScriptErr
task.spawn(function()
	local okRaw, raw = pcall(function() return game:HttpGet(LOADER_URL) end)
	if not okRaw then prefetchConfigErr = raw return end
	local okJson, parsed = pcall(function() return HttpService:JSONDecode(raw) end)
	if not okJson then prefetchConfigErr = parsed return end
	prefetchConfig = parsed

	local placeId = tostring(game.PlaceId)
	local gameData = parsed.games and parsed.games[placeId]
	if not gameData or not gameData.url then return end
	local okSrc, src = pcall(function() return game:HttpGet(gameData.url) end)
	if okSrc then prefetchScript = src else prefetchScriptErr = src end
end)

local word = "Meki Scripter"
local frames = { "[ ]" }
for i = 1, #word do
	table.insert(frames, "[ " .. word:sub(1, i) .. " ]")
end

titleLabel.Text = frames[1]
local fadeIn = TweenService:Create(titleLabel, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
	TextTransparency = 0,
})
fadeIn:Play()
fadeIn.Completed:Wait()
task.wait(0.3)

for i = 2, #frames do
	titleLabel.Text = frames[i]
	task.wait(0.2)
end

task.wait(1)

local Theme = {
	Dialog              = Color3.fromRGB(45, 45, 45),
	DialogHolder        = Color3.fromRGB(35, 35, 35),
	DialogHolderLine    = Color3.fromRGB(30, 30, 30),
	DialogButton        = Color3.fromRGB(45, 45, 45),
	DialogButtonBorder  = Color3.fromRGB(80, 80, 80),
	DialogBorder        = Color3.fromRGB(70, 70, 70),
	Text                = Color3.fromRGB(240, 240, 240),
	Hover               = Color3.fromRGB(120, 120, 120),
}

local GothamFace     = Font.new("rbxasset://fonts/families/GothamSSm.json")
local GothamSemiBold = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.SemiBold)

local function showDialog(message, buttons)
	local dialogGui = Instance.new("ScreenGui")
	dialogGui.Name = "MekiScripterDialog"
	dialogGui.ResetOnSpawn = false
	dialogGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	dialogGui.IgnoreGuiInset = true
	dialogGui.DisplayOrder = 10
	local parented = pcall(function()
		dialogGui.Parent = game:GetService("CoreGui")
	end)
	if not parented then
		dialogGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
	end

	local TintFrame = Instance.new("TextButton")
	TintFrame.Name = "TintFrame"
	TintFrame.Text = ""
	TintFrame.AutoButtonColor = false
	TintFrame.Size = UDim2.fromScale(1, 1)
	TintFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	TintFrame.BackgroundTransparency = 1
	TintFrame.BorderSizePixel = 0
	TintFrame.Parent = dialogGui

	local Root = Instance.new("CanvasGroup")
	Root.Name = "Root"
	Root.Size = UDim2.fromOffset(420, 200)
	Root.AnchorPoint = Vector2.new(0.5, 0.5)
	Root.Position = UDim2.fromScale(0.5, 0.5)
	Root.BackgroundColor3 = Theme.Dialog
	Root.BorderSizePixel = 0
	Root.GroupTransparency = 1
	Root.Parent = TintFrame

	local RootCorner = Instance.new("UICorner")
	RootCorner.CornerRadius = UDim.new(0, 8)
	RootCorner.Parent = Root

	local RootStroke = Instance.new("UIStroke")
	RootStroke.Color = Theme.DialogBorder
	RootStroke.Transparency = 0.5
	RootStroke.Parent = Root

	local Scale = Instance.new("UIScale")
	Scale.Scale = 1.1
	Scale.Parent = Root

	local Body = Instance.new("TextLabel")
	Body.Name = "Body"
	Body.BackgroundTransparency = 1
	Body.Size = UDim2.new(1, -40, 1, -90)
	Body.Position = UDim2.fromOffset(20, 10)
	Body.FontFace = GothamSemiBold
	Body.TextColor3 = Theme.Text
	Body.TextSize = 16
	Body.TextWrapped = true
	Body.TextXAlignment = Enum.TextXAlignment.Center
	Body.TextYAlignment = Enum.TextYAlignment.Center
	Body.Text = message
	Body.Parent = Root

	local ButtonHolderFrame = Instance.new("Frame")
	ButtonHolderFrame.Name = "ButtonHolderFrame"
	ButtonHolderFrame.Size = UDim2.new(1, 0, 0, 70)
	ButtonHolderFrame.Position = UDim2.new(0, 0, 1, -70)
	ButtonHolderFrame.BackgroundColor3 = Theme.DialogHolder
	ButtonHolderFrame.BorderSizePixel = 0
	ButtonHolderFrame.Parent = Root

	local SeparatorLine = Instance.new("Frame")
	SeparatorLine.Size = UDim2.new(1, 0, 0, 1)
	SeparatorLine.BackgroundColor3 = Theme.DialogHolderLine
	SeparatorLine.BorderSizePixel = 0
	SeparatorLine.Parent = ButtonHolderFrame

	local ButtonHolder = Instance.new("Frame")
	ButtonHolder.Size = UDim2.new(1, -40, 1, -40)
	ButtonHolder.AnchorPoint = Vector2.new(0.5, 0.5)
	ButtonHolder.Position = UDim2.fromScale(0.5, 0.5)
	ButtonHolder.BackgroundTransparency = 1
	ButtonHolder.Parent = ButtonHolderFrame

	local ListLayout = Instance.new("UIListLayout")
	ListLayout.Padding = UDim.new(0, 10)
	ListLayout.FillDirection = Enum.FillDirection.Horizontal
	ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
	ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	ListLayout.Parent = ButtonHolder

	local isOpen = true
	local function close()
		if not isOpen then return end
		isOpen = false

		TweenService:Create(Root, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			GroupTransparency = 1,
		}):Play()
		TweenService:Create(Scale, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			Scale = 1.1,
		}):Play()
		TweenService:Create(TintFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
			BackgroundTransparency = 1,
		}):Play()

		task.delay(0.22, function()
			dialogGui:Destroy()
		end)
	end

	local function createButton(title, layoutOrder, callback)
		local Frame = Instance.new("TextButton")
		Frame.Name = title
		Frame.Text = ""
		Frame.AutoButtonColor = false
		Frame.Size = UDim2.new(0, 0, 0, 32)
		Frame.BackgroundColor3 = Theme.DialogButton
		Frame.BorderSizePixel = 0
		Frame.LayoutOrder = layoutOrder
		Frame.Parent = ButtonHolder

		local Corner = Instance.new("UICorner")
		Corner.CornerRadius = UDim.new(0, 4)
		Corner.Parent = Frame

		local Stroke = Instance.new("UIStroke")
		Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		Stroke.Color = Theme.DialogButtonBorder
		Stroke.Transparency = 0.65
		Stroke.Parent = Frame

		local Hover = Instance.new("Frame")
		Hover.Size = UDim2.fromScale(1, 1)
		Hover.BackgroundColor3 = Theme.Hover
		Hover.BackgroundTransparency = 1
		Hover.BorderSizePixel = 0
		Hover.Parent = Frame

		local HoverCorner = Instance.new("UICorner")
		HoverCorner.CornerRadius = UDim.new(0, 4)
		HoverCorner.Parent = Hover

		local Label = Instance.new("TextLabel")
		Label.BackgroundTransparency = 1
		Label.Size = UDim2.fromScale(1, 1)
		Label.FontFace = GothamFace
		Label.Text = title
		Label.TextColor3 = Theme.Text
		Label.TextSize = 14
		Label.TextXAlignment = Enum.TextXAlignment.Center
		Label.TextYAlignment = Enum.TextYAlignment.Center
		Label.Parent = Frame

		local hoverTween = TweenInfo.new(0.15, Enum.EasingStyle.Quad)
		Frame.MouseEnter:Connect(function()
			TweenService:Create(Hover, hoverTween, { BackgroundTransparency = 0.97 }):Play()
		end)
		Frame.MouseLeave:Connect(function()
			TweenService:Create(Hover, hoverTween, { BackgroundTransparency = 1 }):Play()
		end)
		Frame.MouseButton1Click:Connect(function()
			if callback then
				pcall(callback)
			end
			close()
		end)

		return Frame
	end

	for i, btn in ipairs(buttons) do
		createButton(btn.Title, i, btn.Callback)
	end
	local n = #buttons
	for _, child in ipairs(ButtonHolder:GetChildren()) do
		if child:IsA("TextButton") then
			child.Size = UDim2.new(1 / n, -(((n - 1) * 10) / n), 0, 32)
		end
	end

	TweenService:Create(TintFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
		BackgroundTransparency = 0.75,
	}):Play()
	TweenService:Create(Root, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
		GroupTransparency = 0,
	}):Play()
	TweenService:Create(Scale, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {
		Scale = 1,
	}):Play()
end

local loaderFaded = false
local function fadeOutLoader()
	if loaderFaded then return end
	loaderFaded = true
	local fadeOut = TweenService:Create(titleLabel, TweenInfo.new(0.6, Enum.EasingStyle.Quad), { TextTransparency = 1 })
	fadeOut:Play()
	fadeOut.Completed:Wait()
	screenGui:Destroy()
end

local DISCORD_DISMISSED_FILE = "MekiScripter/discord_dismissed"

local function isDiscordDismissed()
	if not (isfile and readfile) then return false end
	local ok, result = pcall(function()
		return isfile(DISCORD_DISMISSED_FILE)
	end)
	return ok and result == true
end

local function markDiscordDismissed()
	if not writefile then return end
	pcall(function()
		if makefolder and isfolder and not isfolder("MekiScripter") then
			makefolder("MekiScripter")
		end
		writefile(DISCORD_DISMISSED_FILE, "1")
	end)
end

local function showActionDialog(message, onAccept)
	showDialog(message, {
		{
			Title = "Okay",
			Callback = function()
				if onAccept then
					task.spawn(onAccept)
				end
			end,
		},
		{
			Title = "Copy Discord",
			Callback = function()
				if setclipboard then
					setclipboard("https://discord.gg/kCZ8cYnyp")
				end
				if onAccept then
					task.spawn(onAccept)
				end
			end,
		},
	})
end

local waitDeadline = os.clock() + 10
while prefetchConfig == nil and prefetchConfigErr == nil and os.clock() < waitDeadline do
	task.wait(0.05)
end
local success = prefetchConfig ~= nil
local config = prefetchConfig

if not success or not config then
	showActionDialog(
		"Failed to fetch the Meki Scripter game list.\n\nJoin our Discord for support:\ndiscord.gg/kCZ8cYnyp",
		fadeOutLoader
	)
	return
end

local placeId = tostring(game.PlaceId)
local gameData = config.games and config.games[placeId]

if not gameData then
	showActionDialog(
		"This game is not yet supported.\nPlace ID: " .. placeId .. "\n\nRequest it on our Discord:\ndiscord.gg/kCZ8cYnyp",
		fadeOutLoader
	)
	return
end

task.wait(0.6)

local RELAY_URL   = "https://mrnoodles--9c5c204036b411f19dfb42b51c65c3df.web.val.run"
local RELAY_KEY   = "sk&vUeSFi]3*z5$)&tgpJC_4c{@7PfAF"
local httpRequest = (syn and syn.request) or (http and http.request) or http_request or request

local function reportLoaderError(message, details)
	pcall(function()
		if not httpRequest then return end
		httpRequest({
			Url     = RELAY_URL .. "/api/error",
			Method  = "POST",
			Headers = { ["Content-Type"] = "application/json", ["Authorization"] = "Bearer " .. RELAY_KEY },
			Body    = HttpService:JSONEncode({
				source  = "loader",
				message = tostring(message),
				details = details and tostring(details) or nil,
				userId  = tostring(LocalPlayer.UserId),
			}),
		})
	end)
end

local function loadGameScript()
	fadeOutLoader()
	task.wait(0.1)
	_G.MekiScripterShowDiscord = true

	local source, fetchErr
	local fetchOk = pcall(function()
		source = game:HttpGet(gameData.url)
	end)
	if not fetchOk or not source then
		local msg = "Failed to fetch the game script.\n\n" .. tostring(fetchErr or "Network error")
		warn("[Meki Scripter] " .. msg)
		reportLoaderError("Fetch failed", fetchErr)
		showActionDialog(msg, nil)
		return
	end

	local fn, compileErr = loadstring(source)
	if not fn then
		local msg = "Failed to compile the game script.\n\n" .. tostring(compileErr)
		warn("[Meki Scripter] " .. msg)
		reportLoaderError("Compile error: " .. tostring(compileErr))
		showActionDialog(msg, nil)
		return
	end

	local runOk, runErr = pcall(fn)
	if not runOk then
		local msg = "Failed to run the game script.\n\n" .. tostring(runErr)
		warn("[Meki Scripter] " .. msg)
		reportLoaderError("Runtime error: " .. tostring(runErr))
		showActionDialog(msg, nil)
	end
end

local function detectMainAccount()
	local score = 0

	local age = LocalPlayer.AccountAge or 0
	if age > 1095 then
		score = score + 3
	elseif age > 365 then
		score = score + 2
	elseif age > 30 then
		score = score + 1
	end

	if LocalPlayer.MembershipType == Enum.MembershipType.Premium then
		score = score + 3
	end

	pcall(function()
		local url = "https://friends.roblox.com/v1/users/" .. tostring(LocalPlayer.UserId) .. "/friends/count"
		local raw = game:HttpGet(url)
		local data = HttpService:JSONDecode(raw)
		local count = data and data.count or 0
		if count > 50 then
			score = score + 2
		elseif count > 10 then
			score = score + 1
		end
	end)

	return score >= 4
end

if detectMainAccount() then
	showDialog("Hey, we detected you may be on a main account. We recommend NOT using this on your main to avoid risking your account.", {
		{
			Title = "Continue Anyway",
			Callback = function()
				task.spawn(loadGameScript)
			end,
		},
		{
			Title = "Stop Script",
			Callback = function()
				fadeOutLoader()
			end,
		},
	})
elseif isDiscordDismissed() then
	task.spawn(loadGameScript)
else
	showActionDialog(
		"Our scripts are keyless, but we ask that you join the Discord to support us and get updates on new scripts!\n\ndiscord.gg/kCZ8cYnyp",
		function()
			markDiscordDismissed()
			loadGameScript()
		end
	)
end
