repeat 
    wait()
until
game:IsLoaded()

Version = "1.0"

getgenv().Notify = function(str)
    game:GetService("StarterGui"):SetCore("SendNotification", {
	Title = "Pls Auto | " .. tostring(Version),
	Text = tostring(str),
	Duration = 5,
})

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")

local Remotes = require(ReplicatedStorage.Remotes)
local SayMessageRequest = ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest
local queueOnTeleport = queueonteleport or queue_on_teleport or syn and syn.queue_on_teleport

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer.PlayerGui
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local LocalLeaderstats = LocalPlayer:WaitForChild("leaderstats")

local Booths = PlayerGui.MapUIContainer.MapUI.BoothUI
local Booth = nil

for _, v in ipairs(workspace.BoothInteractions:GetChildren()) do
    if PlayerGui.MapUIContainer.MapUI.BoothUI["BoothUI"..tostring(v:GetAttribute("BoothSlot"))].Details.Owner.Text == "unclaimed" then
        fireproximityprompt(v.Claim, 0)
        TweenService:Create(HumanoidRootPart, TweenInfo.new(math.random(0.1, 0.2)), {CFrame = CFrame.new(v.CFrame.x + 3, v.CFrame.y + 3, v.CFrame.z + 3)}):Play()
        break
    end
end

repeat 
    for _, v in ipairs(Booths:GetChildren()) do
        if v.Details.Owner.Text:split("'")[1] == LocalPlayer.DisplayName then
         Booth = v
         break
     end
 end
until
Booth ~= nil

local BoothText = string.gsub(Booth.Details.Raised.Text:split(" ")[1], ",", "")

LocalPlayer.Idled:Connect(function()
    if Settings.AntiAfkDisconnect then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

if Settings.Beg then
    spawn(function()
        while wait(Settings.BegInterval) do
            if tostring(Settings.BegText) then
                SayMessageRequest:FireServer(tostring(Settings.BegText), "all")
            end
        end
    end)
end

Notify("Script loaded")
