RegisterCommand(Config.Command, function(source)
    lib.registerMenu({
        id = 'fsg_scoreboard_main',
        title = locale('scoreboard_title'),
        position = 'top-right',
        options = {
            { label = 'View Online Players', icon = 'fa-solid fa-users', close = true }
        }
    }, function(selected, scrollIndex, args)
        showScoreboard()
    end)
    lib.showMenu('fsg_scoreboard_main')
end)

if Config.Keybind then
    RegisterKeyMapping(Config.Command, 'Open Scoreboard', 'KEYBOARD', Config.Keybind)
end

CreateThread(function()
    while (true) do
        local w = 1000
        if lib.getOpenMenu() == 'fsg_scoreboard_players' or lib.getOpenMenu() == 'fsg_scoreboard_info' then
            local Players = GetPlayersFromCoords(GetEntityCoords(PlayerPedId()), Config.Distance)
            for _, Player in pairs(Players) do
                local PlayerId = GetPlayerServerId(Player)
                local Ped = GetPlayerPed(Player)
                local PlayerCoords = GetPedBoneCoords(Ped, 0x796e)
                local CanSee = HasEntityClearLosToEntity(PlayerPedId(), Ped, 20)
                if CanSee then
                    w = 0
                    if NetworkIsPlayerTalking(Player) then
                        DrawText3D(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z + 0.35, PlayerId,
                            { r = 46, g = 104, b = 255 })
                    else
                        DrawText3D(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z + 0.35, PlayerId)
                    end
                end
            end
        end

        Wait(w)
    end
end)
