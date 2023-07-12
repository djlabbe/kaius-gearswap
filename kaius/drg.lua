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
    res = require 'resources'
end

-- Setup vars that are user-independent.
function job_setup()
    wyv_breath_spells = S{'Dia', 'Poison', 'Blaze Spikes', 'Protect', 'Sprout Smack', 'Head Butt', 'Cocoon',
        'Barfira', 'Barblizzara', 'Baraera', 'Barstonra', 'Barthundra', 'Barwatera'}

    wyv_elem_breath = S{'Flame Breath', 'Frost Breath', 'Sand Breath', 'Hydro Breath', 'Gust Breath', 'Lightning Breath'}

    state.Buff.Doom = false
end

function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'PDL')
    state.WeaponskillMode:options('Normal', 'Acc', 'PDL')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Trishula', 'ShiningOne', 'Naegling', 'Mafic' }
    state.WeaponLock = M(false, 'Weapon Lock')

    include('Global-Binds.lua')

    -- gear.Artifact_Head = { name="Vishap Armet +1" }
    gear.Artifact_Body = { name="Vishap Mail +1" }
    gear.Artifact_Hands = { name="Vishap Finger Gauntlets +3" }
    gear.Artifact_Legs = { name="Vishap Brais +3" }
    -- gear.Artifact_Feet = { name="Vishap Greaves +1" }

    gear.Relic_Head = { name="Pteroslaver Armet +3" }
    gear.Relic_Body = { name="Pteroslaver Mail +3" }
    gear.Relic_Hands = { name="Pteroslaver Finger Gauntlets +3" }
    gear.Relic_Legs = { name="Pteroslaver Brais +3" }
    gear.Relic_Feet = { name="Pteroslaver Greaves +3" }

    gear.Empyrean_Head = { name="Peltast's Mezail +3" }
    gear.Empyrean_Body = { name="Peltast's Plackart +3" }
    gear.Empyrean_Hands = { name="Peltast's Vambraces +3" }
    gear.Empyrean_Legs = { name="Peltast's Cuissots +2" }
    gear.Empyrean_Feet = { name="Peltast's Schynbalds +2" }

    gear.DRG_TP_Cape = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}} --*
    gear.DRG_STP_Cape = { name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}} --*
    gear.DRG_WS1_Cape = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --*
    gear.DRG_WS2_Cape = { name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}} -- *

    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind !F1 input /ja "Spirit Surge" <me>')
    send_command('bind !F2 input /ja "Fly High" <me>')

    send_command('bind !a input /ja "Dragon Breaker" <me>')
    send_command('bind !c input /ja "Ancient Circle" <me>')
   
    if player.sub_job == 'SAM' then
        send_command('bind !` input /ja "Hasso" <me>')
        send_command('bind ^` input /ja "Seigan" <me>')
        send_command('bind ^numpad7 gs c set WeaponLock false;gs c set WeaponSet Trishula; gs c set WeaponLock true;input /macro set 1')
        send_command('bind ^numpad8 gs c set WeaponLock false;gs c set WeaponSet ShiningOne; gs c set WeaponLock true;input /macro set 1')
        send_command('bind ^numpad9 gs c set WeaponLock false;gs c set WeaponSet Naegling; gs c set WeaponLock true;input /macro set 2')
        send_command('bind ^numpad4 gs c set WeaponLock false;gs c set WeaponSet Mafic; gs c set WeaponLock true;input /macro set 3')
        set_macro_page(1, 14)
    elseif player.sub_job == 'WAR' then
        send_command('bind !t input /ja "Provoke" <t>')
        send_command('bind ^numpad7 gs c set WeaponLock false;gs c set WeaponSet Trishula; gs c set WeaponLock true;input /macro set 4')
        send_command('bind ^numpad8 gs c set WeaponLock false;gs c set WeaponSet ShiningOne; gs c set WeaponLock true;input /macro set 4')
        send_command('bind ^numpad9 gs c set WeaponLock false;gs c set WeaponSet Naegling; gs c set WeaponLock true;input /macro set 5')
        send_command('bind ^numpad4 gs c set WeaponLock false;gs c set WeaponSet Mafic; gs c set WeaponLock true;input /macro set 6')
        set_macro_page(4, 14)
    elseif player.sub_job == 'DNC' then
        send_command('bind ^` input /ja "Chocobo Jig" <me>')
        send_command('bind ^numpad7 gs c set WeaponLock false;gs c set WeaponSet Trishula; gs c set WeaponLock true;input /macro set 4')
        send_command('bind ^numpad8 gs c set WeaponLock false;gs c set WeaponSet ShiningOne; gs c set WeaponLock true;input /macro set 4')
        send_command('bind ^numpad9 gs c set WeaponLock false;gs c set WeaponSet Naegling; gs c set WeaponLock true;input /macro set 5')
        send_command('bind ^numpad4 gs c set WeaponLock false;gs c set WeaponSet Mafic; gs c set WeaponLock true;input /macro set 6')
        set_macro_page(4, 14)
    elseif player.sub_job == 'NIN' then
        send_command('bind ^numpad7 gs c set WeaponLock false;gs c set WeaponSet Trishula; gs c set WeaponLock true;input /macro set 4')
        send_command('bind ^numpad8 gs c set WeaponLock false;gs c set WeaponSet ShiningOne; gs c set WeaponLock true;input /macro set 4')
        send_command('bind ^numpad9 gs c set WeaponLock false;gs c set WeaponSet Naegling; gs c set WeaponLock true;input /macro set 5')
        send_command('bind ^numpad4 gs c set WeaponLock false;gs c set WeaponSet Mafic; gs c set WeaponLock true;input /macro set 6')
        set_macro_page(4, 14)
    else
        set_macro_page(1, 14)
    end 

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false

    send_command('wait 3; input /lockstyleset 14')
end

function user_unload()
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @a')
    send_command('unbind !`')
    send_command('unbind ^`')
    send_command('unbind !F!')
    send_command('unbind !F2')
    send_command('unbind !a')
    send_command('unbind !c')
    send_command('unbind numpad7')
    send_command('unbind numpad8')
    send_command('unbind numpad9')
    send_command('unbind numpad4')
end

function init_gear_sets()

    sets.precast.JA['Spirit Surge'] = { body=gear.Relic_Body }
    sets.precast.JA['Call Wyvern'] = { body=gear.Relic_Body }
    sets.precast.JA['Ancient Circle'] = { legs=gear.Artifact_Legs }

    sets.precast.JA['Spirit Link'] = {
        -- head=gear.Artifact_Head,
        hands=gear.Empyrean_Hands,
        feet=gear.Relic_Feet,
    }

    sets.precast.JA['Steady Wing'] = {
        legs=gear.Artifact_Legs,
        feet=gear.Relic_Feet,
        back="Updraft Mantle",
    }

    sets.precast.JA['Jump'] = {
        ammo="Aurgelmir Orb +1",
        head="Flamma Zucchetto +2",
        neck="Vim Torque +1",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        body=gear.Relic_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Relic_Legs,
        feet="Ostro Greaves",       
        waist="Sailfi Belt +1",      
        ring1="Niqmaddu ring",
        ring2=gear.Chirich_2,
        back=gear.DRG_TP_Cape,
    }

    sets.precast.JA['High Jump'] = sets.precast.JA['Jump']
    sets.precast.JA['Spirit Jump'] = sets.precast.JA['Jump']

    sets.precast.JA['Soul Jump'] = set_combine(sets.precast.JA['Jump'], {
        body=gear.Artifact_Body,
    })
    sets.precast.JA['Super Jump'] = {}

    sets.precast.JA['Angon'] = {
        ammo="Angon", 
        hands=gear.Relic_Hands
    }

    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head=gear.Carmine_D_Head, --14
        body="Sacro Breastplate", --10
        hands="Leyline Gloves", --8
        legs="Ayanmo Cosciales +2", --6
        feet=gear.Carmine_B_Feet, --8
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring2="Prolix Ring", --2
    }

    sets.precast.WS = set_combine({
        ammo="Knobkierrie",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Legs,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        waist="Sailfi Belt +1",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Niqmaddu ring",
        ring2="Epaminondas's Ring",
        back=gear.DRG_WS1_Cape,
    }, {
        ring2="Cornelia's Ring"
    })

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
    sets.precast.WS.PDL = set_combine(sets.precast.WS, {
        ring2="Ephramad's Ring",
    })

    ------------------
    -- Savage Blade --
    ------------------

    sets.precast.WS["Savage Blade"] = set_combine({
        ammo="Knobkierrie",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Rep. Plat. Medal",
        waist="Sailfi Belt +1",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2="Regal Ring",
        back=gear.DRG_WS1_Cape,
    }, {
        ring2="Cornelia's Ring",
    })

    sets.precast.WS["Savage Blade"].PDL = set_combine(sets.precast.WS["Savage Blade"], {
        body=gear.Empyrean_Body,
        neck="Dragoon's Collar +2",
        ear1="Peltast's Earring +1",
        ring1="Ephramad's Ring",
    })

    sets.precast.WS["Judgment"] = sets.precast.WS["Savage Blade"]
    sets.precast.WS["Judgment"].PDL = sets.precast.WS["Savage Blade"].PDL

    sets.precast.WS['Stardiver'] = {
        ammo="Coiste Bodhar",
        head=gear.Empyrean_Head,
        neck="Fotia Gorget",
        ear1="Sherida Earring",     
        ear2="Moonshade Earring",
        body=gear.Nyame_Body,
        hands=gear.Empyrean_Hands,
        ring1="Niqmaddu Ring",
        ring2="Sroda Ring",
        back=gear.DRG_WS2_Cape,
        waist="Fotia Belt",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
    }

    sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS['Stardiver'], {})

    sets.precast.WS['Stardiver'].PDL = set_combine(sets.precast.WS['Stardiver'], {
        hands=gear.Gleti_Hands,
        body=gear.Gleti_Body,
        legs=gear.Gleti_Legs,
        feet=gear.Gleti_Feet,
        ear1="Peltast's Earring +1",
        ring2="Ephramad's Ring",
    })

    sets.precast.WS['Camlann\'s Torment'] = set_combine({
        ammo="Knobkierrie",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Dgn. Collar +2",
        waist="Fotia Belt",
        ear1="Thrud Earring",   
        ear2="Moonshade Earring",
        ring1="Niqmaddu ring",
        ring2="Regal Ring",
        back=gear.DRG_WS1_Cape,
    }, {
        ring2="Cornelia's Ring"
    })

    sets.precast.WS['Camlann\'s Torment'].Acc = set_combine(sets.precast.WS['Camlann\'s Torment'], {})

     sets.precast.WS['Camlann\'s Torment'].PDL = set_combine(sets.precast.WS['Camlann\'s Torment'], {
        body=gear.Gleti_Body,
        legs=gear.Gleti_Legs,
        ring1="Sroda Ring",
        ring2="Epaminondas's Ring",
        waist="Fotia Belt"
    }, {
        ring1="Ephramad's Ring",
    })

    sets.precast.WS['Sonic Thrust'] = set_combine({
        ammo="Knobkierrie",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Dgn. Collar +2",
        waist="Sailfi Belt +1",
        ear1="Sherida Earring",    
        ear2="Moonshade Earring",
        ring1="Niqmaddu ring",
        ring2="Regal Ring",
        back=gear.DRG_WS1_Cape,
    }, {
        ring2="Cornelia's Ring"
    })

    sets.precast.WS['Sonic Thrust'].Acc = set_combine(sets.precast.WS['Sonic Thrust'], {})
    sets.precast.WS['Sonic Thrust'].PDL = set_combine(sets.precast.WS['Sonic Thrust'], {
        head=gear.Relic_Head,
        feet=gear.Relic_Feet,
        ring1="Ephramad's Ring",
    })

    sets.precast.WS['Impulse Drive'] = {
        head=gear.Empyrean_Head,
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Nyame_Feet,
        neck="Dgn. Collar +2",
        ear1="Peltast's Earring +1",
        ear2="Moonshade Earring",
        ring1="Niqmaddu Ring",
        ring2="Begrudging Ring",
        back=gear.DRG_WS1_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Impulse Drive'].Acc = set_combine(sets.precast.WS['Impulse Drive'], {
        legs=gear.Artifact_Legs,
    })

    sets.precast.WS['Impulse Drive'].PDL = set_combine(sets.precast.WS['Impulse Drive'], {
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Gleti_Feet,
        ring2="Epaminondas's Ring",
        ear1="Peltast's Earring +1",
    }, {
        ring2="Cornelia's Ring"
    })

    sets.precast.WS['Impulse Drive'].HighTP = set_combine(sets.precast.WS['Impulse Drive'], {
        hands=gear.Relic_Hands,
        ear2="Ishvara Earring",
    })

    ----------------
    -- Drakesbane --
    ----------------
    sets.precast.WS['Drakesbane'] = {
        ammo="Coiste Bodhar",
        head="Blistering Sallet +1",
        body="Hjarrandi Breast.",
        hands=gear.Gleti_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Gleti_Feet,
        neck="Dgn. Collar +2",
        ear1="Peltast's Earring +1",
        ear2="Moonshade Earring",
        ring1="Niqmaddu Ring",
        ring2="Begrudging Ring",
        back=gear.DRG_WS1_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Drakesbane'].PDL = set_combine(sets.precast.WS['Drakesbane'], {
        ammo="Crepuscular Pebble",
        head=gear.Gleti_Head,
        body=gear.Gleti_Body,
        legs=gear.Gleti_Legs,
        ear1="Thrud Earring",
        ring2="Sroda Ring",
    }, {
        ring1="Ephramad's Ring",
    })

    sets.precast.WS["Wheeling Thrust"] = set_combine({
        ammo="Knobkierrie",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Dragoon's Collar +2",
        waist="Sailfi Belt +1",
        ear1="Sherida Earring",
        ear2="Thrud Earring",
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",
        back=gear.DRG_WS1_Cape,
    }, {
        ring2="Cornelia's Ring"
    })

    sets.precast.WS['Geirskogul'] = set_combine({
        ammo="Knobkierrie",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        ear1="Sherida Earring",
        ear2="Thrud Earring",
        ring="Niqmaddu Ring",
        ring2="Regal Ring",
        waist="Sailfi Belt +1",
        back=gear.DRG_WS3_Cape,
    }, {
        ring2="Cornelia's Ring"
    })

    sets.precast.WS['Geirskogul'].Acc = set_combine(sets.precast.WS['Geirskogul'], {})
    sets.precast.WS['Geirskogul'].PDL = set_combine(sets.precast.WS['Geirskogul'], {
        ear1="Peltast's Earring +1", 
        ring2="Epaminondas's Ring",
    }, {
        ring2="Ephramad's Ring",
    })

    sets.precast.WS['Leg Sweep'] = set_combine(sets.precast.WS, {
        ammo="Pemphredo Tathlum",
        head=gear.Empyrean_Body,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        ear1="Dignitary's Earring",
        ear2="Crepuscular Earring",
        ring1="Metamor. Ring +1",
        ring2="Crepuscular Ring",
    })

    sets.precast.WS['Leg Sweep'].Acc = set_combine(sets.precast.WS['Leg Sweep'], {})
    sets.precast.WS['Leg Sweep'].PDL = set_combine(sets.precast.WS['Leg Sweep'], {})

    sets.precast.WS['Raiden Thrust'] = {
        ammo="Knobkierrie",
        head=gear.Nyame_Head,
        neck="Sibyl Scarf",
        ear1="Friomisi Earring",
        ear2="Moonshade Earring",
        body=gear.Nyame_Head,
        hands=gear.Nyame_Hands,
        ring1="Epaminondas's Ring",
        ring2="Shiva Ring +1",
        back=gear.DRG_WS1_Cape,
        waist="Sailfi Belt +1",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
    }

    sets.precast.WS['Thunder Thrust'] = sets.precast.WS['Raiden Thrust']

    sets.midcast.HealingBreath = {
        head=gear.Relic_Head,
        legs=gear.Artifact_Legs,
        feet=gear.Relic_Feet,
        neck="Dgn. Collar +2",
        ring1=gear.Moonlight_1,
        ring2="Defending Ring",
        back="Updraft Mantle",
    }

    sets.defense.PDT = {
        ammo="Coiste Bodhar",
        head="Hjarrandi Helm", --10
        body=gear.Gleti_Body, --9
        hands=gear.Empyrean_Hands, --11
        legs=gear.Relic_Legs,
        feet="Flamma Gambieras +2",
        neck="Dragoon's Collar +2",
        ear1="Sherida Earring",
        ear2="Sroda Earring",
        ring1=gear.Moonlight_1, --5
        ring2=gear.Moonlight_2, --5
        waist="Sailfi Belt +1",
        back=gear.DRG_TP_Cape --10
    } --50

    sets.defense.MDT = {
        ammo="Staunch Tathlum +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Dragoon's Collar +2",
        ear1="Enmerkar Earring",
        ear2="Odnowa Earring +1",
        ring1="Defending Ring",
        ring2="Shadow Ring",
        waist="Carrier's Sash",
        back=gear.DRG_TP_Cape
    }

    sets.engaged = {
        ammo="Coiste Bodhar",
        head="Flamma Zucchetto +2",
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Relic_Legs,
        feet="Flamma Gambieras +2",
        neck="Vim Torque +1",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        ring1="Niqmaddu Ring",
        ring2=gear.Moonlight_2,
        back=gear.DRG_TP_Cape,
        waist="Sailfi Belt +1",
    }

    sets.engaged.Naegling = set_combine(sets.engaged, {
        body=gear.Empyrean_Body, 
        hands=gear.Empyrean_Hands, --11
        legs=gear.Gleti_Legs, --8
    }) --34% DT

    sets.engaged.Pet = {
        ear2="Sroda Earring",
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        ear2="Cessance Earring",
        neck="Dragoon's Collar +2",
    })

    sets.engaged.Hybrid = {
        neck="Dgn. Collar +2",
        body=gear.Gleti_Body, --9/0
        legs=gear.Gleti_Legs, --8/0
        hands=gear.Empyrean_Hands, --11/11
        ring1=gear.Moonlight_1, --5/5
        ring2=gear.Moonlight_2, --5/5
    } --48% Physical, 21% MDT (50% w/ Shell V)

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.idle = {
        ammo="Staunch Tathlum +1", --3/3
        head=gear.Empyrean_Head, --10/10
        body=gear.Nyame_Body,
        hands=gear.Gleti_Hands, --5/5
        legs=gear.Gleti_Legs,
        feet=gear.Gleti_Feet,
        neck="Dgn. Collar +2",
        ear1="Etiolation Earring",
        ear2="Arete Del Luna +1",
        ring1=gear.Moonlight_1,
        ring2="Shadow Ring",
        back=gear.DRG_TP_Cape, --6/6
        waist="Carrier's Sash", --4/0
    }

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1", --3/3
        body="Hjarrandi Breast.", --12/12
        head="Hjarrandi Helm", --10/10
        hands=gear.Gleti_Hands,
        feet=gear.Relic_Feet,
        neck="Loricate Torque +1", --6/6
        ear1="Etiolation Earring",
        ring1="Moonlight Ring", --5/5
        ring2="Defending Ring", --10/10
        waist="Carrier's Sash",
    })

    sets.idle.Pet = set_combine(sets.idle, {
        neck="Dgn. Collar +2",
    })

    sets.idle.DT.Pet = set_combine(sets.idle.Pet, {
        neck="Dgn. Collar +2",
    })

    sets.idle.Weak = sets.idle.DT
    sets.idle.Town = sets.engaged.DT
    sets.Kiting = { legs=gear.Carmine_D_Legs }

    sets.buff.Doom = {
        neck="Nicander's Necklace",
        ring1="Eshmun's Ring",
        ring2="Purity Ring",
        waist="Gishdubar Sash",
    }

    sets.Trishula = { main="Trishula", sub="Utu Grip" }
    sets.ShiningOne = { main="Shining One", sub="Utu Grip" }
    sets.Naegling = { main="Naegling" }
    sets.Mafic = { main="Mafic Cudgel" }

end

function job_precast(spell, action, spellMap, eventArgs)
    -- Wyvern Commands
    if spell.name == 'Dismiss' and pet.hpp < 100 then
        eventArgs.cancel = true
        add_to_chat(50, 'Cancelling Dismiss! ' ..pet.name.. ' is below full HP! [ ' ..pet.hpp.. '% ]')
    elseif wyv_breath_spells:contains(spell.english) or (spell.skill == 'Ninjutsu' and player.hpp < 33) then
        equip(sets.precast.HealingBreath)
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        if spell.english == 'Impulse Drive' and player.tp > 2000 then
           equip(sets.precast.WS['Impulse Drive'].HighTP)
        end
    end
end

function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.name:startswith('Healing Breath') or spell.name == 'Restoring Breath' then
        equip(sets.midcast.HealingBreath)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

function job_buff_change(buff,gain)
    if buff == "Doom" then
        if gain then
            state.Buff.Doom = true
            send_command('@input /p Doomed.')
        else
            state.Buff.Doom = false
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
    elseif state.OffenseMode.value == 'PDL' then
        wsmode = 'PDL'
    end

    return wsmode
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
    if player.equipment.main == "Naegling" then
        meleeSet = set_combine(meleeSet, sets.engaged.Naegling)
    end
    if pet.isValid then
        meleeSet = set_combine(meleeSet, sets.engaged.Pet)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
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