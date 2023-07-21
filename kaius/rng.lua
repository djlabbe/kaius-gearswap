-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------
--
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
    res = require('resources')
    extdata = require('extdata')
end


function job_setup()
    state.Buff.Barrage = buffactive.Barrage or false
    state.Buff.Camouflage = buffactive.Camouflage or false
    state.Buff['Unlimited Shot'] = buffactive['Unlimited Shot'] or false
    state.Buff['Velocity Shot'] = buffactive['Velocity Shot'] or false
    state.Buff['Double Shot'] = buffactive['Double Shot'] or false
    state.Buff.Doom = false
    state.warned = M(false) -- Whether a warning has been given for low ammo

    state.AutoAmmoMode = M(true,'Auto Ammo Mode')
    tickdelay = os.clock() + 5
    ammostock = 200
    useItem = false
	useItemName = ''
    prevItemName = ''
	useItemSlot = ''
    next_cast = 0
    delayed_cast = ''

    data.equipment = {}
    data.equipment.rema_ranged_weapons = S{'Fomalhaut','Gastraphetes', 'Armageddon', 'Annihilator'}

    data.equipment.rema_ranged_weapons_ammo = {
        ['Fomalhaut'] = 'Chrono Bullet',
        ['Gastraphetes'] = 'Quelling Bolt',
        ['Armageddon'] = 'Devastating Bullet',
        ['Annihilator'] = 'Eradicating Bullet'
    }

    data.equipment.rema_ranged_weapons_ammo_pouch = {
        ['Fomalhaut'] = 'Chr. Bul. Pouch',
        ['Gastraphetes'] = 'Quelling B. Quiver',
        ['Armageddon'] = 'Dev. Bul. Pouch',
        ['Annihilator'] = 'Era. Bul. Pouch'
    }

    no_shoot_ammo = S{"Animikii Bullet", "Hauksbok Arrow"}
    hybrid_ws = S{'Hot Shot'}
end

function user_setup()
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal', 'DT')
    state.RangedMode:options('Normal', 'Acc', 'Critical', 'PDL')
    state.WeaponskillMode:options('Normal', 'Acc', 'Enmity', 'PDL')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Gastraphetes', 'Fomalhaut', 'Fomalhaut_HS', 'Armageddon', 'Annihilator', 'Savage', 'Aoe'}
    state.WeaponLock = M(false, 'Weapon Lock')

    DefaultAmmo = {
                    ['Yoichinoyumi'] = "Chrono Arrow",
                    ['Gandiva'] = "Chrono Arrow",
                    ['Fail-Not'] = "Chrono Arrow",
                    ['Annihilator'] = "Chrono Bullet",
                    ['Armageddon'] = "Chrono Bullet",
                    ['Gastraphetes'] = "Quelling Bolt",
                    ['Fomalhaut'] = "Chrono Bullet",
                    ['Sparrowhawk +2'] = "Chrono Arrow",
                  }

    AccAmmo = {    
                    ['Yoichinoyumi'] = "Yoichi's Arrow",
                    ['Gandiva'] = "Yoichi's Arrow",
                    ['Fail-Not'] = "Yoichi's Arrow",
                    ['Annihilator'] = "Eradicating Bullet",
                    ['Armageddon'] = "Eradicating Bullet",
                    ['Gastraphetes'] = "Quelling Bolt",
                    ['Fomalhaut'] = "Eradicating Bullet",
                    ['Sparrowhawk +2'] = "Chrono Arrow",
              }

    WSAmmo = {     
                    ['Yoichinoyumi'] = "Chrono Arrow",
                    ['Gandiva'] = "Chrono Arrow",
                    ['Fail-Not'] = "Chrono Arrow",
                    ['Annihilator'] = "Chrono Bullet",
                    ['Armageddon'] = "Chrono Bullet",
                    ['Gastraphetes'] = "Quelling Bolt",
                    ['Fomalhaut'] = "Chrono Bullet",
                    ['Sparrowhawk +2'] = "Chrono Arrow",
             }

    MagicAmmo = {  
                    ['Yoichinoyumi'] = "Chrono Arrow",
                    ['Gandiva'] = "Chrono Arrow",
                    ['Fail-Not'] = "Chrono Arrow",
                    ['Annihilator'] = "Devastating Bullet",
                    ['Armageddon'] = "Devastating Bullet",
                    ['Gastraphetes'] = "Quelling Bolt",
                    ['Fomalhaut'] = "Devastating Bullet",
                    ['Sparrowhawk +2'] = "Chrono Arrow",
                }

    include('Global-Binds.lua')

    gear.Artifact_Head = { name="Orion Beret +3" }
    -- gear.Artifact_Body = { name="Orion Jerkin +1" }
    gear.Artifact_Legs = { name="Orion Braccae +1" }
    gear.Artifact_Hands = { name="Orion Bracers +2" }
    gear.Artifact_Feet = { name="Orion Socks +2" }

    gear.Relic_Head = { name="Arcadian Beret +3" }
    gear.Relic_Body = { name="Arcadian Jerkin +3" }
    gear.Relic_Legs = { name="Arcadian Braccae +3" }
    gear.Relic_Hands = { name="Arcadian Bracers +3" }
    gear.Relic_Feet = { name="Arcadian Socks +3" }

    gear.Empyrean_Head = { name="Amini Gapette +2" }
    gear.Empyrean_Body = { name="Amini Caban +3" }
    gear.Empyrean_Hands = { name="Amini Glovelettes +3" }
    gear.Empyrean_Legs = { name="Amini Bragues +3" }    
    gear.Empyrean_Feet = { name="Amini Bottillons +3" }

    gear.RNG_DW_Cape ={ name="Belenus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}}
    gear.RNG_RA_Cape = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.RNG_SNP_Cape = { name="Belenus's Cape", augments={'"Snapshot"+10',}}
    gear.RNG_TP_Cape = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    gear.RNG_LS_Cape = { name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    gear.RNG_TF_Cape = { name="Belenus's Cape", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
    gear.RNG_SB_Cape = { name="Belenus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    gear.RNG_CRIT_Cape = { name="Belenus's Cape", augments={'AGI+20','Accuracy+20 Attack+20','Crit.hit rate+10','Phys. dmg. taken-10%',}}

    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind !F1 input /ja "Eagle Eye SHot" <me>')
    send_command('bind !F2 input /ja "Overkill" <me>')

    send_command('bind !` input /ja "Velocity Shot" <me>')
    send_command('bind ^` input /ja "Hover Shot" <me>')
    send_command('bind !b input /ja "Shadowbind" <t>')

    marks = 1
    sword = 4
    if player.sub_job == 'WAR' then
        send_command('bind !t input /ja "Provoke" <t>')
        set_macro_page(marks, 11)
    elseif player.sub_job == 'DNC' then
        send_command('bind ^` input /ja "Chocobo Jig" <me>')
        marks = 2
        sword = 5
        set_macro_page(marks, 11)
    elseif player.sub_job == 'NIN' then
        marks = 3
        sword = 6
        set_macro_page(marks, 11)
    else
        set_macro_page(1, 11)
    end

    send_command('bind ^numpad7 gs c set WeaponSet Gastraphetes; input //dp xbow; input /macro set ' ..marks)
    send_command('bind ^numpad8 gs c set WeaponSet Fomalhaut; input //dp gun; input /macro set ' ..marks)
    send_command('bind ^numpad9 gs c set WeaponSet Fomalhaut_HS; input //dp gun; input /macro set ' ..marks)

    send_command('bind ^numpad4 gs c set WeaponSet Armageddon; input //dp gun; input /macro set ' ..marks)
    send_command('bind ^numpad5 gs c set WeaponSet Annihilator; input //dp gun; input /macro set ' ..marks)

    send_command('bind ^numpad1 gs c set WeaponSet Savage; input //dp bow; input /macro set ' ..sword)
    send_command('bind ^numpad2 gs c set WeaponSet Aoe; input //dp bow; input /macro set ' ..marks)

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    send_command('wait 3; input /lockstyleset 11')
    update_combat_form()
    determine_haste_group()
end

function user_unload()
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @r')
end


function init_gear_sets()
    sets.precast.JA['Eagle Eye Shot'] = { legs=gear.Relic_Legs }
    sets.precast.JA['Bounty Shot'] = { hands=gear.Empyrean_Hands }
    sets.precast.JA['Camouflage'] = { body=gear.Artifact_Body }
    sets.precast.JA['Scavenge'] = { feet=gear.Artifact_Feet }
    sets.precast.JA['Shadowbind'] = { hands=gear.Artifact_Feet }
    sets.precast.JA['Sharpshot'] = { legs=gear.Artifact_Legs }

    sets.precast.Waltz = {
        body="Passion Jacket",
        ring1="Asklepian Ring",
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
        ring2="Defending Ring",
        waist="Rumination Sash",
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        body="Passion Jacket",
        ring2="Lebeche Ring",
    })

    sets.precast.RA = {
        head=gear.Taeon_SNAP_Head, --10/0
        body=gear.Empyrean_Body,
        hands=gear.Carmine_D_Hands, --8/11
        legs=gear.Artifact_Legs, --15/0
        feet="Meghanada Jambeaux +2", --10/0
        neck="Scout's Gorget +2", --4/0
        ring1="Crepuscular Ring", --3/0
        back=gear.RNG_SNP_Cape, --10/0
        waist="Yemaya Belt",
    } --60/11

    sets.precast.RA.Flurry1 = set_combine(sets.precast.RA, {
        head=gear.Artifact_Head, --0/18
        legs=gear.Adhemar_D_Legs, --10/13
    }) --45/42

    sets.precast.RA.Flurry2 = set_combine(sets.precast.RA.Flurry1, {
        feet=gear.Relic_Feet, --0/10
    }) --32/57

    
    sets.precast.RA.Gastra = {
        head=gear.Artifact_Head, --15/00
        body=gear.Empyrean_Body,
        hands=gear.Carmine_D_Hands, --8/11
        legs=gear.Artifact_Legs, --15/0
        feet="Meghanada Jambeaux +2", --10/0
        neck="Scout's Gorget +2", --4/0
        ring1="Crepuscular Ring", --3/0
        back=gear.RNG_SNP_Cape, --10/0
        waist="Yemaya Belt",
    }
    sets.precast.RA.Gastra.Flurry1 = set_combine(sets.precast.RA.Gastra, {
        legs=gear.Adhemar_D_Legs,
        feet=gear.Relic_Feet, --0/10
    })

    sets.precast.RA.Gastra.Flurry2 = set_combine(sets.precast.RA.Gastra.Flurry1, {
        legs="Pursuer's Pants", --0/19
    })
   
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
        waist="Rumination Sash", --10
    }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast.RA = {
        head=gear.Relic_Head,
        body=gear.Ikenga_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Scout's Gorget +2",
        ear1="Dedition Earring",
        ear2="Telos Earring",
        ring1="Ilabrat Ring",
        ring2="Regal Ring",
        back=gear.RNG_RA_Cape,
        waist="Tellen Belt",
    }

    sets.midcast.RA.Acc = set_combine(sets.midcast.RA, {
        ear1="Crepuscular Earring",
        ring2="Crepuscular Ring",
    })

    sets.midcast.RA.Critical = set_combine(sets.midcast.RA, {
        -- head=gear.Relic_Head,
        -- body=gear.Empyrean_Body,
        head="Meghanada Visor +2",
        body="Nisroch Jerkin",
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet="Oshosi Leggings +1",
        neck="Scout's Gorget +2",
        ear1="Odr Earring",
        ear2="Amini Earring +1",
        ring1="Begrudging Ring",
        ring2="Regal Ring",
        waist="K. Kachina Belt +1",
        back=gear.RNG_CRIT_Cape,
    })

    sets.DoubleShot = {
        head=gear.Relic_Head,
        body=gear.Relic_Body,
        hands="Oshosi Gloves +1", -- 5
        legs="Oshosi Trousers +1", --7
        feet="Oshosi Leggings +1", --4
    } --25

    sets.DoubleShot.Critical = {
        head=gear.Relic_Head,
        body=gear.Relic_Body,
        hands="Oshosi Gloves +1", -- 5
        legs="Oshosi Trousers +1", --7
        feet="Oshosi Leggings +1", --4
        neck="Scout's Gorget +2",
        ear1="Odr Earring",
        ear2="Amini Earring +1",
        ring1="Begrudging Ring",
        ring2="Mummu Ring",
        waist="K. Kachina Belt +1",
        back=gear.RNG_CRIT_Cape,
    }

    sets.TrueShot = {
        body="Nisroch Jerkin",
        legs=gear.Empyrean_Legs,
        waist="Tellen Belt",
    }


    sets.engaged = {
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Malignance_Feet,
        neck="Iskur Gorget",
        ear1="Sherida Earring",
        ear2="Dedition Earring",
        ring1="Hetairoi Ring",
        ring2="Epona's Ring",
        back=gear.RNG_TP_Cape,
        waist="Windbuffet Belt +1",
    }

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Malignance_Feet,
        neck="Iskur Gorget",
        ear1="Suppanomimi", --5
        ear2="Eabani Earring", --4
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.RNG_DW_Cape, --10
        waist="Sailfi Belt +1",
    }

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = sets.engaged.DW

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = sets.engaged.DW.LowHaste

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste =  sets.engaged.DW.MidHaste

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = {
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Malignance_Feet,
        neck="Iskur Gorget",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.RNG_DW_Cape, --10
        waist="Sailfi Belt +1",
    } -- 10%

    sets.engaged.Hybrid = {
        ring2="Defending Ring", --10/10
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)

    sets.precast.WS = {
        head=gear.Nyame_Head, --10
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands, --7d
        legs=gear.Nyame_Legs, --10
        feet=gear.Nyame_Feet, --8
        neck="Scout's Gorget +2",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring", --5
        ring2="Cornelia's Ring",
        back=gear.RNG_LS_Cape, --10
        waist="Fotia Belt",
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        feet=gear.Relic_Feet,
        ear1="Beyla Earring",
        waist="K. Kachina Belt +1",
    })

    sets.precast.WS.Enmity = set_combine(sets.precast.WS, {
        hands=gear.Relic_Hands,
        feet=gear.Relic_Feet,
        neck="Yngvi Choker",
        ear1="Beyla Earring",
    })

    sets.precast.WS["Last Stand"] = {
        head=gear.Artifact_Head, --10
        body=gear.Empyrean_Body,
        hands=gear.Nyame_Hands, --7
        legs=gear.Nyame_Legs, --10
        feet=gear.Empyrean_Feet, --8
        neck="Scout's Gorget +2",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1="Dingir Ring", --5
        ring2="Cornelia's Ring",
        back=gear.RNG_LS_Cape, --10
        waist="Fotia Belt",
    }

    sets.precast.WS['Last Stand'].Acc = set_combine(sets.precast.WS['Last Stand'], {
        ammo=gear.ACCbullet,
        feet=gear.Artifact_Feet,
        ear2="Beyla Earring",
        waist="K. Kachina Belt +1",
    })

    sets.precast.WS['Last Stand'].Enmity = set_combine(sets.precast.WS['Last Stand'], {
        hands=gear.Relic_Hands,
        feet=gear.Relic_Feet,
        ear1="Beyla Earring",
    })

    sets.precast.WS['Apex Arrow'] = sets.precast.WS

    sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {
        feet=gear.Artifact_Feet,
        ear1="Beyla Earring",
        waist="K. Kachina Belt +1",
    })

    sets.precast.WS['Apex Arrow'].Enmity = set_combine(sets.precast.WS['Apex Arrow'], {
        hands=gear.Relic_Hands,
        feet=gear.Relic_Feet,
        ear1="Beyla Earring",
    })

    sets.precast.WS['Jishnu\'s Radiance'] ={
        head=gear.Artifact_Head,
        neck="Fotia Gorget",
        ear1="Odr Earring",
        ear2="Amini Earring +1",
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        ring1="Begrudging Ring",
        ring2="Regal Ring",
        back=gear.RNG_CRIT_Cape,
        waist="Fotia Belt",
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
    }

    sets.precast.WS['Jishnu\'s Radiance'].PDL ={
        head="Blistering Sallet +1",
        neck="Scout's Gorget +2",
        ear1="Odr Earring",
        ear2="Amini Earring +1",
        body=gear.Empyrean_Body,
        hands=gear.Ikenga_Hands,
        ring1="Begrudging Ring",
        ring2="Regal Ring",
        back=gear.RNG_CRIT_Cape,
        waist="Fotia Belt",
        legs=gear.Ikenga_Legs,
        feet=gear.Empyrean_Feet,
    }

    sets.precast.WS['Jishnu\'s Radiance'].Acc = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {
        neck="Iskur Gorget",
        ear1="Telos Earring",
        ear2="Beyla Earring",
        ring1="Crepuscular Ring",
        waist="K. Kachina Belt +1",
    })

    sets.precast.WS['Jishnu\'s Radiance'].Enmity = set_combine(sets.precast.WS['Jishnu\'s Radiance'], {
        hands=gear.Relic_Hands,
        feet=gear.Relic_Feet,
        ear1="Beyla Earring",
    })

   
    sets.precast.WS["Coronach"] =  {
        head=gear.Artifact_Head, --10
        neck="Fotia Gorget",
        ear1="Ishvara Earring",
        ear2="Amini Earring +1",
        body=gear.Empyrean_Body,
        hands=gear.Nyame_Hands, --7
        ring1="Epaminondas's Ring", --5
        ring2="Cornelia's Ring",
        back=gear.RNG_LS_Cape, --10
        waist="Fotia Belt",
        legs=gear.Nyame_Legs, --10
        feet=gear.Empyrean_Feet, --8
    }

    sets.precast.WS["Coronach"].PDL =  {
        head=gear.Artifact_Head, --10
        neck="Scout's Gorget +2",
        ear1="Ishvara Earring",
        ear2="Amini Earring +1",
        body=gear.Empyrean_Body,
        hands=gear.Nyame_Hands, --7
        ring1="Cornelia's Ring",
        ring2="Sroda Ring",
        back=gear.RNG_LS_Cape, --10
        waist="Fotia Belt",
        legs=gear.Nyame_Legs, --10
        feet=gear.Empyrean_Feet, --8
    }

    sets.precast.WS["Coronach"].Acc = set_combine(sets.precast.WS['Coronach'], {
        ear1="Telos Earring",
        ear2="Beyla Earring",
    })

    sets.precast.WS["Trueflight"] = {
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Scout's Gorget +2",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1="Dingir Ring",
        ring2="Cornelia's Ring",
        back=gear.RNG_TF_Cape,
        waist="Eschan Stone",
    }

    sets.precast.WS["Wildfire"] = set_combine(sets.precast.WS["Trueflight"], {
        waist="Skrymir Cord +1",
    })

    sets.precast.WS["Hot Shot"] = {
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1="Sroda Ring",
        ring2="Cornelia's Ring",
        back=gear.RNG_TF_Cape,
        waist="Skrymir Cord +1",
    }

    sets.precast.WS['Savage Blade'] = {
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Republican Platinum Medal",
        ear1="Sherida Earring",       
        ear2="Moonshade Earring",
        ring1="Cornelia's Ring",
        ring2="Regal Ring",
        back=gear.RNG_SB_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Savage Blade'].PDL = {
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Scout's Gorget +2",
        ear1="Moonshade Earring",
        ear2="Amini Earring +1",       
        ring1="Sroda Ring",
        ring2="Cornelia's Ring",
        back=gear.RNG_SB_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Aeolian Edge'] = {
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Sibyl Scarf",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1="Dingir Ring",
        ring2="Epaminondas's Ring",
        back=gear.RNG_TF_Cape,
        waist="Orpheus's Sash",
    }

    sets.resting = {}

    sets.idle = {
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Malignance_Feet,
        neck="Warder's Charm +1",
        ear1="Arete Del Luna +1",
        ear2="Eabani Earring",
        ring1="Defending Ring",
        ring2="Shadow Ring",
        back="Shadow Mantle",
        waist="Carrier's Sash",
    }

    sets.idle.DT = set_combine(sets.idle, {
        head=gear.Malignance_Head, --6/6
        body=gear.Malignance_Body, --9/9
        hands=gear.Empyrean_Hands, --11/11
        legs=gear.Empyrean_Legs, --13/13
        feet=gear.Malignance_Feet, --4/4
        neck="Warder's Charm +1",
        ring2="Defending Ring", --10/10
    })

    -- sets.idle.Town = set_combine(sets.precast.WS["Trueflight"], {
    --     waist="Orpheus's Sash",
    -- })
    
    sets.idle.Town = sets.idle

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Jute Boots +1"}

    sets.buff.Barrage = {
        head=gear.Ikenga_Head,
        neck="Scout's Gorget +2",
        ear1="Crepuscular Earring",
        ear2="Telos Earring",
        body=gear.Ikenga_Body,
        ring1="Sroda Ring",
        ring2="Regal Ring",
        hands=gear.Artifact_Hands,
        legs=gear.Ikenga_Legs,
        feet=gear.Ikenga_Feet,
        back=gear.RNG_TP_Cape,
    }

    sets.buff['Velocity Shot'] = set_combine(sets.midcast.RA, {
        body=gear.Empyrean_Body, 
        back=gear.RNG_TP_Cape
    })
    
    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Purity Ring", --20
        waist="Gishdubar Sash", --10
    }

    sets.FullTP = { ear1="Crematio Earring" }
    sets.Savage = {main="Naegling", sub="Gleti's Knife", ranged="Sparrowhawk +2", ammo="Hauksbok Arrow"}
    sets.Aoe = {main="Tauret", sub=gear.Malevolence_A, ranged="Sparrowhawk +2", ammo="Hauksbok Arrow"}
    sets.Annihilator = {main="Perun +1", sub="Gleti's Knife", ranged="Annihilator", ammo="Chrono Bullet"}
    sets.Fomalhaut = {main="Perun +1", sub="Gleti's Knife", ranged="Fomalhaut", ammo="Chrono Bullet"}
    sets.Fomalhaut_HS = {main=gear.Malevolence_B, sub=gear.Malevolence_A, ranged="Fomalhaut", ammo="Chrono Bullet"}
    sets.Armageddon = {main="Perun +1", sub="Gleti's Knife", ranged="Armageddon", ammo="Chrono Bullet"}
    sets.Gastraphetes = {main=gear.Malevolence_B, sub=gear.Malevolence_A, ranged="Gastraphetes", ammo="Quelling Bolt"}
    sets.DefaultShield = {sub="Nusku Shield"}

end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        state.CombatWeapon:set(player.equipment.range)
    end
    -- Check that proper ammo is available if we're using ranged attacks or similar.
    if spell.action_type == 'Ranged Attack' or (spell.type == 'WeaponSkill' and (spell.skill == 'Marksmanship' or spell.skill == 'Archery')) then
        check_ammo(spell, action, spellMap, eventArgs)
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
    if spell.action_type == 'Ranged Attack' then
        special_ammo_check()
        if spell.action_type == 'Ranged Attack' then
            if player.equipment.ranged == "Gastraphetes" then
                if flurry == 2 then
                    equip(sets.precast.RA.Gastra.Flurry2)
                elseif flurry == 1 then
                    equip(sets.precast.RA.Gastra.Flurry1)
                else
                    equip(sets.precast.RA.Gastra)
                end
            else
                if flurry == 2 then
                    equip(sets.precast.RA.Flurry2)
                elseif flurry == 1 then
                    equip(sets.precast.RA.Flurry1)
                else
                    equip(sets.precast.RA)
                end
            end
            if player.equipment.main == "Perun +1" then
                equip({waist="Yemaya Belt"})
            end
        end
    elseif spell.type == 'WeaponSkill' then
        if (spell.english == 'Trueflight' or spell.english == 'Aeolian Edge') and player.tp > 2900 then
            equip(sets.FullTP)
        end
        if (spell.skill == 'Archery') then
            special_ammo_check()
        end
        -- Equip obi if weather/day matches for WS.
        if elemental_ws:contains(spell.name) or hybrid_ws:contains(spell.name) then
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
    elseif (spell.english == 'Shadowbind' or spell.english == 'Bounty Shot' or spell.english == 'Eagle Eye Shot') then
        special_ammo_check()
    end
    
    
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if buffactive['Double Shot'] then
            equip(sets.DoubleShot)
            if buffactive['Aftermath: Lv.3'] and player.equipment.ranged == "Armageddon" then
                equip(sets.DoubleShotCritical)
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
        if state.Buff.Barrage then
            equip(sets.buff.Barrage)
        end
    end
end


function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english == "Shadowbind" then
        send_command('@timers c "Shadowbind ['..spell.target.name..']" 42 down abilities/00122.png')
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

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
-- If we gain or lose any flurry buffs, adjust gear.
    if S{'flurry'}:contains(buff:lower()) then
        if not gain then
            flurry = nil
            add_to_chat(122, "Flurry status cleared.")
        end
        if not midaction() then
            handle_equipping_gear(player.status)
        end
    end

    if buff == "Camouflage" then
        if gain then
            equip(sets.buff.Camouflage)
            disable('body')
        else
            enable('body')
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

function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub','range')
    else
        enable('main','sub','range')
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
    check_weaponset()

    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end

    return meleeSet
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if (spell.skill == 'Marksmanship' or spell.skill == 'Archery') then
        if state.RangedMode.value == 'Acc' then
            wsmode = 'Acc'
        end
        if state.RangedMode.value == 'PDL' then
            wsmode = 'PDL'
        end
    elseif (spell.skill ~= 'Marksmanship' and spell.skill ~= 'Archery') then
        if state.OffenseMode.value == 'Acc' then
            wsmode = 'Acc'
        end
        if state.RangedMode.value == 'PDL' then
            wsmode = 'PDL'
        end
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
                    add_to_chat(122, 'Flurry Status: Flurry I')
                    flurry = 1
                elseif param == 846 then
                    add_to_chat(122, 'Flurry Status: Flurry II')
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

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'forceequip' then
        handle_forceequip(cmdParams)
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
end

-- Check for proper ammo when shooting or weaponskilling
function check_ammo(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' then
        if player.equipment.ammo == 'empty' or player.equipment.ammo ~= DefaultAmmo[player.equipment.range] then
            if DefaultAmmo[player.equipment.range] then
                if player.inventory[DefaultAmmo[player.equipment.range]] or player.wardrobe[DefaultAmmo[player.equipment.range]] then
                    add_to_chat(3,"Using Default Ammo")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                else
                    add_to_chat(3,"Default ammo unavailable. Using equipped ammo.")
                end
            else
                add_to_chat(3,"Unable to determine default ammo for current weapon. Using equipped ammo.")
            end
        end
    elseif spell.type == 'WeaponSkill' then
        -- magical weaponskills
        if elemental_ws:contains(spell.english) then
            if player.inventory[MagicAmmo[player.equipment.range]] or player.wardrobe[MagicAmmo[player.equipment.range]] then
                equip({ammo=MagicAmmo[player.equipment.range]})
            else
                add_to_chat(3,"Magic ammo unavailable. Using default ammo.")
                equip({ammo=DefaultAmmo[player.equipment.range]})
            end
        --physical + hybrid weaponskills
        else
            if state.RangedMode.value == 'Acc' then
                if player.inventory[AccAmmo[player.equipment.range]] or player.wardrobe[AccAmmo[player.equipment.range]] then
                    equip({ammo=AccAmmo[player.equipment.range]})
                else
                    add_to_chat(3,"Acc ammo unavailable. Using default ammo.")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                end
            else
                if player.inventory[WSAmmo[player.equipment.range]] or player.wardrobe[AccAmmo[player.equipment.range]] then
                    equip({ammo=WSAmmo[player.equipment.range]})
                else
                    add_to_chat(3,"WS ammo unavailable. Using default ammo.")
                    equip({ammo=DefaultAmmo[player.equipment.range]})
                end
            end
        end
    end

    ammoCount = 0
    if player.inventory[player.equipment.ammo] ~= nil then 
        ammoCount = ammoCount + player.inventory[player.equipment.ammo].count
    end

    if player.wardrobe[player.equipment.ammo] ~= nil then 
        ammoCount = ammoCount + player.wardrobe[player.equipment.ammo].count
    end

    if player.equipment.ammo ~= 'empty' and ammoCount < 15 then
        add_to_chat(39,"*** Ammo '"..player.equipment.ammo.."' running low! *** ("..ammoCount..")")
    end
end

function update_offense_mode()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        state.CombatForm:set('DW')
    else
        state.CombatForm:reset()
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


------- AUTO AMMO ------

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