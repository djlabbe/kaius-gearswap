-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--
--  Abilities:  [ CTRL+` ]          Afflatus Solace
--              [ ALT+` ]           Afflatus Misery
--              [ ALT+- ]           Light Arts + Add White
--              [ ALT+= ]           Dark Arts + Add Dark
--              [ CTRL+; ]           Speed
--              [ CTRL+[ ]           AOE
--              [ ALT+; ]            Cost
--              [ ALT+[ ]            Power
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
-------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
    state.Buff.Doom = false
end

function user_setup()
    state.OffenseMode:options('Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'DT')

    state.BarElement = M{['description']='BarElement', 'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}
    state.BarStatus = M{['description']='BarStatus', 'Baramnesra', 'Barvira', 'Barparalyzra', 'Barsilencera', 'Barpetra', 'Barpoisonra', 'Barblindra', 'Barsleepra'}
    state.BoostSpell = M{['description']='BoostSpell', 'Boost-STR', 'Boost-INT', 'Boost-AGI', 'Boost-VIT', 'Boost-DEX', 'Boost-MND', 'Boost-CHR'}

    state.WeaponLock = M(false, 'Weapon Lock')
    state.WeaponSet = M{['description']='Weapon Set', 'Maxentius', 'Yagrush' }

    gear.Artifact_Head = { name="Theophany Cap +3", priority=64 }
    gear.Artifact_Body = { name="Theophany Bliaut +3", priority=91 }
    gear.Artifact_Hands = { name="Theophany Mitts +3", priority=43 }
    gear.Artifact_Legs = { name="Theophany Pantaloons +3", priority=74 }
    gear.Artifact_Feet = { name="Theophany Duckbills +3", priority=74 }

    gear.Relic_Head = { name="Piety Cap +3" }
    gear.Relic_Body = { name="Piety Bliaut +3" }
    gear.Relic_Hands = { name="Piety Mitts +3" }
    gear.Relic_Legs = { name="Piety Pantaloons +3" }
    gear.Relic_Feet = { name="Piety Duckbills +3" }

    gear.Empyrean_Head = { name="Ebers Cap +3", priority=64 }
    gear.Empyrean_Body = { name="Ebers Bliaut +3", priority=127 }
    gear.Empyrean_Hands = { name="Ebers Mitts +3", priority=65 }
    gear.Empyrean_Legs = { name="Ebers Pantaloons +3", priority=71 }
    gear.Empyrean_Feet = { name="Ebers Duckbills +3", priority=71 }

    gear.WHM_Cure_Cape = { name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Haste+10','Mag. Evasion+15',}} --X
    gear.WHM_DW_Cape = { name="Alaunus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}}

    include('Global-Binds.lua')

    send_command('bind !F1 input /ja "Benediction" <me>')
    send_command('bind !F2 input /ja "Asylum" <me>')

    send_command('bind !` input /ja "Afflatus Solace" <me>')
    send_command('bind ^` input /ja "Afflatus Misery" <me>')

    send_command('bind !- gs c scholar light')
    send_command('bind != gs c scholar dark')

    send_command('bind ^[ gs c scholar aoe')
    send_command('bind ^; gs c scholar speed')   
    send_command('bind !; gs c scholar cost')

    send_command('bind !numpad7 input /ma "Paralyze" <t>')
    send_command('bind !numpad8 input /ma "Slow" <t>')
    send_command('bind !numpad9 input /ma "Silence" <t>')  
    send_command('bind !insert gs c cycleback BoostSpell')
    send_command('bind !delete gs c cycle BoostSpell')
    send_command('bind !home gs c cycleback BarElement')
    send_command('bind !end gs c cycle BarElement')
    send_command('bind !pageup gs c cycleback BarStatus')
    send_command('bind !pagedown gs c cycle BarStatus')

    send_command('bind !s input /ja Sublimation <me>')
    send_command('bind !d input /ja "Divine Seal" <me>')
    send_command('bind !p input /ma "Protectra V" <me>')
    send_command('bind !o input /ma "Shellra V" <me>')
    send_command('bind !h input /ma "Haste" <stpc>')
    send_command('bind !u input /ma "Aquaveil" <me>')

    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind ^numpad7 gs c set WeaponSet Maxentius;')
    send_command('bind ^numpad8 gs c set WeaponSet Yagrush;')

    set_macro_page(1, 3)
    send_command('wait 3; input /lockstyleset 3')

    state.Auto_Kite = M(false, 'Auto_Kite')
    DW = false
    moving = false
    update_combat_form()
end

function user_unload()
    send_command('unbind !`')
    send_command('unbind ^`')
    send_command('unbind !s')

    send_command('unbind !-')
    send_command('unbind !=')

    send_command('unbind !-')
    send_command('unbind !=')

    send_command('unbind ^;')   
    send_command('unbind ^[')
    send_command('unbind !;')

    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind !home')
    send_command('unbind !end')
    send_command('unbind !pageup')
    send_command('unbind !pagedown')

    send_command('unbind !d')
    send_command('unbind !p')
    send_command('unbind !o')
    send_command('unbind !h')

    send_command('unbind @r')
    send_command('unbind @w')
    unbind_numpad()
end

function init_gear_sets()

    sets.precast.FC = {
        ammo={name="Impatiens", priority=1}, 
        head=gear.Bunzi_Head, --10
        neck={name="Cleric's Torque +2", priority=1}, --10
        ear1={name="Malignance earring", priority=1}, --4
        ear2={name="Loquac. Earring", priority=1}, --2
        body={name="Pinga Tunic +1", priority=101}, --15
        hands={name="Volte gloves", priority=1}, --6
        ring1={name="Lebeche Ring", priority=1},
        ring2={name="Kishar Ring", priority=1}, --4
        back={name="Fi Follet Cape +1", priority=1}, --10
        waist=gear.Platinum_Moogle_Belt,
        legs={name="Pinga Pants +1", priority=84}, --13
        feet={name="Regal Pumps +1", priority=13} --7
    } --81

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash",
    })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {      
        feet=gear.Kaykaus_C_Feet,
        back="Perimede Cape",
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC.CureSolace = sets.precast.FC.Cure

    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
        main="Daybreak", 
        sub="Ammurapi Shield"
    })

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
        head=empty, 
        body="Crepuscular Cloak", 
        waist="Shinjutsu-no-Obi +1"
    })

    sets.midcast.FC = sets.precast.FC

    sets.midcast.CureSolace = {
        main={name="Raetic Rod +1", priority=25}, --(CP-23) (CPII-10)
        sub={name="Genmei Shield", priority=1},-- (DT-10)
        ammo={name="Staunch Tathlum +1", priority=1}, -- (DT-3) (SIRD-11)
        head=gear.Empyrean_Head, --(CP-22)
        neck={name="Clr. Torque +2", priority=1}, --(CP-10) (Enm-25)
        ear1={name="Glorious Earring", priority=1}, -- (CPII-2) (Enm-5) 
        ear2={name="Ebers Earring +1", priority=1}, --(DT-5)
        body=gear.Empyrean_Body,
        hands=gear.Artifact_Hands, -- (CPII-4) (Enm-7)
        legs=gear.Empyrean_Legs, --(DT-13)
        feet=gear.Empyrean_Feet, --(DT-11)
        ring1={name="Gelatinous Ring +1", priority=135}, --(Enm-7)          
        ring2={name="Defending Ring", priority=1}, -- (DT-10)
        back=gear.WHM_Cure_Cape, 
        waist={name="Shinjutsu-no-Obi +1", priority=1},
    } --55 CP | 20 CPII | 51% PDT | -34 Enmity



    sets.midcast.CureSolaceWeather = set_combine(sets.midcast.CureSolace, {
        hands=gear.Empyrean_Hands, --(DT-10)
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
    }) --51% DT

    sets.midcast.CureNormal = set_combine(sets.midcast.CureSolace, {
        body=gear.Artifact_Body,
    })

    sets.midcast.CureWeather = set_combine(sets.midcast.CureNormal, {
        hands=gear.Empyrean_Hands, --(DT-10)
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
    })  --51% DT

    sets.midcast.CuragaNormal = set_combine(sets.midcast.CureNormal, {
        -- SIRD FOR Some Odyssey fights
        legs=gear.Bunzi_Legs, --(DT-9) (20 SIRD)
        -- feet=gear.Artifact_Feet, -- (29 SIRD)
    })

    sets.midcast.CuragaWeather = set_combine(sets.midcast.CureNormal, {
        hands=gear.Empyrean_Hands, --(DT-10)
        body=gear.Artifact_Body,
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
    }) --51% DT

    sets.midcast.StatusRemoval = {
        main="Yagrush",
        sub="Genmei Shield",
        head=gear.Empyrean_Body,
        body=gear.Empyrean_Body,
        hands="Fanatic Gloves",
        legs=gear.Artifact_Legs,
        feet=gear.Empyrean_Feet,
        neck="Incanter's Torque",
        ear1="Loquacious Earring",
        ear2="Etiolation Earring",
        ring1="Kishar Ring",
        back=gear.WHM_Cure_Cape,
        waist="Embla Sash",
    }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        main="Yagrush",
        sub="Genmei Shield",
        head="Vanya Hood",
        body=gear.Empyrean_Body,
        hands="Fanatic Gloves", --15
        legs=gear.Artifact_Legs, --21
        neck="Debilis Medallion", --15
        ear1="Meili Earring",
        ear2="Ebers Earring +1", --3/3
        ring1="Haoma's Ring", --15
        ring2="Menelaus's Ring", --20
        back=gear.WHM_Cure_Cape, --25
        waist="Bishop's Sash",
    })

    sets.midcast.Erase = set_combine(sets.midcast.StatusRemoval, {
        neck="Clr. Torque +2"
    })

    sets.midcast['Enhancing Magic'] = {
        main=gear.Gada_ENH,
        sub="Ammurapi Shield",
        back=gear.WHM_Cure_Cape,
        head=gear.Telchine_ENH_Head,
        body=gear.Telchine_ENH_Body,
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Telchine_ENH_Legs,
        feet=gear.Artifact_Feet,
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
        feet=gear.Artifact_Feet,
        waist="Embla Sash",
    }

    sets.midcast.Regen = {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Inyanga Tiara +2",
        neck="Incanter's Torque",
        ear2="Magnetic Earring",
        body=gear.Relic_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Artifact_Legs,
        feet=gear.Bunzi_Feet,
        back="Solemnity Cape",
        waist="Embla Sash",
    }

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
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
        head="Chironic Hat",
        hands="Regal Cuffs",
        legs="Shedir Seraweels",
        feet=gear.Artifact_Feet,
        ear1="Halasz Earring",
        ear2="Magnetic Earring",
        ring1="Freke Ring",
        ring2="Evanescence Ring",
        waist="Emphatikos Rope",
    })

    sets.midcast.Auspice = set_combine(sets.midcast.EnhancingDuration, {
        feet=gear.Empyrean_Feet,
    })

    sets.midcast.BarElement = set_combine(sets.midcast['Enhancing Magic'], {
        main="Beneficus",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Relic_Legs,
        feet=gear.Empyrean_Feet,
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Fi Follet Cape +1",
        waist="Embla Sash",
    })

    sets.midcast.BarStatus = set_combine(sets.midcast.BarElement, {
        neck="Sroda Necklace",
    });

    sets.midcast.BoostStat = set_combine(sets.midcast['Enhancing Magic'], {
        feet=gear.Empyrean_Feet,
    })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
        ring1="Sheltered Ring",
    })

    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

    sets.midcast['Divine Magic'] = {
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Ghastly Tathlum +1",
        head=gear.Empyrean_Head,
        body=gear.Artifact_Body,
        hands=gear.Relic_Hands,
        legs=gear.Artifact_Legs,
        feet=gear.Artifact_Feet,
        neck="Erra Pendant",
        ear1="Regal Earring",
        ear2="Ebers Earring +1",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
    }

    sets.midcast.Banish = set_combine(sets.midcast['Divine Magic'], {
        head=empty;
        body="Cohort Cloak +1",
        hands=gear.Bunzi_Hands,
        legs=gear.Bunzi_Legs,
        ear1="Malignance Earring", 
        ring1="Freke Ring",
    })

    sets.midcast.Holy = sets.midcast.Banish

    sets.midcast['Dark Magic'] = {
        main="Rubicundity",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        body=gear.Artifact_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Chironic_ENF_Legs,
        feet=gear.Artifact_Feet,
        neck="Erra Pendant",
        ear1="Mani Earring",
        ear2="Malignance Earring",
        ring1="Evanescence Ring",
        ring2="Archon Ring",
        back="Aurist's Cape +1",
        waist="Fucho-no-Obi",
    }

    sets.midcast.MndEnfeebles = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head=gear.Artifact_Head;
        body=gear.Artifact_Body,
        hands="Regal Cuffs",
        legs=gear.Chironic_ENF_Legs,
        feet=gear.Artifact_Feet,
        neck="Erra Pendant",
        ear1="Regal Earring",
        ear2="Ebers Earring +1",
        ring1="Kishar Ring",
        ring2="Metamorph Ring +1",
        back="Aurist's Cape +1",
        waist="Obstinate Sash",
    }

    sets.midcast.IntEnfeebles = set_combine(sets.midcast.MndEnfeebles, {
        waist="Acuity Belt +1",
    })

    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeebles, {main="Daybreak", sub="Ammurapi Shield"})

    sets.midcast.Impact = {
        main="Yagrush",
        sub="Ammurapi Shield",
        head=empty,
        body="Crepuscular Cloak",
        hands=gear.Artifact_Hands,
        legs=gear.Artifact_Legs,
        feet=gear.Artifact_Feet,
        ring1="Freke Ring",
        ring2="Archon Ring",
    }

    sets.midcast.Trust = sets.precast.FC


    sets.engaged.DW = {
        ammo="Hasty Pinion +1",
        head=gear.Bunzi_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Rep. Plat. Medal",
        ear1="Crepuscular Earring",
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.WHM_Cure_Cape,
        waist="Windbuffet Belt +1",
    }

    sets.precast.WS = {
        ammo="Oshasha's Treatise",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1=gear.Cornelia_Or_Epaminondas,
        ring2="Ilabrat Ring",
        back=gear.WHM_Cure_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS, {
        neck="Rep. Plat. Medal",
    })

    sets.buff['Divine Caress'] = {
        hands=gear.Empyrean_Hands, 
        back="Mending Cape"
    }

    sets.buff['Devotion'] = { head=gear.Relic_Head }
    sets.buff.Sublimation = { waist="Embla Sash" }
    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Purity Ring", --20
        waist="Gishdubar Sash", --10
    }
    sets.Obi = {waist="Hachirin-no-Obi"}

    sets.resting = {
        main="Chatoyant Staff",
        waist="Shinjutsu-no-Obi +1",
    }

    sets.idle = {
        main="Mpaca's Staff",
        sub="Irenic Strap +1",
        ammo="Staunch Tathlum +1", --3
        head=gear.Bunzi_Head, --7
        body=gear.Empyrean_Body,
        hands=gear.Bunzi_Hands, --8
        legs=gear.Empyrean_Legs, --13
        feet=gear.Empyrean_Feet, --11
        neck="Sibyl Scarf",
        ear1="Sanare Earring",
        ear2="Ebers Earring +1", --5
        ring1=gear.Gerubu_Or_Stikini1,
        ring2=gear.Stikini_2,
        back=gear.WHM_Cure_Cape,
        waist=gear.Platinum_Moogle_Belt, --3
    } --50/30 (10 Refresh)

    sets.idle.DT = set_combine(sets.idle, {
        main="Daybreak",
        sub="Genmei Shield",
        ammo="Staunch Tathlum +1",
        head=gear.Bunzi_Head,
        body=gear.Empyrean_Body,
        hands=gear.Bunzi_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Bunzi_Feet,
        neck="Sibyl Scarf",
        ear1="Sanare Earring",
        ear2="Eabani Earring",
        ring1=gear.Gerubu_Or_Stikini1,
        ring2=gear.Stikini_2,
        back=gear.WHM_Cure_Cape,
        waist="Carrier's Sash",
    }) --50/30 (10 Refresh)

    -- sets.idle.Town = set_combine(sets.idle, {
    --     main="Yagrush",
    --     sub="Ammurapi Shield",
    -- })

    sets.idle.Town =sets.idle
    sets.engaged = sets.idle


    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT
    
    sets.Kiting = { ring1="Shneddick Ring +1" }
    sets.latent_refresh = { waist="Fucho-no-obi" }
    sets.DefaultShield = { sub="Genmei Shield" }

    sets.Maxentius = { main="Maxentius", sub="Sindri" }
    sets.Yagrush = { main="Yagrush", sub="Sindri" }
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    end
    if spellMap == 'Banish' or spellMap == "Holy" then
        if (world.weather_element == 'Light' or world.day_element == 'Light') then
            equip(sets.Obi)
        end
    end
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Sleep II" then
            send_command('@timers c "Sleep II ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sleep" or spell.english == "Sleepga" then -- Sleep & Sleepga Countdown --
            send_command('@timers c "Sleep ['..spell.target.name..']" 60 down spells/00253.png')
        elseif spell.english == "Repose" then
            send_command('@timers c "Repose ['..spell.target.name..']" 90 down spells/00098.png')
        end
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

function job_buff_change(buff,gain)
    if buff == "Sublimation: Activated" then
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

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    determine_haste_group()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    update_sublimation()
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' then
            if buffactive['Afflatus Solace'] then
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureSolaceWeather"
                else
                    return "CureSolace"
              end
            else
                if (world.weather_element == 'Light' or world.day_element == 'Light') then
                    return "CureWeather"
                else
                    return "CureNormal"
              end
            end
        elseif default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return "CuragaWeather"
            else
                return "CuragaNormal"
            end
        elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    check_weaponset()
    return meleeSet
end

function customize_idle_set(idleSet)
    if state.Buff['Sublimation: Activated'] then
        idleSet = set_combine(idleSet, sets.buff.Sublimation)
    end
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
-- Return true if display was handled, and you don't want the default info shown.
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

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'barelement' then
        send_command('@input /ma '..state.BarElement.value..' <me>')
    elseif cmdParams[1]:lower() == 'barstatus' then
        send_command('@input /ma '..state.BarStatus.value..' <me>')
    elseif cmdParams[1]:lower() == 'boostspell' then
        send_command('@input /ma '..state.BoostSpell.value..' <me>')
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

function update_sublimation()
    state.Buff['Sublimation: Activated'] = buffactive['Sublimation: Activated'] or false
end

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 11 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 11 and DW_needed <= 27 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 27 and DW_needed <= 31 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 31 and DW_needed <= 42 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 42 then
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
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
       equip(sets.DefaultShield)
    end
end