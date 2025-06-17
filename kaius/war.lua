-- Load and initialize the include file.
include('Kaius-Include')
include('gear/Gear')
include('Global-Binds.lua')

LockStylePallet = "1"
MacroBook = "1"
MacroSet = "1"
Food = "Sublime Sushi"
AutoItem = false
Random_Lockstyle = false
Lockstyle_List = {1,2,6,12}
Elemental_WS = S{'Aeolian Edge', 'Seraph Blade', 'Shining Blade','Red Lotus Blade', 'Burning Blade', 'Sanguine Blade', 'Energy Drain','Energy Steal','Cyclone','Gust Slash'}

state.OffenseMode:options('TP','DT','PDL', 'SUB', 'MEVA')
state.OffenseMode:set('TP')

state.WeaponMode:options('Chango', 'Shining One', 'Helheim', 'Naegling', 'Loxotic', 'Dolichenus', 'Unlocked')
state.WeaponMode:set('Chango')

-- Initialize Player
jobsetup (LockStylePallet,MacroBook,MacroSet)

send_command('bind ^numpad7 gs c WeaponMode Chango;')
send_command('bind ^numpad8 gs c WeaponMode Helheim;')
send_command('bind ^numpad9 gs c WeaponMode Shining One;')
send_command('bind ^numpad4 gs c WeaponMode Naegling;')
send_command('bind ^numpad5 gs c WeaponMode Loxotic;')
send_command('bind ^numpad6 gs c WeaponMode Dolichenus;')
send_command('bind ^numpad0 gs c WeaponMode Unlocked;')

if player.sub_job == 'SAM' then
	send_command('bind !c input /ja "Warding Circle" <me>')
	send_command('bind !` input /ja "Hasso" <me>')
	send_command('bind ^` input /ja "Seigan" <me>')
elseif player.sub_job == 'DRG' then
	send_command('bind !c input /ja "Ancient Circle" <me>')
end

function get_sets()

	-- Weapon setup
	sets.Weapons = {}

	sets.Weapons['Chango'] = {main="Chango", sub="Utu Grip"}
	sets.Weapons['Shining One'] = {main="Shining One", sub="Utu Grip"}
	sets.Weapons['Helheim'] = {main="Helheim",sub="Utu Grip"}
	sets.Weapons['Naegling'] = {main="Naegling",sub="Ikenga's Axe"}
	sets.Weapons['Loxotic'] = {main="Loxotic Mace +1",sub="Ikenga's Axe"}
	sets.Weapons['Dolichenus'] = {main="Dolichenus",sub="Ikenga's Axe"}

	-- This stops GS from chaning weapons (Abyssea Proc etc)
	sets.Weapons['Unlocked'] ={ }

	-- This is used when you do not have dual wield and is not a two handed weapon
	sets.Weapons.Shield = {sub="Blurred Shield +1"}

	-- Base set for when the player is not engaged or casting.  Other sets build off this set
	sets.Idle = {
		ammo="Staunch Tathlum +1",
		head=head.Sakpata, 
		body=body.Sakpata,
		hands=hands.Sakpata,
		legs=legs.Sakpata,
		feet=feet.Sakpata,
		neck="Warder's Charm +1",
		waist="Null Belt",
		ear1="Eabani Earring",
		ear2="Odnowa Earring +1",
		ring1=ring.Moonlight_1,
		ring2=ring.ShadowRing,
		back="Null Shawl",
    }

	sets.Idle.TP = set_combine(sets.Idle, {})
	sets.Idle.DT = set_combine(sets.Idle, {})
	sets.Idle.PDL = set_combine(sets.Idle, {})
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
		head=head.Boii,
		body=body.Sakpata,
		hands=hands.Sakpata,
		legs=legs.Sakpata,
		feet=feet.Pummelers,
		neck="Warrior's bead necklace +2",
		waist="Sailfi Belt +1",
	    ear1="Schere Earring",
        ear2="Boii Earring +1",
		ring1="Niqmaddu Ring",
		ring2=ring.Moonlight_2,
		back=back.WAR_TP,
	}

	sets.OffenseMode.TP = set_combine( sets.OffenseMode, {})
	sets.OffenseMode.DT = set_combine( sets.OffenseMode, {
		head=head.Sakpata, 
		feet=feet.Sakpata,
	})

	sets.OffenseMode.PDL = set_combine(sets.OffenseMode, {})

	sets.OffenseMode.MEVA = set_combine(sets.OffenseMode, {
		feet=feet.Sakpata,
		neck="Warder's Charm +1",
	})

	sets.Subtle_Blow = {
		body="Dagon Breastplate", -- 10 SB II
		feet=feet.Sakpata, -- 15 SB I
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

	-- Used for Magic Spells
	sets.Precast.FastCast = {
		ammo="Sapience Orb", --2
		head=head.Sakpata, --8
		body="Sacro Breastplate", --10
		hands="Leyline Gloves", --8
		neck="Orunmila's Torque", -- 5
		ear1="Etiolation Earring", --1
		ear2="Loquacious Earring", -- 3
		ring1="Prolix Ring", -- 2
		ring2="Gelatinous Ring +1",
	} --44%

	sets.Precast.Enmity = {
		ammo="Sapience Orb", -- 2
		head=head.Souveran_C, --9
		body=body.Souveran_C, --20
		hands=hands.Souveran_C, --9
		legs=legs.Souveran_C, --9
		feet=feet.Souveran_D, --9
		neck="Moonlight Necklace", --15
		ear1="Cryptic Earring", --4
		ear2={name="Trux Earring", priority=1},
		ring1="Petrov Ring", --4
		ring2="Eihwaz Ring", --5
	} --91

	sets.Precast['Utsusemi: Ichi'] = {}
	sets.Precast['Utsusemi: Ni'] = {}

	--Base set for midcast - if not defined will notify and use your idle set for surviability
	sets.Midcast = set_combine(sets.Idle, {})

	--This set is used as base as is overwrote by specific gear changes (Spell Interruption Rate Down)
	sets.Midcast.SIRD = {
	    ammo="Staunch Tathlum +1", --11
		feet=feet.Ody_CURE,
		neck="Moonlight Necklace", --15
		ear1="Magnetic Earring", --8
		waist="Audumbla Sash", --10
	}

	sets.Midcast.Enhancing = {}
	sets.Midcast.Enhancing.Others = {}
	
	sets.Midcast['Utsusemi: Ichi'] = {}
	sets.Midcast['Utsusemi: Ni'] = {}

	-- Job Abilities
	sets.JA = {}
	sets.JA["Mighty Strikes"] = {feet=feet.Boii}
	sets.JA["Berserk"] = {body=body.WAR_Artifact, feet=feet.Agoge}
	sets.JA["Warcry"] = {head=head.Agoge}
	sets.JA["Defender"] = {}
	sets.JA["Aggressor"] = {body=body.Agoge, head=head.Agoge}
	sets.JA["Provoke"] = sets.Precast.Enmity
	sets.JA["Tomahawk"] = {ammo="Throwing Tomahawk",} -- Need to add feet
	sets.JA["Retaliation"] = {}
	sets.JA["Restraint"] = {hands=hands.Boii}
	sets.JA["Blood Rage"] = {body=body.Boii}
	sets.JA["Brazen Rush"] = {}

	--Default WS set base
	sets.WS = {
		head=head.Agoge,
        body=body.Nyame,
        hands=hands.Boii,
        legs=legs.Nyame,
        feet=feet.Nyame,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",
        ring1=ring.Cornelia_Or_Regal,
        ring2="Niqmaddu Ring",
        ammo="Knobkierrie",
        back=back.WAR_WS1,
        waist="Sailfi Belt +1",
	}

	sets.WS.WSD = {}

	sets.WS.MEVA = set_combine(sets.WS, {
		head=head.Sakpata,
		body=body.Sakpata,
	})

	-- Modes
	sets.WS.CRIT = {
		ammo="Yetshila +1",
		head=head.Sakpata,
		body="Hjarrandi Breast.",
		hands=hands.Sakpata,
		legs=legs.Sakpata,
		feet=feet.Sakpata,
		neck="Warrior's Bead Necklace +2",
		waist="Sailfi Belt +1",
		ear1="Schere Earring",
		ear2="Boii Earring +1",
		ring1="Niqmaddu Ring",
		ring2="Begrudging Ring",
		back=back.WAR_WS1,
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
	-- sets.WS.AM = {}
	-- sets.WS.AM1 = {}
	-- sets.WS.AM2 = {}
	-- sets.WS.AM3 = {}
	-- sets.WS.AM1['Ukonvasara'] = {}
	-- sets.WS.AM2['Ukonvasara'] = {}
	-- sets.WS.AM3['Ukonvasara'] = {}

	-- sets.WS.AM.RA = {}
	-- sets.WS.AM1.RA = {}
	-- sets.WS.AM2.RA = {}
	-- sets.WS.AM3.RA = {}
	-- sets.WS.AM1.RA['Ukonvasara'] = {}
	-- sets.WS.AM2.RA['Ukonvasara'] = {}
	-- sets.WS.AM3.RA['Ukonvasara'] = {}

	-- Great Axe WS
	sets.WS["Ukko's Fury"] = {
	    ammo="Yetshila +1",
		head=head.Sakpata,
		body=body.Sakpata,
		hands=hands.Sakpata,
		legs=legs.Sakpata,
		feet=feet.Sakpata,
		neck="Warrior's Bead Necklace +2",
		ear1="Schere Earring",
		ear2="Boii Earring +1",
		ring1="Niqmaddu Ring",
		ring2=ring.Ephramad_Or_Regal,
		waist="Sailfi Belt +1",
		back=back.WAR_WS1,
	}
	sets.WS["Upheaval"] = {
	    ammo="Knobkierrie",
		head=head.Agoge,
		body=body.Nyame,
		hands=hands.Nyame,
		legs=legs.Nyame,
		feet=feet.Nyame,
		neck="Warrior's Bead Necklace +2",
		ear1="Moonshade Earring",
		ear2="Thrud Earring",
		ring1="Niqmaddu Ring",
		ring2="Regal Ring",
		waist="Sailfi Belt +1",
		back=back.WAR_WS1,
	}
	
	sets.WS["Full Break"] = {
		 ammo="Pemphredo Tathlum",
		head=head.Nyame,
		body=body.Nyame,
		hands=hands.Nyame,
		legs=legs.Nyame,
		feet=feet.Nyame,
		neck="Null Loop",
		waist="Null Belt",
		ear1="Moonshade Earring",
        ear2="Boii Earring +1",
		ring1=ring.Stikini_1,
		ring2="Regal Ring",
		back=back.WAR_WS1,
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
		head=head.Nyame,
		body=body.Nyame,
		hands=hands.Nyame,
		legs=legs.Nyame,
		feet=feet.Nyame,
		neck="Warrior's Bead Necklace +2",
		waist="Sailfi Belt +1",
		ear1="Moonshade Earring",
		ear2="Boii Earring +1",
		ring1=ring.Stikini_1,
		ring2="Regal Ring",
		back=back.WAR_WS1,
	}

	 sets.WS['Cataclysm'] = { --MAB26
        ammo="Knobkierrie", --WSD6
        head="Pixie Hairpin +1", --DMAB28
        body=body.Nyame.Body, --MAB30 WSD12
        hands=hands.Nyame, --MAB30 WSD10
        legs=legs.Nyame, --MAB30 WSD11
        feet=feet.Nyame, --MAB30 WSD10
        neck="Sanctity Necklace", --MAB10
        waist="Orpheus's Sash", 
        ear1="Moonshade Earring", --TPB250 MAB4
        ear2="Friomisi Earring", --MAB10
        ring1="Archon Ring", --DMAB5
        ring2="Epaminondas's Ring",
        back=back.WAR_WS1,
    } --TPB250 MAB170 DMAB33 WSD59

	sets.TreasureHunter = {}
end

-------------------------------------------------------------------------------------------------------------------
-- DO NOT EDIT BELOW THIS LINE UNLESS YOU NEED TO MAKE JOB SPECIFIC RULES
-------------------------------------------------------------------------------------------------------------------

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
function self_command_custom(cmd)
	local command = cmd:lower()
	if command:contains('weaponmode') then
        if player.sub_job == 'SAM' then
            if state.WeaponMode.value == 'Chango' then
                send_command('input /macro set 1')
            elseif state.WeaponMode.value == 'Shining One' then
                send_command('input /macro set 4')
            elseif state.WeaponMode.value == 'Helheim' then
                send_command('input /macro set 5')
			elseif state.WeaponMode.value == 'Naegling' then
                send_command('input /macro set 2')
			elseif state.WeaponMode.value == 'Loxotic' then
                send_command('input /macro set 3')
			elseif state.WeaponMode.value == 'Doilichenus' then
                send_command('input /macro set 3')
            end
        elseif player.sub_job == 'DRG' then
            if state.WeaponMode.value == 'Chango' then
                send_command('input /macro set 6')
            elseif state.WeaponMode.value == 'Shining One' then
                send_command('input /macro set 9')
            elseif state.WeaponMode.value == 'Helheim' then
                send_command('input /macro set 10')
			elseif state.WeaponMode.value == 'Naegling' then
                send_command('input /macro set 7')
			elseif state.WeaponMode.value == 'Loxotic' then
                send_command('input /macro set 8')
			elseif state.WeaponMode.value == 'Doilichenus' then
                send_command('input /macro set 8')
            end
        end
    end
end

function user_file_unload()
	send_command('unbind !F1')
    send_command('unbind !F2')    
    send_command('unbind !t')
    send_command('unbind !`')
    send_command('unbind ^`')
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