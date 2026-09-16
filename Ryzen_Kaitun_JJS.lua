-- Configuration & Settings
local SKILL_INTERVAL = 0.15 -- Tốc độ spam phím M1, 1, 2, 3, 4 (giây)
local G_INTERVAL = 120      -- Thời gian chờ cho phím G (120 giây = 2 phút)
local MIN_PLAYERS = 4       -- Ngưỡng người chơi tối thiểu để đổi server

-- Services
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local targetPlayer = nil

-------------------------------------------------
-- 1. UI SETUP (Stat Panel)
-------------------------------------------------
local DISPLAY_NAME = "Ryzen Kaitun | JJS"
local StatState = {
    TimePlayed = 0,
    Kills = 0,
    Money = 0,
}

local COLOR_BG        = Color3.fromRGB(15, 12, 22)
local COLOR_PANEL     = Color3.fromRGB(22, 17, 32)
local COLOR_PANEL_2   = Color3.fromRGB(28, 21, 40)
local COLOR_ACCENT    = Color3.fromRGB(150, 60, 230)
local COLOR_ACCENT_2  = Color3.fromRGB(190, 110, 255)
local COLOR_TEXT      = Color3.fromRGB(235, 230, 245)
local COLOR_SUBTEXT   = Color3.fromRGB(160, 150, 180)
local COLOR_STROKE    = Color3.fromRGB(80, 55, 120)

local function corner(inst, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius or 12)
    c.Parent = inst
    return c
end

local function stroke(inst, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color or COLOR_STROKE
    s.Thickness = thickness or 1
    s.Transparency = 0.2
    s.Parent = inst
    return s
end

local function gradient(inst, color1, color2, rotation)
    local g = Instance.new("UIGradient")
    g.Color = ColorSequence.new(color1, color2)
    g.Rotation = rotation or 90
    g.Parent = inst
    return g
end

local function formatTime(totalSeconds)
    local h = math.floor(totalSeconds / 3600)
    local m = math.floor((totalSeconds % 3600) / 60)
    local s = math.floor(totalSeconds % 60)
    if h > 0 then
        return string.format("%02dh %02dm %02ds", h, m, s)
    end
    return string.format("%02dm %02ds", m, s)
end

local function formatNumber(n)
    local formatted = tostring(math.floor(n))
    local k
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    return formatted
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KaitunBF_StatPanel"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local panel = Instance.new("Frame")
panel.Name = "Panel"
panel.Size = UDim2.new(0, 300, 0, 190)
panel.Position = UDim2.new(0, 20, 0, 20)
panel.BackgroundColor3 = COLOR_PANEL
panel.BorderSizePixel = 0
panel.Parent = screenGui
corner(panel, 16)
stroke(panel, COLOR_STROKE, 1.5)
gradient(panel, COLOR_PANEL, COLOR_BG, 80)

local accentBar = Instance.new("Frame")
accentBar.Name = "AccentBar"
accentBar.Size = UDim2.new(1, 0, 0, 4)
accentBar.BorderSizePixel = 0
accentBar.BackgroundColor3 = COLOR_ACCENT
accentBar.Parent = panel
corner(accentBar, 16)
gradient(accentBar, COLOR_ACCENT, COLOR_ACCENT_2, 0)

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, -24, 0, 64)
header.Position = UDim2.new(0, 12, 0, 14)
header.BackgroundTransparency = 1
header.Parent = panel

local avatarFrame = Instance.new("Frame")
avatarFrame.Name = "AvatarFrame"
avatarFrame.Size = UDim2.new(0, 56, 0, 56)
avatarFrame.Position = UDim2.new(0, 0, 0, 4)
avatarFrame.BackgroundColor3 = COLOR_PANEL_2
avatarFrame.Parent = header
corner(avatarFrame, 14)
stroke(avatarFrame, COLOR_ACCENT_2, 2)

local avatarImage = Instance.new("ImageLabel")
avatarImage.Name = "AvatarImage"
avatarImage.Size = UDim2.new(1, -6, 1, -6)
avatarImage.Position = UDim2.new(0, 3, 0, 3)
avatarImage.BackgroundTransparency = 1
avatarImage.Image = ""
avatarImage.Parent = avatarFrame
corner(avatarImage, 11)

pcall(function()
    avatarImage.Image = Players:GetUserThumbnailAsync(
        LocalPlayer.UserId,
        Enum.ThumbnailType.HeadShot,
        Enum.ThumbnailSize.Size180x180
    )
end)

local nameButton = Instance.new("TextButton")
nameButton.Name = "NameButton"
nameButton.Size = UDim2.new(1, -68, 0, 30)
nameButton.Position = UDim2.new(0, 68, 0, 0)
nameButton.BackgroundColor3 = COLOR_PANEL_2
nameButton.AutoButtonColor = false
nameButton.Text = DISPLAY_NAME
nameButton.TextColor3 = COLOR_TEXT
nameButton.TextSize = 15
nameButton.Font = Enum.Font.GothamBold
nameButton.TextXAlignment = Enum.TextXAlignment.Left
nameButton.TextTruncate = Enum.TextTruncate.AtEnd
nameButton.Parent = header
corner(nameButton, 8)
stroke(nameButton, COLOR_STROKE, 1)

local namePadding = Instance.new("UIPadding")
namePadding.PaddingLeft = UDim.new(0, 10)
namePadding.PaddingRight = UDim.new(0, 10)
namePadding.Parent = nameButton

nameButton.MouseButton1Click:Connect(function()
    avatarImage.Visible = not avatarImage.Visible
end)

local roleLabel = Instance.new("TextLabel")
roleLabel.Name = "RoleLabel"
roleLabel.Size = UDim2.new(1, -68, 0, 20)
roleLabel.Position = UDim2.new(0, 68, 0, 34)
roleLabel.BackgroundTransparency = 1
roleLabel.Text = "JJS Auto Farm"
roleLabel.TextColor3 = COLOR_SUBTEXT
roleLabel.TextSize = 12
roleLabel.Font = Enum.Font.Gotham
roleLabel.TextXAlignment = Enum.TextXAlignment.Left
roleLabel.Parent = header

local statsHolder = Instance.new("Frame")
statsHolder.Name = "StatsHolder"
statsHolder.Size = UDim2.new(1, -24, 0, 90)
statsHolder.Position = UDim2.new(0, 12, 0, 88)
statsHolder.BackgroundTransparency = 1
statsHolder.Parent = panel

local statsLayout = Instance.new("UIListLayout")
statsLayout.FillDirection = Enum.FillDirection.Horizontal
statsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
statsLayout.VerticalAlignment = Enum.VerticalAlignment.Center
statsLayout.Padding = UDim.new(0, 8)
statsLayout.SortOrder = Enum.SortOrder.LayoutOrder
statsLayout.Parent = statsHolder

local function createStatCard(order, iconText, labelText, valueName)
    local card = Instance.new("Frame")
    card.Name = valueName .. "Card"
    card.Size = UDim2.new(0, 90, 1, 0)
    card.BackgroundColor3 = COLOR_PANEL_2
    card.LayoutOrder = order
    card.Parent = statsHolder
    corner(card, 12)
    stroke(card, COLOR_STROKE, 1)
    gradient(card, COLOR_PANEL_2, COLOR_BG, 90)

    local icon = Instance.new("TextLabel")
    icon.Name = "Icon"
    icon.Size = UDim2.new(1, 0, 0, 26)
    icon.Position = UDim2.new(0, 0, 0, 10)
    icon.BackgroundTransparency = 1
    icon.Text = iconText
    icon.TextSize = 20
    icon.Font = Enum.Font.GothamBold
    icon.TextColor3 = COLOR_ACCENT_2
    icon.Parent = card

    local value = Instance.new("TextLabel")
    value.Name = "Value"
    value.Size = UDim2.new(1, -8, 0, 20)
    value.Position = UDim2.new(0, 4, 0, 38)
    value.BackgroundTransparency = 1
    value.Text = "0"
    value.TextSize = 15
    value.Font = Enum.Font.GothamBold
    value.TextColor3 = COLOR_TEXT
    value.TextTruncate = Enum.TextTruncate.AtEnd
    value.Parent = card

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 0, 16)
    label.Position = UDim2.new(0, 0, 0, 60)
    label.BackgroundTransparency = 1
    label.Text = labelText
    label.TextSize = 11
    label.Font = Enum.Font.Gotham
    label.TextColor3 = COLOR_SUBTEXT
    label.Parent = card

    return value
end

local timeValueLabel = createStatCard(1, "⏱", "TIME", "Time")
local killValueLabel = createStatCard(2, "☠", "KILLS", "Kill")
local moneyValueLabel = createStatCard(3, "$", "MONEY", "Money")

-- Cập nhật thông số dữ liệu UI liên tục
local leaderstats = LocalPlayer:FindFirstChild("leaderstats")

RunService.Heartbeat:Connect(function(dt)
    StatState.TimePlayed += dt

    if not leaderstats then
        leaderstats = LocalPlayer:FindFirstChild("leaderstats")
    end

    if leaderstats then
        local killsStat = leaderstats:FindFirstChild("Kills") or leaderstats:FindFirstChild("Kills ") or leaderstats:FindFirstChild("Kill")
        local moneyStat = leaderstats:FindFirstChild("Money") or leaderstats:FindFirstChild("Yen") or leaderstats:FindFirstChild("Beli") or leaderstats:FindFirstChild("Cash")
        
        if killsStat then StatState.Kills = killsStat.Value end
        if moneyStat then StatState.Money = moneyStat.Value end
    end

    timeValueLabel.Text = formatTime(StatState.TimePlayed)
    killValueLabel.Text = formatNumber(StatState.Kills)
    moneyValueLabel.Text = formatNumber(StatState.Money)
end)

-------------------------------------------------
-- 2. AUTO FARM & TARGETING LOGIC
-------------------------------------------------
local function pressKey(keyCode)
    VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
    task.wait(0.02)
    VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
end

local function getNearestPlayer()
    local nearest = nil
    local shortestDistance = math.huge
    
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local myPos = LocalPlayer.Character.HumanoidRootPart.Position

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") then
            if p.Character.Humanoid.Health > 0 then
                local dist = (p.Character.HumanoidRootPart.Position - myPos).Magnitude
                if dist < shortestDistance then
                    shortestDistance = dist
                    nearest = p
                end
            end
        end
    end
    return nearest
end

local function hopToCrowdedServer()
    local placeId = game.PlaceId
    local servers = {}
    local req = request or http_request or (syn and syn.request)
    
    if req then
        local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/0?sortOrder=Desc&limit=100"
        local success, result = pcall(function() return HttpService:JSONDecode(req({Url = url}).Body) end)
        
        if success and result and result.data then
            for _, v in ipairs(result.data) do
                if type(v) == "table" and v.playing and v.maxPlayers and v.playing < v.maxPlayers and v.id ~= game.JobId then
                    table.insert(servers, v)
                end
            end
        end
    end

    if #servers > 0 then
        table.sort(servers, function(a, b) return a.playing > b.playing end)
        TeleportService:TeleportToPlaceInstance(placeId, servers[1].id, LocalPlayer)
    else
        TeleportService:Teleport(placeId, LocalPlayer)
    end
end

-- Task 1: Tự động quét và hop server khi ít người
task.spawn(function()
    while task.wait(5) do
        if #Players:GetPlayers() <= MIN_PLAYERS then
            hopToCrowdedServer()
            break
        end
    end
end)

-- Task 2: Lock 99% đằng sau lưng mục tiêu
RunService.Heartbeat:Connect(function()
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then return end
    
    if not targetPlayer or not targetPlayer.Parent or not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("Humanoid") or targetPlayer.Character.Humanoid.Health <= 0 then
        targetPlayer = getNearestPlayer()
    end

    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetRoot = targetPlayer.Character.HumanoidRootPart
        LocalPlayer.Character.HumanoidRootPart.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
    end
end)

-- Task 3: Auto Spam Skill M1, 1, 2, 3, 4
task.spawn(function()
    local attackKeys = {
        Enum.KeyCode.Button1,
        Enum.KeyCode.One,
        Enum.KeyCode.Two,
        Enum.KeyCode.Three,
        Enum.KeyCode.Four
    }
    
    while task.wait(SKILL_INTERVAL) do
        if targetPlayer then
            for _, key in ipairs(attackKeys) do
                pressKey(key)
                task.wait(0.02)
            end
        end
    end
end)

-- Task 4: Auto phím G mỗi 2 phút
task.spawn(function()
    while true do
        task.wait(G_INTERVAL)
        if targetPlayer then
            pressKey(Enum.KeyCode.G)
        end
    end
end)
