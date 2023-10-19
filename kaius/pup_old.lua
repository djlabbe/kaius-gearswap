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
    state.Buff.Doom = false
    custom_weapon_list = S{"Godhands"}
end

function user_setup()
    include('Global-Binds.lua')

    state.OffenseMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT')

    state.WeaponLock = M(true, 'Weapon Lock')
    state.WeaponSet = M{['description']='Weapon Set', 'Xiucoatl', 'Verethragna', 'Godhands'}

    gear.Artifact_Head = { name="Foire Taj +1" }
    gear.Artifact_Body = { name="Foire Tobe +1" }
    gear.Artifact_Hands = { name="Foire Dastanas +1" }
    gear.Artifact_Legs = { name="Foire Churidars +1" }    
    gear.Artifact_Feet = { name="Foire Babouches +1" }

    gear.Relic_Head = { name="Pitre Taj +3" }
    gear.Relic_Body = { name="Pitre Tobe +3" }
    gear.Relic_Hands = { name="Pitre Dastanas +3" }
    gear.Relic_Legs = { name="Pitre Churidars +3" }
    gear.Relic_Feet = { name="Pitre Babouches +3" }

    gear.Empyrean_Head = { name="Karagoz Cappello +2" }
    gear.Empyrean_Body = { name="Karagoz Farsetto +2" }
    gear.Empyrean_Hands = { name="Karagoz Guanti +2" }
    gear.Empyrean_Legs = { name="Karagoz Pantaloni +2" }
    gear.Empyrean_Feet = { name="Karagoz Scarpe +2" }

    gear.Taeon_PUP_Head = { name="Taeon Chapeau", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    gear.Taeon_PUP_Body = { name="Taeon Tabard", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    gear.Taeon_PUP_Hands = { name="Taeon Gloves", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    gear.Taeon_PUP_Legs = { name="Taeon Tights", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    gear.Taeon_PUP_Feet = { name="Taeon Boots", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}

    gear.PUP_Cape = { name="Visucius's Mantle" }
    gear.PUP_WS_Cape = { name = "Visucius's Mantle" }
    
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')

    send_command('bind !F1 input /ja "Overdrive" <me>')
    send_command('bind !F2 input /ja "Heady Artifice" <me>')

    if player.sub_job == 'WAR' then
        send_command('bind !t input /ja "Provoke" <t>')
    end

    send_command('bind ^numpad7 gs c set WeaponSet Xiucoatl;input /macro set 1')
    send_command('bind ^numpad8 gs c set WeaponSet Verethragna;input /macro set 1')
    send_command('bind ^numpad9 gs c set WeaponSet Godhands;input /macro set 1')

    set_macro_page(1, 18)
    send_command('wait 3; input /lockstyleset 18')

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

    sets.precast.JA["Tactical Switch"] = {feet=gear.Empyrean_Feet}
    sets.precast.JA["Ventriloquy"] = {legs=gear.Relic_Legs}
    sets.precast.JA["Role Reversal"] = {feet=gear.Relic_Feet}
    sets.precast.JA["Overdrive"] = {body=gear.Relic_Body}

    sets.precast.JA["Repair"] = {
        ammo="Automat. Oil +3",
        feet=gear.Relic_Feet
    }

    sets.precast.JA["Maintenance"] = set_combine(sets.precast.JA["Repair"], {})

    sets.precast.JA.Maneuver = {
        neck="Buffoon's Collar +1",
        body=gear.Empyrean_Body,
        hands=gear.Artifact_Hands,
        back=gear.PUP_Cape,
        ear1="Burana Earring"
    }

    sets.precast.JA["Activate"] = {back = "Visucius's Mantle"}
    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]
    sets.precast.JA["Provoke"] = {}

    sets.OverdriveValoredge = {
        main="Xiucoatl",
        range="Neo Animator",
        head=gear.Taeon_PUP_Head,
        body=gear.Taeon_PUP_Body,
        hands=gear.Taeon_PUP_Hands,
        legs=gear.Taeon_PUP_Legs,
        feet=gear.Taeon_PUP_Feet,
        neck="Shulmanu Collar",
        waist="Klouskap Sash +1",
        ear1="Rimeice Earring",
        ear2="Enmerkar Earring",
        ring1="Gere Ring",
        ring2="Niqmaddu Ring",
        back=gear.PUP_Cape,
    }

    -- sets.precast.JA["Activate"] = {back = gear.PUP_Cape}
    -- sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.FC = {
        range="Neo Animator",
        ammo="Automat. Oil +3",
        head=gear.Herc_FC_head, --13
        body=gear.Taeon_FC_body, --9
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring1="Prolix Ring", --2
        ring2="Kishar Ring", --4
    } -- 53%

    sets.midcast.FastRecast = sets.precast.FC
    
    sets.precast.WS = {
        range="Neo Animator",
        ammo="Automat. Oil +3",
		head=gear.Nyame_Head,
		body=gear.Nyame_Body,
		hands=gear.Nyame_Body,
		legs=gear.Nyame_Legs,
		feet=gear.Nyame_Feet,
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		ear1="Schere Earring",
		ear2="Moonshade Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.PUP_Cape,
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        -- TODO
    })

    sets.precast.WS["Victory Smite"] = {
        range="Neo Animator",
        ammo="Automat. Oil +3",
		head=gear.Mpaca_Head,
		body=gear.Mpaca_Body,
		hands=gear.Mpaca_Body,
		legs=gear.Mpaca_Legs,
		feet=gear.Mpaca_Feet,
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		ear1="Schere Earring",
		ear2="Moonshade Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.PUP_Cape,
    }

    sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], {
        -- TODO
    })
   
    sets.precast.WS['Shijin Spiral'] = {
        range="Neo Animator",
        ammo="Automat. Oil +3",
		head=gear.Mpaca_Head,
		body=gear.Mpaca_Body,
		hands=gear.Mpaca_Body,
		legs=gear.Mpaca_Legs,
		feet=gear.Mpaca_Feet,
        neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Mache Earring +1",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.PUP_Cape,
    }

    sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], {
        -- TODO
    })

    sets.precast.WS['Howling Fist'] =  {
        range="Neo Animator",
        ammo="Automat. Oil +3",
		head=gear.Mpaca_Head,
		body=gear.Nyame_Body,
		hands=gear.Nyame_Hands,
		legs=gear.Mpaca_Legs,
		feet=gear.Nyame_Feet,
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		ear1="Schere Earring",
		ear2="Moonshade Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.PUP_Cape,
    }

    sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], {
        -- TODO
    })

    sets.precast.WS['Stringing Pummel'] =  {
        range="Neo Animator",
        ammo="Automat. Oil +3",
		head=gear.Mpaca_Head,
		body=gear.Mpaca_Body,
		hands=gear.Ryuo_A_Hands,
		legs=gear.Mpaca_Legs,
		feet=gear.Ryuo_C_Feet,
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ear1="Sherida Earring",
		ear2="Moonshade Earring",
		ring1="Regal Ring",
		ring2="Niqmaddu Ring",
		back=gear.PUP_Cape,
    }

    sets.precast.WS["Stringing Pummel"].Acc = set_combine(sets.precast.WS["Stringing Pummel"], {
        -- TODO
    })

    sets.precast.MaxTP = {
		ear2="Odr Earring",
    }

    -- sets.engaged = {
    --     range="Neo Animator",
    --     ammo="Automat. Oil +3",
	-- 	head=gear.Malignance_Head,
	-- 	body=gear.Mpaca_Body,
	-- 	hands=gear.Malignance_Hands,
	-- 	legs="Samnuha Tights",
	-- 	feet=gear.Malignance_Feet,
	-- 	neck="Shulmanu Collar",
	-- 	waist="Moonbow Belt +1",
    --     ear1="Schere Earring",
	-- 	ear2="Karagoz Earring +1",
	-- 	ring1="Gere Ring",
	-- 	ring2="Niqmaddu Ring",
	-- 	back=gear.PUP_Cape,
    -- }
    
    sets.engaged = {
        main={ name="Ohtas", augments={'Accuracy+70','Pet: Accuracy+70','Pet: Haste+10%',}},
        range={ name="Neo Animator", augments={'Path: A',}},
        ammo="Automat. Oil +3",
        head="Heyoka Cap +1",
        body={ name="Taeon Tabard", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
        hands={ name="Taeon Gloves", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
        legs={ name="Rao Haidate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
        feet={ name="Mpaca's Boots", augments={'Path: A',}},
        neck="Shulmanu Collar",
        waist="Klouskap Sash +1",
        left_ear="Rimeice Earring",
        right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Store TP"+4',}},
        left_ring="Varar Ring +1",
        right_ring="Varar Ring +1",
        back="Visucius's Mantle",
    }

    sets.MacheEar1 = {
        ear2="Mache Earring +1"
    }

    sets.engaged.Godhands = sets.engaged
    
    sets.engaged.Acc = set_combine(sets.engaged, {
		ring2=gear.Chirich_2,
    })

    sets.engaged.Godhands.Acc = sets.engaged.Acc

    sets.engaged.Hybrid = {
        range="Neo Animator",
        ammo="Automat. Oil +3",
        head="Heyoka Cap +1",
        body=gear.Mpaca_Body,
        hands=gear.Empyrean_Hands,
        legs="Heyoka Subligar",
        feet=gear.Mpaca_Feet,
        neck="Shulmanu Collar",
        ear1="Schere Earring",
		ear2="Karagoz Earring +1",
        waist="Moonbow Belt +1",
        back=gear.PUP_Cape,
    }


    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Godhands.DT = sets.engaged.DT

    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)  
    sets.engaged.Godhands.Acc.DT = sets.engaged.Acc.DT

    sets.idle = {
        range="Neo Animator",
        ammo="Automat. Oil +3",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Warder's Charm +1",
        ear1="Arete Del Luna +1",
        ear2="Sanare Earring",
        ring1="Gelatinous Ring +1",
        ring2="Shadow Ring",
        back=gear.PUP_Cape,
        waist="Moonbow Belt +1",
    }

    sets.idle.Pet = {
        main="Xiucoatl",
        range="Neo Animator",
        head=gear.Taeon_PUP_Head,
        body=gear.Taeon_PUP_Body,
        hands=gear.Taeon_PUP_Hands,
        legs=gear.Taeon_PUP_Legs,
        feet=gear.Taeon_PUP_Feet,
        neck="Shulmanu Collar",
        waist="Klouskap Sash +1",
        ear1="Rimeice Earring",
        ear2="Enmerkar Earring",
        ring1="Gere Ring",
        ring2="Niqmaddu Ring",
        back=gear.PUP_Cape,
    }


    sets.idle.Turtle = {
        main="Gnafron's Adargas",
    }

    sets.idle.Town ={
        range="Neo Animator",
        ammo="Automat. Oil +3",
		head=gear.Mpaca_Head,
		body=gear.Mpaca_Body,
		hands=gear.Mpaca_Hands,
		legs=gear.Mpaca_Legs,
		feet=gear.Mpaca_Feet,
		neck="Pup. Collar +2",
		waist="Moonbow Belt +1",
		ear1="Schere Earring",
		ear2="Karagoz Earring +1",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.PUP_Cape,
    }
    
    sets.defense.PDT = {
        range="Neo Animator",
        ammo="Automat. Oil +3",
        head=gear.Malignance_Head,
        neck="Pup. Collar +2",
        ear1="Schere Earring",
        -- ear2="Sherida Earring",
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        ring1="Gere Ring",
        ring2="Niqmaddu Ring",
        back=gear.PUP_Cape,
        waist="Moonbow Belt +1",
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
    }
    
    sets.defense.MDT = {
         range="Neo Animator",
        ammo="Automat. Oil +3",
        head=gear.Nyame_Head,
        neck="Warder's Charm +1",
        ear1="Odnowa Earring +1",
        ear2="Tuisto Earring",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        ring1="Defending Ring",
        ring2="Gelatinous Ring +1",
        back=gear.PUP_Cape,
        waist="Engraved Belt",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
    }

    sets.buff.Doom = {
        neck="Nicander's Necklace",
        ring1="Eshmun's Ring",
        ring2="Purity Ring",
        waist="Gishdubar Sash",
    }

    sets.Kiting = { ring1="Shneddick Ring +1" }
    sets.Xiucoatl = { main="Xiucoatl" }
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
    if buff == "Doom" then
        if gain then
            state.Buff.Doom = true
            send_command('@input /p Doomed.')
           
        else
            state.Buff.Doom = false
        end
    end
end

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'Acc' then
        wsmode = 'Acc'
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

-- Check for various actions that we've specified in user code as being used with TH gear.
-- This will only ever be called if TreasureMode is not 'None'.
-- Category and Param are as specified in the action event packet.
function th_action_check(category, param)
    if category == 2 or -- any ranged attack
        --category == 4 or -- any magic action
        (category == 3 and param == 30) or -- Aeolian Edge
        (category == 6 and info.default_ja_ids:contains(param)) or -- Provoke, Animated Flourish
        (category == 14 and info.default_u_ja_ids:contains(param)) -- Quick/Box/Stutter Step, Desperate/Violent Flourish
        then return true
    end
end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
end