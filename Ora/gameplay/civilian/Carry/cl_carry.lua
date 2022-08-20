local carryingBackInProgress = false
RegisterCommand("carry",
    function(source, args)
       
        if not carryingBackInProgress then
            carryingBackInProgress = true
            local player = PlayerPedId()
            lib = "missfinale_c2mcs_1"
            anim1 = "fin_c2_mcs_1_camman"
            lib2 = "nm"
            anim2 = "firemans_carry"
            distans = 0.15
            distans2 = 0.27
            height = 0.63
            spin = 0.0
            length = 100000
            controlFlagMe = 49
            controlFlagTarget = 33
            animFlagTarget = 1
            local closestPlayer = GetClosestPlayer(3)
            target = GetPlayerServerId(closestPlayer)
            if closestPlayer ~= nil then
                --print("triggering cmg2_animations:sync")
                TriggerServerEvent(
                    "cmg2_animations:sync",
                    closestPlayer,
                    lib,
                    lib2,
                    anim1,
                    anim2,
                    distans,
                    distans2,
                    height,
                    target,
                    length,
                    spin,
                    controlFlagMe,
                    controlFlagTarget,
                    animFlagTarget
                )
            else
                --print("[CMG Anim] No player nearby")
                TriggerEvent("carry:notify","CHAR_PEGASUS_DELIVERY",1,"Notification",false,"Aucun joueur à proximité")
            end
        else
            carryingBackInProgress = false
            ClearPedSecondaryTask(PlayerPedId())
            DetachEntity(PlayerPedId(), true, false)
            local closestPlayer = GetClosestPlayer(3)
            target = GetPlayerServerId(closestPlayer)
            TriggerServerEvent("cmg2_animations:stop", target)
        end
    end,
    false
)

RegisterNetEvent("cmg2_animations:syncTarget")
AddEventHandler(
    "cmg2_animations:syncTarget",
    function(target, animationLib, animation2, distans, distans2, height, length, spin, controlFlag)
        local playerPed = PlayerPedId()
        local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
        carryingBackInProgress = true
        --print("triggered cmg2_animations:syncTarget")
        RequestAnimDict(animationLib)

        while not HasAnimDictLoaded(animationLib) do
            Citizen.Wait(10)
        end
        if spin == nil then
            spin = 180.0
        end
        AttachEntityToEntity(
            PlayerPedId(),
            targetPed,
            0,
            distans2,
            distans,
            height,
            0.5,
            0.5,
            spin,
            false,
            false,
            false,
            false,
            2,
            false
        )
        if controlFlag == nil then
            controlFlag = 0
        end
        TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
    end
)

RegisterNetEvent("cmg2_animations:syncMe")
AddEventHandler(
    "cmg2_animations:syncMe",
    function(animationLib, animation, length, controlFlag, animFlag)
        local playerPed = PlayerPedId()
        --print("triggered cmg2_animations:syncMe")
        RequestAnimDict(animationLib)

        while not HasAnimDictLoaded(animationLib) do
            Citizen.Wait(10)
        end
        Wait(500)
        if controlFlag == nil then
            controlFlag = 0
        end
        TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)

        Citizen.Wait(length)
    end
)

RegisterNetEvent("cmg2_animations:cl_stop")
AddEventHandler(
    "cmg2_animations:cl_stop",
    function()
        carryingBackInProgress = false
        ClearPedSecondaryTask(PlayerPedId())
        DetachEntity(PlayerPedId(), true, false)
    end
)

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)

    for index, value in ipairs(players) do
        local target = GetPlayerPed(value)
        if (target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance =
                GetDistanceBetweenCoords(
                targetCoords["x"],
                targetCoords["y"],
                targetCoords["z"],
                plyCoords["x"],
                plyCoords["y"],
                plyCoords["z"],
                true
            )
            if (closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
    --print("closest player is dist: " .. tostring(closestDistance))
    if closestDistance <= radius then
        return closestPlayer
    else
        return nil
    end
end

RegisterNetEvent("carry:notify")
AddEventHandler(
    "carry:notify",
    function(icon, type, sender, title, text)
        Citizen.CreateThread(
            function()
                Wait(1)
                SetNotificationTextEntry("STRING")
                AddTextComponentString(text)
                SetNotificationMessage(icon, icon, true, type, sender, title, text)
                DrawNotification(false, true)
            end
        )
    end
)



cfg_chair = {}

cfg_chair.objects = {
	ButtonToSitOnChair = 58, -- // Default: G -- // https://docs.fivem.net/game-references/controls/
	ButtonToLayOnBed = 38, -- // Default: E -- // https://docs.fivem.net/game-references/controls/
	ButtonToStandUp = 23, -- // Default: F -- // https://docs.fivem.net/game-references/controls/
	SitAnimation = {anim='PROP_HUMAN_SEAT_CHAIR_MP_PLAYER'},
	BedBackAnimation = {dict='anim@gangops@morgue@table@', anim='ko_front'},
	BedStomachAnimation = {anim='WORLD_HUMAN_SUNBATHE'},
	BedSitAnimation = {anim='WORLD_HUMAN_PICNIC'},
	locations = {
		{object="v_med_bed2", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-1.4, direction=0.0, bed=true},
		{object="v_serv_ct_chair02", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.0, direction=168.0, bed=false},
		{object="prop_off_chair_04", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="prop_off_chair_03", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="prop_off_chair_05", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_club_officechair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_ilev_leath_chr", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_corp_offchair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_med_emptybed", verticalOffsetX=0.0, verticalOffsetY=0.13, verticalOffsetZ=-0.2, direction=90.0, bed=false},
		{object="Prop_Off_Chair_01", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false}
	}
}


local plyCoords = GetEntityCoords(PlayerPedId())
local isWithinObject = false
local oElement = {}

-- // BASIC
local InUse = false
local IsTextInUse = false
local PlyLastPos = 0

-- // ANIMATION
local Anim = 'sit'
local AnimScroll = 0

-- Medium Thread
CreateThread(function()
    while true do
        plyCoords = GetEntityCoords(PlayerPedId())
        Wait(1000)
    end
end)

-- Slow Thread
CreateThread(function()
    Wait(1500)
    while true do
        for _, element in pairs(cfg_chair.objects.locations) do
            local closestObject = GetClosestObjectOfType(plyCoords.x, plyCoords.y, plyCoords.z, 3.0, GetHashKey(element.object), 0, 0, 0)
            local coordsObject = GetEntityCoords(closestObject)
            local distanceDiff = #(coordsObject - plyCoords)
            if (distanceDiff < 3.0 and closestObject ~= 0) then
                if (distanceDiff < 2.0) then
                    oElement = {
                        fObject = closestObject,
                        fObjectCoords = coordsObject,
                        fObjectcX = element.verticalOffsetX,
                        fObjectcY = element.verticalOffsetY,
                        fObjectcZ = element.verticalOffsetZ,
                        fObjectDir = element.direction,
                        fObjectIsBed = element.bed
                    }
                    isWithinObject = true
                end
                break
            else
                isWithinObject = false
            end
        end
        Wait(2000)
    end
end)


-- Healing Thread
CreateThread(function()
    while true do
        Wait(3000)
        if InUse == true then
            if oElement.fObjectIsBed == true then
                local ply = PlayerPedId()
                local health = GetEntityHealth(ply)
                if health <= 199 then
                    SetEntityHealth(ply, health + 1)
                end
            end
        end
    end
end)

RegisterNetEvent('ChairBedSystem:Client:Animation')
AddEventHandler('ChairBedSystem:Client:Animation', function(v, coords)
    local object = v.fObject
    local vertx = v.fObjectcX
    local verty = v.fObjectcY
    local vertz = v.fObjectcZ
    local dir = v.fObjectDir
    local isBed = v.fObjectIsBed
    local objectcoords = coords
    
    local ped = PlayerPedId()
    PlyLastPos = GetEntityCoords(ped)
    FreezeEntityPosition(object, true)
    FreezeEntityPosition(ped, true)
    InUse = true
    if isBed == false then
        if cfg_chair.objects.SitAnimation.dict ~= nil then
            SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
            SetEntityHeading(ped, GetEntityHeading(object) - 180.0)
            local dict = cfg_chair.objects.SitAnimation.dict
            local anim = cfg_chair.objects.SitAnimation.anim
            
            AnimLoadDict(dict, anim, ped)
        else
            TaskStartScenarioAtPosition(ped, cfg_chair.objects.SitAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + dir, 0, true, true)
        end
    else
        if Anim == 'back' then
            if cfg_chair.objects.BedBackAnimation.dict ~= nil then
                SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
                SetEntityHeading(ped, GetEntityHeading(object) - 180.0)
                local dict = cfg_chair.objects.BedBackAnimation.dict
                local anim = cfg_chair.objects.BedBackAnimation.anim
                
                Animation(dict, anim, ped)
            else
                TaskStartScenarioAtPosition(ped, cfg_chair.objects.BedBackAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + dir, 0, true, true
            )
            end
        elseif Anim == 'stomach' then
            if cfg_chair.objects.BedStomachAnimation.dict ~= nil then
                SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
                SetEntityHeading(ped, GetEntityHeading(object) - 180.0)
                local dict = cfg_chair.objects.BedStomachAnimation.dict
                local anim = cfg_chair.objects.BedStomachAnimation.anim
                
                Animation(dict, anim, ped)
            else
                TaskStartScenarioAtPosition(ped, cfg_chair.objects.BedStomachAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + dir, 0, true, true)
            end
        elseif Anim == 'sit' then
            if cfg_chair.objects.BedSitAnimation.dict ~= nil then
                SetEntityCoords(ped, objectcoords.x, objectcoords.y, objectcoords.z + 0.5)
                SetEntityHeading(ped, GetEntityHeading(object) - 180.0)
                local dict = cfg_chair.objects.BedSitAnimation.dict
                local anim = cfg_chair.objects.BedSitAnimation.anim
                
                Animation(dict, anim, ped)
            else
                TaskStartScenarioAtPosition(ped, cfg_chair.objects.BedSitAnimation.anim, objectcoords.x + vertx, objectcoords.y + verty, objectcoords.z - vertz, GetEntityHeading(object) + 180.0, 0, true, true)
            end
        end
    end
end)



function DrawText3Ds(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = (string.len(text)) / 350
        DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 100)
    end
end

function Animation(dict, anim, ped)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
    
    TaskPlayAnim(ped, dict, anim, 8.0, 1.0, -1, 1, 0, 0, 0, 0)
end
