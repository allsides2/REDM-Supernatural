local VorpCore = {}
TriggerEvent("getCore",function(core)
    VorpCore = core
end)







RegisterServerEvent('healing:applyHealToPlayer')
AddEventHandler('healing:applyHealToPlayer', function(targetServerId)
    TriggerClientEvent('healing:receiveHeal', targetServerId)
end)

RegisterServerEvent('sobrenatural:damage_select')
AddEventHandler('sobrenatural:damage_select', function(targetServerId)
    TriggerClientEvent('sobrenatural:damage_string',-1)
end)