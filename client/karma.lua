local isSupernatural = true
local nui = false

local karma = 0

local add = false
local sub = false
local count = 0 
local subCount = 0 




RegisterNetEvent('karma:isSupernatural')
AddEventHandler('karma:isSupernatural', function()
	isSupernatural = true
end)

RegisterNetEvent('karma:client:get_karma')
AddEventHandler('karma:client:get_karma', function(pKarma)
	karma = pKarma
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0x17BEC168) then -- E pressionado
            print("chamou kjarama")
            count("sub", 200)
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		TriggerServerEvent('karma:server:get_karma')
		Citizen.Wait(60000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if isSupernatural and nui then
			local _text = ("Karma")
			DrawTxt(_text, 0.83, 0.78, 0.4, 0.8, true, 255, 255, 255, 150, false) 
			if karma == 0 then
				local _text = (karma.."")
				DrawTxt(_text, 0.75, 0.75, 0.4, 0.5, true, 255, 255, 255, 150, false) 
			elseif karma > 0 then
				local _text = (karma.."")
				DrawTxt(_text, 0.83, 0.8, 0.4, 0.5, true, 0, 153, 0, 150, false) 
			elseif karma < 0 then
				local _text = (karma.."")
				DrawTxt(_text, 0.838, 0.82, 0.4, 0.5, true, 255, 0, 0, 150, false) 
			end
		end
	end
end)


RegisterNetEvent('karma:count')
AddEventHandler('karma:count', function(type,num)
	count(type,num)
end)
RegisterNetEvent('karma:nui')
AddEventHandler('karma:nui', function(type)
	if type == "show" then
		nui = true
	elseif type == "hide" then
		nui = false
	end
	
end)

function count(type, num)
    print(num)
	if type == "add" then
		karma = karma + num
	elseif type == "sub" then
		karma = karma - num
	end
    TriggerServerEvent('karma:server:set_karma',type,num)
end









function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
	local str = CreateVarString(10, "LITERAL_STRING", str)
	SetTextScale(w, h)
	SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
	if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1);
	DisplayText(str, x, y)
end