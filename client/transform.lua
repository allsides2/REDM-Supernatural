

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Citizen.InvokeNative(0x91AEF906BCA88877,0, 0x17BEC168) then   -- just pressed E


		end
		
    end
end)





function setTransform(animalModel)
	local hash = GetHashKey(animalModel)
	SetPlayerModel(PlayerId(), hash, 0)
	SetPedOutfitPreset(PlayerPedId(), 0, 0)
	SetModelAsNoLongerNeeded(hash)

end





TriggerClientEvent('scalesync:setScale', -1, player, scale)