
local isSupernatural = false
local playerSpawn = false
local playerRole = nil

local skill2 = nil
local skill3 = nil
local skill4 = nil



RegisterNetEvent('supernatural:isSupernatural')
AddEventHandler('supernatural:isSupernatural', function()
    isSupernatural = true
end)
RegisterNetEvent('supernatural:getClass')
AddEventHandler('supernatural:getClass', function(class)
    playerRole = class
end)

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(5000)
        if not isSupernatural then
	        TriggerServerEvent('supernatural:init',source)
            print("verificando sobrenatural")
        end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000)
        if isSupernatural then
            local foundClass = false
            for className, classData in pairs(Config.role) do
                if playerRole == className then
                    foundClass = true
                    print("é sobrenatural")
                    print("classe: " .. className)

                    for key, skill in pairs(classData) do
                        print("tecla: " .. key)
                        if true then
                            if key == "2" then
                                skill2 = skill
                                print("Skill: " .. skill.name)
                            elseif key == "3" then
                                skill3 = skill
                                print("Skill: " .. skill.name)
                            elseif key == "4" then
                                skill4 = skill
                                print("Skill: " .. skill.name)
                            end
                        else
                            print("Habilidade não encontrada para: " .. key)
                        end
                    end
                    break
                end
            end
        else
            print("NÃO é sobrenatural")
        end
    end
end)


--binds https://forum.cfx.re/t/keybind-hashes/1666877/2
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(10)
        if isSupernatural then
		    Citizen.Wait(1)
		    if Citizen.InvokeNative(0x91AEF906BCA88877,0,0x1CE6D9EB) then   -- just pressed 2
                print("chamou skill")
                print(skill2.name)
                Skill(skill2.name)
		    end
		    if Citizen.InvokeNative(0x91AEF906BCA88877,0,0x4F49CC4C) then   -- just pressed 3
                print("chamou skill")
                print(skill3.name)
                Skill(skill3.name)
		    end
        end
	end
end)






function Skill(skill)
    if skill == "HEAL_AREA" then
        print("cure area selecionado")
        TriggerEvent("skill:HEAL_AREA")
        return 
    end
    if skill == "FIRE_AREA" then
        print("FIRE area selecionado")
        TriggerEvent("skill:FIRE_AREA")
        return 
    end
 

end







local music_events = {

    "SUS1_EXIT",
    "SUS1_FAIL",
    "WNT4_START",
    "WNT4_START_2",
    "WNT4_STOP",
    "WNT4_TRAIN_JUMP",
}


local currentlyPlaying = false

RegisterCommand("playmusic", function()
    if not currentlyPlaying then
        currentlyPlaying = true
        TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Playing music events for 5 seconds each.")
        

        for _, event in ipairs(music_events) do
            TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Music: "..event)
            Citizen.InvokeNative(0x1E5185B72EF5158A, event)  -- PREPARE_MUSIC_EVENT
            Citizen.InvokeNative(0x706D57B0F50DA710, event)  -- TRIGGER_MUSIC_EVENT
            Wait(5000)  -- Wait for 5 seconds
            Citizen.InvokeNative(0x1E5185B72EF5158A, event .. "_STOP")  -- PREPARE_MUSIC_EVENT_STOP
            Citizen.InvokeNative(0x706D57B0F50DA710, event .. "_STOP")  -- TRIGGER_MUSIC_EVENT_STOP
        end

        currentlyPlaying = false
    else
        TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "Music is already playing.")
    end
end, false)