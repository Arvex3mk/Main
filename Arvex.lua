local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Aʀvᴇx", LoadingTitle = "Aʀvᴇx Hub"})
local Tab = Window:CreateTab("Main")

local function tp(d)
    local r, target, dist = game.Players.LocalPlayer.Character.HumanoidRootPart, nil, math.huge
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name:lower():find("hole") or v.Name:lower():find("safe")) then
            local off = v.Position - r.Position
            if (d == 1 and off:Dot(r.CFrame.LookVector) > 5) or (d == -1 and off:Dot(r.CFrame.LookVector) < -5) then
                if off.Magnitude < dist then dist = off.Magnitude; target = v end
            end
        end
    end
    if target then r.CFrame = target.CFrame + Vector3.new(0, 3, 0) end
end

Tab:CreateButton({Name = "Dug Up (Next)", Callback = function() tp(1) end})
Tab:CreateButton({Name = "Dug Down (Prev)", Callback = function() tp(-1) end})
Tab:CreateToggle({Name = "Coin Farm", Callback = function(v) _G.cf = v while _G.cf do for _, i in pairs(workspace:GetDescendants()) do if (i.Name:find("Coin") or i.Name:find("Gold")) and i:IsA("BasePart") then firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, i, 0) firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, i, 1) end end task.wait(0.2) end end})
Tab:CreateToggle({Name = "Collect Cash", Callback = function(v) _G.cc = v while _G.cc do for _, i in pairs(workspace:GetDescendants()) do if i.Name:find("Cash") and i:IsA("BasePart") then firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, i, 0) firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, i, 1) end end task.wait(0.2) end end})
Tab:CreateToggle({Name = "Instant Take", Callback = function(v) _G.it = v game:GetService("RunService").RenderStepped:Connect(function() if _G.it then for _, p in pairs(workspace:GetDescendants()) do if p:IsA("ProximityPrompt") then p.HoldDuration = 0 p:InputHoldBegin() end end end end) end})
