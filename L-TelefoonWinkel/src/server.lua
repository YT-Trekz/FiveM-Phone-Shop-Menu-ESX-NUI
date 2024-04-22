ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('L-TelefoonWinkel:phone')
AddEventHandler('L-TelefoonWinkel:phone', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if(xPlayer.getMoney() >= Config.Prijs.Telefoon) then
        xPlayer.removeMoney(Config.Prijs.Telefoon)
		xPlayer.addInventoryItem(Config.Item.Telefoon, 1)
        TriggerClientEvent('L-TelefoonWinkel:phone', src)
    else
        notification("Je hebt niet Genoeg ~r~Geld")
    end

end)

RegisterServerEvent('L-TelefoonWinkel:radio')
AddEventHandler('L-TelefoonWinkel:radio', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if(xPlayer.getMoney() >= Config.Prijs.Portefoon) then
        xPlayer.removeMoney(Config.Prijs.Portefoon)
		xPlayer.addInventoryItem(Config.Item.Portefoon, 1)
        TriggerClientEvent('L-TelefoonWinkel:radio', src)
    else
        notification("Je hebt niet Genoeg ~r~Geld")
    end

end)

function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end