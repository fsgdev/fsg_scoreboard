lib.locale()

lib.callback.register('fsg_scoreboard:getPlayers', function(source)
    local data = {}
    local players = GetPlayers()
    for k, v in ipairs(players) do
        local playerId
        if QBCore then
            local netPlayer = GetPlayer(v)
            playerId = netPlayer.PlayerData.source
        else
            playerId = v.source
        end
        table.insert(data, {playerId = playerId, playerName = GetPlayerName(playerId)})
    end
    return data
end)

lib.callback.register('fsg_scoreboard:getSpecificPlayer', function(source, target)
    local identifiers = {}
    local player = GetPlayer(target)
    local playerId = player.source
    if QBCore then
        playerId = player.PlayerData.source
    end
    local fivemid = GetPlayerIdentifierByType(tostring(playerId), 'fivem')
    local discordid = GetPlayerIdentifierByType(tostring(playerId), 'discord')
    local xblid = GetPlayerIdentifierByType(tostring(playerId), 'xbl')
    local liveid = GetPlayerIdentifierByType(tostring(playerId), 'liveid')
    table.insert(identifiers, {fivemid, discordid, xblid, liveid})
    return playerId, GetPlayerName(playerId), GetPlayerIdentifierByType(tostring(playerId), 'steam'), identifiers
end)
