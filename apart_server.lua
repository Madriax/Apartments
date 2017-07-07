---------------------------
------CHOSE SQL MODE-------
---------------------------
--Async   -----------------
--MySQL   -----------------
--Couchdb ----------------- (soon)
---------------------------
local mode = "Async"

if (mode == "Async") then
  require "resources/mysql-async/lib/MySQL"
elseif mode == "MySQL" then
  --require "resources/[essential]/essentialmode/lib/MySQL" IF YOU'RE USING LALIFE SCRIPT !
  require "resources/essentialmode/lib/MySQL"

  --DO NOT FORGET TO CHANGE THE LINE BELLOW !!!
  MySQL:open("localhost", "gta5_gamemode_essential", "root", "Police911")
end


local lang = 'en'
local txt = {
  	['fr'] = {
        ['welcome'] = 'Bienvenue dans votre appartement!\n',
        ['nocash'] = 'Vous n\'avez pas assez d\'argent!\n',
        ['estVendu'] = 'Appartement vendus!\n'
  },

    ['en'] = {
        ['welcome'] = 'Welcome to home!\n',
        ['nocash'] = 'You d\'ont have enough cash!\n',
        ['estVendu'] = 'Apartment sold!\n'
    }
}


local isBuy = 0
local money = 0
local dirtymoney = 0

RegisterServerEvent("apart:getAppart")
AddEventHandler('apart:getAppart', function(name)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local name = name
    if (mode == "Async") then
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
    elseif mode == "MySQL" then
      local executed_query = MySQL:executeQuery("SELECT * FROM user_appartement WHERE name = @nom", {['@nom'] = tostring(name)})
      local result = MySQL:getResults(executed_query, {'identifier'})
      if (result) then
        count = 0
        for _ in pairs(result) do
          count = count +1
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
    end
  end)
end)

RegisterServerEvent("apart:getCash")
AddEventHandler('apart:getCash', function(name)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local name = name
    if (mode == "Async") then
      MySQL.Async.fetchAll("SELECT * FROM user_appartement WHERE name = @nom", {['@nom'] = tostring(name)}, function (result)
        if (result) then
          money = result[1].money
          dirtymoney = result[1].dirtymoney
          TriggerClientEvent('apart:getCash', source, money, dirtymoney)
        end
      end)
    elseif mode == "MySQL" then
      local executed_query = MySQL:executeQuery("SELECT * FROM user_appartement WHERE name = @nom", {['@nom'] = tostring(name)})
      local result = MySQL:getResults(executed_query, {'identifier'})
      if (result) then
        money = result[1].money
        dirtymoney = result[1].dirtymoney
        TriggerClientEvent('apart:getCash', source, money, dirtymoney)
      end
    end
  end)
end)

RegisterServerEvent("apart:depositcash")
AddEventHandler('apart:depositcash', function(cash, apart)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local money = 0
    if (tonumber(user.money) >= tonumber(cash) and tonumber(cash) > 0) then
      if mode == "Async" then
        MySQL.Async.fetchAll("SELECT money FROM user_appartement WHERE name = @nom", {['@nom'] = apart}, function (result)
            if (result) then
              money = result[1].money
              user:removeMoney((cash))
              local newmoney = money + cash
              MySQL.Async.execute("UPDATE user_appartement SET `money`=@cash WHERE name = @nom",{['@cash'] = newmoney, ['@nom'] = apart}, function(data)
              end)
            end
        end)
      elseif mode == "MySQL" then
        local executed_query = MySQL:executeQuery("SELECT money FROM user_appartement WHERE name = @nom", {['@nom'] = apart})
        local result = MySQL:getResults(executed_query, {'money'})
        if (result) then
          money = result[1].money
          user:removeMoney((cash))
          local newmoney = money + cash
          MySQL:executeQuery("UPDATE user_appartement SET `money`=@cash WHERE name = @nom",{['@cash'] = newmoney, ['@nom'] = apart})
        end
      end

      TriggerClientEvent('apart:getCash', source, money, dirtymoney)
    else
      -- TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['nocash']) --(FOR FREEROAM)
      TriggerClientEvent("citizenv:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['nocash']) --WITH LALIFE SCRIPTS
    end
  end)
end)

RegisterServerEvent("apart:depositdirtycash")
AddEventHandler('apart:depositdirtycash', function(cash, apart)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local money = 0
    if (tonumber(user:getDMoney()) >= tonumber(cash) and tonumber(cash) > 0) then
      if mode == "Async" then
        MySQL.Async.fetchAll("SELECT dirtymoney FROM user_appartement WHERE name = @nom", {['@nom'] = apart}, function (result)
            if (result) then
              money = result[1].dirtymoney
              user:removeDMoney((cash))
              local newmoney = money + cash
              MySQL.Async.execute("UPDATE user_appartement SET `dirtymoney`=@cash WHERE name = @nom",{['@cash'] = newmoney, ['@nom'] = apart}, function(data)
              end)
            end
        end)
      elseif mode == "MySQL" then
        local executed_query = MySQL:executeQuery("SELECT dirtymoney FROM user_appartement WHERE name = @nom", {['@nom'] = apart})
        local result = MySQL:getResults(executed_query, {'dirtymoney'})
        if (result) then
          money = result[1].dirtymoney
          user:removeDMoney((cash))
          local newmoney = money + cash
          MySQL:executeQuery("UPDATE user_appartement SET `dirtymoney`=@cash WHERE name = @nom",{['@cash'] = newmoney, ['@nom'] = apart})
        end
      end

      TriggerClientEvent('apart:getCash', source, money, dirtymoney)
    else
      -- TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['nocash']) --(FOR FREEROAM)
      TriggerClientEvent("citizenv:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['nocash']) --WITH LALIFE SCRIPTS
    end
  end)
end)

RegisterServerEvent("apart:takecash")
AddEventHandler('apart:takecash', function(cash, apart)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local money = 0
    if mode == "Async" then
      MySQL.Async.fetchAll("SELECT money FROM user_appartement WHERE name = @nom", {['@nom'] = apart}, function (result)
          if (result) then
            money = result[1].money
            if (tonumber(cash) <= tonumber(money) and tonumber(cash) > 0) then
              user:addMoney((cash))
              local newmoney = money - cash
              MySQL.Async.execute("UPDATE user_appartement SET `money`=@cash WHERE name = @nom",{['@cash'] = newmoney, ['@nom'] = apart}, function(data)
              end)
            else
              -- TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['nocash']) --(FOR FREEROAM)
              TriggerClientEvent("citizenv:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['nocash']) --WITH LALIFE SCRIPTS
            end
          end
      end)
    elseif mode == "MySQL" then
      local executed_query = MySQL:executeQuery("SELECT money FROM user_appartement WHERE name = @nom", {['@nom'] = apart})
      local result = MySQL:getResults(executed_query, {'money'})
      if (result) then
        money = result[1].money
        if (tonumber(cash) <= tonumber(money) and tonumber(cash) > 0) then
          user:addMoney((cash))
          local newmoney = money - cash
          MySQL:executeQuery("UPDATE user_appartement SET `money`=@cash WHERE name = @nom",{['@cash'] = newmoney, ['@nom'] = apart})
        else
          -- TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['nocash']) --(FOR FREEROAM)
          TriggerClientEvent("citizenv:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['nocash']) --WITH LALIFE SCRIPTS
        end
      end
    end

    TriggerClientEvent('apart:getCash', source, money, dirtymoney)
  end)
end)

RegisterServerEvent("apart:takedirtycash")
AddEventHandler('apart:takedirtycash', function(cash, apart)
  TriggerEvent('es:getPlayerFromId', source, function(user)
    local player = user.identifier
    local money = 0
    if mode == "Async" then
      MySQL.Async.fetchAll("SELECT dirtymoney FROM user_appartement WHERE name = @nom", {['@nom'] = apart}, function (result)
          if (result) then
            money = result[1].money
            if (tonumber(cash) <= tonumber(money) and tonumber(cash) > 0) then
              user:addDMoney((cash))
              local newmoney = money - cash
              MySQL.Async.execute("UPDATE user_appartement SET `dirtymoney`=@cash WHERE name = @nom",{['@cash'] = newmoney, ['@nom'] = apart}, function(data)
              end)
            else
              -- TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['nocash']) --(FOR FREEROAM)
              TriggerClientEvent("citizenv:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['nocash']) --WITH LALIFE SCRIPTS
            end
          end
      end)
    elseif mode == "MySQL" then
      local executed_query = MySQL:executeQuery("SELECT dirtymoney FROM user_appartement WHERE name = @nom", {['@nom'] = apart})
      local result = MySQL:getResults(executed_query, {'dirtymoney'})
      if (result) then
        money = result[1].money
        if (tonumber(cash) <= tonumber(money) and tonumber(cash) > 0) then
          user:addDMoney((cash))
          local newmoney = money - cash
          MySQL:executeQuery("UPDATE user_appartement SET `dirtymoney`=@cash WHERE name = @nom",{['@cash'] = newmoney, ['@nom'] = apart})
        else
          -- TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['nocash']) --(FOR FREEROAM)
          TriggerClientEvent("citizenv:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['nocash']) --WITH LALIFE SCRIPTS
        end
      end
    end

    TriggerClientEvent('apart:getCash', source, money, dirtymoney)
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
      if (mode == "Async") then
    	  MySQL.Async.execute("INSERT INTO user_appartement (`identifier`, `name`, `price`) VALUES (@username, @name, @price)", {['@username'] = player, ['@name'] = name, ['@price'] = price})
      elseif mode == "MySQL" then
        local executed_query2 = MySQL:executeQuery("INSERT INTO user_appartement (`identifier`, `name`, `price`) VALUES (@username, @name, @price)", {['@username'] = player, ['@name'] = name, ['@price'] = price})
      end
      -- TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['welcome']) --(FOR FREEROAM)
    	TriggerClientEvent("citizenv:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['welcome']) --WITH LALIFE SCRIPTS
    	TriggerClientEvent('apart:isMine', source)
    else
    	-- TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['nocash']) --(FOR FREEROAM)
    	TriggerClientEvent("citizenv:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['nocash']) --WITH LALIFE SCRIPTS
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
      if (mode == "Async") then
        MySQL.Async.execute("DELETE from user_appartement WHERE identifier = @username AND name = @name",
        {['@username'] = player, ['@name'] = name})
      elseif mode == "MySQL" then
        local executed_query3 = MySQL:executeQuery("DELETE from user_appartement WHERE identifier = @username AND name = @name",
        {['@username'] = player, ['@name'] = name})
      end
      -- TriggerClientEvent("es_freeroam:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['estVendu']) --(FOR FREEROAM)
      TriggerClientEvent("citizenv:notify", source, "CHAR_SIMEON", 1, "Stephane", false, txt[lang]['estVendu']) --WITH LALIFE SCRIPTS
      TriggerClientEvent('apart:isNotBuy', source)
  end)
end)