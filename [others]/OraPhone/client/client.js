(()=>{"use strict";const e=e=>new Promise((t=>setTimeout(t,e)));let t=0,n=null,a="out",o=null,r=null;const i={"cellphone@":{out:{text:"cellphone_text_in",call:"cellphone_call_listen_base"},text:{out:"cellphone_text_out",text:"cellphone_text_in",call:"cellphone_text_to_call"},call:{out:"cellphone_call_out",text:"cellphone_call_to_text",call:"cellphone_text_to_call"}},"anim@cellphone@in_car@ps":{out:{text:"cellphone_text_in",call:"cellphone_call_in"},text:{out:"cellphone_text_out",text:"cellphone_text_in",call:"cellphone_text_to_call"},call:{out:"cellphone_horizontal_exit",text:"cellphone_call_to_text",call:"cellphone_text_to_call"}}};function l(){0!=t&&(DeleteObject(t),t=0)}async function s(s,_,c){if(a==s&&!c)return;n=PlayerPedId(),_=_??!1;let u="cellphone@";IsPedInAnyVehicle(n,!1)&&(u="anim@cellphone@in_car@ps"),await async function(t){for(RequestAnimDict(t);!HasAnimDictLoaded(t);)await e(1)}(u);let d=i[u][a][s];"out"!=a&&StopAnimTask(n,o,r,1);let p=50;_&&(p=14),TaskPlayAnim(n,u,d,3,-1,-1,p,0,!1,!1,!1),"out"!=s&&"out"==a&&(await e(380),await async function(){l();let n=GetHashKey("prop_amb_phone");if(n&&IsModelInCdimage(n)&&!HasModelLoaded(n))for(RequestModel(n);!HasModelLoaded(n);)await e(100);exports.Ora.TriggerServerCallback("Ora::SE::Anticheat:RegisterObject",(function(){let e=PlayerPedId(),[a,o,r]=GetEntityCoords(e);t=CreateObject(n,a,o,r+.2,!0,!0,!0);let i=GetPedBoneIndex(e,28422);AttachEntityToEntity(t,e,i,0,0,0,0,0,0,1,1,0,0,2,1)}),n)}()),o=u,r=d,a=s,"out"==s&&(await e(180),l(),StopAnimTask(n,o,r,1))}async function _(){await s("text",!1,!0)}const c={PhonePlayIn:async function(){await _()},PhonePlayOut:async function(){await s("out")},PhonePlayText:_,PhonePlayCall:async function(e){await s("call",e)}},u=e=>new Promise((t=>setTimeout(t,e)));let d,p,m,h=!1,f=!1,g=!1,y=!1,b=!1,N="",C="",v=!1,P=!0,T=!0;RegisterKeyMapping("phone","Téléphone","keyboard","f2"),RegisterCommand("phone",(e=>O(!h)));let x=exports.Ora.GetMyGroup();function k(e=!0){f=e}async function O(e=!0){v||h?P&&(P=!1,h=e,e?(await c.PhonePlayIn(),SetNuiFocus(!0,!0),k(e),SetNuiFocusKeepInput(e),d=setTick((async()=>{DisableAllControlActions(1),EnableControlAction(1,21),EnableControlAction(1,23),EnableControlAction(1,75),EnableControlAction(1,49),EnableControlAction(1,27),EnableControlAction(1,30),EnableControlAction(1,31),EnableControlAction(1,32),EnableControlAction(1,33),EnableControlAction(1,34),EnableControlAction(1,35),EnableControlAction(1,59),EnableControlAction(1,60),EnableControlAction(1,63),EnableControlAction(1,64),EnableControlAction(1,71),EnableControlAction(1,72),EnableControlAction(1,76),EnableControlAction(1,129),EnableControlAction(1,130),EnableControlAction(1,133),EnableControlAction(1,134),EnableControlAction(1,87),EnableControlAction(1,88),EnableControlAction(1,89),EnableControlAction(1,90),EnableControlAction(1,107),EnableControlAction(1,108),EnableControlAction(1,109),EnableControlAction(1,110),EnableControlAction(1,111),EnableControlAction(1,112),EnableControlAction(1,146),EnableControlAction(1,147),EnableControlAction(1,148),EnableControlAction(1,149),EnableControlAction(1,150),EnableControlAction(1,151),EnableControlAction(1,152),EnableControlAction(1,249)}))):(SetNuiFocusKeepInput(e),await c.PhonePlayOut(),await u(200),clearTick(d),EnableAllControlActions(1)),SetNuiFocus(e,e),SendNUIMessage({type:"oraPhoneUI",display:e}),await u(600),P=!0):SendNUIMessage({type:"phoneDisabled"})}async function I(e){e?(T=exports.Ora_utils.GetPlayerHUD(),exports.Ora_utils.SetPlayerHUD(!1),p=setTick((async()=>{DisableControlAction(1,200),IsControlJustPressed(1,202)&&(A(),SendNUIMessage({type:"cancel_picture"})),IsControlJustPressed(1,27)&&!y&&(y=!0,g=!g,function(e){y=!1,Citizen.invokeNative("0x2491A93618B7D838",e)}(g)),IsControlJustPressed(1,201)&&!b&&(b=!0,async function(){await u(200),SendNUIMessage({type:"take_picture",app:N,appSub:C}),await u(500),A()}()),b||h||("Appuyez sur ~INPUT_CELLPHONE_UP~ pour changer la caméra",SetTextComponentFormat("STRING"),AddTextComponentString("Appuyez sur ~INPUT_CELLPHONE_UP~ pour changer la caméra"),DisplayHelpTextFromStringLabel(0,0,1,-1)),h||(HideHudComponentThisFrame(1),HideHudComponentThisFrame(2),HideHudComponentThisFrame(3),HideHudComponentThisFrame(4),HideHudComponentThisFrame(5),HideHudComponentThisFrame(6),HideHudComponentThisFrame(7),HideHudComponentThisFrame(8),HideHudComponentThisFrame(9),HideHudComponentThisFrame(13),HideHudComponentThisFrame(17),HideHudComponentThisFrame(20),HideHudAndRadarThisFrame(),ThefeedHideThisFrame())}))):clearTick(p)}async function A(){DestroyMobilePhone(),CellCamActivate(!1,!1),O(!0),await u(500),T&&exports.Ora_utils.SetPlayerHUD(!0),R()}async function R(){await u(100),clearTick(p),clearTick(m)}function E(){exports.Ora.TriggerServerCallback("getBankingAccountsPly",(async function(e){let t=[e.own,e.coOwn],n=[];for(let e of t)for(let t of e)n.push(t);for(let e of n)await exports.Ora.TriggerServerCallback("getHisto",(function(t){e.history=t}),e.label,e.iban);if(n.length>0)for(;null==n[n.length-1].history;)await u(100);SendNUIMessage({type:"bankGetAccounts",accounts:n})}))}x&&"superadmin"==x&&RegisterCommand("oraphonerefreshplayer",(e=>function(){if(x=exports.Ora.GetMyGroup(),x&&"superadmin"==x){let e=[];exports.Ora.TriggerServerCallback("onlinePlayers:list",(function(t){for(let n of t)e.push(n);emitNet("OraPhone:server:refresh_players_loaded",e)}))}}())),DestroyMobilePhone(),onNet("OraPhone:client:phone_active",(e=>{v=e,SendNUIMessage({type:"phoneActive",toggle:e})})),onNet("OraPhone:updateUserData",(e=>{SendNUIMessage({type:"updateUserData",data:e})})),onNet("OraPhone:client:updateContacts",(e=>{SendNUIMessage({type:"updateContacts",contacts:e})})),onNet("OraPhone:client:updateCalls",(e=>{SendNUIMessage({type:"updateCalls",calls:e})})),onNet("OraPhone:client:callStarted",(async e=>{SendNUIMessage({type:"callStarted",targetNumber:e})})),onNet("OraPhone:client:callFinished",(e=>{h&&c.PhonePlayIn(),SendNUIMessage({type:"callEnded"})})),onNet("OraPhone:client:receiveCall",(async(e,t,n,a=!1)=>{SendNUIMessage({type:"receiveCall",fromNumber:e,targetNumber:t,channel:n,video:a}),h||(m=setTick((async()=>{IsControlJustPressed(1,201)&&(SendNUIMessage({type:"takeCall"}),R()),IsControlJustPressed(1,202)&&(SendNUIMessage({type:"cancelCall"}),R())})))})),onNet("OraPhone:client:receiver_offline",(e=>{SendNUIMessage({type:"callEnded"}),c.PhonePlayText()})),onNet("OraPhone:client:update_messages",(async(e,t=!1)=>{t||(t={}),t.id||(null!=e.conversationId?t.id=e.conversationId:t.id=0),t.type||(t.type=""),SendNUIMessage({type:"update_conversations",conversations:e.conversations,conversationId:t.id,updatetype:t.type,oneConversation:null!=e.conversationId})})),onNet("OraPhone:client:new_notification",(e=>{SendNUIMessage({type:"new_notification",notification:e})})),onNet("OraPhone:client:richtermotorsport_update_advertisement",(e=>{SendNUIMessage({type:"updateRichterMotorsportAdvertisement",richterMotorsportAdvertisement:e})})),onNet("OraPhone:client:gallery_update_photo",(e=>{SendNUIMessage({type:"updateGalleryPhoto",galleryPhoto:e})})),onNet("OraPhone:client:maps_favorite_refresh",(e=>{SendNUIMessage({type:"updateMapsFavorite",positions:e})})),onNet("OraPhone:client:maps_update_my_position",(e=>{SendNUIMessage({type:"updateMapsMyPosition",position:e})})),onNet("OraPhone:client:bank_send",(()=>{E()})),onNet("OraPhone:client:refresh_lifeinvader_user",((e,t=null)=>{SendNUIMessage({type:"updateLifeinvaderUser",users:e,status:t})})),onNet("OraPhone:client:lifeinvader_update_app_content",((e,t)=>{SendNUIMessage({type:"lifeinvaderUpdateAppContent",posts:e,content:t})})),RegisterNuiCallbackType("phone_close"),on("__cfx_nui:phone_close",(e=>{O(!1)})),RegisterNuiCallbackType("request_user_data"),on("__cfx_nui:request_user_data",(e=>{emitNet("OraPhone:server:request_user_data")})),RegisterNuiCallbackType("patch_user_data"),on("__cfx_nui:patch_user_data",(e=>{emitNet("OraPhone:patch_user_data",e)})),RegisterNuiCallbackType("refresh_contacts"),on("__cfx_nui:refresh_contacts",(e=>{emitNet("OraPhone:server:refresh_contacts",e)})),RegisterNuiCallbackType("add_contact"),on("__cfx_nui:add_contact",(e=>{emitNet("OraPhone:add_contact",e)})),RegisterNuiCallbackType("delete_contact"),on("__cfx_nui:delete_contact",(e=>{emitNet("OraPhone:server:delete_contact",e)})),RegisterNuiCallbackType("update_contact"),on("__cfx_nui:update_contact",(e=>{emitNet("OraPhone:server:update_contact",e)})),RegisterNuiCallbackType("call_number"),on("__cfx_nui:call_number",(e=>{e.targetNumber?e.fromNumber?e.targetNumber!=e.fromNumber?(c.PhonePlayCall(),SendNUIMessage({type:"callNumberResponse"}),emitNet("OraPhone:server:call_number",e.fromNumber,e.targetNumber)):console.error("call number: the player is trying to call himself."):console.error("call number: missing source number"):console.error("call number: missing target number")})),RegisterNuiCallbackType("accept_call"),on("__cfx_nui:accept_call",(e=>{e||console.error("accept call: missing channel"),c.PhonePlayCall(),emitNet("OraPhone:server:accept_call",e)})),RegisterNuiCallbackType("end_call"),on("__cfx_nui:end_call",(e=>{console.log("nui end call received"),R(),emitNet("OraPhone:server:end_call")})),RegisterNuiCallbackType("refresh_calls"),on("__cfx_nui:refresh_calls",(e=>{emitNet("OraPhone:server:refresh_calls",e)})),RegisterNuiCallbackType("message_create_conversation"),on("__cfx_nui:message_create_conversation",(e=>{e.authors?emitNet("OraPhone:server:message_create_conversation",e):console.error("missing authors")})),RegisterNuiCallbackType("message_delete_conversation"),on("__cfx_nui:message_delete_conversation",(e=>{e.id||e.number?emitNet("OraPhone:server:message_delete_conversation",e):console.error("missing id")})),RegisterNuiCallbackType("message_update_read_conversation"),on("__cfx_nui:message_update_read_conversation",(e=>{e.id||e.number?emitNet("OraPhone:server:message_update_read_conversation",e):console.error("missing id and number")})),RegisterNuiCallbackType("message_update_name_conversation"),on("__cfx_nui:message_update_name_conversation",(e=>{e.id||e.name?emitNet("OraPhone:server:message_update_name_conversation",e):console.error("missing id and name")})),RegisterNuiCallbackType("refresh_conversations"),on("__cfx_nui:refresh_conversations",(e=>{emitNet("OraPhone:server:refresh_conversations",e)})),RegisterNuiCallbackType("add_message"),on("__cfx_nui:add_message",(e=>{if("GPSMYMARKER"===e.message){let t=GetFirstBlipInfoId(8);if(!DoesBlipExist(t))return;{let n=GetBlipInfoIdCoord(t);e.message=`GPS: ${n[0]}, ${n[1]}, ${n[2]}`}}for(let t of e.targetNumber)if(t.number!=e.number&&/[a-zA-Z]/.test(t.number)){let n=t.number.split("/");const a=GetPlayerPed(-1),[o,r,i]=GetEntityCoords(a),l={x:o,y:r,z:i};for(let t of n)emitNet("call:makeCall",t,l,e.message)}emitNet("OraPhone:server:add_message",e)})),RegisterNuiCallbackType("add_potition_on_map"),on("__cfx_nui:add_potition_on_map",(e=>{SetNewWaypoint(parseInt(e.x),parseInt(e.y))})),RegisterNuiCallbackType("message_add_author_conversation"),on("__cfx_nui:message_add_author_conversation",(e=>{e.id||e.author?emitNet("OraPhone:server:message_add_author_conversation",e):console.error("missing id and name")})),RegisterNuiCallbackType("refresh_richtermotorsport_advertisement"),on("__cfx_nui:refresh_richtermotorsport_advertisement",(e=>{emitNet("OraPhone:server:refresh_richtermotorsport_advertisement",e)})),RegisterNuiCallbackType("richtermotorsport_add_advertisement"),on("__cfx_nui:richtermotorsport_add_advertisement",(e=>{let t=[];exports.Ora.TriggerServerCallback("onlinePlayers:list",(function(n){for(let e of n)t.push(e.id);emitNet("OraPhone:server:richtermotorsport_add_advertisement",e,t)}))})),RegisterNuiCallbackType("richtermotorsport_favorite_advertisement"),on("__cfx_nui:richtermotorsport_favorite_advertisement",(e=>{emitNet("OraPhone:server:richtermotorsport_favorite_advertisement",e)})),RegisterNuiCallbackType("richtermotorsport_find_job"),on("__cfx_nui:richtermotorsport_find_job",(e=>{exports.Ora.TriggerServerCallback("Ora::SVCB::Identity:Job:Get",(function(e){SendNUIMessage({type:"updateRichterMotorsportRole",richterMotorsportRole:[e]})}),GetPlayerServerId(PlayerId()))})),RegisterNuiCallbackType("camera_add_image"),on("__cfx_nui:camera_add_image",(e=>{emitNet("OraPhone:server:camera_add_image",e)})),RegisterNuiCallbackType("open_camera"),on("__cfx_nui:open_camera",(async e=>{N=e.app,C=e.appSub,O(!1),CreateMobilePhone(1),CellCamActivate(!0,!0),I(!0),b=!1})),RegisterNuiCallbackType("close_camera"),on("__cfx_nui:close_camera",(async()=>{I(!1),R()})),RegisterNuiCallbackType("refresh_gallery"),on("__cfx_nui:refresh_gallery",(e=>{emitNet("OraPhone:server:refresh_gallery",e)})),RegisterNuiCallbackType("gallery_image_remove"),on("__cfx_nui:gallery_image_remove",(e=>{emitNet("OraPhone:server:gallery_image_remove",e)})),RegisterNuiCallbackType("refresh_notes"),on("__cfx_nui:refresh_notes",(e=>{emitNet("OraPhone:server:refresh_notes",e)})),RegisterNuiCallbackType("notes_add_folder"),on("__cfx_nui:notes_add_folder",(e=>{emitNet("OraPhone:server:notes_add_folder",e)})),RegisterNuiCallbackType("maps_favorite_refresh"),on("__cfx_nui:maps_favorite_refresh",(e=>{emitNet("OraPhone:server:maps_favorite_refresh",e)})),RegisterNuiCallbackType("maps_favorite_add_marker"),on("__cfx_nui:maps_favorite_add_marker",(e=>{emitNet("OraPhone:server:maps_favorite_add_marker",e)})),RegisterNuiCallbackType("maps_favorite_remove_marker"),on("__cfx_nui:maps_favorite_remove_marker",(e=>{emitNet("OraPhone:server:maps_favorite_remove_marker",e)})),RegisterNuiCallbackType("maps_update_my_position"),on("__cfx_nui:maps_update_my_position",(e=>{emitNet("OraPhone:server:maps_update_my_position",e)})),RegisterNuiCallbackType("bank_get_accounts"),on("__cfx_nui:bank_get_accounts",(async e=>{E()})),RegisterNuiCallbackType("bank_send"),on("__cfx_nui:bank_send",(e=>{TriggerEvent("Ora:SendFromPhone",e.amount,e.rib1,e.rib2,e.sourceId)})),RegisterNuiCallbackType("refresh_lifeinvader_user"),on("__cfx_nui:refresh_lifeinvader_user",(e=>{emitNet("OraPhone:server:refresh_lifeinvader_user",e)})),RegisterNuiCallbackType("lifeinvader_add_user"),on("__cfx_nui:lifeinvader_add_user",(e=>{emitNet("OraPhone:server:lifeinvader_add_user",e)})),RegisterNuiCallbackType("lifeinvader_fetch_app_content"),on("__cfx_nui:lifeinvader_fetch_app_content",(e=>{emitNet("OraPhone:server:lifeinvader_fetch_app_content",e)})),RegisterNuiCallbackType("lifeinvader_like_post"),on("__cfx_nui:lifeinvader_like_post",(e=>{emitNet("OraPhone:server:lifeinvader_like_post",e)})),RegisterNuiCallbackType("lifeinvader_add_post_response"),on("__cfx_nui:lifeinvader_add_post_response",(e=>{emitNet("OraPhone:server:lifeinvader_add_post_response",e)})),RegisterNuiCallbackType("lifeinvader_add_post"),on("__cfx_nui:lifeinvader_add_post",(e=>{emitNet("Ora:sendToDiscord","OraPhoneLifeInvader","[UserId: "+e.userId+"/Pseudo: "+e.userPseudo+"/Username: "+e.userUsername+"] : "+e.response),emitNet("OraPhone:server:lifeinvader_add_post",e)})),RegisterNuiCallbackType("lifeinvader_update_user"),on("__cfx_nui:lifeinvader_update_user",(e=>{emitNet("OraPhone:server:lifeinvader_update_user",e)})),RegisterNuiCallbackType("lifeinvader_delete_post"),on("__cfx_nui:lifeinvader_delete_post",(e=>{emitNet("OraPhone:server:lifeinvader_delete_post",e)})),RegisterNuiCallbackType("lifeinvader_delete_user"),on("__cfx_nui:lifeinvader_delete_user",(e=>{emitNet("OraPhone:server:lifeinvader_delete_user",e)})),RegisterNuiCallbackType("right_click"),on("__cfx_nui:right_click",(e=>{k(!1)})),RegisterNuiCallbackType("EnableInput"),on("__cfx_nui:EnableInput",(e=>{SetNuiFocusKeepInput(!0)})),RegisterNuiCallbackType("DisableInput"),on("__cfx_nui:DisableInput",(e=>{SetNuiFocusKeepInput(!1)})),RegisterNuiCallbackType("debug"),on("__cfx_nui:debug",(e=>{console.log("Nui:debug",e.debugTitle),delete e.debugTitle,console.log(e)}))})();