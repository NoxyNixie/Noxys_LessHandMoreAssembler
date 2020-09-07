-- The items we don't touch so early game is still possible even when starting without items.
local blacklist = {
	["automation-science-pack"] = true,
	["assembling-machine-1"] = true,
	["assembling-machine-2"] = true,
	["boiler"] = true,
	["burner-inserter"] = true,
	["burner-mining-drill"] = true,
	["copper-cable"] = true,
	["electronic-circuit"] = true,
	["firearm-magazine"] = true,
	-- ["inserter"] = true, -- As annoying as this is you don't actually need it
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
	-- Angels refining
	["burner-ore-crusher"] = true,
	["stone-crushed"] = true,
	-- bobs mods
	["wooden-board"] = true,
	["basic-transport-belt"] = true,
	["basic-circuit-board"] = true,
	-- Omnimatter
	["crushing-omnite-by-hand"] = true,
	["omnicium-gear-wheel"] = true,
	["burner-omnitractor-1"] = true,
	["burner-omnitractor"] = true,
	-- AAI Industry
	["motor"] = true,
	["science-pack-0"] = true,
	-- PyScience
	["stone-tablet"] = true,
	["burner-lab"] = true,
	["burner-assembling-machine"] = true,
	["tcp-t0"] = true,
	["sct-t0-cognition-mesh"] = true,
	["sct-t0-erudition-turbine"] = true,
	-- Amator mods
	["apm_gearing"] = true,
	["apm_steam_clock"] = true,
	["apm_wood_board_1"] = true,
	["apm_assembling_machine_0"] = true,
	["apm_industrial_science_pack"] = true,
	["apm_lab_0"] = true,
  -- Krastorio 2
	["automation-core"] = true,
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

-- Patch for bobs to move some of the basics in the electronics catagory to hand crafting
-- Todo: Change this so that the things can still be used in the electronics assemblers.
if data.raw["recipe-category"].electronics then
	for _,v in pairs{"copper-cable", "wooden-board", "basic-circuit-board"} do
		if data.raw.recipe[v] then
			data.raw.recipe[v].category = "crafting"
		end
	end
end

-- Patch for bobs mods removing electroncs crafting from the player.
local cats = data.raw.character.character.crafting_categories
for i = #cats, 1, -1 do
	if cats[i] == "electronics" then
		table.remove(cats, i)
	end
end

-- Patch Amators science pack recipe catagory.
if data.raw.recipe["apm_industrial_science_pack"] then
	data.raw.recipe["apm_industrial_science_pack"].category = "crafting"
end