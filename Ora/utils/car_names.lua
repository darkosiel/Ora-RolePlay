function AddTextEntry(key, value)
	Citizen.InvokeNative(GetHashKey("ADD_TEXT_ENTRY"), key, value)
end

Citizen.CreateThread(function()
    --POLICE
--[[    AddTextEntry("lspd1", "CVPI 2011 LSPD")
    AddTextEntry("lspd4", "FPIU 2016 LSPD")
    AddTextEntry("lspd5", "FPIS 2014 LSPD")
    AddTextEntry("lspd6", "FPIS 2014 Slicktop LSPD ")
    AddTextEntry("lspd8", "CVPI 2011 slicktop LSPD")
    AddTextEntry("lspd11", "Dodger Charger 2016 LSPD")
    AddTextEntry("Riot", "Lenco Bearcat")
    AddTextEntry("lspda", "CVPI 2011 Unmarked")
    AddTextEntry("lspdc", "Ford Explorer 2016 SWAT")
    AddTextEntry("lspde", "Ford Explorer 2016 DB")
    AddTextEntry("lspdf", "Ford Taurus 2014 Unmarked")
    AddTextEntry("lspdh", "Dodge Charger 2016 Unmarked")
    AddTextEntry("lspdg", "Dodge Charger 2018 Unmarked")
    AddTextEntry("lspdi", "CVPI 1999 Unmarked")
    AddTextEntry("lspdj", "Chevrolet Tahoe 2018 Unmarked")
    AddTextEntry("lspdk", "Chevrolet Tahoe 2010 Unmarked")
    AddTextEntry("lspdL", "Box ville LSPD ")
    AddTextEntry("policeb", "Harley Davidson LSPD")
    AddTextEntry("policem1", "Vélo LSPD")]]
    AddTextEntry("POLICE", "Stanier LSPD")
    AddTextEntry("POLICESLICK", "Stanier Slicktop LSPD")
    AddTextEntry("POLICE2", "Buffalo LSPD")
    AddTextEntry("POLICE2NEW", "Buffalo S LSPD")
    AddTextEntry("PDUMKBUFFALO", "Buffalo UMK LSPD")
    AddTextEntry("POLICE3", "Torrence LSPD")
    AddTextEntry("POLICE3SLICK", "Torrence")
    AddTextEntry("POLICE3UMK", "Torrence UMK LSPD")
    AddTextEntry("POLICE4", "Stanier UMK LSPD")
    AddTextEntry("PSCOUT", "Scout 2014 LSPD")
    AddTextEntry("PSCOUTNEW", "Scout 2016 LSPD")
    AddTextEntry("UMKSCOUT", "Scout UMK LSPD")
    AddTextEntry("POLEVERON", "Everon LSPD")
    AddTextEntry("POLALAMO", "Alamo LSPD") 
    AddTextEntry("POLRIOT", "Riot LSPD")
    AddTextEntry("POLSPEEDO", "Speedo LSPD")
    AddTextEntry("POLRAIDEN", "Raiden LSPD")
    AddTextEntry("SUPPRESSOR", "Lencot LSPD") 
    AddTextEntry("SEBALAMO2", "Alamo UMK")
    AddTextEntry("PREVOLTER", "Revolter UMK")
    AddTextEntry("POLALAMOOLD", "Alamo OLD LSPD")
    AddTextEntry("POLBUFFALS", "Buffalo LSPD 2018")
    AddTextEntry("NCOUTLSPD", "Scout 2018 LSPD")
    --SAMS
    AddTextEntry("EMSNSPEEDO", "Speedo SAMS") 
    AddTextEntry("EMSROAMER", "Roamer SAMS")
    AddTextEntry("SAFETEAM", "Caracara SAMS")
    --LSFD
    AddTextEntry("LSFDTRUCK3", "MTL 3 LSFD")
    AddTextEntry("LSFDTRUCK2", "MTL Bateau LSFD")
    AddTextEntry("LSFDTRUCK", "Camion Feu LSFD")
    AddTextEntry("LSFD", "Stanier LSFD")
    AddTextEntry("LSFD2", "Sadler LSFD")
    AddTextEntry("LSFD3", "Ambulance 2 LSFD")
    AddTextEntry("LSFD4", "Ambulance LSFD")
    AddTextEntry("LSFD5", "Bison LSFD")

    --Biker
    AddTextEntry("foxharley2", "Fox Harley")
    AddTextEntry("hvrod", "HV Rod")
    AddTextEntry("na252", "Na 252")
    AddTextEntry("dyna", "Dyna")
    AddTextEntry("dyne", "Dyne")
    AddTextEntry("Softail1", "Softail One")
    AddTextEntry("na25", "Na 25")
    AddTextEntry("lv", "LV Motorcycle")
    AddTextEntry("rk2019", "RK 2019")
    AddTextEntry("softail2", "Softail Two")
    AddTextEntry("indian", "Indian")
    AddTextEntry("acknodlow", "ACK Nodlow")
    AddTextEntry("Scout", "Scout")


    --Japonnais
    AddTextEntry("primo3", "Primo Sport")
    AddTextEntry("ALTIOR", "Vectre Classic")
    AddTextEntry("DOUBLED", "Obey TT")
    AddTextEntry("dubsta22", "Dubsta 2021")
    AddTextEntry("dubstaenus", "Dubsta 4x4")
    AddTextEntry("elegyrh7", "Elegy RH7")
    AddTextEntry("gauntlets", "Buffalo HellFire")
    AddTextEntry("oracleta", "Oracle V12")
    AddTextEntry("oraclestd", "Oracle V12 Turbo")
    AddTextEntry("scheisser", "Schafter Classic")
    AddTextEntry("SG3A2", "Sentinel E35")
    AddTextEntry("SG3B2", "Sentinel E35 Cabrio")
    AddTextEntry("SG3C2", "Sentinel E35 Break")
    AddTextEntry("SG32A", "Sentinel E35 Turbo")
    AddTextEntry("sigma2", "RT3000 Classic")
    AddTextEntry("patriots", "Patriot Sport")
    AddTextEntry("stratumc", "Stratum Custom")
    AddTextEntry("sunrise1", "Sunrise R")
    AddTextEntry("Tampar", "Tampa Sport")
    AddTextEntry("buffaloac", "Buffalo S Custom ")
    --WEAZEL
    AddTextEntry("NEWSVAN", "Rumpo News")
    -- AddTextEntry("NEWSMAV", "Maverick News")

    -- Véhicule addon Sport
    AddTextEntry("ARGENTO", "Obey Argento")
    AddTextEntry("pdumkstx", "Buffalo UMK 2018")

    -- Vehicule DLC "The Criminal Entreprise"
    AddTextEntry("brioso3", "brioso classique")
    AddTextEntry("corsita", "Corsita")
    AddTextEntry("draugur", "Draugur")
    AddTextEntry("greenwood", "Greenwood")
    AddTextEntry("kanjosj", "Dinka Kanjo SJ")
    AddTextEntry("postlude", "Dinka Postlude")
    AddTextEntry("rhinehart", "Ubermacht Rhinehart")
    AddTextEntry("ruiner4", "Importe Ruiner")
    AddTextEntry("sentinel4", "Sentinel Classique Custom")
    AddTextEntry("sm722", "Benefactor SM722")
    AddTextEntry("tenf2", "Obey 10F Custom")
    AddTextEntry("vigero2", "Declasse Vigero VL1")
    AddTextEntry("weevil2", "BF Weevil Rallye")
end)