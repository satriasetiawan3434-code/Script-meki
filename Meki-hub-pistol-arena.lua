-- ==========================================
-- KEY SYSTEM - MEKI GANTENG
-- ==========================================
local validKey = "mekiganteng"
local keyVerified = false

-- Buat GUI Key
local function createKeyGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "KeySystem"
    screenGui.Parent = game:GetService("CoreGui")
    screenGui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 210)  -- Lebih tinggi buat tombol Get Key
    frame.Position = UDim2.new(0.5, -175, 0.5, -105)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    title.Text = "meki hub"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18

    local textBox = Instance.new("TextBox", frame)
    textBox.Size = UDim2.new(0, 220, 0, 36)
    textBox.Position = UDim2.new(0.5, -110, 0.28, 0)
    textBox.PlaceholderText = "Masukkan key..."
    textBox.Text = ""
    textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.Font = Enum.Font.Gotham
    textBox.TextSize = 16
    textBox.ClearTextOnFocus = false
    Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 4)

    local submitBtn = Instance.new("TextButton", frame)
    submitBtn.Size = UDim2.new(0, 120, 0, 38)
    submitBtn.Position = UDim2.new(0.5, -60, 0.55, 0)
    submitBtn.Text = "✅ Submit"
    submitBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
    submitBtn.TextColor3 = Color3.new(1, 1, 1)
    submitBtn.Font = Enum.Font.GothamBold
    submitBtn.TextSize = 16
    Instance.new("UICorner", submitBtn).CornerRadius = UDim.new(0, 6)

  -- ========== TOMBOL GET KEY ==========
local getKeyBtn = Instance.new("TextButton", frame)
getKeyBtn.Size = UDim2.new(0, 120, 0, 30)
getKeyBtn.Position = UDim2.new(0.5, -60, 0.75, 0)
getKeyBtn.Text = "📋 Get Key"
getKeyBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
getKeyBtn.TextColor3 = Color3.new(1, 1, 1)
getKeyBtn.Font = Enum.Font.GothamBold
getKeyBtn.TextSize = 14
Instance.new("UICorner", getKeyBtn).CornerRadius = UDim.new(0, 6)

getKeyBtn.MouseButton1Click:Connect(function()
    local url = "https://direct-link.net/3821198/c0U2lgPgMnJA"
    -- Coba salin ke clipboard
    local success = pcall(function()
        setclipboard(url)
    end)
    if success then
        statusLabel.Text = "✅ Link berhasil disalin!"
        statusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
        task.wait(2)
        statusLabel.Text = ""
    else
        -- Fallback: buka browser kalau setclipboard gagal
        pcall(function()
            game:GetService("GuiService"):OpenBrowserWindow(url)
        end)
        statusLabel.Text = "⚠️ Gagal copy, buka browser..."
        statusLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
        task.wait(2)
        statusLabel.Text = ""
    end
end)
-- ============================================

    local statusLabel = Instance.new("TextLabel", frame)
    statusLabel.Size = UDim2.new(1, 0, 0, 25)
    statusLabel.Position = UDim2.new(0, 0, 0.43, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = ""
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    statusLabel.Font = Enum.Font.Gotham
    statusLabel.TextSize = 14

    return screenGui, textBox, submitBtn, statusLabel
end

local gui, textBox, submitBtn, statusLabel = createKeyGUI()

-- Fungsi validasi
local function validate(input)
    if string.lower(input) == validKey then
        keyVerified = true
        gui:Destroy()
        return true
    else
        statusLabel.Text = "❌ Key salah! Coba lagi."
        textBox.Text = ""
        textBox.PlaceholderText = "Salah, ketik ulang..."
        return false
    end
end

submitBtn.MouseButton1Click:Connect(function()
    validate(textBox.Text)
end)

textBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then
        validate(textBox.Text)
    end
end)

-- Tunggu sampai key benar
repeat task.wait(0.1) until keyVerified == true

print("✅ Key valid! Memuat Meki Hub...")
-- ==========================================
-- LANJUT SCRIPT ASLI (di bawah ini)
-- ==========================================

-- [[ meki scripts Notice ]]
-- This script is not verified by rscripts.net. Deal with caution.
--
-- Stay safe:
--   • Never log in on unofficial Roblox sites or lookalike domains.
--   • Real Roblox links use roblox.com (check the .com ending).
--   • Treat fake Roblox login / "claim reward" pages as phishing.
-- [[ End Rscripts Risk Notice ]]
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")

-- Main GUI Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PistolArenaModMenu"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

-- Container Frame (Logo aur Menu dono ko ek sath chipka kar rakhega, aur jab menu open hoga tab yeh pura container drag ho sakega)
local Container = Instance.new("Frame", ScreenGui)
Container.Size = UDim2.new(0, 280, 0, 195)
Container.Position = UDim2.new(0.03, 0, 0.15, 0)
Container.BackgroundTransparency = 1
Container.Active = true
Container.Draggable = true -- Logo aur Menu dono sath mein chipke hue drag honge!

-- 1. Gol Circular Logo ("meki njir" + Rainbow Lighting) - Yeh container ke andar fix hai
local ToggleButton = Instance.new("ImageButton", Container)
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Position = UDim2.new(0, 0, 0, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
ToggleButton.AutoButtonColor = false
ToggleButton.Active = true

local UICornerLogo = Instance.new("UICorner", ToggleButton)
UICornerLogo.CornerRadius = UDim.new(1, 0)

local LogoStroke = Instance.new("UIStroke", ToggleButton)
LogoStroke.Thickness = 3

local LogoText = Instance.new("TextLabel", ToggleButton)
LogoText.Size = UDim2.new(1, 0, 1, 0)
LogoText.Text = "meki\nhub"
LogoText.TextSize = 10
LogoText.Font = Enum.Font.SourceSansBold
LogoText.TextColor3 = Color3.new(1, 1, 1)
LogoText.BackgroundTransparency = 1
LogoText.TextWrapped = true

-- Rainbow Animation for Logo
task.spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            if ToggleButton and ToggleButton.Parent then
                local hueColor = Color3.fromHSV(i, 1, 1)
                LogoStroke.Color = hueColor
                LogoText.TextColor3 = hueColor
            end
            task.wait(0.05)
        end
    end
end)

-- Main Menu Frame (Logo ke bilkul sath chipka hua inside Container)
local Frame = Instance.new("Frame", Container)
Frame.Size = UDim2.new(0, 220, 0, 195)
Frame.Position = UDim2.new(0, 62, 0, 0) -- Hamesha logo ke sath chipka rahega
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.Visible = true
Frame.Active = false

local FrameCorner = Instance.new("UICorner", Frame)
FrameCorner.CornerRadius = UDim.new(0, 8)

-- Rainbow Polished Lighting on Mod Menu Border
local FrameStroke = Instance.new("UIStroke", Frame)
FrameStroke.Thickness = 2.5

task.spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            if Frame and Frame.Parent then
                FrameStroke.Color = Color3.fromHSV(i, 1, 1)
            end
            task.wait(0.05)
        end
    end
end)

-- Menu Title: Made by meki njir (Rainbow Lighting)
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(0, 200, 0, 28)
Title.Position = UDim2.new(0, 10, 0, 6)
Title.Text = "Made by meki hub"
Title.TextSize = 13
Title.Font = Enum.Font.SourceSansBold
Title.BackgroundTransparency = 1
Title.Parent = Frame

task.spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            if Title and Title.Parent then
                Title.TextColor3 = Color3.fromHSV(i, 1, 1)
            end
            task.wait(0.05)
        end
    end
end)

-- Toggle Menu Visibility (Logo click karne se menu hide/unhide hoga, par hamesha logo se chipka rahega)
local menuVisible = true
ToggleButton.MouseButton1Click:Connect(function()
    menuVisible = not menuVisible
    Frame.Visible = menuVisible
end)

-- Compact Button Creation Function
local function createButton(text, callback)
    local btn = Instance.new("TextButton", Frame)
    btn.Size = UDim2.new(0, 200, 0, 32)
    btn.Position = UDim2.new(0, 10, 0, (#Frame:GetChildren() - 2) * 36 + 10)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 12
    btn.Font = Enum.Font.SourceSansBold
    btn.Parent = Frame
    
    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 5)
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        callback(state, btn)
    end)
    return btn
end

-- Raycast Function for Wall Check
local function isVisible(targetPart)
    local myChar = Player.Character
    if not myChar or not myChar:FindFirstChild("Head") then return false end
    local origin = myChar.Head.Position
    local direction = targetPart.Position - origin
    
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {myChar}
    raycastParams.IgnoreWater = true
    
    local result = workspace:Raycast(origin, direction, raycastParams)
    if result and result.Instance:IsDescendantOf(targetPart.Parent) then
        return true
    end
    return false
end

-- 1. ESP Lines/Highlight
local espEnabled = false
createButton("ESP Lines: OFF", function(state, btn)
    espEnabled = state
    btn.Text = "ESP Lines: "..(espEnabled and "ON" or "OFF")
    btn.BackgroundColor3 = espEnabled and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(30, 30, 30)
end)

RunService.RenderStepped:Connect(function()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = p.Character.HumanoidRootPart
            local highlight = hrp:FindFirstChild("RainbowESP_Highlight")
            if espEnabled then
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Name = "RainbowESP_Highlight"
                    highlight.Adornee = p.Character
                    highlight.Parent = hrp
                end
                local hue = tick() % 5 / 5
                highlight.FillColor = Color3.fromHSV(hue, 1, 1)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            else
                if highlight then highlight:Destroy() end
            end
        end
    end
end)

-- 2. Aimbot Logic
local aimbotEnabled = false
createButton("Aimbot: OFF", function(state, btn)
    aimbotEnabled = state
    btn.Text = "Aimbot: "..(aimbotEnabled and "ON" or "OFF")
    btn.BackgroundColor3 = aimbotEnabled and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(30, 30, 30)
end)

RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        local nearestTarget, shortestDist = nil, math.huge
        local myChar = Player.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hum = p.Character:FindFirstChild("Humanoid")
                if hum and hum.Health > 0 then
                    local targetRoot = p.Character.HumanoidRootPart
                    if myRoot and isVisible(targetRoot) then
                        local dist = (targetRoot.Position - myRoot.Position).Magnitude
                        if dist < shortestDist then
                            shortestDist = dist
                            nearestTarget = targetRoot
                        end
                    end
                end
            end
        end
        
        if nearestTarget then
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, nearestTarget.Position + Vector3.new(0, 0.5, 0))
        end
    end
end)

-- 3. Teleport Kill Logic
local tpKillEnabled = false
createButton("Teleport Kill: OFF", function(state, btn)
    tpKillEnabled = state
    btn.Text = "Teleport Kill: "..(tpKillEnabled and "ON" or "OFF")
    btn.BackgroundColor3 = tpKillEnabled and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(30, 30, 30)
end)

RunService.RenderStepped:Connect(function()
    if tpKillEnabled then
        local nearestTarget, shortestDist = nil, math.huge
        local myChar = Player.Character
        local myRoot = myChar and myChar:FindFirstChild("HumanoidRootPart")
        
        if myRoot then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= Player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local hum = p.Character:FindFirstChild("Humanoid")
                    if hum and hum.Health > 0 then
                        local targetRoot = p.Character.HumanoidRootPart
                        local dist = (targetRoot.Position - myRoot.Position).Magnitude
                        if dist < shortestDist then
                            shortestDist = dist
                            nearestTarget = targetRoot
                        end
                    end
                end
            end
            
            if nearestTarget and shortestDist < 100 then
                myRoot.CFrame = nearestTarget.CFrame * CFrame.new(0, 0, 3)
            end
        end
    end
end)
