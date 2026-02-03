local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Aʀvᴇx", LoadingTitle = "Aʀvᴇx Hub"})
local Tab = Window:CreateTab("Main")

-- 1. Dug Up / Down (من السكربت اللي اعطيتني اياه)
local function teleportDig(dir)
    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Hole" or v.Name == "Safe" then
            local dist = (v.Position - root.Position).Magnitude
            if dist < 60 then 
                root.CFrame = v.CFrame * CFrame.new(0, dir == 1 and 6 or -6, 0)
                break
            end
        end
    end
end

Tab:CreateButton({Name = "Dug Up", Callback = function() teleportDig(1) end})
Tab:CreateButton({Name = "Dug Down", Callback = function() teleportDig(-1) end})

-- 2. Coin Magnet (سحب العملات فقط)
Tab:CreateToggle({Name = "Coin Magnet", Callback = function(v)
    _G.Magnet = v
    while _G.Magnet do
        for _, coin in pairs(workspace:GetDescendants()) do
            if coin:IsA("BasePart") and (coin.Name:find("Coin") or coin.Name:find("Gold")) then
                coin.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            end
        end
        task.wait(0.2)
    end
end})

-- 3. Collect Cash (لمس الكاش فقط)
Tab:CreateToggle({Name = "Auto Collect Cash", Callback = function(v)
    _G.Collect = v
    while _G.Collect do
        for _, cash in pairs(workspace:GetDescendants()) do
            if cash:IsA("BasePart") and cash.Name:find("Cash") then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, cash, 0)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, cash, 1)
            end
        end
        task.wait(0.3)
    end
end})

-- 4. Event Time (إظهار وقت الايفنت)
Tab:CreateButton({Name = "Show Event Time", Callback = function()
    local pGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    local timer = pGui:FindFirstChild("TimerGui", true) or pGui:FindFirstChild("EventTimer", true)
    if timer then
        Rayfield:Notify({Title = "Event Time", Content = "الوقت: " .. (timer:IsA("TextLabel") and timer.Text or "موجود بالـ GUI"), Duration = 5})
    else
        Rayfield:Notify({Title = "Arvex", Content = "لم يتم العثور على وقت الحدث حالياً", Duration = 5})
    end
end})

-- 5. Instant Take (تعديلك المفضل)
Tab:CreateToggle({Name = "Instant Take (Hold)", Callback = function(v)
    _G.IT = v
    game:GetService("RunService").Stepped:Connect(function()
        if _G.IT then
            for _, p in pairs(workspace:GetDescendants()) do
                if p:IsA("ProximityPrompt") then p.HoldDuration = 0 end
            end
        end
    end)
end})
