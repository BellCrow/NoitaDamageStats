dofile_once("mods/damage_recap/files/model/damage_aggregator.lua")
dofile_once("mods/damage_recap/files/lib/util.lua")
dofile_once("mods/damage_recap/files/lib/variable_storage.lua")
dofile_once("mods/damage_recap/files/constants.lua")

local damage_aggregator_var = nil 

function damage_received( damage, desc, entity_who_caused, is_fatal)
    if not is_initialized()then
        initialize()
    end
    local normalized_damage = damage * 25
    print(tostring(normalized_damage).." damage taken from ".. desc )
    damage_aggregator_var:add_damage(desc,normalized_damage)
    if is_fatal then
        
        save_damage_aggregation()
    end
end

function save_damage_aggregation()
    local variable_storage_var = variable_storage:new(get_player_entity())
    local serialized_data = damage_aggregator_var:serialize()
    variable_storage_var:set_value(damage_aggregator_save_key, serialized_data)
end

function is_initialized()
    return damage_aggregator_var ~= nil
end

function initialize()
    damage_aggregator_var = damage_aggregator:new()
end