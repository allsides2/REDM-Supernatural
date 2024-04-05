Citizen.CreateThread(function()
    while Config == nil do
        Citizen.Wait(10)
    end

    RegisterCommand("inmyhead", function()
        toggleGhostMode()
    end)
end)

function toggleGhostMode()
    local playerPed = PlayerPedId()

    if not Config.isInGhostMode then
        Config.originalAlpha = GetEntityAlpha(playerPed)
        Config.originalPosition = GetEntityCoords(playerPed)
        SetEntityAlpha(playerPed, 100)  -- Adjust the transparency value as desired
        SetPlayerInvincible(PlayerId(), Config.godModeEnabled)
        FreezeEntityPosition(playerPed, true)
        Config.isPlayerFrozen = true
        Config.isInGhostMode = true
    else
        SetEntityAlpha(playerPed, Config.originalAlpha)
        SetPlayerInvincible(PlayerId(), Config.originalGodMode)
        Config.isInGhostMode = false

        if Config.isPlayerFrozen then
            FreezeEntityPosition(playerPed, false)
            SetEntityCoords(playerPed, Config.originalPosition)
            Config.isPlayerFrozen = false
        end
    end
end
