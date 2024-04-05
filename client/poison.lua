
local TIME_SKILL_POISON_AREA = 0

--Citizen.CreateThread(function()
--    while true do
--        Citizen.Wait(0)
--            if Citizen.InvokeNative(0x91AEF906BCA88877,0, 0x17BEC168) then   -- pressed E
--            local explosionTag_id = 35  -- EXP_TAG_BULLET
--            local explosion_vfxTag_hash = 0x7DD07579 	-- applies effect exp_lightning_strike, if native ADD_EXPLOSION_WITH_USER_VFX is used
--            local ped = PlayerPedId()
--            local ped_coords = GetEntityCoords(ped)
--            local x,y,z = table.unpack(ped_coords)
--            local forward_fix = 0
--            local forwardX=GetEntityForwardX(ped)
--            local forwardY=GetEntityForwardY(ped)
--            local explosion_coords_x = x+(forwardX*forward_fix)
--            local explosion_coords_y = y+(forwardY*forward_fix)
--            local explosion_coords_z = z
--            local damageScale = 4.0
--            local isAudible = false
--            local isInvisible = false
--            local cameraShake = true
--            local heading = GetEntityHeading(ped)
--                
--
--            -- ADD_EXPLOSION_WITH_USER_VFX:
--            --Citizen.InvokeNative(0x53BA259F3A67A99E, explosion_coords_x, explosion_coords_y, explosion_coords_z, explosionTag_id, explosion_vfxTag_hash, damageScale, isAudible, isInvisible, cameraShake)
-- 
--            -- ADD_EXPLOSION:
--            
--            Citizen.InvokeNative(0x7D6F58F69DA92530, explosion_coords_x, explosion_coords_y, explosion_coords_z, explosionTag_id, damageScale, isAudible, isInvisible, cameraShake)
--           --Citizen.InvokeNative(0xA10DB07FC234DD12, "scr_poisoned_well") -- UseParticleFxAsset
--           --Citizen.InvokeNative(0xE6CFE43937061143,"scr_poisoned_well_exp",PlayerPedId(), 0.0, 0.0, 0.0, -90.0,0.0, 0.0, 0.5, 0, 0, 0)
--            SetEntityVisible(PlayerPedId(), false)
--            Citizen.Wait(400)
--            teleport(heading)
--            
--
--            Citizen.InvokeNative(0xA10DB07FC234DD12, "scr_fussar1") -- UseParticleFxAsset
--            
--           -- Citizen.InvokeNative(0xE6CFE43937061143,"scr_ntvs3_exp_fortwall",PlayerPedId(), 0.0, 0.0, 0.0, -90.0,0.0, 0.0, 0.7, 0, 0, 0)
--            Citizen.InvokeNative(0xE6CFE43937061143,"scr_fussar1_exp_roof",PlayerPedId(), 0.0, 0.0-0.5, 0.0, -90.0,0.0, 0.0, 0.7, 0, 0, 0)
--            --applyParticleEffectOnEntity(ped, 300)
--            Citizen.Wait(200)
--            SetEntityVisible(PlayerPedId(), true)
--
--        end
--    end
--end)
      
function applyParticleEffectOnEntity(entity, duration)
    local ptfxDictionary = "des_mob3"
    local ptfxName = "ent_ray_mob3_crash_exp"
    local particleHandle

    if not HasNamedPtfxAssetLoaded(ptfxDictionary) then
        RequestNamedPtfxAsset(ptfxDictionary)
        while not HasNamedPtfxAssetLoaded(ptfxDictionary) do
            Citizen.Wait(0)
        end
    end

    if HasNamedPtfxAssetLoaded(ptfxDictionary) then
        UseParticleFxAsset(ptfxDictionary)
        particleHandle = StartParticleFxLoopedOnEntity(ptfxName, entity, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, false, false, false)
        Citizen.Wait(duration)  -- Leave the effect active for the specified time (2 seconds)
        StopParticleFxLooped(particleHandle, false)
    else
        print("Could not load ptfx dictionary!")
    end
end






function teleport(heading)
    local ped = PlayerPedId()
    local ped_coords = GetEntityCoords(ped)
    local forward_fix = 10 -- Distância à frente que o jogador será teleportado

    -- Calcula a posição para onde o jogador está olhando
    local forwardX = GetEntityForwardX(ped)
    local forwardY = GetEntityForwardY(ped)
    local x, y, z = table.unpack(ped_coords)
    local teleport_coords_x = x + (forwardX * forward_fix)
    local teleport_coords_y = y + (forwardY * forward_fix)
    local teleport_coords_z = z

    -- Teleporta o jogador para a posição calculada
    Citizen.InvokeNative(0x203BEFFDBE12E96A, ped, vector3(teleport_coords_x, teleport_coords_y, teleport_coords_z), heading)
end





RegisterNetEvent('skill:POISON_AREA')
AddEventHandler('skill:POISON_AREA', function(class)
    if TIME_SKILL_POISON_AREA == 0 then
        TIME_SKILL_POISON_AREA=Config.skills["POISON_AREA"].cd

        local explosionTag_id = 35  -- EXP_TAG_BULLET
        local explosion_vfxTag_hash = 0x7DD07579 	-- applies effect exp_lightning_strike, if native ADD_EXPLOSION_WITH_USER_VFX is used
        local ped = PlayerPedId()
        local ped_coords = GetEntityCoords(ped)
        local x,y,z = table.unpack(ped_coords)
        local forward_fix = 0
        local forwardX=GetEntityForwardX(ped)
        local forwardY=GetEntityForwardY(ped)
        local explosion_coords_x = x+(forwardX*forward_fix)
        local explosion_coords_y = y+(forwardY*forward_fix)
        local explosion_coords_z = z
        local damageScale = 4.0
        local isAudible = false
        local isInvisible = false
        local cameraShake = true
        local heading = GetEntityHeading(ped)

        
        Citizen.InvokeNative(0x7D6F58F69DA92530, explosion_coords_x, explosion_coords_y, explosion_coords_z, explosionTag_id, damageScale, isAudible, isInvisible, cameraShake)
        SetEntityVisible(PlayerPedId(), false)
        Citizen.Wait(400)
        teleport(heading)
        

        Citizen.InvokeNative(0xA10DB07FC234DD12, "scr_fussar1") -- UseParticleFxAsset

        Citizen.InvokeNative(0xE6CFE43937061143,"scr_fussar1_exp_roof",PlayerPedId(), 0.0, 0.0-0.5, 0.0, -90.0,0.0, 0.0, 0.7, 0, 0, 0)
        
        Citizen.Wait(200)
        SetEntityVisible(PlayerPedId(), true)

	   
	    while true do
	    	Citizen.Wait(1000)
	    	print(TIME_SKILL_POISON_AREA)
	    	TIME_SKILL_POISON_AREA = TIME_SKILL_POISON_AREA-1
	    	print("finalizou------------------------------")
	    	if TIME_SKILL_POISON_AREA == 0 then return end
	    end
	  
    end
	

end)