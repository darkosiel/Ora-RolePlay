/**
 * Imports
 */
import anim from './anim.js'

const Wait = ms => new Promise(r=>setTimeout(r, ms));
/**
  * Client
  */
let phoneVisible = false;
let mouseFocus = false;
let frontCam = false;
let firstTime = false;
let takePictureBool = false;
let app = "";
let appSub = "";
let onTick;
let onTickCamera;
let onTickCallReceive;
let phoneActive = false;
let canSetPhoneVisible = true;
let OraUtilsPlayerHud = true;

RegisterKeyMapping('phone', 'Téléphone', 'keyboard', 'f2')
RegisterCommand('phone', _=>setPhoneVisible(!phoneVisible))

let myGroup = exports.Ora.GetMyGroup();
if (myGroup && myGroup == "superadmin") {
    RegisterCommand('oraphonerefreshplayer', _=>GetPlayers())
}

function GetPlayers() {
    myGroup = exports.Ora.GetMyGroup();
    if (myGroup && myGroup == "superadmin") {
        let players = [];
        exports.Ora.TriggerServerCallback(
            "onlinePlayers:list",
            function(users) {
                for (let user of users) {
                    players.push(user);
                }
                emitNet("OraPhone:server:refresh_players_loaded", players);
            }
        );
    }
}

function setMouseFocus(active = true) {
    mouseFocus = active;
}

// onTick timer ref
async function setPhoneVisible(visible = true) {
    if (!phoneActive && !phoneVisible) {
        SendNUIMessage({
            type: "phoneDisabled",
        });
        return;
    }
    if (!canSetPhoneVisible) {
        return;
    }
    canSetPhoneVisible = false;
    phoneVisible = visible;
    // When we wanna show the phone
    if (visible) {
        // play some fivem anim
        await anim.PhonePlayIn();
        // Give focus to Nui
        SetNuiFocus(true, true);
        setMouseFocus(visible);
        SetNuiFocusKeepInput(visible);
        // lock controls, focus nui
        onTick = setTick( async () => {
            // Enforce nui focus on or off
            // SetNuiFocus(mouseFocus, mouseFocus);
            // https://docs.fivem.net/docs/game-references/controls/
            DisableAllControlActions(1);
            // sprint
            EnableControlAction(1, 21);
            // enter vehicule
            EnableControlAction(1, 23);
            // exit vehicule
            EnableControlAction(1, 75);
            EnableControlAction(1, 49);
            EnableControlAction(1, 27);
            // move
            EnableControlAction(1, 30);EnableControlAction(1, 31);EnableControlAction(1, 32);EnableControlAction(1, 33);EnableControlAction(1, 34);EnableControlAction(1, 35);
            // move vehicule car
            EnableControlAction(1, 59);EnableControlAction(1, 60);EnableControlAction(1, 63);EnableControlAction(1, 64);EnableControlAction(1, 71);EnableControlAction(1, 72);EnableControlAction(1, 76);EnableControlAction(1, 129);EnableControlAction(1, 130);EnableControlAction(1, 133);EnableControlAction(1, 134);
            // move vehicule fly
            EnableControlAction(1, 87);EnableControlAction(1, 88);EnableControlAction(1, 89);EnableControlAction(1, 90);EnableControlAction(1, 107);EnableControlAction(1, 108);EnableControlAction(1, 109);EnableControlAction(1, 110);EnableControlAction(1, 111);EnableControlAction(1, 112);
            // move parachute
            EnableControlAction(1, 146);EnableControlAction(1, 147);EnableControlAction(1, 148);EnableControlAction(1, 149);EnableControlAction(1, 150);EnableControlAction(1, 151);EnableControlAction(1, 152);
            // push to talk
            EnableControlAction(1, 249);
        })
    // When we wanna hide the phone
    } else {
        SetNuiFocusKeepInput(visible)
        // Play some fivem anim
        await anim.PhonePlayOut();
        // stop blocking controls on tick
        await Wait(200);
        clearTick(onTick);
        // bring them back
        EnableAllControlActions(1);
    }
    // Give & remove focus
    SetNuiFocus(visible, visible);
     // Show & hide UI
    SendNUIMessage({
        type: "oraPhoneUI",
        display: visible
    });
    await Wait(600);
    canSetPhoneVisible = true;
}

function CellFrontCamActivate(activate) {
    firstTime = false;
	return Citizen.invokeNative('0x2491A93618B7D838', activate);
}

DestroyMobilePhone()
async function setCamera(activate) {
    if(activate) {
        OraUtilsPlayerHud = exports.Ora_utils.GetPlayerHUD();
        exports.Ora_utils.SetPlayerHUD(false);
        onTickCamera = setTick(async () => {
            DisableControlAction(1, 200);
            if (IsControlJustPressed(1, 202)) { // -- CLOSE PHONE
                stopCamera();
                SendNUIMessage({
                    type: "cancel_picture"
                });
            }
            if (IsControlJustPressed(1, 27) && !firstTime) { // -- SELFIE MODE
                firstTime = true;
                frontCam = !frontCam;
                CellFrontCamActivate(frontCam);
            }
            if (IsControlJustPressed(1, 201) && !takePictureBool) { // -- TAKE PICTURE
                takePictureBool = true;
                takePicture();
            }
            if (!takePictureBool && !phoneVisible) {
                let text = "Appuyez sur ~INPUT_CELLPHONE_UP~ pour changer la caméra";
                DisplayHelpText(text);
            }
            if (!phoneVisible) {
                HideHudComponentThisFrame(1);
                HideHudComponentThisFrame(2);
                HideHudComponentThisFrame(3);
                HideHudComponentThisFrame(4);
                HideHudComponentThisFrame(5);
                HideHudComponentThisFrame(6);
                HideHudComponentThisFrame(7);
                HideHudComponentThisFrame(8);
                HideHudComponentThisFrame(9);
                HideHudComponentThisFrame(13);
                HideHudComponentThisFrame(17);
                HideHudComponentThisFrame(20);
                HideHudAndRadarThisFrame();
                ThefeedHideThisFrame();
            }
        })
    } else {
        clearTick(onTickCamera);
    }
}

async function takePicture() {
    await Wait(200);
    SendNUIMessage({
        type: "take_picture",
        app: app,
        appSub: appSub
    });
    await Wait(500);
    stopCamera();
}

async function stopCamera() {
    DestroyMobilePhone();
    CellCamActivate(false, false);
    setPhoneVisible(true);
    await Wait(500);
    if (OraUtilsPlayerHud) {
        exports.Ora_utils.SetPlayerHUD(true);
    }
    stopTick();
}

async function stopTick() {
    await Wait(100);
    clearTick(onTickCamera);
    clearTick(onTickCallReceive);
}

function DisplayHelpText(str) {
	SetTextComponentFormat("STRING");
	AddTextComponentString(str);
	DisplayHelpTextFromStringLabel(0, 0, 1, -1);
}

function bankGetAccounts() {
    exports.Ora.TriggerServerCallback(
        "getBankingAccountsPly",
        async function(val) {
            let result = [
                val.own,
                val.coOwn
            ];
            let accounts = [];
            for (let accountType of result) {
                for (let account of accountType) {
                    accounts.push(account);
                }
            }
            for (let account of accounts) {
                await exports.Ora.TriggerServerCallback(
                    "getHisto",
                    function(val) {
                        account.history = val;
                    },
                    account.label,
                    account.iban
                );
            }
            if (accounts.length > 0) {
                while (accounts[accounts.length - 1].history == undefined) {
                    await Wait(100);
                }
            }
            SendNUIMessage({
                type: 'bankGetAccounts',
                accounts: accounts,
            });
        }
    );
}

/**
 * ========================
 * onNet events from server
 * ========================
 */

// Is the phone active ?

onNet('OraPhone:client:phone_active', (active) => {
    phoneActive = active;
    SendNUIMessage({
        type: "phoneActive",
        toggle: active
    });
});

// User data

onNet('OraPhone:updateUserData', data => {
    SendNUIMessage({
        type: 'updateUserData',
        data: data,
    });
});

// Contacts

onNet('OraPhone:client:updateContacts', data => {
    SendNUIMessage({
        type: 'updateContacts',
        contacts: data
    });
});

// Phone

onNet('OraPhone:client:updateCalls', data => {
    SendNUIMessage({
        type: 'updateCalls',
        calls: data
    });
});

// Call

onNet('OraPhone:client:callStarted', async (targetNumber) => {
    SendNUIMessage({
        type: 'callStarted',
        targetNumber: targetNumber,
    });
});

onNet('OraPhone:client:callFinished', _ => {
    if (phoneVisible) {
        anim.PhonePlayIn();
    }
    SendNUIMessage({
        type: 'callEnded',
    });
});

onNet('OraPhone:client:receiveCall', async (fromNumber, targetNumber, chan, video=false) => {
    SendNUIMessage({
        type: 'receiveCall',
        fromNumber: fromNumber,
        targetNumber: targetNumber,
        channel: chan,
        video: video,
    });
    if (!phoneVisible) {
        onTickCallReceive = setTick(async () => {
            if (IsControlJustPressed(1, 201)) { // -- Press Enter
                SendNUIMessage({
                    type: "takeCall",
                })
                stopTick();
            }
            if (IsControlJustPressed(1, 202)) { // -- Press Enter
                SendNUIMessage({
                    type: "cancelCall",
                })
                stopTick();
            }
        })
    }
});

onNet('OraPhone:client:receiver_offline', _ => {
    SendNUIMessage({
        type: 'callEnded',
    });
    anim.PhonePlayText();
});

// Messages

onNet('OraPhone:client:update_messages', async (data, dataConversation = false) => {
    if (!dataConversation) {
        dataConversation = {};
    }
    if (!dataConversation.id) {
        if (data.conversationId != null) {
            dataConversation.id = data.conversationId;
        } else {
            dataConversation.id = 0;
        }
    }
    if (!dataConversation.type) {
        dataConversation.type = '';
    }
    SendNUIMessage({
        type: 'update_conversations',
        conversations: data.conversations,
        conversationId: dataConversation.id,
        updatetype: dataConversation.type,
        oneConversation: (data.conversationId != null ? true : false)
    });
});

onNet('OraPhone:client:new_notification', data => {
    SendNUIMessage({
        type: 'new_notification',
        notification: data
    });
});

// Richter Motorsport

onNet('OraPhone:client:richtermotorsport_update_advertisement', data => {
    SendNUIMessage({
        type: 'updateRichterMotorsportAdvertisement',
        richterMotorsportAdvertisement: data
    });
});

// Gallery

onNet('OraPhone:client:gallery_update_photo', data => {
    SendNUIMessage({
        type: 'updateGalleryPhoto',
        galleryPhoto: data
    });
});

// Notes

// onNet('OraPhone:client:notes_refresh', data => {
//     SendNUIMessage({
//         type: 'updateNotes',
//         notes: data
//     });
// });

// Maps

onNet('OraPhone:client:maps_favorite_refresh', data => {
    SendNUIMessage({
        type: 'updateMapsFavorite',
        positions: data
    });
});

onNet('OraPhone:client:maps_update_my_position', data => {
    SendNUIMessage({
        type: 'updateMapsMyPosition',
        position: data
    });
});

// Bank

onNet('OraPhone:client:bank_send', () => {
    bankGetAccounts();
});

// Lifeinvader

onNet('OraPhone:client:refresh_lifeinvader_user', (data, status = null) => {
    SendNUIMessage({
        type: 'updateLifeinvaderUser',
        users: data,
        status: status
    });
});

onNet('OraPhone:client:lifeinvader_update_app_content', (posts, content) => {
    SendNUIMessage({
        type: 'lifeinvaderUpdateAppContent',
        posts: posts,
        content: content
    });
});

/**
 * =============
 * Nui callbacks
 * =============
 */

// General Phone

RegisterNuiCallbackType('phone_close');
on('__cfx_nui:phone_close', _ => {
    setPhoneVisible(false);
});

// User Data

RegisterNuiCallbackType('request_user_data');
on('__cfx_nui:request_user_data', _ => {
    emitNet('OraPhone:server:request_user_data');
});

RegisterNuiCallbackType('patch_user_data');
on('__cfx_nui:patch_user_data', params => {
    emitNet('OraPhone:patch_user_data', params);
});

// Contacts

RegisterNuiCallbackType('refresh_contacts');
on('__cfx_nui:refresh_contacts', data => {
    emitNet('OraPhone:server:refresh_contacts', data);
});

RegisterNuiCallbackType('add_contact');
on('__cfx_nui:add_contact', c => {
    emitNet('OraPhone:add_contact', c);
});

RegisterNuiCallbackType('delete_contact');
on('__cfx_nui:delete_contact', c => {
    emitNet('OraPhone:server:delete_contact', c);
});

RegisterNuiCallbackType('update_contact');
on('__cfx_nui:update_contact', c => {
    emitNet('OraPhone:server:update_contact', c);
});

// Call

RegisterNuiCallbackType('call_number');
on('__cfx_nui:call_number', data => {
    if (!data.targetNumber) { 
        console.error('call number: missing target number');
        return;
    }
    if (!data.fromNumber) {
        console.error('call number: missing source number');
        return;
    }
    if (data.targetNumber == data.fromNumber) {
        console.error('call number: the player is trying to call himself.');
        return;
    }
    anim.PhonePlayCall();
    SendNUIMessage({
        type: 'callNumberResponse'
    });
    emitNet('OraPhone:server:call_number', data.fromNumber, data.targetNumber);
});

RegisterNuiCallbackType('accept_call');
on('__cfx_nui:accept_call', channel => {
    if (!channel) {
        console.error('accept call: missing channel');
    }
    anim.PhonePlayCall();
    emitNet('OraPhone:server:accept_call', channel);
});

RegisterNuiCallbackType('end_call');
on('__cfx_nui:end_call', _ => {
    console.log('nui end call received');
    stopTick();
    emitNet('OraPhone:server:end_call');
});

// Phone

RegisterNuiCallbackType('refresh_calls');
on('__cfx_nui:refresh_calls', data => {
    emitNet('OraPhone:server:refresh_calls', data);
});

// Messsages

RegisterNuiCallbackType('message_create_conversation');
on('__cfx_nui:message_create_conversation', data => {
    if (!data.authors) { 
        console.error('missing authors');
        return;
    }
    emitNet('OraPhone:server:message_create_conversation', data);
});

RegisterNuiCallbackType('message_delete_conversation');
on('__cfx_nui:message_delete_conversation', data => {
    if (!data.id && !data.number) { 
        console.error('missing id');
        return;
    }
    emitNet('OraPhone:server:message_delete_conversation', data);
});

RegisterNuiCallbackType('message_update_read_conversation');
on('__cfx_nui:message_update_read_conversation', data => {
    if (!data.id && !data.number) { 
        console.error('missing id and number');
        return;
    }
    emitNet('OraPhone:server:message_update_read_conversation', data);
});

RegisterNuiCallbackType('message_update_name_conversation');
on('__cfx_nui:message_update_name_conversation', data => {
    if (!data.id && !data.name) { 
        console.error('missing id and name');
        return;
    }
    emitNet('OraPhone:server:message_update_name_conversation', data);
});

RegisterNuiCallbackType('refresh_conversations');
on('__cfx_nui:refresh_conversations', data => {
    emitNet('OraPhone:server:refresh_conversations', data);
});

RegisterNuiCallbackType('add_message');
on('__cfx_nui:add_message', data => {
    if (data.message === 'GPSMYMARKER') {
        let WaypointHandle = GetFirstBlipInfoId(8);
        if (DoesBlipExist(WaypointHandle)) {
            let waypointCoords = GetBlipInfoIdCoord(WaypointHandle);
            data.message = `GPS: ${waypointCoords[0]}, ${waypointCoords[1]}, ${waypointCoords[2]}`;
        } else {
            return;
        }
    }
    for (let number of data.targetNumber) {
        if (number.number != data.number && /[a-zA-Z]/.test(number.number)) {
            let jobs = number.number.split("/");
            const ped = GetPlayerPed(-1);
            const [x, y, z] = GetEntityCoords(ped);
            const position = {x: x, y: y, z: z};
            for (let job of jobs) {
                emitNet("call:makeCall", job, position, data.message);
            }
        }
    }
    emitNet('OraPhone:server:add_message', data);
});

RegisterNuiCallbackType('add_potition_on_map');
on('__cfx_nui:add_potition_on_map', data => {
    SetNewWaypoint(parseInt(data.x), parseInt(data.y));
});

RegisterNuiCallbackType('message_add_author_conversation');
on('__cfx_nui:message_add_author_conversation', data => {
    if (!data.id && !data.author) { 
        console.error('missing id and name');
        return;
    }
    emitNet('OraPhone:server:message_add_author_conversation', data);
});

// Richter Motorsport

RegisterNuiCallbackType('refresh_richtermotorsport_advertisement');
on('__cfx_nui:refresh_richtermotorsport_advertisement', data => {
    emitNet('OraPhone:server:refresh_richtermotorsport_advertisement', data);
});

RegisterNuiCallbackType('richtermotorsport_add_advertisement');
on('__cfx_nui:richtermotorsport_add_advertisement', data => {
    let players = [];
    exports.Ora.TriggerServerCallback(
        "onlinePlayers:list",
        function(users) {
            for (let user of users) {
                players.push(user.id);
            }
            emitNet('OraPhone:server:richtermotorsport_add_advertisement', data, players);
        }
    );
});

RegisterNuiCallbackType('richtermotorsport_favorite_advertisement');
on('__cfx_nui:richtermotorsport_favorite_advertisement', data => {
    emitNet('OraPhone:server:richtermotorsport_favorite_advertisement', data);
});

RegisterNuiCallbackType('richtermotorsport_find_job');
on('__cfx_nui:richtermotorsport_find_job', data => {
    exports.Ora.TriggerServerCallback(
        "Ora::SVCB::Identity:Job:Get",
        function(job) {
            SendNUIMessage({
                type: 'updateRichterMotorsportRole',
                richterMotorsportRole: [job]
            });
        },
        GetPlayerServerId(PlayerId())
    );
});

RegisterNuiCallbackType('richtermotorsport_delete_advertisement');
on('__cfx_nui:richtermotorsport_delete_advertisement', data => {
    emitNet('OraPhone:server:richtermotorsport_delete_advertisement', data);
});

// Camera

RegisterNuiCallbackType('camera_add_image');
on('__cfx_nui:camera_add_image', data => {
    emitNet('OraPhone:server:camera_add_image', data);
});

RegisterNuiCallbackType('open_camera');
on('__cfx_nui:open_camera', async (data) => {
    app = data.app;
    appSub = data.appSub;
    setPhoneVisible(false);
    CreateMobilePhone(1);
    CellCamActivate(true, true);
    setCamera(true);
    takePictureBool = false;
});

RegisterNuiCallbackType('close_camera');
on('__cfx_nui:close_camera', async () => {
    setCamera(false);
    stopTick();
});

// Gallery

RegisterNuiCallbackType('refresh_gallery');
on('__cfx_nui:refresh_gallery', data => {
    emitNet('OraPhone:server:refresh_gallery', data);
});

RegisterNuiCallbackType('gallery_image_remove');
on('__cfx_nui:gallery_image_remove', data => {
    emitNet('OraPhone:server:gallery_image_remove', data);
});

// Notes

RegisterNuiCallbackType('refresh_notes');
on('__cfx_nui:refresh_notes', data => {
    emitNet('OraPhone:server:refresh_notes', data);
});

RegisterNuiCallbackType('notes_add_folder');
on('__cfx_nui:notes_add_folder', data => {
    emitNet('OraPhone:server:notes_add_folder', data);
});

// Maps

RegisterNuiCallbackType('maps_favorite_refresh');
on('__cfx_nui:maps_favorite_refresh', data => {
    emitNet('OraPhone:server:maps_favorite_refresh', data);
});

RegisterNuiCallbackType('maps_favorite_add_marker');
on('__cfx_nui:maps_favorite_add_marker', data => {
    emitNet('OraPhone:server:maps_favorite_add_marker', data);
});

RegisterNuiCallbackType('maps_favorite_remove_marker');
on('__cfx_nui:maps_favorite_remove_marker', data => {
    emitNet('OraPhone:server:maps_favorite_remove_marker', data);
});

RegisterNuiCallbackType('maps_update_my_position');
on('__cfx_nui:maps_update_my_position', data => {
    emitNet('OraPhone:server:maps_update_my_position', data);
});

// Bank

RegisterNuiCallbackType('bank_get_accounts');
on('__cfx_nui:bank_get_accounts', async data => {
    bankGetAccounts();
});

RegisterNuiCallbackType('bank_send');
on('__cfx_nui:bank_send', data => {
    TriggerEvent("Ora:SendFromPhone", data.amount, data.rib1, data.rib2, data.sourceId);
});

// Lifeinvader

RegisterNuiCallbackType('refresh_lifeinvader_user');
on('__cfx_nui:refresh_lifeinvader_user', data => {
    emitNet('OraPhone:server:refresh_lifeinvader_user', data);
});

RegisterNuiCallbackType('lifeinvader_add_user');
on('__cfx_nui:lifeinvader_add_user', data => {
    emitNet('OraPhone:server:lifeinvader_add_user', data);
});

RegisterNuiCallbackType('lifeinvader_fetch_app_content');
on('__cfx_nui:lifeinvader_fetch_app_content', data => {
    emitNet('OraPhone:server:lifeinvader_fetch_app_content', data);
});

RegisterNuiCallbackType('lifeinvader_like_post');
on('__cfx_nui:lifeinvader_like_post', data => {
    emitNet('OraPhone:server:lifeinvader_like_post', data);
});

RegisterNuiCallbackType('lifeinvader_add_post_response');
on('__cfx_nui:lifeinvader_add_post_response', data => {
    emitNet('OraPhone:server:lifeinvader_add_post_response', data);
});

RegisterNuiCallbackType('lifeinvader_add_post');
on('__cfx_nui:lifeinvader_add_post', data => {
    emitNet("Ora:sendToDiscord", "OraPhoneLifeInvader", "[UserId: " + data.userId + "/Pseudo: " + data.userPseudo + "/Username: " + data.userUsername + "] : " + data.response);
    emitNet('OraPhone:server:lifeinvader_add_post', data);
});

RegisterNuiCallbackType('lifeinvader_update_user');
on('__cfx_nui:lifeinvader_update_user', data => {
    emitNet('OraPhone:server:lifeinvader_update_user', data);
});

RegisterNuiCallbackType('lifeinvader_delete_post');
on('__cfx_nui:lifeinvader_delete_post', data => {
    emitNet('OraPhone:server:lifeinvader_delete_post', data);
});

RegisterNuiCallbackType('lifeinvader_delete_user');
on('__cfx_nui:lifeinvader_delete_user', data => {
    emitNet('OraPhone:server:lifeinvader_delete_user', data);
});

// Bluetooth

RegisterNuiCallbackType('bluetooth_find_player');
on('__cfx_nui:bluetooth_find_player', data => {
    emitNet('OraPhone:server:bluetooth_find_player', data);
});

// --- Tools

RegisterNuiCallbackType('right_click');
on('__cfx_nui:right_click', _ => {
     // right click on UI = give back focus and some controls to fivem client without hiding the phone
    setMouseFocus(false);
});

RegisterNuiCallbackType('EnableInput');
on('__cfx_nui:EnableInput', _ => {
    SetNuiFocusKeepInput(true);
})

RegisterNuiCallbackType('DisableInput');
on('__cfx_nui:DisableInput', _ => {
    SetNuiFocusKeepInput(false);
});

//*// Debug
RegisterNuiCallbackType('debug');
on('__cfx_nui:debug', data => {
    console.log('Nui:debug',data.debugTitle);
    delete data.debugTitle;
    console.log(data);
});