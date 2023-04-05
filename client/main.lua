local QBCore = exports['qb-core']:GetCoreObject()
local EasterEggs = {}

local BasketInHand = false

-- Blip Creation

Citizen.CreateThread(function()
for k,v in pairs(Config.traderNPCS) do
    local blip = AddBlipForCoord(v.location)
    SetBlipSprite(blip, 164)
    SetBlipDisplay(blip, 4)
    SetBlipScale(blip, 0.6)
    SetBlipColour(blip, 59)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Easter Egg Exchange")
    EndTextCommandSetBlipName(blip)
    end
end)

Citizen.CreateThread(function()
    local shopData = {}
    shopData[1] = {
        header = Config.text.shopTitle,
        isMenuHeader = true
    }
    
    for i=1, #Config.easterBasket do
        table.insert(shopData, {
            header = Config.easterBasket[i].name,
            txt = Config.text.shopItem .. tostring(Config.easterBasket[i].cost),
            params = {
                event = "eggs:client:buyBox",
                args = i
            }
        })
    end
    
    shopData[#shopData+1] = {
        header = Config.text.shopClose,
        txt = "",
        params = {
            event = "qb-menu:closeMenu"
        }
    }
    
    for i, traderNPC in pairs(Config.traderNPCS) do
        local hash = GetHashKey(traderNPC.model)
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            Citizen.Wait(100)
        end
    
        traderNPC.ped = CreatePed(0, hash, traderNPC.location, false, false)
        SetEntityAsMissionEntity(traderNPC.ped, true, true)
        FreezeEntityPosition(traderNPC.ped, true)
        SetEntityInvincible(traderNPC.ped, true)
        SetBlockingOfNonTemporaryEvents(traderNPC.ped, true)
        SetEntityHeading(traderNPC.ped, traderNPC.heading)
        exports['qb-target']:AddTargetEntity(Config.traderNPCS[i].ped, {
            options = {
                {
                    icon = "fas fa-hand",
                    label = Config.text.shopEgg,
                    canInteract = function()
                        return true
                    end,
                    action = function()
                        exports['qb-menu']:openMenu(shopData)
                    end
                },
                {
                    icon = "fab fa-leanpub",
                    label = Config.text.leaderboard,
                    canInteract = function()
                        return true
                    end,
                    action = function()
                        ToggleEasterNUI()
                    end
                }
            },
            distance = 3.0
        })
    end
end)

function LoadModel(hash)
    hash = GetHashKey(hash)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(3000)
    end
end

RegisterNetEvent('eggs:respawnEgg', function(loc)
    local v = GlobalState.EasterEggs[loc]
    local hash = GetHashKey(v.model)
    --if not HasModelLoaded(hash) then LoadModel(hash) end
    if not EasterEggs[loc] then
        EasterEggs[loc] = CreateObject(hash, v.location, false, true, true)
        SetEntityAsMissionEntity(EasterEggs[loc], true, true)
        FreezeEntityPosition(EasterEggs[loc], true)
        SetEntityHeading(EasterEggs[loc], v.heading)
        exports['qb-target']:AddTargetEntity(EasterEggs[loc], {
            options = { {
                    icon = "fas fa-hand",
                    label = Config.text.pickupEgg,
                    action = function()
                        QBCore.Functions.Progressbar("pick_egg", Config.text.actionEgg, 2000, false, true, {
                            disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
                            { animDict = 'amb@prop_human_bum_bin@idle_a', anim = 'idle_a', flags = 47, },
                            {}, {}, function()
                            TriggerServerEvent("eggs:pickupEgg", loc)
                            ClearPedTasks(PlayerPedId())
                        end, function() -- Cancel
                            ClearPedTasks(PlayerPedId())
                        end)
                    end
                }
            },
            distance = 3.0
        })
    end
end)

RegisterNetEvent('eggs:removeEgg', function(loc)
    if DoesEntityExist(EasterEggs[loc]) then DeleteEntity(EasterEggs[loc]) end
    EasterEggs[loc] = nil
end)

RegisterNetEvent('eggs:basket', function()
    local PropBone = 57005
    local PropPlacement = {0.26, -0.16, -0.13, -60.0, -50.0, 0.0}

    if not BasketInHand then
        local playerPed = GetPlayerPed(-1)
        local basketHash = GetHashKey('bzzz_event_easter_basket_b')
        local boneIndex = GetPedBoneIndex(playerPed, PropBone)

        RequestModel(basketHash)
        while not HasModelLoaded(basketHash) do
            Citizen.Wait(0)
        end

        local basketObj = CreateObject(basketHash, 0, 0, 0, true, true, true)
        AttachEntityToEntity(basketObj, playerPed, boneIndex, PropPlacement[1], PropPlacement[2], PropPlacement[3], PropPlacement[4], PropPlacement[5], PropPlacement[6], true, true, false, true, 1, true)

        BasketInHand = true
    elseif BasketInHand then
        local playerPed = GetPlayerPed(-1)

        local basketObj = GetClosestObjectOfType(GetEntityCoords(playerPed), 1.0, GetHashKey('bzzz_event_easter_basket_b'), false, false, false)
        if DoesEntityExist(basketObj) then
            DeleteEntity(basketObj)
        end

        BasketInHand = false
    end
end)

RegisterNetEvent("eggs:init", function()
    for k, v in pairs (GlobalState.EasterEggs) do
        local hash = GetHashKey(v.model)
        if not HasModelLoaded(hash) then LoadModel(hash) end
        if not v.taken then
            EasterEggs[k] = CreateObject(hash, v.location.x, v.location.y, v.location.z, false, true, true)
            SetEntityAsMissionEntity(EasterEggs[k], true, true)
            FreezeEntityPosition(EasterEggs[k], true)
            SetEntityHeading(EasterEggs[k], v.heading)
            exports['qb-target']:AddTargetEntity(EasterEggs[k], {
                options = { {
                        icon = "fas fa-hand",
                        label = Config.text.pickupEgg,
                        action = function()
                            local playerPed = GetPlayerPed(-1)
                            local basketHash = GetHashKey('bzzz_event_easter_basket_b')
                            local boneIndex = GetPedBoneIndex(playerPed, PropBone)

                            if not Config.CheckBasketInHand or BasketInHand then
                                if IsPedInAnyVehicle(PlayerPedId()) then
                                    QBCore.Functions.Notify("You can't reach the easter egg..", "error")
                                else
                                    QBCore.Functions.Progressbar("pick_egg", Config.text.actionEgg, 2000, false, true, {
                                        disableMovement = true, disableCarMovement = true, disableMouse = false, disableCombat = true, },
                                        { animDict = 'amb@prop_human_bum_bin@idle_a', anim = 'idle_a', flags = 47, },
                                        {}, {}, function()
                                            TriggerServerEvent("eggs:pickupEgg", k)
                                            ClearPedTasks(playerPed)
                                        end, function() -- Cancel
                                            ClearPedTasks(playerPed)
                                        end)
                                end
                            else
                                QBCore.Functions.Notify("You don't have a basket in your hand..", "error")
                            end
                        end
                    }
                },
                distance = 3.0
            })
        end
    end
end)

RegisterNetEvent("eggs:client:buyBox")
AddEventHandler("eggs:client:buyBox", function(item)
    TriggerServerEvent("eggs:server:buyBox", item)
end)

RegisterNetEvent("eggs:client:openBox")
AddEventHandler("eggs:client:openBox", function(item)
    QBCore.Functions.Progressbar("open_box", Config.text.openBox, math.random(2000,3500), false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
		animDict = 'anim@gangops@facility@servers@',
		anim = 'hotwire',
		flags = 16,
	}, {}, {}, function() -- Done
        TriggerServerEvent("eggs:server:openBox", item)
        ClearPedTasks(PlayerPedId())
    end, function() -- Cancel
        ClearPedTasks(PlayerPedId())
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
     Wait(3000)
     LoadModel('bzzz_event_easter_egg_a')
     LoadModel('bzzz_event_easter_egg_b')
     LoadModel('bzzz_event_easter_egg_c')
     LoadModel('bzzz_event_easter_egg_d')
     LoadModel('bzzz_event_easter_egg_e')
     TriggerEvent('eggs:init')
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SetModelAsNoLongerNeeded(GetHashKey('bzzz_event_easter_egg_a'), GetHashKey('bzzz_event_easter_egg_b'), GetHashKey('bzzz_event_easter_egg_c'), GetHashKey('bzzz_event_easter_egg_e'))
        for k, v in pairs(EasterEggs) do
            if DoesEntityExist(v) then
                DeleteEntity(v) SetEntityAsNoLongerNeeded(v)
            end
        end
    end
end)
