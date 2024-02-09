Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        	if Citizen.InvokeNative(0x91AEF906BCA88877,0, 0x17BEC168) then   -- pressed E
			local explosionTag_id = 19  -- EXP_TAG_BULLET
        		local explosion_vfxTag_hash = 0x7DD07579 	-- applies effect exp_lightning_strike, if native ADD_EXPLOSION_WITH_USER_VFX is used
        		local ped = PlayerPedId()
        		local ped_coords = GetEntityCoords(ped)
			local x,y,z = table.unpack(ped_coords)
			local forward_fix = 1
			local forwardX=GetEntityForwardX(ped)
    	    		local forwardY=GetEntityForwardY(ped)
	        	local explosion_coords_x = x+(forwardX*forward_fix)
	        	local explosion_coords_y = y+(forwardY*forward_fix)
	        	local explosion_coords_z = z
	        	local damageScale = 0.0
	        	local isAudible = true
	        	local isInvisible = false
	        	local cameraShake = true

	        	-- ADD_EXPLOSION_WITH_USER_VFX:
			--Citizen.InvokeNative(0x53BA259F3A67A99E, explosion_coords_x, explosion_coords_y, explosion_coords_z, explosionTag_id, explosion_vfxTag_hash, damageScale, isAudible, isInvisible, cameraShake)
			
			-- ADD_EXPLOSION:
			Citizen.InvokeNative(0x7D6F58F69DA92530, explosion_coords_x, explosion_coords_y, explosion_coords_z, explosionTag_id, damageScale, isAudible, isInvisible, cameraShake)
		end
	end
end)