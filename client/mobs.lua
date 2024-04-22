local VORPutils = {}

TriggerEvent("getUtils", function(utils)
    VORPutils = utils
end)

local ped = {}

Config.mobs = {
    [1] = {
        [1] = {100,100,100},
        [2] = {100,100,100},
    },

}


local playerPed = PlayerPedId()
local coords = GetEntityCoords(playerPed, true, true)


ped = VORPutils.Peds:Create('A_C_cat_01', coords.x, coords.y, coords.z, pDir, 'world', false)


for i, locale in ipairs(Config.mobs) do
    print("Locale ".. i)
    for j, cds in ipairs(locale) do
        print(table.concat(cds))
    end
end


function spawnMobs(mob, coords)

    ped = VORPutils.Peds:Create('A_C_cat_01', coords.x, coords.y, coords.z, pDir, 'world', false)

end


RegisterNetEvent('mob:client:spawn')
AddEventHandler('mob:client:spawn', function()

    for i, locale in ipairs(Config.mobs) do
        print("Locale ".. i)
        for j, cds in ipairs(locale) do
            print("  CDS ".. j.. ": ".. table.concat(cds, ", "))
        end
    end


    --ped = VORPutils.Peds:Create('A_C_cat_01', coords.x+2.7, coords.y, coords.z, pDir, 'world', false)

    
	--print("spawn")
	--ped1 = VORPutils.Peds:Create('A_C_Bear_01', coords.x+2.7, coords.y, coords.z, pDir, 'world', false)
	--boss = true
	--SetEntityHealth(ped1:GetPed(), 5000)
	--SetPedScale(ped1:GetPed(), 2.0)
	--ped1:SetCombatStyle('SituationAllStop', 240.0)
	--ped1:AttackTarget(PlayerPedId(), 'LAW')
	----ped1:Freeze()
	--while true do
	--	Citizen.Wait(1000)
	--	StopEntityFire(ped1:GetPed())
	--end

end)

