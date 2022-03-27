local isWeaponBanned = false

RegisterNetEvent("Ora::Player:banWeapon")
AddEventHandler(
    "Ora::Player:banWeapon",
    function(weaponBanFlag)
      isWeaponBanned = weaponBanFlag
    end
)

Citizen.CreateThread(
  function()
    while (true) do
      Citizen.Wait(1000)
      if (isWeaponBanned == true) then
        local currentPed = LocalPlayer().Ped
        local currentWeapon = GetSelectedPedWeapon(currentPed)
        if (hasPowderWeapon(currentWeapon)) then
          RemoveWeaponFromPed(currentPed, currentWeapon)
          ShowNotification("~h~~r~POUR RAPPEL VOUS ETES BANNI ARMES. VOUS NE POUVEZ PAS TENIR UNE ARME~s~~h~")
        end
      end
    end
  end
)