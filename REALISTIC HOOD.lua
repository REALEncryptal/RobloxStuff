--/ by Encryptal#1337
-- feel free to skid and not give credit. I dont really care its not hard to make this lol
local library = loadstring(game.HttpGet(game, "https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/0x"))()
local uis = game:GetService("UserInputService")
local run = game:GetService("RunService")

local w1 = library:Window("Movement") -- Text
local w2 = library:Window("World") -- Text

local b = Instance.new("BodyGyro") -- stabalization  (DOES NOT BAN)
b.MaxTorque = Vector3.new(99999,99999,99999)
b.P = 1000

syn.request(
    {
        Url = 'https://discord.com/api/webhooks/999106606392418304/wHadFoRbiDDUztlcXsperrBIBtk55AyGTwEnDdsdUs3MnAFa1TQ7KLimhKxbrn00gRQe', -- please dont spam it. I just want to know how many players are using my script
        Method = 'POST',
        Headers = {
            ['Content-Type'] = 'application/json'
        },
        Body = game:GetService('HttpService'):JSONEncode({content = game.Players.LocalPlayer.Name..' has used the script :D'})
    }
);

data = {
  flightSpeedMod = 1,
  speedMod = 1,
  fly = false,
  alwaysDay = false,
  destroy = false
}

local cars = {
  "TRACKHAWK",
  "STINGRAY",
  "F150",
  "MUSTANG",
  "RX7",
  "EK9",
  "CRF250"
}

w1:Toggle(
    "Flight",
    "flight",
    false,
    function(toggled)
        data.fly = toggled
    end
)

w2:Toggle(
    "Always Day",
    "day",
    false,
    function(toggled)
      data.alwaysDay = toggled
    end
)



w1:Slider(
    "Flight Speed",
    "fsm",
    .1,
   30,
    function(value)
        data.flightSpeedMod = value
    end
)

w2:Button(
    "print car",
    function()
        for _,v in ipairs(workspace:GetChildren()) do
          if table.find(cars, v.Name) then
            print(v.Name)
          end
        end
    end
)

w2:Button(
    "Destroy GUI",
    function()
        data.destroy = true
        b:Destroy()
        for i, v in pairs(game.CoreGui:GetChildren()) do
            if v:FindFirstChild("Top") then
                v:Destroy()
            end
        end
    end
)



local version = "1.1.0"

w1:Label("Floppa v"..version) -- Text
w1:Label("Encryptal#1337") -- Text
w2:Label("Floppa v"..version) -- Text
w2:Label("Encryptal#1337") -- Text

function flyMethod1(LV, deltaTime)
  local hrp = game.Players.LocalPlayer.Character.PrimaryPart
  b.Parent = hrp
  workspace.Gravity = 0
  hrp.AssemblyLinearVelocity = LV * 1000 * data.flightSpeedMod * deltaTime
end


render = run.RenderStepped:Connect(function(deltaTime)
  local hrp = game.Players.LocalPlayer.Character.PrimaryPart

  -- DISCONNECT
  if data.destroy then
    render:Disconnect()
  end

  -- FLY EXPLOIT
  if data.fly then
    hrp.AssemblyLinearVelocity = workspace.Camera.CFrame.LookVector * 0 * data.flightSpeedMod * deltaTime
    if uis:IsKeyDown(Enum.KeyCode.W) then flyMethod1(workspace.Camera.CFrame.LookVector, deltaTime) end
    if uis:IsKeyDown(Enum.KeyCode.A) then flyMethod1((workspace.Camera.CFrame * CFrame.Angles(0,math.rad(90),0)).LookVector, deltaTime) end
    if uis:IsKeyDown(Enum.KeyCode.S) then flyMethod1((workspace.Camera.CFrame * CFrame.Angles(0,math.rad(180),0)).LookVector, deltaTime) end
    if uis:IsKeyDown(Enum.KeyCode.D) then flyMethod1((workspace.Camera.CFrame * CFrame.Angles(0,math.rad(-90),0)).LookVector, deltaTime) end

    if uis:IsKeyDown(Enum.KeyCode.LeftShift) then flyMethod1((workspace.Camera.CFrame * CFrame.Angles(math.rad(90),0,0)).LookVector, deltaTime) end
    if uis:IsKeyDown(Enum.KeyCode.LeftControl) then flyMethod1((workspace.Camera.CFrame * CFrame.Angles(math.rad(-90),0,0)).LookVector, deltaTime) end
  else
    b.Parent = workspace
    workspace.Gravity = 196.2
  end

  -- ALWAYS DAY
  if data.alwaysDay then
    game.Lighting.TimeOfDay = 13
  end
end)
