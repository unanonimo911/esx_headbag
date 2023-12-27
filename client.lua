
local HaveBagOnHead = false

Citizen.CreateThread(function()
  while ESX == nil do
      ESX = exports["es_extended"]:getSharedObject()
      Citizen.Wait(0)
  end

  while ESX.GetPlayerData() == nil do Citizen.Wait(0) end
  while ESX.GetPlayerData().job == nil do Citizen.Wait(0) end
  while ESX.GetPlayerData().job.name == nil do Citizen.Wait(0) end

  ESX.PlayerData = ESX.GetPlayerData()
end)

function NajblizszyGracz() --This function send to server closestplayer

local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
local player = GetPlayerPed(-1)

if closestPlayer == -1 or closestDistance > 2.0 then 
    ESX.ShowNotification('~r~No hay ningún jugador cerca')
else
  if not HaveBagOnHead then
    TriggerServerEvent('headbag_job:sendclosest', GetPlayerServerId(closestPlayer))
    ESX.ShowNotification('~g~Has puesto una bolsa a ~w~' .. GetPlayerName(closestPlayer))
    TriggerServerEvent('headbag_job:closest')
  else
    ESX.ShowNotification('~r~YA TIENE UNA BOLSA EN LA CABEZA')
  end
end

end

RegisterNetEvent('headbag_job:naloz') --This event open menu
AddEventHandler('headbag_job:naloz', function()
    OpenBagMenu()
end)

RegisterNetEvent('esx:setJob', function(job)
  ESX.PlayerData.job = job
end)

RegisterCommand('bolsa', function()
  local playerPed = PlayerId()
  local playerPedId = GetPlayerPed(-1)
  local playerJob = ESX.PlayerData.job.name
  while ESX.GetPlayerData() == nil do Citizen.Wait(0) end
  while ESX.GetPlayerData().job == nil do Citizen.Wait(0) end
  while ESX.GetPlayerData().job.name == nil do Citizen.Wait(0) end
  local hsafgjh = false 
  for _, maldivas in ipairs(Config.jobs) do 
    if playerJob == maldivas then 
      hsafgjh = true 
      break 
    end
  end
  if hsafgjh then
      TriggerEvent('headbag_job:naloz')
  else
    ESX.ShowNotification('NO ESTÁS AUTORIZADO.')
  end
end, false)



RegisterNetEvent('headbag_job:nalozNa') --This event put head bag on nearest player
AddEventHandler('headbag_job:nalozNa', function(gracz)
    local playerPed = GetPlayerPed(-1)
    Worek = CreateObject(GetHashKey("prop_money_bag_01"), 0, 0, 0, true, true, true) -- Create head bag object!
    AttachEntityToEntity(Worek, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 12844), 0.2, 0.04, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- Attach object to head
    SetNuiFocus(false,false)
    SendNUIMessage({type = 'openGeneral'})
    HaveBagOnHead = true
end)    

AddEventHandler('playerSpawned', function() --This event delete head bag when player is spawn again
DeleteEntity(Worek)
SetEntityAsNoLongerNeeded(Worek)
SendNUIMessage({type = 'closeAll'})
HaveBagOnHead = false
end)

RegisterNetEvent('headbag_job:zdejmijc') --This event delete head bag from player head
AddEventHandler('headbag_job:zdejmijc', function(gracz)
    ESX.ShowNotification('~g~¡Alguien te quitó la bolsa de la cabeza!')
    DeleteEntity(Worek)
    SetEntityAsNoLongerNeeded(Worek)
    SendNUIMessage({type = 'closeAll'})
    HaveBagOnHead = false
end)

function OpenBagMenu() --This function is menu function

    local elements = {
          {label = 'PONER BOLSA EN  CABEZA', value = 'puton'},
          {label = 'QUITAR BOLSA DE CABEZA', value = 'putoff'},
          
        }
  
    ESX.UI.Menu.CloseAll()
  
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'headbagging',
      {
        title    = 'HEAD BAG MENU',
        align    = 'top-left',
        elements = elements
        },
  
            function(data2, menu2)
  
  
              local player, distance = ESX.Game.GetClosestPlayer()
  
              if distance ~= -1 and distance <= 2.0 then
  
                if data2.current.value == 'puton' then
                    NajblizszyGracz()
                end
  
                if data2.current.value == 'putoff' then
                  TriggerServerEvent('headbag_job:zdejmij')
                end
              else
                ESX.ShowNotification('~r~No hay nadie cerca.')
              end
            end,
      function(data2, menu2)
        menu2.close()
      end
    )
  
  end

