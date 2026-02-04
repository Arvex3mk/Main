local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Aʀvᴇx", LoadingTitle = "Aʀvᴇx Hub"})
local Tab = Window:CreateTab("Main")

-- 1. Dug Up / Down (نفس أرقام السكربت اللي عجبك)
local function teleportDig(dir)
    local root = game.Players.LocalPlayer.Character.HumanoidRootPart
    for _, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Hole" or v.Name == "Safe" then
            if (v.Position - root.Position).Magnitude < 100 then
                root.CFrame = v.CFrame * CFrame.new(0, dir == 1 and 5.5 or -5.5, 0)
                break
            end
        end
    end
end

Tab:CreateButton({Name = "Dug Up", Callback = function() teleportDig(1) end})
Tab:CreateButton({Name = "Dug Down", Callback = function() teleportDig(-1) end})

-- 2. Event Coins Magnet (شفط الكوينز والذهب حق الايفنت فقط)
Tab:CreateToggle({Name = "Event Coins Magnet", Callback = function(state)
    _G.CoinMag = state
    task.spawn(function()
        while _G.CoinMag do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (v.Name == "Coin" or v.Name == "Gold") then
                    v.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                end
            end
            task.wait(0.1)
        end
    end)
end})

-- 3. Auto Collect Cash (تجميع الكاش العادي باللمس فقط)
Tab:CreateToggle({Name = "Auto Collect Cash", Callback = function(state)
    _G.CashColl = state
    task.spawn(function()
        while _G.CashColl do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and v.Name == "Cash" then
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v, 1)
                end
            end
            task.wait(0.3)
        end
    end)
end})

-- 4. Instant Take (الالتقاط الفوري - Hold Duration 0)
Tab:CreateToggle({Name = "Instant Take (Hold)", Callback = function(v)
    _G.IT = v
    game:GetService("RunService").RenderStepped:Connect(function()
        if _G.IT then
            for _, p in pairs(workspace:GetDescendants()) do
                if p:IsA("ProximityPrompt") then p.HoldDuration = 0 end
            end
        end
    end)
end})

-- 5. Show Event Time (هذا اللي سألت عنه، سحبته من الـ GUI)
Tab:CreateButton({Name = "Show Event Time", Callback = function()
    local timer = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("TimerGui", true)
    if timer and timer:FindFirstChild("TextLabel") then
        Rayfield:Notify({Title = "Event Time", Content = "الوقت المتبقي: " .. timer.TextLabel.Text, Duration = 5})
    else
        Rayfield:Notify({Title = "Arvex", Content = "مافي ايفنت شغال حالياً", Duration = 5})
    end
end})
