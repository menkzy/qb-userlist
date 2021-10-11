local QBCore = exports['qb-core']:GetCoreObject()
local ShowNames = false


local menu = MenuV:CreateMenu(false, 'Online Players', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'main menu')
local menu2 = MenuV:CreateMenu(false, 'Online Players', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'Online Players')

RegisterNetEvent('qb-userlist:client:openMenu', function()
    MenuV:OpenMenu(menu)
end)


local menu_button = menu:AddButton({
    icon = '🙍‍♂️',
    label = 'Online Players',
    value = menu2,
    description = 'View List Of Players'
})

local names_button = menu:AddCheckbox({
    icon = '📋',
    label = 'Names',
    value = menu3,
    description = 'Enable/Disable Names overhead'
})

names_button:On('change', function()
    TriggerEvent('qb-userlist:client:toggleNames')
end)

local function OpenPlayerMenus(player)
    local Players = MenuV:CreateMenu(false, player.cid .. ' Options', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv') -- Players Sub Menu
    Players:ClearItems()
    MenuV:OpenMenu(Players)
    local elements = {
        [1] = {
            icon = '💀',
            label = player.id ..' | Player Server ID',
            description = "Player Server ID"
        },
        [2] = {
            icon = '💀',
            label = player.citizenid ..' | Citizen ID',
            description = "Player CitizenID"
        },
        [3] = {
            icon = '💀',
            label = player.cid ..' | Player Name',
            description = "Player Name"
        },
        [4] = {
            icon = '💀',
            label = player.identifier ..' | R* License ID',
            description = "Identifier"
        }
    }
    for k, v in ipairs(elements) do
        local menu_button10 = Players:AddButton({
            icon = v.icon,
            label = ' ' .. v.label,
            description = v.description,
        })
        
    end
end

menu_button:On('select', function(item)
    menu2:ClearItems()
    QBCore.Functions.TriggerCallback('test:getplayers', function(players)
        for k, v in pairs(players) do
            local menu_button10 = menu2:AddButton({
                label = 'ID:' .. v["id"] .. ' | ' .. v["name"],
                value = v,
                description = 'Player Name',
                select = function(btn)
                    local select = btn.Value -- get all the values from v!
                    OpenPlayerMenus(select) -- only pass what i select nothing else
                end
            }) -- WORKS
        end
    end)
end)

menu:OpenWith('KEYBOARD', 'U') -- Press U to open Menu

RegisterNetEvent('qb-userlist:client:toggleNames', function()
    if not ShowNames then
        ShowNames = true
        -- QBCore.Functions.Notify("Names activated", "success")
    else
        ShowNames = false
        --   QBCore.Functions.Notify("Names deactivated", "error")
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        if ShowNames then
            TriggerServerEvent('qb-userlist:server:GetPlayersForList')
        end
    end
end)

RegisterNetEvent('qb-userlist:client:Show', function(players)
    for k, player in pairs(players) do
        local playeridx = GetPlayerFromServerId(player.id)
        local ped = GetPlayerPed(playeridx)
        local name = '#'..player.id
        
        -- Names Logic
        local idTesta = CreateFakeMpGamerTag(ped, name, false, false, "", false)
        
        if ShowNames then
            SetMpGamerTagVisibility(idTesta, 0, true)
            if NetworkIsPlayerTalking(playeridx) then
                SetMpGamerTagVisibility(idTesta, 9, true)
                --   Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 9, true)
            else
                SetMpGamerTagVisibility(idTesta, 9, false)
            end
        else
            SetMpGamerTagVisibility(idTesta, 9, false)
            SetMpGamerTagVisibility(idTesta, 0, false)
        end
    end
end)