local VorpCore = {}
TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()





RegisterServerEvent("fire:requestfireCreation")
AddEventHandler('fire:requestfireCreation', function(waypointCoords, fireCoords)
    TriggerClientEvent('fire:createfire', -1, waypointCoords, fireCoords)
end)

VorpInv.RegisterUsableItem("clothe2", function(data)  
    local _source = data.source
    TriggerClientEvent("vorp_inventory:CloseInv", _source)
    TriggerClientEvent('fire:useItem', _source)
end)


RegisterCommand("fire", function(source, args, raw)
    local _source = source

    TriggerClientEvent('fire:useItem', _source)
end, false)