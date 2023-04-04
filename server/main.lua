local QBCore = exports['qb-core']:GetCoreObject()
GlobalState.EasterEggs = Config.easterEggs

Citizen.CreateThread(function()
    for _, v in pairs(Config.easterEggs) do
        v.taken = false
    end

    for k, v in pairs(Config.easterBasket) do
        QBCore.Functions.CreateUseableItem(v.item, function(source)
            TriggerClientEvent("eggs:client:openBox", source, k)
        end)
    end
end)

QBCore.Functions.CreateUseableItem('easterbasket', function(source)
	TriggerClientEvent('eggs:basket', source) 
end)

function EggCooldown(loc)
    CreateThread(function()
        Wait(Config.respawnTime * 1000)
        Config.easterEggs[loc].taken = false
        GlobalState.EasterEggs = Config.easterEggs
        Wait(1000)
        TriggerClientEvent('eggs:respawnEgg', -1, loc)
    end)
end

RegisterNetEvent("eggs:pickupEgg")
AddEventHandler("eggs:pickupEgg", function(loc)
    if not Config.easterEggs[loc].taken then
        Config.easterEggs[loc].taken = true
        GlobalState.EasterEggs = Config.easterEggs
        TriggerClientEvent("eggs:removeEgg", -1, loc)
        EggCooldown(loc)
        local Player = QBCore.Functions.GetPlayer(source)
        local item = math.random(1, #Config.CuReward)
        local amount = math.random(Config.CuReward[item]["amount"], Config.CuReward[item]["amount"])
        if Player.Functions.AddItem(Config.CuReward[item]["item"], amount) then
            TriggerClientEvent('inventory:client:ItemBox', source,  QBCore.Shared.Items[Config.CuReward[item]["item"]], 'add')
    end
  end
end)

RegisterNetEvent("eggs:server:buyBox")
AddEventHandler("eggs:server:buyBox", function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(source)
    local cost = Config.easterBasket[item].cost
    local totalItems = 0

    for _, reward in ipairs(Config.CuReward) do
        local items = Player.Functions.GetItemsByName(reward.item)
        for _, invItem in ipairs(items) do
            if invItem ~= nil and invItem.amount >= reward.amount then
                totalItems = totalItems + invItem.amount
            end
        end
    end

    if totalItems >= cost then
        for _, reward in ipairs(Config.CuReward) do
            local items = Player.Functions.GetItemsByName(reward.item)
            local remainingCost = cost
            for _, invItem in ipairs(items) do
                if remainingCost > 0 then
                    local removeAmount = math.min(remainingCost, invItem.amount)
                    Player.Functions.RemoveItem(invItem.name, removeAmount)
                    remainingCost = remainingCost - removeAmount
                end
            end
        end
        Player.Functions.AddItem(Config.easterBasket[item].item, 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Config.easterBasket[item].item], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have enough eggs", "error", 2500)
    end
end)

RegisterNetEvent("eggs:server:openBox")
AddEventHandler("eggs:server:openBox", function(i)
    local Player = QBCore.Functions.GetPlayer(source)
    local invItem = Player.Functions.GetItemByName(Config.easterBasket[i].item)

    if invItem ~= nil and invItem.amount >= 1 then
        local reward = Config.easterBasket[i].rewards[math.random(1, #Config.easterBasket[i].rewards)]
        Player.Functions.RemoveItem(Config.easterBasket[i].item, 1)
        Player.Functions.AddItem(reward.item, reward.amount)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[reward.item], "add")
    end
end)
