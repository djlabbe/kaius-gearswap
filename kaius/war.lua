-- Load and initialize the include file.
include('Kaius-Include')
include('gear/Gear')
include('Global-Binds.lua')

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "1"
MacroBook = "1"
MacroSet = "1"

-- Use "gs c food" to use the specified food item 
Food = "Sublime Sushi"

--Uses Items Automatically
AutoItem = false

--Upon Job change will use a random lockstyleset
Random_Lockstyle = false

--Lockstyle sets to randomly equip
Lockstyle_List = {1,2,6,12}

-- This determines if a WS set is augmented with a sash
Elemental_WS = S{'Aeolian Edge', 'Seraph Blade', 'Shining Blade','Red Lotus Blade', 'Burning Blade', 'Sanguine Blade', 'Energy Drain','Energy Steal','Cyclone','Gust Slash'}

-- 'TP','ACC','DT' are standard Default modes.  You may add more and assigne equipsets for them ( Idle.X and OffenseMode.X )
state.OffenseMode:options('TP','PDL','ACC','DT','PDT','MEVA','CRIT','SUB')

--Set default mode (TP,ACC,DT,PDL)
state.OffenseMode:set('TP')

--Weapons options
state.WeaponMode:options('Chango', 'Shining One', 'Helheim', 'Naegling', 'Loxotic', 'Dolichenus', 'Aeolian Edge', 'Unlocked')
state.WeaponMode:set('Chango')

-- Initialize Player
jobsetup (LockStylePallet,MacroBook,MacroSet)

function get_sets()

	-- Weapon setup
	sets.Weapons = {}

	sets.Weapons['Chango'] = {main="Chango", sub="Utu Grip"}
	sets.Weapons['Shining One'] = {main="Shining One", sub="Utu Grip"}
	sets.Weapons['Helheim'] = {main="Helheim",sub="Utu Grip"}
	sets.Weapons['Naegling'] = {main="Naegling",sub="Ikenga's Axe"}
	sets.Weapons['Loxotic'] = {main="Loxotic Mace +1",sub="Ikenga's Axe"}
	sets.Weapons['Dolichenus'] = {main="Dolichenus",sub="Ikenga's Axe"}
	sets.Weapons['Aeolian Edge'] = {"Ternion Dagger +1",sub="Naegling"}

	-- This stops GS from chaning weapons (Abyssea Proc etc)
	sets.Weapons['Unlocked'] ={ }

	-- This is used when you do not have dual wield and is not a two handed weapon
	sets.Weapons.Shield = {sub="Blurred Shield +1"}

	-- Base set for when the player is not engaged or casting.  Other sets build off this set
	sets.Idle = {
		ammo="Staunch Tathlum +1",
		head=gear.Head.Sakpata, 
		body=gear.Body.Sakpata,
		hands=gear.Hands.Sakpata,
		legs=gear.Legs.Sakpata,
		feet=gear.Feet.Sakpata,
		neck="Warder's Charm +1",
		waist="Null Belt",
		ear1="Eabani Earring",
		ear2="Odnowa Earring +1",
		ring1=gear.Ring.Moonlight_1,
		ring2=gear.Ring.ShadowRing,
		back="Null Shawl",
    }
	-- 'TP','PDL','ACC','DT','PDT','MEVA','CRIT','SUB'

	sets.Idle.TP = set_combine(sets.Idle, {})
	sets.Idle.ACC = set_combine(sets.Idle, {})
	sets.Idle.DT = set_combine(sets.Idle, {})
	sets.Idle.PDL = set_combine(sets.Idle, {})
	sets.Idle.PDT = set_combine(sets.Idle, {})
	sets.Idle.CRIT = set_combine(sets.Idle, {})
	sets.Idle.SUB = set_combine(sets.Idle, {})
	sets.Idle.MEVA = set_combine(sets.Idle, {})

	--Used to swap into movement gear when the player is detected movement when not engaged
	 if (item_available("Shneddick Ring +1")) then
        sets.Movement = { ring1="Shneddick Ring +1" }
    else
        sets.Movement = { feet="Hermes' Sandals" }
    end

	-- Set to be used if you get 
	sets.Cursna_Received = {
	    neck="Nicander's Necklace",
	    ring1="Eshmun's Ring",
		ring2="Purity Ring",
		waist="Gishdubar Sash",
	}

	--WAR Double attack
	--28% Job Trait
	--5% Merits

	-- Sets the base equipset for OffenseMode
	sets.OffenseMode = {
		ammo="Coiste Bodhar",
		head=gear.Head.Boii,
		body=gear.Body.Sakpata,
		hands=gear.Hands.Sakpata,
		legs=gear.Legs.Sakpata,
		feet=gear.Feet.Pummelers,
		neck="Warrior's bead necklace +2",
		waist="Sailfi Belt +1",
	    ear1="Schere Earring",
        ear2="Boii Earring +1",
		ring1="Niqmaddu Ring",
		ring2=gear.Ring.Moonlight_2,
		back=gear.Back.WAR_TP,
	}

	sets.OffenseMode.TP = set_combine( sets.OffenseMode, {})
	--This set is used when OffenseMode is ACC and Enaged
	sets.OffenseMode.ACC = set_combine(sets.OffenseMode, {})
	--This set is used when OffenseMode is CRIT and Engaged
	sets.OffenseMode.CRIT = set_combine(sets.OffenseMode, {})

	sets.OffenseMode.DT = set_combine( sets.OffenseMode, {
		head=gear.Head.Sakpata, 
		feet=gear.Feet.Sakpata,
	})

	sets.OffenseMode.PDL = set_combine(sets.OffenseMode, {})

	sets.OffenseMode.MEVA = set_combine(sets.OffenseMode, {
		feet=gear.Feet.Sakpata,
		neck="Warder's Charm +1",
	})

	sets.Subtle_Blow = {
		body="Dagon Breastplate", -- 10 SB II
		feet=gear.Sakpata_Feet, -- 15 SB I
		ear1="Schere Earring", -- 3 SB I
		ear2="Boii Earring +1", -- 8 SB I
		ring1="Niqmaddu Ring", -- 5 SB II
	}

	-- Max SUB set (SUB 50 and SUBII 15) Need auspice (29) to cap
	sets.OffenseMode.SUB = set_combine(sets.OffenseMode.DT, sets.Subtle_Blow, { })

	--These base set are used when an aftermath is active and player is enaged and correct weapon type set (Augments the current OffenseMode)
	--If you don't specify a weapon mode it will use it regardless of Mythic,Empy,Relic,Aeonic

	sets.OffenseMode.AM = {}  -- This is for Relic AM only
	sets.OffenseMode.AM1 = {} -- All AM1 Types
	sets.OffenseMode.AM2 = {} -- All AM2 Types
	sets.OffenseMode.AM3 = {} -- All AM3 Types

	-- This is how you specify a Weapon Mode AM set by Weapon Mode (examples)
	sets.OffenseMode.AM['Bravura'] = {}
	sets.OffenseMode.AM1['Ukonvasara'] = {}
	sets.OffenseMode.AM2['Ukonvasara'] = {}
	sets.OffenseMode.AM3['Ukonvasara'] = {}
	sets.OffenseMode.AM3['Farsha'] = {}
	sets.OffenseMode.AM1['Conqueror'] = {}
	sets.OffenseMode.AM2['Laphria'] = {}

	sets.DualWield = {
		waist="Reiki Yotai",
		ear2="Eabani Earring",
	}

	sets.Precast = set_combine(sets.Idle, {})

	-- For Cure Cast Time reduction
	sets.Precast.Cure = {}

	-- For Enhancing Cast Time reduction
	sets.Precast.Enhancing = {}

	-- Used for Magic Spells
	sets.Precast.FastCast = {
		ammo="Sapience Orb", --2
		head=gear.Head.Sakpata, --8
		body="Sacro Breastplate", --10
		hands="Leyline Gloves", --8
		neck="Orunmila's Torque", -- 5
		ear1="Etiolation Earring", --1
		ear2="Loquacious Earring", -- 3
		ring1="Prolix Ring", -- 2
		ring2="Gelatinous Ring +1",
	} --44%

	-- For instant casts (Like Raises/Reraise)
	sets.Precast.QuickMagic = {}

	sets.Precast.Enmity = {
		ammo="Sapience Orb", -- 2
		head=gear.Head.Souveran_C, --9
		body=gear.Body.Souveran_C, --20
		hands=gear.Hands.Souveran_C, --9
		legs=gear.Legs.Souveran_C, --9
		feet=gear.Feet.Souveran_D, --9
		neck="Moonlight Necklace", --15
		ear1="Cryptic Earring", --4
		ear2={name="Trux Earring", priority=1},
		ring1="Petrov Ring", --4
		ring2="Eihwaz Ring", --5
	} --91

	sets.Precast['Utsusemi: Ichi'] = {}
	sets.Precast['Utsusemi: Ni'] = {}

	-- Ranged Attack
	sets.Precast.RA = {}
    sets.Precast.RA.ACC = {}
	sets.Precast.RA.Flurry = {}
	sets.Precast.RA.Flurry_II = {}

	--Base set for midcast - if not defined will notify and use your idle set for surviability
	sets.Midcast = set_combine(sets.Idle, {})

	--This set is used as base as is overwrote by specific gear changes (Spell Interruption Rate Down)
	sets.Midcast.SIRD = {
	    ammo="Staunch Tathlum +1", --11
		--feet={ name="Odyssean Greaves", augments={'Attack+1','"Fast Cast"+6',}}, --20
		neck="Moonlight Necklace", --15
		ear1="Magnetic Earring", --8
		waist="Audumbla Sash", --10
	}

	-- Enhancing
	sets.Midcast.Enhancing = {}
	sets.Midcast.Enhancing.Others = {}
	
	-- Enfeebling
	sets.Midcast.Enfeebling = {}
	-- Skill Based ('Dispel','Aspir','Aspir II','Aspir III','Drain','Drain II','Drain III','Frazzle','Frazzle II','Stun','Poison','Poison II','Poisonga')
	sets.Midcast.Enfeebling.MACC = {}
	-- Potency Basted ('Paralyze','Paralyze II','Slow','Slow II','Addle','Addle II','Distract','Distract II','Distract III','Frazzle III','Blind','Blind II')
	sets.Midcast.Enfeebling.Potency = {}
	-- Duration Based ('Sleep','Sleep II','Sleepga','Sleepga II','Diaga','Dia','Dia II','Dia III','Bio','Bio II','Bio III','Silence','Gravity','Gravity II','Inundation','Break','Breakaga', 'Bind', 'Bind II')
	sets.Midcast.Enfeebling.Duration = {}

	-- Ranged Attack Gear (Normal Midshot)
    sets.Midcast.RA = {}
    sets.Midcast.RA.ACC = {}
    sets.Midcast.RA.PDL = {}
	sets.Midcast.RA.CRIT = {}
	sets.Midcast.RA.AM3 = {}

	-- Healing
	sets.Midcast.Cure = {}
	sets.Midcast.Curaga = set_combine(sets.Midcast.Cure, {})
	sets.Midcast.Regen = {}

	-- Dancer JA
	sets.Flourish = set_combine(sets.Idle.DT, {})
	sets.Jig = set_combine(sets.Idle.DT, {})
	sets.Step = set_combine(sets.OffenseMode.DT, {})
	sets.Waltz = set_combine(sets.OffenseMode.DT, {})

	-- Specific gear for spells
	sets.Midcast["Stoneskin"] = {
		waist="Siegel Sash",
	}
	sets.Midcast['Utsusemi: Ichi'] = {}
	sets.Midcast['Utsusemi: Ni'] = {}

	-- Job Abilities
	sets.JA = {}
	sets.JA["Mighty Strikes"] = {feet=gear.Feet.Boii}
	sets.JA["Berserk"] = {body=gear.Body.WAR_Artifact, feet=gear.Feet.Agoge}
	sets.JA["Warcry"] = {head=gear.Head.Agoge}
	sets.JA["Defender"] = {}
	sets.JA["Aggressor"] = {body=gear.Body.Agoge, head=gear.Head.Agoge}
	sets.JA["Provoke"] = sets.Precast.Enmity
	sets.JA["Tomahawk"] = {ammo="Throwing Tomahawk",} -- Need to add feet
	sets.JA["Retaliation"] = {}
	sets.JA["Restraint"] = {hands=gear.Hands.Boii}
	sets.JA["Blood Rage"] = {body=gear.Body.Boii}
	sets.JA["Brazen Rush"] = {}

	--Default WS set base
	sets.WS = {
		head=gear.Head.Agoge,
        body=gear.Body.Nyame,
        hands=gear.Hands.Boii,
        legs=gear.Legs.Nyame,
        feet=gear.Feet.Nyame,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",
        ring1=gear.Ring.Cornelia_Or_Regal,
        ring2="Niqmaddu Ring",
        ammo="Knobkierrie",
        back=gear.Back.WAR_WS1,
        waist="Sailfi Belt +1",
	}
	sets.WS.RA = {}

	sets.WS.WSD = {}
	sets.WS.WSD.RA = {}

	sets.WS.MEVA = set_combine(sets.WS, {
		head=gear.Head.Sakpata,
		body=gear.Body.Sakpata,
	})

	-- Modes
	sets.WS.CRIT = {
		ammo="Yetshila +1",
		head=gear.Head.Sakpata,
		body="Hjarrandi Breast.",
		hands=gear.Hands.Sakpata,
		legs=gear.Legs.Sakpata,
		feet=gear.Feet.Sakpata,
		neck="Warrior's Bead Necklace +2",
		waist="Sailfi Belt +1",
		ear1="Schere Earring",
		ear2="Boii Earring +1",
		ring1="Niqmaddu Ring",
		ring2="Begrudging Ring",
		back=gear.Back.WAR_WS1,
	}
	sets.WS.CRIT.RA = {}

	sets.WS.ACC = {}
	sets.WS.ACC.RA = {}

	sets.WS.SUB = set_combine(sets.Subtle_Blow, {

	})

	sets.WS.SUB.RA = {}

	sets.WS.PDL = {}
	sets.WS.PDL.RA = {}

	--These set are used when a weaponskill is used with that level of aftermath with the correct weapon
	--They Augment any built weaponskill set - Same formatting as the OffenseModes
	sets.WS.AM = {}
	sets.WS.AM1 = {}
	sets.WS.AM2 = {}
	sets.WS.AM3 = {}
	sets.WS.AM1['Ukonvasara'] = {}
	sets.WS.AM2['Ukonvasara'] = {}
	sets.WS.AM3['Ukonvasara'] = {}

	sets.WS.AM.RA = {}
	sets.WS.AM1.RA = {}
	sets.WS.AM2.RA = {}
	sets.WS.AM3.RA = {}
	sets.WS.AM1.RA['Ukonvasara'] = {}
	sets.WS.AM2.RA['Ukonvasara'] = {}
	sets.WS.AM3.RA['Ukonvasara'] = {}

	-- Great Axe WS
	sets.WS["Ukko's Fury"] = {
	    ammo="Yetshila +1",
		head=gear.Head.Sakpata,
		body=gear.Body.Sakpata,
		hands=gear.Hands.Sakpata,
		legs=gear.Legs.Sakpata,
		feet=gear.Feet.Sakpata,
		neck="Warrior's Bead Necklace +2",
		ear1="Schere Earring",
		ear2="Boii Earring +1",
		ring1="Niqmaddu Ring",
		ring2=gear.Ring.Ephramad_Or_Regal,
		waist="Sailfi Belt +1",
		back=gear.Back.WAR_WS1,
	}
	sets.WS["Upheaval"] = {
	    ammo="Knobkierrie",
		head=gear.Head.Agoge,
		body=gear.Body.Nyame,
		hands=gear.Hands.Nyame,
		legs=gear.Legs.Nyame,
		feet=gear.Feet.Nyame,
		neck="Warrior's Bead Necklace +2",
		ear1="Moonshade Earring",
		ear2="Thrud Earring",
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		waist="Sailfi Belt +1",
		back=gear.Back.WAR_WS1,
	}
	
	sets.WS["Full Break"] = {
		 ammo="Pemphredo Tathlum",
		head=gear.Head.Nyame,
		body=gear.Body.Nyame,
		hands=gear.Hands.Nyame,
		legs=gear.Legs.Nyame,
		feet=gear.Feet.Nyame,
		neck="Null Loop",
		waist="Null Belt",
		ear1="Moonshade Earring",
        ear2="Boii Earring +1",
		ring1=gear.Ring.Stikini_1,
		ring2="Regal Ring",
		back=gear.Back.WAR_WS1,
	}

	sets.WS["Armor Break"] = sets.WS["Full Break"]


	--Axe WS
	sets.WS["Ragin Axe"] = {}
	sets.WS["Smash Axe"] = {}
	sets.WS["Gale Axe"] = {}
	sets.WS["Avalanche Axe"] = {}
	sets.WS["Spinning Axe"] = {}
	sets.WS["Rampage"] = {}
	sets.WS["Calamity"] = {}
	sets.WS["Mistral Axe"] = {}
	sets.WS["Decimation"] = sets.WS.CRIT
	sets.WS["Bora Axe"] = {}
	sets.WS["Cloudsplitter"] = {}

	--Sword WS
	sets.WS["Fast Blade"] = {}
	sets.WS["Burning Blade"] = {}
	sets.WS["Red Lotus Blade"] = {}
	sets.WS["Flat Blade"] = {}
	sets.WS["Shining Blade"] = {}
	sets.WS["Seraph Blade"] = {}
	sets.WS["Circle Blade"] = {}
	sets.WS["Spirits Within"] = {}
	sets.WS["Vorpal Blade"] = {}
	sets.WS["Savage Blade"] = sets.WS.WSD
	sets.WS["Sanguine Blade"] = {}
	sets.WS["Requiescat"] = {}

	--Great Sword WS
	sets.WS["Fimbulvetr"] = {}
	sets.WS["Resolution"] = {}

	--Club WS
	sets.WS["Judgment"] = {}
	sets.WS["Black Halo"] = {}

	--Polearm
	sets.WS["Impulse Drive"] = sets.WS.CRIT
	sets.WS["Leg Sweep"] = {
		head=gear.Head.Nyame,
		body=gear.Body.Nyame,
		hands=gear.Hands.Nyame,
		legs=gear.Legs.Nyame,
		feet=gear.Feet.Nyame,
		neck="Warrior's Bead Necklace +2",
		waist="Sailfi Belt +1",
		ear1="Moonshade Earring",
		ear2="Boii Earring +1",
		ring1=gear.Ring.Stikini_1,
		ring2="Regal Ring",
		back=gear.Back.WAR_WS1,
	}

	 sets.WS['Cataclysm'] = { --MAB26
        ammo="Knobkierrie", --WSD6
        head="Pixie Hairpin +1", --DMAB28
        body=gear.Body.Nyame.Body, --MAB30 WSD12
        hands=gear.Hands.Nyame, --MAB30 WSD10
        legs=gear.Legs.Nyame, --MAB30 WSD11
        feet=gear.Feet.Nyame, --MAB30 WSD10
        neck="Sanctity Necklace", --MAB10
        waist="Orpheus's Sash", 
        ear1="Moonshade Earring", --TPB250 MAB4
        ear2="Friomisi Earring", --MAB10
        ring1="Archon Ring", --DMAB5
        ring2="Epaminondas's Ring",
        back=gear.Back.WAR_WS1,
    } --TPB250 MAB170 DMAB33 WSD59

	sets.TreasureHunter = {}
end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------

-- This function is called when the job file is loaded.
-- It can be used to set up custom variables or settings.
function jobsetup_custom()
   if player.sub_job == 'SAM' then
        send_command('bind !c input /ja "Warding Circle" <me>')
        send_command('bind !` input /ja "Hasso" <me>')
        send_command('bind ^` input /ja "Seigan" <me>')
        
        set_macro_page(1, 1)
    elseif player.sub_job == 'DRG' then
        send_command('bind !c input /ja "Ancient Circle" <me>')
        set_macro_page(6, 1)
    end
end

-- Called when the player's subjob changes.
function sub_job_change_custom(new, old)
	-- Typically used for Macro pallet changing
end

--Adjust custom precast actions
function pretarget_custom(spell,action)

end

-- Augment basic equipment sets
function precast_custom(spell)
	equipSet = {}

	return equipSet
end

-- Augment basic equipment sets
function midcast_custom(spell)
	equipSet = {}

	return equipSet
end

-- Augment basic equipment sets
function aftercast_custom(spell)
	equipSet = {}

	return equipSet
end

--Function is called when the player gains or loses a buff
function buff_change_custom(name, gain)
	equipSet = {}

	return equipSet
end

--This function is called when a update request the correct equipment set
function choose_set_custom()
	equipSet = {}

	return equipSet
end

--Function is called when the player changes states
function status_change_custom(new,old)
	equipSet = {}

	return equipSet
end

--Function is called when a self command is issued
function self_command_custom(command)

end

function user_file_unload()
	
end

function check_buff_JA()
	buff = 'None'
	local ja_recasts = windower.ffxi.get_ability_recasts()
	if not buffactive['Berserk'] and ja_recasts[1] == 0 then
		buff = "Berserk"
	elseif not buffactive['Aggressor'] and ja_recasts[4] == 0 then
		buff = "Aggressor"
	elseif not buffactive['Warcry'] and ja_recasts[2] == 0 then
		buff = "Warcry"
	end
	if player.sub_job == 'SAM' then
		if not buffactive['Hasso'] and not buffactive['Seigan'] and ja_recasts[138] == 0 then
			buff = "Hasso"
		end
	end
	return buff
end

function check_buff_SP()
	buff = 'None'
	--local sp_recasts = windower.ffxi.get_spell_recasts()
	return buff
end

function pet_change_custom(pet,gain)
	equipSet = {}
	
	return equipSet
end

function pet_aftercast_custom(spell)
	equipSet = {}

	return equipSet
end

function pet_midcast_custom(spell)
	equipSet = {}

	return equipSet
end