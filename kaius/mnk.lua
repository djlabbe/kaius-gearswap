
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
        head=head.Malignance,
        body="Adamantite Armor",
        hands=hands.Malignance,
        legs=legs.Malignance,
        feet=feet.Malignance,
        ear1="Sanare Earring",
        ear2="Eabani Earring",
        neck="Warder's Charm +1",
        ring1=ring.Chirich_1,
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
	})

	-- Engaged Sets
	sets.OffenseMode = {}
	sets.OffenseMode.TP = {
		ammo="Coiste Bodhar",
		head=head.Malignance,
		body=body.Mpaca,
		hands=hands.Adhemar_A,
		legs=legs.MNK_Empyrean,
		feet=feet.MNK_Empyrean,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
        ear1="Sherida Earring",
		ear2="Schere Earring",
		ring1=ring.Lehko_Or_Gere,
		ring2="Niqmaddu Ring",
		back=back.MNK_DEX_DA,
	}

	sets.OffenseMode.DT = set_combine(sets.OffenseMode.TP,{
		head=head.Malignance,
        hands=hands.Malignance,
        legs=legs.MNK_Empyrean,
        feet=feet.MNK_Empyrean,
	})

	sets.OffenseMode.PDL = set_combine(sets.OffenseMode.DT,{})

	sets.OffenseMode.COUNTER = set_combine(sets.OffenseMode.DT, {
		head=head.MNK_Empyrean,
		body=body.Mpaca,
		hands=hands.Malignance,
		legs=legs.MNK_Empyrean,
		feet=feet.MNK_Empyrean,
		neck="Bathy Choker +1",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Bhikku Earring +1",
		ring1="Defending Ring",
		ring2="Niqmaddu Ring",
		back=back.MNK_DEX_DA
	})

	sets.OffenseMode.MEVA = set_combine(sets.OffenseMode.DT,{
		neck="Warder's Charm +1",
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
		legs=legs.MNK_Empyrean,
		-- feet="Ahosi Leggings", -- 7
		waist=waist.PlatinumMoogle,
	    ear1="Cryptic Earring", -- 4
		ear2="Trux Earring", -- 5
		ring1="Eihwaz Ring", -- 5
		ring2="Petrov Ring", -- 4
	} -- 61

	-- Used for Magic Spells
	sets.Precast = {}
	sets.Precast.FastCast = {
		ammo="Sapience Orb", -- 2
		head=head.Herc_FC, --13
        body=body.Taeon_FC, --9
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
		feet={ name="Herculean Boots", augments={'"Fast Cast"+6',}}, --6
		neck="Orunmila's Torque", --5
		waist=waist.PlatinumMoogle,
		ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
		ring1="Prolix Ring", --3
		ring2="Kishar Ring", --4
		back=back.MNK_FC, --10
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
		 ammo="Aurgelmir Orb +1",
        head=head.Nyame,
        neck="Unmoving Collar +1",
        ear1="Handler's Earring +1",
        ear2="Tuisto Earring",
        body=body.MNK_Artifact,
        hands=hands.Relic,
        ring1="Niqmaddu Ring",
        ring2="Gelatinous Ring +1",
        back="Moonlight Cape",
        waist="Platinum Moogle Belt",
        legs=legs.Nyame,
        feet=feet.MNK_Empyrean
	}

	sets.JA["Boost"] = {}
	sets.JA["Counterstance"] = {}
	sets.JA["Chi Blast"] = {head=head.MNK_Relic}
	sets.JA["Mantra"] = {}
	sets.JA["Footwork"] = {}
	sets.JA["Perfect Counter"] = {}
	sets.JA["Impetus"] = {}
	sets.JA["Inner Strength"] = {}

	--Default WS set base
	sets.WS = { -- VS Base with Impetus Down
		ammo="Knobkierrie",
		head=head.Mpaca,
		body=body.Nyame,
		hands=hands.MNK_Empyrean,
		legs=legs.Mpaca,
		feet=feet.Mpaca,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Odr Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=back.MNK_DEX_DA,
	}


	sets.WS.MEVA = set_combine( sets.WS, {
		neck="Warder's Charm +1",
	})


	sets.WS.PDL = set_combine(sets.WS,{
		--TODO
	})


	--WS Sets
	sets.WS["Combo"] = set_combine(sets.WS,{})
	sets.WS["Shoulder Tackle"] = set_combine(sets.WS,{})
	sets.WS["One Inch Punch"] = set_combine(sets.WS,{})
	sets.WS["Backhand Blow"] = set_combine(sets.WS,{})

	sets.WS["Raging Fists"] = {
		ammo="Knobkierrie",
		head=head.Mpaca,
		body=body.Mpaca,
		hands=hands.Tatenashi,
		legs=legs.Nyame,
		feet=feet.MNK_Artifact,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Moonshade Earring",
		ear2="Schere Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=back.MNK_DEX_DA,
	}

	sets.WS["Spinning Attack"] = set_combine(sets.WS,{})

	sets.WS["Final Heaven"] = {
		ammo="Knobkierrie",
		head=head.Mpaca,
		body=body.MNK_Empyrean,
		hands=hands.Tatenashi,
		legs=legs.Nyame,
		feet=feet.Nyame,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Ishvara Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=back.MNK_DEX_DA,
	}

	sets.WS["Howling Fist"] =  {
		ammo="Knobkierrie",
		head=head.Mpaca,
		body=body.Nyame,
		hands=hands.Tatenashi,
		legs=legs.Nyame,
		feet=feet.Nyame,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Moonshade Earring",
		ear2="Schere Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=back.MNK_DEX_DA,
	}

	sets.WS["Dragon Kick"] = {
		ammo="Knobkierrie",
		head=head.Mpaca,
		body=body.Nyame,
		hands=hands.Nyame,
		legs=legs.Nyame,
		feet=feet.MNK_Artifact,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Moonshade Earring",
		ear2="Schere Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=back.MNK_DEX_DA,
	}

	sets.WS["Asuran Fists"] = set_combine(sets.WS,{})

	sets.WS["Tornado Kick"] = {
		ammo="Coiste Bodhar",
		head=head.Mpaca,
		body=body.Nyame,
		hands=hands.Nyame,
		legs=legs.Nyame,
		feet=feet.MNK_Artifact,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Moonshade Earring",
		ear2="Schere Earring",
		ring1=ring.Cornelia_Or_Gere,
		ring2="Niqmaddu Ring",
		back=back.MNK_DEX_DA,
	}

	sets.WS["Victory Smite"] = {
		ammo="Coiste Bodhar",
		head=head.Mpaca,
		body=body.MNK_Empyrean,
		hands=hands.MNK_Empyrean,
		legs=legs.Mpaca,
		feet=feet.Mpaca,
		neck="Monk's Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Schere Earring",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=back.MNK_STR_CRIT,
	}

	sets.WS["Shijin Spiral"] = {
		 ammo="Knobkierrie",
		head=head.Nyame,
		body=body.Nyame,
		hands=hands.Malignance,
		legs=legs.Nyame,
		feet=feet.Malignance,
		neck="Mnk. Nodowa +2",
		waist="Moonbow Belt +1",
		ear1="Sherida Earring",
		ear2="Mache Earring +1",
		ring1="Gere Ring",
		ring2="Niqmaddu Ring",
		back=back.MNK_DEX_DA,
	}

	 sets.WS['Shell Crusher'] = {
        head=head.Malignance,
        neck="Moonlight Necklace",
        ear1="Crepuscular Earring",
        ear2="Bhikku Earring +1",
        body=body.Malignance,
        hands=hands.Malignance,
        legs=legs.Malignance,
        feet=feet.Malignance,
        ring1=ring.Stikini_1,
        ring2="Metamorph Ring +1",
        back=back.MNK_STR_CRIT,
        waist="Acuity Belt +1",
    }

    sets.WS['Cataclysm'] = {
        head="Pixie Hairpin +1",
        neck="Sibyl Scarf",
        ear1="Friomisi Earring",
        ear2="Moonshade Earring",
        body=body.Nyame,
        hands=hands.Nyame,
        legs=legs.Nyame,
        feet=feet.Nyame,
        ring1="Archon Ring",
        ring2="Metamorph Ring +1",
        back=back.MNK_STR_CRIT,
        waist="Orpheus's Sash",
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