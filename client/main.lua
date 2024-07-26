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
end

local function CloseNUI()
    SetNuiFocus(false, false)
    isNUIFocused = false
    SendNUIMessage({
        type = 'close'
    })
end

RegisterNUICallback('close', function(data, cb)
    CloseNUI()
    cb('ok')
end)

RegisterNUICallback('success', function(data, cb)
    TriggerServerEvent('md-keypad:success')
    cb('ok')
end)

RegisterNetEvent('md-keypad:openNUI', OpenNUI)
RegisterNetEvent('md-keypad:closeNUI', CloseNUI)