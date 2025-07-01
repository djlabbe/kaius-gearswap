moving = false
main_engine_time = os.clock()
Location = {x=0, y=0, z=0}

function movement_engine()
    local now = os.clock()
    -- Make sure not update faster than .1 seconds
	if now - main_engine_time < .1 then return end
    if not player or player.status == "Dead" or player.status == "Engaged dead" or buffactive['Charm'] or buffactive['Sleep'] then return end
    local position = windower.ffxi.get_mob_by_id(player.id)
    if position and not buffactive['Mounted'] and not is_Busy then
        local movement = math.sqrt( (position.x-Location.x)^2 + (position.y-Location.y)^2 + (position.z-Location.z)^2 ) > 0.5
        if movement and not moving then
            if player.status ~= "Engaged" then
                moving = true
                windower.send_command("gs c update auto")
            end
        elseif not movement and moving then
            moving = false
            windower.send_command("gs c update auto")
        end
        Location.x = position.x
        Location.y = position.y
        Location.z = position.z
    end

    main_engine_time = os.clock()
end


-- coroutine.schedule(movement_engine, 2)
windower.raw_register_event('outgoing chunk', movement_engine)