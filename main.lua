-- 5z Hub - CHAT COMMAND SENDER (LOCAL / EDUCATIF)

local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local player = Players.LocalPlayer

-- ===== CHAT CHANNEL =====
local channel = TextChatService.ChatInputBarConfiguration.TargetTextChannel

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

-- TITRE
local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "5z Hub - Admin Spammer"
title.TextColor3 = Color3.fromRGB(200, 180, 255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 28

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

-- PANEL ACTION
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

-- ===== ENVOI CHAT =====
local function sendChatCommand(target)
	local msg1 = ":balloon " .. target.Name
	local msg2 = ":rocket " .. target.Name
	local msg3 = ":tiny " .. target.Name

	channel:SendAsync(msg1)
	task.wait(0.5)

	channel:SendAsync(msg2)
	task.wait(0.5)

	channel:SendAsync(msg3)

	panelText.Text =
		"Envoyé :\n" ..
		msg1 .. "\n" ..
		msg2 .. "\n" ..
		msg3
end

-- BOUTON JOUEUR
local function addPlayer(plr)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -10, 0, 40)
	btn.Text = plr.Name
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 18
	btn.TextColor3 = Color3.new(1,1,1)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
	btn.Parent = list

	btn.MouseButton1Click:Connect(function()
		sendChatCommand(plr)
	end)

	layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		list.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
	end)
end

-- INIT
for _, plr in ipairs(Players:GetPlayers()) do
	addPlayer(plr)
end

Players.PlayerAdded:Connect(addPlayer)
