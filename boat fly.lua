--// Blox Fruits Boat Fly - Smooth Start
--// Sit -> Fly immediately
--// No extra teleport / no unnecessary waiting
--// Jump off = Pause
--// Sit back = Resume

getgenv().BoatFly = getgenv().BoatFly or {
    Enabled = true,

    Speed = 150,

    Height = 15,

    HighHeight = 300,

    HighDistance = 250,

    VerticalSpeed = 100,

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
local HighY = nil

local Phase = 0
local HighStartPosition = nil

local Connection = nil


--------------------------------------------------
-- CHARACTER
--------------------------------------------------

local function GetCharacter()
    return Player.Character
        or Player.CharacterAdded:Wait()
end

local function GetHumanoid()
    local Character = GetCharacter()

    return Character:FindFirstChildOfClass(
        "Humanoid"
    )
end


--------------------------------------------------
-- FIND SEAT
--------------------------------------------------

local function FindSeat(Model)

    if not Model then
        return nil
    end

    local VehicleSeat =
        Model:FindFirstChildWhichIsA(
            "VehicleSeat",
            true
        )

    if VehicleSeat then
        return VehicleSeat
    end

    return Model:FindFirstChildWhichIsA(
        "Seat",
        true
    )
end


--------------------------------------------------
-- FIND BOAT
--------------------------------------------------

local function FindBoat()

    local BoatsFolder =
        Workspace:FindFirstChild("Boats")

    if not BoatsFolder then
        return nil, nil
    end

    local Character = GetCharacter()

    local HRP =
        Character:FindFirstChild(
            "HumanoidRootPart"
        )

    if not HRP then
        return nil, nil
    end

    local NearestBoat = nil
    local NearestSeat = nil
    local NearestDistance = math.huge

    for _, BoatModel in
        ipairs(BoatsFolder:GetChildren()) do

        if BoatModel:IsA("Model") then

            local BoatSeat =
                FindSeat(BoatModel)

            if BoatSeat then

                local Distance =
                    (
                        BoatSeat.Position
                        - HRP.Position
                    ).Magnitude

                if Distance < NearestDistance then

                    if not BoatSeat.Occupant then

                        NearestDistance =
                            Distance

                        NearestBoat =
                            BoatModel

                        NearestSeat =
                            BoatSeat
                    end
                end
            end
        end
    end

    return NearestBoat, NearestSeat
end


--------------------------------------------------
-- RESET
--------------------------------------------------

local function ResetFlight()

    StartY = nil
    HighY = nil

    Phase = 0

    HighStartPosition = nil
end


--------------------------------------------------
-- GET POSITION
--------------------------------------------------

local function GetBoatPosition()

    if not Boat
        or not Boat.Parent then
        return nil
    end

    if Boat.PrimaryPart then
        return Boat.PrimaryPart.Position
    end

    if Seat
        and Seat.Parent then
        return Seat.Position
    end

    return nil
end


--------------------------------------------------
-- DIRECTION
--------------------------------------------------

local function GetDirection()

    local Direction =
        Config.Direction

    Direction = Vector3.new(
        Direction.X,
        0,
        Direction.Z
    )

    if Direction.Magnitude <= 0 then
        return nil
    end

    return Direction.Unit
end


--------------------------------------------------
-- MOVE BOAT
--------------------------------------------------

local function MoveBoat(
    Position,
    Direction
)

    if not Boat
        or not Boat.Parent then
        return
    end

    local TargetCFrame =
        CFrame.lookAt(
            Position,
            Position + Direction,
            Vector3.yAxis
        )

    if Boat.PrimaryPart then

        Boat:PivotTo(
            TargetCFrame
        )

    elseif Seat
        and Seat.Parent then

        Seat.CFrame =
            TargetCFrame
    end
end


--------------------------------------------------
-- START FLIGHT FROM CURRENT POSITION
--------------------------------------------------

local function StartFlightFromCurrentPosition()

    if not Boat
        or not Seat
        or not Boat.Parent
        or not Seat.Parent then

        return
    end

    local Position =
        GetBoatPosition()

    if not Position then
        return
    end

    --------------------------------------------------
    -- Chỉ tạo StartY nếu là thuyền mới
    --------------------------------------------------

    if not StartY then

        StartY = Position.Y

        HighY =
            StartY
            + Config.HighHeight

        Phase = 1

        HighStartPosition = nil

    elseif Phase == 0 then

        Phase = 1
    end
end


--------------------------------------------------
-- AUTO FIND + SIT
--------------------------------------------------

local function SitBoat()

    if not Config.AutoFindBoat then
        return
    end

    if Boat
        and Boat.Parent
        and Seat
        and Seat.Parent then

        return
    end

    local NewBoat, NewSeat =
        FindBoat()

    if not NewBoat
        or not NewSeat then

        return
    end

    Boat = NewBoat
    Seat = NewSeat

    local Humanoid =
        GetHumanoid()

    if not Humanoid then
        return
    end

    --------------------------------------------------
    -- KHÔNG TELEPORT NHÂN VẬT
    -- KHÔNG WAIT DÀI
    --------------------------------------------------

    Seat:Sit(Humanoid)

    --------------------------------------------------
    -- Kiểm tra liên tục cho tới khi thật sự ngồi
    --------------------------------------------------

    task.spawn(function()

        for _ = 1, 20 do

            if not Boat
                or not Boat.Parent
                or not Seat
                or not Seat.Parent then

                return
            end

            if Seat.Occupant == Humanoid then

                -- Vừa ngồi xong -> bay ngay
                StartFlightFromCurrentPosition()

                return
            end

            task.wait(0.03)
        end
    end)
end


--------------------------------------------------
-- MOVE TOWARD Y
--------------------------------------------------

local function MoveTowardY(
    CurrentY,
    TargetY,
    dt
)

    local Difference =
        TargetY - CurrentY

    local Step =
        Config.VerticalSpeed * dt

    if math.abs(Difference) <= Step then

        return TargetY, true
    end

    if Difference > 0 then
        return CurrentY + Step, false
    else
        return CurrentY - Step, false
    end
end


--------------------------------------------------
-- BOAT FLY
--------------------------------------------------

local function StartBoatFly()

    if Connection then
        Connection:Disconnect()
    end

    Connection =
        RunService.Heartbeat:Connect(
            function(dt)

                if not Config.Enabled then
                    return
                end

                --------------------------------------------------
                -- BOAT LOST
                --------------------------------------------------

                if not Boat
                    or not Boat.Parent
                    or not Seat
                    or not Seat.Parent then

                    Boat = nil
                    Seat = nil

                    ResetFlight()

                    SitBoat()

                    return
                end


                --------------------------------------------------
                -- HUMANOID
                --------------------------------------------------

                local Humanoid =
                    GetHumanoid()

                if not Humanoid then
                    return
                end


                --------------------------------------------------
                -- KHÔNG NGỒI = PAUSE
                --------------------------------------------------

                if Seat.Occupant ~= Humanoid then
                    return
                end


                --------------------------------------------------
                -- ĐẢM BẢO ĐÃ CÓ FLIGHT STATE
                --------------------------------------------------

                if not StartY then
                    StartFlightFromCurrentPosition()
                end


                local Position =
                    GetBoatPosition()

                if not Position then
                    return
                end


                local Direction =
                    GetDirection()

                if not Direction then
                    return
                end


                --------------------------------------------------
                -- PHASE 1
                -- LÊN 300
                --------------------------------------------------

                if Phase == 1 then

                    local NewY, Finished =
                        MoveTowardY(
                            Position.Y,
                            HighY,
                            dt
                        )

                    local NewPosition =
                        Vector3.new(
                            Position.X,
                            NewY,
                            Position.Z
                        )

                    MoveBoat(
                        NewPosition,
                        Direction
                    )

                    if Finished then

                        Phase = 2

                        HighStartPosition =
                            Vector3.new(
                                NewPosition.X,
                                HighY,
                                NewPosition.Z
                            )
                    end

                    return
                end


                --------------------------------------------------
                -- PHASE 2
                -- BAY NGANG
                --------------------------------------------------

                if Phase == 2 then

                    local NewPosition =
                        Position
                        + Direction
                        * Config.Speed
                        * dt

                    NewPosition =
                        Vector3.new(
                            NewPosition.X,
                            HighY,
                            NewPosition.Z
                        )

                    MoveBoat(
                        NewPosition,
                        Direction
                    )

                    if HighStartPosition then

                        local Distance =
                            (
                                Vector3.new(
                                    NewPosition.X,
                                    0,
                                    NewPosition.Z
                                )
                                -
                                Vector3.new(
                                    HighStartPosition.X,
                                    0,
                                    HighStartPosition.Z
                                )
                            ).Magnitude

                        if Distance >=
                            Config.HighDistance then

                            Phase = 3
                        end
                    end

                    return
                end


                --------------------------------------------------
                -- PHASE 3
                -- HẠ XUỐNG 15
                --------------------------------------------------

                if Phase == 3 then

                    local TargetY =
                        StartY
                        + Config.Height

                    local NewY, Finished =
                        MoveTowardY(
                            Position.Y,
                            TargetY,
                            dt
                        )

                    local NewPosition =
                        Position
                        + Direction
                        * Config.Speed
                        * dt

                    NewPosition =
                        Vector3.new(
                            NewPosition.X,
                            NewY,
                            NewPosition.Z
                        )

                    MoveBoat(
                        NewPosition,
                        Direction
                    )

                    if Finished then
                        Phase = 4
                    end

                    return
                end


                --------------------------------------------------
                -- PHASE 4
                -- BAY NGANG 15
                --------------------------------------------------

                if Phase == 4 then

                    local NewPosition =
                        Position
                        + Direction
                        * Config.Speed
                        * dt

                    NewPosition =
                        Vector3.new(
                            NewPosition.X,
                            StartY
                            + Config.Height,
                            NewPosition.Z
                        )

                    MoveBoat(
                        NewPosition,
                        Direction
                    )

                    return
                end

            end
        )
end


--------------------------------------------------
-- RESPAWN
--------------------------------------------------

Player.CharacterAdded:Connect(
    function()

        task.wait(0.5)

        Boat = nil
        Seat = nil

        ResetFlight()

        if Config.Enabled then
            SitBoat()
        end
    end
)


--------------------------------------------------
-- AUTO FIND
--------------------------------------------------

task.spawn(function()

    while Config.Enabled do

        if not Boat
            or not Boat.Parent then

            SitBoat()
        end

        task.wait(0.2)
    end
end)


--------------------------------------------------
-- START
--------------------------------------------------

StartBoatFly()

task.spawn(function()

    task.wait(0.2)

    if Config.Enabled then
        SitBoat()
    end
end)

print("==============================")
print("Smooth Boat Fly Loaded")
print("Sit -> Immediate Flight")
print("Jump -> Pause")
print("Sit Again -> Resume")
print("==============================")