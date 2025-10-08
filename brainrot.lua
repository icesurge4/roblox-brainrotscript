local Players = game:GetService("Players")

print("🧠 Brainrot запущен! Команды: !clone и !unclone")

local currentClone = nil

local function activateBrainrot()
    local player = Players.LocalPlayer
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    if currentClone then
        currentClone:Destroy()
    end
    
    local clone = character:Clone()
    clone.Name = "BrainrotClone"
    currentClone = clone
    
    for _, part in pairs(clone:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 0.3
            part.BrickColor = BrickColor.new("Bright purple")
            part.Anchored = true
        end
    end
    
    clone:SetPrimaryPartCFrame(humanoidRootPart.CFrame)
    clone.Parent = workspace
    
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
        end
    end
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "BRAINROT",
        Text = "Клон создан! Вы невидимы.",
        Duration = 3
    })
end

local function deactivateBrainrot()
    if currentClone then
        currentClone:Destroy()
        currentClone = nil
    end
    
    local player = Players.LocalPlayer
    local character = player.Character
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
            end
        end
    end
    
    game.StarterGui:SetCore("SendNotification", {
        Title = "BRAINROT",
        Text = "Клон удален! Вы видимы.",
        Duration = 3
    })
end

Players.LocalPlayer.Chatted:Connect(function(message)
    if message == "!clone" then
        activateBrainrot()
    elseif message == "!unclone" then
        deactivateBrainrot()
    end
end)

print("🎯 Напишите в чат: !clone или !unclone")
