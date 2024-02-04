lib.callback.register('fsg_scoreboard:getPlayers', function(source)
    local data = {}
    local players = GetPlayers()
    for k, v in ipairs(players) do
        local playerId = QBCore and GetPlayer(v).PlayerData.source or v.source
        local playerName
        if Config.UseSteamHexAsPlayerName then
            playerName = GetPlayerIdentifierByType(tostring(playerId), 'steam')
        else
            playerName = GetPlayerName(playerId)
        end
        table.insert(data, {playerId = playerId, playerName = ''..playerName})
    end
    return data
end)

lib.callback.register('fsg_scoreboard:getSpecificPlayer', function(source, target)
    local identifiers = {}
    local player = GetPlayer(target)
    local playerId = QBCore and player.PlayerData.source or player.source
    local fivemid = GetPlayerIdentifierByType(tostring(playerId), 'fivem')
    local discordid = GetPlayerIdentifierByType(tostring(playerId), 'discord')
    local xblid = GetPlayerIdentifierByType(tostring(playerId), 'xbl')
    local liveid = GetPlayerIdentifierByType(tostring(playerId), 'liveid')
    table.insert(identifiers, {fivemid, discordid, xblid, liveid})
    return playerId, GetPlayerName(playerId), GetPlayerIdentifierByType(tostring(playerId), 'steam'), identifiers
end)
