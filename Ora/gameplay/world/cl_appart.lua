Property = {}
local sectorizedProperties = {}
local currentProperty = {}
local currentAppart = nil
local weekRent = 1
local realtorOnDuty = 0

OraProperties = OraProperties or {}
OraProperties.LIST = {LOADED = false}
local Exist = false
local PosSS = {}
local CoordsCamList = Ora.Jobs.Immo:GetInteriors()

local zoneByGrids = {}
local MYPOS = {}
local function EnterProperty()
    local playerPed = LocalPlayer().Ped
    local propertyX = currentProperty
    local property = CoordsCamList[currentProperty.indexx]
    local x, y, z = table.unpack(LocalPlayer().Pos)
    MYPOS = {x = x, y = y, z = z}
    Ora.World.Appart.CURRENT.Outside = LocalPlayer().Pos
    Ora.Player.SavedPos = {
        x = x,
        y = y,
        z = z,
        heading = GetEntityHeading(playerPed)
    }

    Citizen.CreateThread(
        function()
            DoScreenFadeOut(100)
            Ora.Player:FreezePlayer(LocalPlayer().Ped, true)
            Ora.Player:SetEntityInvicible(PlayerId(), LocalPlayer().Ped, true)
            while not IsScreenFadedOut() and not IsInteriorReady(GetInteriorAtCoords(property.entry.x, property.entry.y, property.entry.z)) do
                Citizen.Wait(50)
            end
            Ora.Core:TeleportEntityTo(playerPed, vector3(property.entry.x, property.entry.y, property.entry.z), true)
            Wait(100)
            Ora.Player:FreezePlayer(LocalPlayer().Ped, false)
            Ora.Player:SetEntityInvicible(PlayerId(), LocalPlayer().Ped, false)
            DoScreenFadeIn(100)
            DrawSub(propertyX.name, 5000)
            w = propertyX["capacity"]
        end
    )
end
local function ExitProperty()
    outside = MYPOS
    local playerPed = LocalPlayer().Ped
    Ora.Player.SavedPos = {}

    if currentProperty ~= nil then
        if (CoordsCamList[currentProperty.indexx] ~= nil) then
            Zone:Remove(CoordsCamList[currentProperty.indexx].coffre)
        end
    end
    Zone:RemoveFromName("coffre_appart")
    Citizen.CreateThread(
        function()
            DoScreenFadeOut(100)
            Ora.Player:FreezePlayer(LocalPlayer().Ped, true)
            Ora.Player:SetEntityInvicible(PlayerId(), LocalPlayer().Ped, true)

            if outside == nil or outside.x == nil or outside.y == nil or outside.z == nil then
                outside = {x = 254.29, y = -780.99, z = 30.57}
                ShowNotification("~b~Votre localisation de départ n'a pas été trouvé. Vous serez TP au PC")
            end
            
            Ora.Core:TeleportEntityTo(playerPed, vector3(outside.x, outside.y, outside.z), true)
            Wait(100)
            Ora.Player:FreezePlayer(LocalPlayer().Ped, false)
            Ora.Player:SetEntityInvicible(PlayerId(), LocalPlayer().Ped, false)
            DoScreenFadeIn(100)
        end
    )
    currentProperty = nil
    Ora.World.Appart.CURRENT.Property = nil
    Ora.VM:Set("CurrentProperty", {})
end

local function Exit22()
    if (currentProperty == nil or currentProperty.name == nil) then
        TriggerServerCallback("Ora::SE::Instance:LeaveAllInstance", 
            function(canLeave)
                ExitProperty()
                KeySettings:Clear("keyboard", "E", "Appart_")
                KeySettings:Clear("controller", 46, "Appart_")
                Hint:RemoveAll()
            end
        )
    else
        TriggerServerCallback("Ora::SE::Instance:LeaveInstance", 
            function(canLeave)
                ExitProperty()
                KeySettings:Clear("keyboard", "E", "Appart_")
                KeySettings:Clear("controller", 46, "Appart_")
                Hint:RemoveAll()
            end,
            currentProperty.name
        )
    end
end
local function Enter2(pos)
    PosSS = pos
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour sortir")
    KeySettings:Add("keyboard", "E", Exit22, "Appart_")
    KeySettings:Add("controller", 46, Exit22, "Appart_")
end

local function Exit2()
    KeySettings:Clear("keyboard", "E", "Appart_")
    KeySettings:Clear("controller", 46, "Appart_")
    Hint:RemoveAll()
end

local function Exit()
    currentAppart = nil
    KeySettings:Clear("keyboard", "E", "Appart")
    KeySettings:Clear("controller", 46, "Appart")
    Hint:RemoveAll()
    
    if (RageUI.Visible(RMenu:Get("appart", "main"))) then
        RageUI.CloseAll()
    end

    if (RageUI.Visible(RMenu:Get("appart","Ora_jobs_immo_sell"))) then
        RageUI.CloseAll()
    end

    if (RageUI.Visible(RMenu:Get("appart","Ora_jobs_immo_information"))) then
        RageUI.CloseAll()
    end
    Ora.Jobs.Immo.Menu.Property = nil
    Ora.VM:Set("CurrentProperty", nil)
end

local function Open()
    currentProperty = Ora.World.Appart:GetById(currentAppart)
    if (currentProperty == nil) then
        ShowNotification(string.format("Debug %s : %s", "Open", "La propriété " .. currentAppart .. " n'existe pas"))
        return
    end

    Ora.World.Appart.CURRENT.Property = currentProperty
    Ora.Jobs.Immo.Menu.Property = currentProperty
    RMenu:Get("appart", "main"):SetTitle(currentProperty.name)
    RageUI.Visible(RMenu:Get("appart", "main"), true)
    KeySettings:Clear("keyboard", "E", "Appart")
    KeySettings:Clear("controller", 46, "Appart")
    Hint:RemoveAll()
end

local function Enter(z)
    currentAppart = nil
    Hint:Set("Appuyez sur ~INPUT_CONTEXT~ pour intéragir avec la propriété")
    KeySettings:Add("keyboard", "E", Open, "Appart")
    KeySettings:Add("controller", 46, Open, "Appart")
    currentAppart = z
end

local _Marker = {
    type = 23,
    scale = {x = 1.0, y = 1.0, z = 0.2},
    color = {r = 255, g = 255, b = 255, a = 120},
    Up = false,
    Cam = false,
    Rotate = false,
    visible = true
}

function SetupApparts()
    local CanSetup = false

    if (Ora.Identity:GetMyUuid() == nil) then
        TriggerServerCallback("Ora::SE::Identity:GetMyIdentity", function(data)
            Ora.Identity.List[GetPlayerServerId(PlayerId())] = data
            CanSetup = true
        end)
    else
        CanSetup = true
    end

    while (CanSetup == false) do Wait(0) end

    for propertyKey, propertyValue in pairs(Ora.World.Appart:GetList()) do
        local own = false

        if Ora.Identity:GetMyUuid() == propertyValue.owner then
            own = true
        end

        if not own and propertyValue.coowner ~= nil then
            for keyCoowner, valueCoowner in pairs(propertyValue.coowner) do
                if Ora.Identity:GetMyUuid() == valueCoowner then
                    own = true
                    break
                end
            end
        end

        if propertyValue.garagePos ~= nil and own then
            if (type(propertyValue.garagePos) == "string") then
                propertyValue.garagePos = json.decode(propertyValue.garagePos)
            else
                propertyValue.garagePos = propertyValue.garagePos
            end

            Properties = {
                type = 3,
                spawnpos = propertyValue.garagePos,
                Limit = propertyValue.garageMax
            }
            Blipdata = {
                Pos = propertyValue.garagePos,
                Blipcolor = 2,
                Blipname = "Garage " .. propertyValue.name,
                size = 0.6
            }

            local garage = Garage.New(propertyValue.name, propertyValue.garagePos, Properties, Blipdata)
            garage:Setup()
            __Marker = {
                type = 25,
                scale = {x = 1.5, y = 1.5, z = 0.2},
                color = {r = 125, g = 0, b = 0, a = 120},
                Up = false,
                Cam = false,
                Rotate = false,
                visible = true
            }
            propertyValue.garagePos.z = propertyValue.garagePos.z + 1.0
            Marker:Add(propertyValue.garagePos, __Marker)
        end

        if own then
            local coulour = 2
            local size = 0.6
            local name = propertyValue.name
            local blip = AddBlipForCoord(propertyValue.pos.x, propertyValue.pos.y, propertyValue.pos.z)
            SetBlipSprite(blip, 411)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, size)
            SetBlipColour(blip, coulour)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(name)
            EndTextCommandSetBlipName(blip)
        end
    end
end

local drawProperties = {}
local alreadyCreatedProperties = {}
local currentZones = {}
local hasBeenStarted = false


function refreshCurrentZones()
    local playerPed = LocalPlayer().Ped
    local entityCoords = LocalPlayer().Pos
    local myZone = Ora.Core:GetGridZoneId(entityCoords.x, entityCoords.y)
    hasBeenStarted = true
end

local currentZoneId = nil
function manageMarkers(zoneId)
    if (OraProperties.LIST.LOADED == true) then
        if (currentZoneId ~= zoneId) then
            currentZoneId = zoneId

            if (sectorizedProperties[zoneId] ~= nil) then
                for key2, value2 in pairs(sectorizedProperties[zoneId]) do
                    table.insert(
                        drawProperties,
                        {pos = value2.pos, propertyId = value2.id, zoneId = value2.zoneId}
                    )
                end
            end
    
            for key, value in pairs(drawProperties) do
                Citizen.Wait(50)
                if (value.zoneId ~= nil and value.zoneId ~= zoneId and alreadyCreatedProperties[value.propertyId] ~= nil) then
                    if (value.pos ~= nil) then
                        Zone:Remove(value.pos)
                        Marker:Remove(value.pos, _Marker)
                    end
                    drawProperties[key] = nil
                    if (value.propertyId ~= nil) then
                        alreadyCreatedProperties[value.propertyId] = nil
                    end
                elseif (value.zoneId == zoneId and alreadyCreatedProperties[value.propertyId] == nil) then
                    Zone:Add(value.pos, Enter, Exit, value.propertyId, 1.3)
                    Marker:Add(value.pos, _Marker)
                    alreadyCreatedProperties[value.propertyId] = true
                end
            end
        end
       
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000 * 2)
            local playerPed = LocalPlayer().Ped
            local entityCoords = LocalPlayer().Pos
            local gridZoneId = Ora.Core:GetGridZoneId(entityCoords.x, entityCoords.y)
            hasBeenStarted = true
            manageMarkers(gridZoneId)
        end
    end
)

function StartEverything()
    Ora.Jobs.Immo:CreateExits()
    Ora.World.Appart:GetList()
    OraProperties.LIST.LOADED = true

    for key, value in pairs(Ora.World.Appart:GetList()) do
        value.zoneId = Ora.Core:GetGridZoneId(value.pos.x, value.pos.y)
        if (sectorizedProperties[value.zoneId] == nil) then
            sectorizedProperties[value.zoneId] = {}
        end
        table.insert(sectorizedProperties[value.zoneId], value)
    end

    SetupApparts()
end

RegisterNetEvent("instance:Exist")
AddEventHandler(
    "instance:Exist",
    function(_users)
        --print(_users)
        Exist = _users
    end
)
RegisterNetEvent("instance:onCreate")
AddEventHandler(
    "instance:onCreate",
    function(instance)
        if instance.type == "property" then
            TriggerEvent("instance:enter", instance)
        end
    end
)

function EnterAppart()
    return EnterProperty()
end
function ExitAppart()
    return ExitProperty()
end

exports("EnterAppart", EnterAppart)
exports("ExitAppart", ExitAppart)

function DrawSub(msg, time)
    ClearPrints()
    BeginTextCommandPrint("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandPrint(time, 1)
end

RegisterNetEvent("core:UpdateCoOwner")
AddEventHandler(
    "core:UpdateCoOwner",
    function(id, uuid)
        local propertyValue = Ora.World.Appart:GetById(id)
        --local oldCoowners = propertyValue.coowner

        if (propertyValue == nil) then
            --ShowNotification(string.format("Debug %s : %s", "core:UpdateCoOwner", "La propriété " .. id .. " n'existe pas"))
            return
        end

        propertyValue.coowner = uuid
        local own = false
        if propertyValue.coowner ~= nil then
            for coownerId, coownerValue in pairs(propertyValue.coowner) do
                if Ora.Identity:GetMyUuid() == coownerValue then
                    own = true
                    break
                end
            end
        end

        -- if oldCoowners ~= nil then
        --     for coownerId, coownerValue in pairs(oldCoowners) do
        --         if Ora.Identity:GetMyUuid() == coownerValue then
        --             -- Delete blip/marker/zone etc
        --             break
        --         end
        --     end
        -- end

        if own then
            local coulour = 2
            local size = 0.6
            local name = propertyValue.name
            local blip = AddBlipForCoord(propertyValue.pos.x, propertyValue.pos.y, propertyValue.pos.z)

            SetBlipSprite(blip, 411)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, size)
            SetBlipColour(blip, coulour)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(name)
            EndTextCommandSetBlipName(blip)

            if (type(propertyValue.garagePos) == "string") then
                propertyValue.garagePos = json.decode(propertyValue.garagePos)
            else
                propertyValue.garagePos = propertyValue.garagePos
            end

            Properties = {
                type = 0,
                spawnpos = propertyValue.garagePos,
                Limit = propertyValue.garageMax
            }
            Blipdata = {
                Pos = propertyValue.garagePos,
                Blipcolor = 2,
                Blipname = "Garage " .. propertyValue.name,
                size = 0.6
            }

            local garage = Garage.New(propertyValue.name, propertyValue.garagePos, Properties, Blipdata)
            garage:Setup()
            __Marker = {
                type = 25,
                scale = {x = 1.5, y = 1.5, z = 0.2},
                color = {r = 125, g = 0, b = 0, a = 120},
                Up = false,
                Cam = false,
                Rotate = false,
                visible = true
            }
            propertyValue.garagePos.z = propertyValue.garagePos.z + 1.0
            Marker:Add(propertyValue.garagePos, __Marker)
        end
    end
)

RegisterNetEvent("core:UpdateOwner")
AddEventHandler(
    "core:UpdateOwner",
    function(id, uuid)
        local propertyValue = Ora.World.Appart:GetById(id)
    
        if (propertyValue == nil) then
            ShowNotification(string.format("Debug %s : %s", "core:UpdateOwner", "La propriété " .. id .. " n'existe pas"))
            return
        end


        propertyValue.owner = uuid
        Ora.World.Appart:AddToList(propertyValue)
        local own = false

        if Ora.Identity:GetMyUuid() == propertyValue.owner then
            own = true
        end

        if own then
            local coulour = 2
            local size = 0.6
            local name = propertyValue.name
            local blip = AddBlipForCoord(propertyValue.pos.x, propertyValue.pos.y, propertyValue.pos.z)
            SetBlipSprite(blip, 411)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, size)
            SetBlipColour(blip, coulour)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(name)
            EndTextCommandSetBlipName(blip)

            if (type(propertyValue.garagePos) == "string") then
                propertyValue.garagePos = json.decode(propertyValue.garagePos)
            else
                propertyValue.garagePos = propertyValue.garagePos
            end

            Properties = {
                type = 0,
                spawnpos = propertyValue.garagePos,
                Limit = propertyValue.garageMax
            }
            Blipdata = {
                Pos = propertyValue.garagePos,
                Blipcolor = 2,
                Blipname = "Garage " .. propertyValue.name,
                size = 0.6
            }

            local garage = Garage.New(propertyValue.name, propertyValue.garagePos, Properties, Blipdata)
            garage:Setup()
            __Marker = {
                type = 25,
                scale = {x = 1.5, y = 1.5, z = 0.2},
                color = {r = 125, g = 0, b = 0, a = 120},
                Up = false,
                Cam = false,
                Rotate = false,
                visible = true
            }
            propertyValue.garagePos.z = propertyValue.garagePos.z + 1.0
            Marker:Add(propertyValue.garagePos, __Marker)
        end
    end
)
RegisterNetEvent("core:updateloc2")
AddEventHandler(
    "core:updateloc2",
    function(id, time)
        local propertyValue = Ora.World.Appart:GetById(id)
        if (propertyValue ~= nil) then
            propertyValue.time = time  
            Ora.World.Appart:AddToList(propertyValue)
        end
    end
)
RegisterNetEvent("core:updateloc")
AddEventHandler(
    "core:updateloc",
    function(id, uuid, time)
        local propertyValue = Ora.World.Appart:GetById(id)
        if (propertyValue ~= nil) then
            propertyValue.time = time  
            propertyValue.owner = uuid
            Ora.World.Appart:AddToList(propertyValue)
        end
    end
)
RegisterNetEvent("add:Appart")
AddEventHandler(
    "add:Appart",
    function(newAddedAppart)
        if (newAddedAppart.id ~= nil) then
            local appart = Ora.World.Appart:GetById(newAddedAppart.id)

            if (appart == nil) then
                ShowNotification(string.format("Debug %s : %s", "Open", "La propriété " .. newAddedAppart.id .. " n'existe pas"))
                return
            end

            local coulour = 2
            local size = 0.6
            local name = appart.name

            if Ora.Identity.Job:GetName() == "immo" or Ora.Identity.Orga:GetName() == "immo" then
                coulour = 55
                name = nil
                size = 0.45

                if appart.owner ~= nil then
                    coulour = 84
                end

                local blip = AddBlipForCoord(appart.pos.x, appart.pos.y, appart.pos.z)
                SetBlipSprite(blip, 411)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, size)
                SetBlipColour(blip, coulour)
                SetBlipAsShortRange(blip, true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(name)
                EndTextCommandSetBlipName(blip)
            end

            if (sectorizedProperties[appart.zoneId] == nil) then
                sectorizedProperties[appart.zoneId] = {}
            end

            table.insert(sectorizedProperties[appart.zoneId], appart)
            Zone:Add(appart.pos, Enter, Exit, appart.id, 1.3)
            currentZoneId = nil
        end
    end
)

function DeletePropr(id)
    local propertyValue = Ora.World.Appart:GetById(id)
    if (propertyValue ~= nil) then
        RageUI.CloseAll()
        ShowNotification(string.format("La propriété ~g~%s~s~ a été supprimé", Ora.Jobs.Immo.Menu.Property.name))
        TriggerServerEvent("appart:remove", propertyValue.id)
        Marker:Remove(propertyValue.pos)
        Zone:Remove(propertyValue.pos)
        Ora.World.Appart:RemoveFromList(id)
        Ora.Jobs.Immo.Menu.Property = nil
    end
end

function NoOwnerAppart()
    RageUI.Button(
        "Visiter",
        nil,
        {},
        true,
        function(_, _, Selected)
            if Selected then
                RageUI.CloseAll()
                MYPOS = currentProperty.pos
                Ora.World.Appart.CURRENT.Outside = currentProperty.pos
                TriggerServerCallback("Ora::SE::Instance:EnterInstance", 
                    function(canEnter)
                        EnterProperty()
                    end,
                    currentProperty.name,
                    {inside = CoordsCamList[currentProperty.indexx].entry,type = "property"}
                )
            end
        end
    )
    RageUI.Button(
        "Propriétaire",
        nil,
        {RightLabel = "Aucun"},
        true,
        function(_, _, Selected)
        end
    )
    if Ora.Identity.Job:GetName() == "immo" then
        RageUI.CenterButton(
            "~b~↓↓ ~s~Actions agent immo ~b~↓↓",
            nil,
            {},
            true,
            function(_, _, _)
            end
        )

        RageUI.Button(
            string.format("Louer/Prolonger"),
            nil,
            {RightLabel = string.format("~h~~b~%s~s~~h~", math.ceil(Ora.Jobs.Immo.Menu.Property.price/50) .. "$/sem")},
            true,
            function(_, Ac, Selected)
                if (Selected) then
                    Ora.Jobs.Immo:ResetSellAndRent()
                end
            end,
            RMenu:Get("appart", "Ora_jobs_immo_rent")
        )

        RageUI.Button(
            "Vendre",
            nil,
            {RightLabel = string.format("~h~~b~%s~s~~h~", math.ceil(Ora.Jobs.Immo.Menu.Property.price) .. "$")},
            true,
            function(_, Ac, Selected)
                if (Selected) then
                    Ora.Jobs.Immo:ResetSellAndRent()
                end
            end,
            RMenu:Get("appart", "Ora_jobs_immo_sell")
        )

        RageUI.CenterButton(
            "~b~↓↓ ~s~Actions propriété ~b~↓↓",
            nil,
            {},
            true,
            function(_, _, _)
            end
        )

        RageUI.Button(
            "Informations propriété",
            nil,
            {},
            true,
            function(_, _, Selected)
                if Selected then
                    Ora.Jobs.Immo:GetPropertyOwners(Ora.Jobs.Immo.Menu.Property)
                end
            end,
            RMenu:Get("appart", "Ora_jobs_immo_information")
        )

        -- RageUI.Button(
        --     "Editer propriété",
        --     nil,
        --     {},
        --     true,
        --     function(_, _, Selected)
        --         if (Selected) then
        --             Ora.Jobs.Immo.Edit:ResetCurrent()
        --         end
        --     end,
        --     RMenu:Get("appart", "Ora_jobs_immo_edit_property")
        -- )

        RageUI.Button(
            "~r~Supprimer la propriété",
            nil,
            {RightLabel = nil},
            true,
            function(_, _, Selected)
                if Selected then
                    DeletePropr(Ora.Jobs.Immo.Menu.Property.id)
                end
            end
        )
    else
        RageUI.Button(
            "Contacter un agent immobilier",
            nil,
            {RightLabel = ""},
            true,
            function(_, _, Selected)
                if Selected then
                    ShowNotification("~g~Vous avez appellé un agent immobilier")
                    MakeCall("immo")
                end
            end
        )
    end
end
function MakeCall(job, msg)
    local plyPos = GetEntityCoords(LocalPlayer().Ped, true)
    TriggerServerEvent("call:makeCall", job, {x = plyPos.x, y = plyPos.y, z = plyPos.z}, msg)
end
function addStorage()
    local Storage = Storage.New(currentProperty.name .. "_storage", currentProperty.capacity)
    Storage:LinkToPos(CoordsCamList[currentProperty.indexx].coffre, "coffre_appart")
end

function OwnAppart()
    RageUI.Button(
        "Rentrer",
        nil,
        {},
        true,
        function(_, _, Selected)
            if Selected then
                RageUI.CloseAll()
                MYPOS = currentProperty.pos
                Ora.World.Appart.CURRENT.Outside = currentProperty.pos
                TriggerServerCallback("Ora::SE::Instance:EnterInstance", 
                    function(canEnter)
                        EnterProperty()
                        addStorage()
                    end,
                    currentProperty.name,
                    {inside = CoordsCamList[currentProperty.indexx].entry,type = "property"}
                )
            end
        end
    )

    RageUI.Button(
        "Propriétaire",
        nil,
        {RightLabel = "Vous"},
        true,
        function(_, _, Selected)
        end
    )

    if currentProperty.time == nil or currentProperty.time == "nil" then
        currentProperty.time = "Propriétaire"
    end

    RageUI.Button(
        "Fin du bail",
        nil,
        {RightLabel = currentProperty.time ~= nil and currentProperty.time or "Propriétaire"},
        true,
        function(_, _, Selected)
        end
    )

    RageUI.Button(
        "Ajouter un copropriétaire",
        nil,
        {},
        true,
        function(_, Ac, Selected)
            if Ac then
                HoverPlayer()
            end

            if Selected then
                local pedId = GetPlayerServerIdInDirection(8.0)
                if pedId then
                    TriggerServerEvent("core:AddCoOwner", pedId, currentProperty.id, currentProperty.coowner)
                else
                    ShowNotification("~r~Aucune personne aux alentours~s~")
                end
            end
        end
    )

    RageUI.Button(
        "Retirer un copropriétaire",
        nil,
        {},
        true,
        function(_, Ac, Selected)
            if Ac then
                HoverPlayer()
            end

            if Selected then
                local pedId = GetPlayerServerIdInDirection(8.0)
                if pedId then
                    TriggerServerEvent("core:RemoveCoOwner", pedId, currentProperty.id, currentProperty.coowner)
                end
            end
        end
    )

    RageUI.Button(
        "Changer de serrure",
        nil,
        {},
        true,
        function(_, Ac, Selected)
            if Selected then
                TriggerServerEvent("core:RemoveAll", currentProperty.id)
            end
        end
    )

    if (currentProperty.time ~= nil and currentProperty.time ~= "Propriétaire" and realtorOnDuty == 0) then
        RageUI.Button(
            "Prolonger le bail",
            nil,
            {RightLabel = string.format("~h~~b~%s%s~s~~h~", math.ceil(currentProperty.price/50), "$/sem")},
            true,
            function(_, Ac, Selected)
                if (Selected) then
                    Ora.Jobs.Immo:ResetSellAndRent()
                    Ora.Jobs.Immo.SellAndRent.CLIENT_FULLNAME = Ora.Identity:GetMyName()
                    Ora.Jobs.Immo.SellAndRent.CLIENT = GetPlayerServerId(PlayerId())
                end
            end,
            RMenu:Get("appart", "Ora_jobs_immo_self_rent")
        )
    end
end

function isCoOwn(PlyUuid)
    local found = false
    if currentProperty.coowner ~= nil then
        for i = 1, #currentProperty.coowner, 1 do
            if currentProperty.coowner[i] == PlyUuid then
                found = true
                break
            end
        end
    end
    return found
end

function CoOwnAppart()
    RageUI.Button(
        "Rentrer",
        nil,
        {},
        true,
        function(_, _, Selected)
            if Selected then
                RageUI.CloseAll()
                MYPOS = currentProperty.pos
                Ora.World.Appart.CURRENT.Outside = currentProperty.pos
                TriggerServerCallback("Ora::SE::Instance:EnterInstance", 
                    function(canEnter)
                        EnterProperty()
                        addStorage()
                    end,
                    currentProperty.name,
                    {inside = CoordsCamList[currentProperty.indexx].entry,type = "property"}
                )
            end
        end
    )
    RageUI.Button(
        "Propriétaire",
        nil,
        {RightLabel = "Masqué"},
        true,
        function(_, _, Selected)
        end
    )
    if currentProperty.time == nil or currentProperty.time == "nil" then
        currentProperty.time = "Propriétaire"
    end
    RageUI.Button(
        "Fin du bail",
        nil,
        {RightLabel = currentProperty.time ~= nil and currentProperty.time or "Propriétaire"},
        true,
        function(_, _, Selected)
        end
    )
end

function Idontownappart()
    RageUI.Button(
        "Sonner",
        nil,
        {},
        true,
        function(_, _, Selected)
            if Selected then
                RageUI.CloseAll()
                TriggerServerCallback(
                    "Ora::SVCB::immo:GetSourcesFromUUID",
                    function(src)
                        local _src = GetPlayerServerId(PlayerId())

                        if src == nil or #src == 0 then
                            return ShowNotification("~r~Personne ne peut vous ouvrir ! ")
                        end

                        local message = string.format("~h~Sonnette : %s~h~\n~g~~h~E~h~~s~ pour accepter\n~r~~h~Y~h~~s~ pour refuser", "Inconnue")
                        if (currentProperty.name ~= nil) then
                            message = string.format("~h~Sonnette : %s~h~\n~g~~h~E~h~~s~ pour accepter\n~r~~h~Y~h~~s~ pour refuser", currentProperty.name)
                        end


                        for i=1, #src do
                            TriggerPlayerEvent(
                                "RageUI:Popup",
                                src[i],
                                {message = message}
                            )
                            TriggerPlayerEvent("newAppartRequest", src[i], _src)
                        end
                    end,
                    currentProperty
                )
            end
        end
    )

    if (
        Ora.Identity:HasAnyJob('police') or
        Ora.Identity:HasAnyJob('lssd')
    ) then
        local isRaided = false

        for id, Raid in ipairs(Ora.Jobs.Immo.Raids) do
            if (Raid.PropertyName == currentProperty.name) then
                isRaided = true
                break
            end
        end

        if (isRaided == true) then
            RageUI.Button(
                "~g~Entrer dans la perquisition en cours",
                nil,
                {},
                true,
                function(_, _, Selected)
                    if (Selected) then
                        RageUI.CloseAll()
                        MYPOS = currentProperty.pos
                        Ora.World.Appart.CURRENT.Outside = currentProperty.pos
                        TriggerServerCallback("Ora::SE::Instance:EnterInstance",
                            function(canEnter)
                                EnterProperty()
                                addStorage()
                            end,
                            currentProperty.name,
                            {inside = CoordsCamList[currentProperty.indexx].entry,type = "property"}
                        )
                    end
                end
            )
        else
            RageUI.Button(
                "~r~Lancer une perquisition",
                nil,
                {},
                true,
                function(_, _, Selected)
                    if (Selected) then
                        TriggerServerEvent('Ora::SE::Job::Immo:LaunchRaid', currentProperty)
                    end
                end
            )
        end
    end
end

RegisterNetEvent("newAppartRequest")
AddEventHandler(
    "newAppartRequest",
    function(srcc)
        local v = false
        KeySettings:Add(
            "keyboard",
            "E",
            function()
                TriggerPlayerEvent("RageUI:Popup", srcc, {message = "Entrée ~g~acceptée"})
                ShowNotification("Entrée ~g~acceptée")
                TriggerPlayerEvent("accept:Appart", srcc)
                v = true
            end,
            "Appart_Key"
        )
        KeySettings:Add(
            "keyboard",
            "Y",
            function()
                TriggerPlayerEvent("RageUI:Popup", srcc, {message = "Entrée ~r~refusée"})
                ShowNotification("Entrée ~r~refusée")
                v = true
            end,
            "Appart_Key"
        )

        Wait(8000)
        if not v then
            ShowNotification("Entrée ~r~refusée")
            TriggerPlayerEvent("RageUI:Popup", srcc, {message = "Entrée ~r~refusée"})
        end
        KeySettings:Clear("keyboard", "E", "Appart_Key")
        KeySettings:Clear("keyboard", "Y", "Appart_Key")
    end
)
RegisterNetEvent("accept:Appart")
AddEventHandler(
    "accept:Appart",
    function()
        MYPOS = currentProperty.pos
        Ora.World.Appart.CURRENT.Outside = currentProperty.pos
        TriggerServerCallback("Ora::SE::Instance:EnterInstance", 
            function(canEnter)
                EnterProperty()
                addStorage()
            end,
            currentProperty.name,
            {inside = CoordsCamList[currentProperty.indexx].entry,type = "property"}
        )
    end
)

Citizen.CreateThread(
    function()
        while true do
            Wait(1)
            --  print("ab")
            if RageUI.Visible(RMenu:Get("appart", "main")) then
                RageUI.DrawContent(
                    {header = true, glare = false},
                    function()
                        if currentProperty.owner == nil then
                            NoOwnerAppart()
                        else
                            if Ora.Identity:GetMyUuid() == currentProperty.owner then
                                OwnAppart()
                            else
                                if isCoOwn(Ora.Identity:GetMyUuid()) then
                                    CoOwnAppart()
                                else
                                    Idontownappart()
                                end
                            end

                            if Ora.Identity.Job:GetName() == "immo" then
                                RageUI.CenterButton(
                                    "~b~↓↓ ~s~Action immobilier ~b~↓↓",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, _)
                                    end
                                )

                                RageUI.Button(
                                    string.format("Louer/Prolonger"),
                                    nil,
                                    {RightLabel = string.format("~h~~b~%s~s~~h~", math.ceil(Ora.Jobs.Immo.Menu.Property.price/50) .. "$/sem")},
                                    true,
                                    function(_, Ac, Selected)
                                        if (Selected) then
                                            Ora.Jobs.Immo:ResetSellAndRent()
                                        end
                                    end,
                                    RMenu:Get("appart", "Ora_jobs_immo_rent")
                                )
                        
                                RageUI.Button(
                                    string.format("Vendre"),
                                    nil,
                                    {RightLabel = string.format("~h~~b~%s~s~~h~", math.ceil(Ora.Jobs.Immo.Menu.Property.price) .. "$")},
                                    true,
                                    function(_, Ac, Selected)
                                        if (Selected) then
                                            Ora.Jobs.Immo:ResetSellAndRent()
                                        end
                                    end,
                                    RMenu:Get("appart", "Ora_jobs_immo_sell")
                                )
                        
                                RageUI.CenterButton(
                                    "~b~↓↓ ~s~Actions propriété ~b~↓↓",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, _)
                                    end
                                )
                        
                                RageUI.Button(
                                    "Informations propriété",
                                    nil,
                                    {},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            Ora.Jobs.Immo:GetPropertyOwners(Ora.Jobs.Immo.Menu.Property)
                                        end
                                    end,
                                    RMenu:Get("appart", "Ora_jobs_immo_information")
                                )
                        
                                -- RageUI.Button(
                                --     "Editer propriété",
                                --     nil,
                                --     {},
                                --     true,
                                --     function(_, _, Selected)
                                --         if (Selected) then
                                --             Ora.Jobs.Immo.Edit:ResetCurrent()
                                --         end
                                --     end,
                                --     RMenu:Get("appart", "Ora_jobs_immo_edit_property")
                                -- )
                        
                                RageUI.Button(
                                    "~r~Supprimer la propriété",
                                    nil,
                                    {RightLabel = nil},
                                    true,
                                    function(_, _, Selected)
                                        if Selected then
                                            DeletePropr(Ora.Jobs.Immo.Menu.Property.id)
                                        end
                                    end
                                )
                            end
                        end

                    end,
                    function()
                    end
                )
            end
        end
    end
)

local permaLock = {
    {objName = "v_ilev_rc_door2", x = 1005.292, y = -2998.266, z = -47.49689, h = 20.0},
    {objName = "v_ilev_fa_frontdoor", x = -14.86892, y = -1441.182, z = 31.19323, h = 180.0},
    {objName = "v_ilev_epsstoredoor", x = 241.36, y = 361.05, z = 105.89, h = 160.0},
    {objName = "v_ilev_mm_doorm_l", x = -816.716, y = 179.098, z = 72.82738, h = 291.0},
    {objName = "v_ilev_mm_doorm_r", x = -816.1068, y = 177.5109, z = 72.82738, h = 290.0},
    {objName = -1454760130, x = -794.19, y = 182.57, z = 73.04, h = 110.0},
    {objName = 1245831483, x = -793.39, y = 180.51, z = 73.04, h = 110.0},
    {objName = -1454760130, x = -794.51, y = 178.01, z = 73.04, h = 21.0},
    {objName = 1245831483, x = -796.57, y = 177.22, z = 73.04, h = 21.0},
    {objName = "v_ilev_trevtraildr", x = 1972.769, y = 3815.366, z = 33.66326, h = 29.0},
    --{ objName = "v_ilev_lostdoor", x = 981.1506, y = -103.2552, z = 74.9935, h = 42 },     --LOSTMC
    {objName = "v_ilev_mm_door", x = -806.287, y = 185.785, z = 72.48, h = 201.0},
    {objName = "v_ilev_gtdoor", x = 463.4782, y = -1003.538, z = 25.00599, c = "BC"},
    {objName = "v_ilev_bk_door", x = 266.3624, y = 217.5697, z = 110.4, h = 339.0, c = "BC"},
    {objName = "v_ilev_bk_door", x = 256.6172, y = 206.1522, z = 110.4, h = 250.0, c = "BC"},
    {objName = "v_ilev_lester_doorfront", x = 1273.82, y = -1720.7, z = 54.92, h = 24.85},
    {objName = "v_ilev_fh_frontdoor", x = 7.52, y = 539.53, z = 176.18, h = 150.0},
    {objName = "v_ilev_trev_doorfront", x = -1149.71, y = -1521.09, z = 10.78, h = 35.0},
    {objName = "v_ilev_janitor_frontdoor", x = -107.54, y = -9.02, z = 70.67, h = 70.22},
    {objName = -197537718, x = 997.46, y = -3164.35, z = -36.04, h = 180.0},
    {objName = -527552795, x = 997.18, y = -3166.26, z = -34.21, h = 3.0},

    {objName = 1282049587, x = 3602.0, y = -3717.88, z = 29.84, h = -34.61},
    {objName = 486670049, x = -107.54, y = -9.02, z = 70.67, h = 70.35},
    {objName = -421709054, x = 3599.87, y = 3719.38, z = 29.84, h = 0}
}

Citizen.CreateThread(function()
    -- Getting the object to interact with
    BikerClubhouse2 = exports['bob74_ipl']:GetBikerClubhouse2Object()
    -- Setting red bricked walls
    BikerClubhouse2.Walls.Set(BikerClubhouse2.Walls.plain, BikerClubhouse2.Walls.Color.lightBlueAndSable)
    -- Setting furnitures A
    BikerClubhouse2.Furnitures.Set(BikerClubhouse2.Furnitures.B, BikerClubhouse2.Furnitures.Color.gray)
    -- Setting the decoration
    BikerClubhouse2.Decoration.Set(BikerClubhouse2.Decoration.B)
    -- Setting the big painting on the wall
    BikerClubhouse2.Mural.Set(BikerClubhouse2.Mural.cityColor2)
    -- Enabling gun locker
    BikerClubhouse2.GunLocker.Set(BikerClubhouse2.GunLocker.on)
    BikerClubhouse2.Meth.Set(BikerClubhouse2.Meth.none)
    BikerClubhouse2.Cash.Set(BikerClubhouse2.Cash.none)
    BikerClubhouse2.Coke.Set(BikerClubhouse2.Coke.none)
    BikerClubhouse2.Weed.Set(BikerClubhouse2.Weed.none)
    -- Enabling mod booth
    BikerClubhouse2.ModBooth.Set(BikerClubhouse2.ModBooth.on)
    RefreshInterior(BikerClubhouse2.interiorId)
end)

Citizen.CreateThread(function()
    -- Getting the object to interact with
    BikerClubhouse1 = exports['bob74_ipl']:GetBikerClubhouse1Object()

    -- Setting red bricked walls
    BikerClubhouse1.Walls.Set(BikerClubhouse1.Walls.brick, 	BikerClubhouse1.Walls.Color.lightYellow)

    -- Setting furnitures B (fabric couch and chairs)
    BikerClubhouse1.Furnitures.Set(BikerClubhouse1.Furnitures.A, 1)

    -- Setting the decoration
    BikerClubhouse1.Decoration.Set(BikerClubhouse1.Decoration.A)
    -- Setting the big painting on the wall
    BikerClubhouse1.Mural.Set(BikerClubhouse1.Mural.forest)
    -- Enabling gun locker
    BikerClubhouse1.GunLocker.Set(BikerClubhouse1.GunLocker.on)
    -- Enabling mod booth
    BikerClubhouse1.ModBooth.Set(BikerClubhouse1.ModBooth.on)
    BikerClubhouse1.Meth.Set(BikerClubhouse1.Meth.none)
    BikerClubhouse1.Cash.Set(BikerClubhouse1.Cash.none)
    BikerClubhouse1.Coke.Set(BikerClubhouse1.Coke.none)
    BikerClubhouse1.Weed.Set(BikerClubhouse1.Weed.none)
    BikerClubhouse1.Counterfeit.Set(BikerClubhouse1.Counterfeit.none)
    BikerClubhouse1.Documents.Set(BikerClubhouse1.Documents.none)

    RefreshInterior(BikerClubhouse1.interiorId)
end)

function doCloseDoors()
    local playerCoords = LocalPlayer().Pos
    for k, v in pairs(permaLock) do
        if (GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, false) < 10.0) then
            local closeDoor = GetClosestObjectOfType(v.x, v.y, v.z, 3.0, GetHashKey(v.objName), false, false, false)
            --if DoesEntityExist(closeDoor) then print(GetEntityHeading(closeDoor)) end
            SetEntityHeading(closeDoor, v.h)
            if closeDoor and DoesEntityExist(closeDoor) and v.h then
                SetEntityHeading(closeDoor, v.h)
                FreezeEntityPosition(closeDoor, true)
            end
        end
    end
end

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000 * 1)
            doCloseDoors()
        end
    end
)

Citizen.CreateThread(
    function()
        Wait(10000)

        while true do
            TriggerServerCallback(
                "Ora::SE::Service:GetInServiceCount",
                function(count)
                    realtorOnDuty = count
                end,
                "immo"
            )

            Wait(600000)
        end
    end
)

local lastCall = 0
Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(5)
            local ped = LocalPlayer().Ped
            if
                IsPedShooting(ped) and GetInteriorFromEntity(ped) == 0 and GetSelectedPedWeapon(ped) and
                    GetGameTimer() > lastCall and
                    IsPedArmed(ped, 4) and LabsAndWarehouseAttack ~= nil and LabsAndWarehouseAttack.GetPlayerNoCallPolice() == false
             then
                local hasSuppressor, weaponUsed = IsPedCurrentWeaponSilenced(ped), GetSelectedPedWeapon(ped)

                if weaponUsed then
                    local handle2, target2 = FindFirstPed()
                    local success2
                    repeat
                        success2, target2 = FindNextPed(handle2)
                        if
                            target2 and DoesEntityExist(target2) and not IsPedAPlayer(target2) and
                                not IsPedDeadOrDying(target2) and
                                not IsPedShooting(target2) and
                                IsPedHuman(target2) and
                                GetGameTimer() > lastCall
                         then
                            local targetPos = GetEntityCoords(target2)
                            local dist = GetDistanceBetweenCoords(plyPos, targetPos, true)
                            if dist < (hasSuppressor and 4 or 120) then
                                if Ora.Identity.Job:GetName() ~= "police" and "lssd" then
                                    Citizen.SetTimeout(
                                        math.random(1000 * 60, 1000 * 120),
                                        function()
                                            TriggerServerEvent(
                                                "call:makeCall2",
                                                "police",
                                                {x = targetPos.x, y = targetPos.y, z = targetPos.z},
                                                "Tirs d'arme à feu !"
                                            )
                                            TriggerServerEvent(
                                                "call:makeCall2",
                                                "lssd",
                                                {x = targetPos.x, y = targetPos.y, z = targetPos.z},
                                                "Tirs d'arme à feu !"
                                            )                                        
                                        end
                                    )
                                end
                                lastCall = GetGameTimer() + 1000 * 180
                            end
                        end
                    until not success2
                    EndFindPed(handle2)
                end
            end
        end
    end
)
