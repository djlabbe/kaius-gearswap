-- Load and initialize the include file.
include('Kaius-Include')
include('Global-Binds.lua')

LockStylePallet = "12"
MacroBook = "12"
MacroSet = "1"
Food = "Grape Daifuki"
AutoItem = false
Random_Lockstyle = false
Lockstyle_List = {1,2,6,12}

state.OffenseMode:options('TP','DT','PDL','SUB','MEVA')
state.OffenseMode:set('TP')

state.WeaponMode:options('Masamune', 'Dojikiri', 'Shining One')
state.WeaponMode:set('Masamune')

jobsetup (LockStylePallet,MacroBook,MacroSet)

send_command('bind ^numpad7 gs c WeaponMode Masamune;')
send_command('bind ^numpad8 gs c WeaponMode Dojikiri;')
send_command('bind ^numpad9 gs c WeaponMode Shining One;')

send_command('bind !F1 input /ja "Meikyo Shisui" <me>')
send_command('bind !F2 input /ja "Yaegasumi" <me>')
send_command('bind !` input /ja "Hasso" <me>')
send_command('bind ^` input /ja "Seigan" <me>')
send_command('bind !c input /ja "Warding Circle" <me>')
send_command('bind !a input /ja "Hamanoha" <me>')

if player.sub_job == 'WAR' then
    send_command('bind !t input /ja "Provoke" <t>')
end


function get_sets()
	sets.Weapons['Dojikiri'] = {main="Dojikiri Yasutsuna", sub="Utu Grip"}
	sets.Weapons['Masamune'] = {main="Masamune", sub="Utu Grip"}
	sets.Weapons['Shining One'] = {main="Shining One", sub="Utu Grip"}

	-- Standard Idle set with -DT, Refresh and Regen gear
	sets.Idle = {
		head="Wakido Kabuto +3",
        body="Sacro Breastplate",
        hands={name="Mpaca's Gloves", priority=61},
        legs={name="Mpaca's Hose", priority=72},
        feet={name="Mpaca's Boots", priority=50},
        neck="Warder's Charm +1",
        waist="Platinum Moogle Belt",
        ear1="Sanare Earring",
        ear2="Eabani Earring",
        ring1={name="Chirich Ring +1", bag="wardrobe7"},
        ring2={name="Chirich Ring +1", bag="wardrobe8"},
        back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
    }

	sets.Idle.TP = set_combine(sets.Idle, {})
	sets.Idle.DT = set_combine(sets.Idle, {})
	sets.Idle.PDL = set_combine(sets.Idle, {})
	sets.Idle.SUB = set_combine(sets.Idle, {})
	sets.Idle.MEVA = set_combine(sets.Idle, {})

	if (item_available("Shneddick Ring +1")) then
        sets.Movement = { ring1="Shneddick Ring +1" }
    else
        sets.Movement = { feet="Danzo Sune-Ate" }
    end

	sets.Cursna_Received = {
	    neck="Nicander's Necklace",
        ring1="Eshmun's Ring", 
        ring2="Purity Ring",
        waist="Gishdubar Sash",
	}

	--Base TP set to build off
	sets.OffenseMode = {
		ammo="Aurgelmir Orb +1",
        head="Kasuga Kabuto +3",
        body="Kasuga Domaru +3",
        hands="Tatenashi Gote +1",
        legs="Takaha Mantle",
        feet={name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
        neck="Samurai's Nodowa +2",
        waist="Sweordfaetels +1",
        ear1="Dedition Earring",
        ear2="Kasuga Earring +2",
        ring1={name="Chirich Ring +1", bag="wardrobe7"},
        ring2="Niqmaddu Ring",
        back="Takaha Mantle",
	}

	sets.OffenseMode.TP = set_combine (sets.OffenseMode, {})

	--This set is used when OffenseMode is DT and Enaged (Augments the TP base set)
	sets.OffenseMode.DT = set_combine (sets.OffenseMode, {
        hands="Nyame Gauntlets",
        feet="Nyame Sollerets",
        back="Null Shawl",
        waist="Sailfi Belt +1",
	})


	--This set is used when OffenseMode is ACC and Enaged (Augments the TP base set)
	sets.OffenseMode.SUB = set_combine (sets.OffenseMode, {
		ammo="Aurgelmir Orb +1",
        head="Kasuga Kabuto +3",
        body="Dagon Breastplate", --(10)
        hands="Wakido Kote +3",
        legs={name="Mpaca's Hose", priority=72}, --(5)
        feet={name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}, --8
        neck="Samurai's Nodowa +2",
        ear1="Dedition Earring", --3
        ear2="Telos Earring", --5
        ring1={name="Chirich Ring +1", bag="wardrobe7"}, --10
        ring2="Niqmaddu Ring", --(5)
        waist="Sailfi Belt +1",
        back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	})

	sets.OffenseMode.PDL = set_combine(sets.OffenseMode.TP, {});

	sets.OffenseMode.MEVA = set_combine(sets.OffenseMode.DT, {
	    hands="Nyame Gauntlets",
        feet="Nyame Sollerets",
        back="Null Shawl",
        waist="Sailfi Belt +1",
	});

	-- Used for Magic Spells (Fast Cast)
	sets.Precast.FastCast = {
		body="Sacro Breastplate",
        hands="Leyline Gloves",
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Etiolation Earring", --2
        ring2="Prolix Ring", --2
	}

	sets.Enmity = {
	    left_ear="Cryptic Earring", -- 4
		ear2="Friomisi Earring", --2
		ring1="Petrov Ring", -- 4
	}

	--Base set for midcast - if not defined will notify and use your idle set for surviability
	sets.Midcast = set_combine(sets.Idle, {})

	--Job Abilities
	sets.JA["Meikyo Shisui"] = {feet="Sakonji Sune-Ate +3"}
	sets.JA["Berserk"] = {}
	sets.JA["Warcry"] = {}
	sets.JA["Defender"] = {}
	sets.JA["Aggressor"] = {}
	sets.JA["Provoke"] = sets.Enmity
	sets.JA["Third Eye"] = {legs="Sakonji Haidate +3"}

	sets.JA["Meditate"] = {
        head="Wakido Kabuto +3", 
        hands="Sakonji Kote +3", 
        back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}}
    }

	sets.JA["Warding Circle"] = {head="Wakido Kabuto +3"}
	sets.JA["Shikikoyo"] = {}
	sets.JA["Hasso"] = {}
	sets.JA["Seigan"] = {}
	sets.JA["Sengikori"] = {feet="Kasuga Sune-Ate +3",}
	sets.JA["Sekkanoki"] = {hands="Kasuga Kote +3",}
	sets.JA["Hamanoha"] = {}
	sets.JA["Hagakure"] = {}
	sets.JA["Konzen-ittai"] = {}
	sets.JA["Yaegasumi"] = {}

	--Default Weapon Skill set base
	sets.WS = {
		ammo="Knobkierrie",
        head="Mpaca's Cap",
        body="Kasuga Domaru +3",
        hands="Kasuga Kote +3",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets", 
        neck="Samurai's Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Moonshade Earring",
        ear2="Kasuga Earring +2",
        ring1="Regal Ring",
        ring2=gear.Cornelia_Or_Epaminondas,
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}

    sets.WS.PDL = {
        ring2=gear.Ephramad_Or_Sroda,
        feet="Kasuga Sune-Ate +3",
    }

	sets.WS.AM3 = {}
	sets.WS.AM3['Masamune'] = {}

	sets.WS.MAB = set_combine(sets.WS, {		
		ammo="Knobkierrie",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Sibyl Scarf",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1=gear.Cornelia_Or_Regal,
        ring2="Epaminondas's Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        waist="Orpheus's Sash",
	})

	sets.WS.CRIT = set_combine(sets.WS,{
		ear2="Schere Earring",
	    ammo="Coiste Bodhar",
	})

	sets.WS.MEVA = set_combine(sets.WS, {})

	--WS Sets
	sets.WS["Tachi: Enpi"] = set_combine (sets.WS, {})
	sets.WS["Tachi: Hobaku"] = set_combine (sets.WS, {})

	sets.WS["Tachi: Jinpu"] = {
        ammo="Knobkierrie",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Schere Earring",
        ring1=gear.Cornelia_Or_Epaminondas,
        ring2="Niqmaddu Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        waist="Orpheus's Sash",
    }
    sets.WS["Tachi: Jinpu"].PDL = set_combine(sets.WS["Tachi: Jinpu"], {
        neck="Samurai's Nodowa +2",
    })

	sets.WS["Tachi: Goten"] = set_combine (sets.WS, {})

	sets.WS["Tachi: Kagero"] = {
        ammo="Knobkierrie",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Sibyl Scarf",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1=gear.Cornelia_Or_Regal,
        ring2="Epaminondas's Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        waist="Orpheus's Sash",
    }

	sets.WS["Tachi: Koki"] = {
        ammo="Knobkierrie",
        head="Nyame Helm",
        body="Nyame Mail",
        hands="Nyame Gauntlets",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Schere Earring",
        -- ring="Weatherspoon Ring +1",
        ring1=gear.Cornelia_Or_Epaminondas,
        ring2="Niqmaddu Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        waist="Fotia Belt",
    }

	sets.WS["Tachi: Yukikaze"] = set_combine (sets.WS, {})
	sets.WS["Tachi: Gekko"] = set_combine (sets.WS, {})
	sets.WS["Tachi: Kasha"] = set_combine (sets.WS, {})

	sets.WS["Tachi: Rana"] = {
        ammo="Coiste Bodhar",
        head="Mpaca's Cap",
        body="Sakonji Domaru +3",
        hands="Kasuga Kote +3", 
        legs="Nyame Flanchard", 
        feet={name="Mpaca's Boots", priority=50},
        neck="Samurai's Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Lugra Earring +1",
        ear2="Schere Earring",
        ring1="Regal Ring", 
        ring2="Niqmaddu Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    }

    sets.WS["Tachi: Rana"].PDL = set_combine(sets.WS["Tachi: Rana"], {
        ammo="Crepuscular Pebble",
        legs={name="Mpaca's Hose", priority=72},
        ring1=gear.Ephramad_Or_Sroda,
        feet="Kasuga Sune-Ate +3",
    })

	sets.WS["Tachi: Ageha"] = {
        ammo="Pemphredo Tathlum",
        head="Kasuga Kabuto +3",
        body="Kasuga Domaru +3",
        hands="Kasuga Kote +3",
        legs="Takaha Mantle",
        feet="Kasuga Sune-Ate +3",
        neck="Null Loop",
        ear1="Crepuscular Earring",
        ear2="Kasuga Earring +2",
        ring1={name="Stikini Ring +1", bag="wardrobe7"},
        ring2="Metamorph Ring +1",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        waist="Null Belt",
    }

	sets.WS["Tachi: Fudo"] = {
        ammo="Knobkierrie",
        head="Mpaca's Cap",
        body="Nyame Mail",
        hands="Kasuga Kote +3", 
        legs="Nyame Flanchard", 
        feet="Nyame Sollerets",
        neck="Samurai's Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Moonshade Earring",
        ear2="Kasuga Earring +2",
        ring1=gear.Cornelia_Or_Epaminondas,
        ring2="Niqmaddu Ring", 
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    }

    sets.WS["Tachi: Fudo"].PDL = set_combine(sets.WS["Tachi: Fudo"], {
        ring2=gear.Ephramad_Or_Sroda,
        feet="Kasuga Sune-Ate +3",
    })

	sets.WS["Tachi: Shoha"] = {
        ammo="Knobkierrie",
        head="Mpaca's Cap",
        body="Nyame Mail",
        hands="Kasuga Kote +3", 
        legs={name="Mpaca's Hose", priority=72}, 
        feet="Kasuga Sune-Ate +3",
        neck="Samurai's Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Moonshade Earring",
        ear2="Kasuga Earring +2",
        ring1=gear.Cornelia_Or_Sroda,
        ring2="Epaminondas's Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    }

	sets.WS["Impulse Drive"] = {
        ammo="Knobkierrie",
        head="Mpaca's Cap",
        body="Nyame Mail",
        hands="Kasuga Kote +3",
        legs="Nyame Flanchard",
        feet="Nyame Sollerets",
        neck="Samurai's Nodowa +2",
        ear1="Moonshade Earring",
        ear2="Kasuga Earring +2",
        ring1="Begrudging Ring",
        ring2="Niqmaddu Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        waist="Sailfi Belt +1",
    }

    sets.WS["Impulse Drive"].PDL = set_combine(sets.WS["Impulse Drive"], {
        legs={name="Mpaca's Hose", priority=72},
        feet="Kasuga Sune-Ate +3",
        ring1=gear.Ephramad_Or_Sroda,
    })

    sets.WS["Stardiver"] = {
        ammo="Coiste Bodhar", --6
        head="Mpaca's Cap",
        body="Mpaca's Doublet",
        hands="Kasuga Kote +3",
        legs={name="Mpaca's Hose", priority=72},
        feet={name="Mpaca's Boots", priority=50},
        neck="Fotia Gorget",
        ear1="Schere Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Niqmaddu Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
        waist="Fotia Belt",
    }

    sets.WS["Sonic Thrust"] = sets.WS["Tachi: Fudo"]
    sets.WS['Sonic Thrust'].PDL = sets.WS['Tachi: Fudo'].PDL

	--Custome sets for each jobsetup
	sets.Seigan = {
		head="Kasuga Kabuto +3",
		body="Kasuga Domaru +3",
	}

	sets.ThirdEye = {}
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

	return equipSet
end

-- Augment basic equipment sets
function aftercast_custom(spell)
	local equipSet = choose_Seigan()
	return equipSet
end

--Function is called when the player gains or loses a buff
function buff_change_custom(name,gain)
	local equipSet = choose_Seigan()
	return equipSet
end

--This function is called when a update request the correct equipment set
function choose_set_custom()
	local equipSet = choose_Seigan()
	return equipSet
end

--Function is called when the player changes states
function status_change_custom(new,old)
	local equipSet = choose_Seigan()
	return equipSet
end

--Function is called when a self command is issued
function self_command_custom(cmd)
    local command = cmd:lower()
	if command:contains('weaponmode') then
        if player.sub_job == 'DRG' then
            if state.WeaponMode.value == 'Masamune' then
                send_command('input /macro set 1')
            elseif state.WeaponMode.value == 'Dojikiri' then
                send_command('input /macro set 1')
            elseif state.WeaponMode.value == 'Shining One' then
                send_command('input /macro set 2')
            end
        elseif player.sub_job == 'WAR' then
            if state.WeaponMode.value == 'Masamune' then
                send_command('input /macro set 3')
            elseif state.WeaponMode.value == 'Dojikiri' then
                send_command('input /macro set 3')
            elseif state.WeaponMode.value == 'Shining One' then
                send_command('input /macro set 4')
            end
        end
    end
end

--Custom Function
function choose_Seigan()
	local equipSet = {}
		if player.status == "Engaged" then
			if buffactive.Seigan then
				--Equip the Seigan custom set when active
				equipSet = sets.Seigan
				if buffactive["Third Eye"] then
					--Equip the Third Eye custom set when active
					equipSet = set_combine(equipSet, sets.ThirdEye)
				end
			end
		end
	return equipSet
end

--Function used to automate Job Ability use
function check_buff_JA()
	local buff = 'None'
	local ja_recasts = windower.ffxi.get_ability_recasts()

	if not buffactive['Hasso'] and not buffactive['Seigan'] and ja_recasts[138] == 0 then
		buff = "Hasso"
	end

	if player.sub_job == 'WAR' and player.sub_job_level == 49 then
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
	local buff = 'None'
	--local sp_recasts = windower.ffxi.get_spell_recasts()
	return buff
end


-- This function is called when the job file is unloaded
function user_file_unload()
    send_command('unbind !F1')
    send_command('unbind !F2')
    send_command('unbind !`')
    send_command('unbind ^`')
    send_command('unbind !t')
    send_command('unbind !c')
    send_command('unbind !a')
    unbind_numpad()
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

