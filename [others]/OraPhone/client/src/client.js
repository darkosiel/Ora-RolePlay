/// <reference path="node_modules/fivem-js/lib/index.d.ts"/>
/// <reference path="node_modules/@citizenfx/client/natives_universal.d.ts"/>
/**
 * Imports
 */
 import anim from './anim.js'

 const Delay = ms => new Promise(r=>setTimeout(r, ms))
 /**
  * Client
  */
 let phoneVisible = false
 let mouseFocus = false

RegisterKeyMapping('phone', 'Téléphone', 'keyboard', 'e')
RegisterCommand('phone', _=>setPhoneVisible(!phoneVisible))

function setMouseFocus(active = true) {
    mouseFocus = active
}

 // onTick timer ref
let onTick
async function setPhoneVisible(visible = true) {
    phoneVisible = visible
    // When we wanna show the phone
    if (visible) {
        // play some fivem anim
        await anim.PhonePlayIn()
        // Give focus to Nui
        SetNuiFocus(true, true)
        setMouseFocus(visible)
        SetNuiFocusKeepInput(visible)
        // lock controls, focus nui
        onTick = setTick(_=> {
            // On right click in fivem focus back to the phone
            // if (IsControlJustReleased(1, 25) && phoneVisible) {
            //     setMouseFocus(true)
            // }
            // Enforce nui focus on or off
            // SetNuiFocus(mouseFocus, mouseFocus)
            // https://docs.fivem.net/docs/game-references/controls/
            DisableAllControlActions(1)
            // sprint
            EnableControlAction(1, 21)
            // right click to switch focus back on ui
            EnableControlAction(1, 25)
            // move
            EnableControlAction(1, 30);EnableControlAction(1, 31);EnableControlAction(1, 32);EnableControlAction(1, 33);EnableControlAction(1, 34);EnableControlAction(1, 35)
            // push to talk
            EnableControlAction(1, 249);
        })
    // When we wanna hide the phone
    } else {
        // Play some fivem anim
        await anim.PhonePlayOut()
        // stop blocking controls on tick
        clearTick(onTick)
        ClearAllPedProps(GetPlayerPed(GetPlayerFromServerId(source)));
        // bring them back
        EnableAllControlActions(1)
    }
    // Give & remove focus
    SetNuiFocus(visible, visible)
     // Show & hide UI
    SendNUIMessage({
        type: "ui",
        display: visible
    })
}

// onNet events from server

// User data

onNet('OraPhone:updateUserData', data => {
    SendNUIMessage({
        type: 'updateUserData',
        data: data,
    })
})

// Contacts

onNet('OraPhone:client:updateContacts', data => {
    SendNUIMessage({
        type: 'updateContacts',
        contacts: data
    })
})

// Call

onNet('OraPhone:client:callStarted', _ => {
    SendNUIMessage({
        type: 'callStarted',
    })
})

onNet('OraPhone:client:callFinished', _ => {
    anim.PhonePlayIn()
    SendNUIMessage({
        type: 'callEnded',
    })
})

onNet('OraPhone:client:receiveCall', async (fromNumber, chan, video=false) => {
    SendNUIMessage({
        type: 'receiveCall',
        fromNumber,
        channel: chan,
        video,
    })
})

onNet('OraPhone:client:receiver_offline', _ => {
    SendNUIMessage({
        type: 'callEnded',
    })
    anim.PhonePlayText()
})

// Messages

onNet('OraPhone:client:update_messages', data => {
    SendNUIMessage({
        type: 'update_conversations',
        conversations: data
    })
})

onNet('OraPhone:client:new_notification', data => {
    SendNUIMessage({
        type: 'new_notification',
        notification: data
    })
})

// Nui callbacks

// User Data

RegisterNuiCallbackType('request_user_data')
on('__cfx_nui:request_user_data', _ => {
    emitNet('OraPhone:server:request_user_data')
})

RegisterNuiCallbackType('patch_user_data')
on('__cfx_nui:patch_user_data', params => {
    emitNet('OraPhone:patch_user_data', params)
})

RegisterNuiCallbackType('send_message')
on('__cfx_nui:send_message', msgData => {
    emitNet('OraPhone:send_message', msgData)
})

// Contacts

RegisterNuiCallbackType('refresh_contacts')
on('__cfx_nui:refresh_contacts', data => {
    emitNet('OraPhone:server:refresh_contacts', data)
})

RegisterNuiCallbackType('add_contact')
on('__cfx_nui:add_contact', c => {
    emitNet('OraPhone:add_contact', c)
})

RegisterNuiCallbackType('delete_contact')
on('__cfx_nui:delete_contact', c => {
    emitNet('OraPhone:server:delete_contact', c)
})

RegisterNuiCallbackType('update_contact')
on('__cfx_nui:update_contact', c => {
    emitNet('OraPhone:server:update_contact', c)
})

// Call

RegisterNuiCallbackType('call_number')
on('__cfx_nui:call_number', data => {
    if (!data.targetNumber) { 
        console.error('call number: missing target number')
        return
    }
    if (!data.fromNumber) {
        console.error('call number: missing source number')
        return
    }
    if (data.targetNumber == data.fromNumber) {
        console.error('call number: the player is trying to call himself.')
        return
    }
    anim.PhonePlayCall()
    SendNUIMessage({
        type: 'call_number_response'
    })
    emitNet('OraPhone:server:call_number', data.fromNumber, data.targetNumber)
})

RegisterNuiCallbackType('accept_call')
on('__cfx_nui:accept_call', channel => {
    if (!channel) { console.error('accept call: missing channel') }
    anim.PhonePlayCall()
    emitNet('OraPhone:server:accept_call', channel)
})

RegisterNuiCallbackType('end_call')
on('__cfx_nui:end_call', _ => {
    console.log('nui end call received')
    emitNet('OraPhone:server:end_call')
})

// Messsages

RegisterNuiCallbackType('message_create_conversation')
on('__cfx_nui:message_create_conversation', data => {
    if (!data.authors) { 
        console.error('missing authors')
        return
    }
    emitNet('OraPhone:server:message_create_conversation', data)
})

RegisterNuiCallbackType('refresh_conversations')
on('__cfx_nui:refresh_conversations', data => {
    emitNet('OraPhone:server:refresh_conversations', data)
})

RegisterNuiCallbackType('add_message')
on('__cfx_nui:add_message', data => {
    emitNet('OraPhone:server:add_message', data)
})




RegisterNuiCallbackType('right_click')
on('__cfx_nui:right_click', _ => {
     // right click on UI = give back focus and some controls to fivem client without hiding the phone
    setMouseFocus(false)
})

RegisterNuiCallbackType('EnableInput')
on('__cfx_nui:EnableInput', _ => {
    SetNuiFocusKeepInput(true)
})

RegisterNuiCallbackType('DisableInput')
on('__cfx_nui:DisableInput', _ => {
    SetNuiFocusKeepInput(false)
})


 //*// Debug
RegisterNuiCallbackType('debug')
on('__cfx_nui:debug', data => {
    console.log('Nui:debug',data.debugTitle)
    delete data.debugTitle
    console.log(data)
})