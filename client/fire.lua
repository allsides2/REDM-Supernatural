local count=-90
local skill=false
local TIME_SKILL_FIRE = 0



RegisterNetEvent('skill:FIRE_AREA')
AddEventHandler('skill:FIRE_AREA', function()
	if TIME_SKILL_FIRE == 0 then
		TIME_SKILL_FIRE=Config.skills["FIRE_AREA"].cd
		setFireNearestPlayers()
		--TriggerServerEvent('fire:server:set_fire',closestPlayer) 
		--TriggerServerEvent('fire:server:set_fire') 
		Citizen.InvokeNative(0xA10DB07FC234DD12, "anm_rally") -- UseParticleFxAsset
		Citizen.InvokeNative(0xE6CFE43937061143,"ent_anim_rally_cross_fire",PlayerPedId(), 0.0, 1.0, -0.5, -90.0, 0, 0.0, 1.0, 0, 0, 0)
		Citizen.InvokeNative(0xA10DB07FC234DD12, "anm_rally") -- UseParticleFxAsset
		Citizen.InvokeNative(0xE6CFE43937061143,"ent_anim_rally_cross_fire",PlayerPedId(), 0.0, -1.0, -0.5, -90.0, 0, 0.0, 1.0, 0, 0, 10)
		Citizen.InvokeNative(0xA10DB07FC234DD12, "anm_rally") -- UseParticleFxAsset
		Citizen.InvokeNative(0xE6CFE43937061143,"ent_anim_rally_cross_fire",PlayerPedId(), -1.0, 0.0, -0.5, -90.0,-90.0, 0.0, 1.0, 1, 0, 0)
		Citizen.InvokeNative(0xA10DB07FC234DD12, "anm_rally") -- UseParticleFxAsset
		Citizen.InvokeNative(0xE6CFE43937061143,"ent_anim_rally_cross_fire",PlayerPedId(), 1.0, 0.0, -0.5, -90.0,90.0, 0.0, 1.0, 1, 0, 0)
		Citizen.InvokeNative(0xA10DB07FC234DD12, "anm_rally") -- UseParticleFxAsset
		Citizen.InvokeNative(0xE6CFE43937061143,"ent_anim_rally_cross_fire",PlayerPedId(), -0.75, 0.75, -0.5, -90.0,0.0, 45.0, 1.0, 1, 0, 0)
		Citizen.InvokeNative(0xA10DB07FC234DD12, "anm_rally") -- UseParticleFxAsset
		Citizen.InvokeNative(0xE6CFE43937061143,"ent_anim_rally_cross_fire",PlayerPedId(), 0.75, 0.75, -0.5, -90.0,0.0, -45.0, 1.0, 1, 0, 0)
		Citizen.InvokeNative(0xA10DB07FC234DD12, "anm_rally") -- UseParticleFxAsset
		Citizen.InvokeNative(0xE6CFE43937061143,"ent_anim_rally_cross_fire",PlayerPedId(), 0.75, -0.75, -0.5, -90.0,90.0, -45.0, 1.0, 1, 0, 0)
		Citizen.InvokeNative(0xA10DB07FC234DD12, "anm_rally") -- UseParticleFxAsset
		Citizen.InvokeNative(0xE6CFE43937061143,"ent_anim_rally_cross_fire",PlayerPedId(), -0.75, -0.75, -0.5, -90.0,-90.0, 45.0, 1.0, 1, 0, 0)
		while true do
			Citizen.Wait(1000)
			print(TIME_SKILL_FIRE)
			TIME_SKILL_FIRE = TIME_SKILL_FIRE-1
			print("finalizouskill")
			if TIME_SKILL_FIRE == 0 then return end

		end
	end


end)


RegisterNetEvent('fire:client:set_fire')
AddEventHandler('fire:client:set_fire', function()
	local target = PlayerPedId()

	Citizen.InvokeNative(0xA10DB07FC234DD12, "anm_fire") -- UseParticleFxAsset
	Citizen.InvokeNative(0xE6CFE43937061143,"ent_anim_fire_fuel_burst",target, 0.0, 0.0, 0.0, 0.0,0.0, 0.0, 1.0, 0, 0, 0)
end)

function setFireNearestPlayers()
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
		TriggerServerEvent('fire:server:set_fire', GetPlayerServerId(closestPlayer))       
    end
end



