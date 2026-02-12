-- 5z Hub - CHAT COMMAND SENDER (LOCAL / EDUCATIF)

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local channel = TextChatService.ChatInputBarConfiguration.TargetTextChannel
local playerButtons = {}

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "5zHub"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 520, 0, 360)
main.Position = UDim2.new(0.5, -260, 0.5, -180)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 18)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(120, 80, 255)
stroke.Transparency = 0.2

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "5z Hub - Admin Spammer"
title.TextColor3 = Color3.fromRGB(200, 180, 255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 28

-- ===== BOUTON FERMER (DESTROY TOTAL) =====
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 35, 0, 35)
closeButton.Position = UDim2.new(1, -45, 0, 8)
closeButton.Text = "✕"
closeButton.Font = Enum.Font.GothamBold
closeButton.TextSize = 20
closeButton.TextColor3 = Color3.new(1,1,1)
closeButton.BackgroundColor3 = Color3.fromRGB(170, 60, 60)
closeButton.Parent = main
Instance.new("UICorner", closeButton).CornerRadius = UDim.new(1, 0)

closeButton.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- ===== BOUTON HIDE (GAUCHE) =====
local hideButton = Instance.new("TextButton")
hideButton.Size = UDim2.new(0, 35, 0, 35)
hideButton.Position = UDim2.new(0, 10, 0, 8)
hideButton.Text = "-"
hideButton.Font = Enum.Font.GothamBold
hideButton.TextSize = 22
hideButton.TextColor3 = Color3.new(1,1,1)
hideButton.BackgroundColor3 = Color3.fromRGB(60, 60, 170)
hideButton.Parent = main
Instance.new("UICorner", hideButton).CornerRadius = UDim.new(1, 0)

-- LISTE JOUEURS
local list = Instance.new("ScrollingFrame", main)
list.Position = UDim2.new(0.05, 0, 0.18, 0)
list.Size = UDim2.new(0.4, 0, 0.75, 0)
list.CanvasSize = UDim2.new(0, 0, 0, 0)
list.ScrollBarImageTransparency = 0.4
list.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
Instance.new("UICorner", list).CornerRadius = UDim.new(0, 12)

local layout = Instance.new("UIListLayout", list)
layout.Padding = UDim.new(0, 8)

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	list.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end)

local panel = Instance.new("Frame", main)
panel.Position = UDim2.new(0.5, 0, 0.25, 0)
panel.Size = UDim2.new(0.45, 0, 0.6, 0)
panel.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 14)

local panelText = Instance.new("TextLabel", panel)
panelText.Size = UDim2.new(1, -10, 1, -10)
panelText.Position = UDim2.new(0, 5, 0, 5)
panelText.BackgroundTransparency = 1
panelText.TextWrapped = true
panelText.TextColor3 = Color3.fromRGB(230,230,230)
panelText.Font = Enum.Font.GothamBold
panelText.TextSize = 20
panelText.Text = "Clique sur un joueur"

-- KEYBIND INDICATOR
local keybindIndicator = Instance.new("TextLabel")
keybindIndicator.Size = UDim2.new(0.45, 0, 0, 28)
keybindIndicator.Position = UDim2.new(0.5, 0, 0.88, 0)
keybindIndicator.Text = "KEYBIND : G"
keybindIndicator.Font = Enum.Font.GothamBold
keybindIndicator.TextSize = 14
keybindIndicator.TextColor3 = Color3.new(1,1,1)
keybindIndicator.BackgroundColor3 = Color3.fromRGB(170, 60, 60)
keybindIndicator.Parent = main
Instance.new("UICorner", keybindIndicator).CornerRadius = UDim.new(0, 8)

-- ===== NOTIFICATION =====
local function notify()
	StarterGui:SetCore("SendNotification", {
		Title = "5z AP-Spammer",
		Text = "Appuie sur 'K' pour afficher le menu",
		Duration = 4
	})
end

notify()

-- ===== HIDE / SHOW SYSTEM =====
local menuVisible = true

local function toggleMenu()
	menuVisible = not menuVisible
	main.Visible = menuVisible
	
	if not menuVisible then
		notify()
	end
end

hideButton.MouseButton1Click:Connect(toggleMenu)

-- ===== ENVOI CHAT =====
local function sendChatCommand(target)
	local msg1 = ":balloon " .. target.Name
	local msg2 = ":rocket " .. target.Name
	local msg3 = ":jumpscare " .. target.Name

	channel:SendAsync(msg1)
	task.wait()
	channel:SendAsync(msg2)
	task.wait()
	channel:SendAsync(msg3)

	panelText.Text =
		"Envoyé :\n" ..
		msg1 .. "\n" ..
		msg2 .. "\n" ..
		msg3
end

local function getOtherPlayer()
	local players = Players:GetPlayers()
	if #players == 2 then
		for _, plr in ipairs(players) do
			if plr ~= player then
				return plr
			end
		end
	end
	return nil
end

local function updateButtonColors()
	local playerCount = #Players:GetPlayers()

	for plr, btn in pairs(playerButtons) do
		if plr == player then
			btn.BackgroundColor3 = Color3.fromRGB(40, 170, 90)
		else
			if playerCount == 2 then
				btn.BackgroundColor3 = Color3.fromRGB(170, 60, 60)
			else
				btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
			end
		end
	end

	if playerCount == 2 then
		keybindIndicator.BackgroundColor3 = Color3.fromRGB(40, 170, 90)
	else
		keybindIndicator.BackgroundColor3 = Color3.fromRGB(170, 60, 60)
	end
end

local function addPlayer(plr)
	if playerButtons[plr] then return end

	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.Text = plr.Name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 18
	btn.TextColor3 = Color3.new(1,1,1)
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
	btn.Parent = list

	btn.MouseButton1Click:Connect(function()
		sendChatCommand(plr)
	end)

	playerButtons[plr] = btn
	updateButtonColors()
end

local function removePlayer(plr)
	if playerButtons[plr] then
		playerButtons[plr]:Destroy()
		playerButtons[plr] = nil
	end
	updateButtonColors()
end

-- KEYBINDS
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then return end

	if input.KeyCode == Enum.KeyCode.G then
		local target = getOtherPlayer()
		if target then
			sendChatCommand(target)
		end
	end
	
	if input.KeyCode == Enum.KeyCode.K then
		toggleMenu()
	end
end)

for _, plr in ipairs(Players:GetPlayers()) do
	addPlayer(plr)
end

Players.PlayerAdded:Connect(addPlayer)
Players.PlayerRemoving:Connect(removePlayer)

updateButtonColors()
