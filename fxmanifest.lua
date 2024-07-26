fx_version "cerulean"
game "gta5"

author "maji"
description " "
version "1.0"

client_scripts {
    "client/main.lua"
}

server_scripts {
    "server/main.lua"
}

shared_scripts {
    "config.lua"
}

files {
    "html/*",
    "html/assets/*",
    "html/img/*",
    "html/index.html"
}

ui_page "html/index.html"