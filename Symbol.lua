-- @author thunderbeast208 (xactlyblue)
-- @project Rocomponents
-- @file Symbol.lua

-- @notice Inspired by the 'Symbol' script in roblox/roact. (https://roblox.github.io/roact/)

return {
	new = function(name)
		if typeof(name) ~= "string" then
			return
		end
		
		local proxy = newproxy(true)
		local metatable = getmetatable(proxy)
		
		function metatable:__tostring()
			return ("Symbol (%s)"):format(name)
		end
		
		return proxy
	end,
} 
