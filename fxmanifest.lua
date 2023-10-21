fx_version 'cerulean'
game 'gta5'
lua54 'yes'
name 'fsg_scoreboard'
author 'fsg'
version '1.0.6'
repository 'https://github.com/fsgdev/fsg_scoreboard'

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
