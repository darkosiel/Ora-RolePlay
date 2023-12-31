Ora.Illegal.Gofast = Ora.Illegal.Gofast or {}

function Ora.Illegal.Gofast:GetEmptyCurrentObject()
  return {
    VEHICLE = nil,
    STEP = 0,
    BLIP = nil,
    RUNNING = false,
    LOADING_POSITION = nil,
    DELIVERY_POSITION = nil,
    LOADED_PACKET = 0,
    CURRENT_MISSION = {},
    HAS_BEEN_LOADED = false,
    HAS_BEEN_DELIVERED = false,
    IS_ON_LOADING_ZONE = false,
    IS_ON_DELIVERY_ZONE = false,
    CAN_BE_LOADED = false,
    LOADING_PED = nil,
    UNLOADING_PED = nil,
    PLAYER_VEHICLE = nil,
    HAS_BOX = false,
    MISSION_ID = nil,
    MISSION_LEVEL = nil,
    ITEM_IN_TRUNK = nil,
    PLAYER_VEHICLE_PLATE = nil,
  }
end

Ora.Illegal.Gofast.Current = Ora.Illegal.Gofast:GetEmptyCurrentObject()

Ora.Illegal:Register("Gofast")
