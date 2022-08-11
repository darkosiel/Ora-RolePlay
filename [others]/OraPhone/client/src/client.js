/// <reference path="node_modules/fivem-js/lib/index.d.ts"/>
/// <reference path="node_modules/@citizenfx/client/natives_universal.d.ts"/>
/**
 * Imports
 */
 import anim from './anim.js'

 const Delay = ms => new Promise(r=>setTimeout(r, ms))
 /**
  * Config
  * 
  */
 const weekDays = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche']
 const months = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre']
 /**
  * Client
  */
 let phoneVisible = false
 let mouseFocus = false
 
// RegisterKeyMapping('phone', 'Téléphone', 'keyboard', 'e')
RegisterKeyMapping('phone', 'Téléphone', 'keyboard', 'f1')
RegisterCommand('phone', _=>setPhoneVisible(!phoneVisible))

function setMouseFocus(active = true) {
    mouseFocus = active
}

//  function getIngameTime() {
//      return {
//          monthDay: GetClockDayOfMonth(),
//          weekDay: weekDays[GetClockDayOfWeek()],
//          month: months[GetClockMonth()],
//          hours: GetClockHours(),
//          minutes: GetClockMinutes(),
//          year: GetClockYear(),
//      }
//  }





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
onNet('phone_ora:updateUserData', data => {
    SendNUIMessage({
        type: 'updateUserData',
        data: data
    })
})

onNet('phone_ora:callStarted', _ => {
    SendNUIMessage({
        action: 'beginCall',
    })
})

 onNet('phone_ora:callFinished', _ => {
     SendNuiMessage({
         action: 'endCall'
     })
 })

onNet('phone_ora:receiveCall', async (fromNumber, chan, video=false) => {
    playClassicNotifSound(2)
    await setPhoneVisible(true)
    SendNUIMessage({
        action: 'receiveCall',
        fromNumber,
        channel: chan,
        video,
        time: getIngameTime()
    })
})

 // Nui callbacks


RegisterNuiCallbackType('request_user_data')
on('__cfx_nui:request_user_data', _ => {
    emitNet('OraPhone:server:request_user_data')
})

RegisterNuiCallbackType('patch_user_data')
on('__cfx_nui:patch_user_data', params => {
    emitNet('phone_ora:patch_user_data', params)
})

 RegisterNuiCallbackType('delete_contact')
 on('__cfx_nui:delete_contact', c => {
     emitNet('phone_ora:delete_contact', c)
 })
 
 RegisterNuiCallbackType('send_message')
 on('__cfx_nui:send_message', msgData => {
     emitNet('phone_ora:send_message', msgData)
 })

RegisterNuiCallbackType('accept_call')
on('__cfx_nui:accept_call', channel => {
    if (!channel) { console.error('accept call: missing channel') }
    anim.PhonePlayCall()
    emitNet('phone_ora:accept_call', channel)
})

 RegisterNuiCallbackType('end_call')
 on('__cfx_nui:end_call', _ => {
     console.log('nui end call received')
     emitNet('phone_ora:end_call')
     anim.PhonePlayText()
 })
 
RegisterNuiCallbackType('call_number')
on('__cfx_nui:call_number', data => {
    anim.PhonePlayCall()
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
    emitNet('phone_ora:call_number', data.fromNumber, data.targetNumber)
})

 RegisterNuiCallbackType('right_click')
 on('__cfx_nui:right_click', _ => {
     // right click on UI = give back focus and some controls to fivem client without hiding the phone
     setMouseFocus(false)
 })
 
 //*// Debug
 RegisterNuiCallbackType('debug')
 on('__cfx_nui:debug', data => {
     console.log('Nui:debug',data.debugTitle)
     delete data.debugTitle
     console.log(data)
 })
 //*///