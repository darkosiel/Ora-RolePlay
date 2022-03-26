-- 																						//////////////////////////////////////////
-- 																						//             SERVER FUNCTIONS		      //
-- 																						//////////////////////////////////////////


local function GetUUID(src, cb)
    MySQL.Async.fetchAll(
		"SELECT uuid FROM users WHERE identifier = @hex",
		{["@hex"] = GetIdentifiers(src).steam},
		function(result)
			if result[1] ~= nil then
				cb(result[1].uuid)
			else
				error(string.format("Cannot retreive uuid from source (%s). HEX: %s", src, GetIdentifiers(src).steam))
			end
		end
	)
end

local function tableIncludes(arr, val)
	for _, v in ipairs(arr) do
		if v.label then -- for mysql rdy
			if v.label == val then
				return true
			end
		else
			if v == val then
				return true
			end
		end
	end
	return false
end


-- 																						//////////////////////////////////////////
-- 																						//             ON MySQL READY		    		//
-- 																						//////////////////////////////////////////


MySQL.ready(function()
	MySQL.Async.fetchAll(
		"SELECT label FROM business",
		{},
		function(r)
			for k,v in pairs(Jobs) do
				if not tableIncludes(r, k) then
					MySQL.Async.execute("INSERT INTO business (label, treasury, prod) VALUES(@label, 0, '{}')", {["@label"] = k})
				end
			end
		end
	)
end)


-- 																						//////////////////////////////////////////
-- 																						//             SERVER CALLBACKS         //
-- 																						//////////////////////////////////////////


RegisterServerCallback('business:updateBillGUI', function(src, cb, company, plyUuid)
	MySQL.Async.fetchAll(
		"SELECT id, company, reason, src, dest, amount, method, DATE_FORMAT(time, '%d/%m/%Y %T') AS time FROM invoices WHERE company = @company ORDER BY id DESC LIMIT 100",
		{["@company"] = company},
		function(res)
			local finalres = {}
			for id, i in pairs(res) do
				if plyUuid and plyUuid ~= i.src then
					res[id] = nil
				else
					MySQL.Async.fetchAll(
						"SELECT uuid, first_name AS fn, last_name AS ln FROM players_identity WHERE uuid = @uuid or uuid = @uuid2",
						{
							["@uuid"] = i.src,
							["@uuid2"] = i.dest
						},
						function(r)
							if r[1] and r[2] then
								i.src = r[1].uuid == i.src and r[1].fn.." "..r[1].ln or r[2].fn.." "..r[2].ln
								i.dest = r[1].uuid == i.dest and r[1].fn.." "..r[1].ln or r[2].fn.." "..r[2].ln
							elseif r[1] and not r[2] then
								i.src = r[1].uuid == i.src and r[1].fn.." "..r[1].ln or "Introuvable"
								i.dest = r[1].uuid == i.dest and r[1].fn.." "..r[1].ln or "Introuvable"
							elseif not r[1] and r[2] then
								i.src = r[2].uuid == i.src and r[2].fn.." "..r[2].ln or "Introuvable"
								i.dest = r[2].uuid == i.dest and r[2].fn.." "..r[2].ln or "Introuvable"
							else
								i.src = "Introuvable"
								i.dest = "Introuvable"
							end
						end
					)
				end
			end
			for _, r in pairs(res) do
				if r ~= nil then table.insert(finalres, r) end
			end
			Wait(3000)
			cb(finalres)
		end
	)
end)

RegisterServerCallback('business:GetCompanyCapital', function(src, cb, name)
    MySQL.Async.fetchAll(
		"SELECT amount FROM banking_account WHERE iban = @name",
		{["@name"] = name},
		function(res) cb(res) end
	)
end)

RegisterServerCallback('business:GetCompanyTreasury', function(src, cb, name)
    MySQL.Async.fetchAll(
		"SELECT treasury FROM business WHERE label = @name",
		{["@name"] = name},
		function(res) cb(res) end
	)
end)

RegisterServerCallback('business:GetSalariesUUID', function(src, cb, salaries)
	for i = 1, #salaries, 1 do
		MySQL.Async.fetchAll(
			"SELECT uuid FROM players_identity WHERE first_name = @fname and last_name = @lname",
			{
				["@fname"] = salaries[i].first_name,
				["@lname"] = salaries[i].last_name
			},
			function(res)
				salaries[i].uuid = res[1].uuid
			end
		)
	end
	cb(salaries)
end)

RegisterServerCallback('business:GetSourceFromUUID', function(src, cb, uuid) cb(Player.GetSourceFromUUID(uuid)) end)

RegisterServerCallback('business:GetProductivity', function(src, cb, employees, company)
	MySQL.Async.fetchAll(
		"SELECT * FROM business WHERE label = @company",
		{["@company"] = company},
		function(res)
			if res[1] then
				local r = json.decode(res[1].prod)
				for i, obj in pairs(r) do
					for j = 1, #employees, 1 do
						if i == employees[j].uuid and employees[j] ~= nil then
							employees[j].exists = true
						end
					end
				end
				local final = {}
				for y = 1, #employees, 1 do
					if employees[y].exists == nil then
						local tempArr = {[employees[y].uuid] = {["first_name"] = employees[y].first_name, ["last_name"] = employees[y].last_name, ["reset"] = {["amount"] = 0, ["time"] = os.date("%d/%m/%y - %H:%M")}}}
						table.insert(final, tempArr)
					end
				end
				if #final ~= 0 then
					r = json.encode(r)
					if #r == 0 or r == "{}" then
						local ite = 1
						for k,v in pairs(final) do
							v = json.encode(v)
							if ite == 1 then
								r = v
								ite = 0
							else
								r = string.sub(r, 1, #r-1)..","..string.sub(v, 2, #v)
							end
						end
					else
						for k,v in pairs(final) do
							v = json.encode(v)
							r = string.sub(r, 1, #r-1)..","..string.sub(v, 2, #v)
						end
					end
					MySQL.Async.execute("UPDATE business SET prod = @prod WHERE label = @company", {["@prod"] = r, ["@company"] = company})
					final = {}
				end
			end
			MySQL.Async.fetchAll(
				"SELECT * FROM business WHERE label = @company",
				{["@company"] = company},
				function(res)
					if res[1] then
						r = json.decode(res[1].prod)
						for i = 1, #employees, 1 do
							for j, obj in pairs(r) do
								if j == employees[i].uuid then
									employees[i].prod = "Productivité : $"..obj.reset.amount.." (dernier reset le : "..obj.reset.time..")"
								end
							end
						end
						cb(employees)
					end
				end
			)
		end
	)
end)

RegisterServerCallback("business:RemoveFromTreasury", function(src, cb, acc, amount)
	MySQL.Async.fetchAll(
		'SELECT treasury FROM business WHERE label = @acc',
		{["@acc"] = acc},
		function(result)
			if result[1] and tonumber(result[1].treasury) > 0 then
				MySQL.Async.execute("UPDATE business SET treasury = treasury - @amount WHERE label = @acc", {["@amount"] = amount, ["@acc"] = acc})
				cb(true)
			else
				cb(false)
			end
		end
	)
end)

RegisterServerCallback("business:GetJobAndOrga", function(src, cb, uuid)
	MySQL.Async.fetchAll(
		'SELECT name as job, orga FROM players_jobs WHERE uuid = @uuid',
		{["@uuid"] = uuid},
		function(result)
			if result[1] then cb(result[1]) end
		end
	)
end)

															
-- 																						//////////////////////////////////////////
-- 																						//             SERVER EVENTS            //
-- 																						//////////////////////////////////////////


-- TriggerServerEvent("business:SetProductivity", uuidORsrc, jobname, amount, (adding: true or removing: false))
RegisterServerEvent("business:SetProductivity")
AddEventHandler(
	"business:SetProductivity",
	function(_uuid, _company, _amount, _adding) -- uuid can be a source
		local uuid, company, amount, adding = _uuid, _company, _amount, _adding

		if type(uuid) == "number" and uuid > 0 then
			GetUUID(
				uuid,
				function(result)
					uuid = result
					MySQL.Async.fetchAll(
						"SELECT prod FROM business WHERE label = @company",
						{["@company"] = company},
						function(res)
							if res[1] then
								local prod = json.decode(res[1].prod)
								for i, obj in pairs(prod) do
									if i == uuid then
										if adding then
											obj.reset.amount = obj.reset.amount + amount
										else
											obj.reset.amount = obj.reset.amount - amount
										end
										prod = json.encode(prod)
										MySQL.Async.execute("UPDATE business SET prod = @prod WHERE label = @company", {["@prod"] = prod, ["@company"] = company})
										break
									end
								end
							end
						end
					)
				end
			)
		else
			MySQL.Async.fetchAll(
				"SELECT prod FROM business WHERE label = @company",
				{["@company"] = company},
				function(res)
					if res[1] then
						local prod = json.decode(res[1].prod)
						for i, obj in pairs(prod) do
							if i == uuid then
								if adding then
									obj.reset.amount = obj.reset.amount + amount
								else
									obj.reset.amount = obj.reset.amount - amount
								end
								prod = json.encode(prod)
								MySQL.Async.execute("UPDATE business SET prod = @prod WHERE label = @company", {["@prod"] = prod, ["@company"] = company})
								break
							end
						end
					end
				end
			)
		end
	end
)

RegisterServerEvent("business:DeleteEmployProd")
AddEventHandler(
	"business:DeleteEmployProd",
	function(uuid, company)
		MySQL.Async.fetchAll(
			"SELECT prod FROM business WHERE label = @company",
			{["@company"] = company},
			function(res)
				if res[1] then
					local prod = json.decode(res[1].prod)
					for i, obj in pairs(prod) do
						if i == uuid then
							prod[i] = nil
							prod = json.encode(prod)
							MySQL.Async.execute("UPDATE business SET prod = @prod WHERE label = @company", {["@prod"] = prod, ["@company"] = company})
							break
						end
					end
				end
			end
		)
	end
)

RegisterServerEvent("business:ResetProductivity")
AddEventHandler(
	"business:ResetProductivity",
	function(uuid, company)
		MySQL.Async.fetchAll(
			"SELECT prod FROM business WHERE label = @company",
			{["@company"] = company},
			function(res)
				if res[1] then
					local prod = json.decode(res[1].prod)
					for i, obj in pairs(prod) do
						if i == uuid then
							obj.reset.time = os.date("%d/%m/%y - %H:%M")
							obj.reset.amount = 0
							prod = json.encode(prod)
							MySQL.Async.execute("UPDATE business SET prod = @prod WHERE label = @company", {["@prod"] = prod, ["@company"] = company})
							break
						end
					end
				end
			end
		)
	end
)


RegisterServerEvent("business:UpdateOrga")
AddEventHandler(
    "business:UpdateOrga",
	function(orga, rank, uuid)
		MySQL.Async.execute("UPDATE players_jobs SET orga = @orga, orga_rank = @rank WHERE uuid = @uuid", {["@orga"] = orga, ["@rank"] = rank, ["@uuid"] = uuid})
	end
)

RegisterServerEvent("business:AddFromTreasury")
AddEventHandler(
    "business:AddFromTreasury",
	function(acc, amount)
		MySQL.Async.execute("UPDATE business SET treasury = treasury + @amount WHERE label = @acc", {["@amount"] = amount, ["@acc"] = acc})
	end
)
