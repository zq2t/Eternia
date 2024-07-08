local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local Plr = Players.LocalPlayer
local PlrToys = Workspace[Plr.Name..'SpawnedInToys']


local function AddPopupWindow(Text, Gray)
	local GameCorrectionsGui = Plr.PlayerGui.GameCorrectionsGui

	local Container = Instance.new("Frame", GameCorrectionsGui)
	Container.Size = UDim2.new(0.5,0,0,-100)
	Container.Transparency = 1
	Container.Position = UDim2.new(0.25,0,2,0)

	local CorrectionsLabel = GameCorrectionsGui.TweenFrame.MovedOtherPlayerTooQuickly.TextLabel:Clone()
	CorrectionsLabel.Parent = Container
	CorrectionsLabel.Text = Text
	if Gray == true then
		CorrectionsLabel.TextColor3 = Color3.new(0.737255, 0.737255, 0.737255)
	end
	local StartTween = TweenService:Create(Container, TweenInfo.new(0.25), {Position = UDim2.new(0.25,0,1,0)})
	StartTween:Play() wait(3)
	local EndedTween = TweenService:Create(Container, TweenInfo.new(1.5), {Position = UDim2.new(0.25,0,2,0)})
	EndedTween:Play() wait(1.5)
	Container:Destroy()
end

AddPopupWindow("You don't have permission.")
