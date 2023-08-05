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
end

function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'PDL')
    state.WeaponskillMode:options('Normal', 'Acc', 'PDL')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Chango', 'Helheim', 'ShiningOne', 'Naegling', 'Loxotic' }
    state.WeaponLock = M(true, 'Weapon Lock')

    include('Global-Binds.lua')

    -- gear.Artifact_Head = { name= "Pummeler's Mask +1" }
    -- gear.Artifact_Body = { name= "Pummeler's Lorica +1" }
    -- gear.Artifact_Hands = { name= "Pummeler's Mufflers +1" }
    gear.Artifact_Legs = { name= "Pummeler's Cuisses +3" }
    gear.Artifact_Feet = { name= "Pummeler's Calligae +3" }

    gear.Relic_Head = { name= "Agoge Mask +3" }
    gear.Relic_Body = { name= "Agoge Lorica +3" }
    gear.Relic_Hands = { name= "Agoge Mufflers +3" }
    gear.Relic_Legs = { name= "Agoge Cuisses +3" }
    gear.Relic_Feet = { name= "Agoge Calligae +3" }

    gear.Empyrean_Head = { name= "Boii Mask +3" }
    gear.Empyrean_Body = { name= "Boii Lorica +3" }
    gear.Empyrean_Hands = { name= "Boii Mufflers +3" }
    gear.Empyrean_Legs = { name= "Boii Cuisses +3" }
    gear.Empyrean_Feet = { name= "Boii Calligae +2" }

    gear.WAR_TP_Cape = { name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}}
    gear.WAR_WS1_Cape = { name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    gear.WAR_WS2_Cape = { name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind ^numpad7 gs c set WeaponSet Chango;input /macro set 1')
    send_command('bind ^numpad8 gs c set WeaponSet Helheim;input /macro set 5')
    send_command('bind ^numpad9 gs c set WeaponSet ShiningOne;input /macro set 4')
    send_command('bind ^numpad4 gs c set WeaponSet Naegling;input /macro set 2')
    send_command('bind ^numpad5 gs c set WeaponSet Loxotic;input /macro set 3')

    send_command('bind !F1 input /ja "Mighty Strikes" <me>')
    send_command('bind !F2 input /ja "Brazen Rush" <me>')
    
    send_command('bind !t input /ja "Provoke" <t>')

    if player.sub_job == 'SAM' then
        send_command('bind !` input /ja "Hasso" <me>')
        send_command('bind ^` input /ja "Seigan" <me>')
        set_macro_page(1, 1)
    elseif player.sub_job == 'DRG' then
        set_macro_page(2, 1)
    end
    
    send_command('wait 3; input /lockstyleset 1' )

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end

function user_unload()
    send_command('unbind @w')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad9')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind !F1')
    send_command('unbind !F2')    
    send_command('unbind !t')
    send_command('unbind !`')
    send_command('unbind ^`')
end

function init_gear_sets()
    
    sets.Enmity = {
        ammo="Sapience Orb",
        head={name="Halitus Helm", priority=88}, --8
        neck="Moonlight Necklace",
        body=gear.Souveran_C_Body,
        legs=gear.Souveran_C_Legs,
        feet=gear.Souveran_D_Feet,
        ear1={name="Cryptic Earring", priority=40},
        ear2={name="Trux Earring", priority=1},
        body={name="Emet Harness +1", priority=61}, --10
        hands={name="Kurys Gloves", priority=25}, --9
        ring1="Apeile Ring +1",
        ring2="Eihwaz Ring",
    }

    sets.precast.JA["Provoke"] = sets.Enmity

    sets.precast.JA["Berserk"] = {
        body=gear.Artifact_Body,
        feet=gear.Relic_Feet,
    }

    sets.precast.JA["Warcry"] = {
        head=gear.Relic_Head
    }

    sets.precast.JA['Restraint'] = {
        hands=gear.Empyrean_Hands,
    }

    sets.precast.JA['Blood Rage'] = {
        body=gear.Empyrean_Body,
    }
    
    sets.precast.JA['Aggressor'] = {
        body=gear.Relic_Body,
        head=gear.Relic_Head,
    }

    sets.buff.MightyStrikes = {
        feet=gear.Empyrean_Feet,
    }

    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head=gear.Sakpata_Head, --8
        hands="Leyline Gloves", --8
        neck="Orunmila's Torque", --5
        ear1="Etiolation Earring", --1
        ear2="Enchanter's Earring +1", --2
        ring2="Prolix Ring",
    }

    sets.engaged = {
        ammo="Coiste Bodhar", --3
        head=gear.Empyrean_Head, --7
        body=gear.Empyrean_Body,
        hands=gear.Sakpata_Hands, --6
        legs=gear.Sakpata_Legs, --7
        feet=gear.Artifact_Feet, --9
        neck="Warrior's bead necklace +2", --7
        ear1="Schere Earring", --6
        ear2="Boii Earring +1", --8
        ring1="Niqmaddu Ring",
        ring2=gear.Chirich_2,
        waist="Sailfi Belt +1", --5
        back=gear.WAR_TP_Cape, --10
    } -- 68% DA + 28% Traits + Gifts +5% Merits
    -- 52% PDT

    sets.engaged.Acc = {
        ammo="Coiste Bodhar", --3
        head=gear.Empyrean_Head, --7
        body=gear.Empyrean_Body,
        hands=gear.Sakpata_Hands, --6
        legs=gear.Artifact_Legs, --7
        feet=gear.Artifact_Feet, --9
        neck="Warrior's bead necklace +2", --7
        ear1="Schere Earring", --6
        ear2="Boii Earring +1", --8
        ring1="Regal Ring",
        ring2=gear.Chirich_2,
        waist="Sailfi Belt +1", --5
        back=gear.WAR_TP_Cape, --10
    }

    sets.engaged.SingleWield = {
        ammo="Coiste Bodhar",
        head=gear.Empyrean_Head,
        body="Hjarrandi Breastplate",
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Artifact_Feet,
        neck="Warrior's bead necklace +2",
        ear1="Schere Earring",
        ear2="Boii Earring +1",
        ring1="Niqmaddu Ring",
        ring2="Petrov Ring",
        waist="Sailfi Belt +1",
        back=gear.WAR_TP_Cape,
    }

    sets.engaged.DW = {
        ammo="Coiste Bodhar",
        head=gear.Empyrean_Head,
        body=gear.Relic_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Artifact_Feet,
        neck="Warrior's bead necklace +2",
        waist="Reiki Yotai",
        ear1="Eabani Earring",
        ear2="Boii Earring +1",
        ring1="Niqmaddu Ring",
        ring2="Petrov Ring",
        back=gear.WAR_TP_Cape,
    }

    sets.engaged.DW.LowHaste = sets.engaged.DW
    sets.engaged.DW.MidHaste = sets.engaged.DW
    sets.engaged.DW.MaxHaste = sets.engaged.DW
    sets.engaged.DW.MaxHaste = sets.engaged.DW

    sets.engaged.Hybrid = {
        head=gear.Sakpata_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Sakpata_Feet,
    }
    
    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.precast.WS = {
        head=gear.Relic_Head,
        body=gear.Nyame_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ring1="Cornelia's Ring",
        ring2="Epaminondas's Ring",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",
        waist="Sailfi Belt +1",
        ammo="Knobkierrie",
        back=gear.WAR_WS1_Cape,
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        -- TODO
    })

    sets.precast.WS.PDL = set_combine(sets.precast.WS, {
        -- TODO
    })

    --------------------------------------------------------
    ---------------------- GREAT AXE -----------------------
    --------------------------------------------------------

    sets.precast.WS["Upheaval"] = {
        ammo="Knobkierrie",
        head=gear.Relic_Head,
        body=gear.Nyame_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Warrior's bead necklace +2",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",
        ring1="Cornelia's Ring",
        ring2="Gelatinous Ring +1",
        waist="Sailfi Belt +1",
        back=gear.WAR_WS2_Cape,
    }

    sets.precast.WS["Upheaval"].Acc = set_combine(sets.precast.WS["Upheaval"], {})
    sets.precast.WS["Upheaval"].PDL = set_combine(sets.precast.WS["Upheaval"], {})

    sets.precast.WS["Upheaval"].MightyStrikes = { 
        ammo="Yetshila +1",
        head=gear.Relic_Head,
        neck="Fotia Gorget",
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        ring1="Cornelia's Ring",
        ring2="Epaminondas's Ring",
        legs=gear.Sakpata_Legs,
        feet=gear.Empyrean_Feet,
    }

    sets.precast.WS["Ukko's Fury"] = {
        ammo="Yetshila +1",
        head=gear.Empyrean_Head,
        body="Hjarrandi Breastplate",
        hands="Flamma Manopolas +2",
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Warrior's bead necklace +2",
        ear1="Moonshade Earring",
        ear2="Boii Earring +1",
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",
        waist="Sailfi Belt +1",
        back=gear.WAR_WS2_Cape,
    }

    sets.precast.WS["Ukko's Fury"].Acc = set_combine(sets.precast.WS["Ukko's Fury"], {})
    sets.precast.WS["Ukko's Fury"].PDL = set_combine(sets.precast.WS["Ukko's Fury"], {})

    sets.precast.WS["Fel Cleave"] = {
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Nyame_Feet,
        neck="Warrior's bead necklace +2",
        ring1="Cornelia's Ring",
        ring2="Epaminondas's Ring",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",
        waist="Sailfi Belt +1",
        ammo="Knobkierrie",
        back=gear.WAR_WS1_Cape,
    }

    sets.precast.WS["Fel Cleave"].Acc = set_combine(sets.precast.WS["Fel Cleave"], {})
    sets.precast.WS["Fel Cleave"].PDL = set_combine(sets.precast.WS["Fel Cleave"], {})

    sets.precast.WS["Armor Break"] = {
        ammo="Pemphredo Tathlum",
        head=gear.Sakpata_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Sakpata_Feet,
        neck="Moonlight Necklace",
        waist="Eschan Stone",
        ear1="Moonshade Earring",
        ear2="Boii Earring +1",
        ring1=gear.Stikini_1,
        ring2="Metamorph Ring +1",
        back=gear.WAR_WS1_Cape,
    }

    --------------------------------------------------------
    --------------------- GREAT SWORD ----------------------
    --------------------------------------------------------

    sets.precast.WS["Resolution"] = {
        ammo="Yetshila +1",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Tatenashi_Legs,
        feet="Flamma Gambieras +2",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Lugra Earring +1",
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",
        waist="Fotia Belt",
        back=gear.WAR_WS1_Cape,
    }

    sets.precast.WS["Resolution"].Acc = set_combine(sets.precast.WS["Resolution"], {})

    sets.precast.WS["Resolution"].PDL = set_combine(sets.precast.WS["Resolution"], {
        ammo="Seething Bomblet +1",
        body=gear.Sakpata_Body,
        legs=gear.Sakpata_Legs,
        feet=gear.Sakpata_Feet,
    })

    sets.precast.WS["Fimbulvetr"] = {
        ammo="Knobkierrie",
        head=gear.Relic_Head,
        body=gear.Nyame_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Warrior's bead necklace +2",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",
        ring1="Cornelia's Ring",
        ring2="Regal Ring",
        waist="Sailfi Belt +1",
        back=gear.WAR_WS1_Cape,
    }

    sets.precast.WS["Fimbulvetr"].Acc = set_combine(sets.precast.WS["Fimbulvetr"], {})

    sets.precast.WS["Fimbulvetr"].PDL = set_combine(sets.precast.WS["Fimbulvetr"], {
        body=gear.Sakpata_Body,
        legs=gear.Sakpata_Legs,
        feet=gear.Sakpata_Feet,
    })

    --------------------------------------------------------
    ----------------------- POLEARM ------------------------
    --------------------------------------------------------

    sets.precast.WS["Stardiver"] = {
        ammo="Yetshila +1",
        head=gear.Empyrean_Head,
        body="Hjarrandi Breastplate",
        hands="Flamma Manopolas +2",
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Boii Earring +1",
        ring1="Niqmaddu Ring",
        ring2="Begrudging Ring",
        waist="Fotia Belt",
        back=gear.WAR_WS1_Cape,
    }

    sets.precast.WS["Stardiver"].Acc = set_combine(sets.precast.WS["Stardiver"], {})

    sets.precast.WS["Stardiver"].PDL = set_combine(sets.precast.WS["Stardiver"], {
        head="Blistering Sallet +1",
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        ring2="Sroda Ring",
    })

    sets.precast.WS["Impulse Drive"] = {
        ammo="Yetshila +1",
        head=gear.Empyrean_Head,
        body="Hjarrandi Breastplate",
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Warrior's bead necklace +2",
        ear1="Moonshade Earring",
        ear2="Boii Earring +1",
        ring1="Niqmaddu Ring",
        ring2="Begrudging Ring",
        waist="Fotia Belt",
        back=gear.WAR_WS1_Cape,
    }

    sets.precast.WS["Impulse Drive"].Acc = set_combine(sets.precast.WS["Impulse Drive"], {})

    sets.precast.WS["Impulse Drive"].PDL = set_combine(sets.precast.WS["Impulse Drive"], {
        head="Blistering Sallet +1",
        body=gear.Sakpata_Body,
        legs=gear.Empyrean_Legs,
        ring2="Sroda Ring",
    })

    --------------------------------------------------------
    ------------------------ SWORD -------------------------
    --------------------------------------------------------

    sets.precast.WS['Savage Blade'] = {
        ammo="Knobkierrie",
        head=gear.Relic_Head,
        body=gear.Nyame_Body, 
        hands=gear.Empyrean_Hands, 
        legs=gear.Empyrean_Legs,
        feet=gear.Nyame_Feet,
        neck="Warrior's Bead Necklace +2",
        waist="Sailfi Belt +1",
        ear1="Moonshade Earring", 
        ear2="Thrud Earring",
        ring1="Cornelia's Ring",
        ring2="Regal Ring",       
        back=gear.WAR_WS1_Cape,
    }

    sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS["Savage Blade"], {})
    sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS['Savage Blade'], {
        body=gear.Sakpata_Body,
        ring2="Sroda Ring",
    })

    --------------------------------------------------------
    ------------------------ CLUB --------------------------
    --------------------------------------------------------

    sets.precast.WS['Judgment'] = {
        ammo="Knobkierrie",
        head=gear.Relic_Head,
        body=gear.Nyame_Body, 
        hands=gear.Empyrean_Hands, 
        legs=gear.Empyrean_Legs,
        feet=gear.Nyame_Feet,
        neck="Warrior's Bead Necklace +2",
        ear1="Moonshade Earring", 
        ear2="Thrud Earring",
        ring1="Cornelia's Ring",
        ring2="Regal Ring",       
        waist="Sailfi Belt +1",
        back=gear.WAR_WS1_Cape,
    }

    sets.precast.WS["Judgment"].Acc = set_combine(sets.precast.WS["Judgment"], {})
    sets.precast.WS['Judgment'].PDL = set_combine(sets.precast.WS['Savage Blade'], {
        body=gear.Sakpata_Body,
    })
   
    --------------------------------------------------------
    --------------------- IDLE, ETC ------------------------
    --------------------------------------------------------

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head=gear.Sakpata_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Sakpata_Feet,
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Odnowa Earring +1",
        ring1=gear.Moonlight_1,
        ring2="Shadow Ring",
        back="Shadow Mantle",
        waist="Carrier's Sash"
    }

    sets.idle.Town = sets.engaged;

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Purity Ring", --20
        waist="Gishdubar Sash", --10
    }

    sets.Kiting = { feet="Hermes' Sandals" }

    sets.Naegling = { main="Naegling", sub="Blurred Shield +1" }
    sets.Loxotic = { main="Loxotic Mace +1", sub="Blurred Shield +1" }
    sets.ShiningOne = { main="Shining One", sub="Utu Grip" }
    sets.Chango = { main="Chango", sub="Utu Grip" }
    sets.Helheim = { main="Helheim", sub="Utu Grip" }
end

-- function job_post_precast(spell, action, spellMap, eventArgs)
--     if spell.type == 'WeaponSkill' then
--         if (spell.english == 'Upheaval' and buffactive['Mighty Strikes']) then
--             equip(sets.precast.WS["Upheaval"].MightyStrikes)
--         end
--     end
-- end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    determine_haste_group()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

function job_buff_change(buff, gain)
    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

    if buff == "Mighty Strikes" then
        if gain then
            equip(sets.buff.MightyStrikes)
            disable('feet')
        else
            enable('feet')
            handle_equipping_gear(player.status)
        end
    end

    if buff == 'Hasso' and not gain then
        add_to_chat(167, 'Hasso just expired!')
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
    check_weaponset()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
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
    check_weaponset()
    if player.equipment.main == "Naegling" and DW == false then
        meleeSet = set_combine(meleeSet, sets.engaged.SingleWield)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'Acc' then
        wsmode = (wsmode or '') .. 'Acc'
    end
    if state.OffenseMode.value == 'PDL' then
        wsmode = (wsmode or '') .. 'PDL'
    end

    return wsmode
end

-- Function to display the current relevant user state when doing an update.
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

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
end

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 14 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 15 and DW_needed <= 26 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 26 and DW_needed <= 32 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 32 and DW_needed <= 43 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 43 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
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