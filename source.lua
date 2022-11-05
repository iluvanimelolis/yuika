--[[

    Supported Executors:
                        [Synapse X]
    
    Supported Games:
                    [✅] Da Hood (https://www.roblox.com/games/2788229376/Da-Hood)
                    [✅] Hood Modded (https://www.roblox.com/games/5602055394/Hood-Modded)
                    [✅] Untitled Hood (https://www.roblox.com/games/9183932460/Untitled-Hood)
                    [✅] Da Hood Aim Trainer (https://www.roblox.com/games/9824221333/UPDATE-Da-Hood-Aim-Trainer)
    Update Logs: 
                [10/10/22] - [/] Source On GitHub (ketaminee)
                [11/05/22] - [-] ts not maintained anymore 
]]--


getgenv().Settings = {
    Key = "Q";
    AAKey = "Z";
    Target = nil;
    AAEnabled = false;
    Prediction = 0.135;
    Part = "HumanoidRootPart";
}

local Players = game:GetService("Players")
local Input = game:GetService("UserInputService")
local Client = Players.LocalPlayer
local Mouse = Client:GetMouse()
local CurrentCamera = workspace.CurrentCamera
local Dot = Drawing.new("Circle")
local Block = Instance.new("Part", game.Workspace)

Block.Anchored = true
Block.Shape = Enum.PartType.Block
Block.CanCollide = false
Block.Size = Vector3.new(10, 10, 10)
Block.Transparency = 0.65

Dot.Color = Color3.fromRGB(251, 51, 163)
Dot.Radius = 5
Dot.Filled = true
Dot.Thickness = 2
Dot.Transparency = 1

getgenv().GetClosestPlayer = function()
    local closest = {}
    local distance = math.huge
    local player = nil
    for i, plr in pairs(Players:GetPlayers()) do
        if plr ~= Client and plr.Character then
            local os, si = plr.Character:GetBoundingBox()
            local pos = os.Position
            if pos then
                local point = CurrentCamera.WorldToViewportPoint(CurrentCamera, pos)
                local dist = (Vector2.new(Mouse.X, Mouse.Y + 36) - Vector2.new(point.X, point.Y)).Magnitude
                if dist <= distance then
                    player = plr
                    distance = dist
                end
            end
        end
    end
    return player
end

game.RunService.RenderStepped:Connect(function()
    local ToPosition = CurrentCamera:WorldToViewportPoint(Players[getgenv().Settings.Target].Character.LowerTorso.Position) -- + (Players[getgenv().Settings.Target].Character.UpperTorso.Velocity * getgenv().Settings.Prediction)
    Dot.Position = Vector2.new(ToPosition.X, ToPosition.Y)
    Block.CFrame = CFrame.new(Players[getgenv().Settings.Target].Character.LowerTorso.Position + (Players[getgenv().Settings.Target].Character.LowerTorso.Velocity * getgenv().Settings.Prediction))
end)

game.RunService.RenderStepped:Connect(function()
    if getgenv().Settings.AAEnabled then
        local OldVelocity = Client.Character.HumanoidRootPart.Velocity
        Client.Character.HumanoidRootPart.Velocity = Vector3.new(OldVelocity.X, -35, OldVelocity.Z)
        Client.Character.HumanoidRootPart.Velocity = Vector3.new(OldVelocity.X, OldVelocity.Y, OldVelocity.Z)
        Client.Character.HumanoidRootPart.Velocity = Vector3.new(OldVelocity.X, -35, OldVelocity.Z)
        Client.Character.Humanoid.HipHeight = 2.80
    end
    if getgenv().Settings.Target ~= nil then
        Dot.Visible = true
    else
        Dot.Visible = false
        Block.CFrame = CFrame.new(0, -9999, 0)
    end
end)

Input.InputBegan:Connect(function(Key, Typing)
    if Typing then return end
    if Key.KeyCode == Enum.KeyCode[getgenv().Settings.Key] then
        if getgenv().Settings.Target ~= nil then
            getgenv().Settings.Target = nil
        else
            getgenv().Settings.Target = tostring(GetClosestPlayer())
        end
    end
    if Key.KeyCode == Enum.KeyCode[getgenv().Settings.AAKey] then
        if getgenv().Settings.AAEnabled then
            getgenv().Settings.AAEnabled = false
            Client.Character.Humanoid.HipHeight = 2
        elseif not getgenv().Settings.AAEnabled then
            getgenv().Settings.AAEnabled = true
        end
    end
end)

local Old = nil
Old = hookmetamethod(game, "__namecall", function(...)
    local args = { ... }
    local method = getnamecallmethod()
    
    if getgenv().Settings.Target ~= nil and method == "FireServer" then
        if args[2] == "MousePos" or args[2] == "UpdateMousePos" then 
            args[3] = Players[getgenv().Settings.Target].Character[getgenv().Settings.Part].Position + (Players[getgenv().Settings.Target].Character[getgenv().Settings.Part].Velocity * getgenv().Settings.Prediction)
            return Old(unpack(args))
        end
    end
    
    return Old(...)
end)
