		local new_ptfx_dictionary = "amb_lights"
		local new_ptfx_name = "amb_arc_lamp_emit"

		local is_particle_effect_active = false
		local current_ptfx_dictionary = new_ptfx_dictionary
		local current_ptfx_name = new_ptfx_name

		local current_ptfx_handle_id = false

		local bone_index = 247   -- ["PH_Head"]  = {bone_index = 247, bone_id = 57278},

		local ptfx_offcet_x = 0.0
		local ptfx_offcet_y = 2.0
		local ptfx_offcet_z = 0.0
		local ptfx_rot_x = -90.0
		local ptfx_rot_y = 0.0
		local ptfx_rot_z = 0.0
		local ptfx_scale = 1.0
		local ptfx_axis_x = 0
		local ptfx_axis_y = 0
		local ptfx_axis_z = 0


		Citizen.CreateThread(function()
		   	while true do
		        Citizen.Wait(0)
		        if Citizen.InvokeNative(0x91AEF906BCA88877,0, 0x17BEC168) then   -- just pressed E
		        	if not is_particle_effect_active then
		        		current_ptfx_dictionary = new_ptfx_dictionary
						current_ptfx_name = new_ptfx_name
		        		if not Citizen.InvokeNative(0x65BB72F29138F5D6, GetHashKey(current_ptfx_dictionary)) then -- HasNamedPtfxAssetLoaded
		        			Citizen.InvokeNative(0xF2B2353BBC0D4E8F, GetHashKey(current_ptfx_dictionary))  -- RequestNamedPtfxAsset
		        			local counter = 0
		        			while not Citizen.InvokeNative(0x65BB72F29138F5D6, GetHashKey(current_ptfx_dictionary)) and counter <= 300 do  -- while not HasNamedPtfxAssetLoaded
		        				Citizen.Wait(0)
		        			end
		        		end
		    			if Citizen.InvokeNative(0x65BB72F29138F5D6, GetHashKey(current_ptfx_dictionary)) then  -- HasNamedPtfxAssetLoaded
		    				Citizen.InvokeNative(0xA10DB07FC234DD12, current_ptfx_dictionary) -- UseParticleFxAsset

		    				current_ptfx_handle_id = Citizen.InvokeNative(0x9C56621462FFE7A6,current_ptfx_name,PlayerPedId(),ptfx_offcet_x,ptfx_offcet_y,ptfx_offcet_z,ptfx_rot_x,ptfx_rot_y,ptfx_rot_z,bone_index,ptfx_scale,ptfx_axis_x,ptfx_axis_y,ptfx_axis_z) -- StartNetworkedParticleFxLoopedOnEntityBone
		    				--current_ptfx_handle_id =  Citizen.InvokeNative(0x8F90AB32E1944BDE,current_ptfx_name,PlayerPedId(),ptfx_offcet_x,ptfx_offcet_y,ptfx_offcet_z,ptfx_rot_x,ptfx_rot_y,ptfx_rot_z,ptfx_scale,ptfx_axis_x,ptfx_axis_y,ptfx_axis_z)    -- StartNetworkedParticleFxLoopedOnEntity
		    				is_particle_effect_active = true
						else
							print("cant load ptfx dictionary!")
		    			end
		        	else
		        		if current_ptfx_handle_id then
							if Citizen.InvokeNative(0x9DD5AFF561E88F2A, current_ptfx_handle_id) then   -- DoesParticleFxLoopedExist
								Citizen.InvokeNative(0x459598F579C98929, current_ptfx_handle_id, false)   -- RemoveParticleFx
							end
						end
						current_ptfx_handle_id = false
						is_particle_effect_active = false
		        	end
		        end
		    end
		end)