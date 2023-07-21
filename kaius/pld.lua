-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------
--
--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ ALT+` ]           Toggle Magic Burst Mode
--
-------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Protect or false
end

function user_setup()
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal', 'PDT')
    state.WeaponskillMode:options('Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
    
    state.EquipShield = M(true, 'Equip Shield w/Defense')

    state.WeaponSet = M{['description']='Weapon Set', 'Sakpata', 'Naegling'}
    state.WeaponLock = M(false, 'Weapon Lock')

    gear.Artifact_Head = { name="Reverence Coronet +1" }
    gear.Artifact_Body = { name="Reverence Surcoat +3" }
    gear.Artifact_Hands = { name="Reverence Gauntlets +1" }
    gear.Artifact_Legs = { name="Reverence Breeches +1" }    
    gear.Artifact_Feet = { name="Reverence Leggings +1" }

    gear.Relic_Head = { name="Caballarius Coronet +3" }
    gear.Relic_Body = { name="Caballarius Surcoat +3" }
    gear.Relic_Hands = { name="Caballarius Gauntlets +3" }
    gear.Relic_Legs = { name="Caballarius Breeches +3" }
    gear.Relic_Feet = { name="Caballarius Leggings +3" }

    gear.Empyrean_Head = { name="Chevalier's Armet +2" }
    gear.Empyrean_Body = { name="Chevalier's Cuirass +2" }
    gear.Empyrean_Hands = { name="Chevalier's Gauntlets +2" }
    gear.Empyrean_Legs = { name="Chevalier's Cuisses +2" }
    gear.Empyrean_Feet = { name="Chevalier's Sabatons +2" }

    gear.PLD_Cape = { name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Damage taken-5%',}}
    gear.PLD_FC_Cape = { name="Rudianos's Mantle", augments={'"Fast Cast"+10','Spell interruption rate down -10%',}}

    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')

    send_command('bind !F1 input /ja "Invincible" <me>')
    send_command('bind !F2 input /ja "Intervene" <t>')

    send_command('bind !t input /ja "Shield Bash" <t>')
    send_command('bind !` input /ja "Majesty" <me>')
    send_command('bind !p input /ma "Protect V" <stpc>')
    send_command('bind !o input /ma "Shell IV" <stpc>')
    send_command('bind !i input /ma "Phalanx" <me>')
    send_command('bind ![ input /ma "Crusade" <me>')


    send_command('bind !c input /ma "Holy Circle" <me>')

    include('Global-Binds.lua')

    if player.sub_job == 'BLU' then
        set_macro_page(1, 7)
    elseif player.sub_job == 'WAR' then
        set_macro_page(2, 7)
    else
        set_macro_page(1, 7)
    end

    send_command('wait 3; input /lockstyleset 7')

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
end


function init_gear_sets()
    sets.precast.JA['Invincible'] = {legs=gear.Relic_Legs}
    sets.precast.JA['Holy Circle'] = {feet=gear.Artifact_Feet}
    sets.precast.JA['Shield Bash'] = {hands=gear.Relic_Hands}
    sets.precast.JA['Sentinel'] = {feet=gear.Relic_Feet}
    sets.precast.JA['Rampart'] = {head=gear.Relic_Head}
    sets.precast.JA['Fealty'] = {body=gear.Relic_Body}
    sets.precast.JA['Divine Emblem'] = {feet=gear.Empyrean_Feet}
    sets.precast.JA['Cover'] = {head=gear.Artifact_Head}

    sets.precast.JA['Chivalry'] = { -- Max MND
        ammo="Sapience Orb",
        head="Hjarrandi Helm",
        body=gear.Souveran_C_Body,
        hands=gear.Souveran_C_Hands,
        legs=gear.Souveran_C_Legs,
        feet=gear.Eschite_A_Feet,
        neck="Unmoving Collar +1",
        waist="Creed Baudrier",
        ear1="Tuisto Earring",
        ear2="Cryptic Earring",
        ring1="Apeile Ring +1",
        ring2="Eihwaz Ring",
        back=gear.PLD_Cape,
    }


    sets.precast.FC = { -- FC/SIRD
        ammo="Staunch Tathlum +1", -- 0/11
        head=gear.Souveran_C_Head, -- 0/20
        body=gear.Artifact_Body, -- 5/0 
        hands="Leyline Gloves", --5/0
        legs="Founder's Hose",--0/30
        feet=gear.Empyrean_Feet, -- 12/0
        neck="Orunmila's Torque", --5
        waist="Audumbla Sash", -- 0/10
        ear1="Tuisto Earring",
        ear2="Etiolation Earring",
        ring1="Prolix Ring", --5/0
        ring2="Gelatinous Ring +1",
        back=gear.PLD_FC_Cape, --8/10
    } -- 28% FC, 112% SIRD

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.WS = {
        ammo="Crepuscular Pebble",
        head=gear.Sakpata_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Sakpata_Feet,
        neck="Unmoving Collar +1",
        waist="Sailfi Belt +1",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2="Regal Ring",
        -- back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }

    sets.precast.WS['Sanguine Blade'] = {
        ear1="Friomisi Earring",
        ring1="Shiva Ring +1",
    }
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.Enmity = {
        ammo="Sapience Orb",
        head=gear.Souveran_C_Head,
        body=gear.Souveran_C_Body,
        hands=gear.Souveran_C_Hands,
        legs="Founder's Hose",--0/30
        feet=gear.Eschite_C_Feet,
        neck="Unmoving Collar +1",
        waist="Audumbla Sash",
        ear1="Tuisto Earring",
        ear2="Knightly Earring",
        ring1="Apeile Ring +1",
        ring2="Gelatinous Ring +1",
        back=gear.PLD_Cape,
    }

    sets.midcast.Flash = set_combine(sets.Enmity, {{
        head="Loess Barbuta +1",
        body=gear.Souveran_C_Body,
        hands=gear.Souveran_C_Hands,
        legs=gear.Souveran_C_Legs,
        feet=gear.Eschite_A_Feet,
        neck="Unmoving Collar +1",
        waist="Creed Baudrier",
        ear1="Tuisto Earring",
        ear2="Cryptic Earring",
        ring1="Apeile Ring +1",
        ring2="Eihwaz Ring",
        back=gear.PLD_Cape,
    }})
    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = { -- Cure/SIRD 
        ammo="Staunch Tathlum +1", -- 0/11
        head=gear.Souveran_C_Head, --0/20
        body=gear.Souveran_C_Body, --11/0
        hands="Macabre Gaunt. +1", --11/0
        legs="Founder's Hose",--0/30
        feet=gear.Ody_CURE_Feet, --13/20
        neck="Unmoving Collar +1",
        waist="Audumbla Sash", --0/10
        ear1="Nourishing Earring +1", --7/5
        ear2="Chevalier's Earring +1", --11/0
        ring1="Apeile Ring +1",
        ring2="Gelatinous Ring +1",
        back=gear.PLD_FC_Cape, --0/10
    } -- 42/106

    sets.midcast.Blue = { --Enm/SIRD
        ammo="Staunch Tathlum +1", -- 0/11
        head=gear.Souveran_C_Head, --9/20
        body=gear.Souveran_C_Body, --20/0
        hands=gear.Souveran_C_Hands, --9/0
        legs="Founder's Hose",--0/30
        feet=gear.Ody_CURE_Feet, --0/20
        neck="Moonlight Necklace", --15/15
        waist="Audumbla Sash", --0/10
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1",
        ring1="Apeile Ring +1", --9/0
        ring2="Gelatinous Ring +1",
        back=gear.PLD_FC_Cape, --10/0
    } --115 sird
        
    
    sets.midcast['Sheep Song'] = sets.midcast.Blue;
    sets.midcast['Geist Wall'] = sets.midcast.Blue;
    sets.midcast['Blank Gaze'] = sets.midcast.Blue;
    sets.midcast['Jettatura'] = sets.midcast.Blue;
    

    sets.midcast['Enhancing Magic'] = {
        ammo="Staunch Tathlum +1",
        head=gear.Souveran_C_Head,
        body=gear.Souveran_C_Body,
        hands={name="Regal Gauntlets", priority=205}, --[10]
        legs="Founder's Hose",--0/30
        feet=gear.Eschite_C_Feet,
        neck="Unmoving Collar +1",
        waist="Audumbla Sash",
        ear1="Tuisto Earring",
        ear2="Knightly Earring",
        ring1="Apeile Ring +1",
        ring2="Gelatinous Ring +1",
        back=gear.PLD_Cape,
    }
    
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'] , {
        ring1="Sheltered Ring",
    })

    sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'] , {
        ring1="Sheltered Ring",
    })
	
	 sets.midcast.Phalanx = {
        main="Sakpata's Sword",
        sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
        ammo="Staunch Tathlum +1",
        head=gear.Yorium_PHLX_Head,
        body=gear.Yorium_PHLX_Body,
        hands=gear.Souveran_C_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Souveran_D_Feet,
        neck="Incanter's Torque",
        waist="Olympus Sash",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Weard Mantle",
    }

	sets.precast.JA = {
        ammo="Sapience Orb",
        head="Loess Barbuta +1",
        body=gear.Souveran_C_Body,
        hands=gear.Souveran_C_Hands,
        legs=gear.Souveran_C_Legs,
        feet=gear.Eschite_A_Feet,
        neck="Unmoving Collar +1",
        waist="Creed Baudrier",
        ear1="Tuisto Earring",
        ear2="Cryptic Earring",
        ring1="Apeile Ring +1",
        ring2="Eihwaz Ring",
        back=gear.PLD_Cape,
    }

	sets.midcast.Reprisal = {
        ammo="Staunch Tathlum +1",
        head=gear.Souveran_C_Head,
        -- body="Rev. Surcoat +3",
        hands="Leyline Gloves",
        legs="Founder's Hose",--0/30
        -- feet={ name="Odyssean Greaves", augments={'"Fast Cast"+6','STR+5','Accuracy+3',}},
        neck="Unmoving Collar +1",
        waist="Audumbla Sash",
        ear1="Tuisto Earring",
        ear2="Etiolation Earring",
        -- ring1="Weather. Ring",
        ring2="Gelatinous Ring +1",
        back=gear.PLD_FC_Cape,
    }

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head=gear.Empyrean_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Sakpata_Feet,
        neck="Unmoving Collar +1",
        waist="Sailfi Belt +1",
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1",
        ring1=gear.Moonlight_1,
        ring2=gear.Moonlight_2,
        back=gear.PLD_Cape,
    }

    sets.idle.Town = {
        ammo="Staunch Tathlum +1",
        head=gear.Empyrean_Head,
        body=gear.Artifact_Body,
        hands=gear.Relic_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Relic_Feet,
        neck="Unmoving Collar +1",
        waist="Sailfi Belt +1",
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1",
        ring1=gear.Moonlight_1,
        ring2=gear.Moonlight_2,
        back=gear.PLD_Cape,
    }
    
    
    sets.Kiting = {legs=gear.Carmine_D_Legs}
    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here when activating or changing defense mode:
    sets.PhysicalShield = {sub="Ochain"}
    sets.MagicalShield = {sub="Aegis"}

    sets.defense.PDT = {
        ammo="Staunch Tathlum +1",
        head=gear.Sakpata_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Sakpata_Feet,
        neck="Unmoving Collar +1",
        waist="Creed Baudrier",
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1",
        ring1="Eihwaz Ring",
        ring2="Gelatinous Ring +1",
        back=gear.PLD_Cape,
    }

    sets.defense.MDT = {
        ammo="Staunch Tathlum +1",
        head=gear.Sakpata_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Sakpata_Feet,
        neck="Moonlight Necklace",
        ear1="Odnowa Earring +1",
        ear2="Eabani Earring",      
        ring1="Defending Ring",
        ring2="Purity Ring",
        back=gear.PLD_Cape,
        waist="Asklepian Belt",
    }
    
    sets.engaged = {
        ammo="Staunch Tathlum +1", --3
        head=gear.Empyrean_Head, 
        body=gear.Sakpata_Body, --10
        hands=gear.Sakpata_Hands, --8
        legs=gear.Empyrean_Legs, --12
        feet=gear.Sakpata_Feet, --6
        neck="Unmoving Collar +1",
        waist="Sailfi Belt +1",
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1",
        ring1=gear.Moonlight_1,
        ring2=gear.Moonlight_2,
        back=gear.PLD_Cape,
    } --49% DT


    sets.engaged.PDT = sets.engaged
    
    sets.buff.Cover = {head=gear.Artifact_Head, body=gear.Relic_Body}

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Purity Ring", --20
        waist="Gishdubar Sash", --10
    }

    sets.Sakpata = { main="Sakpata's Sword", sub="Srivatsa" }
    sets.Naegling = { main="Naegling", sub="Srivatsa"}

end



function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
    check_weaponset()
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
    if buff == 'Majesty' and not gain then
        add_to_chat(167, 'Majesty just expired!')
    end
    if buff == "doom" then
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

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    if state.Auto_Kite.value == true then
        idleSet = set_combine(idleSet, sets.Kiting)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end

    check_weaponset()
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end    
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
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