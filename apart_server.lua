require "resources/mysql-async/lib/MySQL"
local isBuy = 0

RegisterServerEvent("apart:getAppart")
AddEventHandler('apart:getAppart', function(name)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local name = name
 
    MySQL.Async.fetchAll("SELECT * FROM user_appartement WHERE name = @nom", {['@nom'] = tostring(name)}, function (result)
      if (result) then
        count = 0
        for _ in pairs(result) do
          count = count + 1
        end
        if count > 0 then
        	if (result[1].identifier == player) then
        		TriggerClientEvent('apart:isMine', source)
        	else
            	TriggerClientEvent('apart:isBuy', source)
        	end
        else
        	TriggerClientEvent('apart:isNotBuy', source)
        end
      end
    end)
  end)
end)

RegisterServerEvent("apart:buyAppart")
AddEventHandler('apart:buyAppart', function(name, price)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local name = name
    local price = price
    if (tonumber(user.money) >= tonumber(price)) then
        user:removeMoney((price))
    	MySQL.Async.execute("INSERT INTO user_appartement (`identifier`, `name`, `price`) VALUES (@username, @name, @price)", {['@username'] = player, ['@name'] = name, ['@price'] = price})
    	TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Stephane", false, "Bienvenue dans votre appartement!\n")
    	TriggerClientEvent('apart:isMine', source)
    else
    	TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Stephane", false, "Vous n'avez pas assez d'argent!\n")
    end
  end)
end)

RegisterServerEvent("apart:sellAppart")
AddEventHandler('apart:sellAppart', function(name, price)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local name = name
    local price = price/2
    user:addMoney((price))
        MySQL.Async.execute("DELETE from user_appartement WHERE identifier = @username AND name = @name",
        {['@username'] = player, ['@name'] = name})
      TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Stephane", false, "Appartement vendus!\n")
      TriggerClientEvent('apart:isNotBuy', source)
  end)
end)