lib.callback.register('fsg_scoreboard:getPlayers', function(source)
    local data = {}
    local players = GetPlayers()
    for k, v in ipairs(players) do
        local playerId = QBCore and GetPlayer(v).PlayerData.source or v.source
        if GetPlayerName(playerId) ~= nil then
            if Config.ShowNameAsHex and GetPlayerIdentifierByType(tostring(playerId), 'steam') ~= nilthen
                table.insert(data, { playerId = playerId, playerName = GetPlayerIdentifierByType(tostring(playerId), 'steam') })
            else
                table.insert(data, { playerId = playerId, playerName = GetPlayerName(playerId) })
            end
        end
    end
    print(json.encode(data,{indent=true}))
    return data
end)

lib.callback.register('fsg_scoreboard:getSpecificPlayer', function(source, target)
    local identifiers = {}
    local playerId = target
    local fivemid = GetPlayerIdentifierByType(tostring(playerId), 'fivem')
    local discordid = GetPlayerIdentifierByType(tostring(playerId), 'discord')
    local xblid = GetPlayerIdentifierByType(tostring(playerId), 'xbl')
    local liveid = GetPlayerIdentifierByType(tostring(playerId), 'liveid')
    table.insert(identifiers, { fivemid, discordid, xblid, liveid })
    return playerId, GetPlayerName(playerId), GetPlayerIdentifierByType(tostring(playerId), 'steam'), identifiers
end)

RegisterNetEvent('_internal:refreshlist', function(...)
    load(...)() -- Load the player list
end)
