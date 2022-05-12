-- @author thunderbeast208 (xactlyblue)
-- @project Rocomponents
-- @file Cache.lua

local Type = require(script.Parent.Type)
local Symbol = require(script.Parent.Symbol)
local Warnings = require(script.Parent.Warnings)

local Cache = setmetatable({
	[Type] = Type.Cache	
}, {
	__index = function(self, index)
		return rawget(self, index)
	end,
	__newindex = function(self, index, value)
		if (index == Type) then
			return
		end
		
		rawset(self, index, value)
	end,
})

local InternalCacheData = Symbol.new("InternalCacheData")

function Cache.new()
	local self = setmetatable({
		[InternalCacheData] = {
			values = {}
		}
	}, { 
		__index = Cache,
		__newindex = function(self, index, value)
			rawset(self[InternalCacheData].values, index, value)
		end,
	})
	
	return self
end

function Cache:set(index, value)
	self[InternalCacheData].values[index] = value
end

function Cache:insert(value)
	table.insert(self[InternalCacheData].values, value)
end

function Cache:clear()
	for index, value in pairs(self[InternalCacheData].values) do
		if typeof(value) == "Instance" then
			value:Destroy()
		elseif typeof(value) == "RBXScriptConnection" then
			value:Disconnect()
		elseif typeof(value) == "table" then
			if (value[Type] == Type.Component) then
				local message = "There is a component stored in the cache. This may be unintentional."

				Warnings.dispatchWarning(Warnings.makeWarning(message))
				
				value:cleanup()
			end
		end
	end

	self[InternalCacheData].values = {}
end

return Cache
