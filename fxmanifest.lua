fx_version 'adamant'
game 'gta5'

version '1.0'

client_scripts {
	'config.lua',
 	'client/main.lua',
 	'client/nui.lua'
}

server_scripts {
	'config.lua',
 	'server/main.lua'
}

ui_page 'html/index.html'

files {
    'html/index.html',
    'html/reset.css',
    'html/style.css',
    'html/script.js',
    'html/assets/*.png'
}

file 'peds.meta'

data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_event_easter_basket.ytyp'
data_file 'PED_METADATA_FILE' 'peds.meta'