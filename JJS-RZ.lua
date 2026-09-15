-- Roblox Lua Script: Auto Kill + Lock Behind Back + GUI Menu

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")

-- Trạng thái điều khiển
local autoKillNearest = false
local autoKillSelected = false
local selectedPlayerName = nil

local currentTarget = nil
local lockDistance = 2.5 -- Khoảng cách bám sau lưng (ngắn để tối ưu trúng skill)

----------------------------------------------------------------
-- HÀM HỖ TRỢ & XỬ LÝ
----------------------------------------------------------------

-- Hàm giả lập bấm phím M1 và Skill 1, 2, 3, 4
local function spamSkills()
    -- Click M1
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
    task.wait(0.03)
    VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    
    -- Spam Chiêu 1, 2, 3, 4
    local keys = {Enum.KeyCode.One, Enum.KeyCode.Two, Enum.KeyCode.Three, Enum.KeyCode.Four}
    for _, key in ipairs(keys) do
        VirtualInputManager:SendKeyEvent(true, key, false, game)
        task.wait(0.01)
        VirtualInputManager:SendKeyEvent(false, key, false, game)
    end
end

-- Tìm player gần nhất còn sống
local function getNearestPlayer()
    local nearest = nil
    local shortestDist = math.huge
    local myChar = LocalPlayer.Character
    
    if myChar and myChar:FindFirstChild("HumanoidRootPart") then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hum = p.Character:FindFirstChild("Humanoid")
                if hum and hum.Health > 0 then
                    local dist = (myChar.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if dist < shortestDist then
                        shortestDist = dist
                        nearest = p
                    end
                end
            end
        end
    end
    return nearest
end

----------------------------------------------------------------
-- VÒNG LẶP LOCK SAU LƯNG (CẬP NHẬT THEO KHUNG HÌNH)
----------------------------------------------------------------
RunService.RenderStepped:Connect(function()
    if (autoKillNearest or autoKillSelected) and currentTarget and currentTarget.Character then
        local myChar = LocalPlayer.Character
        local targetChar = currentTarget.Character
        
        local myHRP = myChar and myChar:FindFirstChild("HumanoidRootPart")
        local targetHRP = targetChar:FindFirstChild("HumanoidRootPart")
        local targetHum = targetChar:FindFirstChild("Humanoid")
        
        -- Kiểm tra nếu mục tiêu còn sống
        if myHRP and targetHRP and targetHum and targetHum.Health > 0 then
            -- Tính toán tọa độ ngay sau lưng đối thủ và hướng mặt vào họ
            local behindCFrame = targetHRP.CFrame * CFrame.new(0, 0, lockDistance)
            myHRP.CFrame = CFrame.new(behindCFrame.Position, targetHRP.Position)
            
            -- Thực hiện spam chiêu thức
            spamSkills()
        else
            -- Đặt lại mục tiêu nếu họ đã chết
            currentTarget = nil
        end
    end
end)

-- Vòng lặp quét mục tiêu liên tục
task.spawn(function()
    while task.wait(0.1) do
        if autoKillNearest then
            if not currentTarget or not currentTarget.Character or not currentTarget.Character:FindFirstChild("Humanoid") or currentTarget.Character.Humanoid.Health <= 0 then
                currentTarget = getNearestPlayer()
            end
        elseif autoKillSelected and selectedPlayerName then
            local p = Players:FindFirstChild(selectedPlayerName)
            if p and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                currentTarget = p
            else
                currentTarget = nil
            end
        else
            currentTarget = nil
        end
    end
end)

----------------------------------------------------------------
-- GIAO DIỆN (GUI MENU)
----------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "LockAutoKillMenu"
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 230, 0, 260)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "AUTO KILL (LOCK BACK)"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 16

-- Nút Auto Kill Gần Nhất
local BtnNear = Instance.new("TextButton", MainFrame)
BtnNear.Size = UDim2.new(0.9, 0, 0, 35)
BtnNear.Position = UDim2.new(0.05, 0, 0.18, 0)
BtnNear.Text = "Auto Kill Gần Nhất: OFF"
BtnNear.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
BtnNear.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnNear.Font = Enum.Font.SourceSans

BtnNear.MouseButton1Click:Connect(function()
    autoKillNearest = not autoKillNearest
    if autoKillNearest then autoKillSelected = false end
    currentTarget = nil
    BtnNear.Text = "Auto Kill Gần Nhất: " .. (autoKillNearest and "ON" or "OFF")
    BtnNear.BackgroundColor3 = autoKillNearest and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
end)

-- Ô chọn Player trong Server
local Dropdown = Instance.new("TextButton", MainFrame)
Dropdown.Size = UDim2.new(0.9, 0, 0, 35)
Dropdown.Position = UDim2.new(0.05, 0, 0.35, 0)
Dropdown.Text = "Chọn Player: [Chưa chọn]"
Dropdown.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
Dropdown.Font = Enum.Font.SourceSans

local playerIndex = 1
Dropdown.MouseButton1Click:Connect(function()
    local plist = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(plist, p.Name) end
    end
    if #plist > 0 then
        playerIndex = (playerIndex % #plist) + 1
        selectedPlayerName = plist[playerIndex]
        Dropdown.Text = "Chọn: " .. selectedPlayerName
    else
        Dropdown.Text = "Không có player khác"
    end
end)

-- Nút Auto Kill Player Đã Chọn
local BtnSelect = Instance.new("TextButton", MainFrame)
BtnSelect.Size = UDim2.new(0.9, 0, 0, 35)
BtnSelect.Position = UDim2.new(0.05, 0, 0.52, 0)
BtnSelect.Text = "Auto Kill Đã Chọn: OFF"
BtnSelect.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
BtnSelect.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnSelect.Font = Enum.Font.SourceSans

BtnSelect.MouseButton1Click:Connect(function()
    if not selectedPlayerName then return end
    autoKillSelected = not autoKillSelected
    if autoKillSelected then autoKillNearest = false end
    currentTarget = nil
    BtnSelect.Text = "Auto Kill Đã Chọn: " .. (autoKillSelected and "ON" or "OFF")
    BtnSelect.BackgroundColor3 = autoKillSelected and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(180, 50, 50)
end)

-- Nút Hop Server
local BtnHop = Instance.new("TextButton", MainFrame)
BtnHop.Size = UDim2.new(0.9, 0, 0, 35)
BtnHop.Position = UDim2.new(0.05, 0, 0.78, 0)
BtnHop.Text = "Hop Server"
BtnHop.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
BtnHop.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnHop.Font = Enum.Font.SourceSansBold

BtnHop.MouseButton1Click:Connect(function()
    BtnHop.Text = "Đang đổi server..."
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)
