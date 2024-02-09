local currentMoon = nil
local nextMoon = nil

local currentConstellation= nil
local nextConstellation = nil

Citizen.CreateThread(function()
	while true do
		local h = GetClockHours()
		local m = GetClockMinutes()
		if currentMoon == nil then
			currentMoon, currentConstellation = getMoonInfo()
			nextMoon, nextConstellation = getMoonInfo()
		else
			if h == 00 and m == 00 then
				currentMoon = nextMoon
				currentConstellation = nextConstellation
				nextMoon, nextConstellation = getMoonInfo()
			end
		end
		Citizen.Wait(4500)
	end
end)

function getRandomMoon()
    local randomIndex = math.random(1, #Config.moon)
    return Config.moon[randomIndex]
end

function getMoonInfo()
    local moon = getRandomMoon()
    return moon.name, moon.constellation
end
