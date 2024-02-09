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
