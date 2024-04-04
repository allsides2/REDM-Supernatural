RegisterServerEvent('wolf:server:spawn_wolf')
AddEventHandler('wolf:server:spawn_wolf', function(coords,pDir,group)
	print("cham111111ou")
    TriggerClientEvent('wolf:client:spawn_wolf',-1,coords,pDir,group)
end)

RegisterServerEvent('wolf:server:action')
AddEventHandler('wolf:server:action', function(pid,action)
	if action == "atacar" then
        TriggerClientEvent('wolf:client:atacar',-1,pid)
    elseif action == "seguir" then
        TriggerClientEvent('wolf:client:seguir',-1,pid)
    elseif action == "no-atack" then
        TriggerClientEvent('wolf:client:no-atack',-1,pid,true)
    elseif action == "stop-no-atack" then
        TriggerClientEvent('wolf:client:no-atack',-1,pid,false)
    end
end)

