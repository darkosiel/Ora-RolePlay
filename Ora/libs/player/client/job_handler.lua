AddEventHandler(
    "getmyjobname",
    function(cb)
        local job1 = "rien"
        local job2 = "rien"
        if Ora.Identity.Job:Get() ~= nil then
            job1 = Ora.Identity.Job:GetName()
        end

        if Ora.Identity.Orga:Get() ~= nil then
            job2 = Ora.Identity.Orga:GetName()
        end

        cb(job1, job2)
    end
)