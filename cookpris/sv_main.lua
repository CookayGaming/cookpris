local maxQuantity = 60 -- Maximum quantity of action
-- Commands
RegisterCommand('jail', function(source, args)
    if not args[1] or not args[2] then
		TriggerClientEvent("cookpris:notify", source, "~r~Error :~w~\nThe right command is /jail playerID qty", 3000)
	else
		local otherPlayerID = tonumber(args[1])
		local quantity = tonumber(args[2])
		if quantity > maxQuantity then quantity = maxQuantity end

		TriggerClientEvent("cookpris:setInJail", otherPlayerID, quantity)
		TriggerClientEvent("cookpris:notify", source, "~g~Done :~w~\n" .. GetPlayerName(otherPlayerID) .. " has been sent in jail", 3000)
	end
end, true)