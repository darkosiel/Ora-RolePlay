fx_version 'adamant'

game 'gta5'

ui_page 'NUI/index.html'

dependency 'saltychat'

client_scripts {
    'SaltyTalkieClient.net.dll'
}

files {
    'NUI/*',
    'Newtonsoft.Json.dll',
    'SaltyTalkieClient.net.pdb',
    'config.json'
}
