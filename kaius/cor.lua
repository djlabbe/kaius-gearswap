-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ ALT+F9 ]          Cycle Ranged Modes
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
    include('lib/enchantments.lua')
    res = require('resources')
    extdata = require('extdata')
end

function job_setup()

    state.QD = M{['description']='Primary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot'}
    state.QDMode = M{['description']='Quick Draw Mode', 'Enhance', 'Potency'}
    state.LuzafRing = M(true, "Luzaf's Ring")
    state.Buff.Doom = false
    state.LowAmmoWarned = M(false)

    state.AutoAmmoMode = M(true,'Auto Ammo Mode')
    tickdelay = os.clock() + 5
    ammostock = 70
    useItem = false
	useItemName = ''
    prevItemName = ''
	useItemSlot = ''
    next_cast = 0
    delayed_cast = ''

    current_roll1 = ''
    current_roll2 = ''

    data.equipment = {}
    data.equipment.rema_ranged_weapons = S{'Fomalhaut','Death Penalty','Armageddon', 'Annihilator'}

    data.equipment.rema_ranged_weapons_ammo = {
        ['Fomalhaut'] = 'Chrono Bullet',
        ['Death Penalty'] = 'Living Bullet',
        ['Armageddon'] = 'Devastating Bullet',
        ['Annihilator'] = 'Eradicating Bullet'
    }

    data.equipment.rema_ranged_weapons_ammo_pouch = {
        ['Fomalhaut'] = 'Chr. Bul. Pouch',
        ['Death Penalty'] = 'Liv. Bul. Pouch',
        ['Armageddon'] = 'Dev. Bul. Pouch',
        ['Annihilator'] = 'Era. Bul. Pouch'
    }

    no_shoot_ammo = S{"Animikii Bullet", "Hauksbok Bullet"}
    define_roll_values()
end

function user_setup()
    include('Global-Binds.lua') 

    state.OffenseMode:options('Normal', 'PDL')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Critical')
    state.WeaponskillMode:options('Normal', 'PDL')
    state.IdleMode:options('Normal')

    state.WeaponSet = M{['description']='Weapon Set', 'DeathPenalty_M', 'DeathPenalty_R', 'Armageddon_M', 'Armageddon_R', 'Fomalhaut_M', 'Fomalhaut_R', 'Naegling_Gleti', 'Naegling_Crep'}
    state.WeaponLock = M(false, 'Weapon Lock')

    gear.RAbullet = "Chrono Bullet"
    gear.RAccbullet = "Devastating Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet"
    gear.QDbullet = "Hauksbok Bullet"
    options.ammo_warning_limit = 10

    gear.Rostam_A = { name="Rostam", augments={'Path: A',}, bag="wardrobe1"}
    gear.Rostam_B = { name="Rostam", augments={'Path: B',}, bag="wardrobe2"}
    gear.Rostam_C = { name="Rostam", augments={'Path: C',}, bag="wardrobe3"}

    gear.Artifact_Head = { name= "Laksamana's Tricorne +3" }
    gear.Artifact_Body = { name= "Laksamana's Frac +3" }
    gear.Artifact_Hands = { name= "Laksamana's Gants +2" }
    gear.Artifact_Legs = { name= "Laksamana's Trews +2" }
    gear.Artifact_Feet = { name= "Laksamana's Bottes +2" }

    gear.Relic_Head = { name= "Lanun Tricorne +3" }
    gear.Relic_Body = { name= "Lanun Frac +3" }
    gear.Relic_Hands = { name= "Lanun Gants +3" }
    gear.Relic_Legs = { name= "Lanun Trews +3" }
    gear.Relic_Feet = { name= "Lanun Bottes +4" }

    gear.Empyrean_Head = { name= "Chasseur's Tricorne +3" }
    gear.Empyrean_Body = { name= "Chasseur's Frac +3" }
    gear.Empyrean_Hands = { name= "Chasseur's Gants +3" }
    gear.Empyrean_Legs = { name= "Chasseur's Culottes +3" }
    gear.Empyrean_Feet = { name= "Chasseur's Bottes +3" }

    gear.COR_SNP_Cape = { name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Snapshot"+10','Mag. Evasion+15',}} --X        
    gear.COR_RA_Cape = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Phys. dmg. taken-10%',}} --X
    gear.COR_DW_Cape = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}} --X
    gear.COR_SB_Cape = { name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --X
    gear.COR_LEAD_Cape = { name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --X
    gear.COR_LS_Cape = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --X
    gear.COR_RACRIT_Cape = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Crit.hit rate+10','Phys. dmg. taken-10%',}} --X

    send_command ('bind @` gs c toggle LuzafRing')

    send_command ('bind ^` gs c set WeaponLock false;input /ja "Bolter\'s Roll" <me>')
  
    send_command('bind !insert gs c cycleback QD')
    send_command('bind !delete gs c cycle QD')

    send_command('bind @q gs c cycle QDMode')
    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind !F1 input /ja "Wild Card" <me>')
    send_command('bind !F2 input /ja "Cutting Cards" <stpc>')

    send_command ('bind !f input /ja "Fold" <me>')
    send_command ('bind !t input /ja "Triple Shot" <me>')

    -- ALT + Numpad ===> Rolls --
    send_command('bind !numpad7 gs c set WeaponLock false;input /ja "Samurai Roll" <me>')
    send_command('bind !numpad8 gs c set WeaponLock false;input /ja "Chaos Roll" <me>')
    send_command('bind !numpad9 gs c set WeaponLock false;input /ja "Tactician\'s Roll" <me>')  

    send_command('bind !numpad4 gs c set WeaponLock false;input /ja "Wizard\'s Roll" <me>')
    send_command('bind !numpad5 gs c set WeaponLock false;input /ja "Warlock\'s Roll" <me>')
    send_command('bind !numpad6 gs c set WeaponLock false;input /ja "Monk\'s Roll" <me>')

    send_command('bind !numpad1 gs c set WeaponLock false;input /ja "Fighter\'s Roll" <me>')
    send_command('bind !numpad2 gs c set WeaponLock false;input /ja "Rogue\'s Roll" <me>')
    send_command('bind !numpad3 gs c set WeaponLock false;input /ja "Naturalist\'s Roll" <me>')

    send_command('bind !numpad0 gs c set WeaponLock false;input /ja "Evoker\'s Roll" <me>')
    send_command('bind !numpad+ gs c set WeaponLock false;input /ja "Crooked Cards" <me>')

    if player.sub_job == 'NIN' then
        send_command('bind ^numpad7 gs c set WeaponSet DeathPenalty_M;input /macro set 3')
        send_command('bind ^numpad8 gs c set WeaponSet DeathPenalty_R;input /macro set 3')
        send_command('bind ^numpad4 gs c set WeaponSet Armageddon_M;input /macro set 2')
        send_command('bind ^numpad5 gs c set WeaponSet Armageddon_R;input /macro set 2')
        send_command('bind ^numpad1 gs c set WeaponSet Fomalhaut_M;input /macro set 2')
        send_command('bind ^numpad2 gs c set WeaponSet Fomalhaut_R;input /macro set 2')
        send_command('bind ^numpad0 gs c set WeaponSet Naegling_Gleti;input /macro set 1')
        send_command('bind ^numpad. gs c set WeaponSet Naegling_Crep;input /macro set 1')
        set_macro_page(2, 17)
    elseif player.sub_job == 'DNC' then
        send_command('bind @1 input /ja "Box Step" <t>')
        send_command('bind @2 input /ja "Stutter Step" <t>')

        send_command('bind ^numpad7 gs c set WeaponSet DeathPenalty_M;input /macro set 6')
        send_command('bind ^numpad8 gs c set WeaponSet DeathPenalty_R;input /macro set 6')
        send_command('bind ^numpad4 gs c set WeaponSet Armageddon_M;input /macro set 5')
        send_command('bind ^numpad5 gs c set WeaponSet Armageddon_R;input /macro set 5')
        send_command('bind ^numpad1 gs c set WeaponSet Fomalhaut_M;input /macro set 5')
        send_command('bind ^numpad2 gs c set WeaponSet Fomalhaut_R;input /macro set 5')
        send_command('bind ^numpad0 gs c set WeaponSet Naegling_Gleti;input /macro set 4')
        send_command('bind ^numpad. gs c set WeaponSet Naegling_Crep;input /macro set 4')
        set_macro_page(5, 17)
    else
        send_command('bind ^numpad7 gs c set WeaponSet DeathPenalty_M;input /macro set 3')
        send_command('bind ^numpad8 gs c set WeaponSet DeathPenalty_R;input /macro set 3')
        send_command('bind ^numpad4 gs c set WeaponSet Armageddon_M;input /macro set 2')
        send_command('bind ^numpad5 gs c set WeaponSet Armageddon_R;input /macro set 2')
        send_command('bind ^numpad1 gs c set WeaponSet Fomalhaut_M;input /macro set 2')
        send_command('bind ^numpad2 gs c set WeaponSet Fomalhaut_R;input /macro set 2')
        send_command('bind ^numpad0 gs c set WeaponSet Naegling_Gleti;input /macro set 1')
        send_command('bind ^numpad. gs c set WeaponSet Naegling_Crep;input /macro set 1')
        set_macro_page(2, 17)
    end
   
    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    

    send_command('wait 3; input /lockstyleset 17')
end

function user_unload()
    send_command('unbind @`')    
    send_command('unbind ^`')
    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind @q')
    send_command('unbind @w')
    send_command('unbind !F1')
    send_command('unbind !F2')
    send_command('unbind !f')
    send_command('unbind !t')
    unbind_numpad()
end

function init_gear_sets()

    sets.precast.JA['Snake Eye'] = {legs=gear.Relic_Legs}
    sets.precast.JA['Wild Card'] = {feet=gear.Relic_Feet}

    sets.precast.JA['Random Deal'] = {
        head=gear.Ikenga_Head,
        body=gear.Relic_Body,
        hands=gear.Ikenga_Hands,
        legs=gear.Ikenga_Legs,
        feet=gear.Ikenga_Feet,
    }

    sets.precast.CorsairRoll = {
        main=gear.Rostam_C, 
        range="Compensator",
        head=gear.Relic_Head,
        body=gear.Malignance_Body, --9/9
        hands=gear.Empyrean_Hands,
        legs="Desultor Tassets",
        feet=gear.Malignance_Feet, --4/0
        neck="Regal Necklace",
        ear1="Etiolation Earring", --0/3
        ear2="Odnowa Earring +1", --3/5
        ring1="Gelatinous Ring +1", --7/(-1)
        ring2="Defending Ring", --10/10
        back=gear.COR_SNP_Cape,
        waist="Platinum Moogle Belt",
    }

    sets.precast.JA["Double-Up"] = {main=gear.Rostam_C, range="Compensator"}

    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs=gear.Empyrean_Legs})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet=gear.Empyrean_Feet})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head=gear.Empyrean_Head})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body=gear.Empyrean_Body})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands=gear.Empyrean_Hands})

    sets.precast.LuzafRing = {ring1="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands=gear.Relic_Hands}

    sets.precast.Waltz = {
        neck="Unmoving Collar +1",
        ear2="Tuisto Earring",
        body="Passion Jacket",
        ring1="Asklepian Ring",
        ring2="Gelatinous Ring +1",
        waist="Gishdubar Sash",
    }

    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.FC = {
        head=gear.Carmine_D_Head, --14
        body=gear.Taeon_FC_Body, --9
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        feet=gear.Carmine_B_Feet, --8
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring1="Prolix Ring", --2
        ring2="Kishar Ring", --4
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        neck="Magoraga Beads",
        body="Passion Jacket",
        ring1="Lebeche Ring",
    })

    -- (10% Snapshot from JP Gifts)
    sets.precast.RA = {
        ammo=gear.RAbullet,
        head=gear.Empyrean_Head, --0/14
        body="Oshosi Vest +1", --14/0
        hands=gear.Carmine_D_Hands, --13/0
        legs=gear.Adhemar_D_Legs, --10/13
        feet="Meghanada jambeaux +2", --10/0
        neck="Commodore Charm +2", --4/0
        ring1="Crepuscular Ring",
        back=gear.COR_SNP_Cape, --10/0
        waist="Yemaya Belt", --0/5
    } --61/32

    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
        body=gear.Artifact_Body, --0/20
    }) --47/52

    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
        feet="Pursuer's Gaiters", --0/10
    }) --32/73

    sets.precast.WS = {
        ammo=gear.WSbullet,
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1=gear.Cornelia_Or_Regal,
        ring2="Epaminondas's Ring",
        back=gear.COR_LS_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS.PDL = set_combine(sets.precast.WS, {})

    sets.precast.WS['Last Stand'] = {
        ammo=gear.WSbullet,
        head=gear.Relic_Head,
        body=gear.Ikenga_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1=gear.Cornelia_Or_Regal,
        ring2="Dingir Ring",
        back=gear.COR_LS_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS['Last Stand'].PDL = set_combine(sets.precast.WS['Last Stand'], {

    })


    sets.precast.WS['Wildfire'] = {
        ammo=gear.MAbullet,
        head=gear.Nyame_Head,
        body=gear.Relic_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Relic_Feet,
        neck="Commodore Charm +2",
        ear1="Crematio Earring",
        ear2="Friomisi Earring",
        ring1=gear.Cornelia_Or_Regal,
        ring2="Dingir Ring",
        back=gear.COR_LEAD_Cape,
        waist="Skrymir Cord +1",
    }

    sets.precast.WS['Hot Shot'] = {
        ammo=gear.MAbullet,
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Relic_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1=gear.Cornelia_Or_Regal,
        ring2="Dingir Ring",
        back=gear.COR_LEAD_Cape,
        waist="Skrymir Cord +1",
    }

    sets.precast.WS['Leaden Salute'] = {
        ammo=gear.MAbullet,
        head="Pixie Hairpin +1",
        body=gear.Relic_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Relic_Feet,
        neck="Commodore Charm +2",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1="Archon Ring",
        ring2="Dingir Ring",
        back=gear.COR_LEAD_Cape,
        waist="Skrymir Cord +1",
    }

    sets.precast.WS['Evisceration'] = {
        head="Blistering Sallet +1",
        body="Meghanada Cuirie +2",
        hands=gear.Empyrean_Hands,
        legs="Zoar Subligar +1",
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Odr Earring",
        ring1="Ilabrat Ring",
        ring2="Regal Ring",
        back=gear.COR_DW_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS['Savage Blade'] = {
        ammo=gear.WSbullet,
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Rep. Plat. Medal",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1=gear.Cornelia_Or_Epaminondas,
        ring2="Regal Ring",
        back=gear.COR_SB_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS['Savage Blade'], {
        neck="Commodore Charm +2",
        body=gear.Ikenga_Body,
        ring2="Sroda Ring",
    })

    sets.precast.WS['Aeolian Edge'] = {
        ammo=gear.QDbullet,
        head=gear.Nyame_Head,
        body=gear.Relic_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Relic_Feet,
        neck="Baetyl Pendant",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1=gear.Cornelia_Or_Epaminondas,
        ring2="Dingir Ring",
        back=gear.COR_LEAD_Cape,
        waist="Orpheus's Sash",
    }

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        body=gear.Taeon_Phalanx_Body, --10
        hands="Rawhide Gloves", --15
        legs=gear.Carmine_D_Legs, --20
        feet=gear.Taeon_Phalanx_Feet, --10
        neck="Loricate Torque +1", --5
        ear1="Halasz Earring", --5
        ear2="Magnetic Earring", --8
        ring2="Evanescence Ring", --5
    }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt
    
    sets.midcast['Absorb-TP'] = {
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Erra Pendant",
        ear1="Crepuscular Earring", 
        ear2="Chasseur's Earring +1", 
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Null Shawl",
        waist="Null Belt",
    }


    sets.midcast.CorsairShot = {
        ammo=gear.QDbullet,
        head=gear.Ikenga_Head,
        body=gear.Relic_Body,
        hands=gear.Carmine_D_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Relic_Feet,
        neck="Commodore charm +2",
        ear1="Crematio Earring",
        ear2="Friomisi Earring",
        ring1="Fenrir Ring +1",
        ring2="Dingir Ring",
        back=gear.COR_LEAD_Cape,
        waist="Skrymir Cord +1",
    }

    sets.midcast.CorsairShot['Light Shot'] = {
        ammo=gear.RAccbullet,
        head=gear.Artifact_Head,
        body=gear.Malignance_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Artifact_Feet,
        neck="Commodore charm +2",
        ear1="Crepuscular Earring",
        ear2="Chasseur's Earring +1",
        ring1="Regal Ring",
        ring2="Dingir Ring",
        back=gear.COR_SB_Cape,
        waist="K. Kachina Belt +1",
    }

    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']

    sets.midcast.CorsairShot.Enhance = {
        body="Mirke Wardecors", 
        feet=gear.Empyrean_Feet
    }

    sets.midcast.RA = {
        ammo=gear.RAbullet,
        head=gear.Ikenga_Head,
        body=gear.Ikenga_Body,
        hands=gear.Ikenga_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Ikenga_Feet,
        neck="Iskur Gorget",
        ear1="Crepuscular Earring",
        -- ear2="Telos Earring",
        ear2="Beyla Earring",
        ring1="Crepuscular Ring",
        ring2=gear.Ephramad_Or_Ilabrat,
        back=gear.COR_RA_Cape,
        waist="Tellen Belt",
    }

    sets.midcast.RA.Critical = {
        ammo=gear.RAbullet,
        head="Meghanada Visor +2",
        body="Meghanada Cuirie +2",
        hands=gear.Empyrean_Hands,
        legs="Darraigner's Brais",
        feet="Oshosi Leggings +1",
        neck="Iskur Gorget",
        ear1="Odr Earring",
        ear2="Chasseur's Earring +1",
        ring1=gear.Lehko_Or_Begrudging,
        ring2="Dingir Ring",
        back=gear.COR_RACRIT_Cape,
        waist="Tellen Belt",
    }

    sets.TripleShot = {
        head="Oshosi Mask +1", --5
        body=gear.Empyrean_Body, --12
        hands=gear.Relic_Hands,
        legs="Oshosi Trousers +1", --6
        feet="Oshosi Leggings +1", --3
    } --27

    sets.TripleShotCritical = {
        head="Meghanada Visor +2",
    }

    sets.TrueShot_RA = {
        body="Nisroch Jerkin",
        legs="Oshosi Trousers +1",
        waist="Tellen Belt",
        feet=gear.Ikenga_Feet,
    }

    sets.TrueShot_WS = {
        waist="Tellen Belt",
        feet=gear.Ikenga_Feet,
    }

    sets.engaged = {
        ammo=gear.RAbullet,
        head=gear.Malignance_Head, --6/6
        body=gear.Malignance_Body, --9/9
        hands=gear.Malignance_Hands, --5/5
        legs=gear.Empyrean_Legs, --7/7
        feet=gear.Malignance_Feet, --4/4
        neck="Iskur Gorget",
        ear1="Dedition Earring",
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.COR_DW_Cape,
        waist="Sailfi Belt +1",
    }

    sets.engaged.Hybrid = {
        head=gear.Malignance_Head
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)

    sets.idle = {
        ammo=gear.MAbullet,
        head=gear.Malignance_Head,
        body="Adamantite Armor",
        hands=gear.Malignance_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Malignance_Feet,
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Sanare Earring",
        ring1=gear.Chirich_1,
        ring2="Shadow Ring",
        back=gear.COR_SNP_Cape,
        waist="Platinum Moogle Belt",
    }

    sets.idle.Town = sets.precast.WS['Leaden Salute']

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = {
        head=gear.Malignance_Head, 
        body="Adamantite Armor",
        hands=gear.Malignance_Hands, 
        legs=gear.Malignance_Legs, 
        feet=gear.Malignance_Feet,
        neck="Warder's Charm +1",
        ear1="Etiolation Earring",
        ear2="Eabani Earring",
        ring1="Purity Ring", 
        ring2="Defending Ring",
        back=gear.COR_SNP_Cape,
        waist="Platinum Moogle Belt",
    }

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

    sets.FullTP = {ear1="Crematio Earring"}
    sets.Obi = {waist="Hachirin-no-Obi"}

    sets.DeathPenalty_M = {main=gear.Rostam_B, sub="Crepuscular Knife", ranged="Death Penalty"}
    sets.DeathPenalty_R = {main=gear.Rostam_A, sub="Kustawi +1", ranged="Death Penalty"}
    sets.Armageddon_M = {main=gear.Rostam_B, sub="Crepuscular Knife", ranged="Armageddon"}
    sets.Armageddon_R = {main=gear.Rostam_A, sub="Kustawi +1", ranged="Armageddon"}
    sets.Fomalhaut_M = {main=gear.Rostam_B, sub="Crepuscular Knife", ranged="Fomalhaut"}
    sets.Fomalhaut_R = {main=gear.Rostam_A, sub="Kustawi +1", ranged="Fomalhaut"}
    sets.Naegling_Gleti = {main="Naegling", sub="Gleti's Knife", ranged="Anarchy +3"}
    sets.Naegling_Crep = {main="Naegling", sub="Crepuscular Knife", ranged="Anarchy +3"}

    sets.DefaultShield = {sub="Nusku Shield"}

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or spell.type == 'WeaponSkill' or spell.type == 'CorsairShot' then
        do_bullet_checks(spell, spellMap, eventArgs)
    end

    if spell.english == 'Fold' and buffactive['Bust'] == 2 then
        if sets.precast.FoldDoubleBust then
            equip(sets.precast.FoldDoubleBust)
            eventArgs.handled = true
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

function job_post_precast(spell, action, spellMap, eventArgs)
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") then
        if state.LuzafRing.value then
            equip(sets.precast.LuzafRing)
        end
    end
    if spell.action_type == 'Ranged Attack' then
        special_ammo_check()
        if flurry == 2 then
            equip(sets.precast.RA.Flurry2)
        elseif flurry == 1 then
            equip(sets.precast.RA.Flurry1)
        end
    elseif spell.type == 'WeaponSkill' then
        if spell.skill == 'Marksmanship' then
            special_ammo_check()
        end
        -- Replace TP-bonus gear if not needed.
        if (spell.english == 'Leaden Salute' or spell.english == 'Aeolian Edge') and player.tp > 2900 then
            equip(sets.FullTP)
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

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == "WeaponSkill" then
        if (elemental_ws:contains(spell.name) == false) then
            local tarusize = 0.3
            -- For COR we can just assume Gun TrueShot range
            local trueshotmax = tarusize + spell.target.model_size + 4.3189 
            local trueshotmin = tarusize + spell.target.model_size + 3.0209
            if spell.target.distance > trueshotmin and spell.target.distance < trueshotmax then
                equip(sets.TrueShot_WS)
            end
        end
    elseif spell.type == 'CorsairShot' then
        if (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
            -- Matching double weather (w/o day conflict)
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 1.7 yalms
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
            if state.QDMode.value == 'Enhance' then
                equip(sets.midcast.CorsairShot.Enhance)
            end
        end
    elseif spell.action_type == 'Ranged Attack' then
        if buffactive['Triple Shot'] then
            equip(sets.TripleShot)
            if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
                equip(sets.TripleShotCritical)
                if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                    equip(sets.TrueShot_RA)
                end
            end
        elseif buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
            equip(sets.midcast.RA.Critical)
            if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                equip(sets.TrueShot_RA)
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if (spell.type == 'CorsairRoll' or spell.english == "Double-Up") and not spell.interrupted then
        display_roll_info(spell)
    end
    if spell.english == "Light Shot" then
        send_command('@timers c "Light Shot ['..spell.target.name..']" 60 down abilities/00195.png')
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end

    if spell.action_type == 'Item' and useItem and (spell.english == useItemName) then
        useItem = false
        enable(useItemSlot)
        windower.send_command('gs c forceequip '..useItemSlot..' '..prevItemName..'')
        useItemName = ''
        prevItemName = ''
        useItemSlot = ''
    end
end

function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
    if S{'flurry'}:contains(buff:lower()) then
        if not gain then
            flurry = nil
            --add_to_chat(122, "Flurry status cleared.")
        end
        if not midaction() then
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
        disable('main', 'sub', 'ranged')
    else
        enable('main', 'sub', 'ranged')
    end

    check_weaponset()
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
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
    if state.OffenseMode.value == 'Acc' then
        wsmode = 'Acc'
    elseif state.OffenseMode.value == 'PDL' then
        wsmode = 'PDL'
    end

    return wsmode
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    check_weaponset()

    return meleeSet
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

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local qd_msg = '(' ..string.sub(state.QDMode.value,1,1).. ')'


    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value


    add_to_chat(string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' QD' ..qd_msg.. ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002))

    eventArgs.handled = true
end

--Read incoming packet to differentiate between Haste/Flurry I and II
windower.register_event('action',
    function(act)
        --check if you are a target of spell
        local actionTargets = act.targets
        playerId = windower.ffxi.get_player().id
        isTarget = false
        for _, target in ipairs(actionTargets) do
            if playerId == target.id then
                isTarget = true
            end
        end
        if isTarget == true then
            if act.category == 4 then
                local param = act.param
                if param == 845 and flurry ~= 2 then
                    --add_to_chat(122, 'Flurry Status: Flurry I')
                    flurry = 1
                elseif param == 846 then
                    --add_to_chat(122, 'Flurry Status: Flurry II')
                    flurry = 2
              end
            end
        end
    end)


function job_self_command(cmdParams, eventArgs)
    if (cmdParams[1]:lower() == 'enchantment') then
        handle_enchantment_command(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1] == 'qd' then
        send_command('@input /ja "'..state.QD.current..'" <t>')
    end

    if cmdParams[1]:lower() == 'forceequip' then
        handle_forceequip(cmdParams)
    end
end


function define_roll_values()
    rolls = {
        ["Corsair's Roll"] =    {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"] =        {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"] =     {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"] =        {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"] =      {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"] =     {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Drachen Roll"] =      {lucky=4, unlucky=8, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"] =       {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"] =       {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"] =        {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"] =      {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"] =     {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"] =      {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"] =    {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Puppet Roll"] =       {lucky=3, unlucky=7, bonus="Pet Magic Attack/Accuracy"},
        ["Gallant's Roll"] =    {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"] =     {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"] =     {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"] =    {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Naturalist's Roll"] = {lucky=3, unlucky=7, bonus="Enh. Magic Duration"},
        ["Runeist's Roll"] =    {lucky=4, unlucky=8, bonus="Magic Evasion"},
        ["Bolter's Roll"] =     {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"] =     {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"] =    {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"] =    {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] =  {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies' Roll"] =      {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"] =      {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] =  {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"] =    {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end

function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = (state.LuzafRing.value and string.char(129,157)) or ''

    if rollinfo then
        add_to_chat(001, string.char(129,115).. '  ' ..string.char(31,210)..spell.english..string.char(31,001)..
            ' : '..rollinfo.bonus.. ' ' ..string.char(129,116).. ' ' ..string.char(129,195)..
            '  Lucky: ' ..string.char(31,204).. tostring(rollinfo.lucky)..string.char(31,001).. ' /' ..
            ' Unlucky: ' ..string.char(31,167).. tostring(rollinfo.unlucky)..string.char(31,002)..
            '  ' ..rollsize)
    end
end


-- Determine whether we have sufficient ammo for the action being attempted.
function do_bullet_checks(spell, spellMap, eventArgs)
    local bullet_name
    local bullet_min_count = 1

    if spell.type == 'WeaponSkill' then
        if spell.skill == "Marksmanship" then
            if spell.english == 'Wildfire' or spell.english == 'Leaden Salute' then
                -- magical weaponskills
                bullet_name = gear.MAbullet
            else
                -- physical weaponskills
                bullet_name = gear.WSbullet
            end
        else
            -- Ignore non-ranged weaponskills
            return
        end
    elseif spell.type == 'CorsairShot' then
        bullet_name = gear.QDbullet
    elseif spell.action_type == 'Ranged Attack' then
        bullet_name = gear.RAbullet
        if buffactive['Triple Shot'] then
            bullet_min_count = 3
        end
    end

    local available_bullets = player.inventory[bullet_name] or player.wardrobe[bullet_name]


    -- If no ammo is available, give appropriate warning and end.
    if not available_bullets then
        if spell.type == 'CorsairShot' and player.equipment.ammo ~= 'empty' then
            add_to_chat(104, 'No Quick Draw ammo left.  Using what\'s currently equipped ('..player.equipment.ammo..').')
            return
        elseif spell.type == 'WeaponSkill' and player.equipment.ammo == gear.RAbullet then
            add_to_chat(104, 'No weaponskill ammo left.  Using what\'s currently equipped (standard ranged bullets: '..player.equipment.ammo..').')
            return
        else
            add_to_chat(104, 'No ammo ('..tostring(bullet_name)..') available for that action.')
            eventArgs.cancel = true
            return
        end
    end

    -- Don't allow shooting or weaponskilling with ammo reserved for quick draw.
    if spell.type ~= 'CorsairShot' and bullet_name == gear.QDbullet and available_bullets.count <= bullet_min_count then
        add_to_chat(104, 'No ammo will be left for Quick Draw.  Cancelling.')
        eventArgs.cancel = true
        return
    end

    -- Low ammo warning.
    if spell.type ~= 'CorsairShot' and state.LowAmmoWarned.value == false
        and available_bullets.count > 1 and available_bullets.count <= options.ammo_warning_limit then
        local msg = '*****  LOW AMMO WARNING: '..bullet_name..' *****'
        --local border = string.repeat("*", #msg)
        local border = ""
        for i = 1, #msg do
            border = border .. "*"
        end

        add_to_chat(104, border)
        add_to_chat(104, msg)
        add_to_chat(104, border)

        state.LowAmmoWarned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.LowAmmoWarned then
        state.LowAmmoWarned:reset()
    end
end

function special_ammo_check()
    -- Stop if Animikii/Hauksbok equipped
    if no_shoot_ammo:contains(player.equipment.ammo) then
        cancel_spell()
        add_to_chat(123, '** Action Canceled: [ '.. player.equipment.ammo .. ' equipped!! ] **')
        return
    end
end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
        equip(sets.DefaultShield)
    end
end

-- ------- AUTO AMMO ------

-- This was really the first main chunk I found when trying to reverse engineer Auto-Ammo. There are many references to other data and functions,
-- but we can see that the idea is:
--  1. If we have a REMA ranged weapon, we count the available ammo, and compare against some fixed value to see if we are "low".
--  2. Lookup the appropriate ammo-generating item, set a 'useItem' flag to true, and save the item to use and the slot as variables for use somewhere else.
--  3. I added the 'prevItemName' myself in order to make this work with the Arislan-based Lua in conjuction with GearInfo. (Since the ammo belts are considered "no-swap" gear, they wouldn't otherwise unequip after use.)
-- So here we have identified that we need ammo, as well as the item and slot of the ammo-generating item, as well as the item currently equipped in that slot. 
function check_ammo()
    if state.AutoAmmoMode.value and player.equipment.range and not player.in_combat and not world.in_mog_house and not useItem then
		local ammo_to_stock
		if type(ammostock) == 'table' and ammostock[data.equipment.rema_ranged_weapons_ammo[player.equipment.range]] then
			ammo_to_stock = ammostock[data.equipment.rema_ranged_weapons_ammo[player.equipment.range]]
		else
			ammo_to_stock = ammostock
		end
	
		if data.equipment.rema_ranged_weapons:contains(player.equipment.range) and count_total_ammo(data.equipment.rema_ranged_weapons_ammo[player.equipment.range]) < ammo_to_stock then
			if get_usable_item(player.equipment.range).usable then
				windower.chat.input("/item '"..player.equipment.range.."' <me>")
				add_to_chat(217,"You're low on "..data.equipment.rema_ranged_weapons_ammo[player.equipment.range]..", using "..player.equipment.range..".")
				tickdelay = os.clock() + 2
				return true
			elseif item_available(data.equipment.rema_ranged_weapons_ammo_pouch[player.equipment.range]) then
				if ((get_usable_item(data.equipment.rema_ranged_weapons_ammo_pouch[player.equipment.range]).next_use_time) + 18000 -os.time()) < 10 then
					add_to_chat(217,"You're low on "..data.equipment.rema_ranged_weapons_ammo[player.equipment.range]..", using "..data.equipment.rema_ranged_weapons_ammo_pouch[player.equipment.range]..".")
					useItem = true
					useItemName = data.equipment.rema_ranged_weapons_ammo_pouch[player.equipment.range]
                    prevItemName = player.equipment.waist
					useItemSlot = 'waist'
					return true
				end				
			end
		end
	end
	return false
end

-- Helper function used by check_ammo(). Simply counts all available ammo. Probably shouldn't include sack and case?
function count_total_ammo(ammo_name)
	local ammo_count = 0
	
    for _,n in pairs({"inventory","wardrobe","wardrobe2","wardrobe3","wardrobe4","wardrobe5","wardrobe6","wardrobe7","wardrobe8","satchel","sack","case"}) do
		if player[n][ammo_name] then
			ammo_count = ammo_count + player[n][ammo_name].count
		end
    end

	return ammo_count
end

-- Helper function used by check_ammo() and elsewhere. Is given item in a usable spot?
function item_available(item)
	if player.inventory[item] or player.wardrobe[item] or player.wardrobe2[item] or player.wardrobe3[item] or player.wardrobe4[item] or player.wardrobe5[item] or player.wardrobe6[item] or player.wardrobe7[item] or player.wardrobe8[item] then
		return true
	else
		return false
	end
end

-- Now that we have a way to determine whether we need to create ammo and what item and slot creates the ammo, how do we actually use it?
-- We need a way to do a sequence of actions (equip item, wait, use item, wait, equip previous item)
-- This code hooks into windower and supplies a function to be executed before every frame ("prerender").
-- First we just make sure sufficient time has elapsed for our purposes, then we check to make sure we are not incapacitated.
-- If we are good to go, we execute "pre-tick" and "job_tick". Silindrile has many other functions that get called here, and each is customizable for different purposes.
windower.raw_register_event('prerender', function()
    if not (os.clock() > tickdelay) then return end
    
    gearswap.refresh_globals(false)
    
    if (player ~= nil) and (player.status == 'Idle' or player.status == 'Engaged') and 
        not (delayed_cast ~= '' or check_midaction() or moving or buffactive['Sneak'] or buffactive['Invisible'] or silent_check_disable()) then
        if pre_tick() then return end
        if job_tick() then return end
    end

    tickdelay = os.clock() + .5

    init_gear_sets()
end)

-- Helper to determine whether player has some status that prevents action. (True = incapacitated, false = NOT incapacitated)
function silent_check_disable()
	if buffactive.terror or buffactive.petrification or buffactive.sleep or buffactive.Lullaby or buffactive.stun then
		return true
	else
		return false
	end	
end

-- Helper used to make sure we are not in the middle of some action. May not be needed for COR.
function check_midaction(spell, spellMap, eventArgs)
	if os.clock() < next_cast then
		if eventArgs and not (spell.type:startswith('BloodPact') and state.Buff["Astral Conduit"]) then
			eventArgs.cancel = true
			if delayed_cast == '' then
				windower.send_command:schedule((next_cast - os.clock()),'gs c delayedcast')
			end
			delayed_cast = spell.english
			delayed_target = spell.target.id
		end
		return true
	else
		return false
	end
end

-- Part of the "tick" cycle we setup above when connecting to the windower prerender. For auto-ammo, we
-- will simply call one function which checks for and handles pending "use items".
function pre_tick()
	if check_use_item() then return true end
	return false
end

-- Determines whether we have a pending "item to use", and if we do, either use the item, 
-- or in our case for auto-ammo equip the appropiate gear by issuing a windower command.
-- It is worth noting that we do not have direct access to gearswap commands here. 
-- (Eg. I tried using gs equip commands instead of the windoer.send_command(...)), and that does not work,
-- likely because we are dealing directly with windower only here, it is not really aware of the addon gearswap at this point.
-- Also, we have to implement the handling for the 'gs c forceequip' command - that is done in the job_self_command function.
function check_use_item()
	if useItem then
		local Offset = 18000-os.time()
		
		if time_test then
			windower.add_to_chat(tostring(seconds_to_clock(get_usable_item('Warp Ring').next_use_time + Offset)))
		end
		
		if useItemSlot == 'item' and (player.inventory[useItemName] or player.temporary[useItemName]) then
			windower.chat.input('/item "'..useItemName..'" <me>')
			tickdelay = os.clock() + 3.5
			return true
		elseif item_equipped(useItemName) and get_usable_item(useItemName).usable then
			windower.chat.input('/item "'..useItemName..'" <me>')
			tickdelay = os.clock() + 3
			return true
		elseif item_available(useItemName) and ((get_usable_item(useItemName).next_use_time) + Offset) < 10 then
			windower.send_command('gs c forceequip '..useItemSlot..' '..useItemName..'')
			tickdelay = os.clock() + 2
			return true
		elseif player.satchel[useItemName] then
			windower.send_command('get "'..useItemName..'" satchel')
			tickdelay = os.clock() + 2
			return true
		else
			add_to_chat(123,''..useItemName..' not available or ready for use.')
			useItem = false
			return false
		end
	else
		return false
	end
	return false
end

-- The second part of each tick cycle, here we call the check_ammo to see if we need to take any actions.
function job_tick()
	if check_ammo() then return true end
	return false
end

-- Returns time that you can use the given item again
function get_usable_item(name) 
    for _,n in pairs({"inventory","wardrobe","wardrobe2","wardrobe3","wardrobe4","wardrobe5","wardrobe6","wardrobe7","wardrobe8"}) do
        for _,v in pairs(gearswap.items[n]) do
            if type(v) == "table" and v.id ~= 0 and res.items[v.id].english:lower() == name:lower() then
                return extdata.decode(v)
            end
        end
    end
end

-- Is the given item currently equipped?
function item_equipped(item)
	for k, v in pairs(player.equipment) do
		if v == item then
			return true
		end
	end
	return false
end

-- Handles actually equipping the necessary item and ensuring that the slot is disabled so that it stays on long enough to use.
function handle_forceequip(cmdParams)
    if type(commandArgs) == 'string' then
        commandArgs = T(commandArgs:split(' '))
        if #commandArgs == 0 then
            return
        end
    end

    table.remove(cmdParams, 1)

	if cmdParams[1] ~= nil then
		local equipslot = (table.remove(cmdParams, 1)):lower()
        local gear = table.concat(cmdParams, ' ')
        enable(equipslot)
        equip({[equipslot]=gear})
        disable(equipslot)
		
	else
		handle_equipping_gear(player.status)
	end
end
