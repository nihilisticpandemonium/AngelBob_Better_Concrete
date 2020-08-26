function disable_techs(force, tech_list)
    for _, tech_name in pairs(tech_list) do
        if force.technologies[tech_name] then
            force.technologies[tech_name].researched = false
            force.technologies[tech_name].enabled = false
        else
            log("disable_techs: technology '"..tech_name.."' does not exist.")
        end
    end
end

for _, force in pairs(game.forces) do
    disable_techs(force, {
        "concrete",
        "concrete-2"
    })
end