local isNUIFocused = false

if Config.Debug then
    RegisterCommand('keypad', function(source, args)
        if args[1] == 'open' and args[2] then
            TriggerServerEvent('md-keypad:testOpen', args[2])
        elseif args[1] == 'close' then
            TriggerServerEvent('md-keypad:testClose')
        else
            TriggerEvent('chat:addSuggestion', '/keypad', 'Test keypad functionality', {
                { name = "action", help = "open <value> or close" }
            })
        end
    end, false)
end

local function OpenNUI(expectedValue)
    SetNuiFocus(true, true)
    isNUIFocused = true
    SendNUIMessage({
        type = 'open',
        expectedValue = expectedValue,
        keypadPosition = Config.KeypadPosition
    })
    return exports['md-keypad']:AwaitNUIResponse('keypadResult')
end

local function CloseNUI()
    SetNuiFocus(false, false)
    isNUIFocused = false
    SendNUIMessage({
        type = 'close'
    })
end

exports('AwaitNUIResponse', function(responseType)
    local p = promise.new()
    RegisterNUICallback(responseType, function(data, cb)
        p:resolve(data)
        cb('ok')
    end)
    return Citizen.Await(p)
end)

RegisterNUICallback('close', function(data, cb)
    CloseNUI()
    cb('ok')
end)

RegisterNetEvent('md-keypad:openNUI')
AddEventHandler('md-keypad:openNUI', function(expectedValue)
    local result = OpenNUI(expectedValue)
    if result.success then
        TriggerServerEvent('md-keypad:success')
    end
    Wait(500)
    CloseNUI()
end)

RegisterNetEvent('md-keypad:closeNUI', CloseNUI)
