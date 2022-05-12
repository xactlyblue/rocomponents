-- @author thunderbeast208 (xactlyblue)
-- @project Rocomponents
-- @file ComponentSettings.lua

local Type = require(script.Parent.Type)
local Warnings = require(script.Parent.Warnings)

local ComponentSettings = {}

function ComponentSettings.extend(arguments, bindableTo)
	if typeof(arguments) ~= "table" then
		local message = "Invalid arguments given during an attempt to build a component settings instance! (%s)"

		Warnings.dispatchWarning(Warnings.makeWarning(message), typeof(arguments))
		return nil
	else
		if #arguments ~= 0 then
			return
		end
	end
	
	for i, v in pairs(arguments) do
		if typeof(i) ~= "string" or typeof(v) ~= "string" then
			Warnings.dispatchWarning(Warnings.makeWarning("Expected a dictionary of index/value pairs of strings in order to match types.")) 
			
			return nil
		end
	end
			
	return {
		[Type] = Type.ComponentSettings,

		arguments = arguments,
	}
end

function ComponentSettings.matchAgainst(arguments, componentSettings)
	for index, value in pairs(arguments) do
		if typeof(index) ~= "string" then
			return false
		end

		local relativeValue = componentSettings.arguments[index]

		if typeof(relativeValue) == "nil" then
			return false
		end
		
		if (typeof(value) ~= relativeValue) then
			return false
		end
	end
	
	return true
end

return ComponentSettings
