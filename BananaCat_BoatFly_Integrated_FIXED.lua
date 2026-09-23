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
    TabBoatFly = Window:AddTab({
    Title = "Boat Fly",
    Icon = ""
  })
};
getgenv().Options = Y.Options;
Window:SelectTab(z.TabBoatFly);
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
-- BOAT FLY - AUTO DODGE 300M (FIXED)
-- ==================================================

getgenv().BoatFly = getgenv().BoatFly or {
    Enabled = true,
    Speed = 150,
    Height = 15,
    HighHeight = 1000,
    HighDistance = 250,
    HighHoldTime = 5,
    DodgeEnabled = true,
    DodgeDistance = 180,
    DodgeRadius = 12,
    DodgeCooldown = 2,
    VerticalSpeed = 120,
    Direction = Vector3.new(-0.99102227, 0, -0.13369414),
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
local Connection = nil
local StartY = nil
local HighY = nil
local Phase = 4
local HighStartPosition = nil
local HighHoldStarted = 0
local LastDodge = 0
local DodgeDirection = nil
local SitBoat

local function GetCharacter()
    return Player.Character or Player.CharacterAdded:Wait()
end

local function GetHumanoid()
    local Character = GetCharacter()
    return Character and Character:FindFirstChildOfClass("Humanoid")
end

local function FindBoatModelFromSeat(SeatObject, BoatsFolder)
    local Current = SeatObject
    local LastModel = nil
    while Current and Current ~= BoatsFolder do
        if Current:IsA("Model") then
            LastModel = Current
        end
        Current = Current.Parent
    end
    return LastModel
end

local function FindBoat()
    local BoatsFolder = Workspace:FindFirstChild("Boats")
    if not BoatsFolder then
        return nil, nil
    end

    local Character = GetCharacter()
    local HRP = Character and Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
    if not HRP then
        return nil, nil
    end

    local NearestBoat, NearestSeat, NearestDistance = nil, nil, math.huge

    for _, Object in ipairs(BoatsFolder:GetDescendants()) do
        if Object:IsA("VehicleSeat") or Object:IsA("Seat") then
            local OccupiedByMe = Humanoid and Object.Occupant == Humanoid
            if not Object.Occupant or OccupiedByMe then
                local BoatModel = FindBoatModelFromSeat(Object, BoatsFolder)
                if BoatModel then
                    local Distance = (Object.Position - HRP.Position).Magnitude
                    if Distance < NearestDistance then
                        NearestDistance = Distance
                        NearestBoat = BoatModel
                        NearestSeat = Object
                    end
                end
            end
        end
    end

    return NearestBoat, NearestSeat
end

local function ResetFlight()
    StartY = nil
    HighY = nil
    Phase = 4
    HighStartPosition = nil
    HighHoldStarted = 0
    DodgeDirection = nil
end

local function GetBoatPosition()
    if not Boat or not Boat.Parent then
        return nil
    end
    return Boat:GetPivot().Position
end

local function GetDirection()
    local D = Config.Direction
    D = Vector3.new(D.X, 0, D.Z)
    if D.Magnitude < 0.01 then
        return nil
    end
    return D.Unit
end

local function MoveBoat(Position, Direction)
    if not Boat or not Boat.Parent then
        return
    end

    local Target = CFrame.lookAt(Position, Position + Direction, Vector3.yAxis)

    -- Teleport/pivot every frame and also push physics velocity.  This is more
    -- reliable for boats whose physics ownership changes while the player sits.
    pcall(function()
        Boat:PivotTo(Target)
    end)

    pcall(function()
        if Boat.PrimaryPart then
            Boat.PrimaryPart.CFrame = Target
            Boat.PrimaryPart.AssemblyLinearVelocity = Direction * Config.Speed
        end
    end)

    for _, Part in ipairs(Boat:GetDescendants()) do
        if Part:IsA("BasePart") and not Part.Anchored then
            pcall(function()
                Part.AssemblyLinearVelocity = Direction * Config.Speed
                Part.AssemblyAngularVelocity = Vector3.zero
            end)
        end
    end
end

local function IsValidObstaclePart(Part)
    if not Part or not Part:IsA("BasePart") then
        return false
    end
    if Part.Transparency >= 1 then
        return false
    end
    if not Part.CanQuery then
        return false
    end
    if Boat and Part:IsDescendantOf(Boat) then
        return false
    end
    if Player.Character and Part:IsDescendantOf(Player.Character) then
        return false
    end
    if Part:IsDescendantOf(Workspace:FindFirstChild("Camera")) then
        return false
    end
    return true
end

local function DetectObstacle(Position, Direction)
    if not Config.DodgeEnabled then
        return false
    end
    if os.clock() - LastDodge < Config.DodgeCooldown then
        return false
    end

    local Params = RaycastParams.new()
    Params.FilterType = Enum.RaycastFilterType.Exclude
    Params.FilterDescendantsInstances = {Boat, Player.Character}
    Params.IgnoreWater = true

    -- Check several heights and a wider sphere so rocks, islands and NPC/monster
    -- hitboxes are detected even when their center is above/below the boat.
    local Heights = {0, 6, 14, 24, 40}
    for _, OffsetY in ipairs(Heights) do
        local Origin = Position + Vector3.new(0, OffsetY, 0)
        local Result = Workspace:Spherecast(
            Origin,
            Config.DodgeRadius,
            Direction * Config.DodgeDistance,
            Params
        )
        if Result and IsValidObstaclePart(Result.Instance) then
            LastDodge = os.clock()
            return true
        end
    end

    -- Extra rays slightly to either side catch narrow rocks/parts missed by the sphere.
    local Side = Vector3.new(-Direction.Z, 0, Direction.X)
    for _, Sign in ipairs({-1, 1}) do
        local Origin = Position + Side * (Config.DodgeRadius * Sign)
        local Result = Workspace:Raycast(Origin, Direction * Config.DodgeDistance, Params)
        if Result and IsValidObstaclePart(Result.Instance) then
            LastDodge = os.clock()
            return true
        end
    end

    return false
end

local function StartFlightFromCurrentPosition()
    local Position = GetBoatPosition()
    if not Position then
        return
    end
    if not StartY then
        StartY = Position.Y - Config.Height
        HighY = StartY + Config.HighHeight
        Phase = 4
        HighStartPosition = nil
        HighHoldStarted = 0
    end
end

SitBoat = function(ForceFind)
    if not Config.AutoFindBoat and not ForceFind then
        return false
    end

    if Boat and Boat.Parent and Seat and Seat.Parent then
        local Humanoid = GetHumanoid()
        if Humanoid and Seat.Occupant ~= Humanoid then
            pcall(function() Seat:Sit(Humanoid) end)
        end
        return true
    end

    local NewBoat, NewSeat = FindBoat()
    if not NewBoat or not NewSeat then
        return false
    end

    Boat = NewBoat
    Seat = NewSeat
    ResetFlight()

    local Humanoid = GetHumanoid()
    local HRP = GetCharacter():FindFirstChild("HumanoidRootPart")
    if not Humanoid or not HRP then
        return false
    end

    -- Đưa nhân vật tới ghế rồi Sit để Find Boat thực sự có tác dụng.
    pcall(function()
        HRP.CFrame = NewSeat.CFrame + Vector3.new(0, 3, 0)
        task.wait(0.05)
        NewSeat:Sit(Humanoid)
    end)

    task.spawn(function()
        for _ = 1, 40 do
            if not Boat or not Boat.Parent or not Seat or not Seat.Parent then
                return
            end
            if Seat.Occupant == Humanoid then
                StartFlightFromCurrentPosition()
                return
            end
            task.wait(0.05)
        end
    end)
    return true
end

-- Boat Fly UI
if z.TabBoatFly then
    z.TabBoatFly:AddParagraph({
        Title = "Boat Fly",
        Content = "Find Boat → ngồi vào thuyền → né vật cản bằng cách bay lên 1000 studs, giữ độ cao 5 giây rồi hạ xuống."
    })

    z.TabBoatFly:AddButton({
        Title = "Find Boat",
        Description = "Tìm thuyền gần nhất và ngồi vào ghế.",
        Callback = function()
            task.spawn(function()
                local Found = SitBoat(true)
                if G and G.SetStatus then
                    G.SetStatus(Found and "Đã tìm thấy thuyền" or "Không tìm thấy thuyền", Found and G.Colors.Green or G.Colors.Red)
                end
            end)
        end
    })

    z.TabBoatFly:AddToggle("BoatFlyEnabled", {
        Title = "Boat Fly",
        Description = "Bật/tắt bay thuyền.",
        Default = Config.Enabled,
        Callback = function(Value)
            Config.Enabled = Value
            if Value then
                task.spawn(function() SitBoat(true) end)
            end
        end
    })

    z.TabBoatFly:AddToggle("AutoFindBoat", {
        Title = "Auto Find Boat",
        Description = "Tự tìm và ngồi vào thuyền.",
        Default = Config.AutoFindBoat,
        Callback = function(Value)
            Config.AutoFindBoat = Value
            SaveSettings("AutoFindBoat", Value)
        end
    })
end

local function MoveTowardY(CurrentY, TargetY, dt)
    local Difference = TargetY - CurrentY
    local Step = Config.VerticalSpeed * dt
    if math.abs(Difference) <= Step then
        return TargetY, true
    end
    return CurrentY + (Difference > 0 and Step or -Step), false
end

local function StartBoatFly()
    if Connection then
        Connection:Disconnect()
    end

    Connection = RunService.Heartbeat:Connect(function(dt)
        if not Config.Enabled then
            return
        end

        if not Boat or not Boat.Parent or not Seat or not Seat.Parent then
            Boat, Seat = nil, nil
            ResetFlight()
            SitBoat(false)
            return
        end

        local Humanoid = GetHumanoid()
        if not Humanoid then return end

        if Seat.Occupant ~= Humanoid then
            -- Try to re-seat instead of silently stopping.
            pcall(function() Seat:Sit(Humanoid) end)
            return
        end

        if not StartY then
            StartFlightFromCurrentPosition()
        end

        local Position = GetBoatPosition()
        local Direction = GetDirection()
        if not Position or not Direction then return end

        -- Always keep the boat pointed in the configured direction.
        -- If something is detected in front, immediately switch to the 300-stud
        -- avoidance climb before continuing forward.
        if Phase == 4 and DetectObstacle(Position, Direction) then
            StartY = Position.Y - Config.Height
            HighY = StartY + Config.HighHeight
            HighStartPosition = nil
            HighHoldStarted = 0
            Phase = 1
            return
        end

        if Phase == 4 then
            local NewPosition = Position + Direction * Config.Speed * dt
            NewPosition = Vector3.new(NewPosition.X, StartY + Config.Height, NewPosition.Z)
            MoveBoat(NewPosition, Direction)
            return
        end

        if Phase == 1 then
            -- Rise straight up to the configured high altitude (default +300).
            local NewY, Finished = MoveTowardY(Position.Y, HighY, dt)
            MoveBoat(Vector3.new(Position.X, NewY, Position.Z), Direction)
            if Finished then
                Phase = 2
                HighStartPosition = Vector3.new(Position.X, HighY, Position.Z)
                HighHoldStarted = os.clock()
            end
            return
        end

        if Phase == 2 then
            -- Stay at the full 1000-stud avoidance height for 5 seconds,
            -- while continuing to fly in the configured direction.
            local NewPosition = Position + Direction * Config.Speed * dt
            NewPosition = Vector3.new(NewPosition.X, HighY, NewPosition.Z)
            MoveBoat(NewPosition, Direction)

            if HighHoldStarted > 0 and (os.clock() - HighHoldStarted) >= Config.HighHoldTime then
                Phase = 3
            end
            return
        end

        if Phase == 3 then
            -- Descend while still following the configured direction.
            local TargetY = StartY + Config.Height
            local NewY, Finished = MoveTowardY(Position.Y, TargetY, dt)
            local NewPosition = Position + Direction * Config.Speed * dt
            NewPosition = Vector3.new(NewPosition.X, NewY, NewPosition.Z)
            MoveBoat(NewPosition, Direction)
            if Finished then
                Phase = 4
            end
        end
    end)
end

StartBoatFly()

task.spawn(function()
    while task.wait(0.2) do
        if Config.Enabled and (not Boat or not Boat.Parent) then
            SitBoat(false)
        end
    end
end)

task.spawn(function()
    task.wait(0.5)
    if Config.Enabled then
        SitBoat(true)
    end
end)

Player.CharacterAdded:Connect(function()
    task.wait(0.7)
    Boat, Seat = nil, nil
    ResetFlight()
    if Config.Enabled then
        SitBoat(true)
    end
end)

print("Boat Fly FIXED: Find Boat + Auto Fly + Auto Dodge")


print("Banana Cat + Boat Fly FIXED loaded")
