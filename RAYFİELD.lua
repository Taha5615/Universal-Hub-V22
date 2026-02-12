--[[
    UNIVERSAL HUB V22 - ULTIMATE
    DURUM: Orijinal yapı korundu.
    EKLENEN: Kısayollar sekmesine Vertex MM2 Scripti entegre edildi.
--]]

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Universal Hub | V22 Ultimate",
   LoadingTitle = "Sistemler Hazırlanıyor...",
   LoadingSubtitle = "by Taha",
   ConfigurationSaving = { Enabled = false }
})

-- SERVİSLER
local LP = game.Players.LocalPlayer
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local TS = game:GetService("TeleportService")
local Mouse = LP:GetMouse()

-- DEĞİŞKENLER
_G.SpeedValue = 16
_G.JumpPower = 50
_G.FlySpeed = 50
_G.ESPEnabled = false
_G.ESPColor = Color3.fromRGB(255, 0, 0)
_G.Noclip = false
_G.InfJump = false
_G.HighJumpEnabled = false
_G.ClickTP = false

-- 1. MOVEMENT TAB
local MovementTab = Window:CreateTab("Movement", 4483362458)

MovementTab:CreateToggle({
   Name = "Speed Hack",
   CurrentValue = false,
   Callback = function(V) 
      _G.SpeedHack = V 
      task.spawn(function() while _G.SpeedHack do RS.Heartbeat:Wait(); if LP.Character then LP.Character.Humanoid.WalkSpeed = _G.SpeedValue end end; if LP.Character then LP.Character.Humanoid.WalkSpeed = 16 end end)
   end,
})

MovementTab:CreateSlider({ Name = "Hız", Range = {16, 500}, Increment = 1, CurrentValue = 16, Callback = function(V) _G.SpeedValue = V end})

MovementTab:CreateToggle({
   Name = "High Jump",
   CurrentValue = false,
   Callback = function(V)
      _G.HighJumpEnabled = V
      task.spawn(function() while _G.HighJumpEnabled do RS.Heartbeat:Wait(); if LP.Character then LP.Character.Humanoid.UseJumpPower = true; LP.Character.Humanoid.JumpPower = _G.JumpPower end end; if LP.Character then LP.Character.Humanoid.JumpPower = 50 end end)
   end,
})

MovementTab:CreateSlider({ Name = "Zıplama", Range = {50, 1000}, Increment = 5, CurrentValue = 50, Callback = function(V) _G.JumpPower = V end})

MovementTab:CreateToggle({Name = "Infinite Jump (Sınırsız Zıplama)", CurrentValue = false, Callback = function(V) _G.InfJump = V end})

MovementTab:CreateToggle({
   Name = "Fly (Uçma)",
   CurrentValue = false,
   Callback = function(V)
      _G.FlyEnabled = V
      if V then
          local Root = LP.Character:WaitForChild("HumanoidRootPart")
          local BG = Instance.new("BodyGyro", Root); local BV = Instance.new("BodyVelocity", Root)
          BG.P = 9e4; BG.maxTorque = Vector3.new(9e9, 9e9, 9e9); BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
          LP.Character.Humanoid.PlatformStand = true
          task.spawn(function()
              while _G.FlyEnabled do RS.RenderStepped:Wait()
                  local cam = workspace.CurrentCamera; local dir = Vector3.new(0,0,0)
                  if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
                  if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
                  if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
                  if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
                  BG.CFrame = cam.CFrame; BV.velocity = dir * _G.FlySpeed
              end
              BG:Destroy(); BV:Destroy(); LP.Character.Humanoid.PlatformStand = false
          end)
      end
   end,
})

MovementTab:CreateSlider({ Name = "Uçuş Hızı", Range = {10, 500}, Increment = 5, CurrentValue = 50, Callback = function(V) _G.FlySpeed = V end})

MovementTab:CreateToggle({Name = "Noclip (Duvar Geçme)", CurrentValue = false, Callback = function(V) _G.Noclip = V end})

-- 2. VISUALS TAB
local VisualTab = Window:CreateTab("Visuals", 4483362458)

VisualTab:CreateToggle({
   Name = "ESP",
   CurrentValue = false,
   Callback = function(V)
      _G.ESPEnabled = V
      if not V then for _, p in pairs(Players:GetPlayers()) do if p.Character then if p.Character:FindFirstChild("GeminiHL") then p.Character.GeminiHL:Destroy() end if p.Character.HumanoidRootPart:FindFirstChild("GeminiName") then p.Character.HumanoidRootPart.GeminiName:Destroy() end end end end
      task.spawn(function() while _G.ESPEnabled do for _, p in pairs(Players:GetPlayers()) do if p ~= LP and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
          local hl = p.Character:FindFirstChild("GeminiHL") or Instance.new("Highlight", p.Character); hl.Name = "GeminiHL"; hl.FillColor = _G.ESPColor; hl.FillTransparency = 0.5
          local bg = p.Character.HumanoidRootPart:FindFirstChild("GeminiName") or Instance.new("BillboardGui", p.Character.HumanoidRootPart); bg.Name = "GeminiName"; bg.AlwaysOnTop = true; bg.Size = UDim2.new(0,200,0,50); bg.StudsOffset = Vector3.new(0,3,0)
          local tl = bg:FindFirstChild("TextLabel") or Instance.new("TextLabel", bg); tl.Size = UDim2.new(1,0,1,0); tl.BackgroundTransparency = 1; tl.Text = p.Name; tl.TextColor3 = _G.ESPColor; tl.TextSize = 16; tl.Font = Enum.Font.SourceSansBold
      end end task.wait(0.5) end end)
   end,
})

VisualTab:CreateDropdown({
   Name = "ESP Rengi",
   Options = {"Kırmızı", "Yeşil", "Mavi", "Sarı", "Beyaz"},
   CurrentOption = "Kırmızı",
   Callback = function(Option)
      local colors = {["Kırmızı"]=Color3.new(1,0,0), ["Yeşil"]=Color3.new(0,1,0), ["Mavi"]=Color3.new(0,0,1), ["Sarı"]=Color3.new(1,1,0), ["Beyaz"]=Color3.new(1,1,1)}
      _G.ESPColor = colors[Option[1]]
   end,
})

VisualTab:CreateButton({
    Name = "Fullbright & No Fog (Aydınlık)",
    Callback = function()
        Lighting.Brightness = 2; Lighting.ClockTime = 14; Lighting.FogEnd = 100000; Lighting.GlobalShadows = false
        for _, v in pairs(Lighting:GetDescendants()) do if v:IsA("Atmosphere") or v:IsA("Clouds") then v:Destroy() end end
    end
})

-- 3. PLAYER & TP TAB
local PlayerTab = Window:CreateTab("Players", 4483362458)
local TargetPlayer = ""
local Dropdown = PlayerTab:CreateDropdown({Name = "Oyuncu Seç", Options = {"Yenile'ye Bas"}, CurrentOption = "", Callback = function(Option) TargetPlayer = Option[1] end})

PlayerTab:CreateButton({Name = "Listeyi Yenile", Callback = function() 
    local l = {}; for _, v in pairs(Players:GetPlayers()) do if v ~= LP then table.insert(l, v.Name) end end; Dropdown:Refresh(l, true) 
end})

PlayerTab:CreateButton({Name = "Seçili Oyuncuya Işınlan", Callback = function() 
    if TargetPlayer ~= "" and Players:FindFirstChild(TargetPlayer) then LP.Character.HumanoidRootPart.CFrame = Players[TargetPlayer].Character.HumanoidRootPart.CFrame end 
end})

PlayerTab:CreateToggle({Name = "Spectate (İzle)", CurrentValue = false, Callback = function(V) 
    local cam = workspace.CurrentCamera
    if V and TargetPlayer ~= "" and Players:FindFirstChild(TargetPlayer) then cam.CameraSubject = Players[TargetPlayer].Character.Humanoid else cam.CameraSubject = LP.Character.Humanoid end 
end})

-- 4. SERVER & SETTINGS
local ServerTab = Window:CreateTab("Server", 4483362458)
ServerTab:CreateToggle({Name = "Click TP (Ctrl+Tık)", CurrentValue = false, Callback = function(V) _G.ClickTP = V end})
ServerTab:CreateButton({Name = "Rejoin", Callback = function() TS:Teleport(game.PlaceId, LP) end})
ServerTab:CreateButton({Name = "Server Hop", Callback = function() 
    local Http = game:GetService("HttpService"); local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100"
    local s = Http:JSONDecode(game:HttpGet(Api)); for _, v in pairs(s.data) do if v.playing < v.maxPlayers and v.id ~= game.JobId then TS:TeleportToPlaceInstance(game.PlaceId, v.id, LP) break end end 
end})

-- [[ KISAYOLLAR SEKMESİ ]] --
local ShortcutTab = Window:CreateTab("Kısayollar", 4483362458)

ShortcutTab:CreateKeybind({
   Name = "Menü Aç/Kapat Tuşu",
   CurrentKeybind = "RightShift",
   HoldToInteract = false,
   Flag = "MenuToggle",
   Callback = function(Keybind)
   end,
})

ShortcutTab:CreateButton({
   Name = "Infinite Yield Admin",
   Callback = function()
      loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
   end,
})

-- [[ MM2 BUTONU (EKLENDİ) ]] --
ShortcutTab:CreateButton({
   Name = "MM2 (Murder Mystery 2)",
   Callback = function()
      loadstring(game:HttpGet('https://raw.smokingscripts.org/vertex.lua'))()
   end,
})
-- [[ KISIM SONU ]] --

-- SİSTEM DÖNGÜLERİ
RS.Stepped:Connect(function()
    if _G.Noclip and LP.Character then
        for _, v in pairs(LP.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end
    end
end)

UIS.JumpRequest:Connect(function() if _G.InfJump and LP.Character and LP.Character:FindFirstChild("Humanoid") then LP.Character.Humanoid:ChangeState("Jumping") end end)

UIS.InputBegan:Connect(function(i) if _G.ClickTP and i.UserInputType == Enum.UserInputType.MouseButton1 and UIS:IsKeyDown(Enum.KeyCode.LeftControl) then LP.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p) + Vector3.new(0,3,0) end end)

Rayfield:Notify({Title = "V22 Ultimate", Content = "MM2 Scripti Eklendi!"})