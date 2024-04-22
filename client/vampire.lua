













































local isStopped = true -- Começa como true para indicar que a habilidade está desativada
local up = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0x17BEC168) then -- E pressionado
            if isStopped then
                isStopped = false
                --tracer() -- Ativa a habilidade
                print("fire: ativou")
            else
                isStopped = true
				Citizen.Wait(50)
				explosion(up)
				
				
				up = 0
                print("fire1: desativou")
				
            end
        end
    end
end)



Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

    	if not isStopped then -- Enquanto a habilidade não estiver desativada
    	    if isStopped then -- Verifica se a habilidade foi desativada
    	        print("fire2: desativou")
				isStopped = true
				up = 0
    	        return
    	    end
			up = up+0.5
			local ped = PlayerPedId()
			local ped_coords = GetEntityCoords(ped)
			local x,y,z = table.unpack(ped_coords)

		
			Citizen.InvokeNative(0xA10DB07FC234DD12, "anm_fire") -- UseParticleFxAsset
			--Citizen.InvokeNative(0xE6CFE43937061143,"ent_anim_moon1_roof_collapse_embers",PlayerPedId(), 0.0, 2.5+up, 0.0, -90.0,0.0, 0.0, 0.1, 0, 0, 0)
			--Citizen.InvokeNative(0xFB97618457994A62, "ent_anim_moon1_roof_collapse_embers", x, y, z, 0.0, 90.0, 0.0, 0.0, 1)
			StartNetworkedParticleFxNonLoopedAtCoord("ent_anim_moon1_roof_collapse_embers", x, y, z, 0.0, 90.0, 0.0, 0.0, 1)
			Citizen.Wait(50)

    	end
	end

end)








function explosion(up)
	local explosionTag_id = 32  -- EXP_TAG_BULLET
    local explosion_vfxTag_hash = 0x7DD07579 	-- applies effect exp_lightning_strike, if native ADD_EXPLOSION_WITH_USER_VFX is used
    local ped = PlayerPedId()
    local ped_coords = GetEntityCoords(ped)
	local x,y,z = table.unpack(ped_coords)
	local forward_fix = up+ 2.5
	local forwardX=GetEntityForwardX(ped)
    local forwardY=GetEntityForwardY(ped)
	local explosion_coords_x = x+(forwardX*forward_fix)
	local explosion_coords_y = y+(forwardY*forward_fix)
	local explosion_coords_z = z
	local damageScale = 20.0
	local isAudible = true
	local isInvisible = false
	local cameraShake = true
	Citizen.InvokeNative(0x7D6F58F69DA92530, explosion_coords_x, explosion_coords_y, explosion_coords_z-0.5, explosionTag_id, damageScale, isAudible, isInvisible, cameraShake)
	Citizen.InvokeNative(0x7D6F58F69DA92530, explosion_coords_x, explosion_coords_y, explosion_coords_z-0.5, 23, 0.7, false, false, cameraShake)
end













--local veg_modifier_sphere = 
--Citizen.CreateThread(function()
--    while true do
--        Citizen.Wait(0)
--        if Citizen.InvokeNative(0x91AEF906BCA88877,0, 0x17BEC168) then   -- pressed E
--            if veg_modifier_sphere == nil or veg_modifier_sphere == 0 then
--        
--                local ped = PlayerPedId()
--                local ped_coords = GetEntityCoords(ped)
--                local x,y,z = table.unpack(ped_coords)
--                local forward_fix = 5
--                local forwardX=GetEntityForwardX(ped)
--                local forwardY=GetEntityForwardY(ped)
--                local veg_modifier_coords_x = x+(forwardX*forward_fix)
--                local veg_modifier_coords_y = y+(forwardY*forward_fix)
--                local veg_modifier_coords_z = z
--        
--                local veg_radius = 300.0
--                local veg_Flags =  1 + 2 + 4 + 8 + 16 + 32 + 64 + 128 + 256   -- implement to all debris, grass, bush, etc...
--                local veg_ModType = 1 	-- 1 | VMT_Cull
--        
--                veg_modifier_sphere = Citizen.InvokeNative(0xFA50F79257745E74,veg_modifier_coords_x,veg_modifier_coords_y,veg_modifier_coords_z, veg_radius, veg_ModType, veg_Flags, 0);   -- ADD_VEG_MODIFIER_SPHERE
--        
--            else
--                Citizen.InvokeNative(0x9CF1836C03FB67A2,Citizen.PointerValueIntInitialized(veg_modifier_sphere), 0);    -- REMOVE_VEG_MODIFIER_SPHERE
--                veg_modifier_sphere = 0
--            end
--        end
--        
--
--    end
--end)















--Citizen.CreateThread(function()
--    while true do
--        Citizen.Wait(0)
--        if Citizen.InvokeNative(0x91AEF906BCA88877,0, 0x17BEC168) then   -- pressed E
--            print("!@#123")
--           
--            Citizen.InvokeNative(0xA10DB07FC234DD12, "anm_lom") -- UseParticleFxAsset
--
--            Citizen.InvokeNative(0xE6CFE43937061143,"ent_anim_lom_blood_burst",PlayerPedId(), 0.0, 0.0-0.5, 0.0, -90.0,0.0, 0.0, 10.7, 0, 0, 0)
--            Citizen.Wait(30)
--            SetEntityVisible(PlayerPedId(), false)
--
--            for i = 1, 50 do
--                Citizen.InvokeNative(0xA10DB07FC234DD12, "anm_lom") -- UseParticleFxAsset
--
--                Citizen.InvokeNative(0xE6CFE43937061143,"ent_anim_lom_blood_burst",PlayerPedId(), 0.0, 0.0-0.5, 0.0, -90.0,0.0, 0.0, 5.5, 0, 0, 0)
--                Citizen.Wait(100)
--            end
--            SetEntityVisible(PlayerPedId(), true)
--            Citizen.Wait(30)
--            Citizen.InvokeNative(0xA10DB07FC234DD12, "scr_grays3") -- UseParticleFxAsset
--            Citizen.InvokeNative(0xE6CFE43937061143,"scr_grays_blood_headshot",PlayerPedId(), 0.0, 0.0-0.5, 0.0, -90.0,0.0, 0.0, 3.7, 0, 0, 0)
--
--
--        end
--    end
--end)









--local vampire_isStopped = true -- Começa como true para indicar que a habilidade está desativada
--
--
--Citizen.CreateThread(function()
--    while true do
--        Citizen.Wait(0)
--        if Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0x17BEC168) then -- E pressionado
--            if vampire_isStopped then
--                vampire_isStopped = false
--				SetEntityVisible(PlayerPedId(), false)
--
--                print("fire: ativou")
--            else
--                vampire_isStopped = true
--				Citizen.Wait(50)
--				SetEntityVisible(PlayerPedId(), true)
--
--				
--				
--
--                print("fire1: desativou")
--				
--            end
--        end
--    end
--end)
--
--
--
--
--
--
--
--Citizen.CreateThread(function()
--	while true do
--		Citizen.Wait(0)
--
--    	if not vampire_isStopped then -- Enquanto a habilidade não estiver desativada
--    	    if vampire_isStopped then -- Verifica se a habilidade foi desativada
--    	        print("vampire: desativou")
--				vampire_isStopped = true
--    	        return
--    	    end
--			Citizen.InvokeNative(0xA10DB07FC234DD12, "anm_lom") -- UseParticleFxAsset
--			Citizen.InvokeNative(0xE6CFE43937061143,"ent_anim_lom_blood_burst",PlayerPedId(), 0.0, 0.0-0.5, 0.0, -90.0,0.0, 0.0, 5.5, 0, 0, 0)
--			Citizen.Wait(50)
--
--    	end
--	end
--
--end)