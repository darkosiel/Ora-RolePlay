
// To introduce async delay
Delay = (ms) => new Promise(res => setTimeout(res, ms));

RegisterKeyMapping('throw-mode', 'Viser/Lancer un objet', 'keyboard', 'e')

let isInputBlocked = false
let currentItem
let throwableProp
let playerStrength
let lastStrengthUpdate
const getNextThrowable = () => {
    item = exports.Ora.getAnyThrowable()
    if (!item) { 
        currentItem = void 0
        return
    }
    return item
}

RegisterCommand('throw-mode', async () => {
    if (isInputBlocked) { return }
    isInputBlocked = true
    if (currentItem) {
        exports.Ora.RemoveFirstItem(currentItem.name)
        await launchItem()
    } else {
        const next = getNextThrowable()
        if (next) { 
            currentItem = next
            await takeItemInHands()
        }
        else { 
            exports.Ora.ShowNotification("~r~Pas d'objet à lancer")
        }
    }
    isInputBlocked = false
})

async function takeItemInHands() {
    const playerPed = PlayerPedId()
    const propHash = GetHashKey(currentItem.prop)
    // update strength at least 10 minutes after last fetch
    if(playerStrength == undefined || Date.now() - lastStrengthUpdate > 10 * 60 * 1000) {
        exports.Ora.TriggerServerCallback("Ora:getStrength", (strength, _isFull) => { 
            playerStrength = strength * 10 
            lastStrengthUpdate = Date.now()
        })
    }
    RequestModel(propHash)
    while(!HasModelLoaded(propHash)) { await Delay(100) }
    const pos = GetWorldPositionOfEntityBone(playerPed,6286)
    throwableProp = CreateObject(propHash, pos.x, pos.y, pos.z, true, true, true)
    await Delay(50)
    SetEntityAsMissionEntity(throwableProp)
    AttachEntityToEntity(throwableProp, playerPed, GetPedBoneIndex(playerPed,6286),0,0,0, 0,0,0)
}

async function launchItem () {
    const playerPed = PlayerPedId()
	const animDict = "melee@unarmed@streamed_variations"
	const anim = "plyr_takedown_front_slap"
	ClearPedTasks(playerPed)
	while (!HasAnimDictLoaded(animDict)) {
		RequestAnimDict(animDict)
		await Delay(5)
    }
	TaskPlayAnim(playerPed, animDict, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
    await Delay(500)
    DetachEntity(throwableProp)
    // Build force vector3 to launch the item
    const rawVect = GetEntityForwardVector(playerPed) // x & y
    const pitch = GetGameplayCamRelativePitch()
    const zForceFactor = (pitch + 70) / 105 - 0.5
    const maxLaunchForce = 100
    const minLaunchForce = 15
    const launchForce = minLaunchForce + (playerStrength / 200) * maxLaunchForce
    const vect = { x: launchForce * rawVect[0], y: launchForce * rawVect[1], z: launchForce * zForceFactor }
    ApplyForceToEntity(throwableProp,1,vect.x,vect.y,vect.z,0,0,0,0,false,true,true,false,true)
	await Delay(2000)
	throwableProp = SetEntityAsNoLongerNeeded()
    currentItem = void 0
}