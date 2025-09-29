game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Configuration
local BRAINROT_COLOR = Color3.fromRGB(170, 0, 255)
local BRAINROT_TRANSPARENCY = 0.5
local PULSE_SPEED = 3

-- Storage for brainrot data
local brainrotPlayers = {}

-- Function to activate Brainrot
local function activateBrainrot(player)
    if brainrotPlayers[player] then return end
    
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidR…
[15:15, 9/29/2025] Тимур: -- Roblox Brainrot Script - Server sees clone, player moves invisibly
-- GitHub: https://github.com/ВАШ_USERNAME/roblox-brainrot-script

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Configuration
local BRAINROT_COLOR = Color3.fromRGB(170, 0, 255)
local brainrotData = {}

-- RemoteEvents
local StealBrainrot = game.ReplicatedStorage:FindFirstChild("StealBrainrot") or Instance.new("RemoteEvent", game.ReplicatedStorage)
StealBrainrot.Name = "StealBrainrot"

local SyncPosition = game.ReplicatedStorage:FindFirstChild("SyncBrainrotPosition") or Instance.new("RemoteEvent", game.ReplicatedStorage)
SyncPosition.Name = "SyncBrainrotPosition"

local BrainrotAttack = game.ReplicatedStorage:FindFirstChild("BrainrotAttack") or Instance.new("RemoteEvent", game.ReplicatedStorage)
BrainrotAttack.Name = "BrainrotAttack"

-- Create server clone
local function createServerClone(player)
    local character = player.Character
    if not character then return end
    
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    -- Remove old clone
    local oldClone = workspace:FindFirstChild("ServerClone_" .. player.Name)
    if oldClone then oldClone:Destroy() end
    
    -- Create server clone
    local serverClone = character:Clone()
    serverClone.Name = "ServerClone_" .. player.Name
    
    -- Configure clone
    for _, part in pairs(serverClone:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Anchored = true
            part.CanCollide = false
            part.Transparency = 0.3
            part.BrickColor = BrickColor.new("Bright violet")
            part.Material = Enum.Material.Neon
        end
    end
    
    -- Add glow
    local glow = Instance.new("PointLight")
    glow.Brightness = 2
    glow.Range = 8
    glow.Color = BRAINROT_COLOR
    glow.Parent = serverClone:FindFirstChild("HumanoidRootPart")
    
    serverClone.Parent = workspace
    
    -- Make real character invisible
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
            part.CanCollide = false
        end
    end
    
    -- Store data
    brainrotData[player] = {
        serverClone = serverClone,
        realCharacter = character,
        active = true
    }
    
    player:SetAttribute("HasBrainrot", true)
    return serverClone
end

-- Activate Brainrot
local function activateBrainrot(player)
    if brainrotData[player] then return end
    createServerClone(player)
    
    if player == Players.LocalPlayer then
        game.StarterGui:SetCore("SendNotification", {
            Title = "🧠 BRAINROT ACTIVATED",
            Text = "Server sees clone, you move invisibly!",
            Duration = 5
        })
    end
end

-- Deactivate Brainrot
local function deactivateBrainrot(player)
    local data = brainrotData[player]
    if not data then return end
    
    if data.serverClone then data.serverClone:Destroy() end
    
    if data.realCharacter then
        for _, part in pairs(data.realCharacter:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0
                part.CanCollide = true
            end
        end
    end
    
    brainrotData[player] = nil
    player:SetAttribute("HasBrainrot", false)
end

-- Steal Brainrot
local function stealBrainrot(stealer, target)
    if brainrotData[target] then
        deactivateBrainrot(target)
        activateBrainrot(stealer)
    else
        activateBrainrot(stealer)
    end
end

-- Handle attacks
local function handleBrainrotAttack(attacker, target)
    local targetData = brainrotData[target]
    if targetData and targetData.realCharacter then
        local humanoid = targetData.realCharacter:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:TakeDamage(10)
        end
    end
end

-- GUI
local function createGUI()
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
