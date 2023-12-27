RegisterServerEvent('esx_headbag:checkVersion')
AddEventHandler('esx_headbag:checkVersion', function()
    local currentVersion = '1.0.0' -- Versión actual de tu script
    local resourceName = GetCurrentResourceName()

    PerformHttpRequest('https://raw.githubusercontent.com/unanonimo911/versionchecker/main/versionheadbag.txt', function(errorCode, resultData, resultHeaders)
        if errorCode == 200 then
            local latestVersion = resultData:match("VERSION=(%d+.%d+.%d+)")

            if latestVersion and latestVersion == currentVersion then
                print('[^2' .. resourceName .. '^7] Versión correcta. ¡Listo para usar!')
            else
                print('[^1' .. resourceName .. '^7] Versión incorrecta. La versión más reciente es: ' .. latestVersion)
            end
        else
            print('[^1' .. resourceName .. '^7] No se pudo verificar la versión. Error de conexión.')
        end
    end, 'GET', '', {['Content-Type'] = 'application/json'})
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
            local asds = 5000
            Citizen.Await(asds)
        TriggerEvent('esx_headbag:checkVersion')
    end
end)


