
local VORPcore = {}
TriggerEvent('getCore', function(core)
    VORPcore = core
end)

RegisterServerEvent('karma:server:set_karma')
AddEventHandler('karma:server:set_karma', function(type,num)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local identifier = Character.identifier
    local karma = MySQL.query.await('SELECT * FROM supernatural WHERE identifier = ?', {identifier})
    print(karma[1].karma)

    if type == 'add' then
        newKarma = karma[1].karma + num
    elseif type == 'sub' then
        newKarma = karma[1].karma - num
    end

    MySQL.query('UPDATE supernatural SET karma = @newKarma where identifier = @identifier',{ ['@newKarma'] = newKarma, ['@identifier'] = identifier  })

end)




RegisterServerEvent('karma:server:get_karma')
AddEventHandler('karma:server:get_karma', function(type,num)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local identifier = Character.identifier
    local karma = MySQL.query.await('SELECT * FROM supernatural WHERE identifier = ?', {identifier})
    print(karma[1].karma)

    TriggerClientEvent('karma:client:get_karma', _source, karma[1].karma)

end)