if not game:IsLoaded() then
	game.Loaded:Wait()
end

local plrs = game:GetService("Players")
local repS = game:GetService("ReplicatedStorage")
local cS = game:GetService("CollectionService")

local lplr = plrs.LocalPlayer
local camera = workspace:WaitForChild("Camera")
local mouse = lplr:GetMouse()
local ltoys = workspace:WaitForChild(lplr.Name..'SpawnedInToys')
local lchar = lplr.Character
lplr.CharacterAdded:Connect(function(char)
	lchar = char
end)

local v3 = Vector3.new()
local max = math.huge

local plrsList, plrsWhitelist = {}, {}

local function addToPlayersList(plr)
	table.insert(plrsList, plr)
	if plr:IsFriendsWith(lplr.UserId) then
		table.insert(plrsWhitelist, plr)
	end
end
for _, plr in pairs(plrs:GetPlayers()) do
	addToPlayersList(plr)
end
plrs.PlayerAdded:Connect(function(plr)
	addToPlayersList(plr)
end)
plrs.PlayerRemoving:Connect(function(plr)
	table.remove(plrsList, plr)
	if plr:IsFriendsWith(lplr.UserId) then
		table.remove(plrsWhitelist, plr)
	end
end)

local function waitFor(path, tbl)
	for _, child in pairs(tbl) do
		repeat
			if not path then
				break
			end
			task.wait()
		until path:FindFirstChild(child)
		if tbl[2] == nil and path and path:FindFirstChild(child) then
			return path[child]
		end
	end
end

local function spawnToy(name, cf)
	for _, toy in pairs(ltoys:GetChildren()) do
		if toy.Name == name then
			toy:AddTag("Ignore")
		end
	end

	while true do
		if lchar.Parent == workspace then
			task.spawn(function()
				repS.MenuToys.SpawnToyRemoteFunction:InvokeServer(name, cf, v3)
			end)
		else
			break
		end

		for _, toy in pairs(ltoys:GetChildren()) do
			if not toy:HasTag("Ignore") and toy.Name == name then
				return toy
			end
		end
		task.wait()
	end
	return
end

local antiKickEnabled = false
local function antiKikc()
	if antiKickEnabled == false then
		for _, ninjaKunai in pairs(ltoys:GetChildren()) do
			local stickyPart = ninjaKunai:FindFirstChild("StickyPart")

			if stickyPart and stickyPart:FindFirstChild("StickyWeld") and stickyPart.StickyWeld:HasTag("Used") then
				repS.MenuToys.DestroyToy:FireServer(ninjaKunai)
			end
		end
	else
		pcall(function()
			if lchar:FindFirstChild("HumanoidRootPart") then
				local bool = false
				for _, obj in pairs(cS:GetTagged("Used")) do
					if obj.Name == "StickyWeld" then
						bool = true
						break
					end
				end

				if bool == false then
					local ninjaKunai = spawnToy("NinjaKunai", 
						CFrame.new(-326.24957275390625, 29.208873748779297, 284.66058349609375))

					local highlight = Instance.new("Highlight", ninjaKunai)
					highlight.FillColor = Color3.new(0.0196078, 1, 0.721569)
					
					local stickyPart = waitFor(ninjaKunai, {"StickyPart"})
					local stickyWeld = waitFor(stickyPart, {"StickyWeld"})

					repeat
						repS.PlayerEvents.StickyPartEvent:FireServer(stickyPart, lchar.Torso, CFrame.new(-0.5,-0.8,0))
						task.wait()
					until not ninjaKunai or stickyWeld and stickyWeld.Part1 == lchar.Torso

					task.spawn(function()
						while true do
							if stickyWeld then
								if stickyWeld.Part1 == lchar.Torso then
									stickyWeld:AddTag("Used")
								else
									stickyWeld:RemoveTag("Used")
								end
							else
								break
							end
							task.wait()
						end
					end)
				end
			end
		end)
	end
end

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Window = Rayfield:CreateWindow({
	Name = "b00bsHub",
	LoadingTitle = 'print("mamusosal?")',
	LoadingSubtitle = "by zq2t"
})

local CharacterTab = Window:CreateTab("Character", 4483362458)

local Toggle = CharacterTab:CreateToggle({
	Name = "Anti kick (in the plot doesn't work)",
	CurrentValue = false,
	Flag = "Toggle1",
	Callback = function(Value)
		if Value == true then
			antiKickEnabled = true
			while true do
				if antiKickEnabled == true then
					antiKikc()
				else
					break
				end
				task.wait()
			end
		else
			antiKickEnabled = false
			antiKikc()
		end
	end,
})
