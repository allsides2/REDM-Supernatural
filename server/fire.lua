RegisterServerEvent('fire:server:set_fire')
AddEventHandler('fire:server:set_fire', function(targetServerId)
    print("server foi")
    TriggerClientEvent('fire:client:set_fire',targetServerId)

end)
