-- Load and initialize the include file.
include('Kaius-Include')
include('gear/Gear')

--Set to ingame lockstyle and Macro Book/Set
LockStylePallet = "3"
MacroBook = "3"
MacroSet = "1"

-- Use "gs c food" to use the specified food item 
Food = "Miso Ramen"

--Uses Items Automatically
AutoItem = false

--Upon Job change will use a random lockstyleset
Random_Lockstyle = false

--Lockstyle sets to randomly equip
Lockstyle_List = {1,2,6,12}

-- 'TP','ACC','DT' are standard Default modes.  You may add more and assigne equipsets for them ( Idle.X and OffenseMode.X )
state.OffenseMode:options('TP','ACC','DT','PDT','MEVA')
state.OffenseMode:set('DT')

-- Set to true to run organizer on job changes
Organizer = false

--Weapons options
state.WeaponMode:options('Black Halo','Asclepius','Unlocked')
state.WeaponMode:set('Unlocked')

--Command to Lock Style and Set the correct macros
jobsetup (LockStylePallet,MacroBook,MacroSet)

-- Balance 2100 HP / 1500 MP
function get_sets()

	-- Weapon setup
	sets.Weapons = {}

	sets.Weapons['Black Halo'] = { main="Maxentius", sub="Sindri" }

	sets.Weapons['Asclepius'] = { main="Asclepius"}

	-- Will swap weapons based off sets below
	sets.Weapons['Unlocked'] = { }

	sets.Weapons.Shield = { sub="Genmei Shield" }

	-- Standard Idle set with -DT,Refresh,Regen and movement gear
	sets.Idle = {
	    main="Mpaca's Staff",
        sub="Irenic Strap +1",
		ammo="Staunch Tathlum +1", --3
	    head=head.Bunzi, --7
        body=body.WHM_Empyrean,
        hands=hands.Bunzi, --8
        legs=legs.WHM_Empyrean, --13
        feet=feet.WHM_Empyrean, --11
		neck="Sibyl Scarf",
        ear1="Hearty Earring",
        ear2="Ebers Earring +2", --5
        ring1=ring.Gerubu_Or_Stikini1,
        ring2=ring.Stikini_2,
        back="Null Shawl", --10 
        waist=waist.PlatinumMoogle, --3
    }

	-- 'TP','PDL','ACC','DT','PDT','MEVA'
	sets.Idle.TP = set_combine(sets.Idle, {})
	sets.Idle.ACC = set_combine(sets.Idle, {})
	sets.Idle.DT = set_combine(sets.Idle, {})
	sets.Idle.PDT = set_combine(sets.Idle, {})
	sets.Idle.MEVA = set_combine(sets.Idle, {
		neck="Warder's Charm +1",
		waist="Null Belt",
	})
	-- Set is only applied when sublimation is charging
	sets.Idle.Sublimation = set_combine(sets.Idle, {
	    waist="Embla Sash", -- +3 Submlimation when active
	})

	-- Set to swap out when MP is low
	sets.Idle.Refresh = set_combine(sets.Idle, {
        waist="Fucho-no-obi"
    })

	sets.Idle.Resting = set_combine(sets.Idle, {})

	-- Movement Gear
    if (item_available("Shneddick Ring +1")) then
        sets.Movement = { ring1="Shneddick Ring +1" }
    else
        sets.Movement = { feet="Herald's Gaiters" }
    end

	sets.Cursna_Received = {
	    neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Purity Ring", --20
        waist="Gishdubar Sash", --10
	}

	sets.OffenseMode = {
		 ammo="Hasty Pinion +1",
        head=head.Bunzi,
        body=body.Nyame,
        hands=hands.Bunzi,
        legs=legs.Nyame,
        feet=feet.Nyame,
        neck="Rep. Plat. Medal",
        ear1="Crepuscular Earring",
        ear2="Telos Earring",
        ring1=ring.Chirich_1,
        ring2=ring.Chirich_2,
        back=bHM_DW,
        waist="Windbuffet Belt +1",
	}

	sets.OffenseMode.TP = set_combine(sets.OffenseMode,{ })
	sets.OffenseMode.DT = set_combine(sets.OffenseMode,{ })
	sets.OffenseMode.ACC = set_combine(sets.OffenseMode,{ })
	sets.OffenseMode.PDT = set_combine(sets.OffenseMode, { })
	sets.OffenseMode.MEVA = set_combine(sets.OffenseMode, { })

	sets.Precast = {}

	-- Used for Magic Spells (Cap 80%)
	sets.Precast.FastCast = {
		ammo={name="Impatiens", priority=1}, 
        head=head.Bunzi, --10
        body={name="Pinga Tunic +1", priority=101}, --15
        hands={name="Volte gloves", priority=1}, --6
        legs={name="Pinga Pants +1", priority=84}, --13
        feet={name="Regal Pumps +1", priority=13}, --7
        neck={name="Cleric's Torque +2", priority=1}, --10
        ear1={name="Malignance earring", priority=1}, --4
        ear2={name="Loquac. Earring", priority=1}, --2
        ring1={name="Lebeche Ring", priority=1},
        ring2={name="Kishar Ring", priority=1}, --4
        back={name="Fi Follet Cape +1", priority=1}, --10
        waist=waist.PlatinumMoogle,
	} -- 81%

	-- Cap is 10% Quick Magic - used for Raises and Cures
	sets.Precast.QuickMagic = set_combine(sets.Precast.FastCast, {
		ammo="Impatiens", -- 2
		ring2="Lebeche Ring", -- 2
		waist="Witful Belt", -- 3
	})

	-- Used for Cure cast
	sets.Precast.Cure = set_combine(sets.Precast.FastCast, sets.Precast.QuickMagic,  {
        feet=feet.Kaykaus_C,
        back="Perimede Cape",
	})

	-- Used for Enhancing cast
	sets.Precast.Enhancing = set_combine(sets.Precast.FastCast, sets.Precast.QuickMagic,  {
        waist="Siegel Sash",
	})

	-- Job Abilities
	sets.JA = {}
	sets.JA["Benediction"] = {body=body.WHM_Relic}
	sets.JA["Divine Seal"] = {}
	sets.JA["Convert"] = {}
	sets.JA["Devotion"] = {head=head.WHM_Relic}
	sets.JA["Afflatus Solace"] = {}
	sets.JA["Afflatus Misery"] = {}
	sets.JA["Sacrosanctity"] = {}
	sets.JA["Asylum"] = {}


	-- ===================================================================================================================
	--		sets.midcast
	-- ===================================================================================================================

	--Base set for midcast - if not defined will notify and use your idle set for surviability
	sets.Midcast = set_combine(sets.Idle, {
        main="Daybreak",
        sub="Ammurapi Shield",
        ammo="Ghastly Tathlum +1",
        head=head.Artifact_Head,
        body=body.WHM_Artifact,
        hands=hands.WHM_Relic,
        legs=legs.WHM_Artifact,
        feet=feet.WHM_Artifact,
        neck="Erra Pendant",
        ear1="Regal Earring",
        ear2="Ebers Earring +2",
        ring1=ring.Stikini_1,
        ring2=ring.Stikini_2,
        back="Aurist's Cape +1",
        waist="Obstinate Sash",
	})

	--This set is used as base as is overwrote by specific gear changes (Spell Interruption Rate Down)
	sets.Midcast.SIRD = {}

	-- Cure Set
	sets.Midcast.Cure = {
		main="Asclepius",
        sub={name="Genmei Shield", priority=1},-- (DT-10)
        ammo={name="Staunch Tathlum +1", priority=1}, -- (DT-3) (SIRD-11)
        head=headrean_Head, --(CP-22)
        neck={name="Clr. Torque +2", priority=1}, --(CP-10) (Enm-25)
        ear1={name="Glorious Earring", priority=1}, -- (CPII-2) (Enm-5) 
        ear2={name="Ebers Earring +2", priority=1}, --(DT-5)
        body=body.WHM_Empyrean,
        hands=hands.WHM_Artifact, -- (CPII-4) (Enm-7)
        legs=legs.WHM_Empyrean, --(DT-13)
        feet=feet.WHM_Empyrean, --(DT-11)
        ring1=ring.Janniston_Or_Gelatinous, --(PDT-7)          
        ring2={name="Mephitas's Ring +1", priority=1},
        back=back.WHM_Cure, -- (DT-10)
        waist={name="Shinjutsu-no-Obi +1", priority=1},
    }

    -- Used in custom hook
    sets.Midcast.Cure.LightWeather = {
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
    }

	-- For AoE cure
	sets.Midcast.Curaga = set_combine(sets.Midcast.Cure, 
	{
		 -- SIRD for Odyssey
        legs=legs.Bunzi, --(DT-9) (20 SIRD)
        feet=feet.WHM_Artifact, -- (29 SIRD)
	})

	-- For Cura - foucs on DT
	sets.Midcast.Cura = set_combine(sets.Midcast.Cure, {body=body.WHM_Artifact,})

	-- Enhancing Skill

	-- Used for base duration
	sets.Midcast.Enhancing = {
		main=weapons.Gada_ENH,
        sub="Genmei Shield",
        ammo="Staunch Tathlum +1",
        head=headhine_ENH_Head,
        body=body.Nyame,
        hands=hands.Telchine_ENH,
        legs=legs.Telchine_ENH,
        feet=feet.WHM_Artifact,
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Ebers Earring +2",
        ring1="Defending Ring",
        ring2="Gelatinous Ring +1",
        back=back.WHM_Cure,
        waist="Olympus Sash",
	}

	sets.Midcast.Enhancing.Others = set_combine(sets.Midcast.Enhancing, {
        
	});

	--'Barfire','Barblizzard','Baraero','Barstone','Barthunder','Barwater','Barfira','Barblizzara','Baraera','Barstonra','Barthundra','Barwatera'
	sets.Midcast.Enhancing.Elemental = set_combine(sets.Midcast.Enhancing, {
	    main=weapons.Gada_ENH,
        sub="Genmei Shield",
        ammo="Staunch Tathlum +1",
        head=headhine_ENH_Head,
        body=body.Nyame,
        hands=hands.Telchine_ENH,
        legs=legs.Telchine_ENH,
        feet=feet.WHM_Artifact,
        neck="Loricate Torque +1",
        ring1="Defending Ring",
        ring2="Gelatinous Ring +1",
        ear1="Tuisto Earring",
        ear2="Ebers Earring +2",
        waist="Embla Sash",
        back=back.WHM_Cure,
	})

	--'Barsleepra','Barpoisonra','Barparalyzra','Barblindra','Barvira','Barpetra','Baramnesra','Barsilencera','Barsleep','Barpoison','Barparalyze','Barblind','Barvirus','Barpetrify','Baramnesia','Barsilence'
	sets.Midcast.Enhancing.Status = set_combine(sets.Midcast.Enhancing.Elemental, {
	    neck="Sroda Necklace",
	})

	--'Temper','Temper II','Enaero','Enstone','Enthunder','Enwater','Enfire','Enblizzard','Boost-STR','Boost-DEX','Boost-VIT','Boost-AGI','Boost-INT','Boost-MND','Boost-CHR'
	sets.Midcast.Enhancing.Skill = set_combine(sets.Midcast.Enhancing, {
	    main=weapons.Gada_ENH,
        sub="Genmei Shield",
        ammo="Staunch Tathlum +1",
        head=headhine_ENH_Head,
        body=body.Nyame,
        hands=hands.Telchine_ENH,
        legs=legs.Telchine_ENH,
        feet=feet.WHM_Artifact,
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Ebers Earring +2",
        ring1="Defending Ring",
        ring2="Gelatinous Ring +1",
        back=back.WHM_Cure,
        waist="Olympus Sash",
	})

	-- High MACC for landing spells
	sets.Midcast.Enfeebling = {
		main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head=headrean_Head;
        body=body.WHM_Empyrean,
        hands=hands.WHM_Empyrean,
        legs=legs.Chironic_ENF,
        feet=feet.WHM_Artifact,
        neck="Null Loop",
        ear1="Regal Earring",
        ear2="Ebers Earring +2",
        ring1="Kishar Ring",
        ring2=ring.Ring.Stikini_2,
        back="Aurist's Cape +1",
        waist="Obstinate Sash",
	}

    --Handled in custom hook
    sets.Midcast.IntEnfeebles = set_combine(sets.Midcast.MndEnfeebles, {
        waist="Acuity Belt +1",
    })

	sets.Midcast.Dark = set_combine(sets.Midcast.Enfeebling, {
        main="Rubicundity",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",
        body=body.WHM_Artifact,
        hands=hands.WHM_Artifact,
        legs=legs.Chironic_ENF,
        feet=feet.WHM_Artifact,
        neck="Erra Pendant",
        ear1="Mani Earring",
        ear2="Malignance Earring",
        ring1="Evanescence Ring",
        ring2="Archon Ring",
        back="Aurist's Cape +1",
        waist="Fucho-no-Obi",
	})

	sets.Midcast.Dark.MACC = set_combine(sets.Midcast.Enfeebling.MACC, {

	})

	sets.Midcast.Dark.Absorb = set_combine(sets.Midcast.Enfeebling, {

	})

	sets.Midcast["Cursna"] = {
		main="Yagrush",
        sub="Genmei Shield",
        head=headrean_Head,
        body=body.WHM_Empyrean,
        hands="Fanatic Gloves", --15
        legs=legs.WHM_Artifact, --21
        feet=feet.WHM_Empyrean,
        neck="Debilis Medallion", --15
        ear1="Meili Earring",
        ear2="Ebers Earring +2", --3/3
        ring1="Haoma's Ring", --15
        ring2="Menelaus's Ring", --20
        back=back.WHM_Cure, --25
        waist="Bishop's Sash",
	}

	sets.Midcast["Erase"] = set_combine(sets.Midcast, {
		main="Yagrush",
		neck="Cleric's Torque +2",
	})

	sets.Midcast["Esuna"] = set_combine(sets.Midcast, { main="Asclepius" })

	sets.Midcast["Silena"] = set_combine(sets.Midcast, {
		hands=hands.WHM_Empyrean,
		main="Yagrush"
	})

	sets.Midcast["Poisona"] = set_combine(sets.Midcast, {
		hands=hands.WHM_Empyrean,
		main="Yagrush"
	})

	sets.Midcast["Paralyna"] = set_combine(sets.Midcast, {
		hands=hands.WHM_Empyrean,
		main="Yagrush"
	})

	sets.Midcast["Stona"] = set_combine(sets.Midcast, {
		hands=hands.WHM_Empyrean,
		main="Yagrush"
	})

	sets.Midcast["Blindna"] = set_combine(sets.Midcast, {
		hands=hands.WHM_Empyrean,
		main="Yagrush"
	})

	sets.Midcast["Viruna"] = set_combine(sets.Midcast, {
		hands=hands.WHM_Empyrean,
		main="Yagrush"
	})

	sets.Midcast["Auspice"] = set_combine(sets.Midcast, {
		feet=feet.WHM_Empyrean,
	})

	sets.Midcast["Aquaveil"] = set_combine(sets.Midcast.Enhancing, {
		main="Vadose Rod",
        sub="Genmei Shield",
        ammo="Staunch Tathlum +1",
        head="Chironic Hat",
        body=body.Bunzi,
        hands="Regal Cuffs",
        legs="Shedir Seraweels",
        feet=feet.WHM_Artifact,
        ear1="Halasz Earring",
        ear2="Magnetic Earring",
        ring1="Freke Ring",
        ring2="Evanescence Ring",
        waist="Emphatikos Rope",
	})

	sets.Midcast.Regen = {
		 main="Bolelabunga",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head="Inyanga Tiara +2",
        body=body.WHM_Relic,
        hands=hands.WHM_Empyrean,
        legs=legs.WHM_Artifact,
        feet=feet.Bunzi,
        neck="Cleric's Torque +2",
        ear1="Tuisto Earring",
        ear2="Ebers Earring +2",
        ring1="Defending Ring",
        ring2="Gelatinous Ring +1",
        back="Solemnity Cape",
        waist="Embla Sash",
	}

	-- Specific gear for spells
	sets.Midcast["Stoneskin"] = {
		waist="Siegel Sash",
		neck="Nodens Gorget",
	}

	sets.Midcast.Refresh = {}

	sets.WS = {
	    ammo="Oshasha's Treatise",
        head=head.Nyame,
        body=body.Nyame,
        hands=hands.Nyame,
        legs=legs.Nyame,
        feet=feet.Nyame,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1=ring.Cornelia_Or_Epaminondas,
        ring2="Ilabrat Ring",
        back=back.WHM_Cure,
        waist="Fotia Belt",
	}

	--This set is used when OffenseMode is ACC and a WS is used (Augments the WS base set)
	sets.WS.ACC = {}

	-- Note that the Mote library will unlock these gear spots when used.
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
	local equipSet = {}

	return equipSet
end

-- Augment basic equipment sets
function midcast_custom(spell)
	local equipSet = {}

    if ((world.weather_element == 'Light' or world.day_element == 'Light') and (spell.name:contains('Cure') or spell.name:contains('Cura'))) then
        equipSet = set_combine(sets.Midcast.Cure, sets.Midcast.Cure.LightWeather)
    elseif spell.skill == "Enfeebling Magic" then
        if spell.type == 'DarkMagic' then
            equipSet = set_combine(sets.Midcast.Enfeebling, sets.Midcast.IntEnfeebles)
        else
            equipSet = sets.Midcast.Enfeebling
        end
    end
    
	return equipSet
end

-- Augment basic equipment sets
function aftercast_custom(spell)
	local equipSet = {}
	if not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
		add_to_chat(8,'You are not in a stance')
	end
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

--Function is called when a self command is issued
function self_command_custom(command)

end

-- Function is called when the job lua is unloaded
function user_file_unload()

end

--Function used to automate Job Ability use - Checked first
function check_buff_JA()
	local buff = 'None'
	return buff
end

--Function used to automate Spell use
function check_buff_SP()
	local buff = 'None'
	return buff
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