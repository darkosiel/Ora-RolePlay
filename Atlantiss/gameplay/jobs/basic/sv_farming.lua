RegisterServerCallback(
    "publicFarm:isOpen",
    function(source, callback, timeClosed)
        local currentHour = os.date("%H", os.time())
        local isOpen = true

        for i = 1, #timeClosed, 1 do
            if (tostring(timeClosed[i]) == tostring(currentHour)) then
                isOpen = false
                break
            end
        end
        callback(isOpen)
    end
)
