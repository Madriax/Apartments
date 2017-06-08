local interiors = {}
local entrer = false
local isBuy = 0
 
distance = 50.5999 -- distance to draw
timer = 0
current_int = 0
 
AddEventHandler("playerSpawned", function()
  TriggerServerEvent("apart:sendData_s")
end)
 
-- Active this when you restart resource. If you don't want to close the server
TriggerServerEvent("apart:sendData_s")
 
RegisterNetEvent("apart:f_sendData")
AddEventHandler("apart:f_sendData", function(t1)
    -- Tyler1 my boy
  interiors = t1
end)
 
RegisterNetEvent("apart:isBuy")
AddEventHandler("apart:isBuy", function()
  isBuy = 1
end)
 
RegisterNetEvent("apart:isNotBuy")
AddEventHandler("apart:isNotBuy", function()
  isBuy = 0
end)

RegisterNetEvent("apart:isMine")
AddEventHandler("apart:isMine", function()
  isBuy = 2
end)

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(sc, sc)
        N_0x4e096588b13ffeca(jus)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - 0.1+w, y - 0.02+h)
end
 
function drawTxt(text,font,centre,x,y,scale,r,g,b,a)
    SetTextFont(font)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(centre)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x , y)
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end
 
function MenuAppartement()
    ped = GetPlayerPed(-1);
    MenuTitle = "Appartement"
    ClearMenu()
 
    for i=1, #interiors do
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xe,interiors[i].ye,interiors[i].ze, true) < distance then
            DrawMarker(1,interiors[i].xe,interiors[i].ye,interiors[i].ze-1.0001, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 212, 189, 0, 105, 0, 0, 2, 0, 0, 0, 0)
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xe,interiors[i].ye,interiors[i].ze, true) < 1.599 then
                TriggerServerEvent("apart:getAppart", interiors[i].name)
                Wait(250)
                if isBuy == 1 then
                	Menu.addButton("Sonner a la porte","Sonner",nil)
                elseif isBuy == 2 then
                	Menu.addButton("Rentrer chez moi","Visiter",nil)
                	Menu.addButton("Revendre l'appartement","Vendre",nil)
                else
                	Menu.addButton("Acheter l'appartement","Acheter",nil)
                    Menu.addButton("Visiter l'appartement","Visiter",nil)
                end
                Menu.addButton("Fermer le menu","CloseMenu",nil)
            end
        end
    end
end
 
function CloseMenu()
    Menu.hidden = true    
end

function Sonner()
	drawNotification('Cette fonctionnalite arrivera tres vite')
end

function Vendre()
	for i=1, #interiors do
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xe,interiors[i].ye,interiors[i].ze, true) < distance then
            DrawMarker(1,interiors[i].xe,interiors[i].ye,interiors[i].ze-1.0001, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 212, 189, 0, 105, 0, 0, 2, 0, 0, 0, 0)
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xe,interiors[i].ye,interiors[i].ze, true) < 1.599 then
                TriggerServerEvent("apart:sellAppart", interiors[i].name, interiors[i].price)
                CloseMenu()
            end
        end
    end
end

function Acheter()
	-- drawNotification('Cette fonctionnalite arrivera tres vite')
	for i=1, #interiors do
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xe,interiors[i].ye,interiors[i].ze, true) < distance then
            DrawMarker(1,interiors[i].xe,interiors[i].ye,interiors[i].ze-1.0001, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 212, 189, 0, 105, 0, 0, 2, 0, 0, 0, 0)
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xe,interiors[i].ye,interiors[i].ze, true) < 1.599 then
                TriggerServerEvent("apart:buyAppart", interiors[i].name, interiors[i].price)
                CloseMenu()
            end
        end
    end
end
 
function Visiter(i)
    for i=1, #interiors do
        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xe,interiors[i].ye,interiors[i].ze, true) < distance then
            DrawMarker(1,interiors[i].xe,interiors[i].ye,interiors[i].ze-1.0001, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 212, 189, 0, 105, 0, 0, 2, 0, 0, 0, 0)
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xe,interiors[i].ye,interiors[i].ze, true) < 1.599 then
                if timer == 0 then
                    DoScreenFadeOut(1000)
                    while IsScreenFadingOut() do Citizen.Wait(0) end
                    NetworkFadeOutEntity(GetPlayerPed(-1), true, false)
                    Wait(1000)
                    SetEntityCoords(GetPlayerPed(-1), interiors[i].xo,interiors[i].yo,interiors[i].zo)
                    SetEntityHeading(GetPlayerPed(-1), interiors[i].ho)
                    NetworkFadeInEntity(GetPlayerPed(-1), 0)
                    Wait(1000)
                    current_int = i
                    timer = 5
                    SimulatePlayerInputGait(PlayerId(), 1.0, 100, 1.0, 1, 0)
                    DoScreenFadeIn(1000)
                    Menu.hidden = true
                    while IsScreenFadingIn() do Citizen.Wait(0) end
                end
            end
        end
    end
end
 
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            if timer > 0 and current_int > 0 then DrawAdvancedText(0.707, 0.77, 0.005, 0.0028, 1.89, "~b~"..interiors[current_int].name, 255, 255, 255, 255, 1, 1) end
            for i=1, #interiors do
                if not IsEntityDead(PlayerPedId()) then
                    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xe,interiors[i].ye,interiors[i].ze, true) < distance then
                        DrawMarker(1,interiors[i].xe,interiors[i].ye,interiors[i].ze-1.0001, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 212, 189, 0, 105, 0, 0, 2, 0, 0, 0, 0)
                        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xe,interiors[i].ye,interiors[i].ze, true) < 1.599 then
                            drawTxt('Appuyez sur ~g~E~s~ pour ouvrir le menu',0,1,0.5,0.8,0.6,255,255,255,255)
                            if IsControlJustPressed(1, 86) then
                                MenuAppartement()
                                Menu.hidden = not Menu.hidden
                            end
                            Menu.renderGUI()
                        end
                    end
                    if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xo,interiors[i].yo,interiors[i].zo, true) < distance then
                        DrawMarker(1,interiors[i].xo,interiors[i].yo,interiors[i].zo-1.0001, 0, 0, 0, 0, 0, 0, 1.01, 1.01, 0.3, 212, 189, 0, 105, 0, 0, 2, 0, 0, 0, 0)
                        if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), interiors[i].xo,interiors[i].yo,interiors[i].zo, true) < 1.599 then
                            if timer == 0 then
                                DoScreenFadeOut(1000)
                                while IsScreenFadingOut() do Citizen.Wait(0) end
                                NetworkFadeOutEntity(GetPlayerPed(-1), true, false)
                                Wait(1000)
                                SetEntityCoords(GetPlayerPed(-1), interiors[i].xe,interiors[i].ye,interiors[i].ze)
                                SetEntityHeading(GetPlayerPed(-1), interiors[i].ho)
                                NetworkFadeInEntity(GetPlayerPed(-1), 0)
                                Wait(1000)
                                current_int = i
                                timer = 5
                                SimulatePlayerInputGait(PlayerId(), 1.0, 100, 1.0, 1, 0)
                                DoScreenFadeIn(1000)
                                while IsScreenFadingIn() do Citizen.Wait(0) end
                            end
                        end
                    end
                end
            end
    end
end)
 
Citizen.CreateThread(function()
    while true do
        Wait(1000)
        if timer > 0 then
            timer=timer-1
            if timer == 0 then current_int = 0 end
        end
    end
end)