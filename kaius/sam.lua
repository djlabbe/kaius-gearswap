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

-------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
    res = require 'resources'
end

function job_setup()
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Third Eye'] = buffactive['Third Eye'] or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
    state.Buff.Doom = false
end

function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Subtle', 'Subtle_Auspice')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT')
    
    state.WeaponSet = M{['description']='Weapon Set', 'Masamune', 'Dojikiri', 'ShiningOne', 'AeolianEdge'}
    state.WeaponLock = M(true, 'Weapon Lock')

    gear.Artifact_Head = { name= "Wakido Kabuto +3" }
    -- gear.Artifact_Body = { name= "Wakido Domaru +3" }
    gear.Artifact_Hands = { name= "Wakido Kote +3" }
    gear.Artifact_Legs = { name= "Wakido Haidate +3" }
    -- gear.Artifact_Feet = { name= "Wakido Sune-Ate +3" }

    gear.Relic_Head = { name= "Sakonji Kabuto +3" }
    gear.Relic_Body = { name= "Sakonji Domaru +3" }
    gear.Relic_Hands = { name= "Sakonji Kote +3" }
    gear.Relic_Legs = { name= "Sakonji Haidate +3" }
    gear.Relic_Feet = { name= "Sakonji Sune-Ate +3" }

    gear.Empyrean_Head = { name= "Kasuga Kabuto +3" }
    gear.Empyrean_Body = { name= "Kasuga Domaru +3" }
    gear.Empyrean_Hands = { name= "Kasuga Kote +3" }
    gear.Empyrean_Legs = { name= "Kasuga Haidate +3" }
    gear.Empyrean_Feet = { name= "Kasuga Sune-Ate +2" }

    gear.SAM_STP_Cape = { name="Takaha Mantle" }
    gear.SAM_TP_Cape = { name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.SAM_WS_Cape = { name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --X

    include('Global-Binds.lua')

    send_command('bind !F1 input /ja "Meikyo Shisui" <me>')
    send_command('bind !F2 input /ja "Yaegasumi" <me>')

    send_command('bind !` input /ja "Hasso" <me>')
    send_command('bind ^` input /ja "Seigan" <me>')

    if player.sub_job == 'WAR' then
        send_command('bind !t input /ja "Provoke" <t>')
    end

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind !c input /ja "Warding Circle" <me>')
    send_command('bind !a input /ja "Hamanoha" <me>')
   
    if player.sub_job == 'DRG' then
        send_command('bind ^numpad7 gs c set WeaponSet Masamune;input /macro set 1')
        send_command('bind ^numpad8 gs c set WeaponSet Dojikiri;input /macro set 1')
        send_command('bind ^numpad9 gs c set WeaponSet ShiningOne;input /macro set 2')
        send_command('bind ^numpad4 gs c set WeaponSet AeolianEdge;input /macro set 5')
        set_macro_page(1, 12)
    elseif player.sub_job == 'WAR' then
        send_command('bind !t input /ja "Provoke" <t>')     
        send_command('bind ^numpad7 gs c set WeaponSet Masamune;input /macro set 3')
        send_command('bind ^numpad8 gs c set WeaponSet Dojikiri;input /macro set 3')
        send_command('bind ^numpad9 gs c set WeaponSet ShiningOne;input /macro set 4')
        send_command('bind ^numpad4 gs c set WeaponSet AeolianEdge;input /macro set 6')
        set_macro_page(3, 12)
    else
        set_macro_page(1, 12)
    end

    send_command('wait 3; input /lockstyleset 12')
    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind !F1')
    send_command('unbind !F2')
    send_command('unbind !`')
    send_command('unbind ^`')
    send_command('unbind !t')
    send_command('unbind !c')
    send_command('unbind !a')
    send_command('unbind @w')
    unbind_numpad()
end

function init_gear_sets()

    sets.precast.FC = {
        body="Sacro Breastplate",
        hands="Leyline Gloves",
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Etiolation Earring", --2
        ring2="Prolix Ring", --2
    }

    sets.precast.JA.Meditate = {
        head=gear.Artifact_Head,
        hands=gear.Relic_Hands,
        back=gear.SAM_WS_Cape,
    }

    sets.buff['Meikyo Shisui'] = {feet=gear.Relic_Feet}
    sets.precast.JA.Sekkanoki = { hands=gear.Empyrean_Hands }
    sets.precast.JA.Sengikori = { feet=gear.Empyrean_Feet }
    sets.precast.JA['Warding Circle'] = {head=gear.Artifact_Helm}
    sets.precast.JA['Third Eye'] = {legs=gear.Relic_Legs}

    sets.Masamune = { main="Masamune", sub="Utu Grip" }
    sets.Dojikiri = { main="Dojikiri Yasutsuna", sub="Utu Grip" }
    sets.ShiningOne = { main="Shining One", sub="Utu Grip" }
    sets.AeolianEdge = { main=gear.Malevolence_A }

    sets.engaged = {
        ammo="Aurgelmir Orb +1",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Tatenashi_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Ryuo_C_Feet,
        neck="Sam. Nodowa +2",
        waist="Sweordfaetels +1",
        ear1="Dedition Earring",
        ear2="Kasuga Earring +1",
        ring1="Niqmaddu Ring",
        ring2=gear.Chirich_2,
        back=gear.SAM_STP_Cape,
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        ammo="Coiste Bodhar",
        hands=gear.Artifact_Hands,
        ear1="Schere Earring",
        back=gear.SAM_TP_Cape,
        waist="Ioskeha Belt +1"
    })

    sets.engaged.Subtle = {
        ammo="Aurgelmir Orb +1",
        head="Kendatsuba Jinpachi +1", --8
        body="Dagon Breastplate", --(10)
        hands=gear.Artifact_Hands,
        legs=gear.Mpaca_Legs, --(5)
        feet=gear.Ryuo_C_Feet, --8
        neck="Bathy Choker +1", --11
        ear1="Schere Earring", --3
        ear2="Dignitary's Earring", --5
        ring1="Niqmaddu Ring", --(5)
        ring2="Chirich Ring +1", --10
        waist="Sarissapho. Belt", --5
        back=gear.SAM_TP_Cape,
    } --50/20

    sets.engaged.Subtle_Auspice = {
        ammo="Aurgelmir Orb +1",
        head="Kendatsuba Jinpachi +1", --8
        body="Dagon Breastplate", --(10)
        hands=gear.Artifact_Hands,
        legs=gear.Mpaca_Legs, --(5)
        feet=gear.Ryuo_C_Feet, --8
        neck="Samurai's Nodowa +2",
        ear1="Dedition Earring", --3
        ear2="Telos Earring", --5
        ring1="Niqmaddu Ring", --(5)
        ring2="Chirich Ring +1", --10
        waist="Sailfi Belt +1",
        back=gear.SAM_TP_Cape,
    } --25/20

    -- Base 35%
    sets.engaged.Hybrid = {
        back=gear.SAM_TP_Cape,
    } -- 45% Physical

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.precast.WS = {
        ammo="Knobkierrie",
        head=gear.Mpaca_Head,
        body=gear.Relic_Body,
        hands=gear.Empyrean_Hands,
        legs= gear.Nyame_Legs,
        feet=gear.Nyame_Feet, 
        neck="Sam. Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        ring1="Niqmaddu Ring",
        ring2="Cornelia's Ring",
        back=gear.SAM_WS_Cape,
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})

    sets.precast.WS.HighTP = set_combine(sets.precast.WS, {
        ear2="Lugra Earring +1",
    })

    sets.precast.WS.MaxTP = set_combine(sets.precast.WS.HighTP, {
        head=gear.Nyame_Head,
    })

    sets.precast.WS["Tachi: Fudo"] = {
        ammo="Knobkierrie",
        head=gear.Mpaca_Head,
        body=gear.Nyame_Body,
        hands=gear.Empyrean_Hands, 
        legs= gear.Nyame_Legs, 
        feet=gear.Nyame_Feet,
        neck="Sam. Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        ring1="Cornelia's Ring",
        ring2="Epaminondas's Ring", 
        back=gear.SAM_WS_Cape,
    }

    sets.precast.WS["Tachi: Fudo"].PDL = set_combine( sets.precast.WS["Tachi: Fudo"], {
        ring2="Sroda Ring",
        feet=gear.Empyrean_Feet,
    })

    sets.precast.WS["Tachi: Kasha"] = sets.precast.WS["Tachi: Fudo"]
    sets.precast.WS["Tachi: Kasha"].PDL = sets.precast.WS["Tachi: Fudo"].PDL
    sets.precast.WS["Tachi: Gekko"] = sets.precast.WS["Tachi: Fudo"]
    sets.precast.WS["Tachi: Gekko"].PDL = sets.precast.WS["Tachi: Fudo"].PDL
    sets.precast.WS["Tachi: Yukikaze"] = sets.precast.WS["Tachi: Fudo"]
    sets.precast.WS["Tachi: Yukikaze"].PDL = sets.precast.WS["Tachi: Fudo"].PDL

    sets.precast.WS["Tachi: Shoha"] = {
        ammo="Knobkierrie",
        head=gear.Mpaca_Head,
        body=gear.Nyame_Body,
        hands=gear.Empyrean_Hands, 
        legs= gear.Nyame_Legs, 
        feet=gear.Nyame_Feet,
        neck="Sam. Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        ring2="Cornelia's Ring",
        ring2="Epaminondas's Ring",
        back=gear.SAM_WS_Cape,
    }

    sets.precast.WS["Tachi: Shoha"].PDL = set_combine( sets.precast.WS["Tachi: Shoha"], {
        ammo="Crepuscular Pebble",
        feet=gear.Empyrean_Feet,
    })

    sets.precast.WS["Tachi: Rana"] = {
        ammo="Coiste Bodhar",
        head=gear.Mpaca_Head,
        body=gear.Relic_Body,
        hands=gear.Empyrean_Hands, 
        legs= gear.Nyame_Legs, 
        feet=gear.Mpaca_Feet,
        neck="Sam. Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Lugra Earring +1",
        ear2="Schere Earring",
        ring1="Niqmaddu Ring",
        ring2="Regal Ring", 
        back=gear.SAM_WS_Cape,
    } 

    sets.precast.WS['Tachi: Jinpu'] = {
        ammo="Knobkierrie",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Sam. Nodowa +2",
        ear1="Schere Earring",
        ear2="Moonshade Earring",
        ring1="Cornelia's Ring",
        ring2="Epaminondas's Ring",
        back=gear.SAM_WS_Cape,
        waist="Orpheus's Sash",
    };

    sets.precast.WS['Tachi: Kagero'] = {
        ammo="Knobkierrie",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Sibyl Scarf",
        ear1="Friomisi Earring",
        ear2="Moonshade Earring",
        ring1="Cornelia's Ring",
        ring2="Epaminondas's Ring",
        back=gear.SAM_WS_Cape,
        waist="Orpheus's Sash",
    }

      sets.precast.WS['Tachi: Ageha'] = {
        ammo="Pemphredo Tathlum",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Legs,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Sanctity Necklace",
        ear1="Dignitary's Earring",
        ear2="Kasuga Earring +1",
        ring1=gear.Stikini_1,
        ring2="Metamorph Ring +1",
        back=gear.SAM_WS_Cape,
        waist="Eschan Stone",
    }

    sets.precast.WS['Impulse Drive'] = {
        ammo="Knobkierrie",
        head=gear.Mpaca_Head,
        body=gear.Nyame_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Sam. Nodowa +2",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        ring1="Niqmaddu Ring",
        ring2="Begrudging Ring",
        back=gear.SAM_WS_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Impulse Drive'].PDL = sets.precast.WS['Impulse Drive']

    sets.precast.WS['Impulse Drive'].HighTP = set_combine(sets.precast.WS['Impulse Drive'], {
        head="Blistering Sallet +1",
        ear2="Ishvara Earring",
        ring1="Regal Ring",
    })

    sets.precast.WS['Sonic Thrust'] = sets.precast.WS['Impulse Drive']

    sets.precast.WS['Stardiver'] = {
        ammo="Coiste Bodhar", --6
        head=gear.Mpaca_Head,
        body=gear.Mpaca_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Mpaca_Legs,
        feet=gear.Mpaca_Feet,
        neck="Fotia Gorget",
        ear1="Schere Earring",
        ear2="Moonshade Earring",
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",
        back=gear.SAM_WS_Cape,
        waist="Fotia Belt",
    }

     sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Legs,
        neck="Sibyl Scarf",
        ear1="Friomisi Earring",
        ear2="Moonshade Earring",
        ring1="Metamor. Ring +1",
        ring2="Epaminondas's Ring",
        back=gear.SAM_WS_Cape,
        waist="Orpheus's Sash",
    })

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head=gear.Artifact_Head,
        body="Sacro Breastplate",
        hands=gear.Mpaca_Hands,
        legs=gear.Mpaca_Legs,
        feet=gear.Mpaca_Feet,
        neck="Warder's Charm +1",
        waist="Carrier's Sash",
        ear1="Arete Del Luna +1",
        ear2="Eabani Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.SAM_TP_Cape,
    }

    sets.idle.DT = set_combine(sets.idle, {
        head=gear.Mpaca_Head, --7/0
        body=gear.Mpaca_Body, --10/0
        hands=gear.Mpaca_Hands, --8/0
        legs=gear.Mpaca_Legs, --9/0
        feet=gear.Mpaca_Feet, --6/0
        ring2="Defending Ring", --10/10
    })

    sets.idle.Town = sets.engaged

    sets.Kiting = { ring1="Shneddick Ring +1" }

    sets.defense.PDT = {
        ammo="Staunch Tathlum +1",
        head=gear.Nyame_Head,
        neck="Loricate Torque +1",
        ear1="Odnowa Earring +1",
        ear2="Tuisto Earring",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        ring1="Niqmaddu Ring",
        ring2="Gelatinous Ring +1",
        back=gear.SAM_TP_Cape,
        waist="Sailfi Belt +1",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
    } 

    sets.defense.MDT = {
        ammo="Staunch Tathlum +1", --3
        head=gear.Nyame_Head,
        neck="Warder's Charm +1",
        ear1="Etiolation Earring",
        ear2="Eabani Earring",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        ring1="Purity Ring",
        ring2="Defending Ring",
        back=gear.SAM_TP_Cape, 
        waist="Carrier's Sash",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
    }

    sets.buff.ThirdEye = {
        head=gear.Empyrean_Head,
        legs=gear.Relic_Legs,
    }

    sets.buff.Doom = {
        neck="Nicander's Necklace",
        ring1="Eshmun's Ring", 
        ring2="Purity Ring",
        waist="Gishdubar Sash",
    }
end

function job_precast(spell, action, spellMap, eventArgs)
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Impulse Drive' and player.tp > 2000 then
           equip(sets.precast.WS['Impulse Drive'].HighTP)
        elseif player.tp == 3000 then
            equip(sets.precast.WS.MaxTP)
        elseif player.tp > 2750 then
            equip(sets.precast.WS.HighTP)
        end

        if elemental_ws:contains(spell.name) then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Matching day and weather
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Match day or weather
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

function job_buff_change(buff,gain)
    if buff == 'Hasso' and not gain then
        add_to_chat(167, 'Hasso just expired!')
    end
    if buff == "Doom" then
        if gain then
            state.Buff.Doom = true
            send_command('@input /p Doomed.')
        else
            state.Buff.Doom = false
        end
    end
    if buff == "Third Eye" then
        if gain and state.Buff.Seigan then
            equip(sets.buff.ThirdEye)
            disable('legs')
        else
            enable('legs')
            handle_equipping_gear(player.status)
        end
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

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'Acc' then
        wsmode = 'Acc'
    end

    return wsmode
end

function customize_idle_set(idleSet)
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end
    return idleSet
end

function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    check_weaponset()
    return meleeSet
end

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