local new_ptfx_dictionary = "core"
local rainLeaves = "ent_col_tree_leaves_pine"
local expLeaves = "exp_mtl_leaves"
local is_particle_effect_active = false
local current_ptfx_dictionary = new_ptfx_dictionary
local current_ptfx_handle_id = false
local ptfx_offcet_x = 0.0
local ptfx_offcet_y = 0.0
local ptfx_offcet_z = 2.0
local ptfx_rot_x = -90.0
local ptfx_rot_y = 0.0
local ptfx_rot_z = 0.0
local ptfx_scale = 1.0
local ptfx_axis_x = 0
local ptfx_axis_y = 0
local ptfx_axis_z = 0
local timeSkill = 0


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Citizen.InvokeNative(0x91AEF906BCA88877,0, 0x17BEC168) then   -- just pressed E
			if true then
				
				Citizen.InvokeNative(0xA10DB07FC234DD12, new_ptfx_dictionary) -- UseParticleFxAsset
				current_ptfx_handle_id =  Citizen.InvokeNative(0xE6CFE43937061143,expLeaves,PlayerPedId(),ptfx_offcet_x,ptfx_offcet_y,-0.3,ptfx_rot_x,ptfx_rot_y,ptfx_rot_z,ptfx_scale,ptfx_axis_x,ptfx_axis_y,ptfx_axis_z)    -- StartNetworkedParticleFxNonLoopedOnEntity
				--current_ptfx_handle_id2 =  Citizen.InvokeNative(0xE6CFE43937061143,"exp_mtl_leaves",PlayerPedId(),ptfx_offcet_x,ptfx_offcet_y,-0.3,ptfx_rot_x,ptfx_rot_y,ptfx_rot_z,ptfx_scale,ptfx_axis_x,ptfx_axis_y,ptfx_axis_z)    -- StartNetworkedParticleFxNonLoopedOnEntity
				Citizen.Wait(500)
			end
			
			for i = 1, 150 do
				
				Citizen.InvokeNative(0xA10DB07FC234DD12, new_ptfx_dictionary) -- UseParticleFxAsset
				current_ptfx_handle_id =  Citizen.InvokeNative(0xE6CFE43937061143,rainLeaves,PlayerPedId(),ptfx_offcet_x,ptfx_offcet_y,ptfx_offcet_z,ptfx_rot_x,ptfx_rot_y,ptfx_rot_z,ptfx_scale,ptfx_axis_x,ptfx_axis_y,ptfx_axis_z)    -- StartNetworkedParticleFxNonLoopedOnEntity
				--current_ptfx_handle_id2 =  Citizen.InvokeNative(0xE6CFE43937061143,"exp_mtl_leaves",PlayerPedId(),ptfx_offcet_x,ptfx_offcet_y,ptfx_offcet_z,ptfx_rot_x,ptfx_rot_y,ptfx_rot_z,ptfx_scale,ptfx_axis_x,ptfx_axis_y,ptfx_axis_z)    -- StartNetworkedParticleFxNonLoopedOnEntity
				
				current_ptfx_handle_id2 =  Citizen.InvokeNative(0xE6CFE43937061143,expLeaves,playerPed,ptfx_offcet_x,ptfx_offcet_y,0,90,ptfx_rot_y,ptfx_rot_z,ptfx_scale,ptfx_axis_x,ptfx_axis_y,ptfx_axis_z)    -- StartNetworkedParticleFxNonLoopedOnEntity
				Citizen.Wait(100)
				timeSkill += 100
				if timeSkill == 2000 or timeSkill == 4000 or timeSkill == 6000 or timeSkill == 8000 or timeSkill == 10000 or timeSkill == 12000 or timeSkill == 14000 then
					print(timeSkill)
					Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, GetHashKey("KIT_EMOTE_ACTION_PRAYER_1"), 1, 1, 0, 0, 0)
					Citizen.Wait(1400)
					healNearestPlayerRemotely()
					Citizen.Wait(1600)
				end
				if timeSkill >= 14000 then
					timeSkill = 0
					return
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
    else
        print("error")
    end
end


RegisterNetEvent('healing:receiveHeal')
AddEventHandler('healing:receiveHeal', function()
    local target = PlayerPedId()
    local health = GetEntityHealth(target)
    health = health + 100
    local maxHealth = Citizen.InvokeNative(0x5C4C3D098A4FFD70, target)
	Citizen.InvokeNative(0xA10DB07FC234DD12, new_ptfx_dictionary)
	current_ptfx_handle_id2 =  Citizen.InvokeNative(0xE6CFE43937061143,expLeaves,target,ptfx_offcet_x,ptfx_offcet_y,0,90,ptfx_rot_y,ptfx_rot_z,ptfx_scale,ptfx_axis_x,ptfx_axis_y,ptfx_axis_z)    -- StartNetworkedParticleFxNonLoopedOnEntity
    SetEntityHealth(target, health)
end)
