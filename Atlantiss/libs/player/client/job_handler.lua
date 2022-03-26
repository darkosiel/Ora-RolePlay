AddEventHandler(
    "getmyjobname",
    function(cb)
        local job1 = "rien"
        local job2 = "rien"
        if Atlantiss.Identity.Job:Get() ~= nil then
            job1 = Atlantiss.Identity.Job:GetName()
        end

        if Atlantiss.Identity.Orga:Get() ~= nil then
            job2 = Atlantiss.Identity.Orga:GetName()
        end

        cb(job1, job2)
    end
)