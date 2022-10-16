/// <reference path="node_modules/fivem-js/lib/index.d.ts"/>
/// <reference path="node_modules/@citizenfx/client/natives_universal.d.ts"/>
/**
 * Imports
 */
import anim from './anim.js'

const Wait = ms => new Promise(r=>setTimeout(r, ms))
/**
  * Client
  */
let phoneVisible = false
let mouseFocus = false
var frontCam = false
var firstTime = false
var takePictureBool = false
var app = "";
var appSub = "";
var onTick
var onTickCamera
var phoneActive = false
var canSetPhoneVisible = true

RegisterKeyMapping('phone', 'Téléphone', 'keyboard', 'f2')
RegisterCommand('phone', _=>setPhoneVisible(!phoneVisible))

function setMouseFocus(active = true) {
    mouseFocus = active
}

// onTick timer ref
async function setPhoneVisible(visible = true) {
    if((!phoneActive && !phoneVisible) || !canSetPhoneVisible) {
        return
    }
    canSetPhoneVisible = false
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
        onTick = setTick( async () => {
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
            EnableControlAction(1, 27)
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
    await Wait(600)
    canSetPhoneVisible = true
}

function CellFrontCamActivate(activate) {
    firstTime = false
	return Citizen.invokeNative('0x2491A93618B7D838', activate)
}

DestroyMobilePhone()
async function setCamera(activate) {
    if(activate) {
        exports.Ora_utils.SetPlayerHUD(false)
        onTickCamera = setTick(async () => {
            DisableControlAction(1, 200)
            if (IsControlJustPressed(1, 177)) { // -- CLOSE PHONE
                DestroyMobilePhone()
                CellCamActivate(false, false)
                SendNUIMessage({
                    type: "cancel_picture"
                })
                setPhoneVisible(true)
                stopTick();
                exports.Ora_utils.SetPlayerHUD(true)
            }
            if (IsControlJustPressed(1, 27) && firstTime == false) { // -- SELFIE MODE
                firstTime = true
                frontCam = !frontCam
                CellFrontCamActivate(frontCam)
            }
            if (IsControlJustPressed(1, 18) && takePictureBool == false) { // -- TAKE PICTURE
                takePictureBool = true
                takePicture()
            }
            if (takePictureBool == false && phoneVisible == false) {
                let text = "Appuyez sur ~INPUT_CELLPHONE_UP~ pour changer la caméra"
                DisplayHelpText(text)
            }
            if (phoneVisible == false) {
                HideHudComponentThisFrame(1)
                HideHudComponentThisFrame(2)
                HideHudComponentThisFrame(3)
                HideHudComponentThisFrame(4)
                HideHudComponentThisFrame(5)
                HideHudComponentThisFrame(6)
                HideHudComponentThisFrame(7)
                HideHudComponentThisFrame(8)
                HideHudComponentThisFrame(9)
                HideHudComponentThisFrame(13)
                HideHudComponentThisFrame(17)
                HideHudComponentThisFrame(20)
                HideHudAndRadarThisFrame()
                ThefeedHideThisFrame()
            }
        })
    } else {
        clearTick(onTickCamera)
    }
}

async function takePicture() {
    await Wait(100)
    SendNUIMessage({
        type: "take_picture",
        app: app,
        appSub: appSub
    })
    await Wait(500)
    DestroyMobilePhone()
    CellCamActivate(false, false)
    setPhoneVisible(true)
    await Wait(500)
    exports.Ora_utils.SetPlayerHUD(true)
}

async function stopTick() {
    await Wait(100)
    clearTick(onTickCamera)
}

function DisplayHelpText(str) {
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
}

/**
 * ========================
 * onNet events from server
 * ========================
 */

// Is the phone active ?

onNet('OraPhone:client:phone_active', (active) => {
    phoneActive = active
    SendNUIMessage({
        type: "phoneActive",
        toggle: active
    })
})

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

// Phone

onNet('OraPhone:client:updateCalls', data => {
    SendNUIMessage({
        type: 'updateCalls',
        calls: data
    })
})

// Call

onNet('OraPhone:client:callStarted', _ => {
    SendNUIMessage({
        type: 'callStarted',
    })
})

onNet('OraPhone:client:callFinished', _ => {
    if (phoneVisible) {
        anim.PhonePlayIn()
    }
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

// Richter Motorsport

onNet('OraPhone:client:richtermotorsport_update_advertisement', data => {
    SendNUIMessage({
        type: 'updateRichterMotorsportAdvertisement',
        richterMotorsportAdvertisement: data
    })
})

// Gallery

onNet('OraPhone:client:gallery_update_photo', data => {
    SendNUIMessage({
        type: 'updateGalleryPhoto',
        galleryPhoto: data
    })
})

// Notes

onNet('OraPhone:client:notes_refresh', data => {
    SendNUIMessage({
        type: 'updateNotes',
        notes: data
    })
})

/**
 * =============
 * Nui callbacks
 * =============
 */

// General Phone

RegisterNuiCallbackType('phone_close')
on('__cfx_nui:phone_close', _ => {
    setPhoneVisible(false)
})

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

// Phone

RegisterNuiCallbackType('refresh_calls')
on('__cfx_nui:refresh_calls', data => {
    emitNet('OraPhone:server:refresh_calls', data)
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

RegisterNuiCallbackType('message_delete_conversation')
on('__cfx_nui:message_delete_conversation', data => {
    if (!data.id && !data.number) { 
        console.error('missing id')
        return
    }
    emitNet('OraPhone:server:message_delete_conversation', data)
})

RegisterNuiCallbackType('refresh_conversations')
on('__cfx_nui:refresh_conversations', data => {
    emitNet('OraPhone:server:refresh_conversations', data)
})

RegisterNuiCallbackType('add_message')
on('__cfx_nui:add_message', data => {
    emitNet('OraPhone:server:add_message', data)
})

// Richter Motorsport

RegisterNuiCallbackType('refresh_richtermotorsport_advertisement')
on('__cfx_nui:refresh_richtermotorsport_advertisement', data => {
    emitNet('OraPhone:server:refresh_richtermotorsport_advertisement', data)
})

RegisterNuiCallbackType('richtermotorsport_add_advertisement')
on('__cfx_nui:richtermotorsport_add_advertisement', data => {
    let players = []
    exports.Ora.TriggerServerCallback(
        "onlinePlayers:list",
        function(users) {
            for (let user of users) {
                players.push(user.id)
            }
            emitNet('OraPhone:server:richtermotorsport_add_advertisement', data, players)
        }
    )
})

RegisterNuiCallbackType('richtermotorsport_favorite_advertisement')
on('__cfx_nui:richtermotorsport_favorite_advertisement', data => {
    emitNet('OraPhone:server:richtermotorsport_favorite_advertisement', data)
})

RegisterNuiCallbackType('richtermotorsport_find_job')
on('__cfx_nui:richtermotorsport_find_job', data => {
    exports.Ora.TriggerServerCallback(
        "Ora::SVCB::Identity:Job:Get",
        function(job) {
            SendNUIMessage({
                type: 'updateRichterMotorsportRole',
                richterMotorsportRole: [job]
            })
        },
        GetPlayerServerId(PlayerId())
    )
})

// Camera

RegisterNuiCallbackType('camera_add_image')
on('__cfx_nui:camera_add_image', data => {
    emitNet('OraPhone:server:camera_add_image', data)
})

RegisterNuiCallbackType('open_camera')
on('__cfx_nui:open_camera', async (data) => {
    app = data.app
    appSub = data.appSub
    setPhoneVisible(false)
    CreateMobilePhone(1)
    CellCamActivate(true, true)
    setCamera(true)
    takePictureBool = false
})

RegisterNuiCallbackType('close_camera')
on('__cfx_nui:close_camera', async () => {
    setCamera(false)
})

// Gallery

RegisterNuiCallbackType('refresh_gallery')
on('__cfx_nui:refresh_gallery', data => {
    emitNet('OraPhone:server:refresh_gallery', data)
})

RegisterNuiCallbackType('gallery_image_remove')
on('__cfx_nui:gallery_image_remove', data => {
    emitNet('OraPhone:server:gallery_image_remove', data)
})

// Notes

RegisterNuiCallbackType('refresh_notes')
on('__cfx_nui:refresh_notes', data => {
    emitNet('OraPhone:server:refresh_notes', data)
})

RegisterNuiCallbackType('notes_add_folder')
on('__cfx_nui:notes_add_folder', data => {
    emitNet('OraPhone:server:notes_add_folder', data)
})

// --- Tools

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