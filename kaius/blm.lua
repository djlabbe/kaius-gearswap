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
-------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
    state.Buff.Doom = false
    Elemental_Aja = S{'Stoneja', 'Waterja', 'Aeroja', 'Firaja', 'Blizzaja', 'Thundaja', 'Comet'}
    Aja_Duration_Boost = false
    Aja_Table = {} -- List of -ja debuffed mobs
    Aja_Table_ind = 0 --Used to create "uniqueness" for each mob in queue
    Aja_Current_Boost = "" -- Stores current cumulative magic effect.
end

function user_setup()
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT')
    state.DeathMode = M(false, 'Death Mode')
    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(true, 'Magic Burst')

    include('Global-Binds.lua')

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @q gs c toggle MagicBurst')
    send_command('bind @d gs c toggle DeathMode')

    send_command('bind !p input /ma "Protect III" <stpc>')
    send_command('bind !o input /ma "Shell II" <stpc>')
    send_command('bind !i input /ma "Blink" <me>')
    send_command('bind !u input /ma "Aquaveil" <me>')
    send_command('bind !s input /ja Sublimation <me>')

    send_command('bind !` input /ja "Mana Wall" <me>')
    send_command('bind !t input /ma "Stun" <t>')
    send_command('bind !b input /ma "Bind" <t>')
    send_command('bind !e input /ja "Elemental Seal" <me>')
    send_command('bind !m input /ws "Myrkr" <me>')
    send_command('bind @1 input /ws "Vidohunir" <t>')

    send_command('bind !F1 input /ja "Manafont" <me>')
    send_command('bind !F2 input /ja "Subtle Sorcery" <me>')
    
    if player.sub_job == 'RDM' then
        send_command('bind !g input /ma "Gravity" <t>')
    end

    if player.sub_job == 'SCH' then
        send_command('bind !- gs c scholar light')
        send_command('bind != gs c scholar dark')

        send_command('bind ^; gs c scholar speed')   
        send_command('bind ^[ gs c scholar aoe')
        send_command('bind !; gs c scholar cost')
        send_command('bind ![ gs c scholar power')
    end

    set_macro_page(1, 4)
    send_command('wait 3; input /lockstyleset 4')
    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind !t')
    send_command('unbind @q')
    send_command('unbind @d')
    send_command('unbind @w') 
    send_command('unbind !g')
    send_command('unbind !b')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^;')   
    send_command('unbind ^[')
    send_command('unbind !;')
    send_command('unbind ![')
    unbind_numpad()
end


function init_gear_sets()
    -- gear.Artifact_Head = { name="Spaekona's Petasos +3" }
    gear.Artifact_Body = { name="Spaekona's Coat +3" }
    -- gear.Artifact_Hands = { name="Spaekona's Gloves +3" }
    -- gear.Artifact_Legs = { name="Spaekona's Tonban +2" }
    -- gear.Artifact_Feet = { name="Spaekona's Sabots +2" }

    gear.Relic_Head = { name="Archmage's Petasos +3" }
    gear.Relic_Body = { name="Archmage's Coat +3" }
    gear.Relic_Hands = { name="Archmage's Gloves +3" }
    gear.Relic_Legs = { name="Archmage's Tonban +3" }
    gear.Relic_Feet = { name="Archmage's Sabots +3" }

    gear.Empyrean_Head = { name="Wicce Petasos +3" }
    gear.Empyrean_Body = { name="Wicce Coat +3" }
    gear.Empyrean_Hands = { name="Wicce Gloves +3" }
    gear.Empyrean_Legs = { name="Wicce Chausses +3" }
    gear.Empyrean_Feet = { name="Wicce Sabots +3" }

    gear.BLM_MAB_Cape = { name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}} --X
    gear.BLM_Death_Cape = { name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10','Damage taken-5%',}}

    sets.precast.JA['Mana Wall'] = {
        feet=gear.Empyrean_Feet,
    }

    sets.precast.JA.Manafont = { body=gear.Relic_Body }

    sets.precast.FC = {
        ammo="Sapience Orb",
        head=gear.Amalric_A_Head,
        body="Zendik Robe",
        hands=gear.Agwu_Hands,
        legs=gear.Agwu_Legs,
        feet=gear.Merlinic_FC_Feet,
        neck="Orunmila's Torque",
        ear1="Malignance Earring",
        ear2="Enchanter's Earring +1",
        ring1="Kishar Ring",
        ring2="Lebeche Ring",
        back="Fi Follet Cape +1",
        waist="Embla Sash",
    } 
    
    sets.precast.FC.DeathMode = {
        main="Hvergelmir",
        sub="Khonsu",
        ammo="Ghastly Tathlum +1",
        head=gear.Amalric_A_Head, --11
        body="Rosette jaseran +1",
        hands=gear.Agwu_Hands, --6
        legs="Psycloth Lapas", --8
        feet=gear.Amalric_A_Feet, --6
        neck="Orunmila's Torque", --5
        ear1="Etiolation Earring", --1
        ear2="Loquacious Earring", --2
        ring1="Mephitas's Ring",
        ring2="Mephitas's Ring +1",
        back=gear.BLM_Death_Cape, --4
        waist="Shinjutsu-no-Obi +1",
    }

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",
        back="Perimede Cape",
    })

    -- 8% From JP, 30 from celerity, (10 from /SCH) = 32% Needed
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {
        ammo="Impatiens",
        head=gear.Empyrean_Head,
        body="Zendik Robe",
        hands=gear.Agwu_Hands,
        legs=gear.Agwu_Legs,
        feet=gear.Empyrean_Feet,
        neck="Orunmila's Torque",
        ear1="Malignance Earring",
        ear2="Enchntr. Earring +1",
        back="Fi Follet Cape +1",
        waist="Shinjutsu-no-Obi +1",
        ring1="Lebeche Ring",
        ring2="Defending Ring",       
    })

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
        head=empty, 
        body="Crepuscular Cloak", 
        waist="Shinjutsu-no-Obi +1"
    })

    sets.precast.FC.Impact.DeathMode = set_combine(sets.precast.FC.DeathMode, {
        head=empty, 
        body="Crepuscular Cloak", 
        waist="Shinjutsu-no-Obi +1"
    })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ear1="Mendi. Earring",
        ring1="Lebeche Ring",
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
        main="Daybreak", 
        sub="Ammurapi Shield", 
        waist="Shinjutsu-no-Obi +1"
    })

    sets.precast.Storm = set_combine(sets.precast.FC, {
        ring2=gear.Stikini_2,
    })

    sets.precast.WS = {
        ammo="Ghastly Tathlum +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Telos Earring",
        ring1="Epaminondas's Ring",
        ring2="Ephramad's Ring",
        back=gear.BLM_MAB_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS['Myrkr'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body=gear.Empyrean_Body,
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Relic_Feet,
        neck="Orunmila's Torque",
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        ring1="Mephitas's Ring +1",
        ring2="Fenrir Ring +1",
        back="Bane Cape",
        waist="Shinjutsu-no-Obi +1",s
    } -- Max MP

    sets.precast.WS['Vidohunir'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body=gear.Nyame_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Nyame_Feet,
        neck="Src. Stole +2",
        waist="Orpheus's Sash",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Archon Ring",
        ring2=gear.Ephramad_Or_Petrov,
        back=gear.BLM_MAB_Cape, --WSD Better
    }

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Cure = {
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        body="Shamash Robe",
        hands=gear.Telchine_ENH_Hands,
        feet="Vanya Clogs",
        neck="Nodens Gorget",
        ear1="Mendi. Earring",
        ear2="Regal Earring",
        ring1="Lebeche Ring",
        ring2="Haoma's Ring",
        back="Oretan. Cape +1",
        waist="Bishop's Sash",
    }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        ring1=gear.Stikini_1,
        ring2="Metamor. Ring +1",
        waist="Luminary Sash",
    })

    sets.midcast.Cursna = set_combine(sets.midcast.Cure, {
        main=gear.Gada_ENH,
        sub="Genmei Shield",
        head="Vanya Hood",
        body="Shamash Robe",
        -- hands="Hieros Mittens",
        feet="Vanya Clogs",
        neck="Debilis Medallion",
        ear1="Meili Earring",
        ear2="Lugalbanda Earring",
        ring1="Menelaus's Ring",
        ring2="Haoma's Ring",
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
        head=gear.Telchine_ENH_Head,
        body=gear.Telchine_ENH_Body,
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Telchine_ENH_Legs,
        feet=gear.Telchine_ENH_Feet,
    })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head=gear.Amalric_A_Head,
        waist="Gishdubar Sash",
    })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
    })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        main="Vadose Rod",
        sub="Ammurapi Shield",
        ammo="Staunch Tathlum +1",
        head=gear.Amalric_A_Head,
        hands="Regal Cuffs",
        ear1="Halasz Earring",
        ring1="Freke Ring",
        ring2="Evanescence Ring",
        waist="Emphatikos Rope",
    })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
        ring1="Sheltered Ring"
    })

    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

    sets.midcast.MndEnfeebles = {
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head=empty;
        body="Cohort Cloak +1",
        hands="Regal Cuffs",
        legs="Ea Slops +1",
        feet=gear.Empyrean_Feet,
        neck="Erra Pendant",
        ear1="Malignance Earring",
        ear2="Vor Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Aurist's Cape +1",
        waist="Luminary Sash",
    } -- MND/Magic accuracy

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        main="Maxentius",
        sub="Ammurapi Shield",
        waist="Acuity Belt +1",
    }) -- INT/Magic accuracy

    sets.midcast.ElementalEnfeeble =  {
        ammo="Pemphredo Tathlum",
        head=gear.Empyrean_Head,
        body=gear.Artifact_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Relic_Legs,
        feet=gear.Relic_Feet,
        neck="Sorcerer's Stole +2",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1=gear.Stikini_1,
        ring2="Metamorph Ring +1",
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
    }
    
    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})

    sets.midcast['Dark Magic'] = {
        main="Rubicundity",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Ea Hat +1",
        body="Ea Houppe. +1",
        hands=gear.Empyrean_Hands,
        legs="Ea Slops +1",
        feet=gear.Agwu_Feet,
        neck="Erra Pendant",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.BLM_MAB_Cape,
        waist="Acuity Belt +1",
    }

    sets.midcast.Drain = {
        main="Rubicundity",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head=gear.Merlinic_DRAIN_Head,
        body=gear.Merlinic_DRAIN_Body,
        hands=gear.Merlinic_DRAIN_Hands,
        legs=gear.Artifact_Legs,
        feet=gear.Agwu_Feet,
        neck="Erra Pendant",
        ear1="Hirudinea Earring",
        ear2="Regal Earring",
        ring1="Evanescence Ring",
        ring2="Archon Ring",
        back="Aurist's Cape +1",
        waist="Fucho-no-obi",
    }

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Death = {
        main="Hvergelmir",
        sub="Khonsu",
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body=gear.Merlinic_MB_Body,
        hands=gear.Artifact_Hands, 
        legs=gear.Empyrean_Feet,
        feet=gear.Artifact_Feet,
        neck="Sorcerer's stole +2",
        ear1="Barkarole Earring",
        ear2="Regal Earring",
        ring1="Archon Ring",
        ring2="Metamor. Ring +1",
        back=gear.BLM_Death_Cape,
        waist="Acuity Belt +1",
    }

    sets.midcast.Death.Resistant = sets.midcast.Death

    sets.midcast.Death.Resistant = set_combine(sets.midcast.Death, {
        head=gear.Amalric_A_Head,
    })

    sets.midcast['Elemental Magic'] = {
        main="Laevateinn",
        sub="Enki Strap",
        ammo="Sroda Tathlum",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Sorcerer's Stole +2",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2=gear.Medada_Or_Metamorph,
        back=gear.BLM_MAB_Cape,
        waist="Acuity Belt +1",
    }

    sets.MagicBurst = {
        main="Laevateinn",
        sub="Enki Strap",
        ammo="Ghastly Tathlum +1",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Agwu_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Agwu_Feet,
        neck="Sorcerer's Stole +2",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2=gear.Medada_Or_Metamorph,
        back=gear.BLM_MAB_Cape,
        waist="Acuity Belt +1",
    }

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        head=empty,
        body="Crepuscular Cloak",
        ring2="Archon Ring",
    })
    
    sets.midcast['Elemental Magic'].DeathMode = set_combine(sets.midcast['Elemental Magic'], {
        ammo="Ghastly Tathlum +1",
        back=gear.BLM_Death_Cape,
    })

    sets.midcast['Elemental Magic'].Resistant = set_combine(sets.midcast['Elemental Magic'], {})

    sets.midcast.Impact.Resistant = set_combine(sets.midcast['Elemental Magic'].Resistant, {
        sub="Khonsu",
        head=empty,
        body="Crepuscular Cloak",
    })

    sets.midcast.Trust = sets.precast.FC

    sets.resting = {
        main="Chatoyant Staff",
        waist="Shinjutsu-no-Obi +1",
    }

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = { ring1="Shneddick Ring +1" }
    sets.latent_refresh = { waist="Fucho-no-obi" }

    sets.engaged = {
        ammo="Hasty Pinion +1",
        head="Blistering Sallet +1",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Sanctity Necklace",
        ear1="Crepuscular Earring",
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        waist="Windbuffet Belt +1",
        back=gear.BLM_MAB_Cape,
    }

    sets.buff.Doom = {
        neck="Nicander's Necklace",
        ring1="Eshmun's Ring",
        ring2="Purity Ring",
        waist="Gishdubar Sash",
    }

    sets.Coat = {
        body="Spaekona's Coat +3"
    }

    sets.DarkAffinity = { head="Pixie Hairpin +1",ring2="Archon Ring" }
    sets.Obi = { waist="Hachirin-no-Obi" }

    sets.idle = {
        main="Laevateinn",
        sub="Enki Strap",
        ammo="Ghastly Tathlum +1",
        head=gear.Empyrean_Head,
        body="Shamash Robe",
        hands="Volte Gloves",
        legs="Assid. Pants +1",
        feet=gear.Nyame_Feet,
        neck="Sibyl Scarf",
        ear1="Etiolation Earring",
        ear2="Lugalbanda Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.BLM_MAB_Cape,
        waist="Platinum Moogle Belt",
    }

    sets.idle.DT = set_combine(sets.idle, {
        main="Laevateinn",
        sub="Enki Strap",
        ammo="Staunch Tathlum +1",
        head=gear.Empyrean_Head,
        body="Shamash Robe", 
        hands="Volte Gloves",
        feet=gear.Nyame_Feet,
        neck="Loricate Torque +1",
        ear1="Etiolation Earring",
        ear2="Lugalbanda Earring",
        ring1="Gelatinous Ring +1",
        ring2="Defending Ring",
        back=gear.BLM_MAB_Cape,
        waist="Platinum Moogle Belt",
    })

    sets.idle.DeathMode = {
        ammo="Ghastly Tathlum +1",
        head=gear.Empyrean_Head,
        body="Ros. Jaseran +1",
        hands=gear.Nyame_Hands,
        legs=gear.Amalric_A_Legs,
        feet=gear.Empyrean_Feet,
        neck="Sanctity Necklace",
        ear1="Nehalennia Earring",
        ear2="Etiolation Earring",
        ring1="Mephitas's Ring",
        ring2="Mephitas's Ring +1",
        back=gear.BLM_Death_Cape,
        waist="Shinjutsu-no-Obi +1",
    }

    sets.idle.ManaWall = {
        body="Shamash Robe",
        feet=gear.Empyrean_Feet,
    }

    sets.idle.Town = sets.MagicBurst
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
     if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        equip(sets.precast.FC.DeathMode)
        if spell.english == "Impact" then
            equip(sets.precast.FC.Impact.DeathMode)
        end
    end
    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
    if spell.skill == 'Elemental Magic' and spell.english ~= 'Impact' and spellMap ~= 'Helix' then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' and state.DeathMode.value then
        eventArgs.handled = true
        if spell.skill == 'Elemental Magic' then
            equip(sets.midcast['Elemental Magic'].DeathMode)
        else
            if state.CastingMode.value == "Resistant" then
                equip(sets.midcast.Death.Resistant)
            else
                equip(sets.midcast.Death)
            end
        end
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) and not state.DeathMode.value then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
    if spell.skill == 'Elemental Magic' and spell.english == "Comet" then
        equip(sets.DarkAffinity)
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            equip(sets.MagicBurst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
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
        if player.mpp < 50 then
            equip(sets.Coat)
        end
    end
    if buffactive['Mana Wall'] then
        equip(sets.precast.JA['Mana Wall'])
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.action_type == 'Magic' then
            if Elemental_Aja:contains(spell.english) then	
                if (Aja_Duration_Boost == false or Aja_Current_Boost ~= spell.english) then
                    Aja_Current_Boost = spell.english
                    Aja_Table_ind = Aja_Table_ind + 1
                    table.insert(Aja_Table, tostring(spell.target.name .. " #" .. Aja_Table_ind))
                    send_command('timers create "'.. spell.english .. ': ' .. Aja_Table[Aja_Table_ind] .. '" 105 down spells/01015.png')
                    Aja_Duration_Boost = true
                    send_command('wait 105;input //gs c reset Aja_Duration Timer')
                end
            end
        end
        if spell.english == "Sleep II" or spell.english == "Sleepga II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Break" or spell.english == "Breakga" then
            send_command('@timers c "Break ['..spell.target.name..']" 30 down spells/00255.png')
        end
    end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Unlock armor when Mana Wall buff is lost.
    if buff== "Mana Wall" then
        if gain then
            equip(sets.precast.JA['Mana Wall'])
        else
            handle_equipping_gear(player.status)
        end
    end

    if buff == "Doom" then
        if gain then
            state.Buff.Doom = true
            send_command('@input /p Doomed.')
        else
            state.Buff.Doom = false
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

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if buffactive['Mana Wall'] then
        idleSet = set_combine(idleSet, sets.precast.JA['Mana Wall'])
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
    if state.DeathMode.value then
        idleSet = sets.idle.DeathMode
    end
    if buffactive['Mana Wall'] then
        meleeSet = set_combine(meleeSet, sets.precast.JA['Mana Wall'])
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Mana Wall'] then
        defenseSet = set_combine(defenseSet, sets.precast.JA['Mana Wall'])
    end
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end

    return defenseSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local msg = ''
    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(060, '| Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002).. msg)

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
            if spell_index ~= nil and spell_index > 1 then
                newSpell = elemental_degrade_array[spell.element][spell_index - 1]
                send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        elseif spell.name:startswith('Aspir') then
            spell_index = table.find(elemental_degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = elemental_degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
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

    if cmdParams[1]:lower() == "reset" then
        if cmdParams[2]:lower() == "aja_duration" then
            if (cmdParams[3]:lower() == "timer") then
                send_command("@input /echo <----- ".. Aja_Table[1] ..": Cumulative Magic Effect Has Worn Off ----->")
                table.remove(Aja_Table,1)
                Aja_Table_ind = Aja_Table_ind - 1
                if Aja_Table[1] == nil then
                    Aja_Duration_Boost = false
                    send_command("@input /echo <----- All Cumulative Magic Duration Effects Have Expired ----->")
                end
            end
        end
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
