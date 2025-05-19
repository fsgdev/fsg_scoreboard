shared_script "@ReaperV4/bypass.lua"
lua54 "yes" -- needed for Reaper

fx_version 'cerulean'
game 'gta5'
lua54 'yes'
version '1.1.3'
repository 'https://github.com/fsgdev/fsg_scoreboard'

shared_scripts {
    '@ox_lib/init.lua',
    'framework.lua',
    'config.lua'
}

client_scripts {
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}

files {
    'locales/*.json',
}
