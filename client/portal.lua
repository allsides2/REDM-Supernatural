local portals = {}



RegisterNetEvent('portal:useItem')
AddEventHandler('portal:useItem', function()
    local player = PlayerId()

        local waypointCoords = GetWaypointCoords()
        local playerPed = PlayerPedId()
        local pos = GetEntityCoords(playerPed)
        local heading = GetEntityHeading(playerPed)

        -- Calculate a position ahead of the player
        local forwardX = pos.x + 2.0 * math.sin(-heading * math.pi / 180.0)
        local forwardY = pos.y + 2.0 * math.cos(-heading * math.pi / 180.0)
        local forwardPos = vector3(forwardX, forwardY, pos.z)

        TriggerServerEvent('portal:requestPortalCreation', waypointCoords, forwardPos)
        portalanim()

end)

RegisterNetEvent('portal:createPortal')
AddEventHandler('portal:createPortal', function(waypointCoords, portalCoords)
    CreatePortal(waypointCoords, portalCoords)
end)


RegisterNetEvent('portal:requestPortalCreation')
AddEventHandler('portal:requestPortalCreation', function(playerID)
    local player = PlayerId()
    if player == playerID then 
        if Citizen.InvokeNative(0x202B1BBFC6AB5EE4, player) then
            local waypointCoords = GetWaypointCoords()
            TriggerServerEvent('portal:createPortal', waypointCoords) 
            portalanim()
        else
            TriggerEvent('chat:addMessage', { args = { '[SYSTEM]', 'No waypoint marked!' } })
        end
    end
end)




function applyParticleEffect(checkpointCoords)
    local ptfxDictionary = "scr_net_target_races"
    local ptfxName = "scr_net_target_fire_ring_mp"
    local particleHandle

    if not HasNamedPtfxAssetLoaded(ptfxDictionary) then
        RequestNamedPtfxAsset(ptfxDictionary)
        local counter = 0
        while not HasNamedPtfxAssetLoaded(ptfxDictionary) and counter <= 300 do
            Citizen.Wait(0)
        end
    end

    if HasNamedPtfxAssetLoaded(ptfxDictionary) then
        UseParticleFxAsset(ptfxDictionary)
        particleHandle = StartParticleFxLoopedAtCoord(ptfxName, checkpointCoords.x, checkpointCoords.y, checkpointCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
    else
        print("Could not load ptfx dictionary!")
    end

    return particleHandle
end


function applyParticleEffectOnEntity(entity, duration)
    local ptfxDictionary = "scr_net_target_races"
    local ptfxName = "scr_net_target_fire_ring_mp"
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



function removeParticleEffect(particleHandle)
    if particleHandle then
        StopParticleFxLooped(particleHandle, false)
    end
end

function CreatePortal(waypointCoords, portalCoords)
    local entryParticle = applyParticleEffect(portalCoords) 

    local _, groundZ = GetGroundZAndNormalFor_3dCoord(waypointCoords.x, waypointCoords.y, waypointCoords.z)
    local portal = {start = portalCoords, dest = vector3(waypointCoords.x, waypointCoords.y, groundZ - 2), entryParticle = entryParticle}

    table.insert(portals, portal)

    SetTimeout(5000, function()
        for i, p in ipairs(portals) do
            if p == portal then
                -- Remove Particle Effect 
                removeParticleEffect(p.entryParticle)

                table.remove(portals, i)
                break
            end
        end
    end)
end


function portalanim()
    local dict = "veh_horseback@seat_saddle@generic@terrain@unarmed@rain@fidget"
    local anim = "left_arm_shake_b"
    local prop_name = "p_drumstick01x"
    local bone_index = GetEntityBoneIndexByName(PlayerPedId(), "MH_L_Finger31")
    local prop
    local playerPed = PlayerPedId()
    
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    RequestModel(GetHashKey(prop_name))
    while not HasModelLoaded(GetHashKey(prop_name)) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(playerPed, dict, anim, 2.0, -2.0, -1, 67109393, 0.0, false, 1245184, false, "UpperbodyFixup_filter", false)
    --TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)

    Citizen.Wait(1000)  -- Wait 1 second for the animation to start

    prop = CreateObject(GetHashKey(prop_name), 0, 0, 0, true, true, true)
    AttachEntityToEntity(prop, PlayerPedId(), bone_index, 0.0, 0.0, 0.14, 0.0, 0.0, 0.0, true, true, false, true, 1, true)

    Citizen.Wait(5000)
    ClearPedTasksImmediately(playerPed)
    DeleteObject(prop)
end


-- Add functionality to teleport

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        for _, portal in ipairs(portals) do
            local dist = GetDistanceBetweenCoords(coords, portal.start, true)
            if dist < 1.2 then
                -- teleport to destination
                local dest = portal.dest
                local groundZ = GetHeightmapBottomZForPosition(dest.x, dest.y) + 3

                local entityToTeleport = playerPed
                if IsPedOnMount(playerPed) then
                    entityToTeleport = GetMount(playerPed)
                elseif IsPedInAnyVehicle(playerPed, true) then
                    entityToTeleport = GetVehiclePedIsIn(playerPed, false)
                end

                SetEntityCoords(entityToTeleport, dest.x + 0.1, dest.y + 0.1, groundZ, true, true, true, true)
                SendPlayer("guarma")

                -- Apply particle effect after teleport
                
                applyParticleEffectOnEntity(entityToTeleport, 2000)  -- 2000ms = 2 seconds

                break
            end
        end
    end
end)



function SendPlayer(location)
    local portCfg = Config.shops[location]
    DoScreenFadeOut(100)
    Wait(1500)
   -- Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, _U('traveling') .. "Guarma Port", '', '') -- DisplayLoadingScreens
    Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), vector3(1268.36, -6853.66, 43.27), 243.09) -- SetEntityCoordsAndHeading
    if location == 'guarma' then
        Citizen.InvokeNative(0x74E2261D2A66849A, true) -- SetGuarmaWorldhorizonActive
        Citizen.InvokeNative(0xA657EC9DBC6CC900, 1935063277) -- SetMinimapZone
        Citizen.InvokeNative(0xE8770EE02AEE45C2, 1) -- SetWorldWaterType (1 = Guarma)
    else
        Citizen.InvokeNative(0x74E2261D2A66849A, false) -- SetGuarmaWorldhorizonActive
        Citizen.InvokeNative(0xA657EC9DBC6CC900, -1868977180) -- SetMinimapZone
        Citizen.InvokeNative(0xE8770EE02AEE45C2, 0) -- SetWorldWaterType (0 = World)
        Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), vector3(1767.2314, -560.6431, 43.2135), 243.09)
    end
    
    
    Wait(10 * 1000)
    ShutdownLoadingScreen()
    while GetIsLoadingScreenActive() do
        Wait(1000)
    end
    DoScreenFadeIn(1500)
    Wait(1500)
    SetCinematicModeActive(false)
end

function StartPrompts()
    local buyStr = CreateVarString(10, 'LITERAL_STRING', _U('buyPrompt'))
    BuyPrompt = PromptRegisterBegin()
    PromptSetControlAction(BuyPrompt, Config.keys.buy)
    PromptSetText(BuyPrompt, buyStr)
    PromptSetVisible(BuyPrompt, true)
    PromptSetStandardMode(BuyPrompt, true)
    PromptSetGroup(BuyPrompt, PromptGroup)
    PromptRegisterEnd(BuyPrompt)

    local travelStr = CreateVarString(10, 'LITERAL_STRING', _U('travelPrompt'))
    TravelPrompt = PromptRegisterBegin()
    PromptSetControlAction(TravelPrompt, Config.keys.travel)
    PromptSetText(TravelPrompt, travelStr)
    PromptSetVisible(TravelPrompt, true)
    PromptSetStandardMode(TravelPrompt, true)
    PromptSetGroup(TravelPrompt, PromptGroup)
    PromptRegisterEnd(TravelPrompt)
end



RegisterCommand('guarma', function()
    --StartPrompts()

    SendPlayer('guarma')
end)
RegisterCommand('sair_guarma', function()
    --StartPrompts()

    SendPlayer()
end)
--RegisterCommand('teste_123', function()
--    local playerPed = PlayerPedId()
--    applyParticleEffectOnEntity(playerPed, 2000)  -- 2000ms = 2 seconds
--end)

RegisterCommand("teste_123", function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local headCoords = GetEntityCoords(playerPed)


    TriggerEvent("chatMessage", "^1Head^0: X: " .. headCoords.x .. ", Y: " .. headCoords.y .. ", Z: " .. headCoords.z)

end, false)

function GetWorldPositionOfEntityBone(entity, boneIndex)
    return Citizen.InvokeNative(0x82CFA50E34681CA5, entity, boneIndex)
end



function GetPedBoneIndex(ped, boneId)
    return Citizen.InvokeNative(0x3F428D08BE5AAE31, ped, boneId)
end



local handProp = "p_can05x" -- Insira o modelo do prop da mão aqui
local footProp = "p_can05x" -- Insira o modelo do prop do pé aqui
local handPropEntity = nil
local footPropEntity = nil


function AttachPropToHand()
    local playerPed = PlayerPedId()
    local boneCoords = GetPedBoneCoords(playerPed, 0x6f06, 0.0, 0.0, 0.0) -- Mão esquerda
    print(boneCoords)
    boneCoords = GetPedBoneCoords(playerPed, 0x3fc4, 0.0, 0.0, 0.0) -- Pé esquerdo
    print(boneCoords)
   
    AttachPropToCoords(playerPed, boneCoords, handProp)
end

function AttachPropToFoot()
    local playerPed = PlayerPedId()
    local boneCoords = GetPedBoneCoords(playerPed, 0x3fc4, 0.0, 0.0, 0.0) -- Pé esquerdo
    AttachPropToCoords(playerPed, boneCoords, footProp)
end

function AttachPropToCoords(entity, coords, modelHash)
    DeleteProp(handPropEntity)
    handPropEntity = CreateObject(modelHash, coords.x, coords.y, coords.z, true, true, true) -- Cria o objeto
    SetEntityCoordsNoOffset(handPropEntity, coords.x, coords.y, coords.z, true, true, true) -- Define as coordenadas do objeto
end

RegisterCommand("aaaa", function()
    AttachPropToHand()
end)

RegisterCommand("aaaaa", function()
    AttachPropToFoot()
end)

function GetPedBoneCoords(ped, boneId, offsetX, offsetY, offsetZ)
    return Citizen.InvokeNative(0x17C07FC640E86B4E, ped, boneId, offsetX, offsetY, offsetZ)
end

function DeleteProp(prop)
    if prop ~= nil then
        DeleteEntity(prop)
        prop = nil
    end
end

