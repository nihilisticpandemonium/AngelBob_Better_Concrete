-- modify reinforced concrete brick recipe
data.raw["recipe"]["angels-reinforced-concrete-brick"].results =
    {
        {type = "item", name = "refined-concrete", amount = 4}
    }
if settings.startup["use-iron-sticks-refined-concrete"].value then
    bobmods.lib.recipe.add_ingredient("angels-reinforced-concrete-brick", {"iron-stick", 8})
end

-- modify cement technologies
bobmods.lib.tech.remove_recipe_unlock("angels-stone-smelting-2", "angels-concrete-brick")
bobmods.lib.tech.add_recipe_unlock("angels-stone-smelting-2", "hazard-concrete")
bobmods.lib.tech.add_recipe_unlock("angels-stone-smelting-3", "refined-hazard-concrete")

-- move hazard concrete recipes to same location as concrete recipes
data.raw["recipe"]["hazard-concrete"]["subgroup"] = "angels-stone-casting"
data.raw["recipe"]["hazard-concrete"]["order"] = "i-a"
data.raw["recipe"]["refined-hazard-concrete"]["subgroup"] = "angels-stone-casting"
data.raw["recipe"]["refined-hazard-concrete"]["order"] = "j-a"

-- replace all instances of old concrete
bobmods.lib.recipe.replace_ingredient_in_all("concrete-brick", "concrete")
bobmods.lib.recipe.replace_ingredient_in_all("reinforced-concrete-brick", "refined-concrete")


-- replace dependencies on vanilla concrete tech with cement processing 2.
data.raw["technology"]["concrete"].enabled = false
for _, tech in pairs(data.raw.technology) do
    if tech.prerequisites then
        -- prevent tech loops if anyone adds concrete as a prereq to cement
        -- processing 2 (MoreScience - BobAngels Extension)
        if tech.name == "angels-stone-smelting-2" then
            bobmods.lib.tech.remove_prerequisite(tech.name, "concrete")
        else
            bobmods.lib.tech.replace_prerequisite(tech.name, "concrete", "angels-stone-smelting-2")
        end
    end
end

if mods["MoreScience-BobAngelsExtension"] then
    -- doesn't seem to work otherwise...
    bobmods.lib.tech.add_prerequisite("advanced-automation-science-pack", "angels-stone-smelting-2")
    -- replace dependencies on concrete 2 tech with cement processing 3.
    data.raw["technology"]["concrete-2"].enabled = false
    for _, tech in pairs(data.raw.technology) do
        if tech.prerequisites then
            -- prevent tech loops if anyone adds concrete as a prereq to cement
            -- processing 3 (MoreScience - BobAngels Extension)
            if tech.name == "angels-stone-smelting-3" then
                bobmods.lib.tech.remove_prerequisite(tech.name, "concrete-2")
            else
                bobmods.lib.tech.replace_prerequisite(tech.name, "concrete-2", "angels-stone-smelting-3")
            end
        end
    end
end

-- decrease stone brick move speed bonus
if settings.startup["stone-bricks-slower"].value then
    data.raw["tile"]["stone-path"].walking_speed_modifier = 1.2
end