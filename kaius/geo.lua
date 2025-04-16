-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+Q ]           Toggle Magic Burst Mode
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
-------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
    geo_timer = ''
    indi_duration = 308
    newLuopan = 0
    state.Buff['Blaze of Glory'] = buffactive['Blaze of Glory'] or false
end

function user_setup()
    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(true, 'Magic Burst')

    gear.Artifact_Head = { name= "Geomancy Galero +2" }
    gear.Artifact_Body = { name= "Geomancy Tunic +3" }
    gear.Artifact_Hands = { name= "Geomancy Mitaines +3" }
    gear.Artifact_Legs = { name= "Geomancy Pants +2" }
    gear.Artifact_Feet = { name= "Geomancy Sandals +3" }

    gear.Relic_Head = { name= "Bagua Galero +3" }
    gear.Relic_Body = { name= "Bagua Tunic +3" }
    gear.Relic_Hands = { name= "Bagua Mitaines +3" }
    gear.Relic_Legs = { name= "Bagua Pants +3" }
    gear.Relic_Feet = { name= "Bagua Sandals +3" }

    gear.Empyrean_Head = { name= "Azimuth Hood +3" }
    gear.Empyrean_Body = { name= "Azimuth Coat +3" }
    gear.Empyrean_Hands = { name= "Azimuth Gloves +3" }
    gear.Empyrean_Legs = { name= "Azimuth Tights +3" }
    gear.Empyrean_Feet = { name= "Azimuth Gaiters +3" }

    gear.GEO_Idle_Cape = { name="Nantosuelta's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: "Regen"+5',}} --X
    gear.GEO_MAB_Cape = { name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Mag. Evasion+15',}} --X
    
    include('Global-Binds.lua')

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @q gs c toggle MagicBurst')

    send_command('bind !F1 input /ja "Bolster" <me>')
    send_command('bind !F2 input /ja "Widened Compass" <me>')

    send_command('bind @1 input /ja "Full Circle" <me>')
    send_command('bind @2 input /ja "Radial Arcana" <me>')
    send_command('bind @3 input /ja "Mending Halation" <me>')
    send_command('bind @4 input /ja "Concentric Pulse" <me>')

    send_command('bind !m input /ja "Dematerialize" <me>')
    send_command('bind !f input /ja "Collimated Fervor" <me>')
    send_command('bind !t input /ja "Theurgic Focus" <me>')
   
    if player.sub_job == 'RDM' then
        send_command('bind !p input /ma "Protect III" <stpc>')
        send_command('bind !o input /ma "Shell III" <stpc>')
        send_command('bind !g input /ma "Gravity" <t>')
        send_command('bind !h input /ma "Haste" <stpc>')
        send_command('bind !u input /ma "Aquaveil" <me>')
        send_command('bind !i input /ma "Phalanx" <me>')
        send_command('bind !b input /ma "Bind" <t>')
        send_command('bind !y input /ja "Convert" <me>')
        send_command('bind !numpad7 input /ma "Paralyze" <t>')
        send_command('bind !numpad8 input /ma "Slow" <t>')
        send_command('bind !numpad9 input /ma "Silence" <t>')
        send_command('bind !numpad5 input /ma "Distract" <t>')
        send_command('bind !numpad6 input /ma "Frazzle" <t>')
    end

    if player.sub_job == 'WHM' then
        send_command('bind !h input /ma "Haste" <stpc>')
        send_command('bind !u input /ma "Aquaveil" <me>')
    end


    if player.sub_job == 'SCH' then
        send_command('bind !- gs c scholar light')
        send_command('bind != gs c scholar dark')

        send_command('bind ^; gs c scholar speed')   
        send_command('bind ^[ gs c scholar aoe')
        send_command('bind !; gs c scholar cost')
        send_command('bind ![ gs c scholar power')
    end

    set_macro_page(1, 21)
    send_command('wait 3; input /lockstyleset 21')

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind @w')
    send_command('unbind @q')
    send_command('unbind !a')
    send_command('unbind !h')
    send_command('unbind !m')
    send_command('unbind !n')
    send_command('unbind !b')
    send_command('unbind !f')
    send_command('unbind !t')
    send_command('unbind !y')
    send_command('unbind !i')
    send_command('unbind !u')
    send_command('unbind !b')
    send_command('unbind !g')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^;')   
    send_command('unbind ^[')
    send_command('unbind !;')
    send_command('unbind ![')
    unbind_numpad()
end


function init_gear_sets()

    sets.precast.JA.Bolster = {body=gear.Relic_Body}
    sets.precast.JA['Full Circle'] = {head=gear.Empyrean_Head}
    sets.precast.JA['Life Cycle'] = {
        head=gear.Relic_Head, 
        body=gear.Artifact_Body, 
        back=gear.GEO_Idle_Cape,
    }

    sets.precast.FC = {
        ranged="Dunna", --3
        head=gear.Amalric_A_Head, --11
        body="Zendik Robe", --13
        hands=gear.Agwu_Hands, --6
        legs=gear.Artifact_Legs, --15
        feet=gear.Merlinic_FC_Feet, --12
        neck="Orunmila's Torque", --5
        ear1="Malignance Earring", --4
        ear2="Etiolation Earring", --1
        ring1="Kishar Ring", --4
        ring2="Prolix Ring", --2
        back="Fi Follet Cape +1", --10
        waist="Shinjutsu-no-Obi +1", --5
    } --91

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        back="Perimede Cape",
        waist="Siegel Sash",
    })

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {hands=gear.Relic_Hands})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ring1="Lebeche Ring",
        back="Perimede Cape",
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {main="Daybreak", sub="Ammurapi Shield"})
    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty, body="Crepuscular Cloak"})

    sets.precast.WS = {
        ammo="Oshasha's Treatise",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Regal Earring",
        ring1="Epaminondas's Ring",
        ring2="Hetairoi Ring",
        waist="Fotia Belt",
        back=gear.GEO_MAB_Cape,
    }

    sets.precast.WS['Exudation'] = {
        ammo="Oshasha's Treatise",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Regal Earring",
        ring1="Epaminondas's Ring",
        ring2="Hetairoi Ring",
        waist="Fotia Belt",
        back=gear.GEO_MAB_Cape,
    }

    sets.precast.WS['Flash Nova'] = {
        head=gear.Relic_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Relic_Legs,
        feet=gear.Relic_Feet,
        neck="Sibyl Scarf",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Metamor. Ring +1",
        back=gear.GEO_MAB_Cape,
        waist="Orpheus's Sash",
    }

    sets.precast.WS['Cataclysm'] = {
        head="Pixie Hairpin +1",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Sibyl Scarf",
        ear1="Moonshade Earring",
        ear2="Malignance Earring",
        ring1="Epaminondas's Ring",
        ring2="Archon Ring",
        waist="Orpheus's Sash",
    }

   sets.midcast.Geomancy = {
        main="Idris",
        sub="Genmei Shield",
        ranged="Dunna",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        ear1="Magnetic Earring",
        ear2="Azimuth Earring +2",
        neck="Incanter's Torque",
        ring1="Gelatinous Ring +1",
        ring2="Defending Ring",
        back="Fi Follet Cape +1",
        waist="Shinjutsu-no-Obi +1",
    }

    sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {
        legs=gear.Relic_Legs,
        back="Lifestream Cape",
    })

    sets.midcast.Cure = {
        main="Daybreak", 
        sub="Genmei Shield",
        head="Vanya Hood",
        body=gear.Agwu_Body, 
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Nyame_Legs,
        feet="Vanya Clogs",
        neck="Incanter's Torque",
        ear1="Meili Earring",
        ear2="Azimuth Earring +2",
        ring1="Metamorph Ring +1",
        ring2="Haoma's Ring",
        back="Solemnity Cape",
        waist="Bishop's Sash",
    }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        ring2="Metamor. Ring +1",
        waist="Luminary Sash",
    })

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        hands="Hieros Mittens",
        neck="Debilis Medallion",
        ring1="Haoma's Ring",
        ring2="Menelaus's Ring",
        back="Oretan. Cape +1",
    })

    sets.midcast['Enhancing Magic'] = {
        main=gear.Gada_ENH,
        sub="Ammurapi Shield",
        head=gear.Telchine_ENH_Head,
        body=gear.Telchine_ENH_Body,
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Telchine_ENH_Legs,
        feet=gear.Telchine_ENH_Feet,
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Fi Follet Cape +1",
        waist="Olympus Sash",
    }

    sets.midcast.EnhancingDuration = {
        main=gear.Gada_ENH,
        sub="Ammurapi Shield",
        head=gear.Telchine_ENH_Head,
        body=gear.Telchine_ENH_Body,
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Telchine_ENH_Legs,
        feet=gear.Telchine_ENH_Feet,
        waist="Embla Sash",
    }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub="Ammurapi Shield",
    })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head=gear.Amalric_A_Head,
    })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
    })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        main="Vadose Rod",
        sub="Ammurapi Shield",
        head=gear.Amalric_A_Head,
        hands="Regal Cuffs",
        ear1="Halasz Earring",
        ear2="Magnetic Earring",
        ring1="Freke Ring",
        ring2="Evanescence Ring",
        waist="Emphatikos Rope",
    })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring2="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

    sets.midcast.MndEnfeebles = {
        main="Idris",
        sub="Ammurapi Shield",
        head=empty,
        body="Cohort Cloak +1",
        hands=gear.Artifact_Hands,
        legs=gear.Artifact_Legs,
        feet=gear.Relic_Feet,
        neck="Bagua Charm +2",
        ear1="Vor Earring",
        ear2="Regal Earring",
        ring1="Kishar Ring",
        ring2=gear.Stikini_2,
        back="Aurist's Cape +1",
        waist="Luminary Sash",
    } -- MND/Magic accuracy

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        ring1="Freke Ring",
        ring2="Metamorph Ring +1",
        waist="Acuity Belt +1",
    }) -- INT/Magic accuracy

    sets.midcast['Absorb-TP'] = {
        main="Idris",
        sub="Ammurapi Shield",
        head=gear.Empyrean_Head,
        body=gear.Artifact_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Erra Pendant",
        ear1="Mani Earring",
        ear2="Regal Earring",
        ring1="Archon Ring",
        ring2="Metamorph Ring +1",
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
    }

    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak", sub="Ammurapi Shield"})

    sets.midcast['Dark Magic'] = {
        main="Rubicundity",
        sub="Ammurapi Shield",
        head=gear.Agwu_Head,
        body=gear.Agwu_Body,
        hands=gear.Agwu_Hands,
        legs=gear.Agwu_Legs,
        feet=gear.Agwu_Feet,
        neck="Erra Pendant",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1=gear.Stikini_1,
        ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
    }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head=gear.Relic_Head,
        ring1="Evanescence Ring",
        ring2="Archon Ring",
        ear1="Hirudinea Earring",
        ear2="Mani Earring",
        waist="Fucho-no-Obi",
    })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], { })

    sets.midcast['Elemental Magic'] = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Ghastly Tathlum +1",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Sibyl Scarf",
        waist="Acuity Belt +1",
        ear1="Malignance Earring",
        ear2="Azimuth Earring +2",     
        ring1="Freke Ring",
        ring2="Metamor. Ring +1",
        back=gear.GEO_MAB_Cape,
    }

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        head=empty,
        body="Crepuscular Cloak",
        ring2="Archon Ring",
    })

    sets.MagicBurst = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Ghastly Tathlum +1",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Sibyl Scarf",
        waist="Acuity Belt +1",
        ear1="Malignance Earring",
        ear2="Azimuth Earring +2", 
        ring1="Freke Ring",
        ring2="Metamorph Ring +1",
        back=gear.GEO_MAB_Cape,
    }

    sets.DarkAffinity = { head="Pixie Hairpin +1",ring2="Archon Ring" }

    sets.midcast.GeoElem = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast.Trust = sets.precast.FC

    sets.idle = {
        main="Idris",
        sub="Genmei Shield", --10
        ranged="Dunna",
        head=gear.Empyrean_Head,
        body="Shamash Robe", --10
        hands=gear.Artifact_Hands,
        legs=gear.Agwu_Legs, --7
        feet=gear.Relic_Feet,
        neck="Bagua Charm +2",
        ear1="Etiolation Earring",
        ear2="Azimuth Earring +2", --7
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.GEO_Idle_Cape,
        waist="Isa Belt",
    }

    sets.resting = set_combine(sets.idle, {
        waist="Shinjutsu-no-Obi +1",
    })

    sets.idle.DT = set_combine(sets.idle, {
        main="Idris",
        sub="Genmei Shield",
        body="Shamash Robe",
        hands=gear.Artifact_Hands,
        legs=gear.Nyame_Legs,
        neck="Loricate Torque +1",
        ear1="Lugalbanda Earring",
        ear2="Etiolation Earring",
        ring1="Gelatinous Ring +1",
        ring2="Defending Ring",
        back=gear.GEO_Idle_Cape,
        waist="Isa Belt",
    })

    sets.PetHP = { head=gear.Relic_Head }

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = { feet=gear.Artifact_Feet }

    sets.latent_refresh = {waist="Fucho-no-Obi"}

    sets.engaged = {
        main="Idris",
        sub="Genmei Shield",
        ammo="Hasty Pinion +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Artifact_Hands, -- Pet DT
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Bagua Charm +2", -- Pet Absorb
        ear1="Crepuscular Earring",
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        waist="Isa Belt", -- Pet DT
        back=gear.GEO_Idle_Cape, -- Pet Regen
    }

    sets.buff.Doom = {
        neck="Nicander's Necklace",
        ring1="Eshmun's Ring",
        ring2="Purity Ring",
        waist="Gishdubar Sash",
    }

    sets.Obi = { waist="Hachirin-no-Obi" }
    
    sets.idle.Town = set_combine(sets.MagicBurst, {
        head=gear.Agwu_Head,
        body=gear.Agwu_Body,
        hands=gear.Agwu_Hands,
        legs=gear.Agwu_Legs,
        feet=gear.Agwu_Feet,
    })
end

function job_pretarget(spell, spellMap, eventArgs)
    if spell.type == 'Geomancy' then
        if spell.name:startswith('Indi') and buffactive.Entrust and spell.target.type == 'SELF' then
            add_to_chat(002, 'Entrust active - Select a party member!')
            cancel_spell()
        end
    end
end

function job_precast(spell, action, spellMap, eventArgs)
    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
    if spell.skill == 'Elemental Magic' and spell.english ~= 'Impact' and spellMap ~= 'GeoNuke' then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value then
            equip(sets.MagicBurst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip(sets.Obi)
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip(sets.Obi)
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip(sets.Obi)
            end
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    elseif spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    elseif spell.skill == 'Geomancy' then
        if buffactive.Entrust and spell.english:startswith('Indi-') then
            equip({main=gear.Gada_INDI})
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english:startswith('Geo-') or spell.english == "Life Cycle" then
            newLuopan = 1
        end
    end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
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

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    if gain == false then
        send_command('@timers d "'..geo_timer..'"')
        newLuopan = 0
    end
end

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    handle_equipping_gear(player.status)
end

function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == 'Enfeebling Magic' then
            if spell.type == 'WhiteMagic' then
                return 'MndEnfeebles'
            else
                return 'IntEnfeebles'
            end
        elseif spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        elseif spell.skill == 'Elemental Magic' then
            if spellMap == 'GeoElem' then
                return 'GeoElem'
            end
        end
    end
end

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

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function refine_various_spells(spell, action, spellMap, eventArgs)

    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'

    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if spell.skill == 'Elemental Magic' and spellMap ~= 'GeoElem' then
            spell_index = table.find(elemental_degrade_array[spell.element],spell.name)
            if spell_index > 1 then
                newSpell = elemental_degrade_array[spell.element][spell_index - 1]
                send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        elseif spell.name:startswith('Aspir') then
            spell_index = table.find(elemental_degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = elemental_degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        end
    end
end

function job_self_command(cmdParams, eventArgs)
     if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
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