-- Roblox Advanced Exploit GUI v2.0
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")

-- ========== CONFIG ==========
local CONFIG = {
    flying = false,
    noclip = false,
    speed = false,
    esp = false,
    aimbot = false,
    hitbox = false,
    
    flySpeed = 50,
    speedMultiplier = 2,
}

-- ========== CREATE GUI ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ExploitGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0, 10, 0, 10)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Title Bar
local TitleBar = Instance.new("TextLabel")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
TitleBar.BorderSizePixel = 0
TitleBar.Text = "Exploit Menu"
TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleBar.Font = Enum.Font.GothamBold
TitleBar.TextSize = 14
TitleBar.Parent = MainFrame

-- Scrollable Content
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "Content"
ScrollingFrame.Size = UDim2.new(1, 0, 1, -30)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 30)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 8
ScrollingFrame.Parent = MainFrame

-- ========== BUTTON FUNCTION ==========
local function createButton(parent, name, callback)
    local Button = Instance.new("TextButton")
    Button.Name = name
    Button.Size = UDim2.new(1, -10, 0, 35)
    Button.Position = UDim2.new(0, 5, 0, (#parent:GetChildren() * 40))
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    Button.BorderSizePixel = 1
    Button.BorderColor3 = Color3.fromRGB(0, 150, 200)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 12
    Button.Parent = parent
    
    Button.MouseButton1Click:Connect(callback)
    
    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    end)
    
    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
    end)
end

-- ========== FLY SCRIPT ==========
local function toggleFly()
    CONFIG.flying = not CONFIG.flying
    
    if CONFIG.flying then
        local bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Parent = RootPart
        bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        
        RunService.RenderStepped:Connect(function()
            if not CONFIG.flying then return end
            
            local moveDirection = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + (workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - (workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - workspace.CurrentCamera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + workspace.CurrentCamera.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                moveDirection = moveDirection - Vector3.new(0, 1, 0)
            end
            
            if moveDirection.Magnitude > 0 then
                bodyVelocity.Velocity = moveDirection.Unit * CONFIG.flySpeed
            else
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            end
        end)
    else
        if RootPart:FindFirstChild("BodyVelocity") then
            RootPart.BodyVelocity:Destroy()
        end
    end
end

-- ========== NOCLIP ==========
local function toggleNoclip()
    CONFIG.noclip = not CONFIG.noclip
    
    if CONFIG.noclip then
        RunService.Stepped:Connect(function()
            if not CONFIG.noclip then return end
            for _, part in pairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end)
    end
end

-- ========== SPEED ==========
local function toggleSpeed()
    CONFIG.speed = not CONFIG.speed
    
    if CONFIG.speed then
        RunService.Heartbeat:Connect(function()
            if not CONFIG.speed or not Character then return end
            if UserInputService:IsKeyDown(Enum.KeyCode.W) or 
               UserInputService:IsKeyDown(Enum.KeyCode.A) or
               UserInputService:IsKeyDown(Enum.KeyCode.S) or
               UserInputService:IsKeyDown(Enum.KeyCode.D) then
                RootPart.Velocity = RootPart.Velocity + (RootPart.CFrame.LookVector * CONFIG.speedMultiplier)
            end
        end)
    end
end

-- ========== ESP ==========
local function toggleESP()
    CONFIG.esp = not CONFIG.esp
    
    if CONFIG.esp then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    local billboardGui = Instance.new("BillboardGui")
                    billboardGui.Size = UDim2.new(4, 0, 5, 0)
                    billboardGui.MaxDistance = 500
                    billboardGui.Parent = rootPart
                    
                    local textLabel = Instance.new("TextLabel")
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                    textLabel.BackgroundTransparency = 0.3
                    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    textLabel.TextSize = 14
                    textLabel.Font = Enum.Font.GothamBold
                    textLabel.Text = player.Name
                    textLabel.Parent = billboardGui
                end
            end
        end
    end
end

-- ========== AIMBOT ==========
local function toggleAimbot()
    CONFIG.aimbot = not CONFIG.aimbot
    
    if CONFIG.aimbot then
        RunService.RenderStepped:Connect(function()
            if not CONFIG.aimbot then return end
            
            local closestPlayer = nil
            local closestDistance = 100
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local targetRootPart = player.Character:FindFirstChild("HumanoidRootPart")
                    if targetRootPart then
                        local distance = (RootPart.Position - targetRootPart.Position).Magnitude
                        if distance < closestDistance then
                            closestPlayer = player
                            closestDistance = distance
                        end
                    end
                end
            end
            
            if closestPlayer and closestPlayer.Character then
                local targetRootPart = closestPlayer.Character:FindFirstChild("HumanoidRootPart")
                if targetRootPart then
                    local camera = workspace.CurrentCamera
                    camera.CFrame = CFrame.new(camera.CFrame.Position, targetRootPart.Position)
                end
            end
        end)
    end
end

-- ========== HITBOX ==========
local function toggleHitbox()
    CONFIG.hitbox = not CONFIG.hitbox
    
    if CONFIG.hitbox then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    rootPart.Size = Vector3.new(5, 5, 5)
                    rootPart.CanCollide = false
                end
            end
        end
    end
end

-- ========== CREATE BUTTONS ==========
createButton(ScrollingFrame, "Fly [WASD + Space/Ctrl]", toggleFly)
createButton(ScrollingFrame, "Noclip", toggleNoclip)
createButton(ScrollingFrame, "Speed Boost", toggleSpeed)
createButton(ScrollingFrame, "ESP / Wallhack", toggleESP)
createButton(ScrollingFrame, "Aimbot", toggleAimbot)
createButton(ScrollingFrame, "Hitbox Expander", toggleHitbox)

-- Update ScrollingFrame size
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, (#ScrollingFrame:GetChildren() * 40))

print("✅ Exploit GUI Loaded")
print("Controls: WASD + Space/Ctrl to fly")
