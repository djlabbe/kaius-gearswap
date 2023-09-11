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
--  Abilities:  [ ALT+` ]           Use current Rune
--              [ CTRL+Insert ]     Rune element cycle forward.
--              [ CTRL+Delete ]     Rune element cycle backward.
--
--  Weapons:    [ CTRL+W ]          Toggle Weapon Lock
--
-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------
--  gs c rune                       Uses current rune
--  gs c cycle Runes                Cycles forward through rune elements
--  gs c cycleback Runes            Cycles backward through rune elements
-------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
    res = require 'resources'
end

function job_setup()
    rune_enchantments = S{'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}
    blue_magic_maps = {}
    blue_magic_maps.Enmity = S{'Blank Gaze', 'Geist Wall', 'Jettatura', 'Soporific', 'Poison Breath', 'Blitzstrahl', 'Sheep Song', 'Chaotic Eye'}
    blue_magic_maps.Cure = S{'Wild Carrot'}
    blue_magic_maps.Buffs = S{'Cocoon', 'Refueling'}
    state.Buff.Doom = false
end

function user_setup()
    state.OffenseMode:options('Normal')
    state.WeaponskillMode:options('Normal')
    state.HybridMode:options('Normal', 'DD')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'DT', 'Phalanx', 'Refresh')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')

    state.PhalanxMode = M(false, 'Equip Phalanx Gear')
    state.WeaponSet = M{['description']='Weapon Set', 'Epeolatry', 'Helheim', 'Lycurgos'}
    state.WeaponLock = M(false, 'Weapon Lock')

    state.Runes = M{['description']='Runes', 'Ignis', 'Gelus', 'Flabra', 'Tellus', 'Sulpor', 'Unda', 'Lux', 'Tenebrae'}

    gear.Artifact_Head = { name="Runeist Bandeau +3", priority=109 }
    gear.Artifact_Body = { name="Runeist Coat +3", priority=218 }
    gear.Artifact_Hands = { name="Runeist Mitons +3", priority=85 }
    gear.Artifact_Legs = { name="Runeist Trousers +1", priority=80 }
    gear.Artifact_Feet = { name="Runeist Bottes +1", priority=74 }

    gear.Relic_Head = { name="Futhark Bandeau +3", priority=56 }
    gear.Relic_Body = { name="Futhark Coat +3", priority=119 }
    gear.Relic_Hands = { name="Futhark Mitons +3", priority=45 }
    gear.Relic_Legs = { name="Futhark Trousers +3", priority=107 }
    gear.Relic_Feet = { name="Futhark Boots +3", priority=33 }

    gear.Empyrean_Head = { name="Erilaz Galea +3", priority=111 }
    gear.Empyrean_Body = { name="Erilaz Surcoat +3", priority=143 }
    gear.Empyrean_Hands = { name="Erilaz Gauntlets +3", priority=59 }
    gear.Empyrean_Legs = { name="Erilaz Leg Guards +3", priority=100 }
    gear.Empyrean_Feet = { name="Erilaz Greaves +3", priority=48 }

    gear.RUN_HPD_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}, priority=60}
    gear.RUN_FC_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Phys. dmg. taken-10%',}, priority=60}
    gear.RUN_SIRD_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Spell interruption rate down-10%',}, priority=60}

    -- These are capes that I haven't made yet. I just use capes I have made as placeholders.
    gear.RUN_HPP_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}, priority=60}
    gear.RUN_TP_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}, priority=60}
    gear.RUN_WS1_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}, priority=60}
    gear.RUN_WS2_Cape = { name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}, priority=60}

    include('Global-Binds.lua')

    send_command('bind !F1 input /ja "Elemental Sforzo" <me>')
    send_command('bind !F2 input /ja "Odyllic Subterfuge" <t>')

    send_command('bind !` input //gs c rune')
    send_command('bind ^` input /ja "Vivacious Pulse" <me>')

    send_command('bind !p input /ma "Protect IV" <stpc>')
    send_command('bind !o input /ma "Shell V" <stpc>')
    send_command('bind !i input /ma "Phalanx" <me>')
    send_command('bind !u input /ma "Aquaveil" <me>')
    send_command('bind !y input /ma "Refresh" <me>')
    send_command('bind !m input /ja "Embolden" <me>')

    -- send_command('bind ![ input /ma "Crusade" <me>')

    send_command('bind ^[ input /ma "Temper" <me>')
    send_command('bind ^] input /ja "Swordplay" <me>')

    send_command('bind !insert gs c cycleback Runes')
    send_command('bind !delete gs c cycle Runes')

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind ^p gs c toggle PhalanxMode')

    if player.sub_job == 'SCH' then
        send_command('bind !- gs c scholar light')
        send_command('bind != gs c scholar dark')

        send_command('bind ^; gs c scholar speed')   
        send_command('bind ^[ gs c scholar aoe')
        send_command('bind !; gs c scholar cost')
        send_command('bind ![ gs c scholar power')
    end

    if player.sub_job == 'SAM' then
        send_command('bind ^numpad7 gs c set WeaponSet Epeolatry;input /macro set 2')
        send_command('bind ^numpad8 gs c set WeaponSet Helheim;input /macro set 2')
        send_command('bind ^numpad9 gs c set WeaponSet Lycurgos;input /macro set 2')
        set_macro_page(2, 22)
    else   
        send_command('bind ^numpad7 gs c set WeaponSet Epeolatry;input /macro set 1')
        send_command('bind ^numpad8 gs c set WeaponSet Helheim;input /macro set 1')
        send_command('bind ^numpad9 gs c set WeaponSet Lycurgos;input /macro set 1')
        set_macro_page(1, 22)
    end

    send_command('wait 3; input /lockstyleset 22')

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind !F1')
    send_command('unbind !F2')
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind !p')
    send_command('unbind !o')
    send_command('unbind !i')
    send_command('unbind !u')
    send_command('unbind !y')
    send_command('unbind !m')
    send_command('unbind ![')
    send_command('unbind !]')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind @e')
    send_command('unbind @w')
    unbind_numpad()

end

function init_gear_sets()

    sets.Enmity = {
        ammo="Staunch Tathlum +1",
        head={name="Halitus Helm", priority=88}, --8
        neck={name="Unmoving Collar +1", priority=200},
        ear1={name="Cryptic Earring", priority=40},
        ear2={name="Odnowa Earring +1", priority=110},
        body={name="Emet Harness +1", priority=61}, --10
        hands={name="Kurys Gloves", priority=25}, --9   
        ring1=gear.Moonlight_1,
        ring2={name="Eihwaz Ring", priority=70}, --5    
        back=gear.RUN_HPD_Cape, --10
        waist={name="Platinum Moogle Belt", priority=999}, 
        legs=gear.Empyrean_Legs, --11
        feet=gear.Empyrean_Feet,--7
    }
  
    sets.precast.JA['Vallation'] = set_combine(sets.Enmity, {
        body=gear.Artifact_Body,
        legs=gear.Relic_Legs,
        back=gear.RUN_HPD_Cape,
    })

    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = set_combine(sets.Enmity, { feet=gear.Artifact_Feet })
    sets.precast.JA['Battuta'] = set_combine(sets.Enmity, { head=gear.Relic_Head })
    sets.precast.JA['Liement'] = set_combine(sets.Enmity, { body=gear.Relic_Body })

    sets.precast.JA['Lunge'] = {
        ammo="Seething Bomblet +1",
        head=gear.Agwu_Head,
        body=gear.Agwu_Body,
        hands=gear.Agwu_Hands,
        legs=gear.Agwu_Legs,
        feet=gear.Agwu_Feet,
        neck={name="Unmoving Collar +1", priority=200},
        ear1="Novio Earring",
        ear2="Friomisi Earring",
        ring1="Mujin Band",
        ring2="Fenrir Ring +1",
        back=gear.RUN_HPD_Cape,
        waist={name="Platinum Moogle Belt", priority=999}, 
    }

    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = set_combine(sets.Enmity, { hands=gear.Artifact_Hands })
    sets.precast.JA['Rayke'] = set_combine(sets.Enmity, { feet=gear.Relic_Feet })
    sets.precast.JA['Elemental Sforzo'] = set_combine(sets.Enmity, { body=gear.Relic_Body })
    sets.precast.JA['Swordplay'] = set_combine(sets.Enmity, { hands=gear.Relic_Hands })

    sets.precast.JA['Vivacious Pulse'] = {
        head=gear.Empyrean_Head,
        body=gear.Artifact_Body,
        legs=gear.Artifact_Legs,
        neck="Incanter's Torque",
        ear1={name="Tuisto Earring", priority=150},
        back=gear.RUN_HPD_Cape,
        waist={name="Platinum Moogle Belt", priority=999}, 
    }

    sets.precast.FC = {
        ammo="Staunch Tathlum +1",
        head=gear.Artifact_Head, --12
        body=gear.Empyrean_Body, --13
        hands="Leyline Gloves", --7
        legs=gear.Agwu_Legs, --8
        feet=gear.Carmine_D_Feet, --8
        neck="Orunmila's Torque", --5
        ear1={name="Tuisto Earring", priority=150},
        ear2={name="Etiolation Earring", priority=50}, --2
        ring1="Kishar Ring", --4
        ring2={name="Gelatinous Ring +1", priority=135},
        back=gear.RUN_FC_Cape, --10
        waist={name="Platinum Moogle Belt", priority=999}, 
    } --3513 HP

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        legs=gear.Relic_Legs,
     })

    sets.precast.WS = {
        ammo="Knobkierrie",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck={name="Unmoving Collar +1", priority=200},
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Cornelia's Ring",
        back=gear.RUN_WS1_Cape,
        waist={name="Platinum Moogle Belt", priority=999}, 
    }

    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {
        ammo="Coiste Bodhar",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck={name="Unmoving Collar +1", priority=200},
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Epona's Ring",
        ring2="Niqmaddu Ring",
        back=gear.RUN_WS1_Cape,
        waist={name="Platinum Moogle Belt", priority=999}, 
    })

    sets.precast.WS['Dimidiation'] = set_combine(sets.precast.WS, {
        ammo="Seething Bomblet +1", --13 acc
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck={name="Unmoving Collar +1", priority=200},
        ear1="Moonshade Earring",
        ear2="Erilaz Earring +1", --15 acc
        ring1="Regal Ring",
        ring2="Niqmaddu Ring",
        back=gear.RUN_WS1_Cape,
        waist={name="Platinum Moogle Belt", priority=999}, 
    })

    sets.precast.WS['Herculean Slash'] = set_combine(sets.precast.WS, sets.precast.JA['Lunge'])

    sets.precast.WS['Shockwave'] = set_combine(sets.precast.WS, {
        ammo="Knobkierrie",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck={name="Unmoving Collar +1", priority=200},
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Niqmaddu Ring",
        back=gear.RUN_WS1_Cape,
        waist={name="Platinum Moogle Belt", priority=999}, 
    })

    sets.precast.WS['Upheaval'] = sets.precast.WS['Resolution']
    sets.precast.WS['Shield Break'] = sets.precast.WS['Shockwave']
    sets.precast.WS['Armor Break'] = sets.precast.WS['Shockwave']
    sets.precast.WS['Weapon Break'] = sets.precast.WS['Shockwave']
    sets.precast.WS['Full Break'] = sets.precast.WS['Shockwave']

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", -- [11]
        head=gear.Empyrean_Head, --[20]
        body=gear.Nyame_Body,
        hands={name="Regal Gauntlets", priority=205}, --[10]
        legs=gear.Carmine_A_Legs, --[20]
        feet=gear.Empyrean_Feet,
        neck="Moonlight Necklace", --15/[15]
        ear1="Magnetic Earring", --[8]
        ear2={name="Odnowa Earring +1", priority=110},
        ring1=gear.Moonlight_1,
        ring2={name="Gelatinous Ring +1", priority=135},
        back=gear.RUN_SIRD_Cape, --[10]
        waist={name="Platinum Moogle Belt", priority=999}, 
    } --99+10 = 109 SIR  (3492 HP + 41 PDT)

    sets.midcast['Blue Magic'] = sets.midcast.SpellInterrupt
    sets.midcast['Blue Magic'].Enmity = sets.midcast.Blue 
    sets.midcast['Blue Magic'].Cure = sets.midcast.Blue 
    sets.midcast['Blue Magic'].Buff = sets.midcast.Blue 
    sets.midcast['Sheep Song'] = sets.midcast.Blue;
    sets.midcast['Geist Wall'] = sets.midcast.Blue;
    sets.midcast['Blank Gaze'] = sets.midcast.Blue;
    sets.midcast['Jettatura'] = sets.midcast.Blue;
    sets.midcast['Divine Magic'] = sets.Enmity
    sets.midcast.Flash = sets.midcast.Enmity;
    sets.midcast.Foil = sets.midcast.SpellInterrupt;
    sets.midcast.Stun = sets.midcast.Enmity;

    sets.midcast.Cure = {
        ammo="Staunch Tathlum +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Sacro Gorget", -- 10
        ear1={name="Tuisto Earring", priority=150},
        ear2="Mendi. Earring", -- 5
        ring1="Lebeche Ring", -- 3
        ring2="Menelaus's Ring", --5
        back=gear.RUN_FC_Cape, -- 7
        waist="Sroda Belt",
    }

    sets.midcast['Enhancing Magic'] = set_combine(sets.midcast.SpellInterrupt, {
        hands={name="Regal Gauntlets", priority=205}, --[10]
        legs=gear.Relic_Legs,
    })

    sets.midcast.EnhancingDuration = sets.midcast['Enhancing Magic']

    sets.Phalanx = {
        -- main="Deacon Sword", --4
        head=gear.Relic_Head, --7
        body=gear.Herc_PHLX_Body, --4
        hands=gear.Taeon_Phalanx_Hands, --3(10)
        legs=gear.Taeon_Phalanx_Legs, --3(10)
        feet=gear.Taeon_Phalanx_Feet, --3(10)
    }

    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], sets.Phalanx)

    sets.midcast.Temper = {
        main="Pukulatmuj +1",
        head=gear.Carmine_D_Head,
        hands=gear.Artifact_Hands,
        legs=gear.Carmine_D_Legs,
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        waist="Olympus Sash",
    }

    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {head=gear.Artifact_Head, neck="Sacro Gorget"})
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head=gear.Empyrean_Head, waist="Gishdubar Sash"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring"})
    sets.midcast.Shell = sets.midcast.Protect

    sets.midcast['Enfeebling Magic'] = {
        ammo="Pemphredo Tathlum",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Erra Pendant",
        ear1="Dignitary's Earring",
        ear2="Vor Earring",
        ring1="Metamor. Ring +1",
        ring2="Kishar Ring",
        back=gear.RUN_SIRD_Cape,
        waist="Acuity Belt +1",
    }
    
    sets.engaged = {
        ammo="Staunch Tathlum +1",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck={name="Futhark Torque +2", priority=60},
        ear1={name="Tuisto Earring", priority=150},
        ear2={name="Odnowa Earring +1", priority=110}, 
        ring1=gear.Moonlight_1,
        ring2="Shadow Ring",
        back=gear.RUN_HPD_Cape,
        waist={name="Platinum Moogle Belt", priority=999}, 
    } --3708 hp


    sets.Hybrid = set_combine(sets.engaged, {
        ammo="Coiste Bodhar",
        head=gear.Adhemar_A_Head,
        body="Ashera Harness",
        hands=gear.Adhemar_A_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Dedition Earring",
        waist="Sailfi Belt +1",
        ring1=gear.Moonlight_1,
        ring2=gear.Moonlight_2,
        back=gear.RUN_TP_Cape,
    })

    sets.engaged.DD = set_combine(sets.engaged, sets.Hybrid)

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck={name="Futhark Torque +2", priority=60},
        ear1={name="Tuisto Earring", priority=150},
        ear2={name="Odnowa Earring +1", priority=110}, 
        ring1=gear.Moonlight_1,
        ring2="Shadow Ring",
        back=gear.RUN_HPD_Cape,
        waist={name="Platinum Moogle Belt", priority=999}, 
    }

    sets.idle.DT = {
        ammo="Staunch Tathlum +1",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Loricate Torque +1",
        ear1={name="Tuisto Earring", priority=150},
        ear2={name="Odnowa Earring +1", priority=110},
        ring1=gear.Moonlight_1,
        ring2={name="Gelatinous Ring +1", priority=135},
        back=gear.RUN_HPD_Cape,
        waist={name="Platinum Moogle Belt", priority=999}, 
    } --3183 hp

    sets.idle.Phalanx = set_combine(sets.idle, {
        head=gear.Relic_Head, --7
        body=gear.Taeon_Phalanx_Body, --3(10)
        hands=gear.Taeon_Phalanx_Hands, --3(10)
        legs=gear.Taeon_Phalanx_Legs, --3(10)
        feet=gear.Taeon_Phalanx_Feet, --3(10)
    })

    sets.idle.Refresh = set_combine(sets.idle, {
        ammo="Homiliary",
        body=gear.Artifact_Body,
        hands={name="Regal Gauntlets", priority=205}, --[10]
        legs="Rawhide Trousers",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
    })

    -- I use this mode for "Aoe" tanking (read: seg run). 
    sets.defense.PDT = {
        ammo="Staunch Tathlum +1", 
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs, 
        feet=gear.Empyrean_Feet,
        neck={name="Unmoving Collar +1", priority=200},
        ear1={name="Tuisto Earring", priority=150},
        ear2={name="Odnowa Earring +1", priority=110},
        ring1=gear.Moonlight_1,
        ring2=gear.Moonlight_2, 
        back=gear.RUN_HPD_Cape,
        waist={name="Platinum Moogle Belt", priority=999}, 
    }

    -- Nearly identical to normal engaged set, swap to warder's neck for more absorb chance. Ive prob never actually used this mode.
    sets.defense.MDT = {
        ammo="Staunch Tathlum +1", --3/3
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs, --11
        feet=gear.Empyrean_Feet,
        neck="Warder's Charm +1", --7/7
        ear1={name="Tuisto Earring", priority=150},
        ear2={name="Odnowa Earring +1", priority=110}, --3/5
        ring1=gear.Moonlight_1,
        ring2="Shadow Ring", --10/10
        back=gear.RUN_HPD_Cape, --10/0
        waist={name="Platinum Moogle Belt", priority=999}, 
    }

    sets.defense.Parry = {
        hands="Turms Mittens +1",
        legs=gear.Empyrean_Legs,
        back=gear.RUN_HPP_Cape,
    }

    sets.idle.Town = sets.engaged

    sets.Kiting = { legs=gear.Carmine_D_Legs }

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Purity Ring", --20
        waist="Gishdubar Sash", --10
    }

    sets.Embolden = set_combine(sets.midcast.EnhancingDuration, {back="Evasionist's Cape"})
    sets.Obi = {waist="Hachirin-no-Obi"}

    sets.Epeolatry = { main="Epeolatry", sub="Refined Grip +1" }
    sets.Helheim = { main="Helheim", sub="Utu Grip" }
    sets.Lycurgos = {main="Lycurgos", sub="Utu Grip"}
end

function job_precast(spell, action, spellMap, eventArgs)
    if buffactive['terror'] or buffactive['petrification'] or buffactive['stun'] or buffactive['sleep'] then
        add_to_chat(167, 'Action stopped due to status.')
        eventArgs.cancel = true
        return
    end
    if rune_enchantments:contains(spell.english) then
        eventArgs.handled = true
    end
    if spell.english == 'Lunge' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Swipe" <t>')
--            add_to_chat(122, '***Lunge Aborted: Timer on Cooldown -- Downgrading to Swipe.***')
            eventArgs.cancel = true
            return
        end
    end
    if spell.english == 'Valiance' then
        local abil_recasts = windower.ffxi.get_ability_recasts()
        if abil_recasts[spell.recast_id] > 0 then
            send_command('input /jobability "Vallation" <me>')
            eventArgs.cancel = true
            return
        elseif spell.english == 'Valiance' and buffactive['vallation'] then
            cast_delay(0.2)
            send_command('cancel Vallation') -- command requires 'cancel' add-on to work
        end
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


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        if (spell.element == world.day_element or spell.element == world.weather_element) then
            equip(sets.Obi)
        end
    end
    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
    if spell.english == 'Phalanx' and buffactive['Embolden'] then
        equip(sets.midcast.PhalanxDuration)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomMeleeGroups:clear()
    check_weaponset()
end

function job_buff_change(buff,gain)
    if buff == 'Phalanx' and gain then
        state.PhalanxMode:unset()
    end

    if buff == "Doom" then
        if gain then
            state.Buff.Doom = true
            send_command('@input /p Doomed.')
        else
            state.Buff.Doom = false
        end
    end

    if buff == 'Embolden' then
        if gain then
            equip(sets.Embolden)
            disable('head','legs','back')
        else
            enable('head','legs','back')
            status_change(player.status)
        end
    end

    if buff == 'Battuta' and not gain then
        status_change(player.status)
    end

end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end

    equip(sets[state.WeaponSet.current])
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
    if state.PhalanxMode.value == true then
        idleSet = set_combine(idleSet, sets.Phalanx)
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
    if state.PhalanxMode.value == true then
        meleeSet = set_combine(idleSet, sets.Phalanx)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end

    check_weaponset()
    return meleeSet
end

function customize_defense_set(defenseSet)
    if buffactive['Battuta'] then
        defenseSet = set_combine(defenseSet, sets.defense.Parry)
    end
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end

    return defenseSet
end

-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local r_msg = state.Runes.current
    local r_color = ''
    if state.Runes.current == 'Ignis' then r_color = 167
    elseif state.Runes.current == 'Gelus' then r_color = 210
    elseif state.Runes.current == 'Flabra' then r_color = 204
    elseif state.Runes.current == 'Tellus' then r_color = 050
    elseif state.Runes.current == 'Sulpor' then r_color = 215
    elseif state.Runes.current == 'Unda' then r_color = 207
    elseif state.Runes.current == 'Lux' then r_color = 001
    elseif state.Runes.current == 'Tenebrae' then r_color = 160 end

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

    add_to_chat(r_color, string.char(129,121).. '  ' ..string.upper(r_msg).. '  ' ..string.char(129,122)
        ..string.char(31,210).. ' Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002).. ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060)
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002).. ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002).. ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'rune' then
        local r_msg = state.Runes.current
        local r_color = ''
        local e_color = ''
        local r_res = ''
        local r_dmg = ''
        if state.Runes.current == 'Ignis' then 
            r_color = 167
            e_color = 210
            r_res = 'Ice'
            r_dmg = 'Fire'
        elseif state.Runes.current == 'Gelus' then 
            r_color = 210
            e_color = 204
            r_res = 'Wind'
            r_dmg = 'Ice'        
        elseif state.Runes.current == 'Flabra' then 
            r_color = 204
            e_color = 050
            r_res = 'Earth'
            r_dmg = 'Wind'        
        elseif state.Runes.current == 'Tellus' then
            r_color = 050
            e_color = 215
            r_res = 'Lightning'
            r_dmg = 'Earth'        
        elseif state.Runes.current == 'Sulpor' then
            r_color = 004
            e_color = 207
            r_res = 'Water'
            r_dmg = 'Lightning'        
        elseif state.Runes.current == 'Unda' then
            r_color = 207
            e_color = 167
            r_res = 'Fire'
            r_dmg = 'Water'        
        elseif state.Runes.current == 'Lux' then
            r_color = 001
            e_color = 160
            r_res = 'Darkness'
            r_dmg = 'Light'        
        elseif state.Runes.current == 'Tenebrae' then 
            r_color = 160
            e_color = 001
            r_res = 'Light'
            r_dmg = 'Darkness'
        end

        send_command('@input /ja '..state.Runes.value..' <me>')
        add_to_chat(r_color, string.char(129,121).. '  ' ..string.upper(r_msg).. '  ' ..string.char(129,122)
                    ..string.char(129,121).. ' Resist: ' .. r_res .. ' ' ..string.char(129,122) 
                    ..string.char(129,121).. ' Damage: ' .. r_dmg .. ' ' ..string.char(129,122)  )
    elseif cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
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