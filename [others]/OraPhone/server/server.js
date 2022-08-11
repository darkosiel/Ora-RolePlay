/**
 * =============
 * DB operations
 * =============
 */

/**
 * Just a wrapper for mysql_fetch_all
 * @param {string} sql 
 * @param {object} params 
 * @param {function} cb 
 * @returns {void}
 */
function sqlCallback(sql, params, cb = _ => {}) {
    return exports["mysql-async"].mysql_fetch_all(sql, params, cb)
}

/**
 * Just a wrapper for mysql_execute
 * @param {string} sql 
 * @param {object} params 
 */
function executeSql(sql, params) {
    exports["mysql-async"].mysql_execute(sql, params)
}

/**
 * Execute sql query with a Promise to handle results
 * @param {*} sql 
 * @param {*} params 
 * @returns {Promise}
 */
function fetchDb(sql, params) {
    return new Promise((resolve, reject) => {
        try {
            return sqlCallback(sql, params, res => {
                return resolve(res)
            })
        } catch(e) {
            reject(e)
        }
    })
}

/**
 * Some quick abstract crud
 * @param {string} table_suffix 
 * @param {Object} fieldsMap object key to db column
 * @returns Object
 */
const generateCrud = (table_suffix, fieldsMap) => {
    const table = "ora_"+table_suffix
    const sanitizeKeys = input => {
        for(const k in input) {
            if(!Object.keys(fieldsMap).includes(k)) {
                throw new Error('Unknown field "'+ k + '" for ' + table_suffix)
            }
        }
    }
    const aliasKeys = map => Object.fromEntries(Object.entries(map).map(entr => ['@'+entr[0],entr[1]]))
    const buildSqlCriteria = criteria => Object.keys(criteria).map(k => `${fieldsMap[k]} = @${k}`).join(' AND ')

    const crud = {
        create: values => {
            sanitizeKeys(values)
            let sql = `INSERT INTO ${table} (${Object.keys(values).map(k=>fieldsMap[k]).join(', ')})`
            sql += ` VALUES (${Object.keys(aliasKeys(values)).join(', ')})`
            executeSql(sql, values)
        },
        read: criteria => {
            sanitizeKeys(criteria)
            let sql = `SELECT ${Object.keys(fieldsMap).map(k => `${fieldsMap[k]} AS ${k}`).join(', ')} FROM ${table} WHERE ${buildSqlCriteria(criteria)}`
            return fetchDb(sql, criteria)
        },
        update: (criteria, values) => {
            sanitizeKeys(criteria)
            sanitizeKeys(values)
            let sql = `UPDATE ${table} SET ${Object.keys(values).map(k => `${fieldsMap[k]} = @${k}`).join(',')} WHERE ${buildSqlCriteria(criteria)}`
            executeSql(sql, {...values, ...criteria})
        },
        delete: criteria => {
            sanitizeKeys(criteria)
            let sql = `DELETE FROM ${table} WHERE ${buildSqlCriteria(criteria)}`
            executeSql(sql, criteria)
        }
    }
    return crud
}

const upsert = (crud,values) => {
    if (values.id) {
        crud.update({ id: values.id }, values)
    } else {
        crud.create({...values, id: null })
    }
}

const crud = {
    phone: generateCrud('phone', {
        id: 'id',
        playerUuid: 'player_uuid',
        serialNumber: 'serial_number',
        firstName: 'first_name',
        lastName: 'last_name',
        number: 'number',
        isActive: 'is_active',
        soundNotification: 'sound_notification',
        soundRinging: 'sound_ringing',
        soundAlarm: 'sound_alarm',
        soundNotificationVolume: 'sound_notification_volume',
        soundRingingVolume: 'sound_ringing_volume',
        soundAlarmVolume: 'sound_alarm_volume',
        darkMode: 'dark_mode',
        zoom: 'zoom',
        wallpaper: 'wallpaper',
        wallpaperLock: 'wallpaper_lock',
        luminosity: 'luminosity',
        appHomeOrder: 'app_home_order'
    }),
    contacts: generateCrud('phone_contacts', {
        id: 'id',
        playerUuid: 'player_uuid',
        name: 'name',
        number: 'number',
        note: 'note',
        avatar: 'avatar',
    }),
    messages: generateCrud('phone_messages', {
        id: 'id',
        sourceUuid: 'source_uuid',
        targetUuid: 'target_uuid',
        msgTime: 'msg_time',
        txt: 'txt',
        imgId: 'img_id',
        gps: 'gps_json',
    }),
    calls: generateCrud('phone_call_history', {
        id: 'id',
        sourceUuid: 'source_uuid',
        targetUuid: 'target_uuid',
        callTime: 'call_time',
        accepted: 'accepted',
        callDuration: 'call_duration',
        video: 'video',
    }),
}


/**
 * Description for the user data object
 * 
 * @typedef {Object} UserData
 * @param {string} uuid
 * @param {string} steamId
 * @param {string} phoneNumber
 * @param {string} firstName
 * @param {string} lastName
 * @param {Object} parameters
 * @param {Object} contacts
 * @param {Object} messages
 * @param {Object} calls
 */

function fetchSteamIdFromNumber(num) {
    return fetchDb("SELECT identifier FROM users WHERE phone_number = @num", {num})
}

/**
 * Get full phone data from db in a structured object
 * @param {string} steamId 
 * @returns {UserData}
 */
async function requestUserData(steamId) {
    try {
        // identity
        const identityResponse = await fetchDb("SELECT u.uuid as uuid, u.identifier as steamId, u.phone_number as phoneNumber, p.first_name as firstName, p.last_name as lastName"
            + " FROM users u"
            + " INNER JOIN players_identity p ON u.uuid = p.uuid"
            + " WHERE u.identifier = @id"
        , { id: steamId })
        if (!identityResponse || identityResponse.length != 1) {
            console.error('Identity query failed with steamid', steamId)
            return
        }
        const userData = identityResponse[0]
        const id = userData.uuid
        // parameters
        const phoneResponse = await crud.phone.read({ playerUuid: id })
        if (!phoneResponse || phoneResponse.length === 0) {
            console.log('Phone query failed, creating default phone params for user ', steamId)
        }
        userData.phone = phoneResponse[0]
        // contacts
        const contactsResponse = await crud.contacts.read({ playerUuid: id })
        if (!contactsResponse) {
            console.error('Contacts query failed with steamid', steamId)
            return
        }
        const defaultContacts = [{ id: -1, playerUuid: id, name: 'Urgences', number: '911' }]
        userData.contacts = [...defaultContacts, ...contactsResponse]
        // messages
        const sentMsgResponse = await crud.messages.read({ sourceUuid: id })
        const receivedMsgResponse = await crud.messages.read({ targetUuid: id })
        if (!sentMsgResponse || !receivedMsgResponse) {
            console.error('Messages query failed with steamId', steamId)
            return
        }
        userData.messages = [...sentMsgResponse, ...receivedMsgResponse].sort((a,b)=>b.msgTime-a.msgTime)
        // calls history
        const sentCallsResponse = await crud.calls.read({ sourceUuid: id })
        const receivedCallsResponse = await crud.calls.read({ sourceUuid: id })
        if (!sentCallsResponse || !receivedCallsResponse) {
            console.error('Call history query failed with steamId', steamId)
        }
        userData.calls = [...sentCallsResponse, ...receivedCallsResponse].sort((a,b)=>b.callTime-a.callTime)
        return userData
    } catch (e) {
        console.error('Could not fetch user data with steamId "'+steamId+'"', e)
    }
}

/**
 * ===============================
 * Update User data
 * ===============================
 */
async function updateUserData () {
    const src = source
    const steamId = getSteamId(source)
    const userData = await requestUserData(steamId)
    if (!userData) {
        console.error('Could not get user data with steam id ', steamId, 'from source', src)
        return
    }
    emitNet('phone_ora:updateUserData', src, { playerId: src, ...userData })
}

async function patchUserData(userData) {
    let update = false
    if (!userData.uuid) { 
        console.error('uuid is missing to patch user data')
        return
    }
    if (userData.phone) {
        crud.phone.update({ playerUuid: userData.uuid }, userData.phone)
    }

    if (userData.contacts) {
        for (const c of userData.contacts) {
            if (c.id == null || c.id == undefined) {
                update = true
            }
            upsert(crud.contacts, { ...c, playerUuid: userData.uuid, avatar: null, })
        }
    }
    if (update) {
        updateUserData()
    }
}

/**
 * =======================
 * Online players tracking
 * =======================
 */

/**
 * Map connected players source & steamid
 */
 const onlinePlayers = {}

 /**
  * Get steam id by source from the onlinePlayers map
  * @param {number} source 
  * @returns {string}
  */
 function getSteamId(source) {
     if (!onlinePlayers.hasOwnProperty(source)) {
         const idMax = GetNumPlayerIdentifiers(source)
         let steamId
         for (let i= 0; i < idMax; i ++) {
             if (GetPlayerIdentifier(source, i).startsWith('steam:')) {
                 steamId = GetPlayerIdentifier(source, i)
                 break
             }
         }
         if (!steamId) { return null }
         onlinePlayers[source] = steamId
     }
     return onlinePlayers[source]
 }
 
 /**
  * Get source by steamid from the onlinePlayers map
  * @param {string} steamId 
  * @returns {number}
  */
 function getOnlinePlayerBySteamId(steamId) {
     for (const p in onlinePlayers) {
         console.log('player', p, onlinePlayers[p])
         if (onlinePlayers[p] == steamId) { return p }
     }
     return null
 }
/**
 * ========================
 * Voice channel operations
 * ========================
 */

/**
 * Get an empty voice channel number > 0 and < 100
 * @returns {number}
 */
function getFreeChan() {
    let chan = 1
    while (chan < 100 && callers[chan] !== undefined) {
        chan ++
    }
    if (chan == 100) { return null }
    return chan
}

//Map solo callers awaiting for an answer
const callers = {
}

function purgeCaller (src, video = false) {
   for (const chan in callers) {
       if ([callers[chan].receiverId, callers[chan].callerId].includes(src)) {
           endCall(chan, video)
           return
       }
   }
}

/**
 * Remove everybody from voice channel
 * @param {number} chan 
 */
function endCall(chan, video = false) {
    console.log('remove callers from channel ', chan, callers[chan] || callers)
    if (!callers[chan]) { return }
    exports["pma-voice"].setPlayerCall(callers[chan].callerId, 0)
    exports["pma-voice"].setPlayerCall(callers[chan].receiverId, 0)
    if (video) {
        emitNet('phone_ora:endVideoCall', callers[channel].callerId)
        emitNet('phone_ora:endVideoCall', callers[channel].receiverId)
    } else {
        emitNet('phone_ora:callFinished', callers[chan].callerId)
        emitNet('phone_ora:callFinished', callers[chan].receiverId)
    }
    delete callers[chan]
}

/**
 * =============
 * Server Events
 * =============
 */
on('playerDropped', _ => {
    const src = source
    if (onlinePlayers.hasOwnProperty(src)) {
        delete onlinePlayers[source]
    }
    purgeCaller(src)
})
on("Ora::SE::PlayerLoaded", source => {
    onlinePlayers[source] = getSteamId(source)
    console.log('player loaded', source, onlinePlayers[source])
})

/**
 * ==============
 * Network events
 * ==============
 */

onNet('OraPhone:server:request_user_data', updateUserData)

onNet('phone_ora:patch_user_data', async data => {
    patchUserData(data)
})

onNet('phone_ora:delete_contact', async data => {
    if (!data.id) {
        console.error('canno delete contact without id')
        return
    }
    crud.contacts.delete({ id: data.id })
})

onNet('phone_ora:call_number', async (sourceNum,targetNum,video=false) => {
    const src = source
    const res = await fetchSteamIdFromNumber(targetNum)
    if (!res || res.length == 0) {
        console.error('db gave no result for number ',targetNum, res)
        return
    }
    const steamId = res[0]['identifier']
    console.log('got a steamid', steamId)
    const receiver = getOnlinePlayerBySteamId(steamId)
    if (!receiver) {
        console.error('Player with steamid', steamId ,'is not currently online')
        return
    }
    
    const chan = getFreeChan()
    // save channel for the call and send call notif to receiver
    callers[chan] = {callerId:src, callerSteamId: onlinePlayers[src], receiverSteamId: steamId, receiverId:receiver, fromNum: sourceNum, chan}
    emitNet('phone_ora:receiveCall', receiver, sourceNum, chan, video)
    console.log('call emitted from ',GetPlayerName(src),' to ', GetPlayerName(receiver), 'for channel ', chan)
})

onNet('phone_ora:accept_call', async (channel, video=false) => {
    const src = source
    if (!callers[channel]) { 
        console.error('no registered channel to accept the call', channel)
        return
    }
    console.log(GetPlayerName(src), ' accepted call, moving both in chan', channel, 'with ', GetPlayerName(callers[channel].callerId))
    exports["pma-voice"].setPlayerCall(src, channel)
    exports["pma-voice"].setPlayerCall(callers[channel].callerId, channel)
    if (video) {
        emitNet('phone_ora:startVideoCall', callers[channel].callerId)
        // emitNet('phone_ora:startVideoCall', src)
    } else {
        emitNet('phone_ora:callStarted', callers[channel].callerId)
    }
})

onNet('phone_ora:end_call', (video=false) => {
    const src = source
    purgeCaller(src, video)
})