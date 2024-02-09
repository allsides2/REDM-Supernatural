--local VORPcore = exports.vorp_core:GetCore()

local VORPcore = {}
TriggerEvent("getCore",function(core)
    vorpCore = core
end)

RegisterServerEvent('bcc-guarma:BuyTicket', function(travel)
    local src = source
    local Character = VORPcore.getUser(src)
    local buyPrice = travel.buyPrice
    local canCarry = exports.vorp_inventory:canCarryItem(src, 'boat_ticket', 1)
    if canCarry then
        if Character.money >= buyPrice then
            Character.removeCurrency(0, buyPrice)
            exports.vorp_inventory:addItem(src, 'boat_ticket', 1)
            VORPcore.NotifyRightTip(src, _U('boughtTicket'), 4000)
        else
            VORPcore.NotifyRightTip(src, _U('shortCash'), 4000)
        end
    else
        VORPcore.NotifyRightTip(src, _U('maxTickets'), 4000)
    end
end)

RegisterServerEvent('bcc-guarma:CheckTicket', function(source, cb)
    local src = source
    --local ticket = exports.vorp_inventory:getItem(src, 'boat_ticket')
    if true then
        --exports.vorp_inventory:subItem(src, 'boat_ticket', 1)
        cb(true)
    else
        VORPcore.NotifyRightTip(src, _U('noTicket'), 4000)
        cb(false)
    end
end)

RegisterServerEvent('bcc-guarma:CheckPlayerJob', function(source, cb, port)
    local src = source
    local Character = VORPcore.getUser(src)
    local charJob = Character.job
    local jobGrade = Character.jobGrade
    if not charJob then
        cb(false)
        return
    end
    for _, job in pairs(Config.shops[port].shop.jobs) do
        if (charJob == job.name) and (tonumber(jobGrade) >= tonumber(job.grade)) then
            cb(true)
            return
        end
        VORPcore.NotifyRightTip(src, _U('needJob'), 4000)
        cb(false)
    end
end)
