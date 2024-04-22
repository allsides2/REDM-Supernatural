local VORPutils = {}
local boss = false
local bossString = false
local returned = true

TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)

RegisterCommand('boss', function(source, args, rawCommand)
	
	print("teste:1")
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed, true, true)
	local pDir = GetEntityHeading(playerPed)
	TriggerEvent('boss:client:spawn',coords,pDir,PlayerPedId())
	print("foi12312312")
end, false)

Citizen.CreateThread(function()
	while false do
		Citizen.Wait(0)
		if Citizen.InvokeNative(0x91AEF906BCA88877,0, 0x17BEC168) then   -- just pressed E
			
			print("teste:1")
			local playerPed = PlayerPedId()
    		local coords = GetEntityCoords(playerPed, true, true)
			local pDir = GetEntityHeading(playerPed)
			TriggerEvent('boss:client:spawn',coords,pDir,PlayerPedId())
			print("foi12312312")	
		end
	end
end)


RegisterNetEvent('boss:client:spawn')
AddEventHandler('boss:client:spawn', function(coords,pDir,group)
	print("spawn")
	ped1 = VORPutils.Peds:Create('A_C_Bear_01', coords.x+2.7, coords.y, coords.z, pDir, 'world', false)
	boss = true
	SetEntityHealth(ped1:GetPed(), 5000)
	SetPedScale(ped1:GetPed(), 2.0)
	ped1:SetCombatStyle('SituationAllStop', 240.0)
	ped1:AttackTarget(PlayerPedId(), 'LAW')
	--ped1:Freeze()

	while true do
		Citizen.Wait(1000)
		StopEntityFire(ped1:GetPed())

	end
	
end)


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if boss then
			local coords = GetEntityCoords(ped1:GetPed(), true, true)
			local pCoords = GetEntityCoords(PlayerPedId(), true, true)

			--print("loop")

			

			local coordsBoss = vector3(coords.x, coords.y, coords.z)
			local coordsPlayer = vector3(pCoords.x, pCoords.y, pCoords.z)

        	local coordsLocate = vector3(790.4108, -6909.7222, 49.328)

        	local distance = #(coordsBoss - coordsLocate)
        	local pdistance = #(coordsPlayer - coordsLocate)
			print(pdistance)
			--print(GetEntityHealth(ped1:GetPed()))
			
			--print(coords.x..'   ----    '..coords.y)
			if pdistance < 30 then
				print("dentro")
				local _text = ("[Urso Sombrio]")
				DrawTxt(_text, 0.4, 0.1, 0.4, 0.8, true, 255, 0, 0, 150, false) 
				local _text = (GetEntityHealth(ped1:GetPed()).."/5000")
				DrawTxt(_text, 0.45, 0.15, 0.4, 0.5, true, 255, 255, 255, 150, false) 



			end

			if distance > 20 and returned then
				returned = false
				--ped1:Remove()

				 --SetEntityHealth(ped, 300) 
			end
			if GetEntityHealth(ped1:GetPed()) == 0 then
				boss = false
				print("boss morreu")
				return
			end


		end


	end

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if not returned then
			ped1:ClearTasks()
			TaskGoToCoordAnyMeans(ped1:GetPed(), 790.4108, -6909.7222, 49.3280, 1.0, 0, 0, 0, 0.5)
			print("saiu do pit")
			Citizen.Wait(5000)
			returned = true
		end
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if not returned then
			ped1:ClearTasks()
			TaskGoToCoordAnyMeans(ped1:GetPed(), 790.4108, -6909.7222, 49.3280, 1.0, 0, 0, 0, 0.5)
			print("saiu do pit")
			Citizen.Wait(5000)
			returned = true
		end
	end
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