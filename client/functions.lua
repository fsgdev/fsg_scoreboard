function DebugPrint(msg)
    if Config.Debug then
        return print(msg)
    end
end

function showInfoMenu(id)
    local playerId, playerName, steamhex, identifiers = lib.callback.await('fsg_scoreboard:getSpecificPlayer', false, id)
    steamhex = steamhex or 'N/A'
    local options = {
        {
            label = locale('serverid') .. ': ' .. playerId,
            description = locale('players') .. locale('serverid'),
            icon = 'id-card',
            close = false
        },
        {
            label = locale('username') .. ': ' .. playerName,
            description = locale('players') .. locale('username'),
            icon = 'user',
            close = false
        },
        {
            label = locale('steamhex') .. ': ' .. steamhex,
            description = locale('players') .. locale('steamhex'),
            icon = 'file-lines',
            close = false
        },
        {
            label = locale('identifiers') .. locale('identifiers_below'),
            description = locale('players') .. locale('identifiers'),
            icon = 'arrow-down',
            close = false
        },
    }
    for k, v in pairs(identifiers) do
        for i = 1, #v, 1 do
            table.insert(options, {
                label = v[i],
                description = locale('players') .. locale('identifiers'),
                icon = 'circle-info',
                close = false
            })
        end
    end
    lib.registerMenu({
        id = 'fsg_scoreboard_info',
        title = playerName,
        options = options,
        onClose = function(keyPressed)
            showScoreboard()
        end,
        position = 'top-right'
    })
    lib.showMenu('fsg_scoreboard_info')
end

function showScoreboard()
    local players = lib.callback.await('fsg_scoreboard:getPlayers')
    local options = {}
    for k, v in ipairs(players) do
        table.insert(options, {
            label = '[' .. tostring(v.playerId) .. '] ' .. v.playerName,
            args = { playerId = v.playerId },
            close = false
        })
    end
    lib.registerMenu({
        id = 'fsg_scoreboard_players',
        title = 'Online Players',
        options = options,
        position = 'top-right',
        onClose = function(keyPressed)
            lib.showMenu('fsg_scoreboard_main')
        end,
    }, function(selected, scrollIndex, args)
        showInfoMenu(args.playerId)
    end)
    lib.showMenu('fsg_scoreboard_players')
end

function GetPlayers()
    local Players = {}
    for _, Player in ipairs(GetActivePlayers()) do
        local Ped = GetPlayerPed(Player)
        if DoesEntityExist(Ped) then
            table.insert(Players, Player)
        end
    end
    return Players
end

function GetPlayersFromCoords(Coords, Distance)
    local Players = GetPlayers()
    local ClosePlayers = {}
    if Coords == nil then
        Coords = GetEntityCoords(PlayerPedId())
    end
    if Distance == nil then
        Distance = 5.0
    end
    for _, Player in pairs(Players) do
        local Target = GetPlayerPed(Player)
        local TargetCoords = GetEntityCoords(Target)
        local dist = #(TargetCoords - Coords)
        if dist <= Distance then
            table.insert(ClosePlayers, Player)
        end
    end
    return ClosePlayers
end

local scoreboardTags = {}

-------------------------------------------------------------------------------
-- Nametags
-- Credits to FiveM (https://github.com/citizenfx/cfx-server-data/blob/master/resources/%5Bgameplay%5D/playernames/playernames_cl.lua) & Tabarra (https://github.com/tabarra/txAdmin/blob/master/scripts/menu/client/cl_player_ids.lua)
-------------------------------------------------------------------------------
displayTags = function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    for _, i in ipairs(GetActivePlayers()) do
        local targetPed =  GetPlayerPed(i)
        local targetCoords = GetEntityCoords(targetPed)
        local nametagString = ('[%d]'):format(GetPlayerServerId(i))
        if not scoreboardTags[i] or not IsMpGamerTagActive(scoreboardTags[i].tag) then
            scoreboardTags[i] = {
                tag = CreateFakeMpGamerTag(targetPed, nametagString, false, false, 0),
                ped = targetPed,
            }
        end
        local nametag = scoreboardTags[i].tag
        local distance = #(targetCoords - playerCoords)
        if (distance <= Config.Distance) and HasEntityClearLosToEntity(playerPed, targetPed, 17) then
            SetMpGamerTagVisibility(nametag, 0, true)
        else
            SetMpGamerTagVisibility(nametag, 0, false)
        end
    end
end

cleanupTags = function()
    for _, v in pairs(scoreboardTags) do
        if IsMpGamerTagActive(v.tag) then
            RemoveMpGamerTag(v.tag)
        end
    end
    scoreboardTags = {}
end