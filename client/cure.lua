local timeSkill = 0
local TIME_SKILL_CURE_AREA = 0


RegisterNetEvent('skill:HEAL_AREA')
AddEventHandler('skill:HEAL_AREA', function(class)
	if TIME_SKILL_CURE_AREA == 0 then
		TIME_SKILL_CURE_AREA=Config.skills["HEAL_AREA"].cd
		Citizen.InvokeNative(0xA10DB07FC234DD12, "core") -- UseParticleFxAsset
		current_ptfx_handle_id = Citizen.InvokeNative(0xE6CFE43937061143, "exp_mtl_leaves", PlayerPedId(), 0.0, 0.0, -0.3, -90.0, 0.0, 0.0, 1.0, 0, 0, 0) -- StartNetworkedParticleFxNonLoopedOnEntity
		Citizen.Wait(500)
		for i = 1, 150 do
			Citizen.InvokeNative(0xA10DB07FC234DD12, "core") -- UseParticleFxAsset
			current_ptfx_handle_id = Citizen.InvokeNative(0xE6CFE43937061143, "ent_col_tree_leaves_pine", PlayerPedId(), 0.0, 0.0, 2.0, -90.0, 0.0, 0.0, 1.0, 0, 0, 0) -- StartNetworkedParticleFxNonLoopedOnEntity
			current_ptfx_handle_id2 = Citizen.InvokeNative(0xE6CFE43937061143, "exp_mtl_leaves", playerPed, 0.0, 0.0, 0, 90, 0.0, 0.0, 1.0, 0, 0, 0) -- StartNetworkedParticleFxNonLoopedOnEntity
			Citizen.Wait(100)
			timeSkill = timeSkill + 100
			if timeSkill == 2000 or timeSkill == 4000 or timeSkill == 6000 or timeSkill == 8000 or timeSkill == 10000 or timeSkill == 12000 or timeSkill == 14000 then
				print(timeSkill)
				Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, GetHashKey("KIT_EMOTE_ACTION_PRAYER_1"), 1, 1, 0, 0, 0)
				Citizen.Wait(1400)
				healNearestPlayerRemotely()
				Citizen.Wait(1600)
			end
			if timeSkill >= 14000 then
				timeSkill = 0
				while true do
					Citizen.Wait(1000)
					print(TIME_SKILL_CURE_AREA)
					TIME_SKILL_CURE_AREA = TIME_SKILL_CURE_AREA-1
					print("finalizou------------------------------")
					if TIME_SKILL_CURE_AREA == 0 then return end
				end
			end
		end

	end
end)

function healNearestPlayerRemotely()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed, true, true)
	local closestPlayer = nil
	local closestDistance = 5.0
	for _, player in pairs(GetActivePlayers()) do
		local targetPed = GetPlayerPed(player)
		if targetPed ~= playerPed then
			local targetCoords = GetEntityCoords(targetPed, true, true)
			local distance = #(targetCoords - coords)
			print("Distance to player " .. player .. ": " .. distance)
			if distance < closestDistance then
				closestDistance = distance
				closestPlayer = player
			end
		end
	end

	if closestPlayer then
		TriggerServerEvent('healing:applyHealToPlayer', GetPlayerServerId(closestPlayer))
	end
end

RegisterNetEvent('healing:receiveHeal')
AddEventHandler('healing:receiveHeal', function()
	local target = PlayerPedId()
	local health = GetEntityHealth(target)
	health = health + 100
	local maxHealth = Citizen.InvokeNative(0x5C4C3D098A4FFD70, target)
	Citizen.InvokeNative(0xA10DB07FC234DD12, "core")
	current_ptfx_handle_id2 = Citizen.InvokeNative(0xE6CFE43937061143, "exp_mtl_leaves", target, 0.0, 0.0, 0, 90, 0.0, 0.0, 1.0, 0, 0, 0) -- StartNetworkedParticleFxNonLoopedOnEntity
	SetEntityHealth(target, health)
end)



function DrawText3D(x, y, z, text)
	local onScreen, screenX, screenY = GetScreenCoordFromWorldCoord(x, y, z)
	SetTextScale(0.35, 0.35)
	SetTextFontForCurrentCommand(1)
	SetTextColor(255, 255, 255, 223)
	SetTextCentre(1)
	DisplayText(CreateVarString(10, "LITERAL_STRING", text), screenX, screenY)
end

