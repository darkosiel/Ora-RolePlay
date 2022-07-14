function Ora.Identity.Job:FetchDB(playerId)
  local uuid = Ora.Identity:GetUuid(playerId)
  local returning = nil
  Ora.Identity.Job:Debug(string.format("^5%s^3 fetching to get his job table", uuid))

  MySQL.Async.fetchAll(
    "SELECT name, rank FROM players_jobs WHERE uuid = @uuid",
    {['@uuid'] = uuid},
    function(result)
      if (result[1]) then
        Ora.Identity.Job:Debug(string.format("^5%s^3 received job name ^5%s^3 job rank ^5%s^3", uuid, result[1].name, result[1].rank))
        returning = result[1]
      else
        Ora.Identity.Job:Debug(string.format("^5%s^3 received nothing (false)", uuid))
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
  "Ora::SVCB::Identity:Job:Get",
  function(source, callback, playerId)
    Ora.Identity.Job:Debug(string.format("^5%s^3 triggered ServerCallback : Ora::SVCB::Identity:Job:Get to retrieve job table for playerID: ^5%s^3", source, playerId))
    callback(Ora.Identity.Job:FetchDB(playerId))
  end
)

RegisterServerCallback(
    "Ora::SVCB::Identity:Job:GetEmployees",
    function(source, callback, job)
        MySQL.Async.fetchAll(
            "SELECT first_name, last_name, name, rank, orga, orga_rank, players_jobs.uuid AS uuid "..
            "FROM players_identity "..
            "JOIN players_jobs "..
            "ON players_identity.uuid = players_jobs.uuid "..
            "WHERE orga = @job OR name = @job",
            {
                ["@job"] = job
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

RegisterServerEvent("Ora::SE::Identity:Job:Save")
AddEventHandler(
  "Ora::SE::Identity:Job:Save",
  function(name, rank, _uuid)
    local src = source
    local uuid = _uuid or Ora.Identity:GetUuid(src)
    
    if (
      Ora.Jobs.Firefighter.Config.Dispatch.enabled and
      Ora.Jobs.Firefighter.Config.Fire.spawner.firefighterJobs[name] ~= nil
    ) then
      Ora.Jobs.Firefighter.Dispatch:subscribe(src, true)
    end

    Ora.Identity.Job:Debug(string.format("Saving user job (name: %s, rank: %s) for player id ^5%s^3 uuid ^5%s^3", name, rank, src, uuid))
    MySQL.Async.execute(
      "UPDATE players_jobs SET name = @name, rank = @rank WHERE uuid = @uuid",
      {
        ['@name'] = name,
        ['@rank'] = rank,
        ['@uuid'] = uuid
      }
    )
  end
)
