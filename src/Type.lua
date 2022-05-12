-- @author thunderbeast208 (xactlyblue)
-- @project Rocomponents
-- @file Type.lua

local Symbol = require(script.Parent.Symbol)

local Type = Symbol.new("Type")

local registry = {}

local function createSymbol(name)
	registry[name] = Symbol.new(("Type.%s"):format(name))
end

createSymbol("Component")
createSymbol("Cache")
createSymbol("Warning")
createSymbol("ComponentSettings")
createSymbol("ComponentLifetimePoint")
createSymbol("InternalFunctions")

getmetatable(Type).__index = registry

return Type
