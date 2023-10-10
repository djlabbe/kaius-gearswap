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
--              [ ALT+- ]           Cycle Treasure Hunter Mode
--
-------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end


function job_setup()
    include('Mote-TreasureHunter')
    info.default_ja_ids = S{35, 204}
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
    
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    state.Buff.Doom = false
    state.Buff.AM = false
end

function user_setup()
    state.OffenseMode:options('Normal', 'PDL')
    state.HybridMode:options('Normal', 'DT', 'Evasion')
    state.RangedMode:options('Normal')
    state.WeaponskillMode:options('Normal', 'PDL')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Twashtar_Gleti', 'Twashtar_Crep', 'Twashtar_TP', 'Tauret_Gleti', 'Gandring', 'Savage'}
    state.WeaponLock = M(false, 'Weapon Lock')

    -- gear.Artifact_Head = { name="Pillager's Bonnet +1" }
    gear.Artifact_Body = { name="Pillager's Vest +3" }
    -- gear.Artifact_Hands = { name="Pillager's Armlets +1" }
    -- gear.Artifact_Legs = { name="Pillager's Culottes +1" }
    gear.Artifact_Feet = { name="Pillager's Poulaines +1" }

    gear.Relic_Head = { name="Plunderer's Bonnet +3" }
    gear.Relic_Body = { name="Plunderer's Vest +3" }
    gear.Relic_Hands = { name="Plunderer's Armlets +3" }
    gear.Relic_Legs = { name="Plunderer's Culottes +3" }
    gear.Relic_Feet = { name="Plunderer's Poulaines +3" }

    gear.Empyrean_Head = { name="Skulker's Bonnet +2" }
    gear.Empyrean_Body = { name="Skulker's Vest +2" }
    gear.Empyrean_Hands = { name="Skulker's Armlets +2" }
    gear.Empyrean_Legs = { name="Skulker's Culottes +2" }
    gear.Empyrean_Feet = { name="Skulker's Poulaines +3" }

    gear.THF_TP_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.THF_WSD_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --X
    gear.THF_CRIT_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}} --X

    include('Global-Binds.lua')

    send_command('bind ^= gs c cycle treasuremode')
    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind !numpad7 input /equip Main "Ceremonial Dagger"; input /equip Sub "Ceremonial Dagger"; input /ws "Cyclone" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad8 input /equip Main "Ceremonial Dagger"; input /equip Sub "Ceremonial Dagger"; input /ws "Energy Drain" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad9 input /equip Main "Wax Sword"; input /equip Sub "Ceremonial Dagger"; input /ws "Red Lotus Blade" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad4 input /equip Main "Wax Sword"; input /equip Sub "Ceremonial Dagger"; input /ws "Seraph Blade" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad5 input /equip Main "Ash Club"; input /equip Sub "Ceremonial Dagger"; input /ws "Seraph Strike" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad6 input /equip Main "Iapetus"; input /ws "Raiden Thrust" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad1 input /equip Main "Lament";input /ws "Freezebite" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad2 input /equip Main "Chatoyant Staff"; input /ws "Earth Crusher" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad3 input /equip Main "Chatoyant Staff"; input /ws "Sunburst" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad0 input /equip Main "Lost Sickle"; input /ws "Shadow of Death" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad. input /equip Main "Debahocho +1"; input /equip sub empty; input /ws "Blade: Ei" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad+ input /equip Main "Mutsunokami"; input /ws "Tachi: Jinpu" <t>;gs c set WeaponLock true;')
    send_command('bind !numpad- input /equip Main "Mutsunokami"; input /ws "Tachi: Koki" <t>;gs c set WeaponLock true;')

    send_command('bind !F1 input /ja "Perfect Dodge" <me>')
    send_command('bind !F2 input /ja "Larceny" <t>')

    send_command('bind !` input /ja "Flee" <me>')    
    send_command('bind !f input /ja "Feint" <me>')
    send_command('bind !b input /ja "Bully" <t>')    
    send_command('bind !h input /ja "Hide" <me>')
    send_command('bind !m input /ja "Mug" <me>')
    
    if player.sub_job == 'WAR' then
        send_command('bind !t input /ja "Provoke" <t>')
        set_macro_page(1, 6)
    elseif player.sub_job == 'DNC' then
        send_command('bind !t input /ja "Animated Flourish" <t>')
        set_macro_page(2, 6)
    else
        set_macro_page(1, 6)
    end

    send_command('bind ^numpad7 gs c set WeaponSet Twashtar_Gleti;')
    send_command('bind ^numpad8 gs c set WeaponSet Twashtar_Crep;')
    send_command('bind ^numpad9 gs c set WeaponSet Twashtar_TP;')
    send_command('bind ^numpad4 gs c set WeaponSet Tauret_Gleti;')
    send_command('bind ^numpad5 gs c set WeaponSet Gandring;')
    send_command('bind ^numpad6 gs c set WeaponSet Savage;')

    send_command('wait 3; input /lockstyleset 6')
    
    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
    check_gear_haste()
end

function user_unload()
    send_command('unbind ^=')
    send_command('unbind @w')
    send_command('unbind !F1')
    send_command('unbind !F2')
    send_command('unbind !`')    
    send_command('unbind !f')
    send_command('unbind !b')    
    send_command('unbind !h')
    send_command('unbind !m')
    send_command('unbind !t')
    unbind_numpad()
end

function init_gear_sets()
    sets.TreasureHunter = {
        feet=gear.Empyrean_Feet,
    }

    sets.buff['Sneak Attack'] = {}
    sets.buff['Trick Attack'] = {}

    sets.precast.Step = sets.TreasureHunter
    sets.precast.Flourish1 = sets.TreasureHunter
    sets.precast.JA.Provoke = sets.TreasureHunter

    sets.precast.JA['Accomplice'] = { head=gear.Empyrean_Head }
    sets.precast.JA['Aura Steal'] = { head=gear.Relic_Head }
    sets.precast.JA['Collaborator'] = set_combine(sets.TreasureHunter, { head=gear.Empyrean_Head })
    sets.precast.JA['Flee'] = { feet=gear.Artifact_Feet }
    sets.precast.JA['Hide'] = { body=gear.Artifact_Body }
    sets.precast.JA['Conspirator'] = set_combine(sets.TreasureHunter, { body=gear.Empyrean_Body })

    sets.precast.JA['Steal'] = {
        head=gear.Relic_Head,
        feet=gear.Artifact_Feet,
    }

    sets.precast.JA['Despoil'] = { 
        legs=gear.Empyrean_Legs, 
        feet=gear.Empyrean_Feet,
    }

    sets.precast.JA['Perfect Dodge'] = { hands=gear.Relic_Hands }
    sets.precast.JA['Feint'] = { legs=gear.Relic_Legs }

    sets.precast.Waltz = {
        ammo="Yamarang",
        head="Mummu Bonnet +2",
        body="Passion Jacket",
        legs="Dashing Subligar",
        neck="Unmoving Collar +1",
        ear1="Handler's Earring +1",
        ear2="Tuisto Earring",
        ring1="Asklepian Ring",
        ring2="Gelatinous Ring +1",
        waist="Gishdubar Sash",
    }

    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.FC = {
        ammo="Sapience Orb",
        head=gear.Herc_FC_Head, --13
        body=gear.Taeon_FC_Body, --9
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring2="Prolix Ring", --2
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        body="Passion Jacket",
        ring1="Lebeche Ring",
    })

    sets.precast.WS = {
        ammo="Aurgelmir Orb +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Cornelia's Ring",
        ring2="Epaminondas's Ring",
        back=gear.THF_WSD_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS['Savage Blade'] = {
        ammo="Aurgelmir Orb +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Rep. Plat. Medal",
        ear1="Telos Earring",
        ear2="Moonshade Earring",
        ring1="Cornelia's Ring",
        ring2="Epaminondas's Ring",
        back=gear.THF_WSD_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS.Critical = {
        ammo="Yetshila +1",
        ear1="Odr Earring",
    }

    sets.precast.WS['Rudra\'s Storm'] = {
        ammo="Coiste Bodhar",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Asn. Gorget +2",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Cornelia's Ring",
        ring2="Regal Ring",
        waist="Kentarch Belt +1",
        back=gear.THF_WSD_Cape,
    }

    sets.precast.WS["Rudra's Storm"].PDL = set_combine(sets.precast.WS["Rudra's Storm"], {
        ammo="Crepuscular Pebble",
        ear1="Odr Earring",
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
     })

     sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"],{
        ammo="Yetshila +1",
        ear1="Odr Earring",
    })

    sets.precast.WS["Rudra's Storm"].PDLSA = set_combine(sets.precast.WS["Rudra's Storm"].PDL, sets.precast.WS["Rudra's Storm"].SA)

    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"],{
        ammo="Yetshila +1",
        ear1="Odr Earring",
    })

    sets.precast.WS["Rudra's Storm"].PDLTA = set_combine(sets.precast.WS["Rudra's Storm"].PDL, sets.precast.WS["Rudra's Storm"].TA)

    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"],{
        ammo="Yetshila +1",
        ear1="Odr Earring",
    })

    sets.precast.WS["Rudra's Storm"].PDLSATA = set_combine(sets.precast.WS["Rudra's Storm"].PDL, sets.precast.WS["Rudra's Storm"].SATA)

    sets.precast.WS['Evisceration'] = {
        ammo="Yetshila +1",
        head="Blistering Sallet +1",
        neck="Fotia Gorget",
        body=gear.Relic_Body,
        hands=gear.Gleti_Hands,
        waist="Fotia Belt",
        legs=gear.Gleti_Legs,
        feet=gear.Gleti_Feet,
        ear1="Odr Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Begrudging Ring",
        back=gear.THF_CRIT_Cape,
    }

    sets.precast.WS['Exenterator'] = {
        ammo="Aurgelmir Orb +1",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Relic_Feet,
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Epaminondas's Ring",
        back=gear.THF_WSD_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS['Mandalic Stab'] = sets.precast.WS["Rudra's Storm"]

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        ammo="Ghastly Tathlum +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        -- feet=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Baetyl Pendant",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1="Dingir Ring",
        ring2="Epaminondas's Ring",
        waist="Orpheus's Sash",
    })

    sets.midcast.FastRecast = sets.precast.FC


    sets.defense.PDT = {

    }

    sets.defense.MDT = {

    }

    sets.Kiting = { ring1="Shneddick Ring" }

    sets.engaged = {
        ammo="Aurgelmir Orb +1",
        head=gear.Adhemar_A_Head,
        body=gear.Artifact_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Relic_Feet,
        neck="Asn. Gorget +2",
        ear1="Sherida Earring",
        ear2="Dedition Earring",
        ring1="Gere Ring",
        ring2="Hetairoi Ring",
        back=gear.THF_TP_Cape,
        waist="Windbuffet Belt +1",
    }


    -- * DNC Native DW Trait: 30% DW
    -- * DNC Job Points DW Gift: 5% DW

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
        ammo="Aurgelmir Orb +1",
        head=gear.Empyrean_Head,
        body=gear.Artifact_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Relic_Feet,
        neck="Asn. Gorget +2",
        ear1="Dedition Earring",
        ear2="Skulker's Earring +1",
        ring1="Gere Ring",
        ring2="Hetairoi Ring",
        back=gear.THF_TP_Cape,
        waist="Reiki Yotai", 
    } -- 41%

    sets.engaged.DW.ExtraHaste = set_combine(sets.engaged.DW, {
        hands=gear.Adhemar_A_Hands,
    })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = {
        ammo="Aurgelmir Orb +1",
        head=gear.Empyrean_Head,
        body=gear.Artifact_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Relic_Feet,
        neck="Asn. Gorget +2",
        ear1="Dedition Earring",
        ear2="Skulker's Earring +1",
        ring1="Gere Ring",
        ring2="Hetairoi Ring",
        back=gear.THF_TP_Cape,
        waist="Reiki Yotai", 
    } -- 37%

    sets.engaged.DW.LowHaste.ExtraHaste = set_combine(sets.engaged.DW.LowHaste, {
        hands=gear.Adhemar_A_Hands,
    })

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = {
        ammo="Aurgelmir Orb +1",
        head=gear.Empyrean_Head,
        body=gear.Artifact_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Relic_Feet,
        neck="Asn. Gorget +2",
        ear1="Dedition Earring",
        ear2="Skulker's Earring +1",
        ring1="Gere Ring",
        ring2="Hetairoi Ring",
        back=gear.THF_TP_Cape,
        waist="Reiki Yotai", 
    } -- 26%

    sets.engaged.DW.MidHaste.ExtraHaste = set_combine(sets.engaged.DW.MidHaste, {
        hands=gear.Adhemar_A_Hands,
    })

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = {
        ammo="Aurgelmir Orb +1",
        head=gear.Empyrean_Head,
        body=gear.Artifact_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Relic_Feet,
        neck="Asn. Gorget +2",
        ear1="Dedition Earring",
        ear2="Skulker's Earring +1",
        ring1="Gere Ring",
        ring2="Hetairoi Ring",
        back=gear.THF_TP_Cape,
        waist="Reiki Yotai", 
    } -- 22%

    sets.engaged.DW.HighHaste.ExtraHaste = set_combine(sets.engaged.DW.HighHaste, {
        hands=gear.Adhemar_A_Hands,
    })

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = {
        ammo="Aurgelmir Orb +1",
        head=gear.Empyrean_Head,
        body=gear.Artifact_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Relic_Feet,
        neck="Asn. Gorget +2",
        ear1="Dedition Earring",
        ear2="Skulker's Earring +1",
        ring1="Gere Ring",
        ring2="Hetairoi Ring",
        back=gear.THF_TP_Cape,
        waist="Reiki Yotai", 
    } -- 6%  (27& PDT)
    

    sets.engaged.DW.MaxHaste.ExtraHaste = set_combine(sets.engaged.DW.MaxHaste, {
        hands=gear.Adhemar_A_Hands,
    })

    sets.engaged.Hybrid = {
        -- head=gear.Malignance_Head, --6/6
        body=gear.Malignance_Body, --9/9
        -- hands=gear.Malignance_Hands, --5/5
        -- legs=gear.Malignance_Legs, --7/7
        ring2=gear.Moonlight_2, --5/5
    }

    sets.engaged.HybridEvasion = {
        ammo="Yamarang",
        head=gear.Malignance_Head, --6/6
        body=gear.Malignance_Body, --9/9
        hands=gear.Malignance_Hands, --5/5
        legs=gear.Malignance_Legs, --7/7
        feet=gear.Malignance_Feet, --7/7
        neck="Asn. Gorget +2",
        -- ring1="Vengeful Ring", 
        ring2="Ilabrat Ring", 
        -- waist="Sveltesse Gouriz +1",
        waist="Reiki Yotai",
        ear1="Eabani Earring",
        ear2="Balder Earring +1",
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Evasion = set_combine(sets.engaged, sets.engaged.HybridEvasion)
   
    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.DT.ExtraHaste = set_combine(sets.engaged.DW.ExtraHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Evasion = set_combine(sets.engaged.DW, sets.engaged.HybridEvasion)
  
    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.DT.LowHaste.ExtraHaste = set_combine(sets.engaged.DW.LowHaste.ExtraHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Evasion.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.HybridEvasion)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.DT.MidHaste.ExtraHaste = set_combine(sets.engaged.DW.MidHaste.ExtraHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Evasion.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.HybridEvasion)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.DT.HighHaste.ExtraHaste = set_combine(sets.engaged.DW.HighHaste.ExtraHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Evasion.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.HybridEvasion)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.DT.MaxHaste.ExtraHaste = set_combine(sets.engaged.DW.MaxHaste.ExtraHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Evasion.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.HybridEvasion)

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Purity Ring", --20
        waist="Gishdubar Sash", --10
    }

    sets.Twashtar_Gleti = {main="Twashtar", sub="Gleti's Knife"}
    sets.Twashtar_Crep = {main="Twashtar", sub="Crepuscular Knife"}
    sets.Twashtar_TP = {main="Twashtar", sub="Centovente"}
    sets.Tauret_Gleti = {main="Tauret", sub="Gleti's Knife"}
    sets.Gandring = {main="Gandring", sub="Gleti's Knife"}
    sets.Savage = {main="Naegling", sub="Centovente"}

    sets.resting = {}

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head=gear.Malignance_Head, --6/6
        body=gear.Malignance_Body, --9/9
        hands=gear.Malignance_Hands, --5/5
        legs=gear.Malignance_Legs, --7/7
        feet=gear.Malignance_Feet, --4/4
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Arete del Luna +1",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.THF_TP_Cape,
        waist="Carrier's Sash",
    }

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1", --3/3
        head=gear.Malignance_Head, --6/6
        body=gear.Malignance_Body, --9/9
        hands=gear.Malignance_Hands, --5/5
        legs=gear.Malignance_Legs, --7/7
        feet=gear.Malignance_Feet, --4/4
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Etiolation Earring",
        ring1="Purity Ring", --0/4
        ring2="Defending Ring", --10/10
        back="Moonlight Cape", --6/6
    })

    sets.idle.Town = set_combine(sets.precast.WS['Rudra\'s Storm'], {
        sub="Sm. Escutcheon",
        body="Blacksmith's Apron",
        hands="Smithy's Mitts",
        neck="Smithy's Torque",
        ring1="Craftmaster's Ring",
        ring2="Confectioner's Ring",
        waist="Blacksmith's Belt"
    })

end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
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
    if spell.type == "WeaponSkill" then
        if state.Buff['Sneak Attack'] == true or state.Buff['Trick Attack'] == true then
            equip(sets.precast.WS.Critical)
        end
    end
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Aeolian Edge' then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
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

    if buff == "Aftermath: Lv.3" then
        if gain then
            state.Buff.AM = true
        else
            state.Buff.AM = false
        end
    end

    if not midaction() then
        handle_equipping_gear(player.status)
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
    check_gear_haste()
    check_moving()

    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    th_update(cmdParams, eventArgs)
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

    if state.OffenseMode.value == 'PDL' then
        wsmode = (wsmode or '') .. 'PDL'
    end

    if state.Buff['Sneak Attack'] then
        wsmode = (wsmode or '') .. 'SA'
    end

    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
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
    if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end

    check_weaponset()

    return meleeSet
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
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
    if state.TreasureMode.value ~= 'None' then
        msg = msg .. ' TH: ' ..state.TreasureMode.value.. ' |'
    end
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

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 7 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 7 and DW_needed <= 22 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 22 and DW_needed <= 26 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 26 and DW_needed <= 37 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 37 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function check_gear_haste()
    if player.equipment.sub == "Centovente" then
        classes.CustomMeleeGroups:append('ExtraHaste')
    end
end

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)

    -- if (player.target ~= nil and player.target.distance < 5.0) then
    --     if state.Buff.AM == false and player.tp == 3000 then
    --         send_command("input /ws 'Rudra's Storm' <t>")
    --     elseif state.Buff.AM == true and player.tp > 1000 then
    --         send_command("input /ws 'Rudra's Storm' <t>")
    --     end
    -- end
end

function gearinfo(cmdParams, eventArgs)
    -- send_command('input /lastsynth')
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

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        if state.TreasureMode.value == 'SATA' or state.TreasureMode.value == 'Fulltime' then
            equip(sets.TreasureHunter)
        end
        eventArgs.handled = true
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