include('Kaius-Include')
include('gear/gear')
include('Global-Binds.lua')

LockStylePallet = "4"
MacroBook = "4"
MacroSet = "1"
AutoItem = false
Lockstyle_List = {1,2,6,12}
Random_Lockstyle = false

-- Use "gs c food" to use the specified food item 
Food = "Tropical Crepe"

state.OffenseMode:options('Refresh','Melee','DT')
state.OffenseMode:set('Refresh')

--Weapon Modes
state.WeaponMode:options('Unlocked', 'Laevateinn')
state.WeaponMode:set('Unlocked')

--Command to Lock Style and Set the correct macros
jobsetup (LockStylePallet,MacroBook,MacroSet)

-- Custom Keybinds
send_command('bind !F1 input /ja "Manafont" <me>')
send_command('bind !F2 input /ja "Subtle Sorcery" <me>')

send_command('bind !p input /ma "Protect III" <stpc>')
send_command('bind !o input /ma "Shell II" <stpc>')
send_command('bind !i input /ma "Blink" <me>')
send_command('bind !u input /ma "Aquaveil" <me>')
send_command('bind !s input /ja Sublimation <me>')

send_command('bind !` input /ja "Mana Wall" <me>')
send_command('bind !t input /ma "Stun" <t>')
send_command('bind !b input /ma "Bind" <t>')
send_command('bind !e input /ja "Elemental Seal" <me>')
send_command('bind !m input /ws "Myrkr" <me>')
send_command('bind @1 input /ws "Vidohunir" <t>')

if player.sub_job == 'RDM' then
	send_command('bind !g input /ma "Gravity" <t>')
end

if player.sub_job == 'SCH' then
	send_command('bind !- gs c scholar light')
	send_command('bind != gs c scholar dark')

	send_command('bind ^; gs c scholar speed')   
	send_command('bind ^[ gs c scholar aoe')
	send_command('bind !; gs c scholar cost')
	send_command('bind ![ gs c scholar power')
end

-- Start sets
function get_sets()

	sets.Weapons = {}

	sets.Weapons['Laevateinn'] ={
		main="Laevateinn",
		sub="Enki Strap",
	}

    sets.Weapons['Unlocked'] ={ }

	sets.Weapons.Shield ={}


	--Standard Idle set with -DT,Refresh,Regen and movement gear
	sets.Idle = {
		main="Mpaca's Staff",
        sub="Irenic Strap +1",
        ammo="Ghastly Tathlum +1",
        head="Null Masque",
        body="Shamash Robe",
        hands="Volte Gloves",
        legs="Assid. Pants +1",
        feet=feet.Nyame,
        neck="Sibyl Scarf",
        ear1="Etiolation Earring",
        ear2="Lugalbanda Earring",
        ring1=ring.Stikini_1,
        ring2=ring.Stikini_2,
        back=back.BLM_MAB_Cape,
        waist="Platinum Moogle Belt",
    }

	-- 'Refresh','Melee','DT'
	sets.Idle.Refresh = set_combine(sets.Idle, {})
	sets.Idle.Melee = set_combine(sets.Idle, {})
	sets.Idle.DT = set_combine(sets.Idle, {
		neck="Warder's Charm +1",
	})

	-- Set is only applied when sublimation is charging
	sets.Idle.Sublimation = set_combine(sets.Idle, {
	    waist="Embla Sash", -- +3 Submlimation when active
	})

	sets.Idle.Resting = set_combine(sets.Idle, {})
    
    if (item_available("Shneddick Ring +1")) then
        sets.Movement = { ring1="Shneddick Ring +1" }
    else
        sets.Movement = { feet="Herald's Gaiters" }
    end

	sets.Cursna_Received = {
	    neck="Nicander's Necklace",
        ring1="Eshmun's Ring",
        ring2="Purity Ring",
        waist="Gishdubar Sash",
	}

	sets.OffenseMode = {
		ammo="Hasty Pinion +1",
        head="Blistering Sallet +1",
        body=body.Nyame,
        hands=hands.Nyame,
        legs=legs.Nyame,
        feet=feet.Nyame,
        neck="Sanctity Necklace",
        ear1="Crepuscular Earring",
        ear2="Telos Earring",
        ring1=ring.Chirich_1,
        ring2=ring.Chirich_2,
        waist="Windbuffet Belt +1",
        back=back.BLM_MAB,
	}

	sets.OffenseMode.Refresh = set_combine(sets.Idle,{ }) --Engaged, but stay in normal idle set
	sets.OffenseMode.Melee = set_combine(sets.OffenseMode,{ }) --Engaged, want to DD
	sets.OffenseMode.DT = set_combine(sets.OffenseMode, { 
		main="Mpaca's Staff",
        sub="Irenic Strap +1",
        ammo="Staunch Tathlum +1",
        head=head.BLM_Empyrean,
        body="Shamash Robe", 
        hands=hands.Agwu,
        feet=feet.Nyame,
        neck="Loricate Torque +1",
        ear1="Etiolation Earring",
        ear2="Lugalbanda Earring",
        ring1="Gelatinous Ring +1",
        ring2="Defending Ring",
        back=back.BLM_MAB,
        waist="Platinum Moogle Belt",
	}) --Engaged, max DT

	sets.Precast = {}

	-- Used for Magic Spells
	sets.Precast.FastCast = {
		ammo="Sapience Orb",
        head=head.Amalric_A,
        body="Zendik Robe",
        hands=hands.Agwu,
        legs=legs.Agwu,
        feet=feet.Merlinic_FC,
        neck="Orunmila's Torque",
        ear1="Malignance Earring",
        ear2="Enchanter's Earring +1",
        ring1="Kishar Ring",
        ring2="Lebeche Ring",
        back="Fi Follet Cape +1",
        waist="Embla Sash",
	} -- 80% FC

	sets.Precast["Impact"] = set_combine(sets.Precast.FastCast,{
	    head=empty, 
        body="Crepuscular Cloak", 
        waist="Shinjutsu-no-Obi +1"
	})

    sets.Precast["Dispelga"] = set_combine(sets.Precast.FastCast,{
	    main="Daybreak", 
        sub="Ammurapi Shield",  
        waist="Shinjutsu-no-Obi +1"
	})

	-- Job Abilities
	sets.JA = {}
	sets.JA["Collimated Fervor"] = {}
	sets.JA["Convert"] = {}
	sets.JA["Bolster"] = {}
	sets.JA["Full Circle"] = {}
	sets.JA["Lasting Emanation"] = {}
	sets.JA["Ecliptic Attrition"] = {}
	sets.JA["Life Cycle"] = {}
	sets.JA["Blaze of Glory"] = {}
	sets.JA["Dematerialzie"] = {}
	sets.JA["Theurgic Focus"] = {}
	sets.JA["Concentric Pulse"] = {}
	sets.JA["Mending Halation"] = {}
	sets.JA["Radial Arcana"] = {}
	sets.JA["Widened Compass"] = {}
	sets.JA["Entrust"] = {}

	--Base set for midcast - if not defined will notify and use your idle set for surviability
	sets.Midcast = set_combine(sets.Idle, {
	
	})

	--This set is used as base as is overwrote by specific gear changes (Spell Interruption Rate Down)
	sets.Midcast.SIRD = {

	}

	-- Cure Set
	sets.Midcast.Cure = {
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        body="Shamash Robe",
        hands=hands.Telchine_ENH,
        feet="Vanya Clogs",
        neck="Nodens Gorget",
        ear1="Mendi. Earring",
        ear2="Regal Earring",
        ring1="Lebeche Ring",
        ring2="Haoma's Ring",
        back="Oretan. Cape +1",
        waist="Bishop's Sash",
    }

	sets.Midcast.Enhancing = {
		main=weapons.Gada_ENH,
        sub="Ammurapi Shield",
        head=head.Telchine_ENH,
        body=body.Telchine_ENH,
        hands=hands.Telchine_ENH,
        legs=legs.Telchine_ENH,
        feet=feet.Telchine_ENH,
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1=ring.Stikini_1,
        ring2=ring.Stikini_2,
        back="Fi Follet Cape +1",
        waist="Embla Sash",
	}

	sets.Midcast.Enhancing.Others = set_combine(sets.Midcast.Enhancing, {});
	sets.Midcast.Enhancing.Status = set_combine(sets.Midcast.Enhancing, {});
	sets.Midcast.Enhancing.Skill = set_combine(sets.Midcast.Enhancing, {});

	-- High MACC for landing spells
	sets.Midcast.Enfeebling = {
	    main="Daybreak",
		sub="Ammurapi Shield",
		ammo=ammo.GhastlyTathlum,
		head=head.BLM_Empyrean,
		body=body.BLM_Empyrean,
		hands=hands.BLM_Empyrean,
		legs=legs.BLM_Empyrean,
		feet=feet.BLM_Empyrean,
		neck="Sorcerer's Stole +2",
		waist="Acuity Belt +1",
		ear1="Malignance Earring",
		ear2="Wicce Earring +2",
		ring1=ring.Stikini_1,
        ring2="Metamorph Ring +1",
		back="Aurist's Cape +1",
	}

	sets.Midcast.Enfeebling.MACC = set_combine(sets.Midcast.Enfeebling, {})
	sets.Midcast.Enfeebling.Potency = set_combine(sets.Midcast.Enfeebling, {})
	sets.Midcast.Enfeebling.Duration = set_combine(sets.Midcast.Enfeebling, {})
	sets.Midcast.Enfeebling.Drain = set_combine(sets.Midcast.Enfeebling, {})
	sets.Midcast.Enfeebling.Aspir = set_combine(sets.Midcast.Enfeebling, {})

	sets.Midcast.Dark = set_combine(sets.Midcast.Enfeebling, {})
	sets.Midcast.Dark.MACC = set_combine(sets.Midcast.Enfeebling.MACC, {})
	sets.Midcast.Dark.Absorb = set_combine(sets.Midcast.Enfeebling, {})
	sets.Midcast.Dark.Enhancing = set_combine(sets.Midcast.Enhancing, {})

	sets.Midcast.Nuke = {
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
		ammo="Sroda Tathlum",
        head=head.BLM_Empyrean,
        body=body.BLM_Empyrean,
        hands=hands.BLM_Empyrean,
        legs=legs.BLM_Empyrean,
        feet=feet.BLM_Empyrean,
        neck="Sorcerer's Stole +2",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2=ring.Medada_Or_Metamorph,
        back=back.BLM_MAB,
        waist="Acuity Belt +1",
	}

	sets.Midcast.Burst = set_combine(sets.Midcast.Nuke, { 
        ammo="Ghastly Tathlum +1",
        hands=hands.Agwu,
        feet=feet.Agwu,
    })

	sets.Midcast['Impact'] = set_combine(sets.Midcast.Nuke, {
		hands=hands.BLM_Empyrean,
		legs=legs.BLM_Empyrean,
		feet=feet.BLM_Empyrean,
		ring1=ring.Stikini_1,
		ring2=ring.Stikini_2,
	})

    sets.Midcast['Dispelga'] = set_combine(sets.Midcast.Enfeebling.MACC, {
		main="Daybreak", 
        sub="Ammurapi Shield",
	})

	-- Misc Sets
	sets.Midcast.CuragaSet = sets.Midcast.Cure

	sets.Midcast.Cursna = {}

	sets.MP_Recover = {
	    body=body.BLM_Artifact,
	}

	--Used for elemental Bar Magic Spells
	sets.Midcast.Enhancing.Elemental = {}

	-- Specific gear for spells
	sets.Midcast["Stoneskin"] = set_combine(sets.Midcast.Enhancing, {
		ring2=ring.Stikini_2,
		waist="Siegel Sash",
		neck="Nodens Gorget",
	})

	sets.Midcast["Aquaveil"] = set_combine(sets.Midcast.Enhancing, {
		main="Vadose Rod",
        sub="Ammurapi Shield",
        ammo="Staunch Tathlum +1",
        head=head.Amalric_A,
        hands="Regal Cuffs",
        ear1="Halasz Earring",
        ring1="Freke Ring",
        ring2="Evanescence Ring",
        waist="Emphatikos Rope",
	})

	sets.Midcast.Refresh = set_combine(sets.Midcast.Enhancing, {
		head=head.Amalric_A,
	})

	-- Aspir Set
	sets.Midcast.Aspir = {}

	sets.WS = {}

	sets.WS["Myrkr"] = {
		ammo="Ghastly Tathlum +1",
		head="Pixie Hairpin +1",
        body=body.BLM_Empyrean,
        hands=hands.Telchine_ENH,
        legs=legs.BLM_Empyrean,
        feet=feet.BLM_Relic,
        neck="Orunmila's Torque",
        ear1="Etiolation Earring",
        ear2="Loquacious Earring",
        ring1="Mephitas's Ring +1",
        ring2="Fenrir Ring +1",
        back="Bane Cape",
        waist="Shinjutsu-no-Obi +1",s
	}

	sets.TreasureHunter = { }

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
	local equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function midcast_custom(spell)
	local equipSet = {}
	if spell.skill == 'Elemental Magic' and not Elemental_Enfeeble:contains(spell.name) and player.MPP < 30 then
		windower.add_to_chat(8,'Player Less than 30% MP - Recover MP!')
		equipSet = sets.MP_Recover
	end
	return equipSet
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	local equipSet = {}

	return equipSet
end
--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	local equipSet = {}

	return equipSet
end
--This function is called when a update request the correct equipment set
function choose_set_custom()
	local equipSet = {}

	return equipSet
end
--Function is called when the player changes states
function status_change_custom(new,old)
	local equipSet = {}

	return equipSet
end

function pet_change_custom(pet,gain)
	local equipSet = {}

	return equipSet
end

function pet_aftercast_custom(spell)
	local equipSet = {}

	return equipSet
end

function pet_midcast_custom(spell)
	local equipSet = {}

	return equipSet
end

--Function is called when a self command is issued
function self_command_custom(command)

end

-- Function is called when the job lua is unloaded
function user_file_unload()

end

--Function used to automate Job Ability use - Checked first
function check_buff_JA()
	local buff = 'None'
	--local ja_recasts = windower.ffxi.get_ability_recasts()
	return buff
end

--Function used to automate Spell use
function check_buff_SP()
	local buff = 'None'
	--local sp_recasts = windower.ffxi.get_spell_recasts()
	return buff
end