local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer

local KEY = "mekiganteng"
local GET_KEY = "https://chat.whatsapp.com/E7ZorHopiwPLn5HfUFfLNi?s=cl&p=a&mlu=4"

local FlySpeed = 60
local WalkSpeed = 16
local Flying = false
local Noclip = false
local InfiniteJump = false

local FlyVelocity
local FlyGyro
local FlyConnection
local NoclipConnection
local SpeedConnection
local JumpConnection

-- =====================================================
-- MAIN GUI
-- =====================================================

local function CreateMainGUI()

    local Window = Rayfield:CreateWindow({
        Name = "Meki hub",
        LoadingTitle = "Meki hub",
        LoadingSubtitle = "Mobile",
        ConfigurationSaving = {
            Enabled = false
        }
    })

    local Tab = Window:CreateTab("Main", 4483362458)

    local function GetCharacter()
        local Character = Player.Character

        if not Character then
            return
        end

        local Humanoid =
            Character:FindFirstChildOfClass("Humanoid")

        local Root =
            Character:FindFirstChild("HumanoidRootPart")

        return Character, Humanoid, Root
    end

    -- =================================================
    -- STOP FLY INTERNAL
    -- =================================================

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

        local _, Humanoid = GetCharacter()

        if Humanoid then
            Humanoid.AutoRotate = true
            Humanoid.PlatformStand = false
        end
    end

    -- =================================================
    -- START FLY
    -- =================================================

    local function StartFly()

        StopFly()

        local _, Humanoid, Root = GetCharacter()

        if not Humanoid or not Root then
            return
        end

        Flying = true

        Humanoid.AutoRotate = false
        Humanoid.PlatformStand = false

        FlyVelocity = Instance.new("BodyVelocity")
        FlyVelocity.Name = "MekiFlyVelocity"

        FlyVelocity.MaxForce =
            Vector3.new(
                math.huge,
                math.huge,
                math.huge
            )

        FlyVelocity.P = 5000
        FlyVelocity.Velocity = Vector3.zero
        FlyVelocity.Parent = Root

        FlyGyro = Instance.new("BodyGyro")
        FlyGyro.Name = "MekiFlyGyro"

        FlyGyro.MaxTorque =
            Vector3.new(
                math.huge,
                math.huge,
                math.huge
            )

        FlyGyro.P = 9000
        FlyGyro.D = 500
        FlyGyro.Parent = Root

        FlyConnection =
            RunService.RenderStepped:Connect(function()

                if not Flying then
                    return
                end

                local Character,
                      CurrentHumanoid,
                      CurrentRoot =
                    GetCharacter()

                if not Character
                    or not CurrentHumanoid
                    or not CurrentRoot then

                    StopFly()
                    return
                end

                local Camera =
                    workspace.CurrentCamera

                local MoveDirection =
                    CurrentHumanoid.MoveDirection

                if MoveDirection.Magnitude > 0.01 then

                    local Look =
                        Camera.CFrame.LookVector

                    local Right =
                        Camera.CFrame.RightVector

                    -- Analog Roblox mengikuti kamera.
                    -- Kamera ke atas + analog maju = naik.
                    -- Kamera ke bawah + analog maju = turun.

                    local Forward =
                        MoveDirection:Dot(Look)

                    local Side =
                        MoveDirection:Dot(
                            Vector3.new(
                                Right.X,
                                0,
                                Right.Z
                            )
                        )

                    local Direction =
                        Look * Forward
                        + Right * Side

                    if Direction.Magnitude > 0.01 then

                        FlyVelocity.Velocity =
                            Direction.Unit * FlySpeed

                    else
                        FlyVelocity.Velocity =
                            Vector3.zero
                    end

                else
                    FlyVelocity.Velocity =
                        Vector3.zero
                end

                FlyGyro.CFrame =
                    CFrame.lookAt(
                        CurrentRoot.Position,
                        CurrentRoot.Position
                            + Camera.CFrame.LookVector
                    )
            end)
    end

    -- =================================================
    -- FLY
    -- =================================================

    Tab:CreateToggle({
        Name = "Fly",
        CurrentValue = false,
        Flag = "Fly",

        Callback = function(Value)

            if Value then
                StartFly()
            else
                StopFly()
            end
        end
    })

    -- =================================================
    -- FLY SPEED
    -- =================================================

    Tab:CreateSlider({
        Name = "Fly Speed",
        Range = {10, 500},
        Increment = 5,
        Suffix = " Speed",
        CurrentValue = 60,
        Flag = "FlySpeed",

        Callback = function(Value)
            FlySpeed = Value
        end
    })

    -- =================================================
    -- WALK SPEED
    -- =================================================

    Tab:CreateSlider({
        Name = "Walk Speed",
        Range = {16, 500},
        Increment = 1,
        Suffix = " Speed",
        CurrentValue = 16,
        Flag = "WalkSpeed",

        Callback = function(Value)

            WalkSpeed = Value

            local _, Humanoid =
                GetCharacter()

            if Humanoid then
                Humanoid.WalkSpeed = Value
            end
        end
    })

    -- =================================================
    -- NOCLIP
    -- =================================================

    local function SetNoclip(State)

        Noclip = State

        if NoclipConnection then
            NoclipConnection:Disconnect()
            NoclipConnection = nil
        end

        if State then

            NoclipConnection =
                RunService.Stepped:Connect(function()

                    local Character =
                        Player.Character

                    if not Character then
                        return
                    end

                    for _, Part in
                        ipairs(Character:GetDescendants()) do

                        if Part:IsA("BasePart") then
                            Part.CanCollide = false
                        end
                    end
                end)

        else

            local Character =
                Player.Character

            if Character then

                for _, Part in
                    ipairs(Character:GetDescendants()) do

                    if Part:IsA("BasePart") then
                        Part.CanCollide = true
                    end
                end
            end
        end
    end

    Tab:CreateToggle({
        Name = "Noclip",
        CurrentValue = false,
        Flag = "Noclip",

        Callback = function(Value)
            SetNoclip(Value)
        end
    })

    -- =================================================
    -- INFINITE JUMP
    -- =================================================

    Tab:CreateToggle({
        Name = "Infinite Jump",
        CurrentValue = false,
        Flag = "InfiniteJump",

        Callback = function(Value)

            InfiniteJump = Value

            if JumpConnection then
                JumpConnection:Disconnect()
                JumpConnection = nil
            end

            if Value then

                JumpConnection =
                    UserInputService.JumpRequest:Connect(function()

                        if not InfiniteJump then
                            return
                        end

                        local Character =
                            Player.Character

                        local Humanoid =
                            Character
                            and Character:FindFirstChildOfClass(
                                "Humanoid"
                            )

                        if Humanoid then
                            Humanoid:ChangeState(
                                Enum.HumanoidStateType.Jumping
                            )
                        end
                    end)
            end
        end
    })

    -- =================================================
    -- KEEP WALK SPEED
    -- =================================================

    SpeedConnection =
        RunService.Heartbeat:Connect(function()

            if not Flying then

                local _, Humanoid =
                    GetCharacter()

                if Humanoid then
                    Humanoid.WalkSpeed =
                        WalkSpeed
                end
            end
        end)

    -- =================================================
    -- RESPAWN
    -- =================================================

    Player.CharacterAdded:Connect(function()

        StopFly()

        task.wait(1)

        local _, Humanoid =
            GetCharacter()

        if Humanoid then
            Humanoid.WalkSpeed =
                WalkSpeed
        end

        if Noclip then
            SetNoclip(true)
        end
    end)

    Rayfield:Notify({
        Title = "Meki Fly",
        Content = "Fly + Speed + Noclip + Infinite Jump siap!",
        Duration = 3
    })
end

-- =====================================================
-- KEY SYSTEM
-- =====================================================

local KeyWindow = Rayfield:CreateWindow({
    Name = "Meki Fly | Key System",
    LoadingTitle = "Meki Fly",
    LoadingSubtitle = "Masukkan Key",
    ConfigurationSaving = {
        Enabled = false
    }
})

local KeyTab =
    KeyWindow:CreateTab(
        "Key System",
        4483362458
    )

KeyTab:CreateInput({
    Name = "Key",
    PlaceholderText = "Masukkan key...",
    RemoveTextAfterFocusLost = false,

    Callback = function(Text)

        if Text == KEY then

            Rayfield:Notify({
                Title = "Key Benar!",
                Content = "Membuka Meki Fly...",
                Duration = 2
            })

            task.wait(0.5)

            pcall(function()
                KeyWindow:Destroy()
            end)

            CreateMainGUI()

        else

            Rayfield:Notify({
                Title = "Key Salah",
                Content = "Key yang dimasukkan salah.",
                Duration = 2
            })
        end
    end
})

KeyTab:CreateButton({
    Name = "Get Key",

    Callback = function()

        if setclipboard then
            setclipboard(GET_KEY)

            Rayfield:Notify({
                Title = "Get Key",
                Content = "Link WhatsApp disalin!",
                Duration = 2
            })
        else
            Rayfield:Notify({
                Title = "Get Key",
                Content = GET_KEY,
                Duration = 4
            })
        end
    end
})

Rayfield:Notify({
    Title = "Meki Fly",
    Content = "Key: mekiganteng",
    Duration = 3
})
