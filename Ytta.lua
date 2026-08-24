local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Terrain = workspace:FindFirstChildOfClass('Terrain')
local Player = Players.LocalPlayer

local sg = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
sg.Name = "anti lag by meki"
sg.ResetOnSpawn = false

local main = Instance.new("Frame", sg)
main.Size = UDim2.new(0, 220, 0, 310)
main.Position = UDim2.new(0.1, 0, 0.4, 0)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main)

local stroke = Instance.new("UIStroke", main)
stroke.Color = Color3.fromRGB(0, 255, 150)
stroke.Thickness = 1.5

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "PERFORMANCE ULTRA"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
title.Font = Enum.Font.GothamBold
Instance.new("UICorner", title)

-- FPS COUNTER (lebih akurat)
local fpsLabel = Instance.new("TextLabel", main)
fpsLabel.Size = UDim2.new(0, 60, 0, 20)
fpsLabel.Position = UDim2.new(1, -65, 0, 10)
fpsLabel.BackgroundTransparency = 1
fpsLabel.Text = "FPS: ..."
fpsLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
fpsLabel.Font = Enum.Font.Code
fpsLabel.TextSize = 10
fpsLabel.TextXAlignment = Enum.TextXAlignment.Right

local lastUpdate = os.clock()
local frames = 0

RunService.RenderStepped:Connect(function()
    frames += 1
    if os.clock() - lastUpdate >= 1 then
        fpsLabel.Text = "FPS: " .. frames
        frames = 0
        lastUpdate = os.clock()
    end
end)

-- SCROLL
local container = Instance.new("ScrollingFrame", main)
container.Size = UDim2.new(1, -10, 1, -50)
container.Position = UDim2.new(0, 5, 0, 45)
container.BackgroundTransparency = 1
container.CanvasSize = UDim2.new(0, 0, 2.2, 0)
container.ScrollBarThickness = 2

local layout = Instance.new("UIListLayout", container)
layout.Padding = UDim.new(0, 5)

-- BUTTON
local function createButton(text, callback)
    local b = Instance.new("TextButton", container)
    b.Size = UDim2.new(1, 0, 0, 35)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.TextColor3 = Color3.new(0.9, 0.9, 0.9)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.MouseButton1Click:Connect(callback)
    Instance.new("UICorner", b)
end

-- 🚀 NOKIA MODE (AMAN)
createButton("🚀 Nokia Mode", function()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.CastShadow = false
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        end
    end
end)

-- ☀️ FULLBRIGHT
createButton("☀️ Fullbright", function()
    Lighting.GlobalShadows = false
    Lighting.Brightness = 3
    Lighting.FogEnd = 9e9

    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") then
            v.Enabled = false
        end
    end
end)

-- 🍃 REMOVE EFFECT
createButton("🍃 Remove Effects", function()
    if Terrain then
        Terrain.Decoration = false
    end

    if workspace:FindFirstChild("Clouds") then
        workspace.Clouds.Enabled = false
    end

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end
end)

-- ⚙️ PHYSICS BOOST (FIXED)
createButton("⚙️ Physics Boost", function()
    pcall(function()
        settings().physics.PhysicsEnvironmentalThrottle = Enum.EnvironmentalPhysicsThrottle.Always
    end)

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v.Anchored then
            v.Velocity = Vector3.zero
            v.RotVelocity = Vector3.zero
        end
    end
end)

-- 📺 LOW GRAPHIC
createButton("📺 Low Graphics", function()
    pcall(function()
        settings().rendering.QualityLevel = Enum.QualityLevel.Level1
    end)

    if setrenderproperty then
        setrenderproperty("InterpolationThrottling", "Always")
    end
end)

-- 🔥 ULTRA BOOST
createButton("🔥 Ultra Boost", function()
    pcall(function()
        settings().rendering.QualityLevel = Enum.QualityLevel.Level1
    end)

    if Terrain then
        Terrain.WaterWaveSize = 0
        Terrain.WaterWaveSpeed = 0
        Terrain.WaterReflectance = 0
        Terrain.WaterTransparency = 0
    end

    if sethiddenproperty then
        sethiddenproperty(Lighting, "Technology", Enum.Technology.Compatibility)
    end
end)

-- 🔄 RESTORE
createButton("🔄 Restore Graphics", function()
    Lighting.GlobalShadows = true
    Lighting.Brightness = 1
    Lighting.FogEnd = 100000

    pcall(function()
        settings().rendering.QualityLevel = Enum.QualityLevel.Automatic
    end)

    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") then
            v.Enabled = true
        end
    end
end)

-- ❌ CLOSE
createButton("❌ Close Menu", function()
    sg:Destroy()
end)
