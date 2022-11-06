
const Delay = ms => new Promise(r=>setTimeout(r, ms))
var inCall = false

/**
 * =============
 * DB operations / Functions
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
            return fetchDb(sql, values)
        },
        read: criteria => {
            sanitizeKeys(criteria)
            let sql = ``
            if(criteria != null || criteria != undefined) {
                sql = `SELECT ${Object.keys(fieldsMap).map(k => `${fieldsMap[k]} AS ${k}`).join(', ')} FROM ${table} WHERE ${buildSqlCriteria(criteria)}`
            } else {
                sql = `SELECT ${Object.keys(fieldsMap).map(k => `${fieldsMap[k]} AS ${k}`).join(', ')} FROM ${table}`
            }
            if(table == "ora_phone_contacts") {
                sql += ` ORDER BY name ASC`;
            } else if(table == "ora_phone_messages") {
                sql += ` ORDER BY msg_time ASC`;
            } else if(table == "ora_phone_call_history") {
                sql += ` ORDER BY id DESC`;
            } else if(table == "ora_phone") {
                sql += ` ORDER BY update_time DESC`;
            }
            return fetchDb(sql, criteria)
        },
        update: (criteria, values) => {
            sanitizeKeys(criteria)
            sanitizeKeys(values)
            let sql = `UPDATE ${table} SET ${Object.keys(values).map(k => `${fieldsMap[k]} = @${k}`).join(',')} WHERE ${buildSqlCriteria(criteria)}`
            return fetchDb(sql, {...values, ...criteria})
        },
        delete: criteria => {
            sanitizeKeys(criteria)
            let sql = `DELETE FROM ${table} WHERE ${buildSqlCriteria(criteria)}`
            return fetchDb(sql, criteria)
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
        appHomeOrder: 'app_home_order',
        updateTime: 'update_time',
        createTime: 'create_time'
    }),
    contacts: generateCrud('phone_contacts', {
        id: 'id',
        phoneId: 'phone_id',
        name: 'name',
        number: 'number',
        note: 'note',
        avatar: 'avatar',
    }),
    conversations: generateCrud('phone_conversations', {
        id: 'id',
        targetNumber: 'target_number',
        name: 'name',
        lastMsgTime: 'last_msg_time',
    }),
    messages: generateCrud('phone_messages', {
        id: 'id',
        idConversation: 'id_conversation',
        sourceNumber: 'source_number',
        msgTime: 'msg_time',
        message: 'message',
        imgId: 'img_id',
        gps: 'gps_json',
        isRead: 'is_read',
    }),
    calls: generateCrud('phone_call_history', {
        id: 'id',
        sourceNumber: 'source_number',
        targetNumber: 'target_number',
        callTime: 'call_time',
        accepted: 'accepted',
        callDuration: 'call_duration',
        video: 'video',
    }),
    richtermotorsport: generateCrud('phone_richtermotorsport', {
        id: 'id',
        phoneId: 'phone_id',
        imgUrl: 'img_url',
        model: 'model',
        category: 'category',
        description: 'description',
        registration: 'registration',
        price: 'price',
        advertisementType: 'advertisement_type',
        createTime: 'create_time',
    }),
    richtermotorsportfavorite: generateCrud('phone_richtermotorsport_favorite', {
        advertisementId: 'advertisement_id',
        phoneId: 'phone_id',
    }),
    image: generateCrud('phone_image', {
        id: 'id',
        phoneId: 'phone_id',
        imageLink: 'image_link',
        createTime: 'create_time',
    }),
    notesfolder: generateCrud('phone_notes_folder', {
        id: 'id',
        phoneId: 'phone_id',
        name: 'name',
        createTime: 'create_time',
    }),
    notesnote: generateCrud('phone_notes_note', {
        id: 'id',
        folderId: 'folder_id',
        name: 'name',
        content: 'content',
        updateTime: 'update_time',
        createTime: 'create_time',
    }),
    mapsfavorite: generateCrud('phone_maps_favorite', {
        id: 'id',
        phoneId: 'phone_id',
        name: 'name',
        icon: 'icon',
        x: 'x',
        y: 'y',
        z: 'z',
        createTime: 'create_time',
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

async function fetchSteamIdFromNumber(num) {
    return fetchDb("SELECT identifier FROM users WHERE phone_number = @num", {num})
}

/**
 * Get full phone data from db in a structured object
 * @param {string} steamId 
 * @returns {UserData}
 */
async function requestUserData(steamId, number) {
    try {
        // identity
        const identityResponse = await fetchDb("SELECT u.uuid as uuid, u.identifier as steamId, u.phone_number as phoneNumber, p.first_name as firstName, p.last_name as lastName"
            + " FROM users u"
            + " INNER JOIN players_identity p ON u.uuid = p.uuid"
            + " WHERE u.identifier = @id"
        , { id: steamId })
        console.log(steamId)
        if (!identityResponse || identityResponse.length != 1) {
            console.error('Identity query failed with steamid', steamId)
            return
        }
        const userData = identityResponse[0]
        const id = userData.uuid
        // parameters
        console.log(number)
        const phoneResponse = await crud.phone.read({ number: number })
        if (!phoneResponse || phoneResponse.length === 0) {
            console.log('Phone query failed, no phone with this number ', number)
        }
        userData.phone = phoneResponse[0]
        await crud.phone.update({ number: number }, { playerUuid: id })
        return userData
    } catch (e) {
        console.error('Could not fetch user data with steamId "' + steamId + '"', e)
    }
}

/**
 * ===============================
 * Update User data&
 * ===============================
 */
async function updateUserData(number) {
    const src = source
    const steamId = getSteamId(source)
    const userData = await requestUserData(steamId, number)
    if (!userData) {
        console.error('Could not get user data with steam id ', steamId, 'from source', src)
        return
    }
    emitNet('OraPhone:updateUserData', src, { playerId: src, ...userData })
}

async function patchUserData(userData) {
    let update = false
    // if (!userData.uuid) { 
    //     console.error('uuid is missing to patch user data')
    //     return
    // }
    if (!userData.id) {
        console.error('id is missing to patch user data')
        return
    }
    if (userData.phone) {
        crud.phone.update({ id: userData.id }, userData.phone)
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
  * Get phone number by source
  * @param {object} source 
  * @returns {number}
  */
async function getNumberBySource(source) {
    let steamId = getSteamId(source);
    // Identity
    const identityResponse = await fetchDb("SELECT u.uuid as uuid, u.identifier as steamId, u.phone_number as phoneNumber, p.first_name as firstName, p.last_name as lastName"
    + " FROM users u"
    + " INNER JOIN players_identity p ON u.uuid = p.uuid"
    + " WHERE u.identifier = @id"
    , { id: steamId });
    console.log(steamId);
    if (!identityResponse || identityResponse.length != 1) {
        console.error('Identity query failed with steamid', steamId);
        return null;
    }
    let uuid = identityResponse[0].uuid;
    const phoneResponse = await crud.phone.read({ playerUuid: uuid });
    if (!phoneResponse || phoneResponse.length === 0) {
        console.log('Phone query failed, no phone with this uuid ', uuid);
        return null;
    }
    return phoneResponse[0].number;
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
        if (callers[chan].receiverId == src || callers[chan].callerId == src) {
            endCall(chan, video)
            return
        }
    }
    inCall = false
    emitNet('OraPhone:client:callFinished', src)
}

/**
 * Remove everybody from voice channel
 * @param {number} chan 
 */
async function endCall(chan, video = false) {
    console.log('remove callers from channel ', chan, callers[chan] || callers);
    if (!callers[chan]) { return }
    // PMA Voice
    // exports["pma-voice"].setPlayerCall(callers[chan].callerId, 0);
    // exports["pma-voice"].setPlayerCall(callers[chan].receiverId, 0);
    // Salty Chat
    exports["saltychat"].EndCall(callers[chan].receiverId, callers[chan].callerId);
    exports["saltychat"].EndCall(callers[chan].callerId, callers[chan].receiverId);
    if (video) {
        emitNet('OraPhone:client:endVideoCall', callers[chan].callerId);
        emitNet('OraPhone:client:endVideoCall', callers[chan].receiverId);
    } else {
        emitNet('OraPhone:client:callFinished', callers[chan].callerId);
        emitNet('OraPhone:client:callFinished', callers[chan].receiverId);
    }
    const lastCallResponse = await crud.calls.read({ id: callers[chan].callId });
    if(lastCallResponse[0].accepted == 1) {
        let startDuration = new Date(lastCallResponse[0].callTime);
        let endDuration = new Date();
        let secondsDuration = (endDuration.getTime() - startDuration.getTime()) / 1000;
        await crud.calls.update({ id: lastCallResponse[0].id }, { callDuration: secondsDuration });
    }
    delete callers[chan];
}

/**
 * Refresh all contacts
 * @param {array} data
 */
async function refreshContacts(data) {
    const contactsResponse = await crud.contacts.read({ phoneId: data.phoneId });
    if (!contactsResponse) {
        console.error('Contacts query failed with phoneId', data.phoneId)
        return
    }
    const defaultContacts = [
        { id: -1, phoneId: data.phoneId, name: "LSPD", number: "police", avatar: "Law_and_order_35" },
        { id: -1, phoneId: data.phoneId, name: "LSSD", number: "lssd", avatar: "Law_and_order_3" },
        { id: -1, phoneId: data.phoneId, name: "SAMS/LSFD", number: "lsms/lsfd", avatar: "Pharmacy_20" },
        { id: -1, phoneId: data.phoneId, name: "Weazel News", number: "journaliste", avatar: "Creative_Design_2" },
        { id: -1, phoneId: data.phoneId, name: "LS Customs", number: "mecano", avatar: "Cars_14" },
        { id: -1, phoneId: data.phoneId, name: "Auto Repairs", number: "mecano2", avatar: "Cars_17" },
        { id: -1, phoneId: data.phoneId, name: "Benny's", number: "bennys", avatar: "Cars_15" },
        { id: -1, phoneId: data.phoneId, name: "Cabinet Hermerion", number: "avocat", avatar: "Law_and_order_10" },
        { id: -1, phoneId: data.phoneId, name: "Cabinet Lysias", number: "avocat2", avatar: "Law_and_order_10" },
        { id: -1, phoneId: data.phoneId, name: "Cabinet Genovese", number: "avocat3", avatar: "Law_and_order_10" },
        { id: -1, phoneId: data.phoneId, name: "Cabinet Wistaria", number: "avocat4", avatar: "Law_and_order_10" },
        { id: -1, phoneId: data.phoneId, name: "Burger Shot", number: "burgershot", avatar: "Bowling_48" },
        { id: -1, phoneId: data.phoneId, name: "Post OP", number: "grossiste", avatar: "Cars_47" },
        { id: -1, phoneId: data.phoneId, name: "Mirror", number: "restaurant", avatar: "50-Supermarket-Icons_49" },
        { id: -1, phoneId: data.phoneId, name: "Taxi", number: "taxi", avatar: "Cars_19" },
        { id: -1, phoneId: data.phoneId, name: "LTD Nord", number: "ltdnord", avatar: "50-Supermarket-Icons_5" },
        { id: -1, phoneId: data.phoneId, name: "LTD Davis", number: "ltdsud", avatar: "50-Supermarket-Icons_5" },
        { id: -1, phoneId: data.phoneId, name: "LTD Grove Street", number: "ltdsud2", avatar: "50-Supermarket-Icons_5" },
    ];
    return [...defaultContacts, ...contactsResponse];
}

/**
 * Refresh all Richter Motorsport app
 * @param {array} data
 */
async function refreshRichterMotorsport(phoneId) {
    const richterMotorsportAdvertisementResponse = await crud.richtermotorsport.read()
    const richterMotorsportFavoriteResponse = await crud.richtermotorsportfavorite.read({ phoneId: phoneId })
    if (!richterMotorsportFavoriteResponse) {
        console.error('Richter Motorsport Favorite query failed with phoneId', phoneId)
        return
    }
    return { advertisement: richterMotorsportAdvertisementResponse, favorite: richterMotorsportFavoriteResponse }
}

/**
 * Refresh all Richter Motorsport app
 * @param {array} data
 */
async function refreshGallery(phoneId) {
    const galleryImageResponse = await crud.image.read({ phoneId: phoneId })
    if (!galleryImageResponse) {
        console.error('Photo query failed with phoneId', phoneId)
        return
    }
    return galleryImageResponse
}

/**
 * Refresh all Notes app
 * @param {array} data
 */
// async function refreshNotes(phoneId) {
//     const notesFolderResponse = await crud.notesfolder.read({ phoneId: phoneId })
//     if(notesFolderResponse && notesFolderResponse.length > 0) {
//         for (let folder of notesFolderResponse) {
//             const notesNoteResponse = await crud.notesnote.read({ folderId: folder.id })
//             folder.notes = notesNoteResponse
//         }
//     }
//     return notesFolderResponse
// }

/**
 * Refresh all Maps Favorite position
 * @param {array} data
 */
async function refreshMapsFavorite(phoneId) {
    const mapsFavoriteResponse = await crud.mapsfavorite.read({ phoneId: phoneId })
    return mapsFavoriteResponse
}

/**
 * Refresh all calls
 * @param {array} data
 */
async function refreshCalls(data) {
    const callsResponse = await fetchDb("SELECT * FROM ora_phone_call_history WHERE source_number = " + data.number + " OR target_number = " + data.number + " ORDER BY id DESC LIMIT 20")
    if (!callsResponse) {
        console.error('Contacts query failed with number', data.number)
        return
    }
    return [...callsResponse]
}

/**
 * Refresh all conversations
 * @param {array} data
 */
async function refreshConversations(number) {
    let conversationsResponse = await fetchDb("SELECT * FROM ora_phone_conversations WHERE target_number LIKE '%" + number + "%' ORDER BY last_msg_time DESC");
    if (!conversationsResponse) {
        console.error('Contacts query failed with number', number)
        return
    }
    for (let conversation of conversationsResponse) {
        let isActive = true;
        let authorList = JSON.parse(conversation.target_number)
        for (let author of authorList) {
            if (author.number == number && !author.active) {
                isActive = false
                break
            }
        }
        if (isActive) {
            let messageResponse = await crud.messages.read({ idConversation: conversation.id })
            conversation.messages = []
            if (messageResponse) {
                conversation.messages = messageResponse
            }
        } else {
            conversationsResponse = conversationsResponse.filter((conv) => conv.id != conversation.id)
        }
    }
    return conversationsResponse
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

onNet('OraPhone:server:request_user_data', async data => {
    updateUserData(data)
})

onNet('OraPhone:patch_user_data', async data => {
    patchUserData(data)
})

// Contacts

onNet('OraPhone:server:refresh_contacts', async data => {
    const src = source
    emitNet('OraPhone:client:updateContacts', src, await refreshContacts(data))
})

onNet('OraPhone:add_contact', async data => {
    const src = source
    if (!data.phoneId && !data.name && !data.number && !data.avatar) {
        console.error('cannot add contact without phoneId, name, number and avatar')
        return
    }
    await crud.contacts.create({ phoneId: data.phoneId, name: data.name, number: data.number, avatar: data.avatar })
    emitNet('OraPhone:client:updateContacts', src, await refreshContacts(data))
})

onNet('OraPhone:server:delete_contact', async data => {
    const src = source
    if (!data.id) {
        console.error('cannot delete contact without id')
        return
    }
    crud.contacts.delete({ id: data.id })
    emitNet('OraPhone:client:updateContacts', src, await refreshContacts(data))
})

onNet('OraPhone:server:update_contact', async data => {
    const src = source
    if (!data.id && !data.name && !data.number && !data.avatar) {
        console.error('cannot add contact without id, name, number and avatar')
        return
    }
    await crud.contacts.update({ id: data.id }, data.data)
    emitNet('OraPhone:client:updateContacts', src, await refreshContacts(data))
})

// Call

onNet('OraPhone:server:call_number', async (sourceNum, targetNum, video=false) => {
    inCall = true
    const src = source
    const res = await fetchSteamIdFromNumber(targetNum)
    if (!res || res.length == 0) {
        console.error('db gave no result for number ',targetNum, res)
        await Delay(3000)
        if(inCall) {
            emitNet('OraPhone:client:receiver_offline', src)
        }
        return
    }
    const steamId = res[0]['identifier']
    console.log('got a steamid', steamId)
    const receiver = getOnlinePlayerBySteamId(steamId)
    if (!receiver) {
        console.error('Player with steamid', steamId ,'is not currently online')
        await crud.calls.create({ sourceNumber: sourceNum, targetNumber: targetNum })
        await Delay(3000)
        if(inCall) {
            emitNet('OraPhone:client:receiver_offline', src)
        }
        return
    }
    for(let [chanIndex, chanValue] of Object.entries(callers)) {
        if(chanValue.receiverId == receiver) {
            console.log('Player is already on a channel', chanIndex, chanValue)
            await crud.calls.create({ sourceNumber: sourceNum, targetNumber: targetNum })
            await Delay(5000)
            if(inCall) {
                emitNet('OraPhone:client:receiver_offline', src)
            }
            return
        }
    }
    const chan = getFreeChan();
    // save channel for the call and send call notif to receiver
    await crud.calls.create({ sourceNumber: sourceNum, targetNumber: targetNum });
    const lastCallResponse = await crud.calls.read({ sourceNumber: sourceNum, targetNumber: targetNum });
    callers[chan] = {callerId:src, callerSteamId: onlinePlayers[src], receiverSteamId: steamId, receiverId:receiver, fromNum: sourceNum, targetNum: targetNum, chan, callId: lastCallResponse[0].id };
    emitNet('OraPhone:client:receiveCall', receiver, sourceNum, targetNum, chan, video);
    console.log('call emitted from ',GetPlayerName(src),' to ', GetPlayerName(receiver), 'for channel ', chan);
})

onNet('OraPhone:server:accept_call', async (channel, video=false) => {
    const src = source;
    channel = channel.channel;
    if (!callers[channel]) { 
        console.error('no registered channel to accept the call', channel);
        return;
    }
    console.log(GetPlayerName(src), ' accepted call, moving both in chan', channel, 'with ', GetPlayerName(callers[channel].callerId));
    // PMA Voice
    // exports["pma-voice"].setPlayerCall(src, channel);
    // exports["pma-voice"].setPlayerCall(callers[channel].callerId, channel);
    // Salty Chat
    exports["saltychat"].EstablishCall(src, callers[channel].callerId);
    exports["saltychat"].EstablishCall(callers[channel].callerId, src);
    await crud.calls.update({ id: callers[channel].callId }, { accepted: 1 });
    if (video) {
        emitNet('OraPhone:startVideoCall', callers[channel].callerId);
        // emitNet('phone_ora:startVideoCall', src);
    } else {
        emitNet('OraPhone:client:callStarted', callers[channel].callerId, callers[channel].targetNum);
    }
})

onNet('OraPhone:server:end_call', (video=false) => {
    const src = source
    purgeCaller(src, video)
})

// Phone

onNet('OraPhone:server:refresh_calls', async data => {
    const src = source
    emitNet('OraPhone:client:updateCalls', src, await refreshCalls(data))
})

// Message

onNet('OraPhone:server:message_create_conversation', async (data) => {
    const src = source;
    let where = "";
    let dataConversation = {};
    let authorList = [];
    for(let author of data.authors) {
        where += " target_number LIKE '%" + author + "%' AND";
    }
    where = where.slice(0, -4)
    let conversationResponse = await fetchDb("SELECT * FROM ora_phone_conversations WHERE" + where);
    let conversationExist = false;
    for(let conversation of conversationResponse) {
        if(JSON.parse(conversation.target_number).length == data.authors.length) {
            conversationExist = true;
            authorList = JSON.parse(conversation.target_number);
            for (let author of authorList) {
                if(author.number == data.number && !author.active) {
                    author.active = true;
                    break;
                }
            }
            dataConversation.id = conversation.id;
            await crud.conversations.update({ id: conversation.id }, { targetNumber: JSON.stringify(authorList) });
            break;
        }
    }
    authorList = [];
    if(!conversationResponse || !conversationExist) {
        for (let author of data.authors) {
            authorList.push({
                number: author,
                active: true,
                isRead: true
            });
        }
        await crud.conversations.create({ targetNumber: JSON.stringify(authorList) });
        conversationResponse = await fetchDb("SELECT * FROM ora_phone_conversations WHERE" + where);
        for(let conversation of conversationResponse) {
            if(JSON.parse(conversation.target_number).length == data.authors.length) {
                dataConversation.id = conversation.id;
                break;
            }
        }
    }
    emitNet('OraPhone:client:update_messages', src, await refreshConversations(data.number), dataConversation);
})

onNet('OraPhone:server:message_delete_conversation', async (data) => {
    const src = source
    let conversationResponse = await crud.conversations.read({ id: data.id })
    if (!conversationResponse || conversationResponse.length == 0) {
        console.error('db gave no result for conversation ', data.id)
        return
    }
    let authorList = JSON.parse(conversationResponse[0].targetNumber)
    for (let author of authorList) {
        if (author.number == data.number) {
            author.active = false
            break
        }
    }
    await crud.conversations.update({ id: data.id }, { targetNumber: JSON.stringify(authorList) })
    emitNet('OraPhone:client:update_messages', src, await refreshConversations(data.number))
})

onNet('OraPhone:server:message_update_read_conversation', async (data) => {
    const src = source;
    let dataConversation = {};
    let conversationResponse = await crud.conversations.read({ id: data.id });
    if (!conversationResponse || conversationResponse.length == 0) {
        console.error('db gave no result for conversation ', data.id);
        return;
    }
    let authorList = JSON.parse(conversationResponse[0].targetNumber);
    for (let author of authorList) {
        if (author.number == data.number) {
            author.isRead = true;
            break;
        }
    }
    await crud.conversations.update({ id: data.id }, { targetNumber: JSON.stringify(authorList) });
    dataConversation.type = "update_read";
    emitNet('OraPhone:client:update_messages', src, await refreshConversations(data.number), dataConversation);
})

onNet('OraPhone:server:message_update_name_conversation', async (data) => {
    const src = source;
    await crud.conversations.update({ id: data.id }, { name: data.name });
    let conversationResponse = await crud.conversations.read({ id: data.id });
    let targetNumber = JSON.parse(conversationResponse[0].targetNumber);
    for(let target of targetNumber) {
        const res = await fetchSteamIdFromNumber(target.number);
        if (!res || res.length == 0) {
            continue;
        }
        const steamId = res[0]['identifier'];
        const receiver = getOnlinePlayerBySteamId(steamId);
        if (!receiver) {
            continue;
        }
        emitNet('OraPhone:client:update_messages', receiver, await refreshConversations(target.number));
    }
    emitNet('OraPhone:client:update_messages', src, await refreshConversations(data.number));
})

onNet('OraPhone:server:refresh_conversations', async (data) => {
    const src = source
    emitNet('OraPhone:client:update_messages', src, await refreshConversations(data.number))
})

onNet('OraPhone:server:add_message', async (data) => {
    if (data.message === 'GPSMYPOSITION') {
        const player = source;
        const ped = GetPlayerPed(player);
        const [playerX, playerY, playerZ] = GetEntityCoords(ped);
        data.message = `GPS: ${playerX}, ${playerY}, ${playerZ}`;
    }
    await crud.messages.create({ idConversation: data.conversationId, sourceNumber: data.number, message: data.message });
    let dateNow = new Date().toLocaleString('en-CA', { dateStyle: 'short', timeStyle: 'medium', hour12: false });
    dateNow = dateNow.replaceAll(",", "");
    let conversationResponse = await crud.conversations.read({ id: data.conversationId });
    let contactList = JSON.parse(conversationResponse[0].targetNumber);
    for (let contact of contactList) {
        if (contact.number != data.number) {
            contact.isRead = false;
        }
    }
    await crud.conversations.update({ id: data.conversationId }, { targetNumber: JSON.stringify(contactList), lastMsgTime: dateNow });
    let numberList = [];
    for (let number of data.targetNumber) {
        numberList.push(number.number);
    }
    for(let target of data.targetNumber) {
        const res = await fetchSteamIdFromNumber(target.number);
        if (!res || res.length == 0) {
            continue;
        }
        const steamId = res[0]['identifier'];
        const receiver = getOnlinePlayerBySteamId(steamId);
        if (!receiver) {
            console.error('Player with steamid', steamId ,'is not currently online');
            continue;
        }
        emitNet('OraPhone:client:update_messages', receiver, await refreshConversations(target.number));
        if(target.number != data.number) {
            let notification = {
                app: "message",
                appSub: "message",
                time: "Maintenant",
                title: numberList,
                message: data.message,
                conversationId: data.conversationId
            }
            emitNet('OraPhone:client:new_notification', receiver, notification);
        }
    }
})

// Richter Motorsport

onNet('OraPhone:server:refresh_richtermotorsport_advertisement', async data => {
    const src = source
    emitNet('OraPhone:client:richtermotorsport_update_advertisement', src, await refreshRichterMotorsport(data.phoneId))
})

onNet('OraPhone:server:richtermotorsport_add_advertisement', async (data, players) => {
    const src = source
    await crud.richtermotorsport.create({ phoneId: data.phoneId, imgUrl: data.image, model: data.model, category: data.category, description: data.description, registration: data.registration, price: data.price, advertisementType: data.advertisementType })
    emitNet('OraPhone:client:richtermotorsport_update_advertisement', src, await refreshRichterMotorsport(data.phoneId))
    for(let player of players) {
        let notification = {
            app: "richtermotorsport",
            appSub: "home",
            time: "Maintenant",
            title: "Nouvelle annonce",
            message: data.model
        }
        emitNet('OraPhone:client:new_notification', player, notification)
    }
})

onNet('OraPhone:server:richtermotorsport_favorite_advertisement', async (data) => {
    const src = source
    if(data.favorite) {
        await crud.richtermotorsportfavorite.create({ phoneId: data.phoneId, advertisementId: data.advertisementId })
    } else {
        await crud.richtermotorsportfavorite.delete({ phoneId: data.phoneId, advertisementId: data.advertisementId })
    }
    emitNet('OraPhone:client:richtermotorsport_update_advertisement', src, await refreshRichterMotorsport(data.phoneId))
})

// Camera

onNet('OraPhone:server:camera_add_image', async (data) => {
    const src = source
    await crud.image.create({ phoneId: data.phoneId, imageLink: data.image })
    emitNet('OraPhone:client:gallery_update_photo', src, await refreshGallery(data.phoneId))
})

// Gallery

onNet('OraPhone:server:refresh_gallery', async (data) => {
    const src = source
    emitNet('OraPhone:client:gallery_update_photo', src, await refreshGallery(data.phoneId))
})

onNet('OraPhone:server:gallery_image_remove', async (data) => {
    const src = source
    await crud.image.delete({ id: data.id })
    emitNet('OraPhone:client:gallery_update_photo', src, await refreshGallery(data.phoneId))
})

// Notes

// onNet('OraPhone:server:refresh_notes', async (data) => {
//     const src = source
//     emitNet('OraPhone:client:notes_refresh', src, await refreshNotes(data.phoneId))
// })

// onNet('OraPhone:server:notes_add_folder', async (data) => {
//     const src = source
//     await crud.notesfolder.create({ phoneId: data.phoneId, name: data.name })
//     emitNet('OraPhone:client:notes_refresh', src, await refreshNotes(data.phoneId))
// })

// Maps

onNet('OraPhone:server:maps_favorite_refresh', async (data) => {
    const src = source
    emitNet('OraPhone:client:maps_favorite_refresh', src, await refreshMapsFavorite(data.phoneId))
})

onNet('OraPhone:server:maps_favorite_add_marker', async (data) => {
    const src = source;
    const ped = GetPlayerPed(src);
    const [playerX, playerY, playerZ] = GetEntityCoords(ped);
    await crud.mapsfavorite.create({ phoneId: data.phoneId, name: data.name, icon: data.icon, x: playerX, y: playerY, z: playerZ });
    emitNet('OraPhone:client:maps_favorite_refresh', src, await refreshMapsFavorite(data.phoneId))
})

onNet('OraPhone:server:maps_favorite_remove_marker', async (data) => {
    const src = source;
    await crud.mapsfavorite.delete({ id: data.id });
    emitNet('OraPhone:client:maps_favorite_refresh', src, await refreshMapsFavorite(data.phoneId))
})

onNet('OraPhone:server:maps_update_my_position', async (data) => {
    const src = source;
    const ped = GetPlayerPed(src);
    const [playerX, playerY, playerZ] = GetEntityCoords(ped);
    emitNet('OraPhone:client:maps_update_my_position', src, [playerX, playerY, playerZ])
})

// Create new phone

function RegisterNewPhone(phoneNumber, identity) {
    let playerUuid = identity.uuid
    let serialNumber = Math.floor(Math.random() * (9999 - 1111 + 1) + 1111) + "-" + Math.floor(Math.random() * (9999 - 1111 + 1) + 1111)
    let firstName = identity.first_name
    let lastName = identity.last_name
    let number = phoneNumber
    let isActive = 0
    let soundNotification = 'notification-sms1'
    let soundRinging = 'ringing-iosoriginal'
    let soundAlarm = 'alarm-iosradaroriginal'
    let soundNotificationVolume = '5'
    let soundRingingVolume = '5'
    let soundAlarmVolume = '5'
    let darkMode = '0'
    let zoom = 'zoom100%'
    let wallpaper = 'wallpaper-ios15'
    let wallpaperLock = 'wallpaper-ios15'
    let luminosity = '100'
    let appHomeOrder = '[\"clock\",\"camera\",\"gallery\",\"calandar\",\"\",\"\",\"\",\"\",\"notes\",\"calculator\",\"music\",\"store\",\"\",\"\",\"\",\"\",\"richtermotorsport\",\"maps\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"]'
    crud.phone.create({ playerUuid: playerUuid, serialNumber: serialNumber, firstName: firstName, lastName: lastName, number: number, isActive: isActive, soundNotification: soundNotification, soundRinging: soundRinging, soundAlarm: soundAlarm, soundNotificationVolume: soundNotificationVolume, soundRingingVolume: soundRingingVolume, soundAlarmVolume: soundAlarmVolume, darkMode: darkMode, zoom: zoom, wallpaper: wallpaper, wallpaperLock: wallpaperLock, luminosity: luminosity, appHomeOrder: appHomeOrder })
}
