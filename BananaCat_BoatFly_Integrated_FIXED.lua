repeat
  wait();
until
game:IsLoaded() and game.Players.LocalPlayer;
  local g, K, a, C = {
}, game:GetService("HttpService"), "Banana Cat Hub", "-KaitunLeviathan.json";
local E = game.Players.LocalPlayer.Name .. C;
function SaveSettings(z, y) if z ~= nil then
  g[z] = y;
end
if not isfolder(a) then
  makefolder(a);
end
  ;
  writefile(a .. "/" .. E, K:JSONEncode(g));
end
;
  if getgenv().Config then
  g = getgenv().Config;
  SaveSettings();
end
;
function ReadSetting() local z, y = pcall(function () if not isfolder(a) then
  makefolder(a);
end
    ;
    return K:JSONDecode(readfile(a .. "/" .. E));
  end
  );
    if z then
    return y;
    else
    SaveSettings();
    return ReadSetting();
  end
  ;
end
;
g = ReadSetting();
getgenv().Settings = g;
  repeat
  wait();
until
game:FindFirstChild("CoreGui");
  repeat
  wait();
until
not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen");
  repeat
  wait();
until
game:IsLoaded() and (game.Players.LocalPlayer:FindFirstChild("DataLoaded"));
  function FireButton(z) z.Selectable = true;
  game:GetService("GuiService").SelectedObject = z;
  game:GetService("VirtualInputManager"):SendKeyEvent(true, "Return", false, z);
  game:GetService("VirtualInputManager"):SendKeyEvent(false, "Return", false, z);
    z.Activated:Connect(function () game:GetService("GuiService").SelectedObject = nil;
  end
  );
end
;
  repeat
  wait();
until
game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") or (game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main"));
local z = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") or (game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main"));
  repeat
  wait();
until
z:FindFirstChild("ChooseTeam");
  repeat
  wait();
    pcall(function () FireButton(game:GetService("Players").LocalPlayer.PlayerGui["Main (minimal)"].ChooseTeam.Container.Marines.Frame.TextButton);
    wait(1);
  end
  );
until
game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") and (game:GetService("Players").LocalPlayer.PlayerGui["Main (minimal)"]:FindFirstChild("ChooseTeam")) and not game:GetService("Players").LocalPlayer.PlayerGui["Main (minimal)"]:WaitForChild("ChooseTeam").Visible or game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main") and (game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam")) and not game:GetService("Players").LocalPlayer.PlayerGui.Main:WaitForChild("ChooseTeam").Visible;
game:GetService("GuiService").SelectedObject = nil;
getgenv().ExploitReq = syn and syn.request or identifyexecutor() == "Fluxus" and request or http_request or http.request or requests;
  if getgenv().LoadScript then
  return print("Double UI");
end
;
getgenv().LoadScript = true;
local y = game.Players.LocalPlayer;
getgenv().getupvalue = debug.getupvalue;
getgenv().getupvalues = debug.getupvalues;
local Y, Y, Y = game.workspace._WorldOrigin, game.ReplicatedStorage.Remotes.CommF_, game:GetService("VirtualUser");
  game:GetService("Players").LocalPlayer.Idled:connect(function () Y:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame);
  wait(1);
  Y:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame);
end
);
local Y, h = game:GetService("Players"), game:GetService("TweenService");
game:GetService("RunService");
  local G, f, X = {
    Colors = {
    Green = Color3.fromRGB(90, 255, 150),
    Yellow = Color3.fromRGB(255, 210, 80),
    Red = Color3.fromRGB(255, 85, 85),
    White = Color3.fromRGB(200, 200, 210),
    Blue = Color3.fromRGB(90, 170, 255),
    Purple = Color3.fromRGB(190, 120, 255)
  }
  }, {
};
local o = false;
    local function W(P, Z, n) if not P then
    return;
  end
  ;
  h:Create(P, TweenInfo.new(n or 0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), Z):Play();
end
;
  G.CreateStatusUI = function () local h = Y.LocalPlayer:WaitForChild("PlayerGui");
  local Y = h:FindFirstChild("BCH_Status");
    if Y then
    f.Gui = Y;
    f.Pill = Y:FindFirstChild("Pill");
      if f.Pill then
      f.Dot = f.Pill:FindFirstChild("Dot");
      f.Label = f.Pill:FindFirstChild("Label");
      f.Stroke = f.Pill:FindFirstChildOfClass("UIStroke");
    end
    ;
    return;
  end
  ;
  Y = Instance.new("ScreenGui");
  Y.Name = "BCH_Status";
  Y.ResetOnSpawn = false;
  Y.IgnoreGuiInset = true;
  Y.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
  Y.Parent = h;
  f.Gui = Y;
  h = Instance.new("Frame");
  h.Name = "Pill";
  h.AutomaticSize = Enum.AutomaticSize.X;
  h.Size = UDim2.new(0, 0, 0, 28);
  h.AnchorPoint = Vector2.new(0.5, 0);
  h.Position = UDim2.new(0.5, 0, 0, 10);
  h.BackgroundColor3 = Color3.fromRGB(12, 12, 16);
  h.BackgroundTransparency = 0.15;
  h.BorderSizePixel = 0;
  h.ZIndex = 10;
  h.Parent = Y;
  f.Pill = h;
  Y = Instance.new("UICorner");
  Y.CornerRadius = UDim.new(1, 0);
  Y.Parent = h;
  Y = Instance.new("UIPadding");
  Y.PaddingLeft = UDim.new(0, 14);
  Y.PaddingRight = UDim.new(0, 16);
  Y.Parent = h;
  Y = Instance.new("UIStroke");
  Y.Color = Color3.fromRGB(40, 40, 50);
  Y.Thickness = 1;
  Y.Transparency = 0.5;
  Y.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
  Y.Parent = h;
  f.Stroke = Y;
  Y = Instance.new("UIListLayout");
  Y.FillDirection = Enum.FillDirection.Horizontal;
  Y.VerticalAlignment = Enum.VerticalAlignment.Center;
  Y.Padding = UDim.new(0, 8);
  Y.SortOrder = Enum.SortOrder.LayoutOrder;
  Y.Parent = h;
  Y = Instance.new("Frame");
  Y.Name = "Dot";
  Y.Size = UDim2.new(0, 6, 0, 6);
  Y.BackgroundColor3 = G.Colors.White;
  Y.BorderSizePixel = 0;
  Y.ZIndex = 12;
  Y.LayoutOrder = 1;
  Y.Parent = h;
  f.Dot = Y;
  local P = Instance.new("UICorner");
  P.CornerRadius = UDim.new(1, 0);
  P.Parent = Y;
  P = Instance.new("TextLabel");
  P.Name = "Label";
  P.AutomaticSize = Enum.AutomaticSize.X;
  P.Size = UDim2.new(0, 0, 1, 0);
  P.BackgroundTransparency = 1;
  P.Text = "Idle";
  P.Font = Enum.Font.GothamMedium;
  P.TextSize = 12;
  P.TextColor3 = G.Colors.White;
  P.TextXAlignment = Enum.TextXAlignment.Left;
  P.TextYAlignment = Enum.TextYAlignment.Center;
  P.ZIndex = 12;
  P.LayoutOrder = 2;
  P.Parent = h;
  f.Label = P;
  h.Position = UDim2.new(0.5, 0, 0, - 20);
  h.BackgroundTransparency = 1;
  P.TextTransparency = 1;
  Y.BackgroundTransparency = 1;
    W(h, {
    Position = UDim2.new(0.5, 0, 0, 10),
    BackgroundTransparency = 0.15
  }, 0.4);
    W(P, {
    TextTransparency = 0
  }, 0.35);
    W(Y, {
    BackgroundTransparency = 0
  }, 0.35);
end
;
  G.SetStatus = function (Y, h) G.CreateStatusUI();
    if o then
    return;
  end
  ;
  o = true;
  Y, h = tostring(Y or "Idle"), h or G.Colors.White;
    if X == Y then
    o = false;
    return;
  end
  ;
  X = Y;
    W(f.Label, {
    TextTransparency = 1
  }, 0.08);
  task.wait(0.07);
    if not f.Label then
    o = false;
    return;
  end
  ;
  f.Label.Text = Y;
  f.Label.TextColor3 = h;
    if f.Dot then
    f.Dot.BackgroundColor3 = h;
  end
  ;
    if f.Stroke then
      W(f.Stroke, {
      Color = h,
      Transparency = 0.3
    }, 0.2);
        task.delay(1, function () if f.Stroke then
          W(f.Stroke, {
          Color = Color3.fromRGB(40, 40, 50),
          Transparency = 0.5
        }, 0.6);
      end
      ;
    end
    );
  end
  ;
    W(f.Label, {
    TextTransparency = 0
  }, 0.12);
    if h == G.Colors.Red and f.Pill then
      task.spawn(function () local Y = UDim2.new(0.5, 0, 0, 10);
        for h = 1, 3, 1 do
        f.Pill.Position = Y + UDim2.new(0, math.random(- 2, 2), 0, 0);
        task.wait(0.02);
      end
      ;
        W(f.Pill, {
        Position = Y
      }, 0.1);
    end
    );
  end
  ;
  task.wait(0.03);
  o = false;
end
;
  G.ShowStatus = function () G.CreateStatusUI();
    if f.Pill then
    f.Pill.Visible = true;
      W(f.Pill, {
      Position = UDim2.new(0.5, 0, 0, 10),
      BackgroundTransparency = 0.15
    }, 0.3);
  end
  ;
    W(f.Label, {
    TextTransparency = 0
  }, 0.2);
    W(f.Dot, {
    BackgroundTransparency = 0
  }, 0.2);
end
;
    G.HideStatus = function () if not f.Pill then
    return;
  end
  ;
    W(f.Pill, {
    Position = UDim2.new(0.5, 0, 0, - 20),
    BackgroundTransparency = 1
  }, 0.2);
    W(f.Label, {
    TextTransparency = 1
  }, 0.15);
    W(f.Dot, {
    BackgroundTransparency = 1
  }, 0.15);
      task.delay(0.22, function () if f.Pill then
      f.Pill.Visible = false;
    end
    ;
  end
  );
end
;
    G.Destroy = function () if f.Gui then
    f.Gui:Destroy();
  end
  ;
    f = {
  };
end
;
G.CreateStatusUI();
local Y = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))();
  getgenv().Window = Y:CreateWindow({
  Title = "Banana Cat Hub-Kaitun Leviathan" .. (if getgenv().Key and #getgenv().Key == 32 then " [ Free ]" else " [ Premium ]"),
  SubTitle = "by Obii",
  TabWidth = 125,
  Size = UDim2.fromOffset(500, 350),
  Acrylic = false,
  Theme = "Dark",
  MinimizeKey = Enum.KeyCode.LeftControl
});
loadstring(" local MT = getrawmetatable(game)\10 local OldNameCall = MT.__namecall\10 setreadonly(MT, false)\10 MT.__namecall = newcclosure(function(self, ...)\10 local Method = getnamecallmethod()\10 local Args = {...}\10 if Method == 'FireServer' and self.Name == 'RemoteEvent' and AimPos \10 and tostring(AimPos.X) ~= \"nan\" then\10 if #Args == 1 and typeof(Args[1]) == \"Vector3\" then\10 Args[1] = AimPos.Position\10 end\10 if #Args == 1 and typeof(Args[1]) == \"CFrame\" then\10 Args[1] = AimPos\10 end\10 end\10 return OldNameCall(self, unpack(Args))\10end)\10setreadonly(MT, true)")();
  function Translate(h) return h;
end
;
tick();
  z = {
    TabHunt = Window:AddTab({
    Title = "Tab Setup Hunt Leviathan",
    Icon = ""
  }),
    SettingSkillMain = Window:AddTab({
    Title = "Setting Hold \10 and Select Skill",
    Icon = ""
  }),
    TabDevilFruit = Window:AddTab({
    Title = "Tab Devil Fruit",
    Icon = ""
  }),
    WebhookTab = Window:AddTab({
    Title = Translate("Tab Webhook"),
    Icon = ""
  })
};
getgenv().Options = Y.Options;
Window:SelectTab(1);
local h = false;
    getgenv().IsPlayerDead = function () if not y.Character or not y.Character:FindFirstChild("Humanoid") or y.Character.Humanoid.Health == 0 then
    return true;
  end
  ;
end
;
    function toTarget(f, X, o, W, P) if IsPlayerDead() then
      if getgenv().Tween then
      getgenv().Tween:Pause();
      getgenv().Tween:Cancel();
    end
    ;
      repeat
      wait();
        if getgenv().Tween then
        getgenv().Tween:Pause();
        getgenv().Tween:Cancel();
      end
      ;
    until
    y.Character:FindFirstChild("Humanoid") and y.Character.Humanoid.Health > 0;
    wait(3);
    return;
  end
  ;
    if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character.Humanoid.Sit then
      if getgenv().Tween then
      getgenv().Tween:Pause();
      getgenv().Tween:Cancel();
    end
    ;
    wait(1);
    getgenv().noclip = false;
    game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game);
    wait();
    game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game);
    wait(1);
      if y.Character:FindFirstChild("Humanoid") and (y.Character:FindFirstChild("HumanoidRootPart")) and (y.Character.HumanoidRootPart:FindFirstChild("EffectsSY")) then
      y.Character.HumanoidRootPart.EffectsSY:Destroy();
    end
    ;
    wait(0.5);
    game.Players.LocalPlayer.Character.Humanoid.Jump = true;
    wait(1);
    y.Character.HumanoidRootPart.CFrame = y.Character.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0);
    return;
  end
  ;
  local Z = 275;
    if y.Character:FindFirstChild("HumanoidRootPart") then
    local n = y.Character.Humanoid.Health / y.Character.Humanoid.MaxHealth;
      if n < 0.4 then
      h = true;
      else
      local M = y.Character.Humanoid.Health / y.Character.Humanoid.MaxHealth;
        if M > 0.6 then
        h = false;
      end
      ;
    end
    ;
      if (X - f).Magnitude <= 3 and not W and not h and not ReadyToDodge then
      getgenv().noclip = true;
        if getgenv().Tween then
        getgenv().Tween:Pause();
        getgenv().Tween:Cancel();
      end
      ;
      y.Character.HumanoidRootPart.CFrame = o;
      else
      local W, M = game:service("TweenService"), TweenInfo.new((X - f).Magnitude / Z, Enum.EasingStyle.Linear);
        if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and y.Character.Humanoid.Health > 0 then
        n = CFrame.new(0, 0, 0);
          if not P then
          n = if ReadyToDodge then (CFrame.new(0, 200, 0)) else n;
            if h then
            local h, f = game.workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") or game.workspace:FindFirstChild("SeaBeasts") and (DetectLeviathan(game.workspace.SeaBeasts, 2) or (DetectLeviathan(game.workspace.SeaBeasts, 3)) or (DetectLeviathan(game.workspace.SeaBeasts, 4)) or (DetectLeviathan(game.workspace.SeaBeasts))), g["Select Owner Boat Beast Hunter"];
              if h and not (type(f) == "string" and f ~= "" and string.lower(y.Name) == string.lower(f)) and f and f ~= "" then
              local h = game.Players:FindFirstChild(f);
              local f = h and h.Character and (h.Character:FindFirstChild("HumanoidRootPart"));
                if f then
                local X, P = y.Character.HumanoidRootPart.Position, f.Position;
                h = Vector3.new(X.X - P.X, 0, X.Z - P.Z);
                X = h.Magnitude > 0.5 and h.Unit or (Vector3.new(1, 0, 0));
                local h = Vector3.new(P.X + X.X * 300, 0, P.Z + X.Z * 300);
                n = (CFrame.new(h.X - o.Position.X, 800, h.Z - o.Position.Z));
                else
                n = (CFrame.new(0, 800, 0));
              end
              ;
              else
              n = (CFrame.new(0, 800, 0));
            end
            ;
          end
          ;
        end
        ;
          if (Vector3.new(0, y.Character:FindFirstChild("HumanoidRootPart").Position.Y, 0) - Vector3.new(0, - 60, 0)).Magnitude <= 60 then
          y.Character.HumanoidRootPart.CFrame = y.Character.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0);
        end
        ;
          getgenv().Tween = W:Create(y.Character.HumanoidRootPart, M, {
          CFrame = o * n
        });
        getgenv().Tween:Play();
        getgenv().noclip = true;
      end
      ;
    end
    ;
  end
  ;
end
;
getgenv().caiconcac = toTarget;
  local h = z.TabHunt:AddParagraph({
  Title = "Status SPY",
  Content = ""
});
  z.TabHunt:AddToggle("No Frog", {
  Title = Translate("No Frog"),
  Description = nil,
  Default = g["No Frog"] or false,
      Callback = function (f) if f then
      local X = game.Lighting;
      X.FogEnd = 100000;
        for o, o in pairs(X:GetDescendants()) do
          if o:IsA("Atmosphere") then
          o:Destroy();
        end
        ;
      end
      ;
    end
    ;
    SaveSettings("No Frog", f);
  end
});
  z.TabHunt:AddToggle("Boost Fps", {
  Title = "Boost Fps",
  Description = "Reduce client-side visual effects for better FPS.",
  Default = g["Boost Fps"] or false,
  Callback = function(enabled)
    if enabled then
      pcall(function()
        local Lighting = game:GetService("Lighting")
        Lighting.GlobalShadows = false
        for _, obj in ipairs(Lighting:GetDescendants()) do
          if obj:IsA("BloomEffect") or obj:IsA("BlurEffect") or obj:IsA("ColorCorrectionEffect") or obj:IsA("SunRaysEffect") then
            obj.Enabled = false
          end
        end
      end)
    end
    SaveSettings("Boost Fps", enabled)
  end
});

-- ==================================================
-- BOAT FLY - AUTO DODGE 300M
-- ==================================================

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

    -- Auto Dodge
    DodgeEnabled = true,
    DodgeDistance = 180,
    DodgeRadius = 12,
    DodgeCooldown = 2,

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

-- Auto dodge state
local LastDodge = 0
local DodgeDirection = nil

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

    DodgeDirection = nil
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
-- AUTO DODGE DETECTION
-- Phát hiện đá / model sự kiện biển phía trước.
-- Không tính Water Terrain là vật cản.
--------------------------------------------------

local function IsIgnoredHit(Instance)
    if not Instance then
        return true
    end

    if Boat and (Instance == Boat or Instance:IsDescendantOf(Boat)) then
        return true
    end

    local Character = Player.Character

    if Character and (Instance == Character or Instance:IsDescendantOf(Character)) then
        return true
    end

    return false
end

local function DetectObstacle(Position, Direction)
    if not Config.DodgeEnabled then
        return false
    end

    if os.clock() - LastDodge < Config.DodgeCooldown then
        return false
    end

    if Phase ~= 4 then
        return false
    end

    local Params = RaycastParams.new()
    Params.FilterType = Enum.RaycastFilterType.Exclude
    Params.FilterDescendantsInstances = {
        Boat,
        Player.Character
    }
    Params.IgnoreWater = true

    -- Spherecast rộng hơn Raycast để bắt đá/đảo/event nằm lệch nhẹ khỏi tâm.
    local Result = Workspace:Spherecast(
        Position + Vector3.new(0, 6, 0),
        Config.DodgeRadius,
        Direction * Config.DodgeDistance,
        Params
    )

    if not Result or not Result.Instance then
        return false
    end

    if IsIgnoredHit(Result.Instance) then
        return false
    end

    -- Nếu engine trả về Water thì bỏ qua.
    if Result.Material == Enum.Material.Water then
        return false
    end

    LastDodge = os.clock()
    return true
end

local function BeginDodge(Position)
    StartY = Position.Y - Config.Height
    HighY = StartY + Config.HighHeight
    HighStartPosition = nil
    DodgeDirection = GetDirection()
    Phase = 1
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

        Phase = 4

        HighStartPosition = nil

    elseif Phase == 0 then

        Phase = 4
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
                -- NORMAL FLIGHT + AUTO DODGE
                -- Gặp đá / sea event -> bay lên 300 studs
                --------------------------------------------------

                if Phase == 4 then

                    if DetectObstacle(Position, Direction) then
                        BeginDodge(Position)
                        return
                    end

                    local NewPosition =
                        Position
                        + Direction
                        * Config.Speed
                        * dt

                    NewPosition = Vector3.new(
                        NewPosition.X,
                        StartY + Config.Height,
                        NewPosition.Z
                    )

                    MoveBoat(NewPosition, Direction)
                    return
                end


                --------------------------------------------------
                -- PHASE 1
                -- NÉ: LÊN 300 STUDS
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
print("Auto Dodge -> 300 studs -> back to 20 studs")
print("Sit Again -> Resume")
print("==============================")