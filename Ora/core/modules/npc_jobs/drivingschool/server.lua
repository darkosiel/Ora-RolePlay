-- Ora.NpcJobs.DrivingSchool.Enabled = false

-- RegisterNetEvent("Ora::SE::NpcJobs:DrivingSchool::SetDB")
-- AddEventHandler(
--   "Ora::SE::NpcJobs:DrivingSchool::SetDB",
--   function(bool)
--     local src = source
--     local UUID = Ora.Identity:GetUuid(src)

--     MySQL.Async.execute("UPDATE users SET permis = @bool WHERE uuid = @uuid", {["@bool"] = bool, ["@uuid"] = UUID})
--   end
-- )


-- RegisterServerCallback(
--   "Ora::SE::NpcJobs:DrivingSchool::CanPass",
--   function(src, cb)
--     local UUID = Ora.Identity:GetUuid(src)

--     MySQL.Async.fetchAll(
--       "SELECT permis FROM users WHERE uuid = @uuid",
--       {["@uuid"] = UUID},
--       function(res)
--         if (res[1] and res[1].permis) then
--           if (res[1].permis == 0) then
--             cb(true)
--           else
--             cb(false)
--           end
--         else
--           print(string.format("~r~Cannot retreive permis status from id: %s, uuid: %s", src, UUID))
--           cb(false)
--         end
--       end
--     )
--   end
-- )

-- RegisterServerCallback(
--   "Ora::SE::NpcJobs:DrivingSchool::IsNPCEnabled",
--   function(src, cb)
--     cb(Ora.NpcJobs.DrivingSchool.Enabled)
--   end
-- )


-- RegisterCommand(
-- 	"EnableDrivingSchoolNPC",
-- 	function(source)
-- 		if (source == 0) then
-- 			Ora.NpcJobs.DrivingSchool.Enabled = true
-- 			print("^2Driving school NPC enbaled !^0")
-- 			TriggerClientEvent("Ora::CE::NpcJobs:DrivingSchool::Enable", -1)
-- 		end
-- 	end,
-- 	true
-- )
