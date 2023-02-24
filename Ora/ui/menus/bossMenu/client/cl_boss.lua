local min_capital
local book_busi_id
local orgas
local GUI = {}
GUI.Time = 0
local lastDeposit = 0
local MIN_TIME_BETWEEN_DEPOSITS = 30000

RegisterCommand(
	"debug",
	function()
		SetNuiFocus(false, false)
	end,
	false
)

local function tableSortName(a,b)
	return a.first_name < b.first_name
end

local function setJob(employee)
	local isCoBoss
	if orgas then
		isCoboss = Ora.Identity.Orga:IsCoBoss()
	else
		isCoboss = Ora.Identity.Job:IsCoBoss()
	end
	local x = orgas and Ora.Identity.Orga:Get().grade or Ora.Identity.Job:Get().grade
	local i = 1
	for _, grade in pairs(x) do
		if grade.label == employee.rank then
			employee.grade = i
			i = 1
			break
		end
		i = i +1
	end
	for _, grade2 in pairs(x) do
		if grade2.label == employee.actualRank then
			employee.actualRank = i
			i = 1
			break
		end
		i = i +1
	end
	if isCoBoss and employee.actualRank == #x - 1 then
		TriggerEvent("business:disableLoading")
		return RageUI.Popup({message = "~r~Erreur~b~\nVous ne pouvez pas faire ça à votre collègue !"})
	end
	if isCoBoss and employee.actualRank == #x then
		TriggerEvent("business:disableLoading")
		return RageUI.Popup({message = "~r~Erreur~b~\nVous ne pouvez pas faire ça à votre patron !"})
	end
	TriggerServerCallback('business:GetSourceFromUUID', function(_src)
		employee.source = _src
		if employee.actualJob == employee.orga then
			if employee.actualJob == "gouvernement" then employee.actualJob = "gouv" end
			TriggerServerEvent("Ora::SE::Identity:Orga:Save", employee.actualJob, employee.grade, employee.uuid)
			if employee.source ~= nil then
				TriggerPlayerEvent("Ora::CE::Identity:Orga:Set", employee.source, employee.actualJob, employee.grade, true)
			end
		else
		if employee.actualJob == "gouvernement" then employee.actualJob = "gouv" end
			TriggerServerEvent("Ora::SE::Identity:Job:Save", employee.actualJob, employee.grade, employee.uuid)
			if employee.source ~= nil then
				TriggerPlayerEvent("Ora::CE::Identity:Job:Set", employee.source, employee.actualJob, employee.grade, true)
			end
		end
		Wait(math.random(1, 4)*500)
		TriggerServerCallback(
			orgas and "Ora::SVCB::Identity:Orga:GetEmployees" or "Ora::SVCB::Identity:Job:GetEmployees",
			function(res)
				TriggerEvent("business:updateSalGUI", res)
				TriggerEvent("business:disableLoading")
				RageUI.Popup({message = "~g~Succès~b~\nGrade de l'employé ~y~"..employee.name.fname.." "..employee.name.lname.."~b~ changé en ~y~"..employee.rank.." !"})
			end,
			orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName()
		)
	end, employee.uuid)
end

local function virer(employee)
	local isCoBoss
	if orgas then
		isCoboss = Ora.Identity.Orga:IsCoBoss()
	else
		isCoboss = Ora.Identity.Job:IsCoBoss()
	end
	local x = orgas and Ora.Identity.Orga:Get().grade or Ora.Identity.Job:Get().grade
	local i = 1
	for _, grade in pairs(x) do
		if grade.label == employee.actualRank then
			employee.actualRank = i
			i = 1
			break
		end
		i = i +1
	end
	if isCoBoss and employee.actualRank == #x - 1 then
		TriggerEvent("business:disableLoading")
		return RageUI.Popup({message = "~r~Erreur~b~\nVous ne pouvez pas virer votre collègue !"})
	end
	if isCoBoss and employee.actualRank == #x then
		TriggerEvent("business:disableLoading")
		return RageUI.Popup({message = "~r~Erreur~b~\nVous ne pouvez pas virer votre patron !"})
	end
	TriggerServerCallback('business:GetSourceFromUUID', function(_src)
		employee.source = _src
		if employee.orga == nil then
			TriggerServerCallback(
				"business:GetJobAndOrga",
				function(res)
					if res.job == employee.actualJob then
						TriggerServerEvent("Ora::SE::Identity:Job:Save", "chomeur", 1, employee.uuid)
						if employee.source ~= nil then
							TriggerPlayerEvent("Ora::CE::Identity:Job:Set", employee.source, "chomeur", 1)
						end
					else
						TriggerServerEvent("Ora::SE::Identity:Orga:Save", "chomeur", 1, employee.uuid)
						if employee.source ~= nil then
							TriggerPlayerEvent("Ora::CE::Identity:Orga:Set", employee.source, "chomeur", 1, true)
						end
					end
				end,
				employee.uuid
			)
		else
			if employee.actualJob == employee.orga then
				TriggerServerEvent("Ora::SE::Identity:Orga:Save", "chomeur", 1, employee.uuid)
				if employee.source ~= nil then
					TriggerPlayerEvent("Ora::CE::Identity:Orga:Set", employee.source, "chomeur", 1, true)
				end
			else
				TriggerServerEvent("Ora::SE::Identity:Job:Save", "chomeur", 1, employee.uuid)
				if employee.source ~= nil then
					TriggerPlayerEvent("Ora::CE::Identity:Job:Set", employee.source, "chomeur", 1)
				end
			end
		end
		Wait(math.random(1, 4)*500)
		TriggerServerCallback(
			orgas and "Ora::SVCB::Identity:Orga:GetEmployees" or "Ora::SVCB::Identity:Job:GetEmployees",
			function(res)
				TriggerEvent("business:updateSalGUI", res)
				TriggerEvent("business:disableLoading")
				RageUI.Popup({message = "~g~Succès~b~\nEmployé ~y~"..employee.name.fname.." "..employee.name.lname.."~b~ viré !"})
			end,
			orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName()
		)
		TriggerServerEvent("business:DeleteEmployProd", employee.uuid, orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName())
	end, employee.uuid)
end


RegisterNUICallback('log', function(data, cb)
	print(data.log)
end)


-- 																												//////////////////////////////////////////
-- 																												//               BUSINESS               //
-- 																												//////////////////////////////////////////


RegisterNetEvent('business:activateMenu')
AddEventHandler('business:activateMenu', function(_busi_salaries, _updateGUI, isOrga, isSelf)
	local capital = nil
	local treasury = nil
	orgas = isOrga
	local busi_label = isOrga and Ora.Identity.Orga:Get().label or Ora.Identity.Job:Get().label
	local busi_name = isOrga and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName()
	local _busi_ranks = isOrga and Ora.Identity.Orga:Get().grade or Ora.Identity.Job:Get().grade
	local busi_ranks = {}
	local busi_salary = {}
	for i=1, #_busi_ranks, 1 do table.insert(busi_salary, {_busi_ranks[i].label, _busi_ranks[i].salary}) end
	for _, grd in pairs(_busi_ranks) do table.insert(busi_ranks, grd.label) end
	
	TriggerServerCallback('business:GetCompanyTreasury', function(tr) treasury = tr[1].treasury end, busi_name)
	busi_name = busi_name == "gouv" and "gouvernement" or busi_name
	TriggerServerCallback('business:GetCompanyCapital', function(cptl) capital = cptl[1].amount end, busi_name)
	while treasury == nil do Wait(10) end
	while capital == nil do Wait(10) end

	local busi_prod_reset = 0
	local busi_salaries = _busi_salaries
	if #(busi_salaries) ~= 0 then
		table.sort(busi_salaries, tableSortName)
		TriggerServerCallback('business:GetSalariesUUID', function(s) busi_salaries = s end, busi_salaries)
		TriggerServerCallback(
			'business:GetProductivity',
			function(p)
				busi_salaries = p
				SetNuiFocus(true, true)
				if isSelf then
					SendNUIMessage({
						type = 'open_business_menu', cap = capital, treas = treasury, bus_name = busi_label, bus_prod_reset = busi_prod_reset, bus_sal = busi_salaries,
						medic_state = false, orgas = isOrga, bus_ranks = busi_ranks, bus_slry = busi_salary,  job_name = busi_name,
						isSelf = true, plyUuid = Ora.Identity:GetUuid(GetPlayerServerId(PlayerId()))
					})
				else
					SendNUIMessage({type = 'open_business_menu', cap = capital, treas = treasury, bus_name = busi_label, bus_prod_reset = busi_prod_reset, bus_sal = busi_salaries,
					medic_state = false, orgas = isOrga, bus_ranks = busi_ranks, bus_slry = busi_salary,  job_name = busi_name})
				end
			end, 
			busi_salaries, 
			orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName()
		)
	end
end)

RegisterNetEvent('business:updateSalGUI')
AddEventHandler('business:updateSalGUI', function(_busi_salaries)
	local capital = nil
	local treasury = nil
	local busi_label = orgas and Ora.Identity.Orga:Get().label or Ora.Identity.Job:Get().label
	local busi_name = orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName()
	local _busi_ranks = orgas and Ora.Identity.Orga:Get().grade or Ora.Identity.Job:Get().grade
	local busi_ranks = {}
	local busi_salary = {}
	for i=1, #_busi_ranks, 1 do table.insert(busi_salary, {_busi_ranks[i].label, _busi_ranks[i].salary}) end
	for _, grd in pairs(_busi_ranks) do table.insert(busi_ranks, grd.label) end
	
	TriggerServerCallback('business:GetCompanyTreasury', function(tr) treasury = tr[1].treasury end, busi_name)
	busi_name = busi_name == "gouv" and "gouvernement" or busi_name
	TriggerServerCallback('business:GetCompanyCapital', function(cptl) capital = cptl[1].amount end, busi_name)
	while treasury == nil do Wait(10) end
	while capital == nil do Wait(10) end

	local busi_salaries = _busi_salaries
	if #(busi_salaries) ~= 0 then
		table.sort(busi_salaries, tableSortName)
		TriggerServerCallback('business:GetSalariesUUID', function(s) busi_salaries = s end, busi_salaries)
		TriggerServerCallback(
			'business:GetProductivity',
			function(p) 
				busi_salaries = p
				Wait(math.random(1, 4)*500)
				SendNUIMessage({type = "update_business_sal_menu", cap = capital, treas = treasury, bus_name = busi_label, bus_prod_reset = busi_prod_reset, bus_sal = busi_salaries, 
				orgas = orgas, bus_ranks = busi_ranks, bus_slry = busi_salary, job_name = busi_name})
			end, 
			busi_salaries, 
			orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName()
		)
	end
end)

RegisterNUICallback('close_business_menu', function(data, cb) SetNuiFocus(false) end)

RegisterNUICallback('updateBillGUI', function(data, cb)
	local busi_name = orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName()
	local isSelf = Jobs[busi_name].isSelf
	busi_name = busi_name == "gouv" and "gouvernement" or busi_name
	TriggerServerCallback('business:updateBillGUI', function(factures)
		local _bills = factures
		SendNUIMessage({type = 'update_business_bill_menu', bills = _bills})
	end, busi_name, isSelf and Ora.Identity:GetUuid(GetPlayerServerId(PlayerId())) or false)
end)

RegisterNetEvent('business:disableLoading')
AddEventHandler('business:disableLoading', function()
	SendNUIMessage({type = 'business_disable_loading'})
end)

--[[ RegisterNetEvent('business:updateTreasury')
AddEventHandler('business:updateTreasury', function(treasury)
	local _treasury = treasury
	SendNUIMessage({type = 'update_business_treas_menu', treas = _treasury})
end) ]]

RegisterNUICallback('set_business', function(data, cb)
	if data.type ~= "" and data.type ~= nil then
		if data.type == "prime" then
			data.amount = tonumber(data.amount)
			if data.rib ~= nil and data.rib ~= "" and data.rib ~= "ATL-" then
				TriggerServerCallback(
					"banksExists",
					function(bool)
						if bool then
							local job = orgas and Ora.Identity.Orga:Get() or Ora.Identity.Job:Get()
							TriggerServerEvent(
								"bankingSendMoney",
								data.rib,
								data.amount,
								job.iban ~= nil and job.iban or job.name
							)
							--[[ TriggerServerEvent(
								"gcPhone:_internalAddMessage",
								"Banque",
								ATM.Selected.phone_number,
								"Nouveau virement de " ..
									data.amount ..
										"$ vers " ..
											data.rib ..
												" à partir du compte " ..
													orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName(),
								false
							) ]]
							TriggerServerEvent(
								"newTransaction",
								orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName(),
								data.rib,
								data.amount,
								"Prime versée par l'entreprise.",
								""
							)
							Wait(math.random(1, 4)*500)
							TriggerServerCallback(
								orgas and "Ora::SVCB::Identity:Orga:GetEmployees" or "Ora::SVCB::Identity:Job:GetEmployees",
								function(res)
									TriggerEvent("business:updateSalGUI", res)
									TriggerEvent("business:disableLoading")
									RageUI.Popup({
										message = "~g~Succès~b~\nVirement effectué vers ~y~" ..
											data.rib .. "~b~ de ~y~$" .. data.amount .. "~s~"
									})
								end,
								orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName()
							)
						else
							TriggerEvent("business:disableLoading")
							RageUI.Popup({message = "~r~Erreur~s~\nLe compte n'existe pas"})
						end
					end,
					data.rib
				)
			else
				TriggerEvent("business:disableLoading")
				RageUI.Popup({message="~r~Erreur~s~\nVeuillez spécifier un RIB et mettre un montant supérieur à 0."})
			end
		elseif data.type == "rank" then
			setJob(data)
		elseif data.type == "dismiss" then
			virer(data)
		elseif data.type == "reset_prod" then
			if data.job == "gouv" then
				data.job = "gouvernement"
			elseif data.orga == "gouv" then
				data.orga = "gouvernement"
			end
			TriggerServerEvent("business:ResetProductivity", data.uuid, data.actualJob)
			Wait(math.random(1, 4)*500)
			TriggerServerCallback(
				Ora.Identity.Orga:GetName() == data.actualJob and "Ora::SVCB::Identity:Orga:GetEmployees" or "Ora::SVCB::Identity:Job:GetEmployees",
				function(res)
					TriggerEvent("business:updateSalGUI", res)
					TriggerEvent("business:disableLoading")
					RageUI.Popup({message = "~g~Succès~b~\nProduction de l'employé~y~\n"..data.name.fname.." "..data.name.lname.."\n~b~Remise à zéro !"})
				end,
				Ora.Identity.Orga:GetName() == data.actualJob and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName()
			)
		elseif data.type == "getFromTreas" then
			data.number = tonumber(data.number)
			if data.number ~= nil and data.number > 0 then
				local name = orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName()
				if ( 
					Jobs[name].Storage and
					Jobs[name].Storage[1] and
					#(vector3(Jobs[name].Storage[1].Pos.x, Jobs[name].Storage[1].Pos.y, Jobs[name].Storage[1].Pos.z) - GetEntityCoords(GetPlayerPed(-1))) < 5.0
				) then
					TriggerServerCallback(
						orgas and "Ora::SVCB::Identity:Orga:GetEmployees" or "Ora::SVCB::Identity:Job:GetEmployees",
						function(res)
							TriggerServerCallback(
								'business:RemoveFromTreasury',
								function(bool)
									Wait(math.random(1, 4)*500)
									if ((GetGameTimer() - GUI.Time) > 2000 ) then
										GUI.Time = GetGameTimer()
										if bool then
											lastDeposit = GetGameTimer()
											TriggerServerCallback(
												"Ora::SE::Money:AuthorizePayment", 
												function(token)
													TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = data.number, SOURCE = "Retrait trésorerie", LEGIT = true})
												end,
												{}
											)
											TriggerEvent("business:updateSalGUI", res)
											TriggerEvent("business:disableLoading")
											RageUI.Popup({message = "~g~Succès~b~\nVous avez retiré ~y~$"..data.number.."~b~ de la trésorerie!"})
										else
											TriggerEvent("business:disableLoading")
											RageUI.Popup({message = "~r~Erreur~b~\nVous ne pouvez pas récupérer ce que vous n'avez pas."})
										end
									else
										ShowNotification("~r~Tentative de spam~s~")
									end
								end,
								orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName(),
								data.number
							)
						end,
						orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName()
					)
				elseif (not Jobs[name].Storage or not Jobs[name].Storage[1]) then
					TriggerServerCallback(
						orgas and "Ora::SVCB::Identity:Orga:GetEmployees" or "Ora::SVCB::Identity:Job:GetEmployees",
						function(res)
							TriggerServerCallback(
								'business:RemoveFromTreasury',
								function(bool)
									Wait(math.random(1, 4)*500)
									if bool then
										TriggerServerCallback(
											"Ora::SE::Money:AuthorizePayment", 
											function(token)
												TriggerServerEvent(Ora.Payment:GetServerEventName(), {TOKEN = token, AMOUNT = data.number, SOURCE = "Retrait trésorerie", LEGIT = true})
											end,
											{}
										)
										TriggerEvent("business:updateSalGUI", res)
										TriggerEvent("business:disableLoading")
										RageUI.Popup({message = "~g~Succès~b~\nVous avez retiré ~y~$"..data.number.."~b~ de la trésorerie!"})
									else
										TriggerEvent("business:disableLoading")
										RageUI.Popup({message = "~r~Erreur~b~\nVous ne pouvez pas récupérer ce que vous n'avez pas."})
									end
								end,
								orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName(),
								data.number
							)
						end,
						orgas and Ora.Identity.Orga:GetName() or Ora.Identity.Job:GetName()
					)
				else
					TriggerEvent("business:disableLoading")
					RageUI.Popup({message = "~r~Erreur~b~\nVous êtes trop loin de votre coffre entreprise pour retirer de la trésorerie."})
				end
			else
				TriggerEvent("business:disableLoading")
				RageUI.Popup({message = "~r~Erreur~b~\nEntrez un montant à retirer de la trésorerie."})
			end
		end
	end
end)
