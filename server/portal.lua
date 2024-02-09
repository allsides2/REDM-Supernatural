local VorpCore = {}
TriggerEvent("getCore",function(core)
    VorpCore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()





RegisterServerEvent("portal:requestPortalCreation")
AddEventHandler('portal:requestPortalCreation', function(waypointCoords, portalCoords)
    TriggerClientEvent('portal:createPortal', -1, waypointCoords, portalCoords)
end)

VorpInv.RegisterUsableItem("clothe2", function(data)  
    local _source = data.source
    TriggerClientEvent("vorp_inventory:CloseInv", _source)
    TriggerClientEvent('portal:useItem', _source)
end)


RegisterCommand("portal", function(source, args, raw)
    local _source = source
    TriggerClientEvent("vorp_inventory:CloseInv", _source)
    TriggerClientEvent('portal:useItem', _source)
end, false)