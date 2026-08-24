do
    -- =====================================================
    -- MEKI LUCKY HUB v2.1 (Mobile/PC)
    -- Cleaned & Formatted by MEKI
    -- All original logic preserved.
    -- =====================================================

    local args = { [1] = 1 }

    -- =====================================================
    -- 1. SERVICES & CORE VARIABLES
    -- =====================================================
    local Players = game:GetService("Players")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local HttpService = game:GetService("HttpService")
    local VirtualUser = game:GetService("VirtualUser")
    local player = Players.LocalPlayer
    local PlayerGui = player:WaitForChild("PlayerGui")

    -- =====================================================
    -- 2. ANTI-AFK
    -- =====================================================
    player.Idled:Connect(function()
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
        print("🛡️ Anti-AFK Worked: ป้องกันการโดนเตะเรียบร้อย!")
    end)

    -- =====================================================
    -- 3. SAFE PARENT & DESTROY OLD GUI
    -- =====================================================
    local SafeParent = PlayerGui
    for _, v in pairs(SafeParent:GetChildren()) do
        if (v.Name == "MEKI") then
            v:Destroy()
        end
    end

    -- =====================================================
    -- 4. THEME
    -- =====================================================
    local Theme = {
        Background = Color3.fromRGB(5, 5, 8),
        Surface = Color3.fromRGB(15, 15, 20),
        SurfaceLight = Color3.fromRGB(25, 25, 35),
        Accent = Color3.fromRGB(4, 203, 41),
        Text = Color3.fromRGB(255, 255, 255),
        TextDim = Color3.fromRGB(150, 150, 150),
        Success = Color3.fromRGB(4, 203, 41)
    }

    -- =====================================================
    -- 5. MAIN GUI CREATION
    -- =====================================================
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MEKI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = SafeParent

    -- Toggle Button (Logo)
    local toggleBtn = Instance.new("ImageButton", ScreenGui)
    toggleBtn.Size = UDim2.new(0, 50, 0, 50)
    toggleBtn.Position = UDim2.new(0, 15, 0, 150)
    toggleBtn.BackgroundColor3 = Theme.Surface
    toggleBtn.Image = "rbxthumb://type=Asset&id=117149073945265&w=150&h=150"
    toggleBtn.Draggable = true
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0.5, 0)
    local btnStroke = Instance.new("UIStroke", toggleBtn)
    btnStroke.Thickness = 2
    btnStroke.Color = Theme.Accent

    -- Main Frame
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 310, 0, 320)
    Main.Position = UDim2.new(0.5, -155, 0.5, -210)
    Main.BackgroundColor3 = Theme.Background
    Main.BorderSizePixel = 0
    Main.Active = true
    Main.Draggable = true
    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 12)

    -- Top Bar
    local TopBar = Instance.new("Frame", Main)
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.BackgroundColor3 = Theme.Surface
    TopBar.BorderSizePixel = 0

    -- Logo inside TopBar
    local Logo = Instance.new("ImageLabel", TopBar)
    Logo.Size = UDim2.new(0, 36, 0, 36)
    Logo.Position = UDim2.new(0, 10, 0.5, -18)
    Logo.BackgroundTransparency = 1
    Logo.Image = "rbxthumb://type=Asset&id=117149073945265&w=150&h=150"
    Instance.new("UICorner", Logo).CornerRadius = UDim.new(0.2, 0)

    -- Titles
    local Title1 = Instance.new("TextLabel", TopBar)
    Title1.Size = UDim2.new(0, 160, 0, 22)
    Title1.Position = UDim2.new(0, 52, 0, 5)
    Title1.BackgroundTransparency = 1
    Title1.Text = " Mobile 2.1 Bata"
    Title1.TextColor3 = Theme.Text
    Title1.TextSize = 10
    Title1.Font = Enum.Font.GothamBold
    Title1.TextXAlignment = Enum.TextXAlignment.Left

    local Title2 = Instance.new("TextLabel", TopBar)
    Title2.Size = UDim2.new(0, 160, 0, 22)
    Title2.Position = UDim2.new(0, 52, 0, 5)
    Title2.BackgroundTransparency = 1
    Title2.Text = "MEKI HUB"
    Title2.TextColor3 = Theme.Text
    Title2.TextSize = 17
    Title2.Font = Enum.Font.GothamBold
    Title2.TextXAlignment = Enum.TextXAlignment.Left

    local Subtitle = Instance.new("TextLabel", TopBar)
    Subtitle.Size = UDim2.new(0, 160, 0, 16)
    Subtitle.Position = UDim2.new(0, 52, 0, 26)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "Kick a Lucky Block"
    Subtitle.TextColor3 = Theme.Accent
    Subtitle.TextSize = 10
    Subtitle.Font = Enum.Font.GothamSemibold
    Subtitle.TextXAlignment = Enum.TextXAlignment.Left

    -- Tab Container
    local TabContainer = Instance.new("Frame", Main)
    TabContainer.Size = UDim2.new(1, -16, 0, 36)
    TabContainer.Position = UDim2.new(0, 8, 0, 56)
    TabContainer.BackgroundColor3 = Theme.Surface
    Instance.new("UICorner", TabContainer).CornerRadius = UDim.new(0, 8)

    local TabLayout = Instance.new("UIListLayout", TabContainer)
    TabLayout.FillDirection = Enum.FillDirection.Horizontal
    TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    TabLayout.Padding = UDim.new(0, 2)

    -- Content container
    local Content = Instance.new("Frame", Main)
    Content.Size = UDim2.new(1, -16, 1, -110)
    Content.Position = UDim2.new(0, 8, 0, 98)
    Content.BackgroundColor3 = Theme.Surface
    Content.ClipsDescendants = true
    Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 10)

    -- =====================================================
    -- 6. TAB MANAGEMENT SYSTEM
    -- =====================================================
    local Tabs = {}
    local function CreateTab(name)
        local Btn = Instance.new("TextButton", TabContainer)
        Btn.Size = UDim2.new(0, 0, 0, 28)
        Btn.AutomaticSize = Enum.AutomaticSize.X
        Btn.BackgroundColor3 = Theme.SurfaceLight
        Btn.Text = name
        Btn.TextColor3 = Theme.TextDim
        Btn.TextSize = 9
        Btn.Font = Enum.Font.GothamBold
        Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

        local pad = Instance.new("UIPadding", Btn)
        pad.PaddingLeft = UDim.new(0, 6)
        pad.PaddingRight = UDim.new(0, 6)

        local Page = Instance.new("ScrollingFrame", Content)
        Page.Name = name .. "Page"
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.BackgroundTransparency = 1
        Page.ScrollBarThickness = 2
        Page.ScrollBarImageColor3 = Theme.Accent
        Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
        Page.Visible = false

        local PL = Instance.new("UIListLayout", Page)
        PL.Padding = UDim.new(0, 10)
        PL.HorizontalAlignment = Enum.HorizontalAlignment.Center
        Instance.new("UIPadding", Page).PaddingTop = UDim.new(0, 12)
        Instance.new("UIPadding", Page).PaddingBottom = UDim.new(0, 12)

        table.insert(Tabs, { Btn = Btn, Page = Page })

        Btn.MouseButton1Click:Connect(function()
            for _, t in pairs(Tabs) do
                t.Page.Visible = false
                TweenService:Create(t.Btn, TweenInfo.new(0.2), {
                    BackgroundColor3 = Theme.SurfaceLight,
                    TextColor3 = Theme.TextDim
                }):Play()
            end
            Page.Visible = true
            TweenService:Create(Btn, TweenInfo.new(0.2), {
                BackgroundColor3 = Theme.Accent,
                TextColor3 = Color3.new(0, 0, 0)
            }):Play()
        end)
        return Page
    end

    -- Create all tabs
    local MainTab = CreateTab("Main")
    local CollectTab = CreateTab("Collect")
    local EventTab = CreateTab("Event")
    local UpGTab = CreateTab("UpG")
    local ConfigsTab = CreateTab("Configs")
    local KickZoneTab = CreateTab("KickZone")
    local SellTab = CreateTab("Sell")
    local DetailsTab = CreateTab("Info")

    -- =====================================================
    -- 7. UI CONTROLLERS & CONFIG SYSTEM
    -- =====================================================
    local CurrentConfig = {}
    local UIControllers = {}
    local SharedDropdownUpdaters = {}

    -- =====================================================
    -- 8. UI BUILDER FUNCTIONS
    -- =====================================================
    local function CreateButton(parent, text, callback)
        local btn = Instance.new("TextButton", parent)
        btn.Size = UDim2.new(0, 260, 0, 32)
        btn.BackgroundColor3 = Theme.SurfaceLight
        btn.Text = text
        btn.TextColor3 = Theme.Text
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 12
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
        btn.MouseButton1Click:Connect(callback)
    end

    local function CreateToggle(parent, text, configKey, callback)
        local frame = Instance.new("Frame", parent)
        frame.Size = UDim2.new(0, 260, 0, 32)
        frame.BackgroundColor3 = Theme.SurfaceLight
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1, -50, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Theme.Text
        label.Font = Enum.Font.GothamBold
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextSize = 11

        local tBtn = Instance.new("TextButton", frame)
        tBtn.Size = UDim2.new(0, 20, 0, 20)
        tBtn.Position = UDim2.new(1, -30, 0.5, -10)
        tBtn.BackgroundColor3 = Theme.Surface
        tBtn.Text = ""
        Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 4)
        Instance.new("UIStroke", tBtn).Color = Theme.Accent

        local s = false
        UIControllers[configKey] = function(val)
            s = val
            tBtn.BackgroundColor3 = (s and Theme.Accent) or Theme.Surface
            CurrentConfig[configKey] = s
            callback(s)
        end

        tBtn.MouseButton1Click:Connect(function()
            UIControllers[configKey](not s)
        end)
        CurrentConfig[configKey] = false
    end

    local function CreateDropdown(parent, title, options, configKey, callback)
        local container = Instance.new("Frame", parent)
        container.Size = UDim2.new(0, 260, 0, 32)
        container.BackgroundColor3 = Theme.SurfaceLight
        container.ClipsDescendants = true
        Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

        local selected = options[1]
        local mainBtn = Instance.new("TextButton", container)
        mainBtn.Size = UDim2.new(1, 0, 0, 32)
        mainBtn.BackgroundTransparency = 1
        mainBtn.Text = " " .. title .. ": " .. selected .. " ▼"
        mainBtn.TextColor3 = Theme.Accent
        mainBtn.Font = Enum.Font.GothamBold
        mainBtn.TextSize = 11
        mainBtn.TextXAlignment = Enum.TextXAlignment.Left

        local scroll = Instance.new("ScrollingFrame", container)
        scroll.Size = UDim2.new(1, 0, 1, -32)
        scroll.Position = UDim2.new(0, 0, 0, 32)
        scroll.BackgroundTransparency = 1
        scroll.ScrollBarThickness = 2
        scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

        local layout = Instance.new("UIListLayout", scroll)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        local isOpen = false
        local maxDropHeight = math.min(#options * 30, 150)

        UIControllers[configKey] = function(val)
            if (val and table.find(options, val)) then
                selected = val
                mainBtn.Text = " " .. title .. ": " .. selected .. " ▼"
                CurrentConfig[configKey] = selected
                callback(selected)
            end
        end

        mainBtn.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            if isOpen then
                TweenService:Create(container, TweenInfo.new(0.2), {
                    Size = UDim2.new(0, 260, 0, 32 + maxDropHeight)
                }):Play()
            else
                TweenService:Create(container, TweenInfo.new(0.2), {
                    Size = UDim2.new(0, 260, 0, 32)
                }):Play()
            end
        end)

        for i, option in ipairs(options) do
            local optBtn = Instance.new("TextButton", scroll)
            optBtn.Size = UDim2.new(1, -10, 0, 30)
            optBtn.BackgroundColor3 = Theme.Surface
            optBtn.Text = " " .. option
            optBtn.TextColor3 = Theme.TextDim
            optBtn.Font = Enum.Font.GothamBold
            optBtn.TextSize = 11
            optBtn.TextXAlignment = Enum.TextXAlignment.Left

            optBtn.MouseButton1Click:Connect(function()
                isOpen = false
                TweenService:Create(container, TweenInfo.new(0.2), {
                    Size = UDim2.new(0, 260, 0, 32)
                }):Play()
                UIControllers[configKey](option)
            end)
        end
        CurrentConfig[configKey] = options[1]
    end

    local function CreateMultiDropdown(parent, title, options, configKey, callback)
        local container = Instance.new("Frame", parent)
        container.Size = UDim2.new(0, 260, 0, 32)
        container.BackgroundColor3 = Theme.SurfaceLight
        container.ClipsDescendants = true
        Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

        local selected = {}
        for _, opt in ipairs(options) do
            selected[opt] = false
        end

        local mainBtn = Instance.new("TextButton", container)
        mainBtn.Size = UDim2.new(1, 0, 0, 32)
        mainBtn.BackgroundTransparency = 1
        mainBtn.Text = " " .. title .. ": Any ▼"
        mainBtn.TextColor3 = Theme.Accent
        mainBtn.Font = Enum.Font.GothamBold
        mainBtn.TextSize = 11
        mainBtn.TextXAlignment = Enum.TextXAlignment.Left

        local scroll = Instance.new("ScrollingFrame", container)
        scroll.Size = UDim2.new(1, 0, 1, -32)
        scroll.Position = UDim2.new(0, 0, 0, 32)
        scroll.BackgroundTransparency = 1
        scroll.ScrollBarThickness = 2
        scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

        local layout = Instance.new("UIListLayout", scroll)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        local isOpen = false
        local maxDropHeight = math.min(#options * 30, 150)
        local optBtns = {}

        local function updateText()
            local count = 0
            for k, v in pairs(selected) do
                if v then count = count + 1 end
            end
            if (count == 0) then
                mainBtn.Text = " " .. title .. ": Any " .. ((isOpen and "▲") or "▼")
            else
                mainBtn.Text = " " .. title .. ": " .. count .. " Selected " .. ((isOpen and "▲") or "▼")
            end
            CurrentConfig[configKey] = selected
            callback(selected)
        end

        UIControllers[configKey] = function(loadedTable)
            if (type(loadedTable) == "table") then
                for k, v in pairs(loadedTable) do
                    if (selected[k] ~= nil) then
                        selected[k] = v
                    end
                end
                for optName, btn in pairs(optBtns) do
                    btn.TextColor3 = (selected[optName] and Theme.Success) or Theme.TextDim
                end
                updateText()
            end
        end

        mainBtn.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            if isOpen then
                TweenService:Create(container, TweenInfo.new(0.2), {
                    Size = UDim2.new(0, 260, 0, 32 + maxDropHeight)
                }):Play()
            else
                TweenService:Create(container, TweenInfo.new(0.2), {
                    Size = UDim2.new(0, 260, 0, 32)
                }):Play()
            end
            updateText()
        end)

        for i, option in ipairs(options) do
            local optBtn = Instance.new("TextButton", scroll)
            optBtn.Size = UDim2.new(1, -10, 0, 30)
            optBtn.BackgroundColor3 = Theme.Surface
            optBtn.Text = " " .. option
            optBtn.TextColor3 = Theme.TextDim
            optBtn.Font = Enum.Font.GothamBold
            optBtn.TextSize = 11
            optBtn.TextXAlignment = Enum.TextXAlignment.Left
            optBtns[option] = optBtn

            optBtn.MouseButton1Click:Connect(function()
                selected[option] = not selected[option]
                optBtn.TextColor3 = (selected[option] and Theme.Success) or Theme.TextDim
                updateText()
            end)
        end
        CurrentConfig[configKey] = selected
    end

    local function CreateSharedMultiDropdown(parent, title, options, configKey, syncGroupId, sharedTable, callback)
        local container = Instance.new("Frame", parent)
        container.Size = UDim2.new(0, 260, 0, 32)
        container.BackgroundColor3 = Theme.SurfaceLight
        container.ClipsDescendants = true
        Instance.new("UICorner", container).CornerRadius = UDim.new(0, 6)

        local selected = {}
        for _, opt in ipairs(options) do
            selected[opt] = false
        end

        local mainBtn = Instance.new("TextButton", container)
        mainBtn.Size = UDim2.new(1, 0, 0, 32)
        mainBtn.BackgroundTransparency = 1
        mainBtn.Text = " " .. title .. ": Any ▼"
        mainBtn.TextColor3 = Theme.Accent
        mainBtn.Font = Enum.Font.GothamBold
        mainBtn.TextSize = 11
        mainBtn.TextXAlignment = Enum.TextXAlignment.Left

        local scroll = Instance.new("ScrollingFrame", container)
        scroll.Size = UDim2.new(1, 0, 1, -32)
        scroll.Position = UDim2.new(0, 0, 0, 32)
        scroll.BackgroundTransparency = 1
        scroll.ScrollBarThickness = 2
        scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

        local layout = Instance.new("UIListLayout", scroll)
        layout.SortOrder = Enum.SortOrder.LayoutOrder

        local isOpen = false
        local maxDropHeight = math.min(#options * 30, 150)
        local optBtns = {}

        if not SharedDropdownUpdaters[syncGroupId] then
            SharedDropdownUpdaters[syncGroupId] = {}
        end

        local function updateDisplayOnly()
            local count = 0
            for k, v in pairs(sharedTable) do
                if v then count = count + 1 end
            end
            if (count == 0) then
                mainBtn.Text = " " .. title .. ": Any " .. ((isOpen and "▲") or "▼")
            else
                mainBtn.Text = " " .. title .. ": " .. count .. " Selected " .. ((isOpen and "▲") or "▼")
            end
        end

        SharedDropdownUpdaters[syncGroupId][configKey] = updateDisplayOnly

        local function updateTextAndSave()
            for _, updateFunc in pairs(SharedDropdownUpdaters[syncGroupId]) do
                updateFunc()
            end
            CurrentConfig[configKey] = selected
            callback(selected)
        end

        UIControllers[configKey] = function(loadedTable)
            if (type(loadedTable) == "table") then
                for k, v in pairs(loadedTable) do
                    if (selected[k] ~= nil) then
                        selected[k] = v
                        sharedTable[k] = v
                    end
                end
                for optName, btn in pairs(optBtns) do
                    btn.TextColor3 = (selected[optName] and Theme.Success) or Theme.TextDim
                end
                updateTextAndSave()
            end
        end

        mainBtn.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            if isOpen then
                TweenService:Create(container, TweenInfo.new(0.2), {
                    Size = UDim2.new(0, 260, 0, 32 + maxDropHeight)
                }):Play()
            else
                TweenService:Create(container, TweenInfo.new(0.2), {
                    Size = UDim2.new(0, 260, 0, 32)
                }):Play()
            end
            updateDisplayOnly()
        end)

        for i, option in ipairs(options) do
            local optBtn = Instance.new("TextButton", scroll)
            optBtn.Size = UDim2.new(1, -10, 0, 30)
            optBtn.BackgroundColor3 = Theme.Surface
            optBtn.Text = " " .. option
            optBtn.TextColor3 = Theme.TextDim
            optBtn.Font = Enum.Font.GothamBold
            optBtn.TextSize = 11
            optBtn.TextXAlignment = Enum.TextXAlignment.Left
            optBtns[option] = optBtn

            optBtn.MouseButton1Click:Connect(function()
                selected[option] = not selected[option]
                sharedTable[option] = selected[option]
                optBtn.TextColor3 = (selected[option] and Theme.Success) or Theme.TextDim
                updateTextAndSave()
            end)
        end
        CurrentConfig[configKey] = selected
    end

    local function CreateNumberPicker(parent, title, min, max, default, configKey, callback)
        local frame = Instance.new("Frame", parent)
        frame.Size = UDim2.new(0, 260, 0, 32)
        frame.BackgroundColor3 = Theme.SurfaceLight
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(0, 110, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = title
        label.TextColor3 = Theme.Text
        label.Font = Enum.Font.GothamBold
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextSize = 11

        local controls = Instance.new("Frame", frame)
        controls.Size = UDim2.new(0, 130, 1, 0)
        controls.Position = UDim2.new(1, -140, 0, 0)
        controls.BackgroundTransparency = 1

        local minusBtn = Instance.new("TextButton", controls)
        minusBtn.Size = UDim2.new(0, 28, 0, 24)
        minusBtn.Position = UDim2.new(0, 0, 0.5, -12)
        minusBtn.BackgroundColor3 = Theme.Surface
        minusBtn.Text = "-"
        minusBtn.TextColor3 = Theme.Text
        minusBtn.Font = Enum.Font.GothamBold
        Instance.new("UICorner", minusBtn).CornerRadius = UDim.new(0, 4)

        local textInput = Instance.new("TextBox", controls)
        textInput.Size = UDim2.new(0, 60, 0, 24)
        textInput.Position = UDim2.new(0, 34, 0.5, -12)
        textInput.BackgroundColor3 = Theme.Surface
        textInput.Text = tostring(default)
        textInput.TextColor3 = Theme.Accent
        textInput.Font = Enum.Font.GothamBold
        textInput.TextSize = 11
        Instance.new("UICorner", textInput).CornerRadius = UDim.new(0, 4)

        local plusBtn = Instance.new("TextButton", controls)
        plusBtn.Size = UDim2.new(0, 28, 0, 24)
        plusBtn.Position = UDim2.new(0, 100, 0.5, -12)
        plusBtn.BackgroundColor3 = Theme.Surface
        plusBtn.Text = "+"
        plusBtn.TextColor3 = Theme.Text
        plusBtn.Font = Enum.Font.GothamBold
        Instance.new("UICorner", plusBtn).CornerRadius = UDim.new(0, 4)

        local val = default
        UIControllers[configKey] = function(newVal)
            newVal = tonumber(newVal) or default
            newVal = math.clamp(newVal, min, max)
            val = newVal
            textInput.Text = tostring(val)
            CurrentConfig[configKey] = val
            callback(val)
        end

        minusBtn.MouseButton1Click:Connect(function()
            UIControllers[configKey](val - 1)
        end)
        plusBtn.MouseButton1Click:Connect(function()
            UIControllers[configKey](val + 1)
        end)
        textInput.FocusLost:Connect(function()
            UIControllers[configKey](textInput.Text)
        end)
        CurrentConfig[configKey] = default
    end

    local function CreateStringInput(parent, text, placeholder, configKey, callback)
        local frame = Instance.new("Frame", parent)
        frame.Size = UDim2.new(0, 260, 0, 50)
        frame.BackgroundColor3 = Theme.SurfaceLight
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1, -20, 0, 20)
        label.Position = UDim2.new(0, 10, 0, 2)
        label.BackgroundTransparency = 1
        label.Text = text
        label.TextColor3 = Theme.Text
        label.Font = Enum.Font.GothamBold
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.TextSize = 11

        local input = Instance.new("TextBox", frame)
        input.Size = UDim2.new(1, -20, 0, 22)
        input.Position = UDim2.new(0, 10, 0, 22)
        input.BackgroundColor3 = Theme.Surface
        input.TextColor3 = Theme.Accent
        input.Text = ""
        input.PlaceholderText = placeholder
        input.Font = Enum.Font.GothamBold
        input.TextSize = 10
        input.TextXAlignment = Enum.TextXAlignment.Left
        input.ClearTextOnFocus = false
        input.ClipsDescendants = true
        Instance.new("UICorner", input).CornerRadius = UDim.new(0, 4)

        UIControllers[configKey] = function(val)
            input.Text = val
            CurrentConfig[configKey] = val
            callback(val)
        end

        input.FocusLost:Connect(function()
            UIControllers[configKey](input.Text)
        end)
        CurrentConfig[configKey] = ""
    end

    -- =====================================================
    -- 9. DISCORD WEBHOOK SYSTEM
    -- =====================================================
    local webhookURL = ""
    local enableWebhook = false
    local sessionPetCounts = {}

    local function SendDiscordWebhook(title, msg, color, isTest)
        if (webhookURL == "") then return end
        if (not enableWebhook and not isTest) then return end

        local httprequest = (syn and syn.request) or (http and http.request) or http_request or (fluxus and fluxus.request) or request
        if httprequest then
            local data = {
                embeds = {
                    {
                        title = title,
                        description = msg,
                        type = "rich",
                        color = color,
                        footer = { text = "MEKI HUB | " .. os.date("%X") }
                    }
                }
            }
            task.spawn(function()
                pcall(function()
                    httprequest({
                        Url = webhookURL,
                        Method = "POST",
                        Headers = { ["Content-Type"] = "application/json" },
                        Body = HttpService:JSONEncode(data)
                    })
                end)
            end)
        end
    end

    -- =====================================================
    -- 10. PET DATA & UTILITY FUNCTIONS
    -- =====================================================
    local petData = {
        Common = { "Noobini Pizzanini", "Tim Cheese", "LiriIi LariIa", "Trippi Troppi", "Talpa Di Fero", "Fruli Frula",
            "pipi Kiwi" },
        Rare = { "Gangster Footera", "Bobrito Bandito", "Boneca Ambalabu", "Ta Ta Ta Ta Sahur", "Ballerina Cappuccina",
            "Brr Brr Patapim", "Cappuccino Assassino", "Cacto Hipopotamo" },
        Epic = { "Madung", "Waterdino", "Pesto Mortioni", "Pannaburro", "Mangolini Parrocini", "Orcalero", "John Pork",
            "Gattatino Nyanino" },
        Legendary = { "Chimpanzini Bananini", "Plan Red", "Plan Blue", "Capi Taco", "Trulimero Trulicana",
            "Bambini Crostini", "Elefantucci Bananucci", "Bananita Dolphinita", "Salamino Pinguino" },
        Mythic = { "Penguino Cocosino", "67", "Burbaloni Luliloli", "Chef Crabracadabra", "Capybara Eggplant", "Bangello",
            "Elefanto Frigo", "Rinooccio Veidini", "Glorbo Fruttodrillo" },
        Godly = { "Udin Din Din Dun", "Pandaccini Bananini", "Octopusini Bluberini", "Strawberelli Flamingelli",
            "Sigma Boy", "Frigo Camelo", "Orangutini Ananasini", "Rhino Toasterino", "Bombardiro Crocodilo" },
        Secret = { "Bombini Gusini", "Tuff Toucan", "Fryuro", "Burguro", "Guest666", "Zibra Zubra Zibralini",
            "Cavallo Virtuso", "Gorillo Watermelondrillo", "Cocofanto Elefanto" },
        Divine = { "Girafa Celeste", "Tralalero Tralala", "Tralalerita Tralala", "Peant jarro", "Dipperi Chiperini",
            "Rexosaurus", "1X1X1X1", "Matteo" },
        Hacked = { "Alessio", "Tripi Tropi Tropa Tripa", "Torrtuginni Dragonfruitini", "Tictac Sahur", "Cactus Pingu",
            "SWAG SODA", "Los Primos Blue", "Stoppo Luminino", "La Vacca Saturno Saturnita", "Agarrini La Palini" },
        OG = { "Karkerkar Kurkur", "Compactoroni Diskaloni", "Blackhole Goat", "Cappuccino Clownino",
            "Nuclearo Dinossauro", "Los Nooo My Hotspotsitos", "Chillin Chilli", "Crazylone Pizaione", "Corn Sahur",
            "Meowl", "Strawberry Elephant" },
        Celestial = { "Dragonfrutina Dolphinita", "Guerriro Digitale", "Ketchuru and Musturu", "Chicleteira Bicicleteira",
            "Pot Hotspot", "Krupuk Pagi Pagi", "Beluga Beluga", "Tralaledon", "Anpalı Babel",
            "Mastodontico Telepiedone" },
        Eternal = { "Professora 67", "Astro Tim", "Baba Yaga", "Espresso Shockantoni", "Ketupat Kepat", "Dumbelloni",
            "Smelloni Papayoni", "Barbelloni Gymrattoni", "Kicky" }
    }

    local rarities = { "Common", "Rare", "Epic", "Legendary", "Mythic", "Godly", "Secret", "Divine", "Hacked", "OG",
        "Celestial", "Eternal" }
    local mutationList = { "Normal", "Golden", "Diamond", "Plasma", "Molten", "Radioactive", "Shadow", "Volcanic",
        "Electrified", "Rainbow", "Virus", "Alien", "Void", "Block Cup", "Carnival", "Heavenly", "Bacon", "Enchanted",
        "Phantom", "Astral", "Wet" }

    local customWalkSpeed = 50
    local enableCustomSpeed = false

    local function ForcedTP(targetCFrame)
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Velocity = Vector3.new(0, 0, 0)
            hrp.CFrame = targetCFrame
        end
    end

    local Net = game:GetService("ReplicatedStorage"):WaitForChild("Shared"):WaitForChild("Packages"):WaitForChild("Network")
    local FIXED_Y = 3

    local function smoothFlyTo(hrp, hum, targetPos)
        local target = Vector3.new(targetPos.X, FIXED_Y, targetPos.Z)
        if hrp then hrp.Anchored = true end
        while hrp and hum and (hum.Health > 0) do
            local dt = task.wait()
            local pos = hrp.Position
            local dir = target - pos
            local dist = dir.Magnitude
            if (dist < 2) then
                hrp.CFrame = CFrame.new(target)
                break
            end
            local flySpeed = (enableCustomSpeed and customWalkSpeed) or math.max(hum.WalkSpeed, 50)
            local moveDist = flySpeed * dt
            if (moveDist > dist) then moveDist = dist end
            hrp.CFrame = CFrame.new(pos + (dir.Unit * moveDist))
        end
        if (hrp and hrp.Parent) then hrp.Anchored = false end
    end

    -- =====================================================
    -- 11. PET MUTATION DETECTION (FULL BUFFS CHECK)
    -- =====================================================
    local fullBuffsCheckList = {
        "Golden", "Diamond", "Volcanic", "Plasma", "Molten", "Radioactive", "Shadow",
        "Electrified", "Rainbow", "Virus", "Alien", "Void", "Bacon", "Enchanted",
        "Block Cup", "Carnival", "Heavenly", "Phantom", "Astral", "Wet"
    }

    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local MutationData = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Data"):WaitForChild("MutationData")
    local MutationSwitch = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("Data"):WaitForChild("MutationSwitch")
    local MutationVFX = ReplicatedStorage:WaitForChild("Objects"):WaitForChild("VFX"):WaitForChild("MutationVFX")

    local MutationCache = {}
    pcall(function()
        for _, mut in pairs(MutationSwitch:GetChildren()) do
            MutationCache[string.lower(mut.Name)] = mut.Name
        end
        for _, mut in pairs(MutationData:GetChildren()) do
            MutationCache[string.lower(mut.Name)] = mut.Name
        end
        for _, mut in pairs(MutationVFX:GetChildren()) do
            MutationCache[string.lower(mut.Name)] = mut.Name
        end
    end)

    for _, buff in ipairs(fullBuffsCheckList) do
        MutationCache[string.lower(buff)] = buff
    end

    local SpecialMutationObjects = {
        eye = "Alien", handle = "Bacon", water = "Wet", splash = "Wet",
        droplet = "Wet", aura = "Void", blackhole = "Void", void = "Void",
        glitch = "Virus", virus = "Virus", Hips = "Heavenly", spark = "Electrified",
        electric = "Electrified", fire = "Molten", lava = "Molten",
        Mutation = "Block Cup", Cube = "Carnival", phantom = "Phantom",
        shadow = "Shadow", rainbow = "Rainbow", gold = "Golden", diamond = "Diamond"
    }

    for objName, mutation in pairs(SpecialMutationObjects) do
        MutationCache[string.lower(objName)] = mutation
    end

    local function GetPetBuffs(petModel)
        local detectedBuffs = {}
        if not petModel then return detectedBuffs end

        local lowerMonsterName = string.lower(petModel.Name)
        for _, buff in ipairs(fullBuffsCheckList) do
            if string.find(lowerMonsterName, string.lower(buff)) then
                detectedBuffs[buff] = true
            end
        end

        for attrName, attrValue in pairs(petModel:GetAttributes()) do
            local lowerAttr = string.lower(attrName)
            if ((type(attrValue) == "boolean") and (attrValue == true) and MutationCache[lowerAttr]) then
                detectedBuffs[MutationCache[lowerAttr]] = true
            end
            if ((type(attrValue) == "string") and MutationCache[string.lower(attrValue)]) then
                detectedBuffs[MutationCache[string.lower(attrValue)]] = true
            end
        end

        for _, obj in pairs(petModel:GetDescendants()) do
            local objName = string.lower(obj.Name)
            if MutationCache[objName] then
                detectedBuffs[MutationCache[objName]] = true
            end
            if (obj:IsA("StringValue") and MutationCache[string.lower(tostring(obj.Value))]) then
                detectedBuffs[MutationCache[string.lower(tostring(obj.Value))]] = true
            end

            for attrName, attrValue in pairs(obj:GetAttributes()) do
                local lowerAttr = string.lower(attrName)
                if ((type(attrValue) == "boolean") and (attrValue == true) and MutationCache[lowerAttr]) then
                    detectedBuffs[MutationCache[lowerAttr]] = true
                end
                if ((type(attrValue) == "string") and MutationCache[string.lower(attrValue)]) then
                    detectedBuffs[MutationCache[string.lower(attrValue)]] = true
                end
            end

            if obj:IsA("TextLabel") then
                local txt = string.lower(obj.Text)
                for _, buff in ipairs(fullBuffsCheckList) do
                    if string.find(txt, string.lower(buff)) then
                        detectedBuffs[buff] = true
                    end
                end
            end

            if ((obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam")) and MutationCache[string.lower(obj.Name)]) then
                detectedBuffs[MutationCache[string.lower(obj.Name)]] = true
            end
        end
        return detectedBuffs
    end

    -- =====================================================
    -- 12. MAIN TAB (AUTO KICK, TRAIN, SPEED)
    -- =====================================================
    local targetKickPets = {}
    local kickPetDropdowns = {}
    local targetMutations = {}

    CreateDropdown(MainTab, "Filter Rarity", rarities, "Main_FilterRarity", function(selectedRarity)
        for r, container in pairs(kickPetDropdowns) do
            container.Visible = r == selectedRarity
        end
    end)

    for _, rarity in ipairs(rarities) do
        local container = Instance.new("Frame", MainTab)
        container.Size = UDim2.new(0, 260, 0, 32)
        container.BackgroundTransparency = 1
        container.AutomaticSize = Enum.AutomaticSize.Y
        container.Visible = rarity == "Common"
        kickPetDropdowns[rarity] = container
        CreateSharedMultiDropdown(container, "Target Brainrots", petData[rarity], "Main_TargetPets_" .. rarity,
            "MainKickPetsSync", targetKickPets, function(sel) end)
    end

    CreateMultiDropdown(MainTab, "Target Mutation", mutationList, "Main_TargetMutations", function(selected)
        targetMutations = selected
    end)

    local autoKick = false
    local tickID = 0
    CreateToggle(MainTab, "Auto Kick (Warp & Run Back) ✨", "AutoKick", function(v)
        autoKick = v
        tickID = tickID + 1
        local id = tickID
        if autoKick then
            task.spawn(function()
                while autoKick and (id == tickID) do
                    pcall(function()
                        local char = player.Character
                        local hrp = char and char:FindFirstChild("HumanoidRootPart")
                        local hum = char and char:FindFirstChild("Humanoid")
                        if not (hrp and hum and (hum.Health > 0)) then return end

                        local kickPos = workspace:FindFirstChild("Areas") and workspace.Areas:FindFirstChild("KickReady")
                        if not kickPos then return end
                        local targetCF = (kickPos:IsA("BasePart") and kickPos.CFrame) or kickPos:GetPivot()

                        if ((hrp.Position - targetCF.Position).Magnitude > 5) then
                            ForcedTP(targetCF + Vector3.new(0, 3, 0))
                        end
                        task.wait(0.5)

                        local startPos = hrp.Position
                        local wasTeleported = false
                        local HUD = PlayerGui:FindFirstChild("HUD")

                        for i = 1, 150 do
                            task.wait(0.1)
                            if (not char or not char.Parent or (hum.Health <= 0)) then return end
                            if ((hrp.Position - startPos).Magnitude > 40) then
                                wasTeleported = true
                                break
                            end
                            local KickButton = HUD and HUD:FindFirstChild("KickButton")
                            if (KickButton and KickButton.Visible) then
                                Net.rev_KickEvent:FireServer(1)
                                task.wait(0.5)
                            end
                        end
                        if not wasTeleported then return end
                        task.wait(0.5)

                        local hasMonster = false
                        local spawnedMonster = nil
                        for i = 1, 40 do
                            task.wait(0.2)
                            local closestDist = 60
                            for _, obj in pairs(workspace.Debris:GetChildren()) do
                                if (obj:IsA("Model") and obj.PrimaryPart) then
                                    local dist = (obj.PrimaryPart.Position - hrp.Position).Magnitude
                                    if (dist < closestDist) then
                                        closestDist = dist
                                        hasMonster = true
                                        spawnedMonster = obj
                                    end
                                end
                            end
                            if hasMonster then break end
                        end

                        if (hasMonster and spawnedMonster) then
                            task.wait(0.5)
                            local isDesiredMut = false
                            local hasMutSelection = false
                            local activeBuffs = GetPetBuffs(spawnedMonster)

                            for mut, isActive in pairs(targetMutations) do
                                if isActive then
                                    hasMutSelection = true
                                    if (mut == "Normal") then
                                        local hasAnyBuff = false
                                        for _, _ in pairs(activeBuffs) do
                                            hasAnyBuff = true
                                            break
                                        end
                                        if not hasAnyBuff then
                                            isDesiredMut = true
                                            break
                                        end
                                    elseif activeBuffs[mut] then
                                        isDesiredMut = true
                                        break
                                    end
                                end
                            end

                            local isDesiredName = false
                            local hasNameSelection = false
                            for petName, isActive in pairs(targetKickPets) do
                                if isActive then
                                    hasNameSelection = true
                                    if (string.lower(spawnedMonster.Name) == string.lower(petName)) then
                                        isDesiredName = true
                                        break
                                    end
                                end
                            end

                            local shouldKill = false
                            if (hasMutSelection and not isDesiredMut) then shouldKill = true end
                            if (hasNameSelection and not isDesiredName) then shouldKill = true end

                            if shouldKill then
                                local waves = workspace:FindFirstChild("Waves")
                                local wavePos = nil
                                if waves then
                                    if waves:IsA("BasePart") then
                                        wavePos = waves.Position
                                    elseif waves:IsA("Model") then
                                        wavePos = waves:GetPivot().Position
                                    else
                                        local part = waves:FindFirstChildWhichIsA("BasePart", true)
                                        if part then wavePos = part.Position end
                                    end
                                end
                                if wavePos then
                                    smoothFlyTo(hrp, hum, wavePos)
                                elseif kickPos then
                                    smoothFlyTo(hrp, hum, targetCF.Position)
                                end
                            elseif (spawnedMonster and not spawnedMonster:GetAttribute("WebhookSent")) then
                                spawnedMonster:SetAttribute("WebhookSent", true)
                                local petName = spawnedMonster.Name
                                local buffStrTbl = {}
                                for b, _ in pairs(activeBuffs) do
                                    table.insert(buffStrTbl, b)
                                end
                                local buffText = ((#buffStrTbl > 0) and table.concat(buffStrTbl, ", ")) or "Normal"
                                local petRarity = "Unknown"
                                if petData then
                                    for r, pets in pairs(petData) do
                                        for _, p in ipairs(pets) do
                                            if (string.lower(petName) == string.lower(p)) then
                                                petRarity = r
                                                break
                                            end
                                        end
                                        if (petRarity ~= "Unknown") then break end
                                    end
                                end
                                local currentAttemptCount = (sessionPetCounts[petName] or 0) + 1
                                SendDiscordWebhook("👀 Target Found!",
                                    "**Pet:** " .. petName .. "\n**Rarity:** " .. petRarity .. "\n**Mutation:** " .. buffText ..
                                    "\n**Count:** " .. currentAttemptCount .. "\n**Player:** " .. player.Name, 3447003,
                                    false)
                                if kickPos then
                                    smoothFlyTo(hrp, hum, targetCF.Position)
                                    task.wait(1.5)
                                    if (char and hum and (hum.Health > 0) and ((hrp.Position - targetCF.Position).Magnitude <
                                        20)) then
                                        sessionPetCounts[petName] = (sessionPetCounts[petName] or 0) + 1
                                        local actualCount = sessionPetCounts[petName]
                                        SendDiscordWebhook("🎉 Target Collected!",
                                            "**Pet:** " .. petName .. "\n**Rarity:** " .. petRarity .. "\n**Mutation:** " ..
                                            buffText .. "\n**Count:** " .. actualCount .. "\n**Player:** " .. player.Name,
                                            314153, false)
                                    end
                                end
                            elseif kickPos then
                                smoothFlyTo(hrp, hum, targetCF.Position)
                            end
                        end
                    end)
                    task.wait(0.4)
                end
            end)
        end
    end)

    -- Auto Train
    local autoTrain = false
    local trainTick = 0
    local validWeights = {
        ["Wooden Stick"] = true, ["Copper Plate"] = true, ["Stone Block"] = true,
        ["Bone Barbell"] = true, ["Donut Barbell"] = true, ["Ice Barbell"] = true,
        ["Iron Plate"] = true, ["Heaven Plate"] = true, ["Gold Barbell"] = true,
        ["Golden Barbell"] = true, ["Giant Gold Star Barbell"] = true, ["Neon Pulse"] = true,
        ["Mega Gold Barbell"] = true, ["Mega Golden Barbell"] = true, ["Emerald Barbell"] = true,
        ["Planet Barbell"] = true
    }

    CreateToggle(MainTab, "Auto Train & x2 ||—||", "AutoTrain", function(v)
        autoTrain = v
        trainTick = trainTick + 1
        local currentTick = trainTick
        if autoTrain then
            task.spawn(function()
                while autoTrain and (currentTick == trainTick) do
                    pcall(function()
                        local char = player.Character
                        local hum = char and char:FindFirstChild("Humanoid")
                        local backpack = player:FindFirstChild("Backpack")
                        local currentTool = char and char:FindFirstChildOfClass("Tool")
                        local isHoldingValidWeight = currentTool and validWeights[currentTool.Name]

                        if not isHoldingValidWeight then
                            if currentTool then hum:UnequipTools() end
                            local slot1 = PlayerGui:FindFirstChild("Backpack") and PlayerGui.Backpack:FindFirstChild(
                                "Bar") and PlayerGui.Backpack.Bar:FindFirstChild("Slot1")
                            if (slot1 and getconnections) then
                                local targets = { slot1, slot1:FindFirstChild("ToolImage") }
                                for _, t in pairs(targets) do
                                    if t then
                                        pcall(function()
                                            for _, c in pairs(getconnections(t.MouseButton1Down)) do c:Fire() end
                                        end)
                                        pcall(function()
                                            for _, c in pairs(getconnections(t.MouseButton1Click)) do c:Fire() end
                                        end)
                                        pcall(function()
                                            for _, c in pairs(getconnections(t.Activated)) do c:Fire() end
                                        end)
                                        pcall(function()
                                            for _, c in pairs(getconnections(t.InputBegan)) do
                                                c:Fire({ UserInputType = Enum.UserInputType.MouseButton1,
                                                    UserInputState = Enum.UserInputState.Begin })
                                            end
                                        end)
                                        pcall(function()
                                            for _, c in pairs(getconnections(t.InputBegan)) do
                                                c:Fire({ UserInputType = Enum.UserInputType.Touch,
                                                    UserInputState = Enum.UserInputState.Begin })
                                            end
                                        end)
                                    end
                                end
                            end
                            task.wait(0.1)
                            if (not char:FindFirstChildOfClass("Tool") and backpack and hum) then
                                for _, tool in pairs(backpack:GetChildren()) do
                                    if (tool:IsA("Tool") and validWeights[tool.Name]) then
                                        hum:EquipTool(tool)
                                        break
                                    end
                                end
                            end
                        else
                            currentTool:Activate()
                            if getconnections then
                                for _, c in pairs(getconnections(currentTool.Activated)) do c:Fire() end
                            end
                        end
                    end)
                    pcall(function()
                        local kickUpgrades = PlayerGui:FindFirstChild("KickUpgrades")
                        if kickUpgrades then
                            for _, bonus in pairs(kickUpgrades:GetChildren()) do
                                if ((bonus.Name == "Bonus") or (bonus.Name == "PopBonus")) then
                                    if bonus.Visible then
                                        if not bonus:GetAttribute("AutoClicked") then
                                            bonus:SetAttribute("AutoClicked", true)
                                            task.spawn(function()
                                                task.wait(0.2)
                                                local imgLabel = bonus:FindFirstChild("ImageLabel")
                                                local targets = { bonus }
                                                if imgLabel then table.insert(targets, imgLabel) end
                                                if getconnections then
                                                    for _, target in pairs(targets) do
                                                        pcall(function()
                                                            for _, conn in pairs(getconnections(target.InputBegan)) do
                                                                conn:Fire({ UserInputType = Enum.UserInputType
                                                                        .MouseButton1,
                                                                    UserInputState = Enum.UserInputState.Begin })
                                                                conn:Fire({ UserInputType = Enum.UserInputType.Touch,
                                                                    UserInputState = Enum.UserInputState.Begin })
                                                            end
                                                        end)
                                                        pcall(function()
                                                            for _, conn in pairs(getconnections(target
                                                                .MouseButton1Down)) do conn:Fire() end
                                                        end)
                                                        pcall(function()
                                                            for _, conn in pairs(getconnections(target
                                                                .MouseButton1Up)) do conn:Fire() end
                                                        end)
                                                        pcall(function()
                                                            for _, conn in pairs(getconnections(target
                                                                .MouseButton1Click)) do conn:Fire() end
                                                        end)
                                                        pcall(function()
                                                            for _, conn in pairs(getconnections(target.Activated)) do
                                                                conn:Fire() end
                                                        end)
                                                    end
                                                end
                                            end)
                                        end
                                    else
                                        bonus:SetAttribute("AutoClicked", nil)
                                    end
                                end
                            end
                        end
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end)

    CreateToggle(MainTab, "Enable Custom Speed 🏃", "EnableSpeed", function(v)
        enableCustomSpeed = v
        if enableCustomSpeed then
            task.spawn(function()
                while enableCustomSpeed do
                    pcall(function()
                        local char = player.Character
                        local hum = char and char:FindFirstChild("Humanoid")
                        if hum then hum.WalkSpeed = customWalkSpeed end
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end)

    CreateNumberPicker(MainTab, "Set Speed", 1, 1000, 50, "SpeedVal", function(val)
        customWalkSpeed = val
    end)

    CreateButton(MainTab, "TP KickReady ⚡", function()
        pcall(function()
            ForcedTP(workspace.Areas.KickReady.CFrame + Vector3.new(0, 5, 0))
        end)
    end)

    -- =====================================================
    -- 13. COLLECT TAB (MONEY, EVENT, BLOCK CUP)
    -- =====================================================
    local autoCollect = false
    local lockedPlot = nil

    CreateToggle(CollectTab, "Auto Collect Money (home) 🤑", "AutoCollect", function(v)
        autoCollect = v
        local char = player.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if autoCollect then
            if (not lockedPlot and hrp) then
                local closestDist = math.huge
                for _, plot in pairs(workspace:WaitForChild("Plots"):GetChildren()) do
                    if (plot:IsA("Model") or plot:IsA("Folder")) then
                        local dist = (hrp.Position - plot:GetPivot().Position).Magnitude
                        if (dist < closestDist) then
                            closestDist = dist
                            lockedPlot = plot
                        end
                    end
                end
            end
            task.spawn(function()
                while autoCollect do
                    if lockedPlot then
                        local buttonsFolder = lockedPlot:FindFirstChild("Buttons")
                        if buttonsFolder then
                            for i = 1, 30 do
                                if not autoCollect then break end
                                local slotPart = buttonsFolder:FindFirstChild("Slot" .. i)
                                if slotPart then
                                    local targetCFrame
                                    if slotPart:IsA("BasePart") then
                                        targetCFrame = slotPart.CFrame
                                    elseif (slotPart:IsA("Model") and slotPart.PrimaryPart) then
                                        targetCFrame = slotPart.PrimaryPart.CFrame
                                    elseif slotPart:FindFirstChildWhichIsA("BasePart") then
                                        targetCFrame = slotPart:FindFirstChildWhichIsA("BasePart").CFrame
                                    end
                                    if targetCFrame then
                                        pcall(function()
                                            ForcedTP(targetCFrame + Vector3.new(0, 1.5, 0))
                                            task.wait(0.1)
                                            Net.rev_B_Collect:FireServer(i)
                                        end)
                                    end
                                end
                            end
                        end
                    end
                    task.wait(1.5)
                end
            end)
        end
    end)

    local instantInteract = false
    CreateToggle(CollectTab, "Instant Grab (No Delay) ⚡", "InstantGrab", function(v)
        instantInteract = v
        if instantInteract then
            task.spawn(function()
                while instantInteract do
                    pcall(function()
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj:IsA("ProximityPrompt") then
                                obj.HoldDuration = 0
                            end
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end)

    -- =====================================================
    -- 14. EVENT TAB (BLOCK CUP COLLECTOR)
    -- =====================================================
    local rarityMapping = {
        { actual = "ALL", display = "🌟 All", showInUI = true },
        { actual = "Common", display = "🟡 Common", showInUI = true },
        { actual = "Rare", display = "🔵 Rare", showInUI = true },
        { actual = "Epic", display = "🟣 Epic", showInUI = true },
        { actual = "Legendary", display = "🔴 Legendary", showInUI = true },
        { actual = "Mythic", display = "🟠 Mythic", showInUI = false },
        { actual = "Godly", display = "🔴 Godly", showInUI = false },
        { actual = "Secret", display = "💎 Secret", showInUI = false },
        { actual = "Divine", display = "✨ Divine", showInUI = false },
        { actual = "Hacked", display = "💻 Hacked", showInUI = false },
        { actual = "OG", display = "👑 OG", showInUI = false },
        { actual = "Celestial", display = "🌌 Celestial", showInUI = false },
        { actual = "Eternal", display = "🔥 Eternal", showInUI = false }
    }

    local uiOptions = {}
    local actualToDisplay = {}
    for _, item in ipairs(rarityMapping) do
        if item.showInUI then table.insert(uiOptions, item.display) end
        actualToDisplay[item.actual] = item.display
    end

    local selectedRarities = {}
    CreateMultiDropdown(EventTab, "Target Ball Rarity ⚽", uiOptions, "TargetBallRarity", function(selected)
        selectedRarities = selected
    end)

    local function isBallRaritySelected(ballName)
        if selectedRarities["🌟 All"] then return actualToDisplay[ballName] ~= nil end
        local displayName = actualToDisplay[ballName]
        if displayName then return selectedRarities[displayName] == true end
        return false
    end

    -- Safe Mode
    local autoCollectVolcanoSafe = false
    local volcanoSafeTick = 0
    CreateToggle(EventTab, "Auto BLOCK CUP Event (Safe Run) ⚽🏃", "AutoCollectVolcanoSafe", function(v)
        autoCollectVolcanoSafe = v
        volcanoSafeTick = volcanoSafeTick + 1
        local myTick = volcanoSafeTick
        if autoCollectVolcanoSafe then
            task.spawn(function()
                while autoCollectVolcanoSafe and (myTick == volcanoSafeTick) do
                    pcall(function()
                        local char = player.Character
                        local hrp = char and char:FindFirstChild("HumanoidRootPart")
                        local hum = char and char:FindFirstChild("Humanoid")
                        if not (hrp and hum and (hum.Health > 0)) then return end

                        local kickPos = workspace:FindFirstChild("Areas") and workspace.Areas:FindFirstChild("KickReady")
                        if not kickPos then return end
                        local targetCF = (kickPos:IsA("BasePart") and kickPos.CFrame) or kickPos:GetPivot()
                        local safeZonePos = targetCF.Position

                        if ((hrp.Position - safeZonePos).Magnitude > 10) then
                            ForcedTP(targetCF + Vector3.new(0, 3, 0))
                        end
                        task.wait(0.5)

                        local startPos = hrp.Position
                        local wasTeleported = false
                        local HUD = PlayerGui:FindFirstChild("HUD")

                        for i = 1, 150 do
                            task.wait(0.1)
                            if (not char or not char.Parent or (hum.Health <= 0) or not autoCollectVolcanoSafe) then
                                return
                            end
                            local KickButton = HUD and HUD:FindFirstChild("KickButton")
                            if (KickButton and KickButton.Visible) then
                                Net.rev_KickEvent:FireServer(1)
                            end
                            if ((hrp.Position - startPos).Magnitude > 40) then
                                wasTeleported = true
                                break
                            end
                        end
                        if not wasTeleported then return end

                        local stuckTimeout = 0
                        local lastPos = hrp.Position
                        while autoCollectVolcanoSafe and (hum.Health > 0) do
                            pcall(function()
                                if (hum.Sit or hum.PlatformStand or (hum:GetState() == Enum.HumanoidStateType.Ragdoll) or
                                    (hum:GetState() == Enum.HumanoidStateType.FallingDown)) then
                                    hum.Sit = false
                                    hum.PlatformStand = false
                                    hum:ChangeState(Enum.HumanoidStateType.Running)
                                    hum.Jump = true
                                end
                            end)

                            local currentPos = hrp.Position
                            local toSafeZoneDir = (Vector3.new(safeZonePos.X, 0, safeZonePos.Z) -
                                Vector3.new(currentPos.X, 0, currentPos.Z)).Unit

                            for _, obj in pairs(workspace.Debris:GetChildren()) do
                                if not isBallRaritySelected(obj.Name) then continue end
                                local hitbox = obj:FindFirstChild("RootPart", true) or obj:FindFirstChild("Hitbox",
                                    true) or obj:FindFirstChildWhichIsA("BasePart", true)
                                if (hitbox and hitbox:IsA("BasePart")) then
                                    local coinPos = hitbox.Position
                                    local distToCoin = (currentPos - coinPos).Magnitude
                                    if (distToCoin <= 60) then
                                        local toCoinDir = (Vector3.new(coinPos.X, 0, coinPos.Z) -
                                            Vector3.new(currentPos.X, 0, currentPos.Z)).Unit
                                        local dotProduct = toSafeZoneDir:Dot(toCoinDir)
                                        if (dotProduct >= -0.2) then
                                            pcall(function()
                                                if firetouchinterest then
                                                    task.spawn(function()
                                                        firetouchinterest(hrp, hitbox, 0)
                                                        task.wait(0.05)
                                                        firetouchinterest(hrp, hitbox, 1)
                                                    end)
                                                end
                                                Net.rev_CollectShard:FireServer(obj.Name)
                                            end)
                                        end
                                    end
                                end
                            end

                            pcall(function()
                                if (not hum.Sit and (hum:GetState() ~= Enum.HumanoidStateType.Ragdoll)) then
                                    hum:MoveTo(safeZonePos)
                                end
                            end)

                            local currentDistToSafe = (hrp.Position - safeZonePos).Magnitude
                            if (currentDistToSafe <= 6) then break end

                            if ((hrp.Position - lastPos).Magnitude < 0.5) then
                                stuckTimeout = stuckTimeout + 0.1
                            else
                                stuckTimeout = 0
                                lastPos = hrp.Position
                            end
                            if (stuckTimeout > 3) then
                                ForcedTP(targetCF + Vector3.new(0, 3, 0))
                                break
                            end
                            task.wait(0.1)
                        end
                    end)
                    task.wait(0.5)
                end
            end)
        end
    end)

    -- Kamikaze Mode
    local autoCollectVolcanoKamikaze = false
    local volcanoKamikazeTick = 0
    local fixedStartCFrame = CFrame.new(669.768310546875, -7.001974582672119, 244.5688934326172)

    CreateToggle(EventTab, "Collect BLOCK CUP ⚽ (NO Safe Zone)", "AutoCollectVolcanoKamikaze", function(v)
        autoCollectVolcanoKamikaze = v
        volcanoKamikazeTick = volcanoKamikazeTick + 1
        local myTick = volcanoKamikazeTick
        if autoCollectVolcanoKamikaze then
            task.spawn(function()
                while autoCollectVolcanoKamikaze and (myTick == volcanoKamikazeTick) do
                    pcall(function()
                        local char = player.Character
                        local hrp = char and char:FindFirstChild("HumanoidRootPart")
                        local hum = char and char:FindFirstChild("Humanoid")
                        if not (char and hrp and hum and (hum.Health > 0)) then
                            task.wait(1)
                            return
                        end

                        local kickPos = workspace:FindFirstChild("Areas") and workspace.Areas:FindFirstChild("KickReady")
                        if not kickPos then return end
                        local targetCF = (kickPos:IsA("BasePart") and kickPos.CFrame) or kickPos:GetPivot()

                        if ((hrp.Position - targetCF.Position).Magnitude > 10) then
                            ForcedTP(targetCF + Vector3.new(0, 3, 0))
                        end
                        task.wait(0.4)

                        local startPos = hrp.Position
                        local wasTeleported = false
                        local HUD = PlayerGui:FindFirstChild("HUD")

                        for i = 1, 150 do
                            task.wait(0.08)
                            if not autoCollectVolcanoKamikaze then return end
                            local KickButton = HUD and HUD:FindFirstChild("KickButton")
                            if (KickButton and KickButton.Visible) then
                                Net.rev_KickEvent:FireServer(1)
                            end
                            if ((hrp.Position - startPos).Magnitude > 40) then
                                wasTeleported = true
                                break
                            end
                        end
                        if not wasTeleported then return end

                        local waitSpawn = 0
                        local hasCoins = false
                        while waitSpawn < 5 do
                            task.wait(0.5)
                            waitSpawn = waitSpawn + 0.5
                            for _, v in ipairs(workspace.Debris:GetChildren()) do
                                if isBallRaritySelected(v.Name) then
                                    hasCoins = true
                                    break
                                end
                            end
                            if hasCoins then break end
                        end

                        hrp.CFrame = fixedStartCFrame + Vector3.new(0, 5, 0)
                        task.wait(0.2)

                        local collectedCoins = {}
                        while autoCollectVolcanoKamikaze and (hum.Health > 0) do
                            local nearestCoin = nil
                            local nearestDist = math.huge
                            local targetPartToTouch = nil

                            for _, obj in pairs(workspace.Debris:GetChildren()) do
                                if (isBallRaritySelected(obj.Name) and not collectedCoins[obj]) then
                                    local rootPart = obj:FindFirstChild("RootPart", true) or obj:FindFirstChild("Hitbox",
                                        true) or obj:FindFirstChildWhichIsA("BasePart", true)
                                    if rootPart then
                                        local safe1 = workspace.Lobby.Safe
                                        local safe2 = workspace.Lobby:GetChildren()[26]
                                        if ((rootPart.Position - safe1.Position).Magnitude < 70) then continue end
                                        if ((rootPart.Position - safe2.Position).Magnitude < 70) then continue end

                                        local flatHrp = Vector3.new(hrp.Position.X, 0, hrp.Position.Z)
                                        local flatRoot = Vector3.new(rootPart.Position.X, 0, rootPart.Position.Z)
                                        local dist = (flatHrp - flatRoot).Magnitude
                                        if (dist < nearestDist) then
                                            nearestDist = dist
                                            nearestCoin = obj
                                            targetPartToTouch = rootPart
                                        end
                                    end
                                end
                            end

                            if (not nearestCoin or not targetPartToTouch) then
                                task.wait(0.5)
                                break
                            end

                            local timeout = 0
                            while autoCollectVolcanoKamikaze and nearestCoin.Parent and (hum.Health > 0) and not collectedCoins[
                                nearestCoin] do
                                task.wait(0.05)
                                timeout = timeout + 0.05
                                local currentSpeed = (enableCustomSpeed and customWalkSpeed) or 50
                                pcall(function()
                                    hum.WalkSpeed = currentSpeed
                                end)
                                hum:MoveTo(targetPartToTouch.Position)

                                local flatHrp = Vector3.new(hrp.Position.X, 0, hrp.Position.Z)
                                local flatRoot = Vector3.new(targetPartToTouch.Position.X, 0, targetPartToTouch.Position.Z)
                                local currentDist = (flatHrp - flatRoot).Magnitude
                                if (currentDist <= 15) then
                                    collectedCoins[nearestCoin] = true
                                    pcall(function()
                                        if firetouchinterest then
                                            firetouchinterest(hrp, targetPartToTouch, 0)
                                            task.wait(0.01)
                                            firetouchinterest(hrp, targetPartToTouch, 1)
                                        end
                                        Net.rev_CollectShard:FireServer(nearestCoin.Name)
                                    end)
                                    break
                                end
                                if (timeout >= 1.5) then
                                    collectedCoins[nearestCoin] = true
                                    break
                                end
                            end
                        end
                    end)
                    task.wait(0.5)
                end
            end)
        end
    end)

    CreateButton(CollectTab, "Buy Speed x1 👟", function()
        Net.rev_SPEED_UPGRADE:FireServer(1)
    end)
    CreateButton(CollectTab, "Rebirth ♻️", function()
        Net.rev_RebirthRequest:FireServer()
    end)

    -- =====================================================
    -- 15. UPGRADE TAB
    -- =====================================================
    local upList = {}
    for i = 1, 30 do table.insert(upList, tostring(i)) end
    local targetUpgrade = "1"

    CreateDropdown(UpGTab, "Select UpG", upList, "UpGVal", function(val)
        targetUpgrade = val
    end)

    local autoUpSel = false
    CreateToggle(UpGTab, "Auto Upgrade Selected ⚡", "AutoUpG", function(v)
        autoUpSel = v
        if autoUpSel then
            task.spawn(function()
                while autoUpSel do
                    pcall(function()
                        Net.rev_B_Upgrade:FireServer(tonumber(targetUpgrade))
                    end)
                    task.wait(0.2)
                end
            end)
        end
    end)

    -- =====================================================
    -- 16. CONFIGS TAB (SAVE / LOAD SYSTEM)
    -- =====================================================
    local ConfigFolder = "MEKI_HUB_CONFIGS"
    pcall(function()
        if (isfolder and not isfolder(ConfigFolder)) then
            makefolder(ConfigFolder)
        elseif (makefolder and not isfolder) then
            makefolder(ConfigFolder)
        end
    end)

    local inputConfigName = ""
    local selectedConfigName = "---"

    local function GetConfigList()
        local list = {}
        if listfiles then
            pcall(function()
                for _, file in pairs(listfiles(ConfigFolder)) do
                    local fileName = file:match("([^/\\]+)%.json$")
                    if fileName then table.insert(list, fileName) end
                end
            end)
        end
        if (#list == 0) then table.insert(list, "---") end
        return list
    end

    CreateStringInput(ConfigsTab, "Config name", "Enter config name...", "UI_InputName", function(val)
        inputConfigName = val
    end)

    CreateButton(ConfigsTab, "Create config", function()
        if (inputConfigName == "") then
            print("⚠️ กรุณาใส่ชื่อ Config!")
            return
        end
        local json = HttpService:JSONEncode(CurrentConfig)
        pcall(function()
            if writefile then
                writefile(ConfigFolder .. "/" .. inputConfigName .. ".json", json)
                print("✅ สร้าง Config: " .. inputConfigName .. " สำเร็จ!")
            end
        end)
    end)

    -- Config Dropdown UI
    local ConfigDropContainer = Instance.new("Frame", ConfigsTab)
    ConfigDropContainer.Size = UDim2.new(0, 260, 0, 32)
    ConfigDropContainer.BackgroundColor3 = Theme.SurfaceLight
    ConfigDropContainer.ClipsDescendants = true
    Instance.new("UICorner", ConfigDropContainer).CornerRadius = UDim.new(0, 6)

    local ConfigMainBtn = Instance.new("TextButton", ConfigDropContainer)
    ConfigMainBtn.Size = UDim2.new(1, 0, 0, 32)
    ConfigMainBtn.BackgroundTransparency = 1
    ConfigMainBtn.Text = " Config list: --- ▼"
    ConfigMainBtn.TextColor3 = Theme.Accent
    ConfigMainBtn.Font = Enum.Font.GothamBold
    ConfigMainBtn.TextSize = 11
    ConfigMainBtn.TextXAlignment = Enum.TextXAlignment.Left

    local ConfigScroll = Instance.new("ScrollingFrame", ConfigDropContainer)
    ConfigScroll.Size = UDim2.new(1, 0, 1, -32)
    ConfigScroll.Position = UDim2.new(0, 0, 0, 32)
    ConfigScroll.BackgroundTransparency = 1
    ConfigScroll.ScrollBarThickness = 2
    ConfigScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local ConfigLayout = Instance.new("UIListLayout", ConfigScroll)
    local isDropOpen = false

    local function RefreshDropdownUI()
        for _, child in pairs(ConfigScroll:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end
        local list = GetConfigList()
        selectedConfigName = list[1] or "---"
        ConfigMainBtn.Text = " Config list: " .. selectedConfigName .. " ▼"
        for _, cfg in ipairs(list) do
            local optBtn = Instance.new("TextButton", ConfigScroll)
            optBtn.Size = UDim2.new(1, -10, 0, 30)
            optBtn.BackgroundColor3 = Theme.Surface
            optBtn.Text = " " .. cfg
            optBtn.TextColor3 = Theme.TextDim
            optBtn.Font = Enum.Font.GothamBold
            optBtn.TextSize = 11
            optBtn.TextXAlignment = Enum.TextXAlignment.Left
            optBtn.MouseButton1Click:Connect(function()
                selectedConfigName = cfg
                isDropOpen = false
                TweenService:Create(ConfigDropContainer, TweenInfo.new(0.2), {
                    Size = UDim2.new(0, 260, 0, 32)
                }):Play()
                ConfigMainBtn.Text = " Config list: " .. selectedConfigName .. " ▼"
            end)
        end
    end

    ConfigMainBtn.MouseButton1Click:Connect(function()
        isDropOpen = not isDropOpen
        local maxDropHeight = math.min(#GetConfigList() * 30, 150)
        if isDropOpen then
            RefreshDropdownUI()
            TweenService:Create(ConfigDropContainer, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 260, 0, 32 + maxDropHeight)
            }):Play()
        else
            TweenService:Create(ConfigDropContainer, TweenInfo.new(0.2), {
                Size = UDim2.new(0, 260, 0, 32)
            }):Play()
        end
    end)
    RefreshDropdownUI()

    CreateButton(ConfigsTab, "Load config", function()
        if (selectedConfigName == "---") then return end
        pcall(function()
            if isfile(ConfigFolder .. "/" .. selectedConfigName .. ".json") then
                local data = HttpService:JSONDecode(readfile(ConfigFolder .. "/" .. selectedConfigName .. ".json"))
                for key, val in pairs(data) do
                    if UIControllers[key] then
                        UIControllers[key](val)
                    end
                end
                print("✅ โหลด Config: " .. selectedConfigName .. " สำเร็จ!")
            end
        end)
    end)

    CreateButton(ConfigsTab, "Overwrite config", function()
        if (selectedConfigName ~= "---") then
            pcall(function()
                if writefile then
                    writefile(ConfigFolder .. "/" .. selectedConfigName .. ".json",
                        HttpService:JSONEncode(CurrentConfig))
                    print("💾 เซฟทับ Config สำเร็จ!")
                end
            end)
        end
    end)

    CreateButton(ConfigsTab, "Delete config", function()
        if (selectedConfigName ~= "---") then
            pcall(function()
                if (delfile and isfile(ConfigFolder .. "/" .. selectedConfigName .. ".json")) then
                    delfile(ConfigFolder .. "/" .. selectedConfigName .. ".json")
                    RefreshDropdownUI()
                end
            end)
        end
    end)

    CreateButton(ConfigsTab, "Refresh list", function()
        RefreshDropdownUI()
    end)

    CreateButton(ConfigsTab, "Set as autoload", function()
        if (selectedConfigName ~= "---") then
            pcall(function()
                if writefile then
                    writefile(ConfigFolder .. "/Autoload.txt", selectedConfigName)
                end
            end)
        end
    end)

    CreateButton(ConfigsTab, "Reset autoload", function()
        pcall(function()
            if (delfile and isfile(ConfigFolder .. "/Autoload.txt")) then
                delfile(ConfigFolder .. "/Autoload.txt")
            elseif writefile then
                writefile(ConfigFolder .. "/Autoload.txt", "")
            end
        end)
    end)

    -- Autoload on start
    task.spawn(function()
        pcall(function()
            if (isfile and isfile(ConfigFolder .. "/Autoload.txt")) then
                local autoloadName = readfile(ConfigFolder .. "/Autoload.txt")
                if ((autoloadName ~= "") and isfile(ConfigFolder .. "/" .. autoloadName .. ".json")) then
                    local data = HttpService:JSONDecode(readfile(ConfigFolder .. "/" .. autoloadName .. ".json"))
                    for key, val in pairs(data) do
                        if UIControllers[key] then
                            UIControllers[key](val)
                        end
                    end
                end
            end
        end)
    end)

    -- =====================================================
    -- 17. KICKZONE TAB (EVENT KICK WITH POWER & DIST MULTIPLIER)
    -- =====================================================
    local eventPowers = {
        Common = { 1, 3.6448693e-9 },
        Rare = { 1, 1.0934608e-7 },
        Epic = { 1, 0.0000036448694 },
        Legendary = { 0, 0.01 },
        Mythic = { 0.24994461610913277, 0.01 },
        Godly = { 1, 0.0006143887127431052 },
        Secret = { 1, 0.001917249739421627 },
        Divine = { 0.7800284549593925, 0.01 },
        Hacked = { 0.7925464622676373, 0.02 },
        OG = { 1, 0.06 },
        Celestial = { 1, 0.11024213100273421 },
        Eternal = { 1, 0.5212494498439454 }
    }

    local selectedEventRarity = "Common"
    local targetEventPets = {}
    local eventPetDropdowns = {}
    local targetEventMutations = {}
    local distMultiplier = 1

    CreateDropdown(KickZoneTab, "Select Zone & Rarity 🎯", rarities, "Event_FilterRarity", function(selectedRarity)
        selectedEventRarity = selectedRarity
        for r, container in pairs(eventPetDropdowns) do
            container.Visible = r == selectedRarity
        end
    end)

    CreateNumberPicker(KickZoneTab, "Adjust Dist (Multiplier)", 0.0001, 100, 1, "EventDist", function(v)
        distMultiplier = v
    end)

    for _, rarity in ipairs(rarities) do
        local container = Instance.new("Frame", KickZoneTab)
        container.Size = UDim2.new(0, 260, 0, 32)
        container.BackgroundTransparency = 1
        container.AutomaticSize = Enum.AutomaticSize.Y
        container.Visible = rarity == "Common"
        eventPetDropdowns[rarity] = container
        CreateSharedMultiDropdown(container, "Target KickZone Brainrots", petData[rarity],
            "Event_TargetPets_" .. rarity, "EventKickPetsSync", targetEventPets, function(sel) end)
    end

    CreateMultiDropdown(KickZoneTab, "Target KickZone Mutation", mutationList, "Event_TargetMutations", function(selected)
        targetEventMutations = selected
    end)

    local autoEventKick = false
    local eventTickID = 0
    CreateToggle(KickZoneTab, "Auto Kick (KickZone & Waves) ✨", "AutoEvent", function(v)
        autoEventKick = v
        eventTickID = eventTickID + 1
        local id = eventTickID
        if autoEventKick then
            task.spawn(function()
                while autoEventKick and (id == eventTickID) do
                    pcall(function()
                        local char = player.Character
                        local hrp = char and char:FindFirstChild("HumanoidRootPart")
                        local hum = char and char:FindFirstChild("Humanoid")
                        if not (hrp and hum and (hum.Health > 0)) then return end

                        local kickPos = workspace:FindFirstChild("Areas") and workspace.Areas:FindFirstChild("KickReady")
                        if not kickPos then return end
                        local targetCF = (kickPos:IsA("BasePart") and kickPos.CFrame) or kickPos:GetPivot()

                        if ((hrp.Position - targetCF.Position).Magnitude > 5) then
                            ForcedTP(targetCF + Vector3.new(0, 3, 0))
                        end
                        task.wait(0.5)

                        local startPos = hrp.Position
                        local wasTeleported = false
                        local HUD = PlayerGui:FindFirstChild("HUD")

                        for i = 1, 400 do
                            task.wait(0.1)
                            if (not char or not char.Parent or (hum.Health <= 0)) then return end
                            if ((hrp.Position - startPos).Magnitude > 40) then
                                wasTeleported = true
                                break
                            end
                            local KickButton = HUD and HUD:FindFirstChild("KickButton")
                            if (KickButton and KickButton.Visible) then
                                local powerArgs = eventPowers[selectedEventRarity]
                                if powerArgs then
                                    Net.rev_KickEvent:FireServer(powerArgs[1], powerArgs[2] * distMultiplier)
                                else
                                    Net.rev_KickEvent:FireServer(1)
                                end
                                task.wait(0.5)
                            end
                        end
                        if not wasTeleported then return end
                        task.wait(0.5)

                        local hasMonster = false
                        local spawnedMonster = nil
                        for i = 1, 40 do
                            task.wait(0.2)
                            local closestDist = 2000
                            for _, obj in pairs(workspace.Debris:GetChildren()) do
                                if (obj:IsA("Model") and obj.PrimaryPart) then
                                    local dist = (obj.PrimaryPart.Position - hrp.Position).Magnitude
                                    if (dist < closestDist) then
                                        closestDist = dist
                                        hasMonster = true
                                        spawnedMonster = obj
                                    end
                                end
                            end
                            if hasMonster then break end
                        end

                        if (hasMonster and spawnedMonster) then
                            task.wait(0.5)
                            local isDesiredMut = false
                            local hasMutSelection = false
                            local activeBuffs = GetPetBuffs(spawnedMonster)

                            for mut, isActive in pairs(targetEventMutations) do
                                if isActive then
                                    hasMutSelection = true
                                    if (mut == "Normal") then
                                        local hasAnyBuff = false
                                        for _, _ in pairs(activeBuffs) do
                                            hasAnyBuff = true
                                            break
                                        end
                                        if not hasAnyBuff then
                                            isDesiredMut = true
                                            break
                                        end
                                    elseif activeBuffs[mut] then
                                        isDesiredMut = true
                                        break
                                    end
                                end
                            end

                            local isDesiredName = false
                            local hasNameSelection = false
                            for petName, isActive in pairs(targetEventPets) do
                                if isActive then
                                    hasNameSelection = true
                                    if (string.lower(spawnedMonster.Name) == string.lower(petName)) then
                                        isDesiredName = true
                                        break
                                    end
                                end
                            end

                            local shouldKill = false
                            if (hasMutSelection and not isDesiredMut) then shouldKill = true end
                            if (hasNameSelection and not isDesiredName) then shouldKill = true end

                            if shouldKill then
                                local waves = workspace:FindFirstChild("Waves")
                                local wavePos = nil
                                if waves then
                                    if waves:IsA("BasePart") then
                                        wavePos = waves.Position
                                    elseif waves:IsA("Model") then
                                        wavePos = waves:GetPivot().Position
                                    else
                                        local part = waves:FindFirstChildWhichIsA("BasePart", true)
                                        if part then wavePos = part.Position end
                                    end
                                end
                                if wavePos then
                                    smoothFlyTo(hrp, hum, wavePos)
                                elseif kickPos then
                                    smoothFlyTo(hrp, hum, targetCF.Position)
                                end
                            elseif (spawnedMonster and not spawnedMonster:GetAttribute("WebhookSent")) then
                                spawnedMonster:SetAttribute("WebhookSent", true)
                                local petName = spawnedMonster.Name
                                local buffStrTbl = {}
                                for b, _ in pairs(activeBuffs) do
                                    table.insert(buffStrTbl, b)
                                end
                                local buffText = ((#buffStrTbl > 0) and table.concat(buffStrTbl, ", ")) or "Normal"
                                local petRarity = "Unknown"
                                if petData then
                                    for r, pets in pairs(petData) do
                                        for _, p in ipairs(pets) do
                                            if (string.lower(petName) == string.lower(p)) then
                                                petRarity = r
                                                break
                                            end
                                        end
                                        if (petRarity ~= "Unknown") then break end
                                    end
                                end
                                local currentAttemptCount = (sessionPetCounts[petName] or 0) + 1
                                SendDiscordWebhook("👀 KickZone Target Found!",
                                    "**Pet:** " .. petName .. "\n**Rarity:** " .. petRarity .. "\n**Mutation:** " .. buffText ..
                                    "\n**Count:** " .. currentAttemptCount .. "\n**Player:** " .. player.Name, 3447003,
                                    false)
                                if kickPos then
                                    smoothFlyTo(hrp, hum, targetCF.Position)
                                    task.wait(1.5)
                                    if (char and hum and (hum.Health > 0) and ((hrp.Position - targetCF.Position).Magnitude <
                                        20)) then
                                        sessionPetCounts[petName] = (sessionPetCounts[petName] or 0) + 1
                                        local actualCount = sessionPetCounts[petName]
                                        SendDiscordWebhook("🎉 KickZone Collected!",
                                            "**Pet:** " .. petName .. "\n**Rarity:** " .. petRarity .. "\n**Mutation:** " ..
                                            buffText .. "\n**Count:** " .. actualCount .. "\n**Player:** " .. player.Name,
                                            314153, false)
                                    end
                                end
                            elseif kickPos then
                                smoothFlyTo(hrp, hum, targetCF.Position)
                            end
                        end
                    end)
                    task.wait(0.4)
                end
            end)
        end
    end)

    -- =====================================================
    -- 18. SELL TAB
    -- =====================================================
    local targetSellPets = {}
    local sellPetDropdowns = {}
    local targetSellBuffs = {}
    local buffList = { "Normal", "Golden", "Diamond", "Plasma", "Volcanic", "Molten", "Radioactive", "Shadow",
        "Electrified", "Rainbow", "Virus", "Alien", "Block Cup", "Carnival", "Heavenly", "Void", "Bacon", "Enchanted",
        "Phantom", "Astral", "Wet" }

    CreateDropdown(SellTab, "Select Rarity", rarities, "Sell_FilterRarity", function(selectedRarity)
        for r, container in pairs(sellPetDropdowns) do
            container.Visible = r == selectedRarity
        end
    end)

    for _, rarity in ipairs(rarities) do
        local container = Instance.new("Frame", SellTab)
        container.Size = UDim2.new(0, 260, 0, 32)
        container.BackgroundTransparency = 1
        container.AutomaticSize = Enum.AutomaticSize.Y
        container.Visible = rarity == "Common"
        sellPetDropdowns[rarity] = container
        CreateSharedMultiDropdown(container, "Select Brainrots", petData[rarity], "Sell_TargetPets_" .. rarity,
            "SellPetsSync", targetSellPets, function(sel) end)
    end

    CreateMultiDropdown(SellTab, "Select Mutation", buffList, "Sell_TargetMutations", function(selected)
        targetSellBuffs = selected
    end)

    local autoSellMode = false
    CreateToggle(SellTab, "Auto Sell Selected Pets 💸", "AutoSell", function(v)
        autoSellMode = v
        if autoSellMode then
            task.spawn(function()
                while autoSellMode do
                    pcall(function()
                        local player = game:GetService("Players").LocalPlayer
                        local backpack = player:FindFirstChild("Backpack")
                        local char = player.Character
                        local hum = char and char:FindFirstChild("Humanoid")
                        if (backpack and hum) then
                            for _, item in pairs(backpack:GetChildren()) do
                                if not autoSellMode then break end
                                if (item:IsA("Tool") and targetSellPets[item.Name]) then
                                    local buffName = item:GetAttribute("Mutation") or "None"
                                    if (buffName == "None") then buffName = "Normal" end
                                    local shouldSell = false
                                    if targetSellBuffs[buffName] then shouldSell = true end
                                    if shouldSell then
                                        hum:EquipTool(item)
                                        task.wait(0.15)
                                        game:GetService("ReplicatedStorage").Shared.Packages.Network.ref_B_Sell:InvokeServer()
                                        task.wait(0.2)
                                    end
                                end
                            end
                        end
                    end)
                    task.wait(1)
                end
            end)
        end
    end)

    -- =====================================================
    -- 19. DETAILS / INFO TAB
    -- =====================================================
    local function addLabel(txt, clr)
        local l = Instance.new("TextLabel", DetailsTab)
        l.Size = UDim2.new(1, 0, 0, 25)
        l.BackgroundTransparency = 1
        l.Text = txt
        l.TextColor3 = clr
        l.Font = Enum.Font.GothamBold
        l.TextSize = 12
    end

    addLabel("🍀 Kick a Lucky Block", Theme.Success)
    addLabel("🌿 by meki", Theme.Success)
    addLabel("▶️ YouTube Mekiscripterr", Theme.Success)
    addLabel("🟢 It works", Theme.Success)

    local SettingDiv = Instance.new("Frame", DetailsTab)
    SettingDiv.Size = UDim2.new(1, 0, 0, 2)
    SettingDiv.BackgroundColor3 = Theme.SurfaceLight
    SettingDiv.BorderSizePixel = 0

    addLabel("--- Discord Webhook ---", Theme.Accent)

    CreateToggle(DetailsTab, "Enable Webhook 🔔", "EnableWebhook", function(v)
        enableWebhook = v
    end)

    CreateStringInput(DetailsTab, "Webhook URL:", "Paste URL https://discord.com...", "WebhookURL", function(val)
        webhookURL = val
    end)

    CreateButton(DetailsTab, "Test Webhook 🧪", function()
        SendDiscordWebhook("🧪 Test Notification", "Webhook system for **meki** is working perfectly!", 314153, true)
    end)

    -- =====================================================
    -- 20. FINAL ACTIVATION
    -- =====================================================
    Tabs[1].Page.Visible = true
    Tabs[1].Btn.BackgroundColor3 = Theme.Accent
    Tabs[1].Btn.TextColor3 = Color3.new(0, 0, 0)

    toggleBtn.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
    end)

end
