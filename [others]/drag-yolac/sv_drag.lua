local dragging = {}
--dragging[source] = targetSource, source is dragging targetSource
local dragged = {}
--dragged[targetSource] = source, targetSource is being dragged by source

RegisterServerEvent("DragPeople:sync")
AddEventHandler("DragPeople:sync", function(targetSrc)
	local source = source

	TriggerClientEvent("DragPeople:syncTarget", targetSrc, source)
	dragging[source] = targetSrc
	dragged[targetSrc] = source
end)

RegisterServerEvent("DragPeople:stop")
AddEventHandler("DragPeople:stop", function(targetSrc)
	local source = source

	if dragging[source] then
		TriggerClientEvent("DragPeople:cl_stop", targetSrc)
		dragging[source] = nil
		dragged[targetSrc] = nil
	elseif dragged[source] then
		TriggerClientEvent("DragPeople:cl_stop", dragged[source])			
		dragging[dragged[source]] = nil
		dragged[source] = nil
	end
end)

AddEventHandler('playerDropped', function(reason)
	local source = source
	
	if dragging[source] then
		TriggerClientEvent("DragPeople:cl_stop", dragging[source])
		dragged[dragging[source]] = nil
		dragging[source] = nil
	end

	if dragged[source] then
		TriggerClientEvent("DragPeople:cl_stop", dragged[source])
		dragging[dragged[source]] = nil
		dragged[source] = nil
	end
end)