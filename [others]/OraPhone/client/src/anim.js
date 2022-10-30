
// To introduce async delay
const Delay = (ms) => new Promise(res => setTimeout(res, ms));


let myPedId = null


//"prop_amb_phone"
// OR "prop_npc_phone"
// OR "prop_cs_phone_01"
// OR "prop_npc_phone_02"
const phoneModel = "prop_amb_phone"
let phoneProp = 0

let currentStatus = "out"
let lastDict = null
let lastAnim = null

let ANIMS = {
    "cellphone@": {
        "out": {
            "text": "cellphone_text_in",
            "call": "cellphone_call_listen_base"
        },
        "text": {
            "out": "cellphone_text_out",
            "text": "cellphone_text_in",
            "call": "cellphone_text_to_call"
        },
        "call": {
            "out": "cellphone_call_out",
            "text": "cellphone_call_to_text",
            "call": "cellphone_text_to_call"
        }
    },
    "anim@cellphone@in_car@ps": {
        "out": {
            "text": "cellphone_text_in",
            "call": "cellphone_call_in"
        },
        "text": {
            "out": "cellphone_text_out",
            "text": "cellphone_text_in",
            "call": "cellphone_text_to_call"
        },
        "call": {
            "out": "cellphone_horizontal_exit",
            "text": "cellphone_call_to_text",
            "call": "cellphone_text_to_call"
        }
    }
}

async function newPhoneProp() {
    deletePhone()
    let modelHash = GetHashKey(phoneModel)
    if(modelHash && IsModelInCdimage(modelHash) && !HasModelLoaded(modelHash)) {
        RequestModel(modelHash)
        while(!HasModelLoaded(modelHash)) { await Delay(100) }
    }
    exports["Ora"].TriggerServerCallback("Ora::SE::Anticheat:RegisterObject", 
        function() {
            let ped = PlayerPedId()
            let [x,y,z] = GetEntityCoords(ped)
            phoneProp = CreateObject(modelHash, x, y, z + 0.2, true, true, true)
            let bone = GetPedBoneIndex(ped, 28422)
            AttachEntityToEntity(phoneProp, ped, bone, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
        },
        modelHash
    )
}

function deletePhone() {
    if(phoneProp != 0) {
        DeleteObject(phoneProp)
        phoneProp = 0
    }
}

/*////
	out || text || Call ||
//*///
async function PhonePlayAnim(state, freeze, force) {
    if(currentStatus == state && !force) {
        return
    }

    myPedId = PlayerPedId()
    freeze = freeze ?? false

    let dict = "cellphone@"
    if(IsPedInAnyVehicle(myPedId, false)) {
        dict = "anim@cellphone@in_car@ps"
    }
    await loadAnimDict(dict)

    let anim = ANIMS[dict][currentStatus][state]
    if(currentStatus != "out") {
        StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
    }
    let flag = 50
    if(freeze) {
        flag = 14
    }
    TaskPlayAnim(myPedId, dict, anim, 3.0, -1, -1, flag, 0, false, false, false)

    if(state != "out" && currentStatus == "out" ) {
        await Delay(380)
        await newPhoneProp()
    }

    lastDict = dict
    lastAnim = anim
    currentStatus = state

    if(state == "out" ) {
        await Delay(180)
        deletePhone()
        StopAnimTask(myPedId, lastDict, lastAnim, 1.0)
    }
}

async function PhonePlayOut() {
    await PhonePlayAnim("out")
}

async function PhonePlayText() {
    await PhonePlayAnim("text", false, true)
}

async function PhonePlayCall(freeze) {
    await PhonePlayAnim("call", freeze)
}

async function PhonePlayIn() {
    await PhonePlayText()
}

async function loadAnimDict(dict) {
    RequestAnimDict(dict)
    while(!HasAnimDictLoaded(dict)) {
        await Delay(1)
    }
}

export default { PhonePlayIn, PhonePlayOut, PhonePlayText, PhonePlayCall }

// Citizen.CreateThread(function ()
// 	await Delay(200)
// 	PhonePlayCall()
// 	await Delay(2000)
// 	PhonePlayOut()
// 	await Delay(2000)

// 	PhonePlayText()
// 	await Delay(2000)
// 	PhonePlayCall()
// 	await Delay(2000)
// 	PhonePlayOut()
// })