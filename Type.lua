-- @author thunderbeast208 (xactlyblue)
-- @project Rocomponents
-- @file Type.lua

local Symbol = require(script.Parent.Symbol)

local Type = Symbol.new("Type")

local metatable = getmetatable(Type)
local registry = {}

local function makeSymbolFromName(name)
	return Symbol.new(("Type.%s"):format(name))
end

makeSymbolFromName("Component")
makeSymbolFromName("Cache")
makeSymbolFromName("Warning")
makeSymbolFromName("ComponentSettings")
makeSymbolFromName("ComponentLifetimePoint")
makeSymbolFromName("InternalFunctions")

function metatable:__index(index)
	return registry[index]
end

return Type
