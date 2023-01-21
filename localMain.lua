local player = game:GetService("Players").LocalPlayer
local mouse = player:GetMouse()

local remote = script:WaitForChild("remote")

local mouseHit

script.Parent.Activated:Connect(function()
	mouseHit = mouse.Button1Down:Connect(function()
		remote:FireServer(mouse.Hit.Position)
	end)
end)

script.Parent.Deactivated:Connect(function()
	mouseHit:Disconnect()
end)
