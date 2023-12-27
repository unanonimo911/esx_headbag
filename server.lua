ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('headbag_job:closest')
AddEventHandler('headbag_job:closest', function()
    local name = GetPlayerName(najblizszy)
    TriggerClientEvent('headbag_job:nalozNa', najblizszy)
end)

RegisterServerEvent('headbag_job:sendclosest')
AddEventHandler('headbag_job:sendclosest', function(closestPlayer)
    najblizszy = closestPlayer
end)

RegisterServerEvent('headbag_job:zdejmij')
AddEventHandler('headbag_job:zdejmij', function()
    TriggerClientEvent('headbag_job:zdejmijc', najblizszy)
end)

ESX.RegisterUsableItem('headbag', function(source)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    TriggerClientEvent('headbag_job:naloz', _source)
    TriggerEvent('headbag_job:debugger', source)
end)