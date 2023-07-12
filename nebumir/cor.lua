-- Original: Motenten / Modified: Arislan
-- Haste/DW Detection Requires Gearinfo Addon

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
--              [ WIN+C ]           Toggle Capacity Points Mode
--              [ WIN+` ]           Toggle use of Luzaf Ring.
--              [ WIN+Q ]           Quick Draw shot mode selector.
--
--  Abilities:  [ CTRL+- ]          Quick Draw primary shot element cycle forward.
--              [ CTRL+= ]          Quick Draw primary shot element cycle backward.
--              [ ALT+- ]           Quick Draw secondary shot element cycle forward.
--              [ ALT+= ]           Quick Draw secondary shot element cycle backward.
--              [ CTRL+[ ]          Quick Draw toggle target type.
--              [ CTRL+] ]          Quick Draw toggle use secondary shot.
--
--              [ CTRL+C ]          Crooked Cards
--              [ CTRL+` ]          Double-Up
--              [ CTRL+X ]          Fold
--              [ CTRL+S ]          Snake Eye
--              [ CTRL+NumLock ]    Triple Shot
--              [ CTRL+Numpad/ ]    Berserk
--              [ CTRL+Numpad* ]    Warcry
--              [ CTRL+Numpad- ]    Aggressor
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--  Weapons:    [ WIN+E/R ]         Cycles between available Weapon Sets
--              [ WIN+W ]           Toggle Ranged Weapon Lock
--
--  WS:         [ CTRL+Numpad7 ]    Savage Blade
--              [ CTRL+Numpad8 ]    Last Stand
--              [ CTRL+Numpad4 ]    Leaden Salute
--              [ CTRL+Numpad5 ]    Requiescat
--              [ CTRL+Numpad6 ]    Wildfire
--              [ CTRL+Numpad1 ]    Aeolian Edge
--              [ CTRL+Numpad2 ]    Evisceration
--
--  RA:         [ Numpad0 ]         Ranged Attack
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c qd                         Uses the currently configured shot on the target, with either <t> or
--                                  <stnpc> depending on setting.
--  gs c qd t                       Uses the currently configured shot on the target, but forces use of <t>.
--
--  gs c cycle mainqd               Cycles through the available steps to use as the primary shot when using
--                                  one of the above commands.
--  gs c cycle altqd                Cycles through the available steps to use for alternating with the
--                                  configured main shot.
--  gs c toggle usealtqd            Toggles whether or not to use an alternate shot.
--  gs c toggle selectqdtarget      Toggles whether or not to use <stnpc> (as opposed to <t>) when using a shot.
--
--  gs c toggle LuzafRing           Toggles use of Luzaf Ring on and off


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- QuickDraw Selector
    state.Mainqd = M{['description']='Primary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot'}
    state.Altqd = M{['description']='Secondary Shot', 'Fire Shot', 'Ice Shot', 'Wind Shot', 'Earth Shot', 'Thunder Shot', 'Water Shot'}

    state.UseAltqd = M(false, 'Use Secondary Shot')
    state.SelectqdTarget = M(false, 'Select Quick Draw Target')
    state.IgnoreTargetting = M(false, 'Ignore Targetting')

    state.QDMode = M{['description']='Quick Draw Mode', 'STP', 'Enhance', 'Potency', 'TH'}

    state.Currentqd = M{['description']='Current Quick Draw', 'Main', 'Alt'}

    -- Whether to use Luzaf's Ring
    state.LuzafRing = M(true, "Luzaf's Ring")
    -- Whether a warning has been given for low ammo
    state.warned = M(false)
              
    no_shoot_ammo = S{"Animikii Bullet", "Hauksbok Bullet"}

    state.Buff.Doom = false

    include('Mote-TreasureHunter')

    -- For th_action_check():
    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}

    define_roll_values()
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'LowAcc', 'MidAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('STP', 'Normal', 'Acc', 'HighAcc', 'Critical')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'DT', 'Refresh')

    -- state.WeaponSet = M{['description']='Weapon Set', 'DeathPenalty_M', 'DeathPenalty_R', 'Armageddon_M', 'Armageddon_R', 'Fomalhaut_M', 'Fomalhaut_R', 'Ataktos'}
    state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'Fomalhaut_M', 'Fomalhaut_R'}
    state.WeaponLock = M(false, 'Weapon Lock')

    gear.RAbullet = "Chrono Bullet"
    gear.RAccbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Chrono Bullet"
    gear.QDbullet = "Chrono Bullet"

    -- gear.RAbullet = "Chrono Bullet"
    -- gear.RAccbullet = "Devastating Bullet"
    -- gear.WSbullet = "Chrono Bullet"
    -- gear.MAbullet = "Living Bullet"
    -- gear.QDbullet = "Living Bullet"
    options.ammo_warning_limit = 10

    gear.Lanun_A = { name="Lanun Knife", augments={'Path: A',}}
    gear.Lanun_B = { name="Lanun Knife", augments={'Path: B',}}
    gear.Lanun_C = { name="Lanun Knife", augments={'Path: C',}}

    gear.Artifact_Body = { name= "Laksamana's Frac +3" }
    -- gear.Artifact_Legs = { name= "Laksamana's Trews +3" }

    gear.Relic_Head = { name= "Lanun Tricorne +3" }
    gear.Relic_Body = { name= "Lanun Frac +3" }
    gear.Relic_Hands = { name= "Lanun Gants +3" }
    gear.Relic_Legs = { name= "Lanun Trews +3" }
    gear.Relic_Feet = { name= "Lanun Bottes +3" }

    gear.Empyrean_Head = { name= "Chasseur's Tricorne +2" }
    gear.Empyrean_Body = { name= "Chasseur's Frac +2" }
    gear.Empyrean_Hands = { name= "Chasseur's Gants +2" }
    gear.Empyrean_Legs = { name= "Chasseur's Culottes +2" }
    gear.Empyrean_Feet = { name= "Chasseur's Bottes +2" }

    gear.COR_SNP_Cape = { name="Camulus's Mantle", augments={'INT+20','Eva.+20 /Mag. Eva.+20','"Snapshot"+10','Mag. Evasion+15',}} --Done
    gear.COR_RA_Cape = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}} -- 5 Resin ?

    gear.COR_DW_Cape = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}} --Done
    gear.COR_DA_Cape = { name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}} ---Done

    gear.COR_SB_Cape ={ name="Camulus's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}}
    gear.COR_LD_Cape ={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}} 
    gear.COR_LS_Cape ={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}}

    -- Additional local binds
    include('Global-Binds.lua') -- OK to remove this line

    send_command('bind ^= gs c cycle treasuremode')
    send_command ('bind @` gs c toggle LuzafRing')

    send_command ('bind ^` input /ja "Bolter\'s Roll" <me>')
  
    send_command('bind !insert gs c cycleback mainqd')
    send_command('bind !delete gs c cycle mainqd')
    send_command('bind !home gs c cycle altqd')
    send_command('bind !end gs c cycleback altqd')
    send_command('bind !pageup gs c toggle selectqdtarget')
    send_command('bind !pagedown gs c toggle usealtqd')

    send_command('bind @q gs c cycle QDMode')
    send_command('bind @e gs c cycle WeaponSet')
    send_command('bind @w gs c toggle WeaponLock')

    send_command ('bind !f input /ja "Fold" <me>')
    send_command ('bind !t input /ja "Triple Shot" <me>')

    -- ALT + Numpad ===> Rolls --
    send_command('bind !numpad7 input /ja "Samurai Roll" <me>')
    send_command('bind !numpad8 input /ja "Chaos Roll" <me>')
    send_command('bind !numpad9 input /ja "Tactician\'s Roll" <me>')  

    send_command('bind !numpad4 input /ja "Wizard\'s Roll" <me>')
    send_command('bind !numpad5 input /ja "Warlock\'s Roll" <me>')
    send_command('bind !numpad6 input /ja "Beast Roll" <me>')

    send_command('bind !numpad1 input /ja "Fighter\'s Roll" <me>')
    send_command('bind !numpad2 input /ja "Rogue\'s Roll" <me>')
    send_command('bind !numpad3 input /ja "Naturalist\'s Roll" <me>')

    send_command('bind !numpad0 input /ja "Evoker\'s Roll" <me>')
    send_command('bind !numpad- input /ja "Corsair\'s Roll" <me>')
    send_command('bind !numpad+ input /ja "Crooked Cards" <me>')
    sword = 1
    dagger = 2
    if player.sub_job == 'NIN' then
        set_macro_page(sword, 17)
    elseif player.sub_job == 'DNC' then
        send_command('bind !t input /ja "Animated Flourish" <t>')
        sword = 3
        dagger = 4
        set_macro_page(sword, 17)
    else
        set_macro_page(1, 17)
    end

    send_command('bind ^numpad5 gs c set WeaponLock false;gs c set WeaponSet Fomalhaut_M; gs c set WeaponLock true;input /macro set ' ..dagger)
    send_command('bind ^numpad6 gs c set WeaponLock false;gs c set WeaponSet Fomalhaut_R; gs c set WeaponLock true;input /macro set ' ..dagger)
    send_command('bind ^numpad1 gs c set WeaponLock false;gs c set WeaponSet Naegling; gs c set WeaponLock true;input /macro set ' ..sword)
    send_command('wait 3; input /lockstyleset 17')

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command ('unbind ^`')
    send_command('unbind !numpad7')
    send_command('unbind !numpad8')
    send_command('unbind !numpad9')  
    send_command('unbind !numpad4')
    send_command('unbind !numpad5')
    send_command('unbind !numpad6')
    send_command('unbind !numpad1')
    send_command('unbind !numpad2')
    send_command('unbind !numpad3')
    send_command('unbind !numpad0')
    send_command('unbind !numpad+')
    send_command('unbind !numpad-')  
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Precast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.JA['Snake Eye'] = {legs=gear.Relic_Legs}
    sets.precast.JA['Wild Card'] = {feet=gear.Relic_Feet}
    sets.precast.JA['Random Deal'] = {body=gear.Relic_Body}

    sets.precast.CorsairRoll = {
        head=gear.Relic_Head,
        body=gear.Malignance_Body, --9/9
        hands=gear.Empyrean_Hands,
        legs="Desultor Tassets",
        feet=gear.Malignance_Feet, --4/0
        neck="Regal Necklace",
        ear1="Odnowa Earring +1", --3/5
        ear2="Etiolation Earring", --0/3
        ring1="Gelatinous Ring +1", --7/(-1)
        ring2="Defending Ring", --10/10
        back=gear.COR_SNP_Cape,
        waist="Flume Belt +1", --4/0
    }

    sets.precast.CorsairRoll.Duration = {main={name="Lanun Knife"}, range="Compensator"}

    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs=gear.Empyrean_Legs})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet=gear.Empyrean_Feet})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head=gear.Empyrean_Head})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body=gear.Empyrean_Body})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands=gear.Empyrean_Hands})

    sets.precast.LuzafRing = {ring1="Luzaf's Ring"}
    sets.precast.FoldDoubleBust = {hands=gear.Relic_Hands}

    sets.precast.Waltz = {
        ammo="Voluspa Tathlum",
        neck="Unmoving Collar +1",
        ear1="Handler's Earring +1",
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
        hands="Leyline Gloves", --6
        legs="Rawhide Trousers", --5
        feet=gear.Carmine_B_Feet, --8
        -- neck="Orunmila's Torque", --5
        neck="Baetyl Pendant",
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring1="Weather. Ring", --6(4)
        ring2="Kishar Ring", --4
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        body="Passion Jacket",
        ring1="Lebeche Ring",
    })

    -- (10% Snapshot from JP Gifts)
    sets.precast.RA = {
        ammo=gear.RAbullet,
        head=gear.Empyrean_Head, --0/14
        body="Oshosi Vest +1", --14/0
        hands=gear.Relic_Hands, --13/0
        legs=gear.Adhemar_D_Legs, --10/13
        feet="Meg. Jam. +2", --10/0
        neck="Comm. Charm +1", --4/0
        back=gear.COR_SNP_Cape, --10/0
        waist="Yemaya Belt", --0/5
    } --61/32

    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
        body=gear.Artifact_Body, --0/20
    }) --47/52

    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
        hands=gear.Carmine_D_Hands, --8/11
        feet="Pursuer's Gaiters", --0/10
    }) --32/73


    ------------------------------------------------------------------------------------------------
    ------------------------------------- Weapon Skill Sets ----------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.precast.WS = {
        ammo=gear.WSbullet,
        head=gear.Relic_Head,
        body=gear.Artifact_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Herc_RA_Legs,
        feet=gear.Relic_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1="Dingir Ring",
        ring2="Epaminondas's Ring",
        back=gear.COR_LS_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ammo=gear.RAccbullet,
        feet="Meg. Jam. +2",
        ear1="Beyla Earring",
        ear2="Telos Earring",
        neck="Iskur Gorget",
        ring2="Cacoethic ring +1",
        waist="K. Kachina Belt +1",
    })

    sets.precast.WS['Last Stand'] = {
        ammo=gear.WSbullet,
        head=gear.Nyame_Head,
        body=gear.Artifact_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Relic_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2="Epaminondas's Ring",
        back=gear.COR_WS3_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
        ammo=gear.RAccbullet,
        neck="Iskur Gorget",
        ear1="Beyla Earring",
        ear2="Telos Earring",
        ring2="Cacoethic ring +1",
        waist="K. Kachina Belt +1",
    })

    sets.precast.WS['Wildfire'] = {
        ammo=gear.MAbullet,
        head=gear.Nyame_Head,
        body=gear.Relic_Body,
        hands=gear.Nyame_Hands, -- TODO Asap
        legs=gear.Nyame_Legs,
        feet=gear.Relic_Feet,
        neck="Comm. Charm +1",
        -- ear1="Crematio Earring",
        ear1="Sortiarius Earring",
        ear2="Friomisi Earring",
        ring1="Dingir Ring",
        ring2="Epaminondas's Ring",
        back=gear.COR_LS_Cape,
        waist="Eschan Stone",
    }

    sets.precast.WS['Leaden Salute'] = set_combine(sets.precast.WS['Wildfire'], {
        head="Pixie Hairpin +1",
        -- waist="Svelt. Gouriz +1",
        ear1="Moonshade Earring",
        back=gear.COR_LD_Cape,
        ring1="Archon Ring",
    })

    sets.precast.WS['Hot Shot'] = sets.precast.WS['Wildfire']

    sets.precast.WS['Evisceration'] = {
        head=gear.Adhemar_A_Head,
        -- body="Abnoba Kaftan",
        hands="Mummu Wrists +2",
        legs="Zoar Subligar +1",
        -- feet="Mummu Gamash. +2",
        feet=gear.Adhemar_D_Feet,
        neck="Fotia Gorget",
        ear1="Mache Earring +1",
        ear2="Odr Earring",
        ring1="Regal Ring",
        ring2="Mummu Ring",
        back=gear.COR_DA_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {

        body=gear.Adhemar_A_Body,
        legs=gear.Herc_WSD_Legs,
    })

    sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {
        head=gear.Nyame_Head,
        body=gear.Artifact_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Comm. Charm +1",
        ear1="Moonshade Earring",
        ear2="Telos Earring",
        ring1="Sroda Ring",
        ring2="Epaminondas's Ring",
        back=gear.COR_SB_Cape,
        waist="Sailfi Belt +1",
    })

    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS['Savage Blade'], {
    })

    sets.precast.WS['Swift Blade'] = set_combine(sets.precast.WS, {
        head=gear.Adhemar_A_Head,
        body=gear.Adhemar_A_Body,
        hands=gear.Adhemar_B_Hands,
        legs="Meg. Chausses +2",
        feet=gear.Herc_TA_Feet,
        ear1="Cessance Earring",
        ear2="Brutal Earring",
        ring1="Regal Ring",
        ring2="Epona's Ring",
        back=gear.COR_SB_Cape,
    })

    sets.precast.WS['Swift Blade'].Acc = set_combine(sets.precast.WS['Swift Blade'], {
        hands=gear.Adhemar_A_Hands,
        ear2="Telos Earring",
    })

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS['Swift Blade'], {
        hands="Meg. Gloves +2",
        ear1="Moonshade Earring",
        ear2="Telos Earring",
        ring2="Rufescent Ring",
    }) --MND

    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS['Requiescat'], {
        ear1="Cessance Earring",
    })

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS['Wildfire'], {
        ammo=gear.QDbullet,
        ear1="Moonshade Earring",
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

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

    sets.midcast.Cure = {
        neck="Incanter's Torque",
        ear1="Meili Earring",
        ear2="Mendi. Earring",
        ring1="Lebeche Ring",
        ring2="Haoma's Ring",
        waist="Bishop's Sash",
    }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast.CorsairShot = {
        ammo=gear.QDbullet,
        head=gear.Nyame_Head,
        body=gear.Relic_Body,
        hands=gear.Carmine_D_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Relic_Feet,
        neck="Baetyl Pendant",
        -- ear1="Crematio Earring",
        ear1="Novio Earring",
        ear2="Friomisi Earring",
        ring1="Dingir Ring",
        ring2="Fenrir Ring +1",
        back=gear.COR_LS_Cape,
        waist="Skrymir Cord +1",
    }

    sets.midcast.CorsairShot.STP = {
        ammo=gear.QDbullet,
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Iskur Gorget",
        ear1="Dedition Earring",
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.COR_RA_Cape,
        waist="Kentarch Belt +1",
    }

    sets.midcast.CorsairShot['Light Shot'] = {
        ammo=gear.RAccbullet,
        head=gear.Artifact_Head,
        body=gear.Malignance_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Artifact_Feet,
        neck="Comm. Charm +1",
        ear1="Enchntr. Earring +1",
        ear2="Dignitary's Earring",
        ring1="Regal Ring",
        ring2="Weather. Ring",
        back=gear.COR_LS_Cape,
        waist="K. Kachina Belt +1",
    }

    sets.midcast.CorsairShot['Dark Shot'] = sets.midcast.CorsairShot['Light Shot']
    sets.midcast.CorsairShot.Enhance = {body="Mirke Wardecors", feet=gear.Empyrean_Feet}

    -- Ranged gear
    sets.midcast.RA = {
        ammo=gear.RAbullet,
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Iskur Gorget",
        ear1="Enervating Earring",
        ear2="Telos Earring",
        ring1="Dingir Ring",
        ring2="Ilabrat Ring",
        back=gear.COR_RA_Cape,
        waist="Yemaya Belt",
    }

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
        ammo=gear.RAccbullet,
        ear1="Beyla Earring",
        ring2="Cacoethic ring +1",
    })

    sets.midcast.RA.HighAcc = set_combine(sets.midcast.RA.Acc, {
        -- legs=gear.Artifact_Legs,
        ring1="Regal Ring",
        waist="K. Kachina Belt +1",
    })

    sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
        head="Meghanada Visor +2",
        body="Mummu Jacket +2",
        hands="Mummu Wrists +2",
        feet="Osh. Leggings +1",
        ring1="Begrudging Ring",
        ring2="Mummu Ring",
        waist="K. Kachina Belt +1",
    })

    sets.midcast.RA.STP = set_combine(sets.midcast.RA, {
        ear1="Dedition Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
    })

    sets.TripleShot = {
        head="Oshosi Mask +1", --5
        body=gear.Empyrean_Body, --12
        hands=gear.Relic_Hands,
        legs="Osh. Trousers +1", --6
        feet="Osh. Leggings +1", --3
    } --27

    sets.TripleShotCritical = {
        head="Meghanada Visor +2",
        waist="K. Kachina Belt +1",
    }

    sets.TrueShot = {
        -- body="Nisroch Jerkin",
        legs="Osh. Trousers +1",
    }



    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        ammo=gear.RAbullet,
        head=gear.Adhemar_A_Head,
        body=gear.Adhemar_A_Body,
        hands=gear.Adhemar_B_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Malignance_Feet,
        neck="Iskur Gorget",
        ear1="Cessance Earring",
        ear2="Brutal Earring",
        -- ring1="Hetairoi Ring",
        -- ring2="Epona's Ring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.COR_DA_Cape,
        waist="Sailfi Belt +1",
    }

    sets.engaged.LowAcc = set_combine(sets.engaged, {
        -- head="Dampening Tam",
        hands=gear.Adhemar_A_Hands,
        ring1=gear.Chirich_1,
        -- neck="Combatant's Torque",
    })

    sets.engaged.MidAcc = set_combine(sets.engaged.LowAcc, {
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
    })

    sets.engaged.HighAcc = set_combine(sets.engaged.MidAcc, {
        head=gear.Carmine_D_Head,
        hands="Gazu Bracelets +1",
        ear1="Mache Earring +1",
        ear2="Odr Earring",
        ring2=gear.Chirich_2,
        waist="Kentarch Belt +1",
    })


    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
        head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Iskur Gorget",
        -- waist={ name="Sailfi Belt +1", augments={'Path: A',}},
         waist="Sailfi Belt +1",
        left_ear="Cessance Earring",
        right_ear="Telos Earring",
        ring1="Chirich Ring +1",
        ring2="Petrov Ring",
        back=gear.COR_DW_Cape,
    } -- 48%

    sets.engaged.DW.LowAcc = set_combine(sets.engaged.DW, {
        -- head="Dampening Tam",
        ring1=gear.Chirich_1,
        -- neck="Combatant's Torque",
    })

    sets.engaged.DW.MidAcc = set_combine(sets.engaged.DW.LowAcc, {
        hands=gear.Adhemar_A_Hands,
        ear1="Cessance Earring",
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
    })

    sets.engaged.DW.HighAcc = set_combine(sets.engaged.DW.MidAcc, {
        head=gear.Carmine_D_Head,
        hands="Gazu Bracelets +1",
        ear1="Mache Earring +1",
        ear2="Odr Earring",
        ring2=gear.Chirich_2,
        -- waist="Olseni Belt",
    })


    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = {
        ammo=gear.RAbullet,
        head=gear.Adhemar_A_Head,
        body=gear.Adhemar_A_Body, --6
        hands=gear.Malignance_Hands,
        legs=gear.Carmine_D_Legs, --6
        -- feet=gear.Taeon_DW_Feet, --9
        feet=gear.Malignance_Feet,
        neck="Iskur Gorget",
        ear1="Suppanomimi", --5
        ear2="Eabani Earring", --4
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.COR_DW_Cape, --10
        -- waist="Reiki Yotai", --7
         waist="Sailfi Belt +1",
    } -- 47%

    sets.engaged.DW.LowAcc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
        -- head="Dampening Tam",
        ring1=gear.Chirich_1,
        -- neck="Combatant's Torque",
    })

    sets.engaged.DW.MidAcc.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, {
        hands=gear.Adhemar_A_Hands,
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
    })

    sets.engaged.DW.HighAcc.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, {
        head=gear.Carmine_D_Head,
        hands="Gazu Bracelets +1",
        ear1="Mache Earring +1",
        ear2="Odr Earring",
        ring2=gear.Chirich_2,
        -- waist="Olseni Belt",
    })


    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = {
        ammo=gear.RAbullet,
        head=gear.Adhemar_A_Head,
        body=gear.Adhemar_A_Body, --6
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        -- feet=gear.Taeon_DW_Feet, --9
        feet=gear.Malignance_Feet,
        neck="Iskur Gorget",
        ear1="Suppanomimi", --5
        ear2="Eabani Earring", --4
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.COR_DW_Cape, --10
        -- waist="Reiki Yotai", --7
         waist="Sailfi Belt +1",
    } -- 31%

    sets.engaged.DW.LowAcc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {
        -- head="Dampening Tam",
        hands=gear.Adhemar_A_Hands,
        ring1=gear.Chirich_1,
        -- neck="Combatant's Torque",
    })

    sets.engaged.DW.MidAcc.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, {
        legs="Meg. Chausses +2",
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
    })

    sets.engaged.DW.HighAcc.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, {
        head=gear.Carmine_D_Head,
        hands="Gazu Bracelets +1",
        legs=gear.Carmine_D_Legs,
        ear1="Mache Earring +1",
        ear2="Odr Earring",
        ring2=gear.Chirich_2,
        -- waist="Olseni Belt",
    })

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = {
        ammo=gear.RAbullet,
        head=gear.Adhemar_A_Head,
        body=gear.Adhemar_A_Body, --6
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        -- feet=gear.Herc_TA_Feet,
        feet=gear.Malignance_Feet,
        neck="Iskur Gorget",
        ear1="Suppanomimi", --5
        ear2="Eabani Earring", --4
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.COR_DW_Cape, --10
        -- waist="Reiki Yotai", --7
         waist="Sailfi Belt +1",
    } -- 27%

    sets.engaged.DW.LowAcc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
        hands=gear.Adhemar_A_Hands,
        ring1=gear.Chirich_1,
    })

    sets.engaged.DW.MidAcc.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, {
        legs="Meg. Chausses +2",
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        waist="Kentarch Belt +1",
    })

    sets.engaged.DW.HighAcc.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, {
        head=gear.Carmine_D_Head,
        hands="Gazu Bracelets +1",
        legs=gear.Carmine_D_Legs,
        ear1="Mache Earring +1",
        ear2="Odr Earring",
        ring2=gear.Chirich_2,
        -- waist="Olseni Belt",
    })


    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = {
        ammo=gear.RAbullet,
        head=gear.Malignance_Head,
        body=gear.Adhemar_A_Body, --6
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Iskur Gorget",
        ear1="Suppanomimi", --5
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.COR_DA_Cape,
         waist="Sailfi Belt +1",
    } -- 11%

    sets.engaged.DW.LowAcc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
        hands=gear.Adhemar_A_Hands,
        ring1=gear.Chirich_1,
        waist="Kentarch Belt +1",
    })

    sets.engaged.DW.MidAcc.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, {
        legs="Meg. Chausses +2",
        ear1="Cessance Earring",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
    })

    sets.engaged.DW.HighAcc.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, {
        head=gear.Carmine_D_Head,
        hands="Gazu Bracelets +1",
        legs=gear.Carmine_D_Legs,
        ear1="Mache Earring +1",
        ear2="Odr Earring",
        ring2=gear.Chirich_2,
    })


    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        head=gear.Malignance_Head,
        body=gear.Malignance_Body, --9/9
        hands=gear.Malignance_Hands, --5/5
        legs=gear.Malignance_Legs, --7/7
        feet=gear.Malignance_Feet, --4/4
        back=gear.COR_DW_Cape,
        ear1="Cessance Earring",
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.LowAcc.DT = set_combine(sets.engaged.LowAcc, sets.engaged.Hybrid)
    sets.engaged.MidAcc.DT = set_combine(sets.engaged.MidAcc, sets.engaged.Hybrid)
    sets.engaged.HighAcc.DT = set_combine(sets.engaged.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT = set_combine(sets.engaged.DW.LowAcc, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT = set_combine(sets.engaged.DW.MidAcc, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT = set_combine(sets.engaged.DW.HighAcc, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.LowHaste = set_combine(sets.engaged.DW.LowAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.LowHaste = set_combine(sets.engaged.DW.MidAcc.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.LowHaste = set_combine(sets.engaged.DW.HighAcc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MidHaste = set_combine(sets.engaged.DW.LowAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MidHaste = set_combine(sets.engaged.DW.MidAcc.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MidHaste = set_combine(sets.engaged.DW.HighAcc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.HighHaste = set_combine(sets.engaged.DW.LowAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.HighHaste = set_combine(sets.engaged.DW.MidAcc.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.HighHaste = set_combine(sets.engaged.DW.HighAcc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.LowAcc.DT.MaxHaste = set_combine(sets.engaged.DW.LowAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.MidAcc.DT.MaxHaste = set_combine(sets.engaged.DW.MidAcc.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.HighAcc.DT.MaxHaste = set_combine(sets.engaged.DW.HighAcc.MaxHaste, sets.engaged.Hybrid)

------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

    sets.idle = {
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        -- neck="Bathy Choker +1",
        neck="Loricate Torque +1",
        ear1="Infused Earring",
        ear2="Eabani Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.COR_SNP_Cape,
        waist="Carrier's Sash",
    }

    sets.idle.DT = set_combine(sets.idle, {
        head=gear.Malignance_Head, --6/6
        body=gear.Malignance_Body, --9/9
        hands=gear.Malignance_Hands, --5/5
        legs=gear.Malignance_Legs, --7/7
        feet=gear.Malignance_Feet, --4/4
        neck="Warder's Charm +1",
        ring1="Purity Ring", --0/4
        ring2="Defending Ring", --10/10
        back="Moonlight Cape", --6/6
    })

    sets.idle.Refresh = set_combine(sets.idle, {
        head=gear.Herc_Idle_Head,
        --body="Mekosu. Harness",
        legs="Rawhide Trousers",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
    })

    sets.idle.Town = sets.engaged.DW.MaxHaste

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT

    sets.defense.MDT = {
        head=gear.Malignance_Head, --6/6
        body=gear.Malignance_Body, --9/9
        hands=gear.Malignance_Hands, --5/5
        legs=gear.Malignance_Legs, --7/7
        feet=gear.Malignance_Feet, --4/4
        neck="Warder's Charm +1",
        ear1="Etiolation Earring",
        ear2="Eabani Earring",
        ring1="Purity Ring", --0/4
        ring2="Defending Ring", --10/10
        back=gear.COR_SNP_Cape,
        waist="Carrier's Sash",
    }

    sets.Kiting = { ring1="Shneddick Ring" }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Purity Ring", --20
        waist="Gishdubar Sash", --10
    }

    -- sets.FullTP = {ear1="Crematio Earring"}
    -- sets.FullTP = {ear1="Novio Earring"}
    sets.Obi = {waist="Hachirin-no-Obi"}

    sets.TreasureHunter = {
        ammo="Perfect Lucky Egg",
        head="Volte Cap", 
        hands="Volte Bracers", 
        waist="Chaac Belt"
    }

    -- sets.DeathPenalty_M = {main={name="Rostam", bag="wardrobe3"}, sub="Tauret", ranged="Death Penalty"}
    -- sets.DeathPenalty_M.Acc = {main={name="Rostam", bag="wardrobe3"}, sub={name="Rostam", bag="wardrobe"}, ranged="Death Penalty"}
    -- sets.DeathPenalty_R = {main="Lanun Knife", sub="Tauret", ranged="Death Penalty"}
    -- sets.DeathPenalty_R.Acc = {main="Lanun Knife", sub={name="Rostam", bag="wardrobe"}, ranged="Death Penalty"}
    -- sets.Armageddon_M = {main="Naegling", sub="Tauret", ranged="Armageddon"}
    -- sets.Armageddon_M.Acc = {main="Rostam", sub="Blurred Knife +1", ranged="Armageddon"}
    -- sets.Armageddon_R = {main="Rostam", sub="Kustawi +1", ranged="Armageddon"}
    -- sets.Armageddon_R.Acc = sets.Armageddon_R
    -- sets.Fomalhaut_M = {main="Rostam", sub="Blurred Knife +1", ranged="Fomalhaut"}
    -- sets.Fomalhaut_M.Acc = {main="Rostam", sub="Blurred Knife +1", ranged="Fomalhaut"}
    -- sets.Fomalhaut_R = {main="Rostam", sub="Tauret", ranged="Fomalhaut"}
    -- sets.Fomalhaut_R.Acc = sets.Fomalhaut_R
    sets.Naegling = {main="Naegling", sub="Gleti's Knife", ranged="Anarchy +2"}
    sets.Fomalhaut_M = {main=gear.Lanun_B, sub="Gleti's Knife", ranged="Fomalhaut"}
    sets.Fomalhaut_R = {main=gear.Lanun_A, sub="Kustawi +1", ranged="Fomalhaut"}

    sets.DefaultShield = {sub="Nusku Shield"}

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

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
        if player.status ~= 'Engaged' and state.WeaponLock.value == false then
            equip(sets.precast.CorsairRoll.Duration)
        end
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
        if spell.english == 'Leaden Salute' or spell.english == 'Aeolian Edge' and player.tp > 2900 then
            equip(sets.FullTP)
        end
        if elemental_ws:contains(spell.name) then
            -- Matching double weather (w/o day conflict).
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
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' then
        if (spell.english ~= 'Light Shot' and spell.english ~= 'Dark Shot') then
            -- Matching double weather (w/o day conflict).
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
            if state.QDMode.value == 'Enhance' then
                equip(sets.midcast.CorsairShot.Enhance)
            elseif state.QDMode.value == 'TH' then
                equip(sets.midcast.CorsairShot)
                equip(sets.TreasureHunter)
            elseif state.QDMode.value == 'STP' then
                equip(sets.midcast.CorsairShot.STP)
            end
        end
    elseif spell.action_type == 'Ranged Attack' then
        if buffactive['Triple Shot'] then
            equip(sets.TripleShot)
            if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
                equip(sets.TripleShotCritical)
                if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                    equip(sets.TrueShot)
                end
            end
        elseif buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
            equip(sets.midcast.RA.Critical)
            if (spell.target.distance < (7 + spell.target.model_size)) and (spell.target.distance > (5 + spell.target.model_size)) then
                equip(sets.TrueShot)
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

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

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
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
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

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if spell.skill == 'Marksmanship' then
        if state.RangedMode.value == 'Acc' or state.RangedMode.value == 'HighAcc' then
            wsmode = 'Acc'
        end
    else
        if state.OffenseMode.value == 'Acc' or state.OffenseMode.value == 'HighAcc' then
            wsmode = 'Acc'
        end
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

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'CorsairShot' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end

        eventArgs.SelectNPCTargets = state.SelectqdTarget.value
    end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
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

    local qd_msg = '(' ..string.sub(state.QDMode.value,1,1).. ')'

    local e_msg = state.Mainqd.current
    if state.UseAltqd.value == true then
        e_msg = e_msg .. '/'..state.Altqd.current
    end

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
        ..string.char(31,060).. ' QD' ..qd_msg.. ': '  ..string.char(31,001)..e_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

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

    function determine_haste_group()
        classes.CustomMeleeGroups:clear()
        if DW == true then
            if DW_needed <= 11 then
                classes.CustomMeleeGroups:append('MaxHaste')
            elseif DW_needed > 12 and DW_needed <= 27 then
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

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'qd' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end

        local doqd = ''
        if state.UseAltqd.value == true then
            doqd = state[state.Currentqd.current..'qd'].current
            state.Currentqd:cycle()
        else
            doqd = state.Mainqd.current
        end

        send_command('@input /ja "'..doqd..'" <t>')
    end

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
    -- send_command('@input /item "Barrels of Fun" <me>')
    -- if (player.tp > 1000) then 
    --     send_command('@input /ws "Hot Shot" <t>')
    -- end
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
    if spell.type ~= 'CorsairShot' and state.warned.value == false
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

        state.warned:set()
    elseif available_bullets.count > options.ammo_warning_limit and state.warned then
        state.warned:reset()
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
    if state.OffenseMode.value == 'LowAcc' or state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        equip(sets[state.WeaponSet.current].Acc)
    else
        equip(sets[state.WeaponSet.current])
    end
    
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
        equip(sets.DefaultShield)
    end
end