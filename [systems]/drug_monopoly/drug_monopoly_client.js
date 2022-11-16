
MONOPOLY_REFRESH_RATE_SECONDS = 1

let zoneInformations = {}
onNet('drug_monopoly:updateZoneInfo', (zoneId, zoneData) => {
    if (zoneId) { zoneInformations[zoneId] = zoneData }
    else {
        for(const k in zoneData) {
            zoneInformations[k] = zoneData[k]
        }
    }
})

onNet('drug_monopoly:sendMessageNotification', message => {
    SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(true, false)
})

let lastRequest = null
function getZoneInfo(zoneId) {
    if (!lastRequest || Date.now() - lastRequest > MONOPOLY_REFRESH_RATE_SECONDS * 1000) {
        lastRequest = Date.now()
        emitNet('drug_monopoly:requestMonopolyUpdate', zoneId)
    }
    if (!zoneInformations[zoneId]) { 
        console.error('No data in zone ', zoneId)
        return null
    }
    return zoneInformations[zoneId]
}

exports("getZoneInfo", getZoneInfo)
