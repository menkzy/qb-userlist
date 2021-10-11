fx_version 'cerulean'
game 'gta5'

description 'QB-UserList'
version '1.0.0'

ui_page 'html/index.html'

client_scripts {
    '@menuv/menuv.lua',
    'client/client.lua',
}

server_script 'server/server.lua'

files {
    'html/index.html',
    'html/index.js'
}

dependency 'menuv'