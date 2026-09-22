--// Blox Fruits Boat Fly
--// Auto Find + Auto Sit + 3 Phase Flight
--// Jump Off = Pause
--// Sit Back = Resume
--// NO NOCLIP

getgenv().BoatFly = getgenv().BoatFly or {
    Enabled = true,

    Speed = 150,

    -- Độ cao cuối
    Height = 15,

    -- Bay lên cao
    HighHeight = 300,

    -- Quãng đường bay ngang trên cao
    HighDistance = 250,

    -- Hướng bay
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

    local VehicleSeat =
        Model:FindFirstChildWhichIsA(
            "VehicleSeat",
            true
        )

    if VehicleSeat then
        return VehicleSeat
    end

    local NormalSeat =
        Model:FindFirstChildWhichIsA(
            "Seat",
            true
        )

    return NormalSeat
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

                    -- Chỉ chọn ghế trống
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
-- RESET FLIGHT
--------------------------------------------------

local function ResetFlight()

    StartY = nil
    HighY = nil

    Phase = 0

    HighStartPosition = nil
end


--------------------------------------------------
-- SIT BOAT
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

    local Character =
        GetCharacter()

    local Humanoid =
        GetHumanoid()

    if not Humanoid then
        return
    end


    --------------------------------------------------
    -- Đưa nhân vật tới ghế
    --------------------------------------------------

    Character:PivotTo(
        Seat.CFrame
        * CFrame.new(0, 2, 0)
    )

    task.wait(0.15)


    --------------------------------------------------
    -- Ngồi
    --------------------------------------------------

    if Seat:IsA("VehicleSeat")
        or Seat:IsA("Seat") then

        Seat:Sit(Humanoid)
    end

    task.wait(0.3)


    --------------------------------------------------
    -- Chỉ khởi tạo độ cao lần đầu
    --------------------------------------------------

    if not StartY then

        local Position

        if Boat.PrimaryPart then
            Position =
                Boat.PrimaryPart.Position
        else
            Position =
                Seat.Position
        end

        StartY = Position.Y

        HighY =
            StartY
            + Config.HighHeight

        Phase = 1

        HighStartPosition =
            Vector3.new(
                Position.X,
                HighY,
                Position.Z
            )

        print(
            "Boat Fly Started - Phase 1"
        )
    end
end


--------------------------------------------------
-- GET BOAT POSITION
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
-- GET DIRECTION
--------------------------------------------------

local function GetDirection()

    local Direction =
        Config.Direction

    Direction =
        Vector3.new(
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

    local NewCFrame =
        CFrame.lookAt(
            Position,
            Position + Direction,
            Vector3.yAxis
        )

    if Boat.PrimaryPart then

        Boat:PivotTo(
            NewCFrame
        )

    elseif Seat
        and Seat.Parent then

        Seat.CFrame =
            NewCFrame
    end
end


--------------------------------------------------
-- BOAT FLY
--------------------------------------------------

local function StartBoatFly()

    if Connection then
        Connection:Disconnect()
        Connection = nil
    end

    Connection =
        RunService.Heartbeat:Connect(
            function(dt)

                if not Config.Enabled then
                    return
                end


                --------------------------------------------------
                -- CHECK BOAT
                --------------------------------------------------

                if not Boat
                    or not Boat.Parent
                    or not Seat
                    or not Seat.Parent then

                    Boat = nil
                    Seat = nil

                    ResetFlight()

                    if Config.AutoFindBoat then
                        SitBoat()
                    end

                    return
                end


                --------------------------------------------------
                -- CHECK HUMANOID
                --------------------------------------------------

                local Humanoid =
                    GetHumanoid()

                if not Humanoid then
                    return
                end


                --------------------------------------------------
                -- JUMP KHỎI THUYỀN
                --------------------------------------------------

                if Seat.Occupant
                    ~= Humanoid then

                    -- Không di chuyển thuyền
                    -- Không reset Phase
                    -- Khi ngồi lại sẽ tiếp tục

                    return
                end


                --------------------------------------------------
                -- GET POSITION
                --------------------------------------------------

                local Position =
                    GetBoatPosition()

                if not Position then
                    return
                end


                --------------------------------------------------
                -- GET DIRECTION
                --------------------------------------------------

                local Direction =
                    GetDirection()

                if not Direction then
                    return
                end


                --------------------------------------------------
                -- INIT HEIGHT
                --------------------------------------------------

                if not StartY then

                    StartY =
                        Position.Y

                    HighY =
                        StartY
                        + Config.HighHeight

                    Phase = 1

                    HighStartPosition =
                        Vector3.new(
                            Position.X,
                            HighY,
                            Position.Z
                        )
                end


                --------------------------------------------------
                -- PHASE 1
                -- BAY LÊN 300
                --------------------------------------------------

                if Phase == 1 then

                    local CurrentY =
                        Position.Y

                    local NewY =
                        CurrentY
                        + (
                            Config.Speed
                            * dt
                        )

                    if NewY >= HighY then

                        NewY = HighY

                        Phase = 2

                        HighStartPosition =
                            Vector3.new(
                                Position.X,
                                HighY,
                                Position.Z
                            )

                        print(
                            "Boat Fly -> Phase 2"
                        )
                    end

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

                    return
                end


                --------------------------------------------------
                -- PHASE 2
                -- BAY NGANG TRÊN CAO
                --------------------------------------------------

                if Phase == 2 then

                    local NewPosition =
                        Position
                        + (
                            Direction
                            * Config.Speed
                            * dt
                        )

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


                    --------------------------------------------------
                    -- KIỂM TRA QUÃNG ĐƯỜNG
                    --------------------------------------------------

                    if HighStartPosition then

                        local HorizontalDistance =
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

                        if HorizontalDistance
                            >= Config.HighDistance then

                            Phase = 3

                            print(
                                "Boat Fly -> Phase 3"
                            )
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

                    local CurrentY =
                        Position.Y

                    local NewY =
                        CurrentY
                        - (
                            Config.Speed
                            * dt
                        )

                    if NewY <= TargetY then

                        NewY =
                            TargetY

                        Phase = 4

                        print(
                            "Boat Fly -> Low Flight"
                        )
                    end


                    --------------------------------------------------
                    -- Vừa hạ vừa bay ngang
                    --------------------------------------------------

                    local NewPosition =
                        Position
                        + (
                            Direction
                            * Config.Speed
                            * dt
                        )

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

                    return
                end


                --------------------------------------------------
                -- PHASE 4
                -- BAY NGANG Ở ĐỘ CAO 15
                --------------------------------------------------

                if Phase == 4 then

                    local NewPosition =
                        Position
                        + (
                            Direction
                            * Config.Speed
                            * dt
                        )

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
-- CHARACTER RESPAWN
--------------------------------------------------

Player.CharacterAdded:Connect(
    function()

        task.wait(1)

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

task.spawn(
    function()

        while Config.Enabled do

            if not Boat
                or not Boat.Parent then

                SitBoat()
            end

            task.wait(1)
        end
    end
)


--------------------------------------------------
-- START
--------------------------------------------------

StartBoatFly()

task.spawn(
    function()

        task.wait(1)

        if Config.Enabled
            and not Boat then

            SitBoat()
        end
    end
)


print("==============================")
print("Boat Fly Loaded")
print("Jump Off = PAUSE")
print("Sit Back = RESUME")
print("Speed:", Config.Speed)
print("High Height:", Config.HighHeight)
print("High Distance:", Config.HighDistance)
print("Low Height:", Config.Height)
print("==============================")