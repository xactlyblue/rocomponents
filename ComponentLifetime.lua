-- @author thunderbeast208 (xactlyblue)
-- @project Rocomponents
-- @file ComponenLifetime.lua

local Type = require(script.Parent.Type)
local Symbol = require(script.Parent.Symbol)

local Name = Symbol.new("ComponentLifetimePointName") 

return {
	Idle = {
		[Name] = "Idle",
		[Type] = Type.ComponentLifetimePoint,
	},
	Binding = {
		[Name] = "Binding",
		[Type] = Type.ComponentLifetimePoint,
	},
	Unbinding = {
		[Name] = "Unbinding",
		[Type] = Type.ComponentLifetimePoint,
	},
	CleaningUp = {
		[Name] = "CleaningUp",
		[Type] = Type.ComponentLifetimePoint,
	},
	Nonexistant = {
		[Name] = "Nonexistant",
		[Type] = Type.ComponentLifetimePoint,
	}
}
