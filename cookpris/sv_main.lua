-- Config
local maxQuantity = 60 -- Maximum quantity of action
local allowedList =
{
	"license:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX", -- Add any license over here
}


-- Functions
local function GetRockstarLicense(source)
	local license = ""
	for k,v in pairs(GetPlayerIdentifiers(source)) do
		if string.find(v, "license", 0) ~= nil then
			license = v
			return license
		end
	end
end


-- Commands
RegisterCommand('jail', function(source, args)
    if not args[1] or not args[2] then
		TriggerClientEvent("cookpris:notify", source, "~r~Error :~w~\nThe right command is /jail playerID qty", 3000)
	else
		local license = GetRockstarLicense(source)

		local isAllowed = false
		for k,v in pairs(allowedList) do
			if v == license then
				isAllowed = true
			end
		end

		if isAllowed then
			local otherPlayerID = tonumber(args[1])
			local quantity = tonumber(args[2])
			if quantity > maxQuantity then quantity = maxQuantity end

			TriggerClientEvent("cookpris:setInJail", otherPlayerID, quantity)
			TriggerClientEvent("cookpris:notify", source, "~g~Done :~w~\n" .. GetPlayerName(otherPlayerID) .. " has been sent in jail", 3000)
		else
			TriggerClientEvent("cookpris:notify", source, "~r~Error :~w~\nYou doesn't have the permissions", 3000)
		end
	end
end, false)