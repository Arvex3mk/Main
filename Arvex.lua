local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "Aʀvᴇx", LoadingTitle = "Aʀvᴇx Hub"})
local Tab = Window:CreateTab("Main")

-- وظيفة التنقل الدقيق
local function tp(direction)
    local player = game.Players.LocalPlayer
    local character = player.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local root = character.HumanoidRootPart
    local target = nil
    local shortestDistance = math.huge

    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and (v.Name:lower():find("hole") or v.Name:lower():find("safe")) then
            local offset = v.Position - root.Position
            if (direction == 1 and offset:Dot(root.CFrame.LookVector) > 0) or 
               (direction == -1 and offset:Dot(root.CFrame.LookVector) < 0) then
                if offset.Magnitude < shortestDistance then
                    shortestDistance = offset.Magnitude
                    target = v
                end
            end
        end
    end

    if target then
        root.CFrame = target.CFrame * CFrame.new(0, 3, 0) -- ينقلك فوقها بـ 3 بلاطات بالضبط
    end
end

Tab:CreateButton({Name = "Dug Up (Next)", Callback = function() tp(1) end})
Tab:CreateButton({Name = "Dug Down (Prev)", Callback = function() tp(-1) end})

Tab:CreateToggle({Name = "Auto Collect (Cash/Gold)", Callback = function(v)
    _G.Collect = v
    while _G.Collect do
        for _, item in pairs(workspace:GetDescendants()) do
            if item:IsA("BasePart") and (item.Name:find("Cash") or item.Name:find("Gold") or item.Name:find("Coin")) then
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, item, 0)
                firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, item, 1)
            end
        end
        task.wait(0.5)
    end
end})

Tab:CreateToggle({Name = "Instant Interaction (Hold to Take)", Callback = function(v)
    _G.Instant = v
    game:GetService("RunService").Stepped:Connect(function()
        if _G.Instant then
            for _, p in pairs(workspace:GetDescendants()) do
                if p:IsA("ProximityPrompt") then
                    p.HoldDuration = 0 -- يخليك تاخذه بمجرد الضغط بدون انتظار
                end
            end
        end
    end)
end})
