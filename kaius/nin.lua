-- Load and initialize the include file.
include('Kaius-Include')
include('gear/gear')
include('Global-Binds.lua')

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "13"
MacroBook = "13"
MacroSet = "1"

-- Use "gs c food" to use the specified food item 
Food = "Grape Daifuku"

--Uses Items Automatically
AutoItem = false

--Upon Job change will use a random lockstyleset
Random_Lockstyle = false

--Lockstyle sets to randomly equip
Lockstyle_List = {1,2,6,12}

--Set default mode (TP,ACC,DT)
state.OffenseMode:options('TP','DT','PDL','MEVA') -- ACC effects WS and TP modes
state.OffenseMode:set('DT')

--Modes for specific to Ninja
state.WeaponMode:options('Heishi_Gleti','Heishi_Darkblade','Naegling','Aeolian','Unlocked')
state.WeaponMode:set('Heishi_Gleti')

elemental_ws = S{'Aeolian', 'Blade: Teki', 'Blade: To','Blade: Chi','Blade: Ei','Blade: Yu'}

jobsetup (LockStylePallet,MacroBook,MacroSet)

function get_sets()
	sets.Weapons = {}
	sets.Weapons['Heishi_Gleti'] = {main="Heishi Shorinken",sub="Gleti's Knife"}
    sets.Weapons['Heishi_Darkblade'] = {main="Heishi Shorinken",sub="Yagyu Darkblade"}
	sets.Weapons['Naegling'] = {main="Naegling",sub="Uzura +2",}
	sets.Weapons['Aeolian'] = {main="Tauret",sub="Naegling"}
	sets.Weapons['Unlocked'] = { }

	sets.Weapons.Shield = {}
	sets.Weapons.Sleep = {}

	sets.Idle = {
		ammo="Seki Shuriken",
        head="Null Masque",
        body="Adamantite Armor",
        hands=hands.Malignance,
        legs=legs.NIN_Empyrean,
        feet=feet.Malignance,
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Sanare Earring",
        ring1="Purity Ring",
        ring2="Fortified Ring",
        back="Null Shawl",
        waist="Null Belt",
    }

	sets.Idle.TP = set_combine(sets.Idle, {})
	sets.Idle.DT = set_combine(sets.Idle, {})
	sets.Idle.PDL = set_combine(sets.Idle, {})
	sets.Idle.MEVA = set_combine(sets.Idle, {})

	--Defined below based off time of day
	sets.Movement = {}


    if (item_available("Shneddick Ring +1")) then
        sets.Movement.Day = { ring1="Shneddick Ring +1" }
    else
        sets.Movement.Day = { feet="Danzo Sune-Ate" }
    end

	sets.Movement.Night = {
		feet=feet.NIN_Artifact,
	}
	sets.Movement.Dusk = {
		feet=feet.NIN_Artifact,
	}

	sets.Cursna_Received = {
	    neck="Nicander's Necklace",
        ring1="Eshmun's Ring",
        ring2="Purity Ring",
        waist="Gishdubar Sash",
	}

	sets.OffenseMode = {}

	--Base TP set to build off
	sets.OffenseMode.TP = {
		ammo="Seki Shuriken",
        head=head.Malignance,
        body=body.Mpaca,
        hands=hands.Mpaca,
        legs=legs.Mpaca,
        feet=feet.Malignance,
        neck="Ninja Nodowa +2",
        ear1="Dedition Earring",
        ear2="Hattori Earring +1",
        ring1="Gere Ring",
        ring2=ring.Lehko_Or_Chirich2,
        back=back.NIN_TP_Cape,
        waist="Sailfi Belt +1",        
	}

	--This set is used when OffenseMode is DT and Enaged (Augments the TP base set)
	sets.OffenseMode.DT = set_combine (sets.OffenseMode.TP, {
	    head=head.Malignance,
		body=body.Mpaca,
		hands=hands.Malignance,
		legs=legs.Malignance,
		feet=feet.Malignance,
	})

	sets.OffenseMode.PDL = set_combine (sets.OffenseMode.TP, {
	    head=head.Malignance,
		body=body.Malignance,
		hands=hands.Malignance,
		legs=legs.Malignance,
		feet=feet.Malignance,
	})

	sets.OffenseMode.MEVA = set_combine(sets.OffenseMode.DT,{
		neck="Warder's Charm +1"
	})

	sets.DualWield = {}

	sets.Precast = {}
	-- Used for Magic Spells
	sets.Precast.FastCast = {
	    ammo="Sapience Orb", --2
        head=head.Herc_FC, --13
        body=body.Taeon_FC, --9
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchanter's Earring +1", --2
        ring1="Kishar Ring", --4
        ring2="Prolix Ring", --2
        back=gear.NIN_FC_Cape, --10
        waist=waist.PlatinumMoogle,
	} -- 67

	sets.Precast.Utsusemi = {
		ammo="Staunch Tathlum +1", --11
        body=body.NIN_Relic,
        hands="Rawhide Gloves", --15
        legs=legs.Taeon_Phalanx, --10
        feet=feet.Taeon_Phalanx, --10
        neck="Magoraga Beads", -- 10 FC (+6)
        ear1="Halasz Earring", --5
        ear2="Magnetic Earring", --8
        ring1="Evanescence Ring", --5
        back=gear.NIN_FC_Cape,
        waist="Audumbla Sash", --10
	}

	sets.Precast.QuickMagic = {

	}

	sets.Enmity = { -- Head and Back upgrade slots
		ammo="Sapience Orb", --2
		body="Emet Harness +1", --10
		hands="Kurys Gloves", --9
		--="Zoar Subligar +1", --6
		-- feet="Ahosi Leggings", --7
		neck="Moonlight Necklace", --15
		waist="Kasiri Belt", --3
		ear1="Cryptic Earring", --4
		ear2="Friomisi Earring", --2
		ring1="Petrov Ring", --4
		ring2="Eihwaz Ring", --5
	}

	--Base set for midcast - if not defined will notify and use your idle set for surviability
	sets.Midcast = set_combine(sets.Idle, {
	
	})
	-- Utsusemi Set
	sets.Midcast.Utsusemi = {
		back=back.NIN_FC,
		feet=feet.NIN_Empyrean,
	}
	--This set is used as base as is overwrote by specific gear changes (Spell Interruption Rate Down)
	sets.Midcast.SIRD = {}
	-- Cure Set
	sets.Midcast.Cure = {}
	-- Enhancing Skill
	sets.Midcast.Enhancing = {
		head=head.NIN_Artifact,
        feet=feet.NIN_Relic,
        neck="Incanter's Torque",
        -- ear1="Stealth Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        -- back="Astute Cape",
        -- waist="Cimmerian Sash",
	}

	-- High MACC for landing spells
	sets.Midcast.Enfeebling = {
		ammo=ammo.Yamarang,
        head=head.NIN_Artifact,
        body=body.Malignance,
        hands=hands.Malignance,
        legs=legs.Malignance,
        feet=feet.NIN_Artifact,
        neck="Sanctity Necklace",
        ear1="Crepuscular Earring",
        ear2="Hattori Earring +1",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=back.NIN_MAB,
        waist="Skrymir Cord +1",
	}
    
	-- High MAB for spells
	sets.Midcast.Nuke = {
		ammo=ammo.GhastlyTathlum,
        head=head.NIN_Relic,
        body=body.Nyame,
        hands=hands.Nyame,
        legs=legs.Nyame,
        feet=feet.Relic,
        neck="Sibyl Scarf",
        waist="Skrymir Cord +1",
        ear1="Friomisi Earring",
        ear2="Hattori Earring +1",
        ring1="Metamorph Ring +1",
        ring2="Dingir Ring",
        back=back.NIN_TP,
	}

	sets.JA = {}
	sets.JA["Futae"] = { hands=hands.NIN_Empyrean } --hands="Hattori Tekko"
	sets.JA["Berserk"] = {}
	sets.JA["Warcry"] = {}
	sets.JA["Defender"] = {}
	sets.JA["Aggressor"] = {}
	sets.JA["Provoke"] = sets.Enmity
	sets.JA["Mijin Gakure"] = {}
	sets.JA["Yonin"] = { head=head.NIN_Relic }
	sets.JA["Innin"] = { head=head.NIN_Relic }
	sets.JA["Issekigan"] = {}
	sets.JA["Mikage"] = {}

	--Default WS set base
	sets.WS = {
		ammo="Coiste Bodhar",
        head=head.Nyame,
        body=body.Nyame,
        hands=hands.Nyame,
        legs=legs.Nyame,
        feet=feet.Nyame,
        neck="Ninja Nodowa +2",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1="Epaminondas's Ring",
        ring2=gear.Cornelia_Or_Regal,
        back=gear.NIN_WS_Cape,
        waist="Fotia Belt",
	}

	--This set is used when OffenseMode is ACC and a WS is used (Augments the WS base set)

	sets.WS.Hybrid = {
        ammo="Seeth. Bomblet +1",
        head=head.Nyame,
        neck="Fotia Gorget",
        body=body.Nyame,
        hands=hands.Nyame,
        feet=feet.Nyame,
        legs=legs.Nyame,        
        ear1="Moonshade Earring",
        ear2="Lugra Earring +1",
        ring1="Gere Ring",
        ring2=gear.Cornelia_Or_Epaminondas,
        waist="Orpheus's Sash",
        back=gear.NIN_WS_Cape,
    }

	sets.WS["Blade: Teki"] = sets.WS.Hybrid
	sets.WS["Blade: To"] = sets.WS.Hybrid
	sets.WS["Blade: Chi"] = sets.WS.Hybrid

	sets.WS["Blade: Metsu"] = {
		ammo="Coiste Bodhar",
        head=head.Nyame,
        body=body.Nyame,
        hands=hands.Nyame,
        legs=legs.Nyame,
        feet=feet.Nyame,
        neck="Ninja Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Odr Earring",
        ear2="Lugra Earring +1",
        ring1="Gere Ring",
        ring2=gear.Cornelia_Or_Regal,
        back=gear.NIN_WS_Cape,
	}

	sets.WS["Blade: Rin"] = {}
	sets.WS["Blade: Retsu"] = {}

	sets.WS["Blade: Ei"] = {
		ammo="Seeth. Bomblet +1",
        head="Pixie Hairpin +1",
        neck="Sibyl Scarf",
        body=body.Nyame,
        hands=hands.Nyame,
        feet=feet.Nyame,
        legs=legs.Nyame,        
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1=gear.Cornelia_Or_Epaminondas,
        ring2="Archon Ring",
        waist="Orpheus's Sash",
        back=gear.NIN_WS_Cape,
	}

	sets.WS["Blade: Jin"] = {}

	sets.WS["Blade: Ten"] = {
		ammo="Coiste Bodhar",
        head=head.Mpaca,
        body=body.Nyame,
        hands=hands.Nyame,
        legs=legs.Nyame,
        feet=feet.Nyame,
        neck="Rep. Plat. Medal",
        waist="Sailfi Belt +1",
        ear1="Moonshade Earring",
        ear2="Lugra Earring +1",
        ring1="Gere Ring",
        ring2=gear.Cornelia_Or_Regal,
        back=gear.NIN_WS_Cape,
	}

	sets.WS["Blade: Ku"] = {
		ammo="Seeth. Bomblet +1",
        head=head.Mpaca,
        body=body.Nyame,
        hands=hands.NIN_Relic,
        legs=legs.Nyame,
        feet=feet.Nyame,
        neck="Fotia Gorget",
        waist="Fotia Belt",
        ear1="Mache Earring +1",
        ear2="Lugra Earring +1",
        ring1="Gere Ring",
        ring2=gear.Cornelia_Or_Regal,
        back=gear.NIN_DA_Cape,
	}

	sets.WS["Blade: Kamu"] = {
		ammo="Crepuscular Pebble",
        head=head.Mpaca,
        body=body.Nyame,
        hands=hands.Nyame,
        legs=legs.Mpaca,
        feet=feet.Nyame,
        neck="Rep. Plat. Medal",
        waist="Sailfi Belt +1", 
        ear1="Moonshade Earring",
        ear2="Lugra Earring +1",
        ring1="Gere Ring",
        ring2=gear.Cornelia_Or_Sroda,
        back=gear.NIN_TP_Cape,
	}

	sets.WS["Blade: Yu"] = {
		ammo="Seeth. Bomblet +1",
        head="Hachiya Hatsu. +3",
        body=body.Nyame,
        hands=hands.Nyame,
        legs=legs.Nyame,
        feet=feet.Nyame,
        neck="Baetyl Pendant",
        ear1="Crematio Earring",
        ear2="Friomisi Earring",
        ring1="Dingir Ring",
        ring2=gear.Cornelia_Or_Epaminondas,
        back=gear.NIN_MAB_Cape,
        waist="Skrymir Cord +1",
	}

	sets.WS["Blade: Hi"] = {
		ammo="Yetshila +1",
        head=head.Relic,
        body=body.Nyame,
        hands=hands.Nyame,
        feet=feet.Nyame,
        neck="Ninja Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Odr Earring",
        ear2="Lugra Earring +1",
        ring1="Gere Ring",
        ring2=gear.Cornelia_Or_Regal,
        back=gear.NIN_WS_Cape,
	}

	sets.WS["Blade: Shun"] = {
		ammo="Coiste Bodhar",
        head="Mpaca's Cap",
        body=body.Malignance,
        hands=hands.Nyame,
        legs=legs.Mpaca,
        feet=feet.Nyame,
        neck="Fotia Gorget",
        waist="Fotia Belt",
        ear1="Moonshade Earring",
        ear2="Hattori Earring +1",
        ring1="Gere Ring",
        ring2=gear.Cornelia_Or_Regal,
        back=gear.NIN_DA_Cape,
	}

	sets.WS["Savage Blade"] = {
	    ammo="Seething Bomblet +1",
        head=head.Mpaca,
        body=body.Nyame,
        hands=hands.Nyame,
        legs=legs.Nyame,
        feet=feet.Nyame,
        neck="Rep. Plat. Medal",
        waist="Sailfi Belt +1",
        ear1="Moonshade Earring",
        ear2="Lugra Earring +1",
        ring1="Gere Ring",
        ring2=gear.Cornelia_Or_Epaminondas,
        back=gear.NIN_WS_Cape,
	}

	sets.WS['Aeolian Edge'] = {
        ammo="Seeth. Bomblet +1",
        head="Pixie Hairpin +1",
        neck="Sibyl Scarf",
        body=body.Nyame,
        hands=hands.Nyame,
        feet=feet.Nyame,
        legs=legs.Nyame,        
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1="Dingir Ring",
        ring2="Epaminondas's Ring",
        waist="Orpheus's Sash",
        back=gear.NIN_WS_Cape,
    }

end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------

-- This function is called when the job file is loaded.
-- It can be used to set up custom variables or settings.
function jobsetup_custom()
   send_command('bind !F1 input /ja "Mijin Gakure" <me>')
    send_command('bind !F2 input /ja "Mikage" <me>')
    send_command('bind !` input /ja "Innin" <me>')
    send_command('bind ^` input /ja "Yonin" <me>')
    send_command('bind !t input /ja "Provoke" <t>')
    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @q gs c toggle MagicBurst')
    send_command('bind !numpad7 input /ma "Jubaku: Ichi" <t>')
    send_command('bind !numpad8 input /ma "Hojo: Ni" <t>')
    send_command('bind !numpad9 input /ma "Aisha: Ichi" <t>')  
    send_command('bind !numpad1 input /ma "Yurin Ichi" <t>')
    send_command('bind !numpad2 input /ma "Kurayami: Ni" <t>')
    send_command('bind !numpad3 input /ma "Dokumori: Ichi" <t>')
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
function buff_change_custom(name,gain)
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
--Function is called by the gearswap command
function self_command_custom(command)

end

-- This function is called when the job file is unloaded
function user_file_unload()

end

function check_buff_JA()
	buff = 'None'
	local ja_recasts = windower.ffxi.get_ability_recasts()
	if player.sub_job == 'WAR' then
		if not buffactive['Berserk'] and ja_recasts[1] == 0 then
			buff = "Berserk"
		elseif not buffactive['Aggressor'] and ja_recasts[4] == 0 then
			buff = "Aggressor"
		elseif not buffactive['Warcry'] and ja_recasts[2] == 0 then
			buff = "Warcry"
		end
	end
	return buff
end

function check_buff_SP()
	buff = 'None'
	--local sp_recasts = windower.ffxi.get_spell_recasts()
	return buff
end

Cycle_Time = 1
function Cycle_Timer()
	if world.time >= 17*60 or world.time <= 7*60 then
		if world.time >= (18*60) or world.time <= (6*60) then
			sets.Movement = set_combine(sets.Movement, sets.Movement.Night)
			log('Night')
		else
			sets.Movement = set_combine(sets.Movement, sets.Movement.Dusk)
			log('Dusk')
		end
	else
		sets.Movement = set_combine(sets.Movement, sets.Movement.Day)
		log('Day')
	end
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