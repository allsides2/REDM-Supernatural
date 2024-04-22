local VORPcore = {}
TriggerEvent('getCore', function(core)
    VORPcore = core
end)

VorpInv = exports.vorp_inventory:vorp_inventoryApi()

RegisterNetEvent('supernatural:init')
AddEventHandler('supernatural:init', function()
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local identifier = Character.identifier
    if isSupernatural(identifier,src) then
        TriggerClientEvent('supernatural:isSupernatural',src)
    else return end
end)

function isSupernatural(identifier,src)
    local supernatural = MySQL.query.await('SELECT * FROM supernatural WHERE identifier = ?', {identifier})
    print(#supernatural)
    print(supernatural[1].class)
    if #supernatural >= 1 then
        TriggerClientEvent('supernatural:getClass',src,supernatural[1].class)
        return true
    else
        return false
    end
end

---- itens para setar sobrenatural
VorpInv.RegisterUsableItem("pipe", function(data)  
    local _source = data.source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local identifier = Character.identifier
    local supernatural = MySQL.query.await('SELECT * FROM supernatural WHERE identifier = ?', {identifier})
    if #supernatural >= 1 then
        return
    end
    TriggerClientEvent("vorp_inventory:CloseInv", _source)
    print("foii")
    MySQL.query.await('INSERT INTO supernatural (identifier, class, role, transform) VALUES (?, ?, ?, ?)', {identifier, "vampire", 1, "asdasd"})
    
end)






RegisterServerEvent('server:set_mana')
AddEventHandler('server:get_mana', function(num)
    print("foi____")
    local _source = source
    local newMana = num
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local identifier = Character.identifier
    MySQL.query('UPDATE supernatural SET mana = @newMana where identifier = @identifier',{ ['@newMana'] = newMana, ['@identifier'] = identifier  })
    print("foi")
end)




RegisterServerEvent('server:get_mana')
AddEventHandler('server:get_mana', function()
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local identifier = Character.identifier
    local Mana = MySQL.query.await('SELECT * FROM supernatural WHERE identifier = ?', {identifier})
    print(Mana[1].mana)

    TriggerClientEvent('client:get_mana', _source, karma[1].karma)

end)