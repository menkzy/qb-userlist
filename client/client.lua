local QBCore = exports['qb-core']:GetCoreObject()

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