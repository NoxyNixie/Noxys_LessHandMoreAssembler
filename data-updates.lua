-- The items we don't touch so early game is still possible even when starting without items.
local blacklist = {
	["assembling-machine-1"] = true,
	["assembling-machine-2"] = true,
	["boiler"] = true,
	["burner-inserter"] = true,
	["burner-mining-drill"] = true,
	["copper-cable"] = true,
	["electronic-circuit"] = true,
	["firearm-magazine"] = true,
	-- ["inserter"] = true, -- As annoying that this is you don't actually need this
	["iron-axe"] = true,
	["iron-gear-wheel"] = true,
	["iron-stick"] = true,
	["lab"] = true,
	["light-armor"] = true,
	["offshore-pump"] = true,
	["pipe"] = true,
	["pipe-to-ground"] = true,
	["pistol"] = true,
	["small-electric-pole"] = true,
	["steam-engine"] = true,
	["stone-furnace"] = true,
	["transport-belt"] = true,
	["wood"] = true,
	["wooden-chest"] = true,
}
-- Patch all recipes to be advanced crafting.
for k,recipe in pairs(data.raw.recipe) do
	if not blacklist[k] and not string.match(k, "^creative[-]mode[-]") then
		if not recipe.category then 
			recipe.category = "advanced-crafting"
		elseif recipe.category == "crafting" then 
			recipe.category = "advanced-crafting"
		end
	end
end

-- Patch assembling machine 1 to be considered an advanced crafter.
table.insert(data.raw["assembling-machine"]["assembling-machine-1"].crafting_categories, "advanced-crafting")

-- Patch assembling machine 2 so we can actually craft the refinery with it.
if data.raw["assembling-machine"]["assembling-machine-2"].ingredient_count < 5 then
	data.raw["assembling-machine"]["assembling-machine-2"].ingredient_count = 5
end