-- Load and initialize the include file.
include('Kaius-Include')
include('gear/gear')
include('Global-Binds.lua')

LockStylePallet = "12"
MacroBook = "12"
MacroSet = "1"
Food = "Grape Daifuki"
AutoItem = false
Random_Lockstyle = false
Lockstyle_List = {1,2,6,12}
Elemental_WS = S{'Aeolian Edge', 'Seraph Blade', 'Shining Blade','Red Lotus Blade', 'Burning Blade', 'Sanguine Blade', 'Energy Drain','Energy Steal','Cyclone','Gust Slash'}

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
		head=head.SAM_Artifact,
        body="Sacro Breastplate",
        hands=hands.Mpaca,
        legs=legs.Mpaca,
        feet=feet.Mpaca,
        neck="Warder's Charm +1",
        waist="Platinum Moogle Belt",
        ear1="Sanare Earring",
        ear2="Eabani Earring",
        ring1=ring.Chirich_1,
        ring2=ring.Chirich_2,
        back=back.SAM_TP,
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
        head=head.SAM_Empyrean,
        body=body.SAM_Empyrean,
        hands=hands.Tatenashi,
        legs=legs.SAM_Empyrean,
        feet=feet.Ryuo_C,
        neck="Samurai's Nodowa +2",
        waist="Sweordfaetels +1",
        ear1="Dedition Earring",
        ear2="Kasuga Earring +2",
        ring1=ring.Chirich_1,
        ring2="Niqmaddu Ring",
        back=back.SAM_STP,
	}

	sets.OffenseMode.TP = set_combine (sets.OffenseMode, {})

	--This set is used when OffenseMode is DT and Enaged (Augments the TP base set)
	sets.OffenseMode.DT = set_combine (sets.OffenseMode, {
        hands=hands.Nyame,
        feet=feet.Nyame,
        back="Null Shawl",
        waist="Sailfi Belt +1",
	})


	--This set is used when OffenseMode is ACC and Enaged (Augments the TP base set)
	sets.OffenseMode.SUB = set_combine (sets.OffenseMode, {
		ammo="Aurgelmir Orb +1",
        head=head.SAM_Empyrean,
        body="Dagon Breastplate", --(10)
        hands=hands.SAM_Artifact,
        legs=legs.Mpaca, --(5)
        feet=feet.Ryuo_C, --8
        neck="Samurai's Nodowa +2",
        ear1="Dedition Earring", --3
        ear2="Telos Earring", --5
        ring1=ring.Chirich_1, --10
        ring2="Niqmaddu Ring", --(5)
        waist="Sailfi Belt +1",
        back=back.SAM_TP,
	})

	sets.OffenseMode.PDL = set_combine(sets.OffenseMode.TP, {});

	sets.OffenseMode.MEVA = set_combine(sets.OffenseMode.DT, {
	    hands=hands.Nyame,
        feet=feet.Nyame,
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
	sets.JA["Meikyo Shisui"] = {feet=feet.SAM_Relic}
	sets.JA["Berserk"] = {}
	sets.JA["Warcry"] = {}
	sets.JA["Defender"] = {}
	sets.JA["Aggressor"] = {}
	sets.JA["Provoke"] = sets.Enmity
	sets.JA["Third Eye"] = {legs=legs.SAM_Relic}
	sets.JA["Meditate"] = {head=head.SAM_Artifact, hands=hands.SAM_Relic, back=back.SAM_TP}
	sets.JA["Warding Circle"] = {head=head.SAM_Artifact}
	sets.JA["Shikikoyo"] = {}
	sets.JA["Hasso"] = {}
	sets.JA["Seigan"] = {}
	sets.JA["Sengikori"] = {feet=feet.SAM_Empyrean,}
	sets.JA["Sekkanoki"] = {hands=hands.SAM_Empyrean,}
	sets.JA["Hamanoha"] = {}
	sets.JA["Hagakure"] = {}
	sets.JA["Konzen-ittai"] = {}
	sets.JA["Yaegasumi"] = {}

	--Default Weapon Skill set base
	sets.WS = {
		ammo="Knobkierrie",
        head=head.Mpaca,
        body=body.SAM_Empyrean,
        hands=hands.SAM_Empyrean,
        legs=legs.Nyame,
        feet=feet.Nyame, 
        neck="Samurai's Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Moonshade Earring",
        ear2="Kasuga Earring +2",
        ring1="Regal Ring",
        ring2=ring.Cornelia_Or_Epaminondas,
        back=back.SAM_WS,
	}

    sets.WS.PDL = {
        ring2=ring.Ephramad_Or_Sroda,
        feet=feet.SAM_Empyrean,
    }

	sets.WS.AM3 = {}
	sets.WS.AM3['Masamune'] = {}

	sets.WS.MAB = set_combine(sets.WS, {		
		ammo="Knobkierrie",
        head=head.Nyame,
        body=body.Nyame,
        hands=hands.Nyame,
        legs=legs.Nyame,
        feet=feet.Nyame,
        neck="Sibyl Scarf",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1=ring.Cornelia_Or_Regal,
        ring2="Epaminondas's Ring",
        back=back.SAM_WS,
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
        head=head.Nyame,
        body=body.Nyame,
        hands=hands.Nyame,
        legs=legs.Nyame,
        feet=feet.Nyame,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Schere Earring",
        ring1=ring.Cornelia_Or_Epaminondas,
        ring2="Niqmaddu Ring",
        back=back.SAM_WS,
        waist="Orpheus's Sash",
    }
    sets.WS["Tachi: Jinpu"].PDL = set_combine(sets.WS["Tachi: Jinpu"], {
        neck="Samurai's Nodowa +2",
    })

	sets.WS["Tachi: Goten"] = set_combine (sets.WS, {})

	sets.WS["Tachi: Kagero"] = {
        ammo="Knobkierrie",
        head=head.Nyame,
        body=body.Nyame,
        hands=hands.Nyame,
        legs=legs.Nyame,
        feet=feet.Nyame,
        neck="Sibyl Scarf",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1=ring.Cornelia_Or_Regal,
        ring2="Epaminondas's Ring",
        back=back.SAM_WS,
        waist="Orpheus's Sash",
    }

	sets.WS["Tachi: Koki"] = {
         ammo="Knobkierrie",
        head=head.Nyame,
        body=body.Nyame,
        hands=hands.Nyame,
        legs=legs.Nyame,
        feet=feet.Nyame,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Schere Earring",
        -- ring="Weatherspoon Ring +1",
        ring1=ring.Cornelia_Or_Epaminondas,
        ring2="Niqmaddu Ring",
        back=back.SAM_WS,
        waist="Fotia Belt",
    }

	sets.WS["Tachi: Yukikaze"] = set_combine (sets.WS, {})
	sets.WS["Tachi: Gekko"] = set_combine (sets.WS, {})
	sets.WS["Tachi: Kasha"] = set_combine (sets.WS, {})

	sets.WS["Tachi: Rana"] = {
         ammo="Coiste Bodhar",
        head=head.Mpaca,
        body=body.Relic,
        hands=hands.Empyrean, 
        legs=legs.Nyame, 
        feet=feet.Mpaca,
        neck="Samurai's Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Lugra Earring +1",
        ear2="Schere Earring",
        ring1="Regal Ring", 
        ring2="Niqmaddu Ring",
        back=back.SAM_WS,
    }

    sets.WS["Tachi: Rana"].PDL = set_combine(sets.WS["Tachi: Rana"], {
        ammo="Crepuscular Pebble",
        legs=legs.Mpaca,
        ring1=ring.Ephramad_Or_Sroda,
        feet=feet.Empyrean,
    })

	sets.WS["Tachi: Ageha"] = {
        ammo="Pemphredo Tathlum",
        head=head.Empyrean,
        body=body.Empyrean,
        hands=hands.Empyrean,
        legs=legs.Empyrean,
        feet=feet.Empyrean,
        neck="Null Loop",
        ear1="Crepuscular Earring",
        ear2="Kasuga Earring +2",
        ring1=ring.Stikini_1,
        ring2="Metamorph Ring +1",
        back=back.SAM_WS,
        waist="Null Belt",
    }

	sets.WS["Tachi: Fudo"] = {
        ammo="Knobkierrie",
        head=head.Mpaca,
        body=body.Nyame,
        hands=hands.SAM_Empyrean, 
        legs=legs.Nyame, 
        feet=feet.Nyame,
        neck="Samurai's Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Moonshade Earring",
        ear2="Kasuga Earring +2",
        ring1=ring.Cornelia_Or_Epaminondas,
        ring2="Niqmaddu Ring", 
        back=back.SAM_WS,
    }

    sets.WS["Tachi: Fudo"].PDL = set_combine(sets.WS["Tachi: Fudo"], {
        ring2=ring.Ephramad_Or_Sroda,
        feet=feet.SAM_Empyrean,
    })

	sets.WS["Tachi: Shoha"] = {
        ammo="Knobkierrie",
        head=head.Mpaca,
        body=body.Nyame,
        hands=hands.Empyrean, 
        legs=legs.Mpaca, 
        feet=feet.Empyrean,
        neck="Samurai's Nodowa +2",
        waist="Sailfi Belt +1",
        ear1="Moonshade Earring",
        ear2="Kasuga Earring +2",
        ring1=ring.Cornelia_Or_Sroda,
        ring2="Epaminondas's Ring",
        back=back.SAM_WS,
    }

	sets.WS["Impulse Drive"] = {
        ammo="Knobkierrie",
        head=head.Mpaca,
        body=body.Nyame,
        hands=hands.Empyrean,
        legs=legs.Nyame,
        feet=feet.Nyame,
        neck="Samurai's Nodowa +2",
        ear1="Moonshade Earring",
        ear2="Kasuga Earring +2",
        ring1="Begrudging Ring",
        ring2="Niqmaddu Ring",
        back=back.SAM_WS,
        waist="Sailfi Belt +1",
    }

    sets.WS["Impulse Drive"].PDL = set_combine(sets.WS["Impulse Drive"], {
        legs=legs.Mpaca,
        feet=feet.Empyrean,
        ring1=ring.Ephramad_Or_Sroda,
    })

    sets.WS["Stardiver"] = {
        ammo="Coiste Bodhar", --6
        head=head.Mpaca,
        body=body.Mpaca,
        hands=hands.Empyrean,
        legs=legs.Mpaca,
        feet=feet.Mpaca,
        neck="Fotia Gorget",
        ear1="Schere Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Niqmaddu Ring",
        back=back.SAM_WS,
        waist="Fotia Belt",
    }

    sets.WS["Sonic Thrust"] = sets.WS["Tachi: Fudo"]
    sets.WS['Sonic Thrust'].PDL = sets.WS['Tachi: Fudo'].PDL

	--Custome sets for each jobsetup
	sets.Seigan = {
		head=head.SAM_Empyrean,
		body=body.SAM_Empyrean,
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

