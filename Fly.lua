-- =====================================================
-- IN MEKI SCRIPTER v1.0  |  Delta Optimized
-- By meki
-- Fitur: Fly, Noclip, Speed, Inf Jump, Teleport, ESP placeholder
-- Keybind: F, G, H, J, K
-- =====================================================

return (function()
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local StarterGui = game:GetService("StarterGui")
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

    -- VARIABEL UTAMA
    local FlyEnabled = false
    local NoclipEnabled = false
    local SpeedEnabled = false
    local InfJumpEnabled = false
    local flySpeed = 55
    local speedMultiplier = 4.0
    local bodyVelocity = nil
    local infJumpConnection = nil

    -- FUNGSI GET CHAR YANG AMAN
    local function getChar()
        local char = LocalPlayer.Character
        if not char or not char.Parent then return nil end
        return char
    end

    -- ============================================
    -- 1. MEMBUAT GUI
    -- ============================================
    local gui = Instance.new("ScreenGui")
    gui.Name = "InMekiScripter"
    gui.ResetOnSpawn = false
    gui.Parent = PlayerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 360, 0, 420)
    mainFrame.Position = UDim2.new(0.5, -180, 0.5, -210)
    mainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(255, 200, 80)
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = gui

    local titleBar = Instance.new("TextLabel")
    titleBar.Size = UDim2.new(1, 0, 0, 30)
    titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
    titleBar.Text = "In Meki Scripter v1.0"
    titleBar.TextColor3 = Color3.fromRGB(255, 200, 80)
    titleBar.TextScaled = true
    titleBar.Font = Enum.Font.GothamBold
    titleBar.Parent = mainFrame

    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -30, 0, 0)
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Color3.fromRGB(255,255,255)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = mainFrame
    closeBtn.MouseButton1Click:Connect(function()
        gui:Destroy()
    end)

    local indexLabel = Instance.new("TextLabel")
    indexLabel.Size = UDim2.new(0.4, 0, 0, 20)
    indexLabel.Position = UDim2.new(0, 10, 0, 35)
    indexLabel.BackgroundTransparency = 1
    indexLabel.Text = "[Index] v1.0"
    indexLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
    indexLabel.TextScaled = true
    indexLabel.Font = Enum.Font.Gotham
    indexLabel.TextXAlignment = Enum.TextXAlignment.Left
    indexLabel.Parent = mainFrame

    local cashLabel = Instance.new("TextLabel")
    cashLabel.Size = UDim2.new(0.5, 0, 0, 20)
    cashLabel.Position = UDim2.new(0.5, 10, 0, 35)
    cashLabel.BackgroundTransparency = 1
    cashLabel.Text = "STATUS: READY"
    cashLabel.TextColor3 = Color3.fromRGB(0, 255, 120)
    cashLabel.TextScaled = true
    cashLabel.Font = Enum.Font.GothamBold
    cashLabel.TextXAlignment = Enum.TextXAlignment.Right
    cashLabel.Parent = mainFrame

    local btnContainer = Instance.new("ScrollingFrame")
    btnContainer.Size = UDim2.new(1, -20, 1, -80)
    btnContainer.Position = UDim2.new(0, 10, 0, 60)
    btnContainer.BackgroundTransparency = 1
    btnContainer.CanvasSize = UDim2.new(0, 0, 0, 350)
    btnContainer.ScrollBarThickness = 8
    btnContainer.Parent = mainFrame

    -- ============================================
    -- 2. FUNGSI TOGGLE FITUR
    -- ============================================
    local function toggleFly(state)
        FlyEnabled = state
        local char = getChar()
        if not char then return end
        local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
        if not torso then return end
        if FlyEnabled then
            if not bodyVelocity then
                bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                bodyVelocity.P = 9e5
                bodyVelocity.Name = "FlyVelocity"
            end
            bodyVelocity.Parent = torso
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.PlatformStand = true end
        else
            if bodyVelocity then bodyVelocity.Parent = nil end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if hum then hum.PlatformStand = false end
        end
    end

    local function toggleNoclip(state)
        NoclipEnabled = state
        local char = getChar()
        if not char then return end
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not state
            end
        end
    end

    local function toggleSpeed(state)
        SpeedEnabled = state
        local char = getChar()
        if not char then return end
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            if state then
                hum.WalkSpeed = 16 * speedMultiplier
                hum.JumpPower = 70 * speedMultiplier
            else
                hum.WalkSpeed = 16
                hum.JumpPower = 50
            end
        end
    end

    local function toggleInfJump(state)
        InfJumpEnabled = state
        if infJumpConnection then infJumpConnection:Disconnect(); infJumpConnection = nil end
        if state then
            infJumpConnection = UserInputService.JumpRequest:Connect(function()
                local char = getChar()
                if not char then return end
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum and hum:GetState() ~= Enum.HumanoidStateType.Jumping then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end
    end

    local function resetAll()
        if FlyEnabled then toggleFly(false) end
        if NoclipEnabled then toggleNoclip(false) end
        if SpeedEnabled then toggleSpeed(false) end
        if InfJumpEnabled then toggleInfJump(false) end
        cashLabel.Text = "STATUS: RESET"
        for _, btn in ipairs(btnContainer:GetChildren()) do
            if btn:IsA("TextButton") and btn.Name ~= "ESP" then
                btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                btn.TextColor3 = Color3.fromRGB(255,255,255)
            end
        end
    end

    -- ============================================
    -- 3. PEMBUAT TOMBOL
    -- ============================================
    local function createToggleButton(text, yPos, callback, keyHint)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.95, 0, 0, 35)
        btn.Position = UDim2.new(0.025, 0, 0, yPos)
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        btn.Text = text .. " [" .. keyHint .. "]"
        btn.TextColor3 = Color3.fromRGB(230, 230, 230)
        btn.TextScaled = true
        btn.Font = Enum.Font.GothamSemibold
        btn.Parent = btnContainer

        local isActive = false
        btn.MouseButton1Click:Connect(function()
            isActive = not isActive
            if isActive then
                btn.BackgroundColor3 = Color3.fromRGB(0, 160, 0)
                btn.TextColor3 = Color3.fromRGB(255,255,255)
            else
                btn.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
                btn.TextColor3 = Color3.fromRGB(230, 230, 230)
            end
            callback(isActive)
            cashLabel.Text = string.upper(text .. " " .. (isActive and "ON" or "OFF"))
        end)
        return btn
    end

    local btnFly = createToggleButton("Fly", 0, toggleFly, "F")
    local btnNoclip = createToggleButton("Noclip", 45, toggleNoclip, "G")
    local btnSpeed = createToggleButton("Speed Boost", 90, toggleSpeed, "H")
    local btnInfJump = createToggleButton("Inf Jump", 135, toggleInfJump, "J")

    local resetBtn = Instance.new("TextButton")
    resetBtn.Size = UDim2.new(0.95, 0, 0, 35)
    resetBtn.Position = UDim2.new(0.025, 0, 0, 180)
    resetBtn.BackgroundColor3 = Color3.fromRGB(150, 50, 50)
    resetBtn.Text = "Reset All [K]"
    resetBtn.TextColor3 = Color3.fromRGB(255,255,255)
    resetBtn.TextScaled = true
    resetBtn.Font = Enum.Font.GothamBold
    resetBtn.Parent = btnContainer
    resetBtn.MouseButton1Click:Connect(function()
        resetAll()
    end)

    local teleBtn = Instance.new("TextButton")
    teleBtn.Size = UDim2.new(0.95, 0, 0, 35)
    teleBtn.Position = UDim2.new(0.025, 0, 0, 225)
    teleBtn.BackgroundColor3 = Color3.fromRGB(30, 80, 140)
    teleBtn.Text = "Teleport to Mouse"
    teleBtn.TextColor3 = Color3.fromRGB(255,255,255)
    teleBtn.TextScaled = true
    teleBtn.Font = Enum.Font.GothamSemibold
    teleBtn.Parent = btnContainer
    teleBtn.MouseButton1Click:Connect(function()
        local char = getChar()
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local mouse = LocalPlayer:GetMouse()
        if not mouse then return end
        root.CFrame = CFrame.new(mouse.Hit.p + Vector3.new(0, 2.5, 0))
        cashLabel.Text = "STATUS: TELEPORTED"
    end)

    local espBtn = Instance.new("TextButton")
    espBtn.Size = UDim2.new(0.95, 0, 0, 35)
    espBtn.Position = UDim2.new(0.025, 0, 0, 270)
    espBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 120)
    espBtn.Text = "ESP [Experimental]"
    espBtn.TextColor3 = Color3.fromRGB(255,255,255)
    espBtn.TextScaled = true
    espBtn.Font = Enum.Font.GothamSemibold
    espBtn.Parent = btnContainer
    espBtn.MouseButton1Click:Connect(function()
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = "ZuzaRTH - ESP",
                Text = "ESP memerlukan library eksternal (saya siapkan jika Dizz minta /code lagi)",
                Duration = 4
            })
        end)
        cashLabel.Text = "STATUS: ESP CLICKED"
    end)

    -- ============================================
    -- 4. KEYBIND
    -- ============================================
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        local key = input.KeyCode
        if key == Enum.KeyCode.F then btnFly.MouseButton1Click:Fire()
        elseif key == Enum.KeyCode.G then btnNoclip.MouseButton1Click:Fire()
        elseif key == Enum.KeyCode.H then btnSpeed.MouseButton1Click:Fire()
        elseif key == Enum.KeyCode.J then btnInfJump.MouseButton1Click:Fire()
        elseif key == Enum.KeyCode.K then resetBtn.MouseButton1Click:Fire()
        end
    end)

    -- ============================================
    -- 5. LOOP FLY
    -- ============================================
    RunService:BindToRenderStep("FlyControl", Enum.RenderPriority.Input.Value, function()
        if not FlyEnabled then return end
        local char = getChar()
        if not char then return end
        local torso = char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
        if not torso then return end

        local move = Vector3.new()
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + Vector3.new(0,0,-1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move + Vector3.new(0,0,1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move + Vector3.new(-1,0,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Vector3.new(1,0,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then move = move + Vector3.new(0,-1,0) end

        if move.Magnitude > 0 then
            move = move.Unit
            local cam = workspace.CurrentCamera
            local forward = cam.CFrame.LookVector * Vector3.new(1,0,1)
            local right = cam.CFrame.RightVector * Vector3.new(1,0,1)
            local vel = (forward * move.Z + right * move.X + Vector3.new(0, move.Y, 0)) * flySpeed
            if bodyVelocity then bodyVelocity.Velocity = vel end
        else
            if bodyVelocity then bodyVelocity.Velocity = Vector3.new() end
        end
    end)

    -- ============================================
    -- 6. REATTACH SAAT RESPAWN
    -- ============================================
    LocalPlayer.CharacterAdded:Connect(function(char)
        wait(0.5)
        if FlyEnabled then toggleFly(true) end
        if NoclipEnabled then toggleNoclip(true) end
        if SpeedEnabled then toggleSpeed(true) end
    end)

    print("=====================================")
    print("  IN MEKI SCRIPTER v1.0 LOADED!")
    print("  [F] Fly    [G] Noclip   [H] Speed")
    print("  [J] Inf Jump    [K] Reset All")
    print("  GUI by meki")
    print("=====================================")

    return true
end)()
