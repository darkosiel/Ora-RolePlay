/*
 * ATTENTION: The "eval" devtool has been used (maybe by default in mode: "development").
 * This devtool is neither made for production nor for readable output files.
 * It uses "eval()" calls to create a separate source file in the browser devtools.
 * If you are trying to read the output file, select a different devtool (https://webpack.js.org/configuration/devtool/)
 * or disable the default devtool with "devtool: false".
 * If you are looking for production-ready output files, see mode: "production" (https://webpack.js.org/configuration/mode/).
 */
/******/ (() => { // webpackBootstrap
/******/ 	"use strict";
/******/ 	var __webpack_modules__ = ({

/***/ "./anim.js":
/*!*****************!*\
  !*** ./anim.js ***!
  \*****************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   \"default\": () => (__WEBPACK_DEFAULT_EXPORT__)\n/* harmony export */ });\n\n// To introduce async delay\nconst Delay = (ms) => new Promise(res => setTimeout(res, ms));\n\n\nlet myPedId = null\n\n\n//\"prop_amb_phone\"\n// OR \"prop_npc_phone\"\n// OR \"prop_cs_phone_01\"\n// OR \"prop_npc_phone_02\"\nconst phoneModel = \"prop_npc_phone_02\"\nlet phoneProp = 0\n\nlet currentStatus = \"out\"\nlet lastDict = null\nlet lastAnim = null\n\nlet ANIMS = {\n    \"cellphone@\": {\n        \"out\": {\n            \"text\": \"cellphone_text_in\",\n            \"call\": \"cellphone_call_listen_base\"\n        },\n        \"text\": {\n            \"out\": \"cellphone_text_out\",\n            \"text\": \"cellphone_text_in\",\n            \"call\": \"cellphone_text_to_call\"\n        },\n        \"call\": {\n            \"out\": \"cellphone_call_out\",\n            \"text\": \"cellphone_call_to_text\",\n            \"call\": \"cellphone_text_to_call\"\n        }\n    },\n    \"anim@cellphone@in_car@ps\": {\n        \"out\": {\n            \"text\": \"cellphone_text_in\",\n            \"call\": \"cellphone_call_in\"\n        },\n        \"text\": {\n            \"out\": \"cellphone_text_out\",\n            \"text\": \"cellphone_text_in\",\n            \"call\": \"cellphone_text_to_call\"\n        },\n        \"call\": {\n            \"out\": \"cellphone_horizontal_exit\",\n            \"text\": \"cellphone_call_to_text\",\n            \"call\": \"cellphone_text_to_call\"\n        }\n    }\n}\n\nasync function newPhoneProp() {\n    deletePhone()\n    let modelHash = GetHashKey(phoneModel)\n    if(modelHash && IsModelInCdimage(modelHash) && !HasModelLoaded(modelHash)) {\n        RequestModel(modelHash)\n        while(!HasModelLoaded(modelHash)) { await Delay(100) }\n    }\n    exports[\"Ora\"].TriggerServerCallback(\"Ora::SE::Anticheat:RegisterObject\", \n        function() {\n            let ped = PlayerPedId()\n            let [x,y,z] = GetEntityCoords(ped)\n            phoneProp = CreateObject(modelHash, x, y, z + 0.2, true, true, true)\n            let bone = GetPedBoneIndex(ped, 28422)\n            AttachEntityToEntity(phoneProp, ped, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)\n        },\n        modelHash\n    )\n}\n\nfunction deletePhone() {\n    if(phoneProp != 0) {\n        DeleteObject(phoneProp)\n        phoneProp = 0\n    }\n}\n\n/*////\n\tout || text || Call ||\n//*///\nasync function PhonePlayAnim(state, freeze, force) {\n    if(currentStatus == state && force != true) {\n        return\n    }\n\n    myPedId = PlayerPedId()\n    freeze = freeze ?? false\n\n    let dict = \"cellphone@\"\n    if(IsPedInAnyVehicle(myPedId, false)) {\n        dict = \"anim@cellphone@in_car@ps\"\n    }\n    await loadAnimDict(dict)\n\n    let anim = ANIMS[dict][currentStatus][state]\n    if(currentStatus != \"out\") {\n        StopAnimTask(myPedId, lastDict, lastAnim, 1.0)\n    }\n    let flag = 50\n    if(freeze == true ) {\n        flag = 14\n    }\n    TaskPlayAnim(myPedId, dict, anim, 3.0, -1, -1, flag, 0, false, false, false)\n\n    if(state != \"out\" && currentStatus == \"out\" ) {\n        await Delay(380)\n        await newPhoneProp()\n    }\n\n    lastDict = dict\n    lastAnim = anim\n    currentStatus = state\n\n    if(state == \"out\" ) {\n        await Delay(180)\n        deletePhone()\n        StopAnimTask(myPedId, lastDict, lastAnim, 1.0)\n    }\n}\n\nasync function PhonePlayOut() {\n    await PhonePlayAnim(\"out\")\n}\n\nasync function PhonePlayText() {\n    await PhonePlayAnim(\"text\", false, true)\n}\n\nasync function PhonePlayCall(freeze) {\n    await PhonePlayAnim(\"call\", freeze)\n}\n\nasync function PhonePlayIn() {\n    await PhonePlayText()\n}\n\nasync function loadAnimDict(dict) {\n    RequestAnimDict(dict)\n    while(!HasAnimDictLoaded(dict)) {\n        await Delay(1)\n    }\n}\n\n/* harmony default export */ const __WEBPACK_DEFAULT_EXPORT__ = ({ PhonePlayIn, PhonePlayOut, PhonePlayText, PhonePlayCall });\n\n// Citizen.CreateThread(function ()\n// \tawait Delay(200)\n// \tPhonePlayCall()\n// \tawait Delay(2000)\n// \tPhonePlayOut()\n// \tawait Delay(2000)\n\n// \tPhonePlayText()\n// \tawait Delay(2000)\n// \tPhonePlayCall()\n// \tawait Delay(2000)\n// \tPhonePlayOut()\n// })\n\n//# sourceURL=webpack://phone_ora/./anim.js?");

/***/ }),

/***/ "./client.js":
/*!*******************!*\
  !*** ./client.js ***!
  \*******************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _anim_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./anim.js */ \"./anim.js\");\n/// <reference path=\"node_modules/fivem-js/lib/index.d.ts\"/>\n/// <reference path=\"node_modules/@citizenfx/client/natives_universal.d.ts\"/>\n/**\n * Imports\n */\n\n\nconst Wait = ms => new Promise(r=>setTimeout(r, ms))\n/**\n  * Client\n  */\nlet phoneVisible = false\nlet mouseFocus = false\nvar frontCam = false\nvar firstTime = false\nvar takePictureBool = false\nvar app = \"\";\nvar appSub = \"\";\nvar onTick\nvar onTickCamera\nvar phoneActive = false\nvar canSetPhoneVisible = true\n\nRegisterKeyMapping('phone', 'Téléphone', 'keyboard', 'f2')\nRegisterCommand('phone', _=>setPhoneVisible(!phoneVisible))\n\nfunction setMouseFocus(active = true) {\n    mouseFocus = active\n}\n\n// onTick timer ref\nasync function setPhoneVisible(visible = true) {\n    if((!phoneActive && !phoneVisible) || !canSetPhoneVisible) {\n        return\n    }\n    canSetPhoneVisible = false\n    phoneVisible = visible\n    // When we wanna show the phone\n    if (visible) {\n        // play some fivem anim\n        await _anim_js__WEBPACK_IMPORTED_MODULE_0__[\"default\"].PhonePlayIn()\n        // Give focus to Nui\n        SetNuiFocus(true, true)\n        setMouseFocus(visible)\n        SetNuiFocusKeepInput(visible)\n        // lock controls, focus nui\n        onTick = setTick( async () => {\n            // On right click in fivem focus back to the phone\n            // if (IsControlJustReleased(1, 25) && phoneVisible) {\n            //     setMouseFocus(true)\n            // }\n            // Enforce nui focus on or off\n            // SetNuiFocus(mouseFocus, mouseFocus)\n            // https://docs.fivem.net/docs/game-references/controls/\n            DisableAllControlActions(1)\n            // sprint\n            EnableControlAction(1, 21)\n            // right click to switch focus back on ui\n            EnableControlAction(1, 25)\n            EnableControlAction(1, 27)\n            // move\n            EnableControlAction(1, 30);EnableControlAction(1, 31);EnableControlAction(1, 32);EnableControlAction(1, 33);EnableControlAction(1, 34);EnableControlAction(1, 35)\n            // push to talk\n            EnableControlAction(1, 249);\n        })\n    // When we wanna hide the phone\n    } else {\n        // Play some fivem anim\n        await _anim_js__WEBPACK_IMPORTED_MODULE_0__[\"default\"].PhonePlayOut()\n        // stop blocking controls on tick\n        clearTick(onTick)\n        ClearAllPedProps(GetPlayerPed(GetPlayerFromServerId(source)));\n        // bring them back\n        EnableAllControlActions(1)\n    }\n    // Give & remove focus\n    SetNuiFocus(visible, visible)\n     // Show & hide UI\n    SendNUIMessage({\n        type: \"ui\",\n        display: visible\n    })\n    await Wait(600)\n    canSetPhoneVisible = true\n}\n\nfunction CellFrontCamActivate(activate) {\n    firstTime = false\n\treturn Citizen.invokeNative('0x2491A93618B7D838', activate)\n}\n\nDestroyMobilePhone()\nasync function setCamera(activate) {\n    if(activate) {\n        exports.Ora_utils.SetPlayerHUD(false)\n        onTickCamera = setTick(async () => {\n            DisableControlAction(1, 200)\n            if (IsControlJustPressed(1, 177)) { // -- CLOSE PHONE\n                DestroyMobilePhone()\n                CellCamActivate(false, false)\n                SendNUIMessage({\n                    type: \"cancel_picture\"\n                })\n                setPhoneVisible(true)\n                stopTick();\n                exports.Ora_utils.SetPlayerHUD(true)\n            }\n            if (IsControlJustPressed(1, 27) && firstTime == false) { // -- SELFIE MODE\n                firstTime = true\n                frontCam = !frontCam\n                CellFrontCamActivate(frontCam)\n            }\n            if (IsControlJustPressed(1, 18) && takePictureBool == false) { // -- TAKE PICTURE\n                takePictureBool = true\n                takePicture()\n            }\n            if (takePictureBool == false && phoneVisible == false) {\n                let text = \"Appuyez sur ~INPUT_CELLPHONE_UP~ pour changer la caméra\"\n                DisplayHelpText(text)\n            }\n            if (phoneVisible == false) {\n                HideHudComponentThisFrame(1)\n                HideHudComponentThisFrame(2)\n                HideHudComponentThisFrame(3)\n                HideHudComponentThisFrame(4)\n                HideHudComponentThisFrame(5)\n                HideHudComponentThisFrame(6)\n                HideHudComponentThisFrame(7)\n                HideHudComponentThisFrame(8)\n                HideHudComponentThisFrame(9)\n                HideHudComponentThisFrame(13)\n                HideHudComponentThisFrame(17)\n                HideHudComponentThisFrame(20)\n                HideHudAndRadarThisFrame()\n                ThefeedHideThisFrame()\n            }\n        })\n    } else {\n        clearTick(onTickCamera)\n    }\n}\n\nasync function takePicture() {\n    await Wait(100)\n    SendNUIMessage({\n        type: \"take_picture\",\n        app: app,\n        appSub: appSub\n    })\n    await Wait(500)\n    DestroyMobilePhone()\n    CellCamActivate(false, false)\n    setPhoneVisible(true)\n    await Wait(500)\n    exports.Ora_utils.SetPlayerHUD(true)\n}\n\nasync function stopTick() {\n    await Wait(100)\n    clearTick(onTickCamera)\n}\n\nfunction DisplayHelpText(str) {\n\tSetTextComponentFormat(\"STRING\")\n\tAddTextComponentString(str)\n\tDisplayHelpTextFromStringLabel(0, 0, 1, -1)\n}\n\n/**\n * ========================\n * onNet events from server\n * ========================\n */\n\n// Is the phone active ?\n\nonNet('OraPhone:client:phone_active', (active) => {\n    phoneActive = active\n    SendNUIMessage({\n        type: \"phoneActive\",\n        toggle: active\n    })\n})\n\n// User data\n\nonNet('OraPhone:updateUserData', data => {\n    SendNUIMessage({\n        type: 'updateUserData',\n        data: data,\n    })\n})\n\n// Contacts\n\nonNet('OraPhone:client:updateContacts', data => {\n    SendNUIMessage({\n        type: 'updateContacts',\n        contacts: data\n    })\n})\n\n// Phone\n\nonNet('OraPhone:client:updateCalls', data => {\n    SendNUIMessage({\n        type: 'updateCalls',\n        calls: data\n    })\n})\n\n// Call\n\nonNet('OraPhone:client:callStarted', _ => {\n    SendNUIMessage({\n        type: 'callStarted',\n    })\n})\n\nonNet('OraPhone:client:callFinished', _ => {\n    _anim_js__WEBPACK_IMPORTED_MODULE_0__[\"default\"].PhonePlayIn()\n    SendNUIMessage({\n        type: 'callEnded',\n    })\n})\n\nonNet('OraPhone:client:receiveCall', async (fromNumber, chan, video=false) => {\n    SendNUIMessage({\n        type: 'receiveCall',\n        fromNumber,\n        channel: chan,\n        video,\n    })\n})\n\nonNet('OraPhone:client:receiver_offline', _ => {\n    SendNUIMessage({\n        type: 'callEnded',\n    })\n    _anim_js__WEBPACK_IMPORTED_MODULE_0__[\"default\"].PhonePlayText()\n})\n\n// Messages\n\nonNet('OraPhone:client:update_messages', data => {\n    SendNUIMessage({\n        type: 'update_conversations',\n        conversations: data\n    })\n})\n\nonNet('OraPhone:client:new_notification', data => {\n    SendNUIMessage({\n        type: 'new_notification',\n        notification: data\n    })\n})\n\n// Richter Motorsport\n\nonNet('OraPhone:client:richtermotorsport_update_advertisement', data => {\n    SendNUIMessage({\n        type: 'updateRichterMotorsportAdvertisement',\n        richterMotorsportAdvertisement: data\n    })\n})\n\n// Gallery\n\nonNet('OraPhone:client:gallery_update_photo', data => {\n    SendNUIMessage({\n        type: 'updateGalleryPhoto',\n        galleryPhoto: data\n    })\n})\n\n// Notes\n\nonNet('OraPhone:client:notes_refresh', data => {\n    SendNUIMessage({\n        type: 'updateNotes',\n        notes: data\n    })\n})\n\n/**\n * =============\n * Nui callbacks\n * =============\n */\n\n// General Phone\n\nRegisterNuiCallbackType('phone_close')\non('__cfx_nui:phone_close', _ => {\n    setPhoneVisible(false)\n})\n\n// User Data\n\nRegisterNuiCallbackType('request_user_data')\non('__cfx_nui:request_user_data', _ => {\n    emitNet('OraPhone:server:request_user_data')\n})\n\nRegisterNuiCallbackType('patch_user_data')\non('__cfx_nui:patch_user_data', params => {\n    emitNet('OraPhone:patch_user_data', params)\n})\n\nRegisterNuiCallbackType('send_message')\non('__cfx_nui:send_message', msgData => {\n    emitNet('OraPhone:send_message', msgData)\n})\n\n// Contacts\n\nRegisterNuiCallbackType('refresh_contacts')\non('__cfx_nui:refresh_contacts', data => {\n    emitNet('OraPhone:server:refresh_contacts', data)\n})\n\nRegisterNuiCallbackType('add_contact')\non('__cfx_nui:add_contact', c => {\n    emitNet('OraPhone:add_contact', c)\n})\n\nRegisterNuiCallbackType('delete_contact')\non('__cfx_nui:delete_contact', c => {\n    emitNet('OraPhone:server:delete_contact', c)\n})\n\nRegisterNuiCallbackType('update_contact')\non('__cfx_nui:update_contact', c => {\n    emitNet('OraPhone:server:update_contact', c)\n})\n\n// Call\n\nRegisterNuiCallbackType('call_number')\non('__cfx_nui:call_number', data => {\n    if (!data.targetNumber) { \n        console.error('call number: missing target number')\n        return\n    }\n    if (!data.fromNumber) {\n        console.error('call number: missing source number')\n        return\n    }\n    if (data.targetNumber == data.fromNumber) {\n        console.error('call number: the player is trying to call himself.')\n        return\n    }\n    _anim_js__WEBPACK_IMPORTED_MODULE_0__[\"default\"].PhonePlayCall()\n    SendNUIMessage({\n        type: 'call_number_response'\n    })\n    emitNet('OraPhone:server:call_number', data.fromNumber, data.targetNumber)\n})\n\nRegisterNuiCallbackType('accept_call')\non('__cfx_nui:accept_call', channel => {\n    if (!channel) { console.error('accept call: missing channel') }\n    _anim_js__WEBPACK_IMPORTED_MODULE_0__[\"default\"].PhonePlayCall()\n    emitNet('OraPhone:server:accept_call', channel)\n})\n\nRegisterNuiCallbackType('end_call')\non('__cfx_nui:end_call', _ => {\n    console.log('nui end call received')\n    emitNet('OraPhone:server:end_call')\n})\n\n// Phone\n\nRegisterNuiCallbackType('refresh_calls')\non('__cfx_nui:refresh_calls', data => {\n    emitNet('OraPhone:server:refresh_calls', data)\n})\n\n// Messsages\n\nRegisterNuiCallbackType('message_create_conversation')\non('__cfx_nui:message_create_conversation', data => {\n    if (!data.authors) { \n        console.error('missing authors')\n        return\n    }\n    emitNet('OraPhone:server:message_create_conversation', data)\n})\n\nRegisterNuiCallbackType('refresh_conversations')\non('__cfx_nui:refresh_conversations', data => {\n    emitNet('OraPhone:server:refresh_conversations', data)\n})\n\nRegisterNuiCallbackType('add_message')\non('__cfx_nui:add_message', data => {\n    emitNet('OraPhone:server:add_message', data)\n})\n\n// Richter Motorsport\n\nRegisterNuiCallbackType('refresh_richtermotorsport_advertisement')\non('__cfx_nui:refresh_richtermotorsport_advertisement', data => {\n    emitNet('OraPhone:server:refresh_richtermotorsport_advertisement', data)\n})\n\nRegisterNuiCallbackType('richtermotorsport_add_advertisement')\non('__cfx_nui:richtermotorsport_add_advertisement', data => {\n    let players = []\n    exports.Ora.TriggerServerCallback(\n        \"onlinePlayers:list\",\n        function(users) {\n            for (let user of users) {\n                players.push(user.id)\n            }\n            emitNet('OraPhone:server:richtermotorsport_add_advertisement', data, players)\n        }\n    )\n})\n\nRegisterNuiCallbackType('richtermotorsport_favorite_advertisement')\non('__cfx_nui:richtermotorsport_favorite_advertisement', data => {\n    emitNet('OraPhone:server:richtermotorsport_favorite_advertisement', data)\n})\n\nRegisterNuiCallbackType('richtermotorsport_find_job')\non('__cfx_nui:richtermotorsport_find_job', data => {\n    exports.Ora.TriggerServerCallback(\n        \"Ora::SVCB::Identity:Job:Get\",\n        function(job) {\n            SendNUIMessage({\n                type: 'updateRichterMotorsportRole',\n                richterMotorsportRole: [job]\n            })\n        },\n        GetPlayerServerId(PlayerId())\n    )\n})\n\n// Camera\n\nRegisterNuiCallbackType('camera_add_image')\non('__cfx_nui:camera_add_image', data => {\n    emitNet('OraPhone:server:camera_add_image', data)\n})\n\nRegisterNuiCallbackType('open_camera')\non('__cfx_nui:open_camera', async (data) => {\n    app = data.app\n    appSub = data.appSub\n    setPhoneVisible(false)\n    CreateMobilePhone(1)\n    CellCamActivate(true, true)\n    setCamera(true)\n    takePictureBool = false\n})\n\nRegisterNuiCallbackType('close_camera')\non('__cfx_nui:close_camera', async () => {\n    setCamera(false)\n})\n\n// Gallery\n\nRegisterNuiCallbackType('refresh_gallery')\non('__cfx_nui:refresh_gallery', data => {\n    emitNet('OraPhone:server:refresh_gallery', data)\n})\n\n// Notes\n\nRegisterNuiCallbackType('refresh_notes')\non('__cfx_nui:refresh_notes', data => {\n    emitNet('OraPhone:server:refresh_notes', data)\n})\n\nRegisterNuiCallbackType('notes_add_folder')\non('__cfx_nui:notes_add_folder', data => {\n    emitNet('OraPhone:server:notes_add_folder', data)\n})\n\n// --- Tools\n\nRegisterNuiCallbackType('right_click')\non('__cfx_nui:right_click', _ => {\n     // right click on UI = give back focus and some controls to fivem client without hiding the phone\n    setMouseFocus(false)\n})\n\nRegisterNuiCallbackType('EnableInput')\non('__cfx_nui:EnableInput', _ => {\n    SetNuiFocusKeepInput(true)\n})\n\nRegisterNuiCallbackType('DisableInput')\non('__cfx_nui:DisableInput', _ => {\n    SetNuiFocusKeepInput(false)\n})\n\n//*// Debug\nRegisterNuiCallbackType('debug')\non('__cfx_nui:debug', data => {\n    console.log('Nui:debug',data.debugTitle)\n    delete data.debugTitle\n    console.log(data)\n})\n\n//# sourceURL=webpack://phone_ora/./client.js?");

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/define property getters */
/******/ 	(() => {
/******/ 		// define getter functions for harmony exports
/******/ 		__webpack_require__.d = (exports, definition) => {
/******/ 			for(var key in definition) {
/******/ 				if(__webpack_require__.o(definition, key) && !__webpack_require__.o(exports, key)) {
/******/ 					Object.defineProperty(exports, key, { enumerable: true, get: definition[key] });
/******/ 				}
/******/ 			}
/******/ 		};
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/hasOwnProperty shorthand */
/******/ 	(() => {
/******/ 		__webpack_require__.o = (obj, prop) => (Object.prototype.hasOwnProperty.call(obj, prop))
/******/ 	})();
/******/ 	
/******/ 	/* webpack/runtime/make namespace object */
/******/ 	(() => {
/******/ 		// define __esModule on exports
/******/ 		__webpack_require__.r = (exports) => {
/******/ 			if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 				Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 			}
/******/ 			Object.defineProperty(exports, '__esModule', { value: true });
/******/ 		};
/******/ 	})();
/******/ 	
/************************************************************************/
/******/ 	
/******/ 	// startup
/******/ 	// Load entry module and return exports
/******/ 	// This entry module can't be inlined because the eval devtool is used.
/******/ 	var __webpack_exports__ = __webpack_require__("./client.js");
/******/ 	
/******/ })()
;