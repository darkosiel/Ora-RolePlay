IllegalOrga = IllegalOrga or {}

IllegalOrga.MENU = {}
IllegalOrga.MENU.CURRENT_PLAYER = nil
IllegalOrga.MENU.CURRENT_RANK = nil

IllegalOrga.FACTIONS = {}
IllegalOrga.FACTIONS.LOADED = false
IllegalOrga.FACTIONS.LIST = {}

IllegalOrga.PROPERTIES_BLIPS = {}
IllegalOrga.PROPERTIES_ZONES = {}
IllegalOrga.CURRENT_PROPERTY_NAME = nil
IllegalOrga.CURRENT_PROPERTY = {}

IllegalOrga.MY_RANK = nil
IllegalOrga.CURRENT_ORGA = {
  NAME = "",
  LABEL = "",
  MY_UUID = nil,
  OWNER = nil,
  ID = nil,
  MEMBERS = {},
  RANKS = {},
  PROPERTIES = {},
}

function IllegalOrga.GetEmptyOrga()
  return {
    NAME = "",
    LABEL = "",
    OWNER = nil,
    MY_UUID = nil,
    ID = nil,
    MEMBERS = {},
    RANKS = {},
    PROPERTIES = {},
  }
end