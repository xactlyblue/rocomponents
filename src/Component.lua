-- @author thunderbeast208 (xactlyblue)
-- @project Rocomponents
-- @file Component.lua

local Type = require(script.Parent.Type)
local Symbol = require(script.Parent.Symbol)
local ComponentSettings = require(script.Parent.ComponentSettings)
local Warnings = require(script.Parent.Warnings)
local Cache = require(script.Parent.Cache)
local ComponentLifetime = require(script.Parent.ComponentLifetime)

local DefaultComponentSettings

local Component = {}
Component.__index = Component

local InternalComponentData = Symbol.new("InternalComponentData")
local Super = Symbol.new("Super")

local httpService = game:GetService("HttpService")

local internalComponentFunctions = Component[Type.InternalComponentFunctions]

function Component:init()
	Warnings.dispatchWarning(Warnings.makeWarning("Component::init has not been overriden. Please make sure to override the initialization function of components."))
	return
end

function Component:onBinded(bindedTo)
	Warnings.dispatchWarning(Warnings.makeWarning("Component::onBinded has not been overriden. Please make sure to override the initialization function of components."))
	return
end

function Component:onUnbinding()
	Warnings.dispatchWarning(Warnings.makeWarning("Component::onUnbinded has not been overriden. Please make sure to override the initialization function of components."))
	return
end

function Component:onCleanup()
	Warnings.dispatchWarning(Warnings.makeWarning("Component::onCleanup has not been overriden. Please make sure to override the initialization function of components."))
	return
end

function Component:super(...)
	local metatable = {
		__index = function(_, index)
			if (index == "super") then
				return (self[Super].super)
			end

			return self[index]
		end,
		__newindex = function(_, index, value)
			self[index] = value
		end
	}
	local pseudoSelf = setmetatable({}, metatable)

	return self[Super].init(pseudoSelf, ...)
end

function Component:cleanup()
	local internalComponentData = self[InternalComponentData]

	internalComponentData.lifetimePoint = ComponentLifetimePoint.CleaningUp

	self.cache:clear()
	self:onCleanup()

	internalComponentData.lifetimePoint = ComponentLifetimePoint.Nonexistant
	return
end

function Component:getCache()
	return self.cache
end

function Component:getLifetimePoint()
	return self[InternalComponentData].lifetimePoint
end

function Component:getArguments()
	return self[InternalComponentData].arguments
end

function Component:getComponentSettings()
	return self[InternalComponentData].componentSettings
end

function Component:__index(index)
	return rawget(self, index)
end

return {
	extend = function(name, componentSettings, extendingFrom)
		local validExtendingFrom = false
		
		if typeof(extendingFrom) == "table" and extendingFrom[Type] == Type.Component then
			validExtendingFrom = true
		end
		
		local newComponent = {
			[Type] = Type.Component,
			[InternalComponentData] = {
				componentSettings = componentSettings,
				arguments = nil,
				lifetimePoint = ComponentLifetime.Idle,
			},
			[Super] = (validExtendingFrom and extendingFrom or nil)
		}
		newComponent.__index = newComponent
		
		if validExtendingFrom then
			setmetatable(newComponent, extendingFrom)
		else
			setmetatable(newComponent, Component)
		end
		
		function newComponent.new(arguments)
			if typeof(arguments) ~= "table" then
				return
			end

			local internalComponentData = newComponent[InternalComponentData]
			
			if (ComponentSettings.matchAgainst(arguments, internalComponentData.componentSettings) ~= true) then
				local message = "Invalid component properties given. (Expected: %s, Got: %s)"
				local warning = Warnings.makeWarning(message)

				local encodedArguments = httpService:JSONEncode(arguments)
				local encodedComponentSettings = httpService:JSONEncode(internalComponentData.componentSettings)

				Warnings.dispatchWarning(warning, encodedArguments, encodedComponentSettings)
				return
			end
			
			local self = setmetatable({}, newComponent)

			self[InternalComponentData].arguments = arguments

			self.cache = Cache.new() 
			self:init()
			
			return self
		end
		
		return newComponent	
	end,
	
	[Type.InternalFunctions] = {
		__bind = function(self, name)
			local internalComponentData = self[InternalComponentData]
		end,

		__unbind = function(self, name)
			local internalComponentData = self[InternalComponentData]
			
			internalComponentData.lifetimePoint = ComponentLifetimePoint.Unbinding
			
			self:onUnbinding()
			self:cleanup()
		end,

		__cleanup = function(self, name)
			return self:cleanup()
		end
	}		
}
