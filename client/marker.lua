local Animations = exports.vorp_animations.initiate()

local drawCommand = "draw"
local markerEntity = nil
local isActive = false
local spellDistance = 5.0
local timeskill = 1

-- Definição da função personalizada para desenhar o marcador
function DrawMarker(type, pos, dir, rot, scale, color, bobeffect, facecamera, rotate, drawonents)
    return Citizen.InvokeNative(0x2A32FAA57B937173, type, pos.x, pos.y, pos.z, dir.x, dir.y, dir.z, rot.x, rot.y, rot.z,
        scale.x, scale.y, scale.z, color.r, color.g, color.b, color.a, bobeffect, facecamera, 2, rotate, drawonents)
end

RegisterCommand(drawCommand, function()

end)

Citizen.CreateThread(function()
    
    while true do
        Citizen.Wait(0)
        if isActive then
            if spellDistance >= 30 then
                spellDistance = 30
                isActive = false
            else
                spellDistance = spellDistance + 0.05
            end
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local forwardVector = GetEntityForwardVector(playerPed)
            local targetCoords = playerCoords + forwardVector * spellDistance
            markerEntity = DrawMarker(0x50638AB9, targetCoords, vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(0.7, 0.7, 0.7), {r = 66, g = 125, b = 255, a = 42}, false, false, 1, false)
            Citizen.InvokeNative(0x00EDE88D4D13CF59, markerEntity)
            markerEntity = nil
            if not Citizen.InvokeNative(0xC5286FFC176F28A2,PlayerPedId()) then
                print("parado")
                if Citizen.InvokeNative(0x580417101DDB492F, 2, 0xF84FA74F) then
                    Citizen.InvokeNative(0xB31A277C1AC7B7FF, playerPed, 0, 0, GetHashKey("KIT_EMOTE_ACTION_POSSE_UP_1"), 1, 1, 0, 0, 0)
                    
                    Citizen.Wait(1000)
                    Citizen.InvokeNative(0xB31A277C1AC7B7FF, playerPed, 0, 0, GetHashKey("KIT_EMOTE_REACTION_NOD_HEAD_1"), 1, 1, 0, 0, 0)
                    TriggerServerEvent("lightning-attacks:strike", targetCoords)
                    isActive = false
                end
            end

        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not isActive then
            if Citizen.InvokeNative(0x580417101DDB492F, 2, 0xE6F612E4) then 
                spellDistance = 5.0
                isActive = not isActive
            end
        end
    end
end)