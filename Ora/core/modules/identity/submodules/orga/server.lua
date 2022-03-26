function Atlantiss.Identity.Orga:Fetch(playerId)
  local uuid = Atlantiss.Identity:GetUuid(playerId)
  local returning = nil
  Atlantiss.Identity.Orga:Debug(string.format("^5%s^3 fetching to get his orga table", uuid))

  MySQL.Async.fetchAll(
    "SELECT orga as name, orga_rank as rank FROM players_jobs WHERE uuid = @uuid",
    {['@uuid'] = uuid},
    function(result)
      if (result[1]) then
        Atlantiss.Identity.Orga:Debug(string.format("^5%s^3 received orga name ^5%s^3 orga rank ^5%s^3", uuid, result[1].name, result[1].rank))
        returning = result[1]
      else
        Atlantiss.Identity.Orga:Debug(string.format("^5%s^3 received nothing (false)", uuid))
        returning = false
      end
    end
  )

  while (returning == nil) do
    Wait(500)
  end

  return returning
end


RegisterServerCallback(
  "Atlantiss::SVCB::Identity:Orga:Get",
  function(source, callback, playerId)
    Atlantiss.Identity.Orga:Debug(string.format("^5%s^3 triggered ServerCallback : Atlantiss::SVCB::Identity:Orga:Get to retrieve orga table for playerID: ^5%s^3", source, playerId))
    callback(Atlantiss.Identity.Orga:Fetch(playerId))
  end
)

RegisterServerCallback(
    "Atlantiss::SVCB::Identity:Orga:GetEmployees",
    function(source, callback, orga)
        MySQL.Async.fetchAll(
            "SELECT first_name, last_name, name, rank, orga, orga_rank, players_jobs.uuid AS uuid "..
            "FROM players_identity "..
            "JOIN players_jobs "..
            "ON players_identity.uuid = players_jobs.uuid "..
            "WHERE orga = @orga OR name = @orga",
            {
                ["@orga"] = orga
            },
            function(result)
                for i = 1, #result, 1 do
                    result[i].source = Player.GetSourceFromUUID(result[i].uuid)
                end
                callback(result)
            end
        )
    end
)

RegisterServerEvent("Atlantiss::SE::Identity:Orga:Save")
AddEventHandler(
  "Atlantiss::SE::Identity:Orga:Save",
  function(name, rank, _uuid)
    local src = source
    local uuid = _uuid or Atlantiss.Identity:GetUuid(src)
    
    if (
      Atlantiss.Jobs.Firefighter.Config.Dispatch.enabled and
      Atlantiss.Jobs.Firefighter.Config.Fire.spawner.firefighterJobs[name] ~= nil
    ) then
      Atlantiss.Jobs.Firefighter.Dispatch:subscribe(src, true)
    end

    Atlantiss.Identity.Orga:Debug(string.format("Saving user orga (name: %s, rank: %s) for player id ^5%s^3 uuid ^5%s^3", name, rank, src, uuid))
    MySQL.Async.execute(
      "UPDATE players_jobs SET orga = @name, orga_rank = @rank WHERE uuid = @uuid",
      {
        ['@name'] = name,
        ['@rank'] = rank,
        ['@uuid'] = uuid
      }
    )
  end
)
