-- written by chapel1337
-- made on 1/20/2023
-- first gear i have ever made, model made by roblox

local player = script.Parent.Parent.Parent
local mouse = player:GetMouse()

local tool = script.Parent
local localMain = tool.localMain

tool.ToolTip = "I LOVE GLAGGLELAND!!!!!! (made by chapel1337)"

local launcher = tool.launcher
local unlaunchedMissile = launcher.missile

local equipCooldown = 0

tool.Equipped:Connect(function()
	launcher.equip.Playing = true
end)

tool.Unequipped:Connect(function()
	launcher.equip.TimePosition = 0
	launcher.equip.Playing = false
end)

tool.Activated:Connect(function()
	task.spawn(function()
		local missile = unlaunchedMissile:Clone()
		missile.Parent = workspace
		missile.missileWeld:Destroy()
		missile.Anchored = true
		
		local hit
		local alpha = 0.08
		
		local connection = localMain.remote.OnServerEvent:Connect(function(player, mouseHit)
			hit = mouseHit
		end)
		
		while task.wait(0.01) do
			-- thanks jac
			if alpha > 1 then
				break
			end
			
			if #missile:GetTouchingParts() > 0 then
				break
			end
			
			missile.Position = missile.Position:Lerp(hit, alpha)
			alpha += 0.08
		end
		
		missile:Destroy()
		
		local explosion = Instance.new("Explosion", workspace)
		explosion.Position = missile.Position
		explosion.ExplosionType = Enum.ExplosionType.NoCraters
		explosion.BlastPressure = 15
		explosion.BlastRadius = 15
		
		connection:Disconnect()
	end)
	
	unlaunchedMissile.Transparency = 1
	unlaunchedMissile.smil.Transparency = 1
	
	task.wait(1.5)
	launcher.reload.Playing = true
	task.wait(2.5)
	
	unlaunchedMissile.Transparency = 0
	unlaunchedMissile.smil.Transparency = 0
end)
