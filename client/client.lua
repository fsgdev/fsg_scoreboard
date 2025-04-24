RegisterCommand(Config.Command, function(source)
    lib.registerMenu({
        id = 'fsg_scoreboard_main',
        title = locale('scoreboard_title'),
        position = 'top-right',
        options = {
            { label = 'View Online Players', icon = 'fa-solid fa-users', close = true }
        },
        onClose = function()
            cleanupTags()
        end,
    }, function()
        showScoreboard()
    end)
    lib.showMenu('fsg_scoreboard_main')
end)

if Config.Keybind then
    RegisterKeyMapping(Config.Command, 'Open Scoreboard', 'KEYBOARD', Config.Keybind)
end

CreateThread(function()
    while (true) do
        local sleep = 250
        if lib.getOpenMenu() == 'fsg_scoreboard_players' or lib.getOpenMenu() == 'fsg_scoreboard_info' then
            displayTags()
            sleep = 50
        else
            sleep = 250
        end
        Wait(sleep)
    end
end)