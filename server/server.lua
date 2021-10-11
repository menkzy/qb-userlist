-- Variables
local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('steamidentifier:id', function(source, steam)
    steam(GetPlayerIdentifiers(source)[1])
end)

-- Get Players
QBCore.Functions.CreateCallback('test:getplayers', function(source, cb) -- WORKS
    local players = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local targetped = GetPlayerPed(v)
        local ped = QBCore.Functions.GetPlayer(v)
        --  local steam = steam()
        table.insert(players, {
            name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | (' .. GetPlayerName(v) .. ')',
            id = v,
            coords = GetEntityCoords(targetped),
            cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
            citizenid = ped.PlayerData.citizenid,
            sources = GetPlayerPed(ped.PlayerData.source),
            identifier = GetPlayerIdentifier(ped.PlayerData.source),
            sourceplayer= ped.PlayerData.source
            
        })
    end
    cb(players)
end)

QBCore.Commands.Add('ulist', 'Open User List', {}, false, function(source, args)
    TriggerClientEvent('qb-userlist:client:openMenu', source)
end)

RegisterNetEvent('qb-userlist:server:GetPlayersForList', function()
    local src = source
    local players = {}
    for k, v in pairs(QBCore.Functions.GetPlayers()) do
        local targetped = GetPlayerPed(v)
        local ped = QBCore.Functions.GetPlayer(v)
        table.insert(players, {
            name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | (' .. GetPlayerName(v) .. ')',
            id = v,
            coords = GetEntityCoords(targetped),
            cid = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname,
            citizenid = ped.PlayerData.citizenid,
            sources = GetPlayerPed(ped.PlayerData.source),
            sourceplayer= ped.PlayerData.source
        })
    end
    TriggerClientEvent('qb-userlist:client:Show', src, players)
end)