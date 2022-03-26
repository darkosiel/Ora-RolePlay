RegisterServerEvent("Atlantiss::SE::Dev:RegisterPosition")
AddEventHandler(
    "Atlantiss::SE::Dev:RegisterPosition",
    function(data)
        local _source = source
        
        -- Opens a file in append mode
        file = io.open("positions.json", "a+")

        -- appends a word test to the last line of the file
        file:write(',' .. data)

        -- closes the open file
        file:close()

    end
)