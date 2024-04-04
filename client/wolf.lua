local VORPutils = {}
local wolfSummon = false
local wolfDutarion = 0
local wolfpacive= true
local ped1

local string_ = "seguindo"


TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if Citizen.InvokeNative(0x91AEF906BCA88877,0, 0x17BEC168) then   -- just pressed E
			
			print("teste:1")
			local playerPed = PlayerPedId()
    		local coords = GetEntityCoords(playerPed, true, true)
			local pDir = GetEntityHeading(playerPed)
			TriggerServerEvent('wolf:server:spawn_wolf',coords,pDir,PlayerPedId())
			wolfSummon = true
			Citizen.Wait(1000)
			while wolfSummon do
				Citizen.Wait(1)
				if true then
					TriggerServerEvent('wolf:server:action',PlayerPedId(),"no-atack")
				end 
			
				local _text = ("[Status]: "..string_.."\n[J] Atacar  - [U] Seguir")
				DrawTxt(_text, 0.0, 0.5, 0.4, 0.4, true, 255, 255, 255, 150, false) 
			
				if Citizen.InvokeNative(0x91AEF906BCA88877,0, 0xF3830D8E) then   -- just pressed j
					string_="atacar"
					wolfpacive=false
					TriggerServerEvent('wolf:server:action',PlayerPedId(),"atacar")
				end
			
				if Citizen.InvokeNative(0x91AEF906BCA88877,0, 0xD8F73058) then   -- just pressed u
					string_="seguir"
					wolfpacive=true
					TriggerServerEvent('wolf:server:action',PlayerPedId(),"seguir")
				end
			
			end
			
		
			
		end
	end
end)


RegisterNetEvent('wolf:client:spawn_wolf')
AddEventHandler('wolf:client:spawn_wolf', function(coords,pDir,group)
	print("spawn")
	ped1 = VORPutils.Peds:Create('A_C_Wolf_Medium', coords.x+2.7, coords.y, coords.z, pDir, 'world', false)
	Citizen.InvokeNative(0xA10DB07FC234DD12, "scr_rhodes") -- UseParticleFxAsset
	Citizen.InvokeNative(0xE6CFE43937061143,"ent_amb_following_dust", ped1:GetPed(), 0.0, 0.0, 0.0, -90.0, 0.0, 0.0, 4.0, 0, 0, 0) -- StartNetworkedParticleFxNonLoopedOnEntity


	
	--ped1:Remove()

end)


RegisterNetEvent('wolf:client:seguir')
AddEventHandler('wolf:client:seguir', function(pid)
	string_="seguindo"
	wolfpacive=true
	ped1:ClearCombatStyle()
	ped1:AddPedToGroup(GetPedGroupIndex(pid))
end)
RegisterNetEvent('wolf:client:atacar')
AddEventHandler('wolf:client:atacar', function(pid)
	string_="atacar"
	wolfpacive=false
	ped1:ClearCombatStyle()
	ped1:SetPedCombatAttributes({
        {flag = 0, enabled = false}
    }, 1, 0, 3)
	print("smonu")
	ped1:AddPedToGroup(GetPedGroupIndex(group))
	ped1:AttackTarget(group, 'COMBAT_ANIMAL')
	ped1:AddPedToGroup(GetPedGroupIndex(pid))

end)
RegisterNetEvent('wolf:client:no-atack')
AddEventHandler('wolf:client:no-atack', function(pid)
	ped1:ClearCombatStyle()
	ped1:FollowToOffsetOfEntity(pid, 0.0, -1.5, 0.0, 1.0, -1, 10, 1, 1)

end)





function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end