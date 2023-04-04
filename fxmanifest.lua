fx_version 'adamant'
game 'gta5'

version '1.0'

client_scripts {
	'config.lua',
 	'client/main.lua'
}

server_scripts {
	'config.lua',
 	'server/main.lua'
}

file 'peds.meta'

data_file 'DLC_ITYP_REQUEST' 'stream/bzzz_event_easter_basket.ytyp'
data_file 'PED_METADATA_FILE' 'peds.meta'