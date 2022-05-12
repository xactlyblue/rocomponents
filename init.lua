-- @author thunderbeast208 (xactlyblue)
-- @project Rocomponents
-- @file init.lua

local Component = require(script.Component)
local ComponentSettings = require(script.ComponentSettings)
local ComponentLifetime = require(script.ComponentLifetime)
local Symbol = require(script.Symbol)
local Cache = require(script.Cache)
local Type = require(script.Type)
local Warnings = require(script.Warnings)

local function bindComponent(componentClass, bindingTo, arguments)
	local invalidArgumentsMessage = "Invalid arguments provided! (Expected: componentClass (string), bindingTo (Instance), arguments (dictionary/table))"
	local invalidArgumentsWarning = Warnings.makeWarning(invalidArgumentsMessage)

	if typeof(componentClass) ~= "table" then
		Warnings.dispatchWarning(invalidArgumentsWarning)
		return
	else

	end
	
	local component = componentClass.new(arguments)
	
	return Component[Type.InternalFunctions].__bind(component, bindingTo)
end

local function unbindComponent(component)
	return Component[Type.InternalFunctions].__unbind(component)
end

return {
	Component = Component,
	ComponentSettings = ComponentSettings,
	ComponentLifetime = ComponentLifetime,
	Symbol = Symbol,
	Cache = Cache,
	
	bindComponent = bindComponent,	
	unbindComponent = unbindComponent,
}
