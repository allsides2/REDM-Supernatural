local isOnFire = false -- Flag to track if the player is already on fire
local fireNetId = nil -- Network ID of the fire entity

-- Function to set the player on fire
function SetPlayerOnFire()
    local playerPed = PlayerPedId()
    StartEntityFire(playerPed) -- Sets the player on fire

    isOnFire = true
    local playerNetId = NetworkGetNetworkIdFromEntity(playerPed)
    TriggerServerEvent("StartPlayerFire", playerNetId) -- Notify the server that the player is on fire

    Citizen.CreateThread(function()
        while isOnFire do
            Citizen.Wait(0)
            if not IsPlayerMoving() then
                isOnFire = false
               
                TriggerServerEvent("StopPlayerFire", playerNetId) -- Notify the server that the player is no longer on fire
            else
                local health = GetEntityHealth(playerPed)
                if health > 1 then
                    SetEntityHealth(playerPed, health + 10) -- Reduce player health while on fire
                else
                    isOnFire = false
                   
                    TriggerServerEvent("StopPlayerFire", playerNetId) -- Notify the server that the player is no longer on fire
                end
            end
        end
    end)
end

-- Function to check if the player is moving
function IsPlayerMoving()
    local playerPed = PlayerPedId()
    return IsPlayerWalking() or IsPlayerRunning() or IsPlayerJumping()
end

-- Function to check if the player is walking
function IsPlayerWalking()
    local playerPed = PlayerPedId()
    return IsPedWalking(playerPed)
end

-- Function to check if the player is running
function IsPlayerRunning()
    local playerPed = PlayerPedId()
    return IsPedRunning(playerPed)
end

-- Function to check if the player is jumping
function IsPlayerJumping()
    local playerPed = PlayerPedId()
    return IsPedJumping(playerPed)
end

-- Event handler to check for player movement
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()

        if not isOnFire then
            if IsPlayerMoving() then
                -- If the player is walking, running, or jumping, set them on fire
                SetPlayerOnFire()
            else
                -- If the player is not moving, prevent catching fire
                --StopEntityFire(playerPed)
            end
        end
    end
end)

-- Event handler to start the fire effect for all players
RegisterNetEvent("StartPlayerFire")
AddEventHandler("StartPlayerFire", function(netId)
    local playerPed = NetworkGetEntityFromNetworkId(netId)
    StartEntityFire(playerPed)
end)

-- Event handler to stop the fire effect for all players
RegisterNetEvent("StopPlayerFire")
AddEventHandler("StopPlayerFire", function(netId)
    local playerPed = NetworkGetEntityFromNetworkId(netId)
    StopEntityFire(playerPed)
end)
