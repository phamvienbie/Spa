-- Load Fluent UI & Addons
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/Beta.lua"))()[cite: 2]
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()[cite: 2]
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()[cite: 2]

-- Window Setup
local Window = Fluent:CreateWindow({
    Title = "Blox Fruits - Boat Fly UI",
    SubTitle = "by dawid & integrated",
    Search = true,
    Icon = "ship",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl,
    UserInfo = true,
    UserInfoTop = false,
    UserInfoTitle = game:GetService("Players").LocalPlayer.DisplayName,[cite: 2]
    UserInfoSubtitle = "User",[cite: 2]
    UserInfoSubtitleColor = Color3.fromRGB(71, 123, 255)[cite: 2]
})

local Tabs = {
    Main = Window:AddTab({ Title = "Boat Fly", Icon = "navigation" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })[cite: 2]
}

local Options = Fluent.Options[cite: 2]

--------------------------------------------------
-- LOGIC BOAT FLY CONFIG
--------------------------------------------------
getgenv().BoatFly = getgenv().BoatFly or {[cite: 1]
    Enabled = true,[cite: 1]
    Speed = 150,[cite: 1]
    Height = 15,[cite: 1]
    HighHeight = 300,[cite: 1]
    HighDistance = 250,[cite: 1]

    -- Auto Dodge
    DodgeEnabled = true,[cite: 1]
    DodgeDistance = 180,[cite: 1]
    DodgeRadius = 12,[cite: 1]
    DodgeCooldown = 2,[cite: 1]

    VerticalSpeed = 100,[cite: 1]

    Direction = Vector3.new(-0.99102227, 0, -0.13369414),[cite: 1]
    AutoFindBoat = true,[cite: 1]
    AutoSit = true[cite: 1]
}

local Config = getgenv().BoatFly[cite: 1]

--------------------------------------------------
-- UI CONTROLS (TÍCH HỢP UI)
--------------------------------------------------
do
    local MainSection = Tabs.Main:AddSection("Thuyền & Bay", "ship")

    local ToggleFly = Tabs.Main:AddToggle("BoatFlyEnabled", { Title = "Bật Boat Fly", Default = Config.Enabled })
    ToggleFly:OnChanged(function(Value)
        Config.Enabled = Value
    end)

    local ToggleAutoFind = Tabs.Main:AddToggle("AutoFindBoat", { Title = "Tự Tìm & Ngồi Thuyền", Default = Config.AutoFindBoat })
    ToggleAutoFind:OnChanged(function(Value)
        Config.AutoFindBoat = Value
    end)

    Tabs.Main:AddSlider("SpeedSlider", {
        Title = "Tốc độ bay",
        Min = 50,
        Max = 500,
        Default = Config.Speed,
        Rounding = 0,
        Callback = function(Value)
            Config.Speed = Value
        end
    })

    Tabs.Main:AddSlider("HeightSlider", {
        Title = "Chiều cao bình thường",
        Min = 5,
        Max = 100,
        Default = Config.Height,
        Rounding = 0,
        Callback = function(Value)
            Config.Height = Value
        end
    })

    local DodgeSection = Tabs.Main:AddSection("Né Vật Cản (Auto Dodge)", "shield-alert")

    local ToggleDodge = Tabs.Main:AddToggle("DodgeEnabled", { Title = "Bật Auto Dodge", Default = Config.DodgeEnabled })
    ToggleDodge:OnChanged(function(Value)
        Config.DodgeEnabled = Value
    end)

    Tabs.Main:AddSlider("HighHeightSlider", {
        Title = "Chiều cao bay né (Studs)",
        Min = 100,
        Max = 500,
        Default = Config.HighHeight,
        Rounding = 0,
        Callback = function(Value)
            Config.HighHeight = Value
        end
    })

    Tabs.Main:AddSlider("DodgeDistSlider", {
        Title = "Khoảng cách phát hiện vật cản",
        Min = 50,
        Max = 400,
        Default = Config.DodgeDistance,
        Rounding = 0,
        Callback = function(Value)
            Config.DodgeDistance = Value
        end
    })
end

--------------------------------------------------
-- GAME SERVICES & VARIABLES
--------------------------------------------------
local Players = game:GetService("Players")[cite: 1]
local RunService = game:GetService("RunService")[cite: 1]
local Workspace = game:GetService("Workspace")[cite: 1]

local Player = Players.LocalPlayer[cite: 1]

local Boat = nil[cite: 1]
local Seat = nil[cite: 1]

local StartY = nil[cite: 1]
local HighY = nil[cite: 1]

local Phase = 0[cite: 1]
local HighStartPosition = nil[cite: 1]

local LastDodge = 0[cite: 1]
local DodgeDirection = nil[cite: 1]

local Connection = nil[cite: 1]

--------------------------------------------------
-- HELPER FUNCTIONS
--------------------------------------------------
local function GetCharacter()
    return Player.Character or Player.CharacterAdded:Wait()[cite: 1]
end

local function GetHumanoid()
    local Character = GetCharacter()[cite: 1]
    return Character:FindFirstChildOfClass("Humanoid")[cite: 1]
end

local function FindSeat(Model)
    if not Model then return nil end[cite: 1]
    local VehicleSeat = Model:FindFirstChildWhichIsA("VehicleSeat", true)[cite: 1]
    if VehicleSeat then return VehicleSeat end[cite: 1]
    return Model:FindFirstChildWhichIsA("Seat", true)[cite: 1]
end

local function FindBoat()
    local BoatsFolder = Workspace:FindFirstChild("Boats")[cite: 1]
    if not BoatsFolder then return nil, nil end[cite: 1]

    local Character = GetCharacter()[cite: 1]
    local HRP = Character:FindFirstChild("HumanoidRootPart")[cite: 1]
    if not HRP then return nil, nil end[cite: 1]

    local NearestBoat, NearestSeat = nil, nil
    local NearestDistance = math.huge[cite: 1]

    for _, BoatModel in ipairs(BoatsFolder:GetChildren()) do[cite: 1]
        if BoatModel:IsA("Model") then[cite: 1]
            local BoatSeat = FindSeat(BoatModel)[cite: 1]
            if BoatSeat then[cite: 1]
                local Distance = (BoatSeat.Position - HRP.Position).Magnitude[cite: 1]
                if Distance < NearestDistance then[cite: 1]
                    if not BoatSeat.Occupant then[cite: 1]
                        NearestDistance = Distance[cite: 1]
                        NearestBoat = BoatModel[cite: 1]
                        NearestSeat = BoatSeat[cite: 1]
                    end
                end
            end
        end
    end
    return NearestBoat, NearestSeat[cite: 1]
end

local function ResetFlight()
    StartY = nil[cite: 1]
    HighY = nil[cite: 1]
    Phase = 0[cite: 1]
    HighStartPosition = nil[cite: 1]
    DodgeDirection = nil[cite: 1]
end

local function GetBoatPosition()
    if not Boat or not Boat.Parent then return nil end[cite: 1]
    if Boat.PrimaryPart then return Boat.PrimaryPart.Position end[cite: 1]
    if Seat and Seat.Parent then return Seat.Position end[cite: 1]
    return nil[cite: 1]
end

local function GetDirection()
    local Direction = Config.Direction[cite: 1]
    Direction = Vector3.new(Direction.X, 0, Direction.Z)[cite: 1]
    if Direction.Magnitude <= 0 then return nil end[cite: 1]
    return Direction.Unit[cite: 1]
end

--------------------------------------------------
-- AUTO DODGE
--------------------------------------------------
local function IsIgnoredHit(Instance)
    if not Instance then return true end[cite: 1]
    if Boat and (Instance == Boat or Instance:IsDescendantOf(Boat)) then return true end[cite: 1]
    local Character = Player.Character[cite: 1]
    if Character and (Instance == Character or Instance:IsDescendantOf(Character)) then return true end[cite: 1]
    return false[cite: 1]
end

local function DetectObstacle(Position, Direction)
    if not Config.DodgeEnabled then return false end[cite: 1]
    if os.clock() - LastDodge < Config.DodgeCooldown then return false end[cite: 1]
    if Phase ~= 4 then return false end[cite: 1]

    local Params = RaycastParams.new()[cite: 1]
    Params.FilterType = Enum.RaycastFilterType.Exclude[cite: 1]
    Params.FilterDescendantsInstances = { Boat, Player.Character }[cite: 1]
    Params.IgnoreWater = true[cite: 1]

    local Result = Workspace:Spherecast([cite: 1]
        Position + Vector3.new(0, 6, 0),[cite: 1]
        Config.DodgeRadius,[cite: 1]
        Direction * Config.DodgeDistance,[cite: 1]
        Params[cite: 1]
    )

    if not Result or not Result.Instance then return false end[cite: 1]
    if IsIgnoredHit(Result.Instance) then return false end[cite: 1]
    if Result.Material == Enum.Material.Water then return false end[cite: 1]

    LastDodge = os.clock()[cite: 1]
    return true[cite: 1]
end

local function BeginDodge(Position)
    StartY = Position.Y - Config.Height[cite: 1]
    HighY = StartY + Config.HighHeight[cite: 1]
    HighStartPosition = nil[cite: 1]
    DodgeDirection = GetDirection()[cite: 1]
    Phase = 1[cite: 1]
end

--------------------------------------------------
-- BOAT MOVEMENT
--------------------------------------------------
local function MoveBoat(Position, Direction)
    if not Boat or not Boat.Parent then return end[cite: 1]
    local TargetCFrame = CFrame.lookAt(Position, Position + Direction, Vector3.yAxis)[cite: 1]

    if Boat.PrimaryPart then[cite: 1]
        Boat:PivotTo(TargetCFrame)[cite: 1]
    elseif Seat and Seat.Parent then[cite: 1]
        Seat.CFrame = TargetCFrame[cite: 1]
    end
end

local function StartFlightFromCurrentPosition()
    if not Boat or not Seat or not Boat.Parent or not Seat.Parent then return end[cite: 1]
    local Position = GetBoatPosition()[cite: 1]
    if not Position then return end[cite: 1]

    if not StartY then[cite: 1]
        StartY = Position.Y[cite: 1]
        HighY = StartY + Config.HighHeight[cite: 1]
        Phase = 4[cite: 1]
        HighStartPosition = nil[cite: 1]
    elseif Phase == 0 then[cite: 1]
        Phase = 4[cite: 1]
    end
end

local function SitBoat()
    if not Config.AutoFindBoat then return end[cite: 1]
    if Boat and Boat.Parent and Seat and Seat.Parent then return end[cite: 1]

    local NewBoat, NewSeat = FindBoat()[cite: 1]
    if not NewBoat or not NewSeat then return end[cite: 1]

    Boat = NewBoat[cite: 1]
    Seat = NewSeat[cite: 1]

    local Humanoid = GetHumanoid()[cite: 1]
    if not Humanoid then return end[cite: 1]

    Seat:Sit(Humanoid)[cite: 1]

    task.spawn(function()
        for _ = 1, 20 do[cite: 1]
            if not Boat or not Boat.Parent or not Seat or not Seat.Parent then return end[cite: 1]
            if Seat.Occupant == Humanoid then[cite: 1]
                StartFlightFromCurrentPosition()[cite: 1]
                return
            end
            task.wait(0.03)[cite: 1]
        end
    end)
end

local function MoveTowardY(CurrentY, TargetY, dt)
    local Difference = TargetY - CurrentY[cite: 1]
    local Step = Config.VerticalSpeed * dt[cite: 1]

    if math.abs(Difference) <= Step then
        return TargetY, true[cite: 1]
    end

    if Difference > 0 then
        return CurrentY + Step, false[cite: 1]
    else
        return CurrentY - Step, false[cite: 1]
    end
end

--------------------------------------------------
-- FLY ENGINE LOOP
--------------------------------------------------
local function StartBoatFly()
    if Connection then Connection:Disconnect() end[cite: 1]

    Connection = RunService.Heartbeat:Connect(function(dt)
        if not Config.Enabled then return end[cite: 1]

        if not Boat or not Boat.Parent or not Seat or not Seat.Parent then[cite: 1]
            Boat = nil[cite: 1]
            Seat = nil[cite: 1]
            ResetFlight()[cite: 1]
            SitBoat()[cite: 1]
            return
        end

        local Humanoid = GetHumanoid()[cite: 1]
        if not Humanoid or Seat.Occupant ~= Humanoid then return end[cite: 1]

        if not StartY then
            StartFlightFromCurrentPosition()[cite: 1]
        end

        local Position = GetBoatPosition()[cite: 1]
        local Direction = GetDirection()[cite: 1]
        if not Position or not Direction then return end[cite: 1]

        -- Phase 4: Normal Flight
        if Phase == 4 then[cite: 1]
            if DetectObstacle(Position, Direction) then[cite: 1]
                BeginDodge(Position)[cite: 1]
                return
            end

            local NewPosition = Position + Direction * Config.Speed * dt[cite: 1]
            NewPosition = Vector3.new(NewPosition.X, StartY + Config.Height, NewPosition.Z)[cite: 1]
            MoveBoat(NewPosition, Direction)[cite: 1]
            return
        end

        -- Phase 1: Dodge Upward
        if Phase == 1 then[cite: 1]
            local NewY, Finished = MoveTowardY(Position.Y, HighY, dt)[cite: 1]
            local NewPosition = Vector3.new(Position.X, NewY, Position.Z)[cite: 1]
            MoveBoat(NewPosition, Direction)[cite: 1]

            if Finished then[cite: 1]
                Phase = 2[cite: 1]
                HighStartPosition = Vector3.new(NewPosition.X, HighY, NewPosition.Z)[cite: 1]
            end
            return
        end

        -- Phase 2: High Cruise
        if Phase == 2 then[cite: 1]
            local NewPosition = Position + Direction * Config.Speed * dt[cite: 1]
            NewPosition = Vector3.new(NewPosition.X, HighY, NewPosition.Z)[cite: 1]
            MoveBoat(NewPosition, Direction)[cite: 1]

            if HighStartPosition then[cite: 1]
                local Distance = (Vector3.new(NewPosition.X, 0, NewPosition.Z) - Vector3.new(HighStartPosition.X, 0, HighStartPosition.Z)).Magnitude[cite: 1]
                if Distance >= Config.HighDistance then[cite: 1]
                    Phase = 3[cite: 1]
                end
            end
            return
        end

        -- Phase 3: Descend Back
        if Phase == 3 then[cite: 1]
            local TargetY = StartY + Config.Height[cite: 1]
            local NewY, Finished = MoveTowardY(Position.Y, TargetY, dt)[cite: 1]
            local NewPosition = Position + Direction * Config.Speed * dt[cite: 1]
            NewPosition = Vector3.new(NewPosition.X, NewY, NewPosition.Z)[cite: 1]

            MoveBoat(NewPosition, Direction)[cite: 1]
            if Finished then Phase = 4 end[cite: 1]
            return
        end
    end)
end

--------------------------------------------------
-- INITIALIZATION & RESPAWN
--------------------------------------------------
Player.CharacterAdded:Connect(function()
    task.wait(0.5)[cite: 1]
    Boat = nil[cite: 1]
    Seat = nil[cite: 1]
    ResetFlight()[cite: 1]
    if Config.Enabled then SitBoat() end[cite: 1]
end)

task.spawn(function()
    while true do
        if Config.Enabled and (not Boat or not Boat.Parent) then
            SitBoat()[cite: 1]
        end
        task.wait(0.5)
    end
end)

StartBoatFly()[cite: 1]

-- Interface & Config Save Manager Setup
SaveManager:SetLibrary(Fluent)[cite: 2]
InterfaceManager:SetLibrary(Fluent)[cite: 2]
SaveManager:IgnoreThemeSettings()[cite: 2]
SaveManager:SetIgnoreIndexes({})[cite: 2]

InterfaceManager:SetFolder("FluentScriptHub")[cite: 2]
SaveManager:SetFolder("FluentScriptHub/blox-fruits")[cite: 2]

InterfaceManager:BuildInterfaceSection(Tabs.Settings)[cite: 2]
SaveManager:BuildConfigSection(Tabs.Settings)[cite: 2]

Window:SelectTab(1)[cite: 2]

Fluent:Notify({
    Title = "Boat Fly UI Loaded",
    Content = "Đã tích hợp thành công Boat Fly vào Fluent UI!",
    Duration = 5
})
