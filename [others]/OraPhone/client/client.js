(()=>{"use strict";const e=e=>new Promise((t=>setTimeout(t,e)));let t=null,a=0,n="out",o=null,r=null,i={"cellphone@":{out:{text:"cellphone_text_in",call:"cellphone_call_listen_base"},text:{out:"cellphone_text_out",text:"cellphone_text_in",call:"cellphone_text_to_call"},call:{out:"cellphone_call_out",text:"cellphone_call_to_text",call:"cellphone_text_to_call"}},"anim@cellphone@in_car@ps":{out:{text:"cellphone_text_in",call:"cellphone_call_in"},text:{out:"cellphone_text_out",text:"cellphone_text_in",call:"cellphone_text_to_call"},call:{out:"cellphone_horizontal_exit",text:"cellphone_call_to_text",call:"cellphone_text_to_call"}}};function l(){0!=a&&(DeleteObject(a),a=0)}async function s(s,c,_){if(n==s&&!_)return;t=PlayerPedId(),c=c??!1;let u="cellphone@";IsPedInAnyVehicle(t,!1)&&(u="anim@cellphone@in_car@ps"),await async function(t){for(RequestAnimDict(t);!HasAnimDictLoaded(t);)await e(1)}(u);let p=i[u][n][s];"out"!=n&&StopAnimTask(t,o,r,1);let d=50;c&&(d=14),TaskPlayAnim(t,u,p,3,-1,-1,d,0,!1,!1,!1),"out"!=s&&"out"==n&&(await e(380),await async function(){l();let t=GetHashKey("prop_amb_phone");if(t&&IsModelInCdimage(t)&&!HasModelLoaded(t))for(RequestModel(t);!HasModelLoaded(t);)await e(100);exports.Ora.TriggerServerCallback("Ora::SE::Anticheat:RegisterObject",(function(){let e=PlayerPedId(),[n,o,r]=GetEntityCoords(e);a=CreateObject(t,n,o,r+.2,!0,!0,!0);let i=GetPedBoneIndex(e,28422);AttachEntityToEntity(a,e,i,0,0,0,0,0,0,1,1,0,0,2,1)}),t)}()),o=u,r=p,n=s,"out"==s&&(await e(180),l(),StopAnimTask(t,o,r,1))}async function c(){await s("text",!1,!0)}const _={PhonePlayIn:async function(){await c()},PhonePlayOut:async function(){await s("out")},PhonePlayText:c,PhonePlayCall:async function(e){await s("call",e)}},u=e=>new Promise((t=>setTimeout(t,e)));let p,d,m,h=!1,g=!1,y=!1,b=!1,C=!1,N="",f="",P=!1,v=!0;function T(e=!0){g=e}async function x(e=!0){(P||h)&&v&&(v=!1,h=e,e?(await _.PhonePlayIn(),SetNuiFocus(!0,!0),T(e),SetNuiFocusKeepInput(e),p=setTick((async()=>{DisableAllControlActions(1),EnableControlAction(1,21),EnableControlAction(1,25),EnableControlAction(1,27),EnableControlAction(1,30),EnableControlAction(1,31),EnableControlAction(1,32),EnableControlAction(1,33),EnableControlAction(1,34),EnableControlAction(1,35),EnableControlAction(1,59),EnableControlAction(1,60),EnableControlAction(1,63),EnableControlAction(1,64),EnableControlAction(1,71),EnableControlAction(1,72),EnableControlAction(1,76),EnableControlAction(1,129),EnableControlAction(1,130),EnableControlAction(1,133),EnableControlAction(1,134),EnableControlAction(1,87),EnableControlAction(1,88),EnableControlAction(1,89),EnableControlAction(1,90),EnableControlAction(1,107),EnableControlAction(1,108),EnableControlAction(1,109),EnableControlAction(1,110),EnableControlAction(1,111),EnableControlAction(1,112),EnableControlAction(1,146),EnableControlAction(1,147),EnableControlAction(1,148),EnableControlAction(1,149),EnableControlAction(1,150),EnableControlAction(1,151),EnableControlAction(1,152),EnableControlAction(1,249)}))):(await _.PhonePlayOut(),clearTick(p),EnableAllControlActions(1)),SetNuiFocus(e,e),SendNUIMessage({type:"oraPhoneUI",display:e}),await u(600),v=!0)}async function k(e){e?(exports.Ora_utils.SetPlayerHUD(!1),d=setTick((async()=>{DisableControlAction(1,200),IsControlJustPressed(1,177)&&(DestroyMobilePhone(),CellCamActivate(!1,!1),SendNUIMessage({type:"cancel_picture"}),x(!0),A(),exports.Ora_utils.SetPlayerHUD(!0)),IsControlJustPressed(1,27)&&!b&&(b=!0,y=!y,function(e){b=!1,Citizen.invokeNative("0x2491A93618B7D838",e)}(y)),IsControlJustPressed(1,18)&&!C&&(C=!0,async function(){await u(200),SendNUIMessage({type:"take_picture",app:N,appSub:f}),await u(500),DestroyMobilePhone(),CellCamActivate(!1,!1),x(!0),await u(500),exports.Ora_utils.SetPlayerHUD(!0)}()),C||h||("Appuyez sur ~INPUT_CELLPHONE_UP~ pour changer la caméra",SetTextComponentFormat("STRING"),AddTextComponentString("Appuyez sur ~INPUT_CELLPHONE_UP~ pour changer la caméra"),DisplayHelpTextFromStringLabel(0,0,1,-1)),h||(HideHudComponentThisFrame(1),HideHudComponentThisFrame(2),HideHudComponentThisFrame(3),HideHudComponentThisFrame(4),HideHudComponentThisFrame(5),HideHudComponentThisFrame(6),HideHudComponentThisFrame(7),HideHudComponentThisFrame(8),HideHudComponentThisFrame(9),HideHudComponentThisFrame(13),HideHudComponentThisFrame(17),HideHudComponentThisFrame(20),HideHudAndRadarThisFrame(),ThefeedHideThisFrame())}))):clearTick(d)}async function A(){await u(100),clearTick(d),clearTick(m)}RegisterKeyMapping("phone","Téléphone","keyboard","f2"),RegisterCommand("phone",(e=>x(!h))),DestroyMobilePhone(),onNet("OraPhone:client:phone_active",(e=>{P=e,SendNUIMessage({type:"phoneActive",toggle:e})})),onNet("OraPhone:updateUserData",(e=>{SendNUIMessage({type:"updateUserData",data:e})})),onNet("OraPhone:client:updateContacts",(e=>{SendNUIMessage({type:"updateContacts",contacts:e})})),onNet("OraPhone:client:updateCalls",(e=>{SendNUIMessage({type:"updateCalls",calls:e})})),onNet("OraPhone:client:callStarted",(async e=>{SendNUIMessage({type:"callStarted",targetNumber:e})})),onNet("OraPhone:client:callFinished",(e=>{h&&_.PhonePlayIn(),SendNUIMessage({type:"callEnded"})})),onNet("OraPhone:client:receiveCall",(async(e,t,a,n=!1)=>{SendNUIMessage({type:"receiveCall",fromNumber:e,targetNumber:t,channel:a,video:n}),h||(m=setTick((async()=>{IsControlJustPressed(1,201)&&(SendNUIMessage({type:"takeCall"}),A()),IsControlJustPressed(1,202)&&(SendNUIMessage({type:"cancelCall"}),A())})))})),onNet("OraPhone:client:receiver_offline",(e=>{SendNUIMessage({type:"callEnded"}),_.PhonePlayText()})),onNet("OraPhone:client:update_messages",(async(e,t=!1)=>{t||(t={}),t.id||(t.id=0),t.type||(t.type=""),SendNUIMessage({type:"update_conversations",conversations:e,conversationId:t.id,updatetype:t.type})})),onNet("OraPhone:client:new_notification",(e=>{SendNUIMessage({type:"new_notification",notification:e})})),onNet("OraPhone:client:richtermotorsport_update_advertisement",(e=>{SendNUIMessage({type:"updateRichterMotorsportAdvertisement",richterMotorsportAdvertisement:e})})),onNet("OraPhone:client:gallery_update_photo",(e=>{SendNUIMessage({type:"updateGalleryPhoto",galleryPhoto:e})})),onNet("OraPhone:client:maps_favorite_refresh",(e=>{SendNUIMessage({type:"updateMapsFavorite",positions:e})})),onNet("OraPhone:client:maps_update_my_position",(e=>{SendNUIMessage({type:"updateMapsMyPosition",position:e})})),RegisterNuiCallbackType("phone_close"),on("__cfx_nui:phone_close",(e=>{x(!1)})),RegisterNuiCallbackType("request_user_data"),on("__cfx_nui:request_user_data",(e=>{emitNet("OraPhone:server:request_user_data")})),RegisterNuiCallbackType("patch_user_data"),on("__cfx_nui:patch_user_data",(e=>{emitNet("OraPhone:patch_user_data",e)})),RegisterNuiCallbackType("send_message"),on("__cfx_nui:send_message",(e=>{emitNet("OraPhone:send_message",e)})),RegisterNuiCallbackType("refresh_contacts"),on("__cfx_nui:refresh_contacts",(e=>{emitNet("OraPhone:server:refresh_contacts",e)})),RegisterNuiCallbackType("add_contact"),on("__cfx_nui:add_contact",(e=>{emitNet("OraPhone:add_contact",e)})),RegisterNuiCallbackType("delete_contact"),on("__cfx_nui:delete_contact",(e=>{emitNet("OraPhone:server:delete_contact",e)})),RegisterNuiCallbackType("update_contact"),on("__cfx_nui:update_contact",(e=>{emitNet("OraPhone:server:update_contact",e)})),RegisterNuiCallbackType("call_number"),on("__cfx_nui:call_number",(e=>{e.targetNumber?e.fromNumber?e.targetNumber!=e.fromNumber?(_.PhonePlayCall(),SendNUIMessage({type:"callNumberResponse"}),emitNet("OraPhone:server:call_number",e.fromNumber,e.targetNumber)):console.error("call number: the player is trying to call himself."):console.error("call number: missing source number"):console.error("call number: missing target number")})),RegisterNuiCallbackType("accept_call"),on("__cfx_nui:accept_call",(e=>{e||console.error("accept call: missing channel"),_.PhonePlayCall(),emitNet("OraPhone:server:accept_call",e)})),RegisterNuiCallbackType("end_call"),on("__cfx_nui:end_call",(e=>{console.log("nui end call received"),A(),emitNet("OraPhone:server:end_call")})),RegisterNuiCallbackType("refresh_calls"),on("__cfx_nui:refresh_calls",(e=>{emitNet("OraPhone:server:refresh_calls",e)})),RegisterNuiCallbackType("message_create_conversation"),on("__cfx_nui:message_create_conversation",(e=>{e.authors?emitNet("OraPhone:server:message_create_conversation",e):console.error("missing authors")})),RegisterNuiCallbackType("message_delete_conversation"),on("__cfx_nui:message_delete_conversation",(e=>{e.id||e.number?emitNet("OraPhone:server:message_delete_conversation",e):console.error("missing id")})),RegisterNuiCallbackType("message_update_read_conversation"),on("__cfx_nui:message_update_read_conversation",(e=>{e.id||e.number?emitNet("OraPhone:server:message_update_read_conversation",e):console.error("missing id and number")})),RegisterNuiCallbackType("message_update_name_conversation"),on("__cfx_nui:message_update_name_conversation",(e=>{e.id||e.name?emitNet("OraPhone:server:message_update_name_conversation",e):console.error("missing id and name")})),RegisterNuiCallbackType("refresh_conversations"),on("__cfx_nui:refresh_conversations",(e=>{emitNet("OraPhone:server:refresh_conversations",e)})),RegisterNuiCallbackType("add_message"),on("__cfx_nui:add_message",(e=>{if("GPSMYMARKER"===e.message){let t=GetFirstBlipInfoId(8);if(!DoesBlipExist(t))return;{let a=GetBlipInfoIdCoord(t);e.message=`GPS: ${a[0]}, ${a[1]}, ${a[2]}`}}for(let t of e.targetNumber)if(t.number!=e.number&&/[a-zA-Z]/.test(t.number)){let a=t.number.split("/");const n=GetPlayerPed(-1),[o,r,i]=GetEntityCoords(n),l={x:o,y:r,z:i};for(let t of a)emitNet("call:makeCall2",t,l,e.message)}emitNet("OraPhone:server:add_message",e)})),RegisterNuiCallbackType("add_potition_on_map"),on("__cfx_nui:add_potition_on_map",(e=>{SetNewWaypoint(parseInt(e.x),parseInt(e.y))})),RegisterNuiCallbackType("refresh_richtermotorsport_advertisement"),on("__cfx_nui:refresh_richtermotorsport_advertisement",(e=>{emitNet("OraPhone:server:refresh_richtermotorsport_advertisement",e)})),RegisterNuiCallbackType("richtermotorsport_add_advertisement"),on("__cfx_nui:richtermotorsport_add_advertisement",(e=>{let t=[];exports.Ora.TriggerServerCallback("onlinePlayers:list",(function(a){for(let e of a)t.push(e.id);emitNet("OraPhone:server:richtermotorsport_add_advertisement",e,t)}))})),RegisterNuiCallbackType("richtermotorsport_favorite_advertisement"),on("__cfx_nui:richtermotorsport_favorite_advertisement",(e=>{emitNet("OraPhone:server:richtermotorsport_favorite_advertisement",e)})),RegisterNuiCallbackType("richtermotorsport_find_job"),on("__cfx_nui:richtermotorsport_find_job",(e=>{exports.Ora.TriggerServerCallback("Ora::SVCB::Identity:Job:Get",(function(e){SendNUIMessage({type:"updateRichterMotorsportRole",richterMotorsportRole:[e]})}),GetPlayerServerId(PlayerId()))})),RegisterNuiCallbackType("camera_add_image"),on("__cfx_nui:camera_add_image",(e=>{emitNet("OraPhone:server:camera_add_image",e)})),RegisterNuiCallbackType("open_camera"),on("__cfx_nui:open_camera",(async e=>{N=e.app,f=e.appSub,x(!1),CreateMobilePhone(1),CellCamActivate(!0,!0),k(!0),C=!1})),RegisterNuiCallbackType("close_camera"),on("__cfx_nui:close_camera",(async()=>{k(!1)})),RegisterNuiCallbackType("refresh_gallery"),on("__cfx_nui:refresh_gallery",(e=>{emitNet("OraPhone:server:refresh_gallery",e)})),RegisterNuiCallbackType("gallery_image_remove"),on("__cfx_nui:gallery_image_remove",(e=>{emitNet("OraPhone:server:gallery_image_remove",e)})),RegisterNuiCallbackType("refresh_notes"),on("__cfx_nui:refresh_notes",(e=>{emitNet("OraPhone:server:refresh_notes",e)})),RegisterNuiCallbackType("notes_add_folder"),on("__cfx_nui:notes_add_folder",(e=>{emitNet("OraPhone:server:notes_add_folder",e)})),RegisterNuiCallbackType("maps_favorite_refresh"),on("__cfx_nui:maps_favorite_refresh",(e=>{emitNet("OraPhone:server:maps_favorite_refresh",e)})),RegisterNuiCallbackType("maps_favorite_add_marker"),on("__cfx_nui:maps_favorite_add_marker",(e=>{emitNet("OraPhone:server:maps_favorite_add_marker",e)})),RegisterNuiCallbackType("maps_favorite_remove_marker"),on("__cfx_nui:maps_favorite_remove_marker",(e=>{emitNet("OraPhone:server:maps_favorite_remove_marker",e)})),RegisterNuiCallbackType("maps_update_my_position"),on("__cfx_nui:maps_update_my_position",(e=>{emitNet("OraPhone:server:maps_update_my_position",e)})),RegisterNuiCallbackType("right_click"),on("__cfx_nui:right_click",(e=>{T(!1)})),RegisterNuiCallbackType("EnableInput"),on("__cfx_nui:EnableInput",(e=>{SetNuiFocusKeepInput(!0)})),RegisterNuiCallbackType("DisableInput"),on("__cfx_nui:DisableInput",(e=>{SetNuiFocusKeepInput(!1)})),RegisterNuiCallbackType("debug"),on("__cfx_nui:debug",(e=>{console.log("Nui:debug",e.debugTitle),delete e.debugTitle,console.log(e)}))})();