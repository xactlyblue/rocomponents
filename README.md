# Rocomponents
A component library for Roblox, allowing you to add more functionality to parts of your project.
This library allows you to add further functionality to code that manipulates or interacts with
instances, and in an organized and readable manner!

## Installation
### Wally
[Wally](https://github.com/UpliftGames/wally) is a package manager for ROBLOX, and can help you
easily install Rocomponents in to your project. Simply, add this block of code to your ``wally.toml`` file
under the dependencies category.

```
Rocomponents = "xactlyblue/rocomponents@0.0.1"
```

### Rojo
To use this library, simply git-clone the source code into your target folder
and rojo will take care of the rest!

``git clone "https://github.com/xactlyblue/rocomponents"``

## Documentation
Unfortunately, this is a relatively new library, and does not yet have in-depth documentation.
However, there are a few basic examples listed below to help you get a good idea of it's function. 

## Basic Examples
This is a simple example of a nametag-component; a billboard-gui displaying the player's name above their head!

Using the following example, you can refer to the nametag as a component, which itself can your own defined
functions as an object-oriented object. You can easily modify the instance it is bound to, and easily clean
up when you're done using the ``Cache`` instance 

If you would like to see the example place [here](https://www.roblox.com/games/9611485319/Rocomponents-Example).

**Note:** If you'd like, you could even add a re-enable the commented out call to unbind the component afterwards to see the unbinding procedures!

```lua
-- Require the rocomponents module!
local Rocomponents = require(game:GetService("ReplicatedStorage").Rocomponents)

-- The ROBLOX services we might need!
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

-- Create the component settings to make sure it's always initialized correctly!
local NametagComponentSettings = Rocomponents.ComponentSettings.extend({
	["name"] = "string",
	["subtitle"] = "string",
})
-- The actual component we will be using!
local NametagComponent = Rocomponents.Component.extend("Nametag", NametagComponentSettings)

-- The initialization function!
function NametagComponent:init()
	print("Woah... a nametag component was created o.O")
end

-- Add the nametag gui to the instance the component is binded to!
function NametagComponent:onBinded(instance)
	local arguments = self:getArguments()
	local name, subtitle = arguments.name, arguments.subtitle
	
	local clone = script:WaitForChild("Nametag"):Clone()
	clone.Name = "Nametag"
	clone.Parent = instance:WaitForChild("Head")
	
	clone:WaitForChild("Name").Text = name
	clone:WaitForChild("Subtitle").Text = subtitle
	
	self.cache.instance = clone
end

-- When a player joins the game, add a nametag to their character when it loads!
Players.PlayerAdded:Connect(function(player)
	local function onCharacterAdded(character)
		-- Create and bind the component to the character!
		local component = Rocomponents.bindComponent(NametagComponent, character, {
			name = player.Name,
			subtitle = "The One And Only!"
		})

		-- Optional:
		-- task.delay(10, function() Rocomponents.unbindComponent(component) end)
	end

	-- Connect the character added function.
	player.CharacterAdded:Connect(onCharacterAdded)
end)
```

Created by [thunderbeast208/xactlyblue](https://www.roblox.com/users/106984434/profile)
