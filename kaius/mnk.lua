
-- Load and initialize the include file.
include('Kaius-Include')
include('gear/gear')
include('Global-Binds.lua')

LockStylePallet = "2"
MacroBook = "2"
MacroSet = "1"
Food = "Grape Daifuku"
AutoItem = false
Random_Lockstyle = false
Lockstyle_List = {1,2,6,12}

state.OffenseMode:options('TP','DT','PDL','COUNTER','MEVA')
state.OffenseMode:set('DT')
state.WeaponMode:options('Verethragna','Godhands','Pole')
state.WeaponMode:set('Verethragna')

jobsetup (LockStylePallet,MacroBook,MacroSet)

send_command('bind ^numpad7 gs c WeaponMode Verethragna;')
send_command('bind ^numpad8 gs c WeaponMode Godhands;')
send_command('bind ^numpad9 gs c WeaponMode Pole;')

send_command('bind !F1 input /ja "Hundred Fists" <me>')
send_command('bind !F2 input /ja "Inner Strength" <me>')

if player.sub_job == 'WAR' then
	send_command('bind !t input /ja "Provoke" <t>')
end

function get_sets()

	sets.Weapons['Verethragna'] = {main="Verethragna"}
	sets.Weapons['Godhands'] = {main="Godhands"}
	sets.Weapons['Pole'] = {main="Malignance Pole", sub="Alber Strap",}

	sets.Weapons.Shield = {}
	sets.Weapons.Sleep = {}

	-- Idle sets
	sets.Idle = {
		ammo="Staunch Tathlum +1",
        head=gear.Malignance_Head,
        body="Adamantite Armor",
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        ear1="Sanare Earring",
        ear2="Eabani Earring",
        neck="Warder's Charm +1",
        ring1=gear.Chirich_1,
        ring2=gear.Gerubu_Or_Shadow,
        back="Null Shawl",
        waist="Moonbow Belt +1",
    }

	sets.Idle.TP = set_combine(sets.Idle, {})
	sets.Idle.DT = set_combine(sets.Idle, {})
	sets.Idle.PDL = set_combine(sets.Idle, {})
	sets.Idle.COUNTER = set_combine(sets.Idle, {})
	sets.Idle.MEVA = set_combine(sets.Idle, {
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
	})

	-- Engaged Sets
	sets.OffenseMode = {}
	sets.OffenseMode.TP = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
		feet="Anch. Gaiters +3",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2={ name="Schere Earring", augments={'Path: A',}},
		ring1="Lehko's Ring",
		ring2="Gere Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Magic dmg. taken-10%',}},
	}

	sets.OffenseMode.DT = set_combine(sets.OffenseMode.TP,{
		head={ name="Mpaca's Cap", augments={'Path: A',}},
		body={ name="Mpaca's Doublet", augments={'Path: A',}},
		hands={ name="Mpaca's Gloves", augments={'Path: A',}},
		legs="Bhikku Hose +3",
		feet={ name="Mpaca's Boots", augments={'Path: A',}},
	})

	sets.OffenseMode.PDL = set_combine(sets.OffenseMode.DT,{
	    ammo="Crepuscular Pebble",
		legs={ name="Mpaca's Hose", augments={'Path: A',}},
	})


	sets.OffenseMode.COUNTER = set_combine(sets.OffenseMode.DT, {

	})

	sets.OffenseMode.MEVA = set_combine(sets.OffenseMode.DT,{
		neck={ name="Warder's Charm +1", augments={'Path: A',}},
	})

	-- Augments the OffenseMode when in DT stance
	sets.Foot_Work = { feet=feet.MNK_Artifact, }

	--Used to swap into movement gear when the player is detected movement when not engaged
	if (item_available("Shneddick Ring +1")) then
        sets.Movement = { ring1="Shneddick Ring +1" }
    else
        sets.Movement = { feet="Hermes' Sandals" }
    end

	--Impetus set has priority over any other modes
	sets.Impetus = {
		body=body.MNK_Empyrean,
	}

	sets.Boost = {
		waist="Ask Sash",
	}

	-- Set to be used if you get cursed
	sets.Cursna_Received = {
	    neck="Nicander's Necklace",
        ring1="Eshmun's Ring",
        ring2="Purity Ring",
        waist="Gishdubar Sash",
	}

	sets.Enmity = {
	    ammo="Sapience Orb", -- 2
		head="Null Masque",
		neck="Moonlight Necklace", -- 15
		body="Emet Harness +1", -- 10
		hands="Kurys Gloves", -- 9
		legs="Bhikku Hose +3",
		feet="Ahosi Leggings", -- 7
		waist="Plat. Mog. Belt",
	    ear1="Cryptic Earring", -- 4
		ear2="Trux Earring", -- 5
		ring1="Eihwaz Ring", -- 5
		ring2="Petrov Ring", -- 4
	} -- 61

	-- Used for Magic Spells
	sets.Precast = {}
	sets.Precast.FastCast = {
		ammo="Sapience Orb", -- 2
		head=head.Herc_FC,
		body=body.Taeon_FC,
		hands="Leyline Gloves"
		legs="Rawhide Trousers", --5
		feet={ name="Herculean Boots", augments={'"Fast Cast"+6',}}, --6
		neck="Orunmila's Torque", --5
		waist=waist.PlatinumMoogle,
		ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
		ring1="Prolix Ring", --3
		ring2="Kishar Ring", --4
		back={ name="Segomo's Mantle", augments={'HP+60','HP+20','"Fast Cast"+10',}}, --10
	} -- FC 66

	--Base set for midcast - if not defined will notify and use your idle set for surviability
	sets.Midcast = set_combine(sets.Idle, {
	
	})

	sets.JA = {}
	sets.JA["Hundred Fists"] = {legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}}}
	sets.JA["Berserk"] = {}
	sets.JA["Warcry"] = {}
	sets.JA["Defender"] = {}
	sets.JA["Aggressor"] = {}
	sets.JA["Provoke"] = sets.Enmity
	sets.JA["Focus"] = {}
	sets.JA["Dodge"] = {}
	sets.JA["Chakra"] = {
		ammo="Iron Gobbet",
		head="Null Masque",
		body="Anch. Cyclas +3",
		hands={ name="Hes. Gloves +3", augments={'Enhances "Invigorate" effect',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		ear1="Tuisto Earring",
		ear2={ name="Odnowa Earring +1", augments={'Path: A',}},
		ring1="Regal Ring",
		ring2={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Magic dmg. taken-10%',}},
	}
	sets.JA["Boost"] = {}
	sets.JA["Counterstance"] = {}
	sets.JA["Chi Blast"] = {
		head={ name="Hes. Crown +3", augments={'Enhances "Penance" effect',}},
	}
	sets.JA["Mantra"] = {}
	sets.JA["Footwork"] = {}
	sets.JA["Perfect Counter"] = {}
	sets.JA["Impetus"] = {}
	sets.JA["Inner Strength"] = {}

	--Default WS set base
	sets.WS = { -- VS Base with Impetus Down
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2={ name="Schere Earring", augments={'Path: A',}},
		ring1="Niqmaddu Ring",
		ring2="Gere Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Damage taken-5%',}},
	}

	-- 35% SB I for MNK
	-- Belt SB II 15%
	-- Mpaca Legs -- SB II 5%
	-- Earring / Ring SB II 10%
	-- Need 4% SB
	sets.WS.SB = set_combine( sets.WS, { -- This maximize SB
		waist="Moonbow Belt +1", -- SB II 15
		ear1="Sherida Earring", -- SB II 5
		ring1="Niqmaddu Ring", -- SB II 5
		legs="Mpaca's Hose", -- SB II 5
		ammo="Coiste Bodhar", -- SB 3
		ear2={ name="Schere Earring", augments={'Path: A',}}, -- SB 3
	})

	sets.WS.MEVA = set_combine( sets.WS, { -- This maximize SB
		neck={ name="Warder's Charm +1", augments={'Path: A',}},
		ring1="Defending Ring",
	})

	--This set is used when OffenseMode is ACC and a WS is used (Augments the WS base set)
	sets.WS.ACC = set_combine(sets.WS,{})

	sets.WS.PDL = set_combine(sets.WS,{})

	sets.WS.Kicks = {
		ammo="Crepuscular Pebble",
		head="Mpaca's Cap",
		body="Ken. Samue +1",
		hands={ name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}},
		legs={ name="Hes. Hose +3", augments={'Enhances "Hundred Fists" effect',}},
		feet="Anch. Gaiters +3",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Odr Earring",
		--ring1="Niqmaddu Ring",
		ring2="Gere Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Damage taken-5%',}},
	}

	--WS Sets
	sets.WS["Combo"] = set_combine(sets.WS,{})
	sets.WS["Shoulder Tackle"] = set_combine(sets.WS,{})
	sets.WS["One Inch Punch"] = set_combine(sets.WS,{})
	sets.WS["Backhand Blow"] = set_combine(sets.WS,{})
	sets.WS["Raging Fists"] = set_combine(sets.WS,{
		neck="Mnk. Nodowa +2",
		feet="Ken. Sune-Ate +1",
	})
	sets.WS["Spinning Attack"] = set_combine(sets.WS,{})
	sets.WS["Howling Fist"] = set_combine(sets.WS,{
		neck="Mnk. Nodowa +2",
		feet="Ken. Sune-Ate +1",
	})
	sets.WS["Dragon Kick"] = sets.WS.Kicks
	sets.WS["Asuran Fists"] = set_combine(sets.WS,{})
	sets.WS["Tornado Kick"] = sets.WS.Kicks
	sets.WS["Victory Smite"] = set_combine(sets.WS,{})
	sets.WS["Shijin Spiral"] = set_combine(sets.WS,{
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Magic dmg. taken-10%',}},
	})

	sets.TreasureHunter = {
		ammo="Per. Lucky Egg",
		body="Volte Jupon",
		waist="Chaac Belt",
	}
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
	if spell.type == 'WeaponSkill' then
		if buffactive.Impetus then
			equipSet = sets.Impetus
		end	
	end
	return equipSet
end
-- Augment basic equipment sets
function midcast_custom(spell)
	local equipSet = {}

	return equipSet
end
-- Augment basic equipment sets
function aftercast_custom(spell)
	local equipSet = {}

	return choose_gear()
end

-- Called when the pet dies or is summoned
function pet_change_custom(pet,gain)
	local equipSet = {}

	return equipSet
end

-- Called during a pet midcast
function pet_midcast_custom(spell)
	local equipSet = {}

	return equipSet
end

-- Called after the performs an action
function pet_aftercast_custom(spell)
	local equipSet = {}

	return equipSet
end

--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	local equipSet = {}

	return choose_gear()
end

--This function is called when a update request the correct equipment set
function choose_set_custom()
	local equipSet = {}

	return choose_gear()
end

--Function is called when the player changes states
function status_change_custom(new,old)
	local equipSet = {}

	return choose_gear()
end

--Function is called when a self command is issued
function self_command_custom(command)

end

--Custom Function
function choose_gear()
	local equipSet = {}
	if player.status == "Engaged" then
		if buffactive['Impetus'] then
			equipSet = sets.Impetus
		end	
		if buffactive['Footwork'] then
			equipSet = set_combine(equipSet, sets.Foot_Work)
		end	
	end
	if buffactive['Boost'] then
		equipSet = set_combine(equipSet, sets.Boost)
	end
	return equipSet
end

function check_buff_JA()
	local buff = 'None'
	local ja_recasts = windower.ffxi.get_ability_recasts()

	-- Sub job has least priority
	if player.sub_job == 'WAR' then
		if not buffactive['Berserk'] and ja_recasts[1] == 0 then
			buff = "Berserk"
		elseif not buffactive['Aggressor'] and ja_recasts[4] == 0 then
			buff = "Aggressor"
		elseif not buffactive['Warcry'] and ja_recasts[2] == 0 then
			buff = "Warcry"
		end
	end

	-- Mantra Max priority
	if player.hpp < 51 and ja_recasts[15] == 0 then
		buff = "Chakra"
	elseif not buffactive.Impetus and ja_recasts[31] == 0 then
		buff = "Impetus"
	elseif not buffactive.Footwork and ja_recasts[21] == 0 then
		buff = "Footwork"
	elseif not buffactive.Mantra and ja_recasts[19] == 0 then
		buff = "Mantra"
	elseif not buffactive.Dodge and ja_recasts[14] == 0 then
		buff = "Dodge"
	elseif not buffactive.Focus and ja_recasts[13] == 0 then
		buff = "Focus"
	end

	return buff
end

function check_buff_SP()
	local buff = 'None'
	--local sp_recasts = windower.ffxi.get_spell_recasts()
	return buff
end

-- This function is called when the job file is unloaded
function user_file_unload()

end