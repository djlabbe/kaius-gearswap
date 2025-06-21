-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--
-------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false
    state.Buff.Doom = false
    state.Buff.Boost = false
    custom_weapon_list = S{"Godhands"}
end

function user_setup()
    include('Global-Binds.lua')

    state.OffenseMode:options('Normal', 'PDL')
    state.WeaponskillMode:options('Normal', 'PDL')
    state.HybridMode:options('Normal', 'DT', 'Counter', 'Ngai')
    state.PhysicalDefenseMode:options('PDT')

    state.WeaponLock = M(true, 'Weapon Lock')
    state.WeaponSet = M{['description']='Weapon Set', 'Verethragna', 'Godhands'}

    gear.Artifact_Head = { name="Anchorite's Crown +2" }
    gear.Artifact_Body = { name="Anchorite's Cyclas +2" }
    gear.Artifact_Hands = { name="Anchorite's Gloves +2" }
    gear.Artifact_Legs = { name="Anchorite's Hose +2" }    
    gear.Artifact_Feet = { name="Anchorite's Gaiters +3" }

    gear.Relic_Head = { name="Hesychast's Crown +3" }
    gear.Relic_Body = { name="Hesychast's Cyclas +3" }
    gear.Relic_Hands = { name="Hesychast's Gloves +3" }
    gear.Relic_Legs = { name="Hesychast's Hose +3" }
    gear.Relic_Feet = { name="Hesychast's Gaiters +3" }

    gear.Empyrean_Head = { name="Bhikku Crown +3" }
    gear.Empyrean_Body = { name="Bhikku Cyclas +3" }
    gear.Empyrean_Hands = { name="Bhikku Gloves +3" }
    gear.Empyrean_Legs = { name="Bhikku Hose +3" }
    gear.Empyrean_Feet = { name="Bhikku Gaiters +3" }

    gear.MNK_DEX_DA_Cape = { name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}} --X
    gear.MNK_STR_CRIT_Cape = { name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}} --X
    
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')

    send_command('bind !F1 input /ja "Hundred Fists" <me>')
    send_command('bind !F2 input /ja "Inner Strength" <me>')

    if player.sub_job == 'WAR' then
        send_command('bind !t input /ja "Provoke" <t>')
    end

    send_command('bind ^numpad7 gs c set WeaponSet Verethragna;input /macro set 1')
    send_command('bind ^numpad8 gs c set WeaponSet Godhands;input /macro set 1')

    set_macro_page(1, 2)
    send_command('wait 3; input /lockstyleset 2')

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
    get_combat_weapon()
end

function user_unload()
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind !F1')
    send_command('unbind !F2')
    send_command('unbind !t')
    unbind_numpad()
end

function init_gear_sets()
    sets.precast.JA['Hundred Fists'] = { legs=gear.Relic_Legs }
    sets.precast.JA['Boost'] = { hands=gear.Artifact_Hands }
    sets.precast.JA['Dodge'] = { feet=gear.Artifact_Feet }
    sets.precast.JA['Focus'] = { head=gear.Artifact_Head }
    sets.precast.JA['Counterstance'] = { feet=gear.Relic_Feet }
    sets.precast.JA['Footwork'] = { feet="Shukuyu sune-ate" }
    sets.precast.JA['Formless Strikes'] = { body=gear.Relic_Body }
    sets.precast.JA['Mantra'] = { feet=gear.Relic_Feet }
    sets.precast.JA['Chi Blast'] = {head=gear.Relic_Head}

    sets.precast.JA['Chi Blast'] = {
        head=gear.Artifact_Head,
        hands=gear.Relic_Hands,
        legs=gear.Relic_Legs,
        feet=gear.Artifact_Feet,
    }

    sets.precast.JA['Chakra'] = {
        ammo="Aurgelmir Orb +1",
        head=gear.Nyame_Head,
        neck="Unmoving Collar +1",
        ear1="Handler's Earring +1",
        ear2="Tuisto Earring",
        body=gear.Artifact_Body,
        hands=gear.Relic_Hands,
        ring1="Niqmaddu Ring",
        ring2="Gelatinous Ring +1",
        back="Moonlight Cape",
        waist="Platinum Moogle Belt",
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet
    }

    sets.precast.FC = {
        ammo="Sapience Orb", --2a
        head=gear.Herc_FC_Head, --13
        body=gear.Taeon_FC_Body, --9
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring1="Prolix Ring", --2
        ring2="Kishar Ring", --4
    } -- 49%

    sets.midcast.FastRecast = sets.precast.FC
    
    sets.precast.WS = {
        ammo="Knobkierrie",
		head=gear.Mpaca_Head,
		body=gear.Nyame_Body,
		hands=gear.Empyrean_Hands,
		legs=gear.Mpaca_Legs,
		feet=gear.Mpaca_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Odr Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_DEX_DA_Cape,
    }

    sets.precast.WS.PDL = set_combine(sets.precast.WS, {
        -- TODO
    })

    sets.precast.WS["Victory Smite"] = {
        ammo="Coiste Bodhar",
		head=gear.Mpaca_Head,
		body=gear.Empyrean_Body,
		hands=gear.Empyrean_Hands,
		legs=gear.Mpaca_Legs,
		feet=gear.Mpaca_Feet,
		neck="Monk's Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Schere Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_STR_CRIT_Cape,
    }

    sets.precast.WS["Victory Smite"].PDL = set_combine(sets.precast.WS["Victory Smite"] , {
        ammo="Crepuscular Pebble",
    })

    sets.precast.WS['Raging Fists'] = {
        ammo="Knobkierrie",
		head=gear.Mpaca_Head,
		body=gear.Mpaca_Body,
		hands=gear.Tatenashi_Hands,
		legs=gear.Nyame_Legs,
		feet=gear.Artifact_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Moonshade Earring",
		ear2="Schere Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_DEX_DA_Cape,
    }
    sets.precast.WS["Raging Fists"].PDL = set_combine(sets.precast.WS["Raging Fists"], {
        -- TODO
    })
   
    sets.precast.WS['Shijin Spiral'] = {
        ammo="Knobkierrie",
		head=gear.Nyame_Head,
		body=gear.Nyame_Body,
		hands=gear.Malignance_Hands,
		legs=gear.Nyame_Legs,
		feet=gear.Malignance_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Mache Earring +1",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_DEX_DA_Cape,
    }

    sets.precast.WS["Shijin Spiral"].PDL = set_combine(sets.precast.WS["Shijin Spiral"], {
        head=gear.Malignance_Head,
        legs=gear.Relic_Legs,
    })

    sets.precast.WS['Howling Fist'] =  {
        ammo="Knobkierrie",
		head=gear.Mpaca_Head,
		body=gear.Nyame_Body,
		hands=gear.Tatenashi_Hands,
		legs=gear.Nyame_Legs,
		feet=gear.Nyame_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Moonshade Earring",
		ear2="Schere Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_DEX_DA_Cape,
    }

    sets.precast.WS["Howling Fist"].PDL = set_combine(sets.precast.WS["Howling Fist"], {
        -- TODO
    })

    sets.precast.WS['Final Heaven'] =  {
        ammo="Knobkierrie",
		head=gear.Mpaca_Head,
		body=gear.Empyrean_Body,
		hands=gear.Tatenashi_Hands,
		legs=gear.Nyame_Legs,
		feet=gear.Nyame_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Ishvara Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_DEX_DA_Cape,
    }

    sets.precast.WS["Final Heaven"].PDL = set_combine(sets.precast.WS["Final Heaven"], {
        -- TODO
    })

    sets.precast.WS['Tornado Kick'] = {
        ammo="Coiste Bodhar",
		head=gear.Mpaca_Head,
		body=gear.Nyame_Body,
		hands=gear.Nyame_Hands,
		legs=gear.Nyame_Legs,
		feet=gear.Artifact_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Moonshade Earring",
		ear2="Schere Earring",
		ring1=gear.Cornelia_Or_Gere,
		ring2="Niqmaddu Ring",
		back=gear.MNK_DEX_DA_Cape,
    }

    sets.precast.WS["Tornado Kick"].PDL = set_combine(sets.precast.WS["Tornado Kick"], {
        -- TODO
    })

    
    sets.precast.WS['Dragon Kick'] = {
        ammo="Knobkierrie",
		head=gear.Mpaca_Head,
		body=gear.Nyame_Body,
		hands=gear.Nyame_Hands,
		legs=gear.Nyame_Legs,
		feet=gear.Artifact_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Moonshade Earring",
		ear2="Schere Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_DEX_DA_Cape,
    }

    sets.precast.MaxTP = {
		ear2="Odr Earring",
    }

    ---- Fall back to default WS set for Asuran Fists, and Spinning Attack ----

    sets.precast.WS['Ascetic\'s Fury'] = {
        ammo="Crepuscular Pebble",
		head=gear.Mpaca_Head,
		body=gear.Empyrean_Body,
		hands=gear.Empyrean_Hands,
		legs=gear.Mpaca_Legs,
		feet=gear.Mpaca_Feet,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ear1="Sherida Earring",
		ear2="Schere Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_STR_CRIT_Cape,
    }
    
    sets.precast.WS['Shell Crusher'] = {
        head=gear.Malignance_Head,
        neck="Moonlight Necklace",
        ear1="Crepuscular Earring",
        ear2="Bhikku Earring +1",
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        ring1=gear.Stikini_1,
        ring2="Metamorph Ring +1",
        back=gear.MNK_STR_CRIT_Cape,
        waist="Acuity Belt +1",
    }

    sets.precast.WS['Cataclysm'] = {
        head="Pixie Hairpin +1",
        neck="Sibyl Scarf",
        ear1="Friomisi Earring",
        ear2="Moonshade Earring",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        ring1="Archon Ring",
        ring2="Metamorph Ring +1",
        back=gear.MNK_STR_CRIT_Cape,
        waist="Orpheus's Sash",
    }

    sets.engaged = {
        ammo="Coiste Bodhar",
		head=gear.Malignance_Head,
		body=gear.Mpaca_Body,
		hands=gear.Adhemar_A_Hands,
		legs=gear.Empyrean_Legs,
		feet=gear.Empyrean_Feet,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
        ear1="Sherida Earring",
		ear2="Schere Earring",
		ring1=gear.Lehko_Or_Gere,
		ring2="Niqmaddu Ring",
		back=gear.MNK_DEX_DA_Cape,
    }

    sets.engaged.PDL = sets.engaged
    
    sets.MacheEar1 = {
        ear1="Mache Earring +1"
    }

    sets.engaged.Godhands = set_combine(sets.engaged, sets.MacheEar1)

    sets.engaged.Godhands.PDL = set_combine(sets.engaged.PDL, sets.MacheEar1)

    sets.engaged.Hybrid = {
        head=gear.Malignance_Head,
        hands=gear.Malignance_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
    }

    sets.engaged.Ngai = {
        head=gear.Malignance_Head,
        neck="Warder's Charm +1",
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Malignance_Feet,
    }
   
    sets.engaged.Counter = {
        ammo="Coiste Bodhar",
		head=gear.Empyrean_Head,
		body=gear.Mpaca_Body,
		hands=gear.Malignance_Hands,
		legs=gear.Empyrean_Legs,
		feet=gear.Empyrean_Feet,
		neck="Bathy Choker +1",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Bhikku Earring +1",
		ring1="Defending Ring",
		ring2="Niqmaddu Ring",
		back=gear.MNK_DEX_DA_Cape,
    }

    sets.engaged.Godhands.Counter = set_combine(sets.engaged.Counter, sets.MacheEar1)

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Ngai = set_combine(sets.engaged, sets.engaged.Ngai)
    sets.engaged.Godhands.DT = set_combine(sets.engaged.DT, sets.MacheEar1)

    sets.engaged.PDL.DT = set_combine(sets.engaged.PDL, sets.engaged.Hybrid)  
    sets.engaged.Godhands.PDL.DT = set_combine(sets.engaged.PDL.DT, sets.MacheEar1)
    
    sets.buff.Impetus = { body=gear.Empyrean_Body }
	-- sets.buff.Footwork = { feet=gear.Artifact_Feet } -- Just use empy always (base attack + kick attack almost as much as AF, plus way more other stats)

    sets.defense.PDT = {
        ammo="Staunch Tathlum +1",
        head=gear.Malignance_Head,
        neck="Monk's Nodowa +2",
        ear1="Sherida Earring",
        ear2="Schere Earring",
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        ring1="Gere Ring",
        ring2="Niqmaddu Ring",
        back=gear.MNK_DEX_DA_Cape,
        waist="Moonbow Belt +1",
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
    }
    
    sets.defense.MDT = {
        ammo="Staunch Tathlum +1",
        head=gear.Nyame_Head,
        neck="Warder's Charm +1",
        ear1="Odnowa Earring +1",
        ear2="Tuisto Earring",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        ring1="Defending Ring",
        ring2="Gelatinous Ring +1",
        back=gear.MNK_DEX_DA_Cape,
        waist="Null Belt",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
    }

    sets.buff.Doom = {
        neck="Nicander's Necklace",
        ring1="Eshmun's Ring",
        ring2="Purity Ring",
        waist="Gishdubar Sash",
    }

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head=gear.Malignance_Head,
        body="Adamantite Armor",
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        ear1="Sanare Earring",
        ear2="Eabani Earring",
        neck="Warder's Charm +1",
        ring1=gear.Chirich_1,
        ring2=gear.Gerubu_Or_Shadow,
        back="Null Shawl",
        waist="Moonbow Belt +1",
    }

    sets.buff.Boost = {
        waist="Ask Sash"
    }

    sets.idle.Town = set_combine(sets.engaged.DT, sets.buff.Impetus)

    if (item_available("Shneddick Ring +1")) then
        sets.Kiting = { ring1="Shneddick Ring +1" }
    else
        sets.Kiting = { feet="Hermes' Sandals" }
    end
    
    sets.Verethragna = { main="Verethragna" }
    sets.Godhands = { main="Godhands" }
end


function job_state_change(field, new_value, old_value)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
    check_weaponset()
end


-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)

    if spell.type == 'WeaponSkill' then
        if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
            equip(sets.buff.Impetus)
        elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
            equip(sets.buff.Footwork)
        end
        
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
        handle_equipping_gear(player.status)
    end

    if buff == "Doom" then
        if gain then
            state.Buff.Doom = true
            send_command('@input /p Doomed.')
           
        else
            state.Buff.Doom = false
        end
    end

    if buff == "Boost" then
        if gain then
            state.Buff.Boost = true
           
        else
            state.Buff.Boost = false
        end
    end
end

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'PDL' then
        wsmode = 'PDL'
    end

    return wsmode
end


-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function job_update(cmdParams, eventArgs)
    get_combat_weapon()
    handle_equipping_gear(player.status)
end

function customize_idle_set(idleSet)
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    if state.Auto_Kite.value == true then
        idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

function customize_melee_set(meleeSet)

    if state.Buff['Impetus'] then
        meleeSet = set_combine(meleeSet, sets.buff.Impetus)
    end

    if buffactive.Footwork then
        meleeSet = set_combine(meleeSet, sets.buff.Footwork)
    end

    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end

    return meleeSet
end

function get_combat_weapon()
    state.CombatWeapon:reset()
    if custom_weapon_list:contains(player.equipment.main) then
        state.CombatWeapon:set(player.equipment.main)
    end
end


function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
end