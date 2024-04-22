ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function CheckPos(x, y, z, cx, cy, cz, radius)
    local t1 = x - cx
    local t12 = t1^2

    local t2 = y-cy
    local t21 = t2^2

    local t3 = z - cz
    local t31 = t3^2

    return (t12 + t21 + t31) <= radius^2
end

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if Config.MapCirkel == true then
            DrawMarker(Config.MapCirkelTypen, Config.Locatie.x,  Config.Locatie.y,  Config.Locatie.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 0.5, 255, 255, 255, 255, false, true, 2, true, false, false, false)
        end
        local ped = PlayerPedId()
        local pcoords = GetEntityCoords(ped)
        if CheckPos(Config.Locatie.x, Config.Locatie.y, Config.Locatie.z, pcoords.x, pcoords.y, pcoords.z, 2) then
            if Config.DrawText3D then
                DrawText3D(Config.Locatie.x, Config.Locatie.y, Config.Locatie.z+0.9, 'Druk op ~m~[E]~s~ om menu te open', 0.60)
            else
                hintToDisplay('Druk ~INPUT_CONTEXT~ om ~m~menu~s~ te open')
            end
            if IsControlJustPressed(0, 51) then
                SetDisplay(not display)
            end
        end
    end    
end)

Citizen.CreateThread(function()
	if Config.MapBlip == true then
		local blip = AddBlipForCoord(Config.Locatie.x, Config.Locatie.y, Config.Locatie.z)

		SetBlipSprite (blip, 459)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.6)
		SetBlipColour (blip, 0)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Blipnaam)
		EndTextCommandSetBlipName(blip)
	end
end)

RegisterNUICallback("phone", function(data)
    TriggerServerEvent('L-TelefoonWinkel:phone')
    SetDisplay(false)
end)

RegisterNUICallback("radio", function(data)
    TriggerServerEvent('L-TelefoonWinkel:radio')
    SetDisplay(false)
end)

RegisterNUICallback("exit", function(data)
   SetDisplay(false)
end)

RegisterNUICallback("error", function(data)
   SetDisplay(false)
end)

function SetDisplay(bool)
   display = bool
   SetNuiFocus(bool, bool)
   SendNUIMessage({
      type = "ui",
      status = bool,
   })
end

Citizen.CreateThread(function()
   while display do
      Citizen.Wait(0)
      DisableControlAction(0, 1, display) 
      DisableControlAction(0, 2, display)
      DisableControlAction(0, 142, display) 
      DisableControlAction(0, 18, display)
      DisableControlAction(0, 322, display) 
      DisableControlAction(0, 106, display)
   end
end)

function chat(str, color)
   TriggerEvent(
      'chat:addMessage',
      {
         color = color,
         multiline = true,
         args = {str}
      }
   )
end

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)

	local factor = string.len(text) / 370
    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 65)

end