local QBCore = exports['qb-core']:GetCoreObject()
local isShowingNUI = false

function ToggleEasterNUI()
    QBCore.Functions.TriggerCallback('sd-easter:getCurrentLeaderboard', function(result)
        local leaderboard = result
        SendNUIMessage({
            type = "toggle",
            status = not isShowingNUI,
            leaderboard = leaderboard
        })
        isShowingNUI = not isShowingNUI
    end)
end

RegisterNetEvent("eggs:client:updateLeaderboard", function() 
    QBCore.Functions.TriggerCallback('sd-easter:getCurrentLeaderboard', function(result)
        local leaderboard = result
        SendNUIMessage({
            type = "update",
            leaderboard = leaderboard
        })
    end)
end)