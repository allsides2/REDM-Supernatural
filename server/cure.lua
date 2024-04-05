local VorpCore = {}
TriggerEvent("getCore",function(core)
    VorpCore = core
end)







RegisterServerEvent('healing:applyHealToPlayer')
AddEventHandler('healing:applyHealToPlayer', function(targetServerId)
    TriggerClientEvent('healing:receiveHeal', targetServerId)
end)

