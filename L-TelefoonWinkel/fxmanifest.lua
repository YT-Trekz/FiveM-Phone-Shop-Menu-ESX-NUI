fx_version 'adamant'
game 'gta5'
lua54 'yes'

author 'MadeByLommel | L-Scripts'
description 'L-TelefoonWinkel'
version '1.0.0'
                                  
ui_page "html/index.html"

client_scripts {
    'src/client.lua',
    'config.lua'
}

server_scripts {
    'src/server.lua',
    'config.lua'
}

files {
    'html/index.html',
    'html/index.js',
    'html/style.css',
    'html/reset.css',
    'html/*.png'
}