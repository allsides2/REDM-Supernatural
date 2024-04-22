
local isSupernatural = false
local playerSpawn = false
local playerRole = nil

local checkNUI = true

local skill2 = nil
local skill3 = nil
local skill4 = nil


local mana = 0
local onMana = false

local onNui = false


Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if onMana then
            
            TriggerEvent('server:get_mana')
            
           
            mana = mana + 5
            print(mana)
            TriggerServerEvent('server:set_mana',mana) 
            Citizen.Wait(10000)
        end
	end
end)

RegisterNetEvent('client:get_mana')
AddEventHandler('client:get_mana', function(pMana)
	mana = pMana
end)

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
        Citizen.Wait(0)
        if isSupernatural and checkNUI then
            checkNUI = false
            Citizen.Wait(15000)
	        TriggerEvent('karma:nui',"show") 
            EnableGui(true,"show") 
            onNui = true
            onMana = true
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
                    --print("classe: " .. className)

                    for key, skill in pairs(classData) do
                        --print("tecla: " .. key)
                        if true then
                            if key == "2" then
                                skill2 = skill
                                --print("Skill: " .. skill.name)
                            elseif key == "3" then
                                skill3 = skill
                               -- print("Skill: " .. skill.name)
                            elseif key == "4" then
                                skill4 = skill
                               -- print("Skill: " .. skill.name)
                            end
                        else
                           -- print("Habilidade não encontrada para: " .. key)
                        end
                    end
                    break
                end
            end
        else
            --print("NÃO é sobrenatural")
        end
    end
end)


--binds https://forum.cfx.re/t/keybind-hashes/1666877/2
Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
        if isSupernatural then
		    if Citizen.InvokeNative(0x91AEF906BCA88877,0,0x1CE6D9EB) then   -- just pressed 2
                print("chamou skill")
                print(skill2.name)
                Skill(skill2.name)
                enableSkill("SKILL-2")
		    end
		    if Citizen.InvokeNative(0x91AEF906BCA88877,0,0x4F49CC4C) then   -- just pressed 3
                print("chamou skill")
                --print(skill3.name)
                Skill(skill3.name)
                enableSkill("SKILL-3")
		    end
		    if Citizen.InvokeNative(0x91AEF906BCA88877,0,0x8F9F9E58) then   -- just pressed 4
                print("chamou skill")
                print(skill3.name)
                Skill(skill4.name)
                enableSkill("SKILL-4")
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
    if skill == "POISON_AREA" then
        print("FIRE area selecionado")
        TriggerEvent("skill:POISON_AREA")
        return 
    end
end





function EnableGui(state, ui)
	SetNuiFocus(not state,not state)
	guiEnabled = state
	SendNUIMessage({
		type = ui,
		enable = state
	})
end
function enableSkill(selectSkill)
	SendNUIMessage({
		skill = selectSkill,
	})
end

function sendClass()
	SendNUIMessage({
		skill_2 = skill2,
		skill_3 = skill3,
		skill_4 = skill4,
	})
end


--local teste_11 = true
--Citizen.CreateThread(function()
--    while true do
--        Citizen.Wait(0)
--        if Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0x17BEC168) then -- E pressionado
--            EnableGui(true, "show")
--            TriggerEvent('karma:nui',"show")
--        end
--    end
--end)

RegisterNUICallback('closeNUI', function()
	EnableGui(true,"ui")
    TriggerEvent('karma:nui',"hide")
end)

RegisterCommand("skills", function()  
    if onNui == false then
        TriggerEvent('karma:nui',"show") 
        EnableGui(true, "show") 
        onNui = true 

    elseif onNui == true then
        TriggerEvent('karma:nui',"hide") 
        EnableGui(true,"hide") 
        onNui = false 
    end                 
end)


RegisterCommand("teste_class", function()  
    sendClass() 
end)