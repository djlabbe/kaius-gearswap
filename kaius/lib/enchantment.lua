local res = require 'resources'

function Use_Item()
    windower.chat.input('/item "'..Use_Item_Command..'" <me>')
end

function Unlock()
    enable('main','sub','range','ammo','head','neck','lear','rear','body','hands','lring','rring','waist','legs','feet')
end

function equip_set()
    windower.send_command("gs c update auto")
end

function use_enchantment(item)
    local SlotList = {"main","sub","range","ammo","head","body","hands","legs","feet","neck","waist","lear","rear","left_ring","right_ring","back"}
    local item_table = res.items:with('enl',item) or res.items:with('en',item)
    if item_table == nil or not item_table.targets:contains('Self') then
        info("Invalid item.")
        return
    end
    local slot =''
    if item_table.slots:contains(0) then
        slot = 'main'
    else
        for k,v in pairs(item_table.slots) do
            if v == true then
                slot = SlotList[k+1]
                break
            end
        end
    end
    enable(slot)
    equip({[slot]=item_table.en})
    disable(slot)
    local delay_use = item_table.cast_delay + 2
    local delay_unlock = delay_use + item_table.cast_time + 2
    Use_Item_Command = item_table.en
    coroutine.schedule(Use_Item, delay_use)
    coroutine.schedule(Unlock, delay_unlock)
    coroutine.schedule(equip_set, delay_unlock)
end

function handle_enchantment_command(cmd, eventArgs)
    local command = cmd:lower()		
    if command == 'warp' then
        use_enchantment("Warp Ring")
    -- Warp Club
    elseif command == 'warp club' then
        use_enchantment("Warp Cudgel")
    -- Holla Teleport
    elseif command == 'holla' then
        use_enchantment("Dim. Ring (Holla)")
    -- Dem Teleport
    elseif command == 'dem' then
        use_enchantment("Dim. Ring (Dem)")
    -- Mea Teleport
    elseif command == 'mea' then
        use_enchantment("Dim. Ring (Mea)")
    -- Command to use any enchanted item, can use either en or enl names from resources, autodetects slot, equip timeout and cast time
    elseif command:startswith('use') then
        use_enchantment(command:slice(5))
    elseif command == 'version' then
        info('Include Version is ['..Mirdain_GS..']')
    end
end