----------------------------------------------------------------------------------------
--  __  __           _                     __   _____                        _
-- |  \/  |         | |                   / _| |  __ \                      | |
-- | \  / | __ _ ___| |_ ___ _ __    ___ | |_  | |__) |   _ _ __  _ __   ___| |_ ___
-- | |\/| |/ _` / __| __/ _ \ '__|  / _ \|  _| |  ___/ | | | '_ \| '_ \ / _ \ __/ __|
-- | |  | | (_| \__ \ ||  __/ |    | (_) | |   | |   | |_| | |_) | |_) |  __/ |_\__ \
-- |_|  |_|\__,_|___/\__\___|_|     \___/|_|   |_|    \__,_| .__/| .__/ \___|\__|___/
--                                                         | |   | |
--                                                         |_|   |_|
-----------------------------------------------------------------------------------------
--[[
    Originally Created By: Faloun
    Programmers: Arrchie, Kuroganashi, Byrne, Tuna
    Testers:Arrchie, Kuroganashi, Haxetc, Patb, Whirlin, Petsmart
    Contributors: Xilkk, Byrne, Blackhalo714
    ASCII Art Generator: http://www.network-science.de/ascii/
]]

function get_sets()
    mote_include_version = 2
    include("Mote-Include.lua")
end

function job_setup()
    include("PUP-LIB.lua")
    custom_weapon_list = S{"Godhands"}
end

function user_setup()
    include('Global-Binds.lua')

    state.WeaponLock = M(false, 'Weapon Lock')
    state.WeaponSet = M{['description']='Weapon Set', 'Xiucoatl', 'Verethragna', 'Godhands'}

    -- These are for when you are fighting with or without Pet
    -- When you are IDLE and Pet is ENGAGED that is handled by the Idle Sets
    -- F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
    state.OffenseMode:options("MasterPet", "Master", "Trusts")

    -- Used when you are Engaged with Pet
    -- Used when you are Idle and Pet is Engaged
    -- Ctrl-F9 - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
    state.HybridMode:options("Normal", "DT", "TP", "Regen", "Ranged")

    -- Ctrl-F10 - Cycle type of Physical Defense Mode in use.
    -- F10 - Activate emergency Physical Defense Mode.
    state.PhysicalDefenseMode:options("PetDT", "MasterDT")

    -- F11 - Activate emergency Magical Defense Mode.
    state.MagicalDefenseMode:options("PetMDT")

    -- Ctrl-F12 - Cycle Idle Mode.
    -- Will automatically set IdleMode to Idle when Pet becomes Engaged and you are Idle
    state.IdleMode:options("Idle", "MasterDT")

    --Various Cycles for the different types of PetModes
    state.PetStyleCycleTank = M {"NORMAL", "DD", "MAGIC", "SPAM"}
    state.PetStyleCycleMage = M {"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
    state.PetStyleCycleDD = M {"NORMAL", "BONE", "SPAM", "OD", "ODACC"}

    --The actual Pet Mode and Pet Style cycles
    --Default Mode is DD
    state.PetModeCycle = M {"DD", "TANK", "MAGE"}
    --Default Pet Cycle is DD
    state.PetStyleCycle = state.PetStyleCycleDD

    -- ALT + E
    state.AutoMan = M(false, "Auto Maneuver")

    -- //gs c toggle autodeploy
    state.AutoDeploy = M(false, "Auto Deploy")

    -- ALT + D (Note this will block all gearswapping when active)
    state.LockPetDT = M(false, "Lock Pet DT")

    --  //gs c toggle setftp
    state.SetFTP = M(false, "Set FTP")

    --  //gs c hub all (Hide HUB)
    state.textHideHUB = M(false, "Hide HUB") 

    --  //gs c hub mode (This will hide the Mode on the HUB)
    state.textHideMode = M(false, "Hide Mode")

    -- //gs c hub state (This will hide the State on the HUB)
    state.textHideState = M(false, "Hide State")

    -- //gs c hub options (This will hide the Options on the HUB)
    state.textHideOptions = M(false, "Hide Options")

    -- //gs c hub lite (This will toggle the HUB lite mode)
    state.useLightMode = M(false, "Toggles Lite mode")

    -- //gs c hub keybinds (toggle the default Keybinds set up for any changeable command on the window)
    state.Keybinds = M(true, "Hide Keybinds")

    send_command('bind !F1 input /ja "Overdrive" <me>')
    send_command('bind !F2 input /ja "Heady Artifice" <me>')

    if player.sub_job == 'WAR' then
        send_command('bind !t input /ja "Provoke" <t>')
    end

    send_command('bind ^numpad7 gs c set WeaponSet Xiucoatl;input /macro set 1')
    send_command('bind ^numpad8 gs c set WeaponSet Verethragna;input /macro set 1')
    send_command('bind ^numpad9 gs c set WeaponSet Godhands;input /macro set 1')

    send_command("bind !f7 gs c cycle PetModeCycle")
    send_command("bind ^f7 gs c cycleback PetModeCycle")
    send_command("bind !f8 gs c cycle PetStyleCycle")
    send_command("bind ^f8 gs c cycleback PetStyleCycle")
    send_command("bind !e gs c toggle AutoMan")
    send_command("bind !d gs c toggle LockPetDT")
    send_command("bind !f6 gs c predict")
    send_command('bind @w gs c toggle WeaponLock')
    send_command("bind home gs c toggle setftp")
    send_command("bind PAGEUP gs c toggle autodeploy")
    send_command("bind PAGEDOWN gs c hide keybinds")
    send_command("bind = gs c clear")

    -- Adjust the X (horizontal) and Y (vertical) position here to adjust the window
    pos_x = 2250
    pos_y = 590
    setupTextWindow(pos_x, pos_y)

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
    get_combat_weapon()

    set_macro_page(1, 18)
    send_command('wait 3; input /lockstyleset 18')
end

function file_unload()
    send_command('unbind !F1')
    send_command('unbind !F2')
    send_command('unbind !t')
    send_command("unbind !f7")
    send_command("unbind ^f7")
    send_command("unbind !f8")
    send_command("unbind ^f8")
    send_command("unbind !e")
    send_command("unbind !d")
    send_command("unbind !f6")
    send_command("unbind @w")
    send_command("unbind home")
    send_command("unbind PAGEUP")
    send_command("unbind PAGEDOWN")       
    send_command("unbind end")
    send_command("unbind =")
end



function init_gear_sets()
    gear.Animator_P2 = "Animator P II +1"
    gear.Animator_P1 = "Animator P +1"
    gear.Animator_Neo = "Neo Animator"

    gear.Artifact_Head = { name="Foire Taj +2" }
    gear.Artifact_Body = { name="Foire Tobe +2" }
    gear.Artifact_Hands = { name="Foire Dastanas +2" }
    gear.Artifact_Legs = { name="Foire Churidars +2" }    
    gear.Artifact_Feet = { name="Foire Babouches +3" }

    gear.Relic_Head = { name="Pitre Taj +3" }
    gear.Relic_Body = { name="Pitre Tobe +3" }
    gear.Relic_Hands = { name="Pitre Dastanas +3" }
    gear.Relic_Legs = { name="Pitre Churidars +3" }
    gear.Relic_Feet = { name="Pitre Babouches +3" }

    gear.Empyrean_Head = { name="Karagoz Cappello +3" }
    gear.Empyrean_Body = { name="Karagoz Farsetto +3" }
    gear.Empyrean_Hands = { name="Karagoz Guanti +3" }
    gear.Empyrean_Legs = { name="Karagoz Pantaloni +3" }
    gear.Empyrean_Feet = { name="Karagoz Scarpe +2" }

    gear.Taeon_PUP_Head = { name="Taeon Chapeau", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    gear.Taeon_PUP_Body = { name="Taeon Tabard", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    gear.Taeon_PUP_Hands = { name="Taeon Gloves", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    gear.Taeon_PUP_Legs = { name="Taeon Tights", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    gear.Taeon_PUP_Feet = { name="Taeon Boots", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}

    gear.Herc_REPAIR_Head = {}
    gear.Herc_REPAIR_Body = {}
    gear.Herc_REPAIR_Hands = {}
    gear.Herc_PETMA_Head = {}
    gear.Herc_PETMA_Hands = {}
    gear.Herc_PETTP_Head = { name="Herculean Helm", augments={'Pet: Accuracy+26 Pet: Rng. Acc.+26','Pet: "Store TP"+10','Pet: STR+2','Pet: Attack+7 Pet: Rng.Atk.+7',}}
    gear.Herc_PETTP_Hands = { name="Herculean Gloves", augments={'Pet: Accuracy+14 Pet: Rng. Acc.+14','Pet: "Store TP"+11','Pet: STR+10',}}
    gear.Herc_PETTP_Legs = { name="Herculean Trousers", augments={'Pet: Attack+20 Pet: Rng.Atk.+20','Pet: "Store TP"+11',}}
    gear.Herc_PETTP_Feet = { name="Herculean Boots", augments={'Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: "Store TP"+10','Pet: AGI+2','Pet: Attack+8 Pet: Rng.Atk.+8',}}
    gear.Herc_PETVIT_Head = {}
    gear.Herc_PETVIT_Hands = {}
    gear.Herc_PETVIT_Legs = {}
    gear.Herc_PETVIT_Feet = {}

    gear.PUP_Cape = { name="Visucius's Mantle" }
    gear.PUP_WS_Cape = { name = "Visucius's Mantle" }
    gear.PUP_TPBONUS_Cape = { name="Dispersal Mantle" }

    -- Pet NOT Active, Mode NONE
    sets.idle = {
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Nyame_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Sanare Earring",
        ring1=gear.Gerubu_Or_Shadow,
        ring2="Shneddick Ring +1",
        waist="Plat. Mog. Belt",
        back=gear.PUP_Cape,
    }

    -- Pet NOT Active, Mode Master DT
    sets.idle.MasterDT = {
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Nyame_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Sanare Earring",
        ring1=gear.Gerubu_Or_Shadow,
        ring2="Shneddick Ring +1",
        waist="Plat. Mog. Belt",
        back=gear.PUP_Cape,
    }

    -- Pet ACTIVE, Pet + Master BOTH Idle, Mode = None
    sets.idle.Pet = {
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Nyame_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Sanare Earring",
        ring1=gear.Gerubu_Or_Shadow,
        ring2="Shneddick Ring +1",
        waist="Plat. Mog. Belt",
        back=gear.PUP_Cape,
    }

    -- Pet ACTIVE, Pet + Player BOTH Idle, Mode = Master DT
    sets.idle.Pet.MasterDT = {
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Nyame_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Sanare Earring",
        ring1=gear.Gerubu_Or_Shadow,
        ring2="Shneddick Ring +1",
        waist="Plat. Mog. Belt",
        back=gear.PUP_Cape,
    }

    -- Custom Idle sets for PET ENGAGED:
    -- sets.idle[idleScope][state.IdleMode][ Pet[Engaged] ][CustomIdleGroups] 
    -- CTRL + F9 to cycle the CUSTOM IDLE MODE

    -- Idle Mode = IDLE, Hybrid = NORMAL
    sets.idle.Pet.Engaged = {
        main="Ohtas",
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Taeon_PUP_Head,
        body=gear.Relic_Body,
        hands=gear.Taeon_PUP_Hands,
        legs=gear.Taeon_PUP_Legs,
        feet=gear.Taeon_PUP_Feet,
        neck="Shulmanu Collar",
        ear1="Enmerkar Earring",
        ear2="Rimeice Earring",
        ring1=gear.Varar_1,
        ring2="C. Palug Ring",
        waist="Incarnation Sash",
        back=gear.PUP_Cape,
    }

    -- Idle Mode = IDLE, Hybrid = TP
    sets.idle.Pet.Engaged.TP = {
        main="Xiucoatl",
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Herc_PETTP_Head,
        body=gear.Relic_Body,
        hands=gear.Herc_PETTP_Hands,
        legs=gear.Herc_PETTP_Legs,
        feet=gear.Herc_PETTP_Feet,
        neck="Shulmanu Collar",
        ear1="Enmerkar Earring",
        ear2="Kyrene's Earring",
        ring1=gear.Varar_1,
        ring2=gear.Varar_2,
        waist="Klouskap Sash +1",
        back=gear.PUP_Cape,
     }

     -- Idle Mode = IDLE, Hybrid = Ranged
     sets.idle.Pet.Engaged.Ranged = {
        main="Xiucoatl",
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Herc_PETTP_Head,
        body=gear.Relic_Body,
        hands=gear.Herc_PETTP_Hands,
        legs=gear.Herc_PETTP_Legs,
        feet=gear.Herc_PETTP_Feet,
        neck="Shulmanu Collar",
        ear1="Enmerkar Earring",
        ear2="Kyrene's Earring",
        ring1=gear.Varar_1,
        ring2=gear.Varar_2,
        waist="Klouskap Sash +1",
        back=gear.PUP_Cape,
     }

     -- Idle Mode = IDLE, Hybrid = DT
    sets.idle.Pet.Engaged.DT = {
        main="Gnafron's Adargas",
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head="Anwig Salade",
        body=gear.Rao_C_Body,
        hands=gear.Rao_C_Hands,
        legs=gear.Rao_C_Legs,
        feet=gear.Rao_C_Feet,
        neck="Shepherd's Chain",
        ear1="Enmerkar Earring",
        ear2="Rimeice Earring",
        ring1=gear.Varar_1,
        ring2="Overbearing Ring",
        back=gear.PUP_Cape,
        waist="Isa Belt",
    }

    -- Idle Mode = IDLE, Hybrid = REGEN
    sets.idle.Pet.Engaged.Regen = {
        main="Gnafron's Adargas",
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head="Anwig Salade",
        body=gear.Rao_C_Body,
        hands=gear.Rao_C_Hands,
        legs=gear.Rao_C_Legs,
        feet=gear.Rao_C_Feet,
        neck="Shepherd's Chain",
        ear1="Enmerkar Earring",
        ear2="Rimeice Earring",
        ring1=gear.Varar_1,
        ring2="Overbearing Ring",
        back=gear.PUP_Cape,
        waist="Isa Belt",
    }


    sets.precast.FC = {
        head=gear.Herc_FC_Head, --13
        body="Zendik Robe", --13
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        feet="Regal Pumps +1",
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring1="Prolix Ring", --2
        ring2="Kishar Ring", --4
    }

    sets.Kiting = { ring1="Shneddick Ring +1" }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        neck = "Magoraga Beads", 
        body = "Passion Jacket"
    })

    sets.precast.JA["Tactical Switch"] = {feet=gear.Empyrean_Feet}
    sets.precast.JA["Ventriloquy"] = {legs=gear.Relic_Legs}
    sets.precast.JA["Role Reversal"] = {feet=gear.Relic_Feet}
    sets.precast.JA["Overdrive"] = {body=gear.Relic_Body}

    -- Repair Cap 50%
    sets.precast.JA["Repair"] = {
        ammo="Automat. Oil +3",
        head=gear.Herc_REPAIR_Head,
        body=gear.Herc_REPAIR_Body,
        hands=gear.Herc_REPAIR_Hands,
        legs=gear.Rao_C_Legs,
        ring2="Overbearing Ring",
        ear1="Guignol Earring", --20
        ear2="Pratik Earring", --10
        feet=gear.Artifact_Feet,
    }

    sets.precast.JA["Maintenance"] = set_combine(sets.precast.JA["Repair"], {})

    sets.precast.JA.Maneuver = {
        main="Midnights",
        range=gear.Animator_P1,
        neck="Buffoon's Collar +1",
        body=gear.Empyrean_Body,
        hands=gear.Artifact_Hands,
        back=gear.PUP_Cape,
        ear1="Burana Earring"
    }

    sets.precast.JA["Activate"] = {back = gear.PUP_Cape}

    sets.precast.JA["Deus Ex Automata"] = sets.precast.JA["Activate"]

    sets.precast.JA["Provoke"] = {
        neck="Unmoving Collar +1",
        body="Passion Jacket",
        hands="Kurys Gloves",
        ear1="Cryptic Earring",
        ear2="Trux Earring",
        ring2="Eihwaz Ring",
    }

    sets.precast.WS = {
        range="Neo Animator",
        ammo="Automat. Oil +3",
		head=gear.Nyame_Head,
		body=gear.Nyame_Body,
		hands=gear.Mpaca_Hands,
		legs=gear.Nyame_Legs,
		feet=gear.Nyame_Feet,
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		ear1="Schere Earring",
		ear2="Moonshade Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.PUP_Cape,
    }

    sets.precast.WS["Stringing Pummel"] = {
		head=gear.Mpaca_Head,
		body=gear.Mpaca_Body,
		hands=gear.Ryuo_A_Hands,
		legs=gear.Mpaca_Legs,
		feet=gear.Ryuo_C_Feet, --TODO: D
		neck="Fotia Gorget",
		waist="Fotia Belt",
		ear1="Schere Earring",
		ear2="Moonshade Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.PUP_Cape,
    }

    sets.precast.WS["Victory Smite"] = {
		head=gear.Mpaca_Head,
		body=gear.Mpaca_Body,
		hands=gear.Mpaca_Hands,
		legs=gear.Mpaca_Legs,
		feet=gear.Mpaca_Feet,
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		ear1="Schere Earring",
		ear2="Moonshade Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.PUP_Cape,
    }

    sets.precast.WS["Shijin Spiral"] = {
		head=gear.Mpaca_Head,
		body=gear.Mpaca_Body,
		hands=gear.Mpaca_Hands,
		legs=gear.Nyame_Legs,
		feet=gear.Mpaca_Feet,
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		ear1="Schere Earring",
		ear2="Mache Earring +1",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.PUP_Cape,
    }

    sets.precast.WS["Howling Fist"] = {
		head=gear.Mpaca_Head,
		body=gear.Nyame_Body,
		hands=gear.Nyame_Hands,
		legs=gear.Nyame_Legs,
		feet=gear.Empyrean_Feet,
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		ear1="Schere Earring",
		ear2="Moonshade Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=gear.PUP_Cape,
    }

      -- Offsense Mode = Master, Hybrid = Normal
    sets.engaged.Master = {
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Malignance_Head,
        body=gear.Mpaca_Body,
        hands=gear.Empyrean_Hands,
        legs="Samnuha Tights",
        feet=gear.Malignance_Feet,
        neck="Shulmanu Collar",
        ear1="Schere Earring",
		ear2="Karagoz Earring +1",
        ring1="Gere Ring",
        ring2="Niqmaddu Ring",
        waist="Moonbow Belt +1",
        back=gear.PUP_Cape,
    }

     -- Offsense Mode = Master, Hybrid = Tp
    sets.engaged.Master.TP = {
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Malignance_Head,
        body=gear.Mpaca_Body,
        hands=gear.Empyrean_Hands,
        legs="Samnuha Tights",
        feet=gear.Malignance_Feet,
        neck="Shulmanu Collar",
        ear1="Schere Earring",
		ear2="Karagoz Earring +1",
        ring1="Gere Ring",
        ring2="Niqmaddu Ring",
        waist="Moonbow Belt +1",
        back=gear.PUP_Cape,
     }


    -- Offsense Mode = Master, Hybrid = DT
    sets.engaged.Master.DT = {
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Malignance_Head,
        body=gear.Mpaca_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Shulmanu Collar",
        ear1="Schere Earring",
        ear2="Dedition Earring",
        ring1="Gere Ring",
        ring2="Niqmaddu Ring",
        waist="Moonbow Belt +1",
        back=gear.PUP_Cape,
    }

    -- Offsense Mode = MasterPet, Hybrid = Normal
    sets.engaged.MasterPet = {
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head="Heyoka Cap +1",
        body=gear.Empyrean_Body,
        hands=gear.Mpaca_Hands,
        legs="Heyoka Subligar",
        feet=gear.Malignance_Feet,
        neck="Shulmanu Collar",
        ear1="Schere Earring",
        ear2="Dedition Earring",
        ring1="Gere Ring",
        ring2="Niqmaddu Ring",
        waist="Moonbow Belt +1",
        back=gear.PUP_Cape,
    }

    -- Offsense Mode = MasterPet, Hybrid = TP
    sets.engaged.MasterPet.TP = {
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head="Heyoka Cap +1",
        body=gear.Empyrean_Body,
        hands=gear.Mpaca_Hands,
        legs="Heyoka Subligar",
        feet=gear.Malignance_Feet,
        neck="Shulmanu Collar",
        ear1="Schere Earring",
        ear2="Dedition Earring",
        ring1="Gere Ring",
        ring2="Niqmaddu Ring",
        waist="Moonbow Belt +1",
        back=gear.PUP_Cape,
     }


    -- Offsense Mode = MasterPet, Hybrid = DT
    sets.engaged.MasterPet.DT = {
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head="Heyoka Cap +1",
        body=gear.Malignance_Body,
        hands=gear.Mpaca_Hands,
        legs="Heyoka Subligar",
        feet=gear.Malignance_Feet,
        neck="Shulmanu Collar",
        ear1="Schere Earring",
        ear2="Dedition Earring",
        ring1="Defending Ring",
        ring2="Niqmaddu Ring",
        waist="Moonbow Belt +1",
        back=gear.PUP_Cape,
    }

    -- Offsense Mode = MasterPet, Hybrid = Regen
    sets.engaged.MasterPet.Regen = {
       head=gear.Relic_Head,
       neck="Bathy Choker +1",
       ear1="Burana Earring",
       ear2="Infused Earring",
    --    body="Hiza. Haramaki +2",
       hands=gear.Rao_C_Hands,
       legs=gear.Rao_C_Legs,
       feet=gear.Rao_C_Feet,
       ring1=gear.Chirich_1,
       ring2=gear.Chirich_2,
       waist="Isa Belt",
       back=gear.PUP_Cape,
    }

    sets.midcast.Pet = {
       main="Sakpata's Fists",
       range=gear.Animator_P2,
       ammo="Automat. Oil +3",
       head=gear.Herc_PETMA_Head,
       body="Udug Jacket",
       hands=gear.Herc_PETMA_Hands,
       legs=gear.Relic_Legs,
       feet=gear.Relic_Feet,
       neck="Puppetmaster's Collar +2",
       ear1="Burana Earring",
       ear2="Enmerkar Earring",
       ring1="Tali'ah Ring",
       ring2="C. Palug Ring",
       waist="Ukko Sash",
    }

    sets.midcast.Pet.Cure = sets.midcast.Pet
    sets.midcast.Pet["Healing Magic"] = sets.midcast.Pet
    sets.midcast.Pet["Elemental Magic"] = sets.midcast.Pet
    sets.midcast.Pet["Enfeebling Magic"] = sets.midcast.Pet
    sets.midcast.Pet["Dark Magic"] = sets.midcast.Pet
    sets.midcast.Pet["Divine Magic"] = sets.midcast.Pet
    sets.midcast.Pet["Enhancing Magic"] = sets.midcast.Pet

    --Equipped automatically
    sets.petEnmity = {
       head="Heyoka Cap +1",
       body="Heyoka Harness +1",
       hands="Heyoka Mittens +1",
       legs="Heyoka Subligar +1",
       feet="Heyoka Leggings +1",
       ear1="Domesticator's Earring",
       ear2="Rimeice Earring",
    }

    -- ALT + D or F10 if Physical Defense Mode = PetDT
    sets.petEmergencyDT = {
       main="Gnafron's Adargas",
       range=gear.Animator_P1,
       ammo="Automat. Oil +3",
       head="Anwig Salade",
       body=gear.Rao_C_Body,
       hands=gear.Rao_C_Hands,
       legs=gear.Rao_C_Legs,
       feet=gear.Rao_C_Feet,
       neck="Shepherd's Chain",
       ear1="Enmerkar Earring",
       ear2="Rimeice Earring",
       ring1=gear.Varar_1,
       ring2="Overbearing Ring",
       back=gear.PUP_Cape,
       waist="Isa Belt",
    }

    -- WSNoFTP is the default weaponskill set used
    sets.midcast.Pet.WSNoFTP = {
        main="Xiucoatl",
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Empyrean_Head,
        body=gear.Relic_Body,
        hands=gear.Mpaca_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Mpaca_Feet,
        neck="Shulmanu Collar",
        ear1="Burana Earring",
        ear2="Enmerkar Earring",
        ring1=gear.Varar_1,
        ring2="Overbearing Ring",
        back=gear.PUP_Cape,
    }

    -- Pet weaponskills that can benefit from WSFTP then this set will be equipped
    sets.midcast.Pet.WSFTP = {
        main="Xiucoatl",
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Empyrean_Head,
        body=gear.Relic_Body,
        hands=gear.Mpaca_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Mpaca_Feet,
        neck="Shulmanu Collar",
        ear1="Burana Earring",
        ear2="Enmerkar Earring",
        ring1=gear.Varar_1,
        ring2="Overbearing Ring",
        back=gear.PUP_Cape,
    }

    -- Default PET WS Set
    sets.midcast.Pet.WS = {}

    --Chimera Ripper, String Clipper
    sets.midcast.Pet.WS["STR"] = set_combine(sets.midcast.Pet.WSNoFTP, {

    })

    -- Bone crusher, String Shredder
    sets.midcast.Pet.WS["VIT"] =  {
        main="Xiucoatl",
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Herc_PETVIT_Head,
        body=gear.Relic_Body,
        hands=gear.Herc_PETVIT_Hands,
        legs=gear.Herc_PETVIT_Legs,
        feet=gear.Herc_PETVIT_Feet,
        neck="Shulmanu Collar",
        ear1="Domesticator's Earring",
        ear2="Burana Earring",
        ring1=gear.Varar_1,
        ring2="C. Palug Ring",
        back=gear.PUP_TPBONUS_Cape,
     }

    -- Cannibal Blade
    sets.midcast.Pet.WS["MND"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Armor Piercer, Armor Shatterer
    sets.midcast.Pet.WS["DEX"] = set_combine(sets.midcast.Pet.WSNoFTP, {})

    -- Arcuballista, Daze
    sets.midcast.Pet.WS["DEXFTP"] = {
        main="Xiucoatl",
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Empyrean_Head,
        body=gear.Relic_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet="Naga Kyahan",
        neck="Shulmanu Collar",
        ear1="Burana Earring",
        ear2="Enmerkar Earring",
        ring1=gear.Varar_1,
        ring2="Overbearing Ring",
        back=gear.PUP_Cape,
    }

    sets.defense.MasterDT = sets.idle.MasterDT
    sets.defense.PetDT = sets.petEmergencyDT
    sets.defense.PetMDT = set_combine(sets.petEmergencyDT, {})

    sets.Xiucoatl = { main="Xiucoatl" }
    sets.Verethragna = { main="Verethragna" }
    sets.Godhands = { main="Godhands" }

    sets.idle.Town = {
        main="Xiucoatl",
        range=gear.Animator_Neo,
        ammo="Automat. Oil +3",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Mpaca_Feet,
        neck="Puppetmaster's Collar +2",
        ear1="Schere Earring",
        ear2="Karagoz Earring +1",
        ring1=gear.Gerubu_Or_Shadow,
        ring2="Shneddick Ring +1",
        waist="Moonbow Belt +1",
        back=gear.PUP_Cape,
    }
end
