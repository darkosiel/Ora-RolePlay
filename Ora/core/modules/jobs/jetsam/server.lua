--[[ 
	CREATE TABLE jetsam_orders (
	id INT NOT NULL AUTO_INCREMENT,
	uuid VARCHAR(100) NOT NULL,
	owner VARCHAR(100) NOT NULL,
	data TEXT NOT NULL DEFAULT '{}',
	date DATE NOT NULL DEFAULT current_timestamp(),
	received INT(1) NOT NULL DEFAULT '0',
	INDEX primary_key (id)
) COLLATE='latin1_swedish_ci';
 ]]

Atlantiss.Jobs.Jetsam.CanOpenMenu = true


RegisterCommand(
    "debugJetsamMenu",
    function(source)
        if (source == 0) then
            Atlantiss.Jobs.Jetsam.CanOpenMenu = true
            print("^2Jetsam employees can now open the menu !^0")
        end
    end,
    true
)


RegisterServerCallback(
	"Atlantiss::SVCB::Jobs:Jetsam:RequestOpenMenu",
	function(src, cb)
		cb(Atlantiss.Jobs.Jetsam.CanOpenMenu)

		if (Atlantiss.Jobs.Jetsam.CanOpenMenu == true) then
			Atlantiss.Jobs.Jetsam.CanOpenMenu = not Atlantiss.Jobs.Jetsam.CanOpenMenu
		end
	end
)

RegisterServerCallback(
	"Atlantiss::SVCB::Jobs:Jetsam:GetOrders",
	function(src, cb)
		MySQL.Async.fetchAll(
			"SELECT id, uuid, owner, data, DATE_FORMAT(date, '%d/%m/%Y') AS date, received FROM jetsam_orders",
			{},
			function(result)
				cb(result)
			end
		)
	end
)

RegisterServerCallback(
	"Atlantiss::SVCB::Jobs:Jetsam:ArchiveOrder",
	function(src, cb, id)
		MySQL.Async.fetchAll(
			"SELECT * FROM jetsam_orders WHERE id = @id",
			{["@id"] = id},
			function(result)
				if (not result[1]) then return cb(nil) end
				
				MySQL.Async.execute("UPDATE jetsam_orders SET received = 1 WHERE id = @id", {["@id"] = id})
				cb(result[1])
			end
		)
	end
)

RegisterServerCallback(
	"Atlantiss::SVCB::Jobs:Jetsam:CanOrder",
	function(src, cb)
		if (os.date("*t").hour == 18 and os.date("*t").min >= 44) then
			TriggerClientEvent("RageUI:Popup", src, {message = "~r~Les commandes ne sont pas possibles pour le moment"})
			return cb(false)
		end

		return cb(true)
	end
)


RegisterNetEvent("Atlantiss::SE::Jobs:Jetsam:Order")
AddEventHandler(
	"Atlantiss::SE::Jobs:Jetsam:Order",
	function(_data, uuid, owner)
		Citizen.SetTimeout(Atlantiss.Jobs.Jetsam.OrderWaitTime, function()
			MySQL.Async.execute(
				"INSERT INTO jetsam_orders (uuid, owner, data, date, received) VALUES (@uuid, @owner, @data, current_timestamp(), 0)",
				{
					["@uuid"] = uuid,
					["@owner"] = owner,
					["@data"] = json.encode(_data)
				}
			)
		end)
	end
)

RegisterNetEvent("Atlantiss::SE::Jobs:Jetsam:ClosedMenu")
AddEventHandler(
	"Atlantiss::SE::Jobs:Jetsam:ClosedMenu",
	function()
		Atlantiss.Jobs.Jetsam.CanOpenMenu = true
	end
)
