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

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony export */ __webpack_require__.d(__webpack_exports__, {\n/* harmony export */   \"default\": () => (__WEBPACK_DEFAULT_EXPORT__)\n/* harmony export */ });\n\r\n// To introduce async delay\r\nconst Delay = (ms) => new Promise(res => setTimeout(res, ms));\r\n\r\n\r\nlet myPedId = null\r\n\r\n\r\n//\"prop_amb_phone\"\r\n// OR \"prop_npc_phone\"\r\n// OR \"prop_cs_phone_01\"\r\n// OR \"prop_npc_phone_02\"\r\nconst phoneModel = \"prop_npc_phone_02\"\r\nlet phoneProp = 0\r\n\r\nlet currentStatus = \"out\"\r\nlet lastDict = null\r\nlet lastAnim = null\r\n\r\nlet ANIMS = {\r\n    \"cellphone@\": {\r\n        \"out\": {\r\n            \"text\": \"cellphone_text_in\",\r\n            \"call\": \"cellphone_call_listen_base\"\r\n        },\r\n        \"text\": {\r\n            \"out\": \"cellphone_text_out\",\r\n            \"text\": \"cellphone_text_in\",\r\n            \"call\": \"cellphone_text_to_call\"\r\n        },\r\n        \"call\": {\r\n            \"out\": \"cellphone_call_out\",\r\n            \"text\": \"cellphone_call_to_text\",\r\n            \"call\": \"cellphone_text_to_call\"\r\n        }\r\n    },\r\n    \"anim@cellphone@in_car@ps\": {\r\n        \"out\": {\r\n            \"text\": \"cellphone_text_in\",\r\n            \"call\": \"cellphone_call_in\"\r\n        },\r\n        \"text\": {\r\n            \"out\": \"cellphone_text_out\",\r\n            \"text\": \"cellphone_text_in\",\r\n            \"call\": \"cellphone_text_to_call\"\r\n        },\r\n        \"call\": {\r\n            \"out\": \"cellphone_horizontal_exit\",\r\n            \"text\": \"cellphone_call_to_text\",\r\n            \"call\": \"cellphone_text_to_call\"\r\n        }\r\n    }\r\n}\r\n\r\nasync function newPhoneProp() {\r\n    deletePhone()\r\n    let modelHash = GetHashKey(phoneModel)\r\n    if(modelHash && IsModelInCdimage(modelHash) && !HasModelLoaded(modelHash)) {\r\n        RequestModel(modelHash)\r\n        while(!HasModelLoaded(modelHash)) { await Delay(100) }\r\n    }\r\n    exports[\"Ora\"].TriggerServerCallback(\"Ora::SE::Anticheat:RegisterObject\", \r\n        function() {\r\n            let ped = PlayerPedId()\r\n            let [x,y,z] = GetEntityCoords(ped)\r\n            phoneProp = CreateObject(modelHash, x, y, z + 0.2, true, true, true)\r\n            let bone = GetPedBoneIndex(ped, 28422)\r\n            AttachEntityToEntity(phoneProp, ped, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)\r\n        },\r\n        modelHash\r\n    )\r\n}\r\n\r\nfunction deletePhone() {\r\n    if(phoneProp != 0) {\r\n        DeleteObject(phoneProp)\r\n        phoneProp = 0\r\n    }\r\n}\r\n\r\n/*////\r\n\tout || text || Call ||\r\n//*///\r\nasync function PhonePlayAnim(state, freeze, force) {\r\n    if(currentStatus == state && force != true) {\r\n        return\r\n    }\r\n\r\n    myPedId = PlayerPedId()\r\n    freeze = freeze ?? false\r\n\r\n    let dict = \"cellphone@\"\r\n    if(IsPedInAnyVehicle(myPedId, false)) {\r\n        dict = \"anim@cellphone@in_car@ps\"\r\n    }\r\n    await loadAnimDict(dict)\r\n\r\n    let anim = ANIMS[dict][currentStatus][state]\r\n    if(currentStatus != \"out\") {\r\n        StopAnimTask(myPedId, lastDict, lastAnim, 1.0)\r\n    }\r\n    let flag = 50\r\n    if(freeze == true ) {\r\n        flag = 14\r\n    }\r\n    TaskPlayAnim(myPedId, dict, anim, 3.0, -1, -1, flag, 0, false, false, false)\r\n\r\n    if(state != \"out\" && currentStatus == \"out\" ) {\r\n        await Delay(380)\r\n        await newPhoneProp()\r\n    }\r\n\r\n    lastDict = dict\r\n    lastAnim = anim\r\n    currentStatus = state\r\n\r\n    if(state == \"out\" ) {\r\n        await Delay(180)\r\n        deletePhone()\r\n        StopAnimTask(myPedId, lastDict, lastAnim, 1.0)\r\n    }\r\n}\r\n\r\nasync function PhonePlayOut() {\r\n    await PhonePlayAnim(\"out\")\r\n}\r\n\r\nasync function PhonePlayText() {\r\n    await PhonePlayAnim(\"text\", false, true)\r\n}\r\n\r\nasync function PhonePlayCall(freeze) {\r\n    await PhonePlayAnim(\"call\", freeze)\r\n}\r\n\r\nasync function PhonePlayIn() {\r\n    await PhonePlayText()\r\n}\r\n\r\nasync function loadAnimDict(dict) {\r\n    RequestAnimDict(dict)\r\n    while(!HasAnimDictLoaded(dict)) {\r\n        await Delay(1)\r\n    }\r\n}\r\n\r\n/* harmony default export */ const __WEBPACK_DEFAULT_EXPORT__ = ({ PhonePlayIn, PhonePlayOut, PhonePlayText, PhonePlayCall });\r\n\r\n// Citizen.CreateThread(function ()\r\n// \tawait Delay(200)\r\n// \tPhonePlayCall()\r\n// \tawait Delay(2000)\r\n// \tPhonePlayOut()\r\n// \tawait Delay(2000)\r\n\r\n// \tPhonePlayText()\r\n// \tawait Delay(2000)\r\n// \tPhonePlayCall()\r\n// \tawait Delay(2000)\r\n// \tPhonePlayOut()\r\n// })\n\n//# sourceURL=webpack://phone_ora/./anim.js?");

/***/ }),

/***/ "./client.js":
/*!*******************!*\
  !*** ./client.js ***!
  \*******************/
/***/ ((__unused_webpack_module, __webpack_exports__, __webpack_require__) => {

eval("__webpack_require__.r(__webpack_exports__);\n/* harmony import */ var _anim_js__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./anim.js */ \"./anim.js\");\n/// <reference path=\"node_modules/fivem-js/lib/index.d.ts\"/>\r\n/// <reference path=\"node_modules/@citizenfx/client/natives_universal.d.ts\"/>\r\n/**\r\n * Imports\r\n */\r\n \r\n\r\n const Delay = ms => new Promise(r=>setTimeout(r, ms))\r\n /**\r\n  * Config\r\n  * \r\n  */\r\n const weekDays = ['Lundi', 'Mardi', 'Mercredi', 'Jeudi', 'Vendredi', 'Samedi', 'Dimanche']\r\n const months = ['Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin', 'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre']\r\n /**\r\n  * Client\r\n  */\r\n let phoneVisible = false\r\n let mouseFocus = false\r\n \r\n// RegisterKeyMapping('phone', 'Téléphone', 'keyboard', 'e')\r\nRegisterKeyMapping('phone', 'Téléphone', 'keyboard', 'f1')\r\nRegisterCommand('phone', _=>setPhoneVisible(!phoneVisible))\r\n\r\nfunction setMouseFocus(active = true) {\r\n    mouseFocus = active\r\n}\r\n\r\n//  function getIngameTime() {\r\n//      return {\r\n//          monthDay: GetClockDayOfMonth(),\r\n//          weekDay: weekDays[GetClockDayOfWeek()],\r\n//          month: months[GetClockMonth()],\r\n//          hours: GetClockHours(),\r\n//          minutes: GetClockMinutes(),\r\n//          year: GetClockYear(),\r\n//      }\r\n//  }\r\n\r\n\r\n\r\n\r\n\r\n // onTick timer ref\r\nlet onTick\r\nasync function setPhoneVisible(visible = true) {\r\n    phoneVisible = visible\r\n    // When we wanna show the phone\r\n    if (visible) {\r\n        // play some fivem anim\r\n        await _anim_js__WEBPACK_IMPORTED_MODULE_0__[\"default\"].PhonePlayIn()\r\n        // Give focus to Nui\r\n        SetNuiFocus(true, true)\r\n        setMouseFocus(visible)\r\n        SetNuiFocusKeepInput(visible)\r\n        // lock controls, focus nui\r\n        onTick = setTick(_=> {\r\n            // On right click in fivem focus back to the phone\r\n            // if (IsControlJustReleased(1, 25) && phoneVisible) {\r\n            //     setMouseFocus(true)\r\n            // }\r\n            // Enforce nui focus on or off\r\n            // SetNuiFocus(mouseFocus, mouseFocus)\r\n            // https://docs.fivem.net/docs/game-references/controls/\r\n            DisableAllControlActions(1)\r\n            // sprint\r\n            EnableControlAction(1, 21)\r\n            // right click to switch focus back on ui\r\n            EnableControlAction(1, 25)\r\n            // move\r\n            EnableControlAction(1, 30);EnableControlAction(1, 31);EnableControlAction(1, 32);EnableControlAction(1, 33);EnableControlAction(1, 34);EnableControlAction(1, 35)\r\n            // push to talk\r\n            EnableControlAction(1, 249);\r\n        })\r\n    // When we wanna hide the phone\r\n    } else {\r\n        // Play some fivem anim\r\n        await _anim_js__WEBPACK_IMPORTED_MODULE_0__[\"default\"].PhonePlayOut()\r\n        // stop blocking controls on tick\r\n        clearTick(onTick)\r\n        // bring them back\r\n        EnableAllControlActions(1)\r\n    }\r\n    // Give & remove focus\r\n    SetNuiFocus(visible, visible)\r\n     // Show & hide UI\r\n    SendNUIMessage({\r\n        type: \"ui\",\r\n        display: visible\r\n    })\r\n}\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n // onNet events from server\r\nonNet('phone_ora:updateUserData', data => {\r\n    SendNUIMessage({\r\n        type: 'updateUserData',\r\n        data: data\r\n    })\r\n})\r\n\r\nonNet('phone_ora:callStarted', _ => {\r\n    SendNUIMessage({\r\n        action: 'beginCall',\r\n    })\r\n})\r\n\r\n onNet('phone_ora:callFinished', _ => {\r\n     SendNuiMessage({\r\n         action: 'endCall'\r\n     })\r\n })\r\n\r\nonNet('phone_ora:receiveCall', async (fromNumber, chan, video=false) => {\r\n    playClassicNotifSound(2)\r\n    await setPhoneVisible(true)\r\n    SendNUIMessage({\r\n        action: 'receiveCall',\r\n        fromNumber,\r\n        channel: chan,\r\n        video,\r\n        time: getIngameTime()\r\n    })\r\n})\r\n\r\n // Nui callbacks\r\n\r\n\r\nRegisterNuiCallbackType('request_user_data')\r\non('__cfx_nui:request_user_data', _ => {\r\n    emitNet('OraPhone:server:request_user_data')\r\n})\r\n\r\nRegisterNuiCallbackType('patch_user_data')\r\non('__cfx_nui:patch_user_data', params => {\r\n    emitNet('phone_ora:patch_user_data', params)\r\n})\r\n\r\n RegisterNuiCallbackType('delete_contact')\r\n on('__cfx_nui:delete_contact', c => {\r\n     emitNet('phone_ora:delete_contact', c)\r\n })\r\n \r\n RegisterNuiCallbackType('send_message')\r\n on('__cfx_nui:send_message', msgData => {\r\n     emitNet('phone_ora:send_message', msgData)\r\n })\r\n\r\nRegisterNuiCallbackType('accept_call')\r\non('__cfx_nui:accept_call', channel => {\r\n    if (!channel) { console.error('accept call: missing channel') }\r\n    _anim_js__WEBPACK_IMPORTED_MODULE_0__[\"default\"].PhonePlayCall()\r\n    emitNet('phone_ora:accept_call', channel)\r\n})\r\n\r\n RegisterNuiCallbackType('end_call')\r\n on('__cfx_nui:end_call', _ => {\r\n     console.log('nui end call received')\r\n     emitNet('phone_ora:end_call')\r\n     _anim_js__WEBPACK_IMPORTED_MODULE_0__[\"default\"].PhonePlayText()\r\n })\r\n \r\nRegisterNuiCallbackType('call_number')\r\non('__cfx_nui:call_number', data => {\r\n    _anim_js__WEBPACK_IMPORTED_MODULE_0__[\"default\"].PhonePlayCall()\r\n    if (!data.targetNumber) { \r\n        console.error('call number: missing target number')\r\n        return\r\n    }\r\n    if (!data.fromNumber) {\r\n        console.error('call number: missing source number')\r\n        return\r\n    }\r\n    if (data.targetNumber == data.fromNumber) {\r\n        console.error('call number: the player is trying to call himself.')\r\n        return\r\n    }\r\n    emitNet('phone_ora:call_number', data.fromNumber, data.targetNumber)\r\n})\r\n\r\n RegisterNuiCallbackType('right_click')\r\n on('__cfx_nui:right_click', _ => {\r\n     // right click on UI = give back focus and some controls to fivem client without hiding the phone\r\n     setMouseFocus(false)\r\n })\r\n \r\n //*// Debug\r\n RegisterNuiCallbackType('debug')\r\n on('__cfx_nui:debug', data => {\r\n     console.log('Nui:debug',data.debugTitle)\r\n     delete data.debugTitle\r\n     console.log(data)\r\n })\r\n //*///\n\n//# sourceURL=webpack://phone_ora/./client.js?");

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