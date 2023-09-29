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

-- Initialization function for this job file.
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include("Mote-Include.lua")
end

function user_setup()
    include('Global-Binds.lua')

    --[[
        F9 - Cycle Offense Mode (the offensive half of all 'hybrid' melee modes).
        
        These are for when you are fighting with or without Pet
        When you are IDLE and Pet is ENGAGED that is handled by the Idle Sets
    ]]
    state.OffenseMode:options("MasterPet", "Master", "Trusts")

    --[[
        Ctrl-F9 - Cycle Hybrid Mode (the defensive half of all 'hybrid' melee modes).
        
        Used when you are Engaged with Pet
        Used when you are Idle and Pet is Engaged
    ]]
    state.HybridMode:options("Normal", "DT", "TP", "Regen")

    --[[
        Alt-F12 - Turns off any emergency mode
        
        Ctrl-F10 - Cycle type of Physical Defense Mode in use.
        F10 - Activate emergency Physical Defense Mode. Replaces Magical Defense Mode, if that was active.
    ]]
    state.PhysicalDefenseMode:options("PetDT", "MasterDT")

    --[[
        Alt-F12 - Turns off any emergency mode

        F11 - Activate emergency Magical Defense Mode. Replaces Physical Defense Mode, if that was active.
    ]]
    state.MagicalDefenseMode:options("PetMDT")

    --[[ IDLE Mode Notes:

        F12 - Update currently equipped gear, and report current status.
        Ctrl-F12 - Cycle Idle Mode.
        
        Will automatically set IdleMode to Idle when Pet becomes Engaged and you are Idle
    ]]
    state.IdleMode:options("Idle", "MasterDT")

    --Various Cycles for the different types of PetModes
    state.PetStyleCycleTank = M {"NORMAL", "DD", "MAGIC", "SPAM"}
    state.PetStyleCycleMage = M {"NORMAL", "HEAL", "SUPPORT", "MB", "DD"}
    state.PetStyleCycleDD = M {"NORMAL", "BONE", "SPAM", "OD", "ODACC"}

    --The actual Pet Mode and Pet Style cycles
    --Default Mode is Tank
    state.PetModeCycle = M {"TANK", "DD", "MAGE"}
    --Default Pet Cycle is Tank
    state.PetStyleCycle = state.PetStyleCycleTank

    --Toggles
    --[[
        Alt + E will turn on or off Auto Maneuver
    ]]
    state.AutoMan = M(false, "Auto Maneuver")

    --[[
        //gs c toggle autodeploy
    ]]
    state.AutoDeploy = M(false, "Auto Deploy")

    --[[
        Alt + D will turn on or off Lock Pet DT
        (Note this will block all gearswapping when active)
    ]]
    state.LockPetDT = M(false, "Lock Pet DT")

    --[[
        Alt + (tilda) will turn on or off the Lock Weapon
    ]]
    state.LockWeapon = M(false, "Lock Weapon")

    --[[
        //gs c toggle setftp
    ]]
    state.SetFTP = M(false, "Set FTP")

   --[[
        This will hide the entire HUB
        //gs c hub all
    ]]
    state.textHideHUB = M(false, "Hide HUB")

    --[[
        This will hide the Mode on the HUB
        //gs c hub mode
    ]]
    state.textHideMode = M(false, "Hide Mode")

    --[[
        This will hide the State on the HUB
        //gs c hub state
    ]]
    state.textHideState = M(false, "Hide State")

    --[[
        This will hide the Options on the HUB
        //gs c hub options
    ]]
    state.textHideOptions = M(false, "Hide Options")

    --[[
        This will toggle the HUB lite mode
        //gs c hub lite
    ]]  
    state.useLightMode = M(false, "Toggles Lite mode")

    --[[
        This will toggle the default Keybinds set up for any changeable command on the window
        //gs c hub keybinds
    ]]
    state.Keybinds = M(false, "Hide Keybinds")

    --[[
        Enter the slots you would lock based on a custom set up.
        Can be used in situation like Salvage where you don't want
        certain pieces to change.

        //gs c toggle customgearlock
        ]]
    state.CustomGearLock = M(false, "Custom Gear Lock")
    --Example customGearLock = T{"head", "waist"}
    customGearLock = T{}

    send_command("bind !f7 gs c cycle PetModeCycle")
    send_command("bind ^f7 gs c cycleback PetModeCycle")
    send_command("bind !f8 gs c cycle PetStyleCycle")
    send_command("bind ^f8 gs c cycleback PetStyleCycle")
    send_command("bind !e gs c toggle AutoMan")
    send_command("bind !d gs c toggle LockPetDT")
    send_command("bind !f6 gs c predict")
    send_command("bind ^` gs c toggle LockWeapon")
    send_command("bind home gs c toggle setftp")
    send_command("bind PAGEUP gs c toggle autodeploy")
    send_command("bind PAGEDOWN gs c hide keybinds")
    send_command("bind = gs c clear")

    -- Adjust the X (horizontal) and Y (vertical) position here to adjust the window
    pos_x = 0
    pos_y = 0
    setupTextWindow(pos_x, pos_y)
end

function file_unload()
    send_command("unbind !f7")
    send_command("unbind ^f7")
    send_command("unbind !f8")
    send_command("unbind ^f8")
    send_command("unbind !e")
    send_command("unbind !d")
    send_command("unbind !f6")
    send_command("unbind ^`")
    send_command("unbind home")
    send_command("unbind PAGEUP")
    send_command("unbind PAGEDOWN")       
    send_command("unbind end")
    send_command("unbind =")
end

function job_setup()
    include("PUP-LIB.lua")
end

function init_gear_sets()
    gear.Animator_P2 = "Animator P II"
    gear.Animator_P1 = "Animator P +1"

    gear.Artifact_Head = { name="Foire Taj +1" }
    gear.Artifact_Body = { name="Foire Tobe +1" }
    gear.Artifact_Hands = { name="Foire Dastanas +1" }
    gear.Artifact_Legs = { name="Foire Churidars +1" }    
    gear.Artifact_Feet = { name="Foire Babouches +1" }

    gear.Relic_Head = { name="Pitre Taj +3" }
    gear.Relic_Body = { name="Pitre Tobe +3" }
    gear.Relic_Hands = { name="Pitre Dastanas +3" }
    gear.Relic_Legs = { name="Pitre Churidars +3" }
    gear.Relic_Feet = { name="Pitre Babouches +3" }

    gear.Empyrean_Head = { name="Karagoz Cappello +2" }
    gear.Empyrean_Body = { name="Karagoz Farsetto +2" }
    gear.Empyrean_Hands = { name="Karagoz Guanti +2" }
    gear.Empyrean_Legs = { name="Karagoz Pantaloni +2" }
    gear.Empyrean_Feet = { name="Karagoz Scarpe +2" }

    gear.Taeon_PUP_Head = { name="Taeon Chapeau", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    gear.Taeon_PUP_Body = { name="Taeon Tabard", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    gear.Taeon_PUP_Hands = { name="Taeon Gloves", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    gear.Taeon_PUP_Legs = { name="Taeon Tights", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    gear.Taeon_PUP_Feet = { name="Taeon Boots", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}

    gear.PUP_Cape = { name="Visucius's Mantle" }
    gear.PUP_WS_Cape = { name = "Visucius's Mantle" }


    --------------------------------------------------------------------------------
    --  __  __           _               ____        _          _____      _
    -- |  \/  |         | |             / __ \      | |        / ____|    | |
    -- | \  / | __ _ ___| |_ ___ _ __  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- | |\/| |/ _` / __| __/ _ \ '__| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  | | (_| \__ \ ||  __/ |    | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|  |_|\__,_|___/\__\___|_|     \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                                  __/ |
    --                                                 |___/
    ---------------------------------------------------------------------------------
    --This section is best utilized for Master Sets
    --[[
        Will be activated when Pet is not active, otherwise refer to sets.idle.Pet
    ]]
    sets.idle = {}

    -------------------------------------Fastcast
    sets.precast.FC = {
        head=gear.Herc_FC_head, --13
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

    -------------------------------------Kiting
    sets.Kiting = { ring1="Shneddick Ring" }

    -------------------------------------JA
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        neck = "Magoraga Beads", 
        body = "Passion Jacket"
    })

    sets.precast.JA["Tactical Switch"] = {feet=gear.Empyrean_Feet}
    sets.precast.JA["Ventriloquy"] = {legs=gear.Relic_Legs}
    sets.precast.JA["Role Reversal"] = {feet=gear.Relic_Feet}
    sets.precast.JA["Overdrive"] = {body=gea r.Relic_Body}

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


    -------------------------------------WS
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        range="Neo Animator",
        ammo="Automat. Oil +3",
		head=gear.Nyame_Head,
		body=gear.Nyame_Body,
		hands=gear.Nyame_Body,
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

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Stringing Pummel"] = {
        range="Neo Animator",
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
        range="Neo Animator",
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
        range="Neo Animator",
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
        range="Neo Animator",
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

    -------------------------------------Idle
    --[[
        Pet is not active
        Idle Mode = MasterDT
    ]]
    sets.idle.MasterDT = {
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Warder's Charm +1",
        ear1="Odnowa Earring +1",
        ear2="Eabani Earring",
        ring1="Defending Ring",
        ring2="Purity Ring",
        back=gear.PUP_Cape,
    }

    -------------------------------------Engaged
    --[[
        Offense Mode = Master
        Hybrid Mode = Normal
    ]]
    sets.engaged.Master = {
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Malignance_Head,
        body=gear.Mpaca_Body,
        hands=gear.Malignance_Hands,
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

    -------------------------------------TP
    --[[
        Offense Mode = Master
        Hybrid Mode = TP
    ]]
    sets.engaged.Master.TP = {
        -- Add your set here
     }

    -------------------------------------DT
    --[[
        Offense Mode = Master
        Hybrid Mode = DT
    ]]
    sets.engaged.Master.DT = {
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Malignance_Head,
        body=gear.Mpaca_Body,
        hands=gear.Malignance_Hands,
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

    ----------------------------------------------------------------------------------
    --  __  __         _           ___     _     ___      _
    -- |  \/  |__ _ __| |_ ___ _ _| _ \___| |_  / __| ___| |_ ___
    -- | |\/| / _` (_-<  _/ -_) '_|  _/ -_)  _| \__ \/ -_)  _(_-<
    -- |_|  |_\__,_/__/\__\___|_| |_| \___|\__| |___/\___|\__/__/
    -----------------------------------------------------------------------------------

    --[[
        These sets are designed to be a hybrid of player and pet gear for when you are
        fighting along side your pet. Basically gear used here should benefit both the player
        and the pet.
    ]]
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Normal
    ]]
    sets.engaged.MasterPet = {
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head="Heyoka Cap +1",
        body="Tali'ah Manteel +2",
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

    -------------------------------------TP
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = TP
    ]]
    sets.engaged.MasterPet.TP = {
        -- Add your set here 
     }

    -------------------------------------DT
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = DT
    ]]
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

    -------------------------------------Regen
    --[[
        Offense Mode = MasterPet
        Hybrid Mode = Regen
    ]]
    sets.engaged.MasterPet.Regen = {
       head=gear.Relic_Head,
       neck="Bathy Choker +1",
       ear1="Burana Earring",
       ear2="Infused Earring",
       body="Hiza. Haramaki +2",
       hands=gear.Rao_C_Hands,
       legs=gear.Rao_C_Legs,
       feet=gear.Rao_C_Feet,
       ring1=gear.Chirich_1,
       ring2=gear.Chirich_2,
       waist="Isa Belt",
       back=gear.PUP_Cape,
    }

    ----------------------------------------------------------------
    --  _____     _      ____        _          _____      _
    -- |  __ \   | |    / __ \      | |        / ____|    | |
    -- | |__) |__| |_  | |  | |_ __ | |_   _  | (___   ___| |_ ___
    -- |  ___/ _ \ __| | |  | | '_ \| | | | |  \___ \ / _ \ __/ __|
    -- | |  |  __/ |_  | |__| | | | | | |_| |  ____) |  __/ |_\__ \
    -- |_|   \___|\__|  \____/|_| |_|_|\__, | |_____/ \___|\__|___/
    --                                  __/ |
    --                                 |___/
    ----------------------------------------------------------------

    -------------------------------------Magic Midcast
    sets.midcast.Pet = {
       main="Xiocoatl",
       range=gear.Animator_P2,
       head=gear.Herc_PET_Head,
       body="Udug Jacket",
       hands=gear.Herc_PET_Hands,
       legs=gear.Relic_Legs,
       feet=gear.Relic_Feet,
       neck="Puppetmaster's Collar +2",
       ear1="Burana Earring",
       ear2="Enmerker Earring",
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

    -------------------------------------Idle
    --[[
        This set will become default Idle Set when the Pet is Active 
        and sets.idle will be ignored
        Player = Idle and not fighting
        Pet = Idle and not fighting

        Idle Mode = Idle
    ]]
    sets.idle.Pet = {
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Mpaca_Feet,
        neck="Warder's Charm +1",
        ear1="Odnowa Earring +1",
        ear2="Karagoz Earring +1",
        ring1="Defending Ring",
        ring2="Purity Ring",
        back=gear.PUP_Cape,
    }

    --[[
        If pet is active and you are idle and pet is idle
        Player = idle and not fighting
        Pet = idle and not fighting
        Idle Mode = MasterDT
    ]]
    sets.idle.Pet.MasterDT = {
        range=gear.Animator_P1,
        ammo="Automat. Oil +3",
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Mpaca_Feet,
        neck="Warder's Charm +1",
        ear1="Odnowa Earring +1",
        ear2="Karagoz Earring +1",
        ring1="Defending Ring",
        ring2="Purity Ring",
        back=gear.PUP_Cape,
    }

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

    --[[
        Activated by Alt+D or
        F10 if Physical Defense Mode = PetDT
    ]]
    sets.pet.EmergencyDT = {
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

    -------------------------------------Engaged for Pet Only
    --[[
      For Technical Users - This is layout of below
      sets.idle[idleScope][state.IdleMode][ Pet[Engaged] ][CustomIdleGroups] 

      For Non-Technical Users:
      If you the player is not fighting and your pet is fighting the first set that will activate is sets.idle.Pet.Engaged
      You can further adjust this by changing the HyrbidMode using Ctrl+F9 to activate the Acc/TP/DT/Regen sets
    ]]
    --[[
        Idle Mode = Idle
        Hybrid Mode = Normal
    ]]
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

    --[[
        Idle Mode = Idle
        Hybrid Mode = TP
    ]]
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

    --[[
        Idle Mode = Idle
        Hybrid Mode = DT
    ]]
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

    --[[
        Idle Mode = Idle
        Hybrid Mode = Regen
    ]]
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

    -------------------------------------WS
    --[[
        WSNoFTP is the default weaponskill set used
    ]]
    sets.midcast.Pet.WSNoFTP = {
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
        ear2="Enmerker Earring",
        ring1=gear.Varar_1,
        ring2="Overbearing Ring",
        back=gear.PUP_Cape,
    }

    --[[
        If we have a pet weaponskill that can benefit from WSFTP
        then this set will be equipped
    ]]
    sets.midcast.Pet.WSFTP = {
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
        ear2="Enmerker Earring",
        ring1=gear.Varar_1,
        ring2="Overbearing Ring",
        back=gear.PUP_Cape,
    }

    --[[
        Base Weapon Skill Set
        Used by default if no modifier is found
    ]]
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
        back=gear.PUP_Cape,
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
        ear2="Enmerker Earring",
        ring1=gear.Varar_1,
        ring2="Overbearing Ring",
        back=gear.PUP_Cape,
    }

    ---------------------------------------------
    --  __  __ _             _____      _
    -- |  \/  (_)           / ____|    | |
    -- | \  / |_ ___  ___  | (___   ___| |_ ___
    -- | |\/| | / __|/ __|  \___ \ / _ \ __/ __|
    -- | |  | | \__ \ (__   ____) |  __/ |_\__ \
    -- |_|  |_|_|___/\___| |_____/ \___|\__|___/
    ---------------------------------------------
    -- Town Set
    sets.idle.Town = sets.idle.Pet.MasterDT
    sets.defense.MasterDT = sets.idle.MasterDT
    sets.defense.PetDT = sets.pet.EmergencyDT
    sets.defense.PetMDT = set_combine(sets.pet.EmergencyDT, {})
end
