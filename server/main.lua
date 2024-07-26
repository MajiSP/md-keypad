local expectedValue = nil
local successCallback = nil

if Config.Debug then
    RegisterServerEvent('md-keypad:testOpen')
    AddEventHandler('md-keypad:testOpen', function(value)
        OpenNUI(source, value, function()
            print('Keypad opened successfully for testing')
        end)
    end)

    RegisterServerEvent('md-keypad:testClose')
    AddEventHandler('md-keypad:testClose', function()
        CloseNUI(source)
    end)
end

local function OpenNUI(player, value, cb)
    if value == nil then
        print('^1ERROR: Expected a value to open the keypad. Received none.^0')
        return false
    end

    expectedValue = value
    successCallback = cb
    TriggerClientEvent('md-keypad:openNUI', player, expectedValue)
    return true
end

exports('md-keypad', {
    Open = function(player, value, cb)
        return OpenNUI(player, value, cb)
    end,
    Close = CloseNUI
})

local function CloseNUI(player)
    expectedValue = nil
    successCallback = nil
    TriggerClientEvent('md-keypad:closeNUI', player)
end

RegisterNetEvent('md-keypad:success')
AddEventHandler('md-keypad:success', function()
    if successCallback then
        successCallback()
    end
end)

--exports('md-keypad', {
--    Open = function(player, value, cb)
--        return OpenNUI(player, value, cb)
--    end,
--    Close = CloseNUI
--})

--exports['md-keypad']:Open(source, 'value', function()
--  print('Success!')
--end)

-- exports['md-keypad']:Close() Used to force close the NUI.