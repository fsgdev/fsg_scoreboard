fx_version 'cerulean'
game 'gta5'
lua54 'yes'
description 'fsg_scoreboard'
version '1.0.6'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'framework.lua',
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
