local QBCore = exports['qb-core']:GetCoreObject()
local ShowNames = false


local menu = MenuV:CreateMenu(false, 'Online Players', 'topright', 220, 20, 60, 'size-125', 'none', 'menuv', 'main menu')

RegisterNetEvent('qb-userlist:client:openMenu', function()
    MenuV:OpenMenu(menu)
end)



local menu_button = menu:AddButton({
    icon = '🙍‍♂️',
    label = 'Online Players',
    value = menu,
    description = 'View List Of Players'
})

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
    menu:ClearItems()
    QBCore.Functions.TriggerCallback('test:getplayers', function(players)
        for k, v in pairs(players) do
            local menu_button10 = menu:AddButton({
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
        Wait(60)
        if ShowNames then
            TriggerServerEvent('qb-userlist:server:GetPlayersForList')
        end
    end
end)

CreateThread(function()
    while true do
        Wait(60)
        if ShowNames then
            TriggerServerEvent('qb-userlist:client:Show')
        end
    end
end)

RegisterCommand('+shownames', function()
    ShowNames = true
end, false)
RegisterCommand('-shownames', function()
    ShowNames = false
end, false)
RegisterKeyMapping('+shownames', 'Show Names', 'keyboard', 'u')

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
                SetMpGamerTagVisibility(idTesta, 3, true)
                --   Citizen.InvokeNative(0x63BB75ABEDC1F6A0, idTesta, 9, true)
            else
                SetMpGamerTagVisibility(idTesta, 3, false)
            end
        else
            SetMpGamerTagVisibility(idTesta, 3, false)
            SetMpGamerTagVisibility(idTesta, 0, false)
        end
    end
end)