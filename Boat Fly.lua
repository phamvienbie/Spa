--// Blox Fruits Boat Fly
--// Auto Find + Auto Sit + Fly Direction

getgenv().BoatFly = getgenv().BoatFly or {
    Enabled = true,

    Speed = 150,

    -- Nâng 15 studs
    Height = 15,

    -- Hướng bay lấy từ tọa độ bạn gửi
    Direction = Vector3.new(
        -0.99102227,
        0,
        -0.13369414
    ),

    AutoFindBoat = true,
    AutoSit = true
}

local Config = getgenv().BoatFly

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer

local Boat = nil
local Seat = nil

local StartY = nil
local Connection = nil

--------------------------------------------------
-- CHARACTER
--------------------------------------------------

local function GetCharacter()
    return Player.Character or Player.CharacterAdded:Wait()
end

local function GetHumanoid()
    local Character = GetCharacter()
    return Character:FindFirstChildOfClass("Humanoid")
end

--------------------------------------------------
-- FIND SEAT
--------------------------------------------------

local function FindSeat(Model)
    if not Model then
        return nil
    end

    -- Ưu tiên VehicleSeat
    local VehicleSeat = Model:FindFirstChildWhichIsA(
        "VehicleSeat",
        true
    )

    if VehicleSeat then
        return VehicleSeat
    end

    -- Một số thuyền có Seat
    local SeatObject = Model:FindFirstChildWhichIsA(
        "Seat",
        true
    )

    return SeatObject
end

--------------------------------------------------
-- FIND BOAT
--------------------------------------------------

local function FindBoat()
    local BoatsFolder = Workspace:FindFirstChild("Boats")

    if not BoatsFolder then
        return nil, nil
    end

    local Character = GetCharacter()
    local HRP = Character:FindFirstChild("HumanoidRootPart")

    if not HRP then
        return nil, nil
    end

    local NearestBoat = nil
    local NearestSeat = nil
    local NearestDistance = math.huge

    for _, BoatModel in ipairs(BoatsFolder:GetChildren()) do

        if BoatModel:IsA("Model") then

            local BoatSeat = FindSeat(BoatModel)

            if BoatSeat then

                local Distance =
                    (BoatSeat.Position - HRP.Position).Magnitude

                if Distance < NearestDistance then

                    -- Nếu ghế chưa có người
                    if not BoatSeat.Occupant then
                        NearestDistance = Distance
                        NearestBoat = BoatModel
                        NearestSeat = BoatSeat
                    end

                end
            end
        end
    end

    return NearestBoat, NearestSeat
end

--------------------------------------------------
-- SIT
--------------------------------------------------

local function SitBoat()
    if not Config.AutoFindBoat then
        return
    end

    if Boat and Boat.Parent and Seat and Seat.Parent then
        return
    end

    Boat, Seat = FindBoat()

    if not Boat or not Seat then
        return
    end

    local Character = GetCharacter()
    local Humanoid = GetHumanoid()

    if not Humanoid then
        return
    end

    ------------------------------------------------
    -- Đưa nhân vật tới ghế
    ------------------------------------------------

    Character:PivotTo(
        Seat.CFrame * CFrame.new(0, 2, 0)
    )

    task.wait(0.15)

    ------------------------------------------------
    -- Ngồi
    ------------------------------------------------

    if Seat:IsA("VehicleSeat") or Seat:IsA("Seat") then
        Seat:Sit(Humanoid)
    end

    task.wait(0.3)

    ------------------------------------------------
    -- Lưu độ cao ban đầu + 15
    ------------------------------------------------

    if Boat.PrimaryPart then
        StartY = Boat.PrimaryPart.Position.Y + Config.Height
    else
        StartY = Seat.Position.Y + Config.Height
    end
end

--------------------------------------------------
-- GET BOAT POSITION
--------------------------------------------------

local function GetBoatPosition()
    if not Boat or not Boat.Parent then
        return nil
    end

    if Boat.PrimaryPart then
        return Boat.PrimaryPart.Position
    end

    if Seat and Seat.Parent then
        return Seat.Position
    end

    return nil
end

--------------------------------------------------
-- BOAT FLY
--------------------------------------------------

local function StartBoatFly()

    if Connection then
        Connection:Disconnect()
        Connection = nil
    end

    Connection = RunService.Heartbeat:Connect(function(dt)

        if not Config.Enabled then
            return
        end

        ------------------------------------------------
        -- Kiểm tra boat
        ------------------------------------------------

        if not Boat
            or not Boat.Parent
            or not Seat
            or not Seat.Parent then

            Boat = nil
            Seat = nil
            StartY = nil

            if Config.AutoFindBoat then
                SitBoat()
            end

            return
        end

        ------------------------------------------------
        -- Nếu chưa ngồi
        ------------------------------------------------

        local Humanoid = GetHumanoid()

        if Config.AutoSit
            and Humanoid
            and Seat.Occupant ~= Humanoid then

            Seat:Sit(Humanoid)

        end

        ------------------------------------------------
        -- Lấy vị trí
        ------------------------------------------------

        local Position = GetBoatPosition()

        if not Position then
            return
        end

        ------------------------------------------------
        -- Chuẩn hóa hướng
        ------------------------------------------------

        local Direction = Config.Direction

        Direction = Vector3.new(
            Direction.X,
            0,
            Direction.Z
        )

        if Direction.Magnitude <= 0 then
            return
        end

        Direction = Direction.Unit

        ------------------------------------------------
        -- Giữ Y = vị trí ban đầu + 15
        ------------------------------------------------

        if not StartY then
            StartY = Position.Y + Config.Height
        end

        ------------------------------------------------
        -- Di chuyển
        ------------------------------------------------

        local NewPosition =
            Position
            + (Direction * Config.Speed * dt)

        NewPosition = Vector3.new(
            NewPosition.X,
            StartY,
            NewPosition.Z
        )

        ------------------------------------------------
        -- Luôn quay đúng hướng
        ------------------------------------------------

        local NewCFrame = CFrame.lookAt(
            NewPosition,
            NewPosition + Direction,
            Vector3.yAxis
        )

        ------------------------------------------------
        -- Move toàn bộ Model
        ------------------------------------------------

        if Boat.PrimaryPart then
            Boat:PivotTo(NewCFrame)
        else
            Seat.CFrame = NewCFrame
        end
    end)
end

--------------------------------------------------
-- CHARACTER RESPAWN
--------------------------------------------------

Player.CharacterAdded:Connect(function()
    task.wait(1)

    Boat = nil
    Seat = nil
    StartY = nil

    if Config.Enabled then
        SitBoat()
    end
end)

--------------------------------------------------
-- START
--------------------------------------------------

task.spawn(function()

    while Config.Enabled do

        if not Boat or not Boat.Parent then
            SitBoat()
        end

        task.wait(1)
    end

end)

StartBoatFly()

print("Boat Fly Loaded")
print("Direction:", Config.Direction)
print("Height:", Config.Height)
print("Speed:", Config.Speed)
