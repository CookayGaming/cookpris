-- Config

local maxActions

-- Coords
local jailCoords = {x = 1643.38, y = 2529.35, z = 45.5}
local stuckCoords = {x = 223.7026, y = -790.25, z = 30.72}
local jailRadius = 12.0

-- Translation
local endMessage = "You are done, welcome back to the real world but calm down for a bit"
local doingPrefix = "Come on, move on !\n"
local doingSuffix = " and you are good to go !"

-- Actions
local jailActionCoords =
{
	{ label = "Weights",			duration = 10000, scenario = "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS", x = 1642.7225341796,	y = 2524.0556640625,	z = 44.56489944458,		h = 230.86309},
	{ label = "Weights",			duration = 10000, scenario = "WORLD_HUMAN_MUSCLE_FREE_WEIGHTS", x = 1646.622680664,		y = 2535.8493652344,	z = 44.564876556396,	h = 50.930492},
	{ label = "Pushups",			duration = 10000, scenario = "WORLD_HUMAN_PUSH_UPS",			x = 1636.439819336,		y = 2528.7370605468,	z = 44.56489944458,		h = 53.6525192},
	{ label = "Pushups",			duration = 10000, scenario = "WORLD_HUMAN_PUSH_UPS",			x = 1638.8117675782,	y = 2531.6665039062,	z = 44.56489944458,		h = 48.541206},
	{ label = "Pushups",			duration = 10000, scenario = "WORLD_HUMAN_PUSH_UPS",			x = 1641.2742919922,	y = 2534.4873046875,	z = 44.56489944458,		h = 52.171966},
	{ label = "Do crunch abs",		duration = 10000, scenario = "WORLD_HUMAN_SIT_UPS",				x = 1638.9910888672,	y = 2521.1713867188,	z = 44.56489944458,		h = 47.997913},
	{ label = "Do crunch abs",		duration = 10000, scenario = "WORLD_HUMAN_SIT_UPS",				x = 1641.4490966796,	y = 2519.3046875,		z = 44.56489944458,		h = 231.47094726},
	{ label = "Do crunch abs",		duration = 10000, scenario = "WORLD_HUMAN_SIT_UPS",				x = 1642.8138427734,	y = 2520.8374023438,	z = 44.56489944458,		h = 237.37298},
	{ label = "Do crunch abs",		duration = 10000, scenario = "WORLD_HUMAN_SIT_UPS",				x = 1638.5084228516,	y = 2524.1552734375,	z = 44.56489944458,		h = 147.60180},
	{ label = "Do crunch abs",		duration = 10000, scenario = "WORLD_HUMAN_SIT_UPS",				x = 1637.407836914,		y = 2522.583984375,		z = 44.56489944458,		h = 143.7697906},
	{ label = "Yoga",				duration = 10000, scenario = "WORLD_HUMAN_YOGA",				x = 1649.8255615234,	y = 2532.7043457032,	z = 44.564865112304,	h = 230.25950622},
	{ label = "Yoga",				duration = 10000, scenario = "WORLD_HUMAN_YOGA",				x = 1648.7510986328,	y = 2531.3874511718,	z = 44.564865112304,	h = 234.14630126},
	{ label = "Yoga",				duration = 10000, scenario = "WORLD_HUMAN_YOGA",				x = 1647.7794189454,	y = 2530.0014648438,	z = 44.564865112304,	h = 231.44407653},
	{ label = "Yoga",				duration = 10000, scenario = "WORLD_HUMAN_YOGA",				x = 1646.579711914,		y = 2531.8999023438,	z = 44.564865112304,	h = 58.9713706970},
	{ label = "Jogging",			duration = 10000, scenario = "WORLD_HUMAN_JOG_STANDING",		x = 1648.0295410156,	y = 2526.6865234375,	z = 44.564865112304,	h = 232.7815246582},
	{ label = "Jogging",			duration = 10000, scenario = "WORLD_HUMAN_JOG_STANDING",		x = 1647.1231689454,	y = 2525.3095703125,	z = 44.564865112304,	h = 232.14538574218},
	{ label = "Jogging",			duration = 10000, scenario = "WORLD_HUMAN_JOG_STANDING",		x = 1646.1625976562,	y = 2523.9912109375,	z = 44.564865112304,	h = 229.96112060546},
	{ label = "Jogging",			duration = 10000, scenario = "WORLD_HUMAN_JOG_STANDING",		x = 1644.8634033204,	y = 2527.0524902344,	z = 44.564865112304,	h = 50.926918029786},
	{ label = "Jogging",			duration = 10000, scenario = "WORLD_HUMAN_JOG_STANDING",		x = 1646.2060546875,	y = 2528.70703125,		z = 44.564865112304,	h = 54.375495910644},
	{ label = "Jogging",			duration = 10000, scenario = "WORLD_HUMAN_JOG_STANDING",		x = 1647.3669433594,	y = 2530.5427246094,	z = 44.564865112304,	h = 53.448127746582},
	{ label = "Sweep the floor",	duration = 10000, scenario = "WORLD_HUMAN_JANITOR",				x = 1641.8232421875,	y = 2529.7856445312,	z = 44.564865112304,	h = 143.40534973144},
	{ label = "Sweep the floor",	duration = 10000, scenario = "WORLD_HUMAN_JANITOR",				x = 1639.9923095704,	y = 2526.69140625,		z = 44.564865112304,	h = 141.42027282714},
	{ label = "Sweep the floor",	duration = 10000, scenario = "WORLD_HUMAN_JANITOR",				x = 1634.2058105468,	y = 2525.2036132812,	z = 44.564865112304,	h = 53.950496673584},
}


-- Variables 
local isInJail = false
local currentAction = 0
local isDoingAction = false
local nActionLeft = nActionNeeded
local initialCoords = nil


-- Functions
local function DrawText3D(x,y,z, text, r,g,b) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
	scale = scale * 1.0
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(r, g, b, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

local function newNotif(message, duration)
	Citizen.CreateThread(function()
		SetNotificationTextEntry("STRING")
		AddTextComponentSubstringPlayerName(message)
		if duration then 
		local Notification = DrawNotification(true, true)
		Citizen.Wait(duration)
		RemoveNotification(Notification)
		else DrawNotification(false, false) end
	end)
end

local function ExitJail()
	currentAction = 0
	isInJail = false
	isDoingAction = false
	nActionLeft = nActionNeeded

	local distanceFromJail = GetDistanceBetweenCoords(jailCoords.x, jailCoords.y, jailCoords.z, initialCoords.x, initialCoords.y, initialCoords.z, true)
	if distanceFromJail < 50.0 then
		initialCoords = stuckCoords
	end

	SetEntityCoords(GetPlayerPed(-1), initialCoords.x, initialCoords.y, initialCoords.z, 0, 0, 0, 0)
	newNotif(endMessage, 6000)
	SetEntityInvincible(GetPlayerPed(-1), false)
end


local function SetPedInJail()
	SetEntityInvincible(GetPlayerPed(-1), true)
	local newCoords = {x = jailCoords.x + (math.random(1, 5) * 1.0), y = jailCoords.y + (math.random(1, 5) * 1.0), z = jailCoords.z}
	SetEntityCoords(GetPlayerPed(-1), newCoords.x, newCoords.y, newCoords.z, 0, 0, 0, 0)
end

local function IsPedOutOfJail(currentPos)
	local distanceFromJail = GetDistanceBetweenCoords(jailCoords.x, jailCoords.y, jailCoords.z, currentPos.x, currentPos.y, currentPos.z, true)
	if distanceFromJail > jailRadius then
		return true
	else
		return false
	end
end

local function IsPedNearAction(currentPos)
	local distanceFromCurrentAction = GetDistanceBetweenCoords(jailActionCoords[currentAction].x, jailActionCoords[currentAction].y, jailActionCoords[currentAction].z, currentPos.x, currentPos.y, currentPos.z, true)
	if distanceFromCurrentAction < 2.0 then
		return true
	else
		return false
	end
end

local function SetNewAction()
	local randomNewAction = math.random(1, #jailActionCoords)
	if currentAction ~= 0 then
		local distBetweenOldAndNewActions = GetDistanceBetweenCoords(jailActionCoords[currentAction].x, jailActionCoords[currentAction].y, jailActionCoords[currentAction].z, jailActionCoords[randomNewAction].x, jailActionCoords[randomNewAction].y, jailActionCoords[randomNewAction].z, true)
		while distBetweenOldAndNewActions < 5.0 do
			randomNewAction = math.random(1, #jailActionCoords)
			distBetweenOldAndNewActions = GetDistanceBetweenCoords(jailActionCoords[currentAction].x, jailActionCoords[currentAction].y, jailActionCoords[currentAction].z, jailActionCoords[randomNewAction].x, jailActionCoords[randomNewAction].y, jailActionCoords[randomNewAction].z, true)
		end
	end

	newNotif(doingPrefix .. nActionLeft .. "/" .. nActionNeeded .. doingSuffix, 5000)
	currentAction = randomNewAction
end

local function OnActionEnd()
	ClearPedTasks(GetPlayerPed(-1))
	nActionLeft = nActionLeft - 1
	if nActionLeft <= 0 then
		ExitJail()
	else
		SetNewAction()
	end
end


-- Loops
-- System
Citizen.CreateThread(function()
	Citizen.Wait(3000)

    while true do
        Citizen.Wait(0)

        if isInJail then
			local currentPos = GetEntityCoords(GetPlayerPed(-1))

			if IsPedNearAction(currentPos) then
				isDoingAction = true
				TaskStartScenarioInPlace(GetPlayerPed(-1), jailActionCoords[currentAction].scenario, 0, true)
				Citizen.Wait(jailActionCoords[currentAction].duration)
				OnActionEnd()
				isDoingAction = false
			end
			
			if IsPedOutOfJail(currentPos) then
				SetPedInJail()
			end

			Citizen.Wait(0)
        else
			local currentPos = GetEntityCoords(GetPlayerPed(-1))
			if not IsPedOutOfJail(currentPos) then
				TriggerEvent("cookpris:setInJail", maxActions)
			end

            Citizen.Wait(1000)
        end
    end
end)

-- Display
Citizen.CreateThread(function ()
	while true do
		if currentAction > 0 and not isDoingAction then
			DrawText3D(jailActionCoords[currentAction].x, jailActionCoords[currentAction].y, jailActionCoords[currentAction].z + 1.0, "[~g~Action~w~] ~g~" .. jailActionCoords[currentAction].label .. "~w~", 255, 255, 255)
			Citizen.Wait(0)
		else
			Citizen.Wait(500)
		end
	end
end)


-- Events
RegisterNetEvent("cookpris:setInJail")
AddEventHandler("cookpris:setInJail", function(lNewNeeded)
	nActionNeeded = lNewNeeded
	nActionLeft = nActionNeeded

	initialCoords = GetEntityCoords(GetPlayerPed(-1))

	-- TODO: Here you might want to save server coords on the server side (in case of a quit before the server store new coords)

	isInJail = true
	SetPedInJail()
	SetNewAction()
end)

RegisterNetEvent("cookpris:notify")
AddEventHandler("cookpris:notify", function(message, duration)
	newNotif(message, duration)
end)