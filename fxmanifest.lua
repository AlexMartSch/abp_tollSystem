fx_version 'cerulean'

author 'AlexBanPer'
version '1.0.0'
game 'gta5'

lua54 'yes'

name 'ABP_TollSystem'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/*.lua',
}

client_scripts {
    'client/**/*.lua'
}

server_scripts {
    'server/**/*.lua'
}

files {
    'shared/locales/*.json',
}

dependencies {
    'oxmysql',
    'ox_lib'
}
