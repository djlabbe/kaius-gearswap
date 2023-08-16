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
    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Doom = false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false
    state.Buff.Sange = buffactive.Sange or false
    lugra_ws = S{'Blade: Kamu', 'Blade: Shun', 'Blade: Ten'}
end

function user_setup()
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'DT')
    state.PhysicalDefenseMode:options('PDT', 'Evasion')

    state.WeaponSet = M{['description'] = 'Weapon Set', 'Heishi', 'Kikoku', 'Naegling',}
    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')

    options.ninja_tool_warning_limit = 10

    include('Global-Binds.lua') 

    gear.Artifact_Head = { name= "Hachiya Hatsu. +3" }
    gear.Artifact_Feet = { name= "Hachiya Kyahan +3" }

    gear.Relic_Head = { name= "Mochizuki Hatsuburi +3" }
    gear.Relic_Body = { name= "Mochizuki Chainmail +3" }
    -- gear.Relic_Legs = { name= "Mochizuki Hakama +3" }
    gear.Relic_Hands = { name = "Mochizuki Tekko +3" }
    gear.Relic_Feet = { name = "Mochizuki Kyahan +3" }

    -- gear.Empyrean_Body = { name = "Hattori Ningi +1" }
    gear.Empyrean_Hands = { name = "Hattori Tekko +2" }
    gear.Empyrean_Feet = { name = "Hattori Kyahan +2" }

    gear.NIN_TP_Cape = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Damage taken-5%',}}
    gear.NIN_WS_Cape = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Damage taken-5%',}}
    gear.NIN_DA_Cape = { name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Mag. Evasion+15',}} --*

    -- send_command('bind !F1 input /ja "Mijin Gakure" <me>')
    send_command('bind !F2 input /ja "Mikage" <me>')

    send_command('bind !` input /ja "Innin" <me>')
    send_command('bind ^` input /ja "Yonin" <me>')
    send_command('bind !t input /ja "Provoke" <t>')

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')
    send_command('bind @q gs c toggle MagicBurst')

    -- send_command('bind !numpad7 input /equip Main "Ceremonial Dagger"; input /equip Sub "Ceremonial Dagger"; input /ws "Cyclone" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad8 input /equip Main "Ceremonial Dagger"; input /equip Sub "Ceremonial Dagger"; input /ws "Energy Drain" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad9 input /equip Main "Wax Sword"; input /equip Sub "Ceremonial Dagger"; input /ws "Red Lotus Blade" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad4 input /equip Main "Wax Sword"; input /equip Sub "Ceremonial Dagger"; input /ws "Seraph Blade" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad5 input /equip Main "Ash Club"; input /equip Sub "Ceremonial Dagger"; input /ws "Seraph Strike" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad6 input /equip Main "Iapetus"; input /ws "Raiden Thrust" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad1 input /equip Main "Lament";input /ws "Freezebite" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad2 input /equip Main "Profane Staff"; input /ws "Earth Crusher" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad3 input /equip Main "Profane Staff"; input /ws "Sunburst" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad0 input /equip Main "Lost Sickle"; input /ws "Shadow of Death" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad. input /equip Main "Debahocho +1"; input /equip sub empty; input /ws "Blade: Ei" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad+ input /equip Main "Mutsunokami"; input /ws "Tachi: Jinpu" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad- input /equip Main "Mutsunokami"; input /ws "Tachi: Koki" <t>;gs c set WeaponLock true;')

    send_command('bind !numpad7 input /ma "Jubaku: Ichi" <t>')
    send_command('bind !numpad8 input /ma "Hojo: Ni" <t>')
    send_command('bind !numpad9 input /ma "Aisha: Ichi" <t>')  
    send_command('bind !numpad1 input /ma "Yurin Ichi" <t>')
    send_command('bind !numpad2 input /ma "Kurayami: Ni" <t>')
    send_command('bind !numpad3 input /ma "Dokumori: Ichi" <t>')   

    -- Whether a warning has been given for low ninja tools
    state.warned = M(false)

    set_macro_page(1, 13)
    send_command('wait 3; input /lockstyleset 13')

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind ^=')
    send_command('unbind !`')
    send_command('unbind ^`>')
    send_command('unbind !t')
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @q')
    send_command('unbind !numpad7')
    send_command('unbind !numpad8')
    send_command('unbind !numpad9')  
    send_command('unbind !numpad4')
    send_command('unbind !numpad2')
    send_command('unbind !numpad3')    
end

function init_gear_sets()
    sets.Enmity = {
        ammo="Sapience Orb", --2
        body="Emet Harness +1", --10
        hands="Kurys Gloves", --9
        feet="Mochi. Kyahan +3", --8
        neck="Moonlight Necklace", --15
        ear1="Cryptic Earring", --4
        ear2="Trux Earring", --5
        -- ring1="Pernicious Ring", --5
        ring2="Eihwaz Ring", --5
        waist="Kasiri Belt", --3
    }

    sets.precast.JA['Provoke'] = sets.Enmity
    -- sets.precast.JA['Mijin Gakure'] = { legs=gear.Relic_Legs }
    sets.precast.JA['Futae'] = { hands=gear.Empyrean_Hands }
    sets.precast.JA['Sange'] = { body=gear.Relic_Body }
    sets.precast.JA['Innin'] = { head=gear.Relic_Head }
    sets.precast.JA['Yonin'] = { head=gear.Relic_Head }

    sets.precast.Waltz = {
        ammo="Yamarang",
        body="Passion Jacket",
        legs="Dashing Subligar",
        ring1="Asklepian Ring",
        waist="Gishdubar Sash",
    }

    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head=gear.Herc_FC_Head, --13
        body=gear.Taeon_FC_Body, --9
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring1="Kishar Ring", --4
        ring2="Prolix Ring", --2
        -- back=gear.NIN_FC_Cape, --10
        waist="Sailfi Belt +1",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        body=gear.Relic_Body, --14
        neck="Magoraga Beads",
    })

    sets.precast.RA = {}

    sets.precast.WS = {
        ammo="Coiste Bodhar",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Ninja Nodowa +2",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1="Epaminondas's Ring",
        ring2="Cornelia's Ring",
        back=gear.NIN_WS_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS['Blade: Shun'] = {
        ammo="Coiste Bodhar",
        head="Mpaca's Cap",
        body=gear.Malignance_Body,
        hands=gear.Adhemar_B_Hands,
        legs=gear.Mpaca_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        waist="Fotia Belt",
        ear1="Moonshade Earring",
        ear2="Hattori Earring +1",
        ring1="Gere Ring",
        ring2="Cornelia's Ring",
        back=gear.NIN_DA_Cape,
    }

    sets.precast.WS['Blade: Ten'] = {
        ammo="Coiste Bodhar",
        head=gear.Mpaca_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Rep. Plat. Medal",
        waist="Sailfi Belt +1",
        ear1="Moonshade Earring",
        ear2="Lugra Earring +1",
        ring1="Gere Ring",
        ring2="Cornelia's Ring",
        back=gear.NIN_WS_Cape,
    }

    sets.precast.WS['Blade: Hi'] = {
        ammo="Yetshila +1",
        head=gear.Relic_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        feet=gear.Nyame_Feet,
        neck="Ninja Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Odr Earring",
        ear2="Lugra Earring +1",
        ring1="Gere Ring",
        ring2="Cornelia's Ring",
        back=gear.NIN_WS_Cape,
    }

    sets.precast.WS['Blade: Metsu'] = {
        ammo="Coiste Bodhar",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Ninja Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Odr Earring",
        ear2="Lugra Earring +1",
        ring1="Gere Ring",
        ring2="Cornelia's Ring",
        back=gear.NIN_WS_Cape,
    }

  sets.precast.WS['Blade: Ku'] = {
        ammo="Seeth. Bomblet +1",
        head=gear.Adhemar_B_Head,
        body=gear.Nyame_Body,
        hands=gear.Relic_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        waist="Fotia Belt",
        ear1="Mache Earring +1",
        ear2="Lugra Earring +1",
        ring1="Gere Ring",
        ring2="Cornelia's Ring",
        back=gear.NIN_DA_Cape,
    }

    sets.precast.WS['Blade: Kamu'] = {
        ammo="Crepuscular Pebble",
        head=gear.Mpaca_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Mpaca_Legs,
        feet=gear.Nyame_Feet,
        neck="Rep. Plat. Medal",
        waist="Sailfi Belt +1", 
        ear1="Moonshade Earring",
        ear2="Lugra Earring +1",
        ring1="Gere Ring",
        ring2="Cornelia's Ring",
        back=gear.NIN_TP_Cape,
    }

    sets.precast.Hybrid = {
        ammo="Seeth. Bomblet +1",
        head=gear.Relic_Head,
        neck="Fotia Gorget",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        feet=gear.Nyame_Feet,
        legs=gear.Nyame_Legs,        
        ear1="Moonshade Earring",
        ear2="Lugra Earring +1",
        ring1="Gere Ring",
        ring2="Cornelia's Ring",
        waist="Orpheus's Sash",
        back=gear.NIN_WS_Cape,
    }

    sets.precast.WS['Blade: Teki'] = sets.precast.Hybrid
    sets.precast.WS['Blade: To'] = sets.precast.Hybrid
    sets.precast.WS['Blade: Chi'] = sets.precast.Hybrid

    sets.precast.WS['Blade: Yu'] = {
        ammo="Seeth. Bomblet +1",
        head="Hachiya Hatsu. +3",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Baetyl Pendant",
        -- ear1="Crematio Earring",
        ear2="Friomisi Earring",
        ring1="Dingir Ring",
        ring2="Cornelia's Ring",
        back=gear.NIN_MAB_Cape,
        waist="Skrymir Cord +1",
    }

    sets.precast.WS['Blade: Ei'] = {
        ammo="Seeth. Bomblet +1",
        head="Pixie Hairpin +1",
        neck="Sibyl Scarf",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        feet=gear.Nyame_Feet,
        legs=gear.Nyame_Legs,        
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1="Cornelia's Ring",
        ring2="Archon Ring",
        waist="Orpheus's Sash",
        back=gear.NIN_WS_Cape,
    }

    sets.precast.WS['Savage Blade'] = {
        ammo="Seething Bomblet +1",
        head=gear.Mpaca_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Rep. Plat. Medal",
        waist="Sailfi Belt +1",
        ear1="Moonshade Earring",
        ear2="Lugra Earring +1",
        ring1="Gere Ring",
        ring2="Cornelia's Ring",
        back=gear.NIN_WS_Cape,
    }

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        ammo="Seeth. Bomblet +1",
        head="Pixie Hairpin +1",
        neck="Sibyl Scarf",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        feet=gear.Nyame_Feet,
        legs=gear.Nyame_Legs,        
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1="Cornelia's Ring",
        ring2="Epaminondas's Ring",
        waist="Orpheus's Sash",
        back=gear.NIN_WS_Cape,
    })

    sets.Lugra = { ear2="Lugra Earring +1" }

    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --11
        body=gear.Taeon_Phalanx_Body, --10
        hands="Rawhide Gloves", --15
        legs=gear.Taeon_Phalanx_Legs, --10
        feet=gear.Taeon_Phalanx_Feet, --10
        neck="Moonlight Necklace", --15
        ear1="Halasz Earring", --5
        ear2="Magnetic Earring", --8
        ring1="Evanescence Ring", --5
        -- back=gear.NIN_FC_Cape, --10
        waist="Audumbla Sash", --10
    }

    -- Specific spells
      sets.midcast.Utsusemi = set_combine(sets.midcast.SpellInterrupt, {
        feet=gear.Empyrean_Feet,
        ear1="Eabani Earring",
        ear2="Odnowa Earring +1",
        ring2="Defending Ring",
        -- back=gear.NIN_FC_Cape,
    })

    sets.midcast.ElementalNinjutsu = {
        ammo="Ghastly Tathlum +1",
        head=gear.Relic_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Relic_Feet,
        neck="Sibyl Scarf",
        waist="Skrymir Cord +1",
        ear1="Friomisi Earring",
        ear2="Hattori Earring +1",
        ring1="Metamorph Ring +1",
        ring2="Dingir Ring",
        back=gear.NIN_TP_Cape,
    }

    sets.midcast.EnfeeblingNinjutsu = {
        ammo="Yamarang",
        head=gear.Artifact_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Artifact_Feet,
        neck="Sanctity Necklace",
        ear1="Dignitary's Earring",
        ear2="Hattori Earring +1",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        -- back=gear.NIN_MAB_Cape,
        waist="Skrymir Cord +1",
    }

    sets.midcast.EnhancingNinjutsu = {
        head=gear.Artifact_Head,
        feet=gear.Relic_Feet,
        neck="Incanter's Torque",
        -- ear1="Stealth Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        -- back="Astute Cape",
        -- waist="Cimmerian Sash",
    }

    sets.midcast.Stun = sets.midcast.EnfeeblingNinjutsu

    sets.midcast.RA = {
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Iskur Gorget",
        ear1="Telos Earring",
        ear2="Hattori Earring +1",
        ring1="Dingir Ring",
        ring2="Crepuscular Ring",
        back=gear.NIN_TP_Cape,
        waist="Yemaya Belt",
    }

    -- * NIN Native DW Trait: 35% DW
    -- No Magic Haste (74% DW to cap)
    sets.engaged = {
        ammo="Date Shuriken",
        head=gear.Ryuo_C_Head, --9
        neck="Ninja Nodowa +2",
        ear1="Dedition Earring",
        ear2="Hattori Earring +1",
        body=gear.Relic_Body, --10
        hands=gear.Malignance_Hands,
        ring1="Gere Ring",
        ring2=gear.Chirich_2,
        back=gear.NIN_TP_Cape,
        waist="Reiki Yotai", --7
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
    } -- 38%

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.LowHaste = {
        ammo="Date Shuriken",
        head=gear.Ryuo_C_Head, --9
        body=gear.Relic_Body, --10
        hands=gear.Adhemar_A_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Ninja Nodowa +2",
        ear1="Dedition Earring",
        ear2="Hattori Earring +1",
        ring1="Gere Ring",
        ring2=gear.Chirich_2,
        back=gear.NIN_TP_Cape,
        waist="Reiki Yotai", --7
    } -- 30%


    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.MidHaste = {
        ammo="Date Shuriken",
        head=gear.Ryuo_C_Head, --9
        neck="Ninja Nodowa +2",
        ear1="Dedition Earring",
        ear2="Hattori Earring +1",
        body=gear.Adhemar_A_Body, --6
        hands=gear.Adhemar_A_Hands,
        ring1="Gere Ring",
        ring2=gear.Chirich_2,
        back=gear.NIN_TP_Cape,
        waist="Reiki Yotai", --7        
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
    } -- 22%

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.HighHaste = {
        ammo="Date Shuriken",
        head=gear.Ryuo_C_Head, --9
        neck="Ninja Nodowa +2",
        ear1="Dedition Earring",
        ear2="Hattori Earring +1",
        body=gear.Malignance_Body,
        hands=gear.Adhemar_A_Hands,
        ring1="Gere Ring",
        ring2=gear.Chirich_2,
        back=gear.NIN_TP_Cape,
        waist="Reiki Yotai", --7        
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
    } -- 16%

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.MaxHaste = {
        ammo="Date Shuriken",
        head=gear.Malignance_Head,
        neck="Ninja Nodowa +2",
        ear1="Dedition Earring",
        ear2="Hattori Earring +1",
        body=gear.Malignance_Body,
        hands=gear.Adhemar_A_Hands,
        ring1="Gere Ring",
        ring2=gear.Chirich_2,
        back=gear.NIN_TP_Cape,
        waist="Sailfi Belt +1",        
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
    } -- 0%

    sets.engaged.Hybrid = {
        head=gear.Malignance_Head, --6/6
        legs=gear.Malignance_Legs, --8/8
        body=gear.Mpaca_Body,
        hands=gear.Malignance_Hands, --5/5
        feet=gear.Malignance_Feet, --4/4
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.DT.LowHaste = set_combine(sets.engaged.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DT.MidHaste = set_combine(sets.engaged.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DT.HighHaste = set_combine(sets.engaged.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DT.MaxHaste = set_combine(sets.engaged.MaxHaste, sets.engaged.Hybrid)

    sets.buff.Migawari = { }
    sets.buff.Yonin = {}
    sets.buff.Innin = {}
    -- sets.buff.Sange = { ammo="Hachiya Shuriken" }

    sets.magic_burst = {
        feet=gear.Artifact_Feet,
        neck="Warder's Charm +1",
        ring2="Mujin Band",
    }

    sets.buff.Doom = {
        neck="Nicander's Necklace",
        ring1="Eshmun's Ring",
        ring2="Purity Ring",
        waist="Gishdubar Sash",
    }

    sets.idle = {
        ammo="Date Shuriken",
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Warder's Charm +1",
        ear1="Arete Del Luna +1",
        ear2="Sanare Earring",
        ring1=gear.Chirich_1,
        ring2="Shadow Ring",
        back=gear.NIN_TP_Cape,
        waist="Engraved Belt",
    }

    sets.idle.DT = set_combine(sets.idle, {
        head=gear.Malignance_Head, --6/6
        body=gear.Malignance_Body, --9/9
        hands=gear.Malignance_Hands, --5/5
        legs=gear.Malignance_Legs, --7/7
        feet=gear.Malignance_Feet, --4/4
        neck="Warder's Charm +1",
        ear2="Etiolation Earring",
        ring1="Purity Ring", --0/4
        ring2="Defending Ring", --10/10
        back="Moonlight Cape", --6/6
    })
    
    sets.idle.Town = sets.engaged.MaxHaste

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = { feet="Danzo sune-ate" }

    sets.DayMovement = { feet="Danzo sune-ate" }
    sets.NightMovement = { feet="Hachiya Kyahan +3" }

    sets.Kikoku = {main="Kikoku", sub="Gleti's Knife"}
    sets.Heishi = {main="Heishi Shorinken", sub="Gleti's Knife"}
    sets.Naegling = {main="Naegling", sub="Uzura +2"}

end

function job_precast(spell, action, spellMap, eventArgs)
    if spell.skill == "Ninjutsu" then
        do_ninja_tool_checks(spell, spellMap, eventArgs)
    end
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if lugra_ws:contains(spell.english) and (world.time >= (17*60) or world.time <= (7*60)) then
            equip(sets.Lugra)
        end
        if spell.english == 'Blade: Yu' and (world.weather_element == 'Water' or world.day_element == 'Water') then
            equip(sets.Obi)
        end
    end

    if spellMap == 'ElementalNinjutsu' then
        if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
            equip({waist="Hachirin-no-Obi"})
        -- Target distance under 1.7 yalms.
        elseif spell.target.distance < (1.7 + spell.target.model_size) then
            equip({waist="Orpheus's Sash"})
        -- Matching day and weather.
        elseif spell.element == world.day_element and spell.element == world.weather_element then
            equip({waist="Hachirin-no-Obi"})
        -- Target distance under 8 yalms.
        elseif spell.target.distance < (8 + spell.target.model_size) then
            equip({waist="Orpheus's Sash"})
        -- Match day or weather.
        elseif spell.element == world.day_element or spell.element == world.weather_element then
            equip({waist="Hachirin-no-Obi"})
        end
    end
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spellMap == 'ElementalNinjutsu' then
        if state.MagicBurst.value then
            equip(sets.magic_burst)
        end
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
        if state.Buff.Futae then
            equip(sets.precast.JA['Futae'])
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Migawari" and not gain then
        add_to_chat(61, "*** MIGAWARI DOWN ***")
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

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

    return wsmode
end

function customize_idle_set(idleSet)
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    if state.Auto_Kite.value == true then
        if world.time >= (17*60) or world.time <= (7*60) then
            idleSet = set_combine(idleSet, sets.NightMovement)
        else
            idleSet = set_combine(idleSet, sets.DayMovement)
        end
    end

    return idleSet
end

function customize_melee_set(meleeSet)
    if state.Buff.Sange then
        meleeSet = set_combine(meleeSet, sets.buff.Sange)
    end
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

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 1 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 1 and DW_needed <= 16 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 16 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 21 and DW_needed <= 34 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 34 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
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

-- Determine whether we have sufficient tools for the spell being attempted.
function do_ninja_tool_checks(spell, spellMap, eventArgs)
    local ninja_tool_name
    local ninja_tool_min_count = 1

    -- Only checks for universal tools and shihei
    if spell.skill == "Ninjutsu" then
        if spellMap == 'Utsusemi' then
            ninja_tool_name = "Shihei"
        elseif spellMap == 'ElementalNinjutsu' then
            ninja_tool_name = "Inoshishinofuda"
        elseif spellMap == 'EnfeeblingNinjutsu' then
            ninja_tool_name = "Chonofuda"
        elseif spellMap == 'EnhancingNinjutsu' then
            ninja_tool_name = "Shikanofuda"
        else
            return
        end
    end

    local available_ninja_tools = player.inventory[ninja_tool_name] or player.wardrobe[ninja_tool_name]

    -- If no tools are available, end.
    if not available_ninja_tools then
        if spell.skill == "Ninjutsu" then
            return
        end
    end

    -- Low ninja tools warning.
    if spell.skill == "Ninjutsu" and state.warned.value == false
        and available_ninja_tools.count > 1 and available_ninja_tools.count <= options.ninja_tool_warning_limit then
        local msg = '*****  LOW TOOLS WARNING: '..ninja_tool_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.warned:set()
    elseif available_ninja_tools.count > options.ninja_tool_warning_limit and state.warned then
        state.warned:reset()
    end
end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
end