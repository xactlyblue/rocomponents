-- @author thunderbeast208 (xactlyblue)
-- @project Rocomponents
-- @file Warnings.lua

local Type = require(script.Parent.Type)
local Warning = {
	[Type] = Type.Warning
}

function Warning.new(message)
	return setmetatable({
		message = message,
	}, {
		__index = Warning,
	})
end

local function makeWarning(message)
	return Warning.new(message)
end

local function dispatchWarning(warning, ...)
	if typeof(warning) ~= "table" then
		return
	else
		if (warning[Type] ~= Type.Warning) then
			return
		end
	end
	
	local appendedWarning = ("[Routilities] " .. (warning.message):format(...))
	
	warn(appendedWarning)
end	
	
return {
	makeWarning = makeWarning,
	dispatchWarning = dispatchWarning,
}
