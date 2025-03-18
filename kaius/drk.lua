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
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Souleater = buffactive.souleater or false
    state.Buff['Last Resort'] = buffactive['Last Resort'] or false
    state.Buff.Doom = false
    custom_weapon_list = S{"Liberator"}
end

function user_setup()
    include('Global-Binds.lua')    

    state.OffenseMode:options('Normal', 'Acc', 'PDL', 'Subtle')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc', 'PDL')
    state.PhysicalDefenseMode:options('PDT', 'MDT')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Liberator', 'Caladbolg', 'Helheim', 'Apocalypse', 'Loxotic', 'Lycurgos', 'Naegling'}

    state.MagicBurst = M(false, 'Magic Burst')
    state.WeaponLock = M(false, 'Weapon Lock')

    gear.Artifact_Head = { name= "Ignominy Burgeonet +3" }
    gear.Artifact_Body = { name= "Ignominy Cuirass +3" }
    gear.Artifact_Hands = { name= "Ignominy Gauntlets +2" }
    gear.Artifact_Legs = { name= "Ignominy Flanchard +3" }
    gear.Artifact_Feet = { name= "Ignominy Sollerets +3" }

    gear.Relic_Head = { name= "Fallen's Burgeonet +3" }
    gear.Relic_Body = { name= "Fallen's Cuirass +3" }
    gear.Relic_Hands = { name= "Fallen's Finger Gauntlets +3" }
    gear.Relic_Legs = { name= "Fallen's Flanchard +3" }
    gear.Relic_Feet = { name= "Fallen's Sollerets +3" }

    gear.Empyrean_Head = { name= "Heathen's Burgeonet +3" }
    gear.Empyrean_Body = { name= "Heathen's Cuirass +2" }
    gear.Empyrean_Hands = { name= "Heathen's Gauntlets +2" }
    gear.Empyrean_Legs = { name= "Heathen's Flanchard +2" }
    gear.Empyrean_Feet = { name= "Heathen's Sollerets +3" }

    gear.DRK_TP_Cape = { name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}} --X
    gear.DRK_DA_Cape = { name="Ankou's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}} --X
    gear.DRK_WS1_Cape = { name="Ankou's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --X
    gear.DRK_WS2_Cape = { name="Ankou's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --X
    gear.DRK_FC_Cape = { name="Ankou's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10',}}
    gear.DRK_MB_Cape = { name="Ankou's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
    gear.DRK_DRK_Cape = { name="Niht Mantle", augments={'Attack+15','Dark magic skill +10','"Drain" and "Aspir" potency +23',}}

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @a gs c toggle Critical')
    send_command('bind @e gs c cycle WeaponSet')
    send_command('bind @q gs c toggle MagicBurst')

    send_command('bind !F1 input /ja "Blood Weapon" <me>')
    send_command('bind !F2 input /ja "Soul Enslavement" <me>')

    send_command('bind !t input /ma "Stun" <t>')
    send_command('bind !y input /ja "Weapon Bash" <t>')
    send_command('bind !d input /ja "Scarlet Delirium" <me>')
    send_command('bind !m input /ja "Consume Mana" <me>')
    send_command('bind !a input /ja "Arcane Crest" <t>')
    send_command('bind !c input /ja "Arcane Circle" <me>')

    send_command('bind !h input /ma "Dread Spikes" <me>')
    send_command('bind !j input /ma "Endark II" <me>')

    if player.sub_job == 'SAM' then
        send_command('bind !` input /ja "Hasso" <me>')
        send_command('bind ^` input /ja "Seigan" <me>')
        send_command('bind ^c input /ja "Warding Circle" <me>')
        send_command('bind ^numpad7 gs c set WeaponSet Caladbolg;input /macro set 1')
        send_command('bind ^numpad8 gs c set WeaponSet Helheim;input /macro set 1')
        send_command('bind ^numpad9 gs c set WeaponSet Liberator;input /macro set 2')
        send_command('bind ^numpad4 gs c set WeaponSet Apocalypse;input /macro set 2')
        send_command('bind ^numpad5 gs c set WeaponSet Lycurgos;input /macro set 3')
        send_command('bind ^numpad6 gs c set WeaponSet Naegling;input /macro set 5')
        send_command('bind ^numpad1 gs c set WeaponSet Loxotic;input /macro set 4')
        set_macro_page(2, 8)
    elseif player.sub_job == 'DRG' then   
        send_command('bind ^numpad7 gs c set WeaponSet Caladbolg;input /macro set 6')
        send_command('bind ^numpad8 gs c set WeaponSet Helheim;input /macro set 6')
        send_command('bind ^numpad9 gs c set WeaponSet Liberator;input /macro set 7')
        send_command('bind ^numpad4 gs c set WeaponSet Apocalypse;input /macro set 7')
        send_command('bind ^numpad5 gs c set WeaponSet Lycurgos;input /macro set 8')
        send_command('bind ^numpad6 gs c set WeaponSet Naegling;input /macro set 9')
        send_command('bind ^numpad1 gs c set WeaponSet Loxotic;input /macro set 10')
        set_macro_page(7, 8)
    else
        send_command('bind ^numpad7 gs c set WeaponSet Caladbolg;input /macro set 6')
        send_command('bind ^numpad8 gs c set WeaponSet Helheim;input /macro set 6')
        send_command('bind ^numpad9 gs c set WeaponSet Liberator;input /macro set 7')
        send_command('bind ^numpad4 gs c set WeaponSet Apocalypse;input /macro set 7')
        send_command('bind ^numpad5 gs c set WeaponSet Lycurgos;input /macro set 8')
        send_command('bind ^numpad6 gs c set WeaponSet Naegling;input /macro set 9')
        send_command('bind ^numpad5 gs c set WeaponSet Loxotic;input /macro set 10')
        set_macro_page(7, 8)
    end

    send_command('bind @1 input /ma "Stone II" <t>')
    send_command('bind @2 input /ma "Water II" <t>')
    send_command('bind @3 input /ma "Aero II" <t>')  
    send_command('bind @4 input /ma "Fire II" <t>')
    send_command('bind @5 input /ma "Blizzard II" <t>')
    send_command('bind @6 input /ma "Thunder II" <t>')
   
    send_command('bind !numpad7 input /ma "Absorb-STR" <t>')
    send_command('bind !numpad8 input /ma "Absorb-DEX" <t>')
    send_command('bind !numpad9 input /ma "Absorb-VIT" <t>')  
    send_command('bind !numpad4 input /ma "Absorb-ACC" <t>')
    send_command('bind !numpad5 input /ma "Absorb-AGI" <t>')
    send_command('bind !numpad6 input /ma "Absorb-INT" <t>')
    send_command('bind !numpad1 input /ma "Absorb-MND" <t>')
    send_command('bind !numpad2 input /ma "Absorb-CHR" <t>')


    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
    send_command('wait 3; input /lockstyleset 8')
    get_combat_weapon()
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind !t')
    send_command('unbind !y')
    send_command('unbind !d')
    send_command('unbind !m')
    send_command('unbind !a')
    send_command('unbind !c')
    send_command('unbind ^c')
    send_command('unbind @a')
    send_command('unbind @e')
    send_command('unbind @q')

    send_command('unbind @1')
    send_command('unbind @2')
    send_command('unbind @3')
    send_command('unbind @4')
    send_command('unbind @5')
    send_command('unbind @6')

    unbind_numpad()
end

function init_gear_sets()

    sets.Enmity = {
        ammo="Sapience Orb",
        head={name="Loess Barbuta +1", priority=105}, --24
        neck="Moonlight Necklace",
        ear1={name="Cryptic Earring", priority=40},
        ear2={name="Trux Earring", priority=1},
        body={name="Emet Harness +1", priority=61}, --10
        hands={name="Kurys Gloves", priority=25}, --9
        ring2={name="Eihwaz Ring", priority=70}, --5 
    }

    sets.precast.JA['Arcane Circle'] = {feet=gear.Artifact_Feet}
    sets.precast.JA['Blood Weapon'] = {body=gear.Relic_Body}
    sets.precast.JA['Dark Seal'] = {head=gear.Relic_Head}
    sets.precast.JA['Diabolic Eye'] = {hands=gear.Relic_Hands}
    sets.precast.JA['Last Resort'] = {
        feet=gear.Relic_Feet,
        back=gear.DRK_TP_Cape,
    }
    sets.precast.JA['Nether Void'] = {legs=gear.Empyrean_Legs}
    sets.precast.JA['Souleater'] = {head=gear.Artifact_Head}
    sets.precast.JA['Weapon Bash'] = {hands=gear.Artifact_Hands}

    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head=gear.Carmine_D_Head, --10
        body="Sacro Breastplate", --10
        hands="Leyline Gloves", --8
        legs="Enif Cosciales", --8
        feet=gear.Carmine_B_Feet, -- 8
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Malignance Earring", --4
        ring1="Kishar Ring", --4
        ring2="Prolix Ring", --4
        back=gear.DRK_FC_Cape, --10
    }

    sets.precast.FC['Dark Magic'] = set_combine(sets.precast.FC, {
        head=gear.Relic_Head,
    })

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
        head=empty,
        body="Crepuscular Cloak",
    })

    sets.precast.WS = {
        ammo="Knobkierrie",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Abyssal Beads +2",
        waist="Sailfi Belt +1",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",
        ring1="Regal Ring",
        ring2="Epaminondas's Ring",
        back= gear.DRK_WS1_Cape,
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
     
    })

    sets.precast.WS.PDL = set_combine(sets.precast.WS, {
    
    })

    ---------------
    -- SCYTHE WS --
    ---------------

    sets.precast.WS['Catastrophe'] = {
        ammo="Knobkierrie",
        head=gear.Nyame_Head, 
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Abyssal Beads +2",
        ear1="Lugra Earring +1",
        ear2="Heathen's Earring +2",
        ring1="Epaminondas's Ring",
        ring2=gear.Cornelia_Or_Niqmaddu,
        waist="Sailfi Belt +1",
        back= gear.DRK_WS1_Cape,
    }

     sets.precast.WS['Catastrophe'].Acc = set_combine(sets.precast.WS['Catastrophe'], {})
     sets.precast.WS['Catastrophe'].PDL = set_combine(sets.precast.WS['Catastrophe'], {
        head=gear.Empyrean_Head,
        ear="Thrud Earring",
        ring1="Sroda Ring",
        legs=gear.Sakpata_Legs,
     })

     sets.precast.WS['Cross Reaper'] = {
        ammo="Knobkierrie",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Abyssal Beads +2",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",
        ring1=gear.Cornelia_Or_Epaminondas,
        ring2="Niqmaddu Ring",
        waist="Sailfi Belt +1",
        back= gear.DRK_WS1_Cape,
    }

    sets.precast.WS['Cross Reaper'].Acc = set_combine(sets.precast.WS['Cross Reaper'], {})
    sets.precast.WS['Cross Reaper'].PDL = set_combine(sets.precast.WS['Cross Reaper'], {
        ear2="Heathen's Earring +2",
        ring1="Sroda Ring",
    })

    sets.precast.WS['Entropy'] = {
        ammo="Coiste Bodhar",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Schere Earring",
        ring1="Metamorph Ring +1",
        ring2="Niqmaddu Ring",
        waist="Fotia Belt",
        back= gear.DRK_WS1_Cape,
    }

    sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS['Entropy'], {})
    sets.precast.WS['Entropy'].PDL = set_combine(sets.precast.WS['Entropy'], {
        ammo="Crepuscular Pebble",
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        ring1="Sroda Ring",
        ear2="Heathen's Earring +2"
    })

    sets.precast.WS['Insurgency'] = {
        ammo="Knobkierrie",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Abyssal Beads +2",
        ear1="Moonshade Earring",
        ear2="Heathen's Earring +2",
        ring1=gear.Cornelia_Or_Regal,
        ring2="Niqmaddu Ring",
        waist="Sailfi Belt +1",
        back= gear.DRK_WS1_Cape,
    }

    sets.precast.WS['Insurgency'].Acc = set_combine(sets.precast.WS['Insurgency'], {})
    sets.precast.WS['Insurgency'].PDL = set_combine(sets.precast.WS['Insurgency'], {
        hands=gear.Sakpata_Hands,
        body=gear.Sakpata_Body,
        legs=gear.Sakpata_Legs,
    })

    sets.precast.WS['Quietus'] = {
        ammo="Knobkierrie",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Abyssal Beads +2",
        ear1="Moonshade Earring",
        ear2="Heathen's Earring +2",
        ring1=gear.Cornelia_Or_Regal,
        ring2="Niqmaddu Ring",
        waist="Sailfi Belt +1",
        back= gear.DRK_WS1_Cape,
    }

    sets.precast.WS['Quietus'].Acc = set_combine(sets.precast.WS['Quietus'], {})
    sets.precast.WS['Quietus'].PDL = set_combine(sets.precast.WS['Quietus'], {
        head=gear.Empyrean_Head,
        legs=gear.Sakpata_Legs,
        ring1="Sroda Ring",
    })

    sets.precast.WS['Shadow of Death'] = {
        ammo="Seething Bomblet +1",
        head="Pixie Hairpin +1",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Sibyl Scarf",
        ear1="Moonshade Earring",
        ear2="Malignance Earring",
        ring1="Archon Ring",
        ring2="Epaminondas's Ring",
        waist="Orpheus's Sash",
        back= gear.DRK_WS1_Cape,
    }

    sets.precast.WS['Infernal Scythe'] = {
        ammo="Knobkierrie",
        head="Pixie Hairpin +1",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Sibyl Scarf",
        ear1="Friomisi Earring",
        ear2="Malignance Earring",
        ring1="Archon Ring",
        ring2=gear.Cornelia_Or_Epaminondas,
        waist="Orpheus's Sash",
        back= gear.DRK_WS1_Cape,
    }

    --------------------
    -- GREAT SWORD WS --
    --------------------
    sets.precast.WS['Fimbulvetr'] = {
        ammo="Knobkierrie",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Abyssal Beads +2",
        waist="Sailfi Belt +1",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",
        ring1="Regal Ring",
        ring2=gear.Cornelia_Or_Niqmaddu,
        back= gear.DRK_WS1_Cape,
    }

    sets.precast.WS['Fimbulvetr'].Acc = set_combine(sets.precast.WS['Fimbulvetr'], {})
    sets.precast.WS['Fimbulvetr'].PDL = set_combine(sets.precast.WS['Fimbulvetr'], {
        head=gear.Empyrean_Head,
        ring1="Epaminondas's Ring",
        ear2="Heathen's Earring +2",
    })

    sets.precast.WS['Torcleaver'] = {
        ammo="Knobkierrie", --6
        head=gear.Nyame_Head, --10
        body=gear.Nyame_Body, --12
        hands=gear.Nyame_Hands, --10
        legs=gear.Nyame_Legs, --11
        feet=gear.Empyrean_Feet, --12 
        neck="Abyssal Beads +2",
        waist="Sailfi Belt +1",
        ear1="Moonshade Earring",
        ear2="Thrud Earring", --3
        ring1="Regal Ring",
        ring2=gear.Cornelia_Or_Epaminondas,
        back= gear.DRK_WS2_Cape, --10
    }

    sets.precast.WS['Torcleaver'].Acc = set_combine(sets.precast.WS['Torcleaver'], {})
    sets.precast.WS['Torcleaver'].PDL = set_combine(sets.precast.WS['Torcleaver'], {
        head=gear.Empyrean_Head,
        ear2="Heathen's Earring +2",
    })

    sets.precast.WS['Resolution'] = {
        ammo="Knobkierrie", --6
        head=gear.Empyrean_Head, --10
        body=gear.Sakpata_Body, --12
        hands=gear.Sakpata_Hands, --10
        legs=gear.Artifact_Legs, --11
        feet=gear.Sakpata_Feet, --12 
        neck="Fotia Gorget",
        waist="Fotia Belt",
        ear1="Moonshade Earring",
        ear2="Schere Earring", --3
        ring1="Regal Ring",
        ring2="Niqmaddu Ring", --5
        back= gear.DRK_WS2_Cape, --10
    } --79% WSD

    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'], {})
    sets.precast.WS['Resolution'].PDL = set_combine(sets.precast.WS['Resolution'], {
        ammo="Crepuscular Pebble",
        legs=gear.Sakpata_Legs,
    })

    sets.precast.WS['Shockwave'] = {
        ammo="Knobkierrie",
        head=gear.Empyrean_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Empyrean_Feet,
        neck="Abyssal Beads +2",
        waist="Fotia Belt",
        ear1="Crepuscular Earring",
        ear2="Heathen's Earring +2",
        ring1="Metamorph Ring +1",
        ring2=gear.Stikini_2,
        back= gear.DRK_WS1_Cape,
    }

    sets.precast.WS['Shockwave'].Acc = set_combine(sets.precast.WS['Shockwave'], {})

    -------------
    -- CLUB WS --
    -------------

    sets.precast.WS['Judgment'] = {
        ammo="Knobkierrie",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Abyssal Beads +2",
        ear1="Moonshade Earring",
        ear2="Heathen's Earring +2",
        ring1="Epaminondas's Ring",
        ring2=gear.Cornelia_Or_Regal,
        waist="Sailfi Belt +1",
        back= gear.DRK_WS1_Cape,
    }

    sets.precast.WS['Judgment'].Acc = set_combine(sets.precast.WS['Judgment'], {})
    sets.precast.WS['Judgment'].PDL = set_combine(sets.precast.WS['Judgment'], {
        head=gear.Empyrean_Head,
        ring2="Sroda Ring",
    })

    -------------
    -- GAXE WS --
    -------------

    sets.precast.WS['Upheaval'] = {
        ammo="Knobkierrie", --6
        head=gear.Nyame_Head, --10
        body=gear.Nyame_Body, --12
        hands=gear.Nyame_Hands, --10
        legs=gear.Nyame_Legs, --11
        feet=gear.Empyrean_Feet, --12 
        neck="Abyssal Beads +2",
        waist="Sailfi Belt +1",
        ear1="Moonshade Earring",
        ear2="Heathen's Earring +2",
        ring1="Gelatinous Ring +1",
        ring2="Niqmaddu Ring", --5
        back= gear.DRK_WS2_Cape, --10
    }
    
    sets.precast.WS['Armor Break'] = {
        ammo="Knobkierrie",
        head=gear.Empyrean_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Sakpata_Feet, 
        neck="Abyssal Beads +2",
        waist="Fotia Belt",
        ear1="Moonshade Earring",
        ear2="Heathen's Earring +2",
        ring1="Niqmaddu Ring",
        ring2="Regal Ring",
        back= gear.DRK_WS1_Cape,
    }

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        head=empty,
        body="Crepuscular Cloak",
        ring1="Archon Ring",
    })

    sets.midcast['Enfeebling Magic'] = {
        ammo="Pemphredo Tathlum",
        head=gear.Carmine_D_Head,
        body=gear.Artifact_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Artifact_Feet,
        neck="Incanter's Torque",
        ear1="Crepuscular Earring",
        ear2="Malignance Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        waist="Eschan Stone",
    }

    sets.midcast['Dark Magic'] = {
        ammo="Pemphredo Tathlum",
        head=gear.Carmine_D_Head,
        body=gear.Carmine_B_Body,
        hands="Ratri Gadlings +1",
        legs=gear.Relic_Legs,
        feet="Ratri Sollerets +1",
        ear1="Mani Earring",
        ear2="Malignance Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.DRK_DRK_Cape,
        waist="Skrymir Cord +1",
    }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        ammo="Pemphredo Tathlum",
        head=gear.Relic_Head,
        neck="Erra Pendant",  
        ear1="Hirudinea Earring",
        ear2="Malignance Earring",
        body=gear.Carmine_B_Body,
        hands=gear.Relic_Hands,
        ring1="Evanescence Ring",
        ring2="Archon Ring",
        back=gear.DRK_DRK_Cape,
        waist="Orpheus's Sash",
        legs=gear.Empyrean_Legs, 
        feet="Ratri Sollerets +1",
    })

    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Absorb = {
        ammo="Pemphredo Tathlum",
        head=gear.Artifact_Head,
        body=gear.Carmine_B_Body,
        hands="Pavor Gauntlets",
        legs=gear.Relic_Legs,
        feet="Ratri Sollerets +1",
        neck="Erra Pendant",  
        ear1="Mani Earring",
        ear2="Malignance Earring",
        ring1="Kishar Ring",
        ring2=gear.Stikini_2,
        back="Chuparrosa Mantle",
        waist="Eschan Stone",
    }

    sets.midcast['Absorb-TP'] = set_combine(sets.midcast.Absorb, {hands=gear.Empyrean_Hands})

    sets.midcast.Stun = sets.enmity;

    sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {
        main="Crepuscular Scythe",
        head="Ratri Sallet +1",
        neck="Unmoving Collar +1",
        body=gear.Empyrean_Body,
        hands="Ratri Gadlings +1",
        legs="Ratri Cuisses +1",
        feet="Ratri Sollerets +1",
        ear1="Odnowa Earring +1",
        ear2="Tuisto Earring",
        ring1=gear.Moonlight_1,
        ring2="Gelatinous Ring +1",
        back="Moonlight Cape",
        waist="Platinum Moogle Belt"
    })

    sets.defense.PDT = {
        head=gear.Sakpata_Head, --7
        body=gear.Sakpata_Body, --10
        hands=gear.Sakpata_Hands, --8
        legs=gear.Sakpata_Legs, --9
        feet=gear.Sakpata_Feet, --6
        ring1=gear.Moonlight_1, --5
        ring2=gear.Moonlight_2, --5
    } --50

    sets.defense.MDT = {
        ammo="Staunch Tathlum +1", --3
        head=gear.Sakpata_Head, --10
        body=gear.Sakpata_Body, --12
        hands=gear.Sakpata_Hands, --8
        legs=gear.Sakpata_Legs, --9
        feet=gear.Sakpata_Feet, --6
        neck="Warder's Charm +1",
        ear1="Odnowa Earring +1", --3/5a
    }

    sets.engaged = {
        ammo="Coiste Bodhar",
        head="Flamma Zucchetto +2",
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Artifact_Legs,
        feet="Flamma Gambieras +2",
        neck="Abyssal Beads +2",
        waist="Sailfi Belt +1",
        ear1="Telos Earring",      
        ear2="Balder Earring +1",
        ring1="Niqmaddu ring",
        ring2=gear.Lehko_Or_Chirich2,
        back=gear.DRK_DA_Cape,
    }

    sets.engaged.Caladbolg = sets.engaged

    sets.engaged.Caladbolg.Aftermath = {
        body="Dagon Breastplate",
        ear1="Schere Earring",
        ear2="Balder Earring +1",      
        ring2=gear.Lehko_Or_Hetairoi,
    }

    sets.engaged.Liberator = {
        ammo="Coiste Bodhar",
        head="Flamma Zucchetto +2",
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        legs=gear.Artifact_Legs,
        feet="Flamma Gambieras +2",
        neck="Abyssal Beads +2",
        waist="Sailfi Belt +1",
        ear1="Telos Earring",
        ear2="Balder Earring +1", 
        ring1="Niqmaddu ring",
        ring2="Hetairoi Ring",
        back= gear.DRK_TP_Cape,
    }

    sets.engaged.Liberator.Aftermath = {
        ammo="Aurgelmir Orb +1",
        body="Hjarrandi Breastplate",
        legs=gear.Ody_STP_Legs,
        feet=gear.Valo_STP_Feet,
        ear1="Telos Earring",      
        ear2="Dedition Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back= gear.DRK_TP_Cape,
    }

    sets.engaged.Subtle = {
        ammo="Coiste Bodhar",
        head=gear.Sakpata_Head, 
        body="Dagon Breastplate", --(10) 
        hands=gear.Sakpata_Hands, --8
        legs=gear.Sakpata_Legs, 
        feet=gear.Sakpata_Feet, --13 
        neck="Abyssal Beads +2",
        ear1="Telos Earring",      
        ear2="Dedition Earring",
        ring1="Niqmaddu Ring", --(5)
        ring2=gear.Chirich_2, --10
        waist="Sailfi Belt +1",
        back=gear.DRK_TP_Cape,
    }  --Auspice = 27 (WHM empy +2) +8 Food = need 15(I) + 15(II) to cap.
    -- DT = 8 + 9 + 6 + 7 + 10P
    
    sets.engaged.Caladbolg.Subtle = sets.engaged.Subtle

    sets.engaged.Acc = set_combine(sets.engaged, {
        ear2="Heathen's Earring +2"
    })

    sets.engaged.Hybrid = {
        head=gear.Sakpata_Head,
        body=gear.Sakpata_Body,
        hands=gear.Sakpata_Hands,
        -- legs=gear.Sakpata_Legs,
        legs=gear.Nyame_Legs,
        feet=gear.Sakpata_Feet,
        ring2=gear.Moonlight_2,
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head=gear.Sakpata_Head,
        body="Sacro Breastplate",
        hands=gear.Sakpata_Hands,
        legs=gear.Sakpata_Legs,
        feet=gear.Sakpata_Feet,
        neck="Sibyl Scarf",
        ear1="Sanare Earring",
        ear2="Eabani Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.DRK_TP_Cape,
        waist="Platinum Moogle Belt",
    }

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1", --3
        head=gear.Sakpata_Head, --10
        body=gear.Sakpata_Body, --12
        hands=gear.Sakpata_Hands, --8
        legs=gear.Sakpata_Legs, --9
        feet=gear.Sakpata_Feet, --6
        neck="Loricate Torque +1", --6/6
        ear1="Odnowa Earring +1", --3/5a
        back="Moonlight Cape", --6/6
    })

    sets.idle.Town = sets.precast.WS['Fimbulvetr'].PDL
    -- sets.idle.Town = sets.precast.WS['Insurgency']

    sets.latent_refresh = { waist="Fucho-no-obi" }
    
    if (item_available("Shneddick Ring +1")) then
        sets.Kiting = { ring1="Shneddick Ring +1" }
    else
        sets.Kiting = { legs=gear.Carmine_A_Legs }
    end

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Purity Ring", --20
        waist="Gishdubar Sash", --10
    }

    sets.Caladbolg = { main="Caladbolg", sub="Utu Grip" }
    sets.Helheim = { main="Helheim", sub="Utu Grip" }
    sets.Liberator = { main="Liberator", sub="Utu Grip" }
    sets.Apocalypse = { main="Apocalypse", sub="Utu Grip" }
    sets.Lycurgos = { main="Lycurgos", sub="Utu Grip" }
    sets.Loxotic = { main="Loxotic Mace +1", sub="Blurred Shield +1" }
    sets.Naegling = { main="Naegling", sub="Blurred Shield +1" }
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_aftercast(spell, action, spellMap, eventArgs)
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end


function job_state_change(field, new_value, old_value)
    if state.WeaponLock.value == true then
        disable('main','sub','range')
    else
        enable('main','sub','range')
    end
    check_weaponset()
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
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    get_combat_weapon()
    handle_equipping_gear(player.status)
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

function customize_melee_set(meleeSet)
    if (buffactive['Aftermath: Lv.3'] and player.equipment.main == "Caladbolg" and state.OffenseMode ~= "Subtle") then
        meleeSet = set_combine(meleeSet, sets.engaged.Caladbolg.Aftermath)
    elseif (buffactive['Aftermath: Lv.3'] and player.equipment.main == "Liberator" and state.OffenseMode ~= "Subtle") then
        meleeSet = set_combine(meleeSet, sets.engaged.Liberator.Aftermath)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end

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

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function get_combat_weapon()
    state.CombatWeapon:reset()
    if custom_weapon_list:contains(player.equipment.main) then
        state.CombatWeapon:set(player.equipment.main)
    end
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
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
end