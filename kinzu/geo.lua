function get_sets()
	mote_include_version = 2
	include('Mote-Include.lua')
end

function binds_on_load()
	-- F9-F12
	send_command('bind f9 gs c cycle OffenseMode')
	send_command('bind f10 gs c cycle HybridMode')
	send_command('bind f11 gs c cycle CastingMode')
	send_command('bind f12 gs c cycle IdleMode')
	-- ALT F9-12
	send_command('bind !f9 gs c update user')
	send_command('bind !f10 gs c cycle RangedMode')
	send_command('bind !f11 gs c cycle WeaponskillMode')
	send_command('bind !f12 gs c cycle Kiting')
end

function job_setup()
    indi_duration = 327
end

function user_setup()
	state.OffenseMode:options('Normal')
	state.HybridMode:options('Normal')
    state.CastingMode:options('Normal', 'MB')
    state.IdleMode:options('Normal')
	
	Elemental_Magic_RA = S{
	'Stonera', 'Watera', 'Aera', 'Fira', 'Blizzara', 'Thundara',
	'Stonera II', 'Watera II', 'Aera II', 'Fira II', 'Blizzara II', 'Thundara II',
	'Stonera III', 'Watera III', 'Aera III', 'Fira III', 'Blizzara III', 'Thundara III'}

	send_command('input /macro book 16;wait .1;input /macro set 1')
	send_command('wait 6;input /lockstyleset 010')
end

function init_gear_sets()
	-- JA Precast Sets 
	sets.precast.JA['Bolster'] = {body="Bagua Tunic +3"}
	sets.precast.JA['Life Cycle'] = {body="Geomancy Tunic +2", back="Nantosuelta's Cape"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals +3"}
	
	-- Precast Sets
	sets.precast['FC'] = {
	main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Genmei Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Nahtirah Hat",
    body="Volte Doublet",
    hands={ name="Agwu's Gages", augments={'Path: A',}},
    legs="Geomancy Pants +2",
    feet={ name="Agwu's Pigaches", augments={'Path: A',}},
    neck="Voltsurge Torque",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Loquac. Earring",
    left_ring="Prolix Ring",
    right_ring="Kishar Ring",
    back={ name="Fi Follet Cape +1", augments={'Path: A',}},
	}
	
	sets.precast.FC['Impact'] = {
	main={ name="Idris", augments={'Path: A',}},
    sub="Genmei Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    body="Crepuscular Cloak",
    hands={ name="Agwu's Gages", augments={'Path: A',}},
    legs="Geomancy Pants +2",
    feet={ name="Agwu's Pigaches", augments={'Path: A',}},
    neck="Voltsurge Torque",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Loquac. Earring",
    left_ring="Prolix Ring",
    right_ring="Kishar Ring",
    back={ name="Fi Follet Cape +1", augments={'Path: A',}},
	}
	
	sets.precast.FC['Dispelga'] = {
	main="Daybreak",
    sub="Genmei Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="C. Palug Crown",
    body="Volte Doublet",
    hands={ name="Agwu's Gages", augments={'Path: A',}},
    legs="Geomancy Pants +2",
    feet={ name="Agwu's Pigaches", augments={'Path: A',}},
    neck="Voltsurge Torque",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Loquac. Earring",
    left_ring="Prolix Ring",
    right_ring="Kishar Ring",
    back={ name="Fi Follet Cape +1", augments={'Path: A',}},
	}
	
	-- Midcast Sets
	-- Geomancy Sets
	sets.midcast['Geomancy'] = {
	main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Genmei Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Azimuth Hood +3",
    body="Shamash Robe",
    hands="Azimuth Gloves +3",
	legs="Azimuth Tights +3",
    feet="Azimuth Gaiters +3",
    neck={ name="Bagua Charm +2", augments={'Path: A',}},
    waist="Luminary Sash",
    left_ear="Magnetic Earring",
    right_ear={ name="Azimuth Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+14','Damage taken-5%',}},
    left_ring={ name="Stikini Ring +1", bag="wardrobe4"},
    right_ring={ name="Stikini Ring +1", bag="wardrobe5"},
    back="Solemnity Cape",
	}
	
	sets.midcast['Geomancy'].Indi = {
	main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Genmei Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Azimuth Hood +3",
    body="Shamash Robe",
    hands="Azimuth Gloves +3",
	legs={ name="Bagua Pants +3", augments={'Enhances "Mending Halation" effect',}},
    feet="Azimuth Gaiters +3",
    neck={ name="Bagua Charm +2", augments={'Path: A',}},
	waist="Luminary Sash",
    left_ear="Magnetic Earring",
    right_ear={ name="Azimuth Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+14','Damage taken-5%',}},
    left_ring={ name="Stikini Ring +1", bag="wardrobe4"},
    right_ring={ name="Stikini Ring +1", bag="wardrobe5"},
    back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +20','Damage taken-3%',}},
	}
	
	-- Healing Magic Sets
	sets.midcast['Cure'] = {
	main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Genmei Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body={ name="Vanya Robe", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    neck="Nodens Gorget",
    waist="Bishop's Sash",
    left_ear="Regal Earring",
    right_ear="Mendi. Earring",
    left_ring={ name="Stikini Ring +1", bag="wardrobe4"},
    right_ring={ name="Stikini Ring +1", bag="wardrobe5"},
    back="Solemnity Cape",
	}
	
	sets.midcast['Curaga'] = {
	main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Genmei Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head={ name="Vanya Hood", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    body={ name="Vanya Robe", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    feet={ name="Vanya Clogs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
    neck="Nodens Gorget",
    waist="Luminary Sash",
    left_ear="Regal Earring",
    right_ear="Mendi. Earring",
    left_ring="Lebeche Ring",
    right_ring={ name="Stikini Ring +1", bag="wardrobe4"},
    back="Solemnity Cape",
	}
	
	-- Enhancing Magic Sets
	sets.midcast['Enhancing Magic'] = {
	main="Gada",
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head={ name="Telchine Cap", augments={'Mag. Evasion+22','"Conserve MP"+3','Enh. Mag. eff. dur. +10',}},
    body={ name="Telchine Chas.", augments={'Mag. Evasion+21','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+22','"Conserve MP"+4','Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+22','"Conserve MP"+3','Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Mimir Earring",
    right_ear="Andoaa Earring",
    left_ring={ name="Stikini Ring +1", bag="wardrobe4"},
    right_ring={ name="Stikini Ring +1", bag="wardrobe5"},
    back={ name="Fi Follet Cape +1", augments={'Path: A',}},
	}
	
	sets.midcast['Refresh'] = {
	main="Gada",
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
    hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
    feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Mimir Earring",
    right_ear="Andoaa Earring",
    left_ring={ name="Stikini Ring +1", bag="wardrobe4"},
    right_ring={ name="Stikini Ring +1", bag="wardrobe5"},
    back={ name="Fi Follet Cape +1", augments={'Path: A',}},
	}
	
	sets.midcast['Aquaveil'] = {
    main="Vadose Rod",
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head={ name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    body={ name="Telchine Chas.", augments={'Mag. Evasion+21','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}},
    hands="Regal Cuffs",
    legs="Shedir Seraweels",
    feet={ name="Telchine Pigaches", augments={'Mag. Evasion+22','"Conserve MP"+3','Enh. Mag. eff. dur. +10',}},
    neck="Incanter's Torque",
    waist="Emphatikos Rope",
    left_ear="Mimir Earring",
    right_ear="Andoaa Earring",
    left_ring={ name="Stikini Ring +1", bag="wardrobe4"},
    right_ring={ name="Stikini Ring +1", bag="wardrobe5"},
    back={ name="Fi Follet Cape +1", augments={'Path: A',}},
	}
	
	-- Enfeebling Magic Sets
	sets.midcast['Enfeebling Magic'] = {
	main={ name="Bunzi's Rod", augments={'Path: A',}},
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Azimuth Hood +3",
    body="Azimuth Coat +3",
    hands="Azimuth Gloves +3",
    legs="Azimuth Tights +3",
    feet="Azimuth Gaiters +3",
    neck={ name="Bagua Charm +2", augments={'Path: A',}},
    waist={ name="Acuity Belt +1", augments={'Path: A',}},
    left_ear="Malignance Earring",
    right_ear={ name="Azimuth Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+14','Damage taken-5%',}},
    left_ring={ name="Stikini Ring +1", bag="wardrobe4"},
    right_ring={ name="Stikini Ring +1", bag="wardrobe5"},
    back={ name="Aurist's Cape +1", augments={'Path: A',}},
	}

	-- Enfeebling Equipment Specific
	sets.midcast['Impact'] = {
    main={ name="Bunzi's Rod", augments={'Path: A',}},
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head=empty,
    body="Crepuscular Cloak",
    hands="Azimuth Gloves +3",
    legs="Azimuth Tights +3",
    feet="Azimuth Gaiters +3",
    neck={ name="Bagua Charm +2", augments={'Path: A',}},
    waist={ name="Acuity Belt +1", augments={'Path: A',}},
    left_ear="Malignance Earring",
    right_ear={ name="Azimuth Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+14','Damage taken-5%',}},
    left_ring={ name="Stikini Ring +1", bag="wardrobe4"},
    right_ring={ name="Stikini Ring +1", bag="wardrobe5"},
    back={ name="Aurist's Cape +1", augments={'Path: A',}},
    }
	
    sets.midcast['Dispelga'] = {
	main="Daybreak",
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Azimuth Hood +3",
    body="Azimuth Coat +3",
    hands="Azimuth Gloves +3",
    legs="Azimuth Tights +3",
    feet="Azimuth Gaiters +3",
    neck={ name="Bagua Charm +2", augments={'Path: A',}},
    waist={ name="Acuity Belt +1", augments={'Path: A',}},
    left_ear="Malignance Earring",
    right_ear={ name="Azimuth Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+14','Damage taken-5%',}},
    left_ring={ name="Stikini Ring +1", bag="wardrobe4"},
    right_ring={ name="Stikini Ring +1", bag="wardrobe5"},
    back={ name="Aurist's Cape +1", augments={'Path: A',}},
    }
	
	-- Elemental Magic Sets
	sets.midcast['Elemental Magic'] = {
	main={ name="Bunzi's Rod", augments={'Path: A',}},
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Azimuth Hood +3",
    body="Azimuth Coat +3",
    hands={ name="Agwu's Gages", augments={'Path: A',}},
    legs="Azimuth Tights +3",
    feet={ name="Agwu's Pigaches", augments={'Path: A',}},
    neck={ name="Bagua Charm +2", augments={'Path: A',}},
    waist={ name="Acuity Belt +1", augments={'Path: A',}},
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Freke Ring",
    right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
	}

	sets.midcast['Elemental Magic'].MB = {
    main={ name="Bunzi's Rod", augments={'Path: A',}},
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Ea Hat +1",
    body="Azimuth Coat +3",
    hands={ name="Agwu's Gages", augments={'Path: A',}},
    legs="Azimuth Tights +3",
    feet={ name="Agwu's Pigaches", augments={'Path: A',}},
    neck={ name="Bagua Charm +2", augments={'Path: A',}},
    waist={ name="Acuity Belt +1", augments={'Path: A',}},
    left_ear="Malignance Earring",
    right_ear="Regal Earring",
    left_ring="Freke Ring",
    right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
	}

	sets.midcast['RA'] = {
	main={ name="Bunzi's Rod", augments={'Path: A',}},
	sub="Ammurapi Shield",
	range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
	head="Azimuth Hood +3",
	body="Seidr Cotehardie",
	hands="Azimuth Gloves +3",
	legs={ name="Agwu's Slops", augments={'Path: A',}},
	feet="Azimuth Gaiters +3",
	neck="Sibyl Scarf",
	waist="Orpheus's Sash",
	left_ear="Malignance Earring",
	right_ear="Regal Earring",
	left_ring="Freke Ring",
	right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
	back={ name="Nantosuelta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
	}
	
	-- Dark Magic Sets
	sets.midcast['Dark Magic'] = {
	main={ name="Bunzi's Rod", augments={'Path: A',}},
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head="Azimuth Hood +3",
    body="Azimuth Coat +3",
    hands="Azimuth Gloves +3",
    legs="Azimuth Tights +3",
    feet="Azimuth Gaiters +3",
    neck={ name="Bagua Charm +2", augments={'Path: A',}},
    waist={ name="Acuity Belt +1", augments={'Path: A',}},
    left_ear="Malignance Earring",
    right_ear={ name="Azimuth Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+14','Damage taken-5%',}},
    left_ring={ name="Stikini Ring +1", bag="wardrobe4"},
    right_ring={ name="Stikini Ring +1", bag="wardrobe5"},
    back={ name="Aurist's Cape +1", augments={'Path: A',}},
	}

	sets.midcast['Stun'] = {
	main={ name="Bunzi's Rod", augments={'Path: A',}},
    sub="Ammurapi Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head={ name="Agwu's Cap", augments={'Path: A',}},
    body="Zendik Robe",
    hands={ name="Agwu's Gages", augments={'Path: A',}},
    legs="Geomancy Pants +2",
    feet={ name="Agwu's Pigaches", augments={'Path: A',}},
    neck={ name="Bagua Charm +2", augments={'Path: A',}},
    waist="Ninurta's Sash",
    left_ear="Malignance Earring",
    right_ear="Enchntr. Earring +1",
    left_ring="Prolix Ring",
    right_ring="Kishar Ring",
    back={ name="Aurist's Cape +1", augments={'Path: A',}},
	}
	
	-- Ninjutsu Sets
    sets.midcast['Ninjutsu'] = {
	main="Idris",
	sub="Genmei Shield",
	range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
	head={ name="Nyame Helm", augments={'Path: B',}},
	body="Shamash Robe",
	hands={ name="Nyame Gauntlets", augments={'Path: B',}},
	legs={ name="Nyame Flanchard", augments={'Path: B',}},
	feet={ name="Nyame Sollerets", augments={'Path: B',}},
	neck="Warder's Charm +1",
	waist="Carrier's Sash",
	left_ear="Sanare Earring",
	right_ear="Lugalbanda Earring",
	left_ring={ name="Stikini Ring +1", bag="Wardrobe 4"},
	right_ring="Shneddick Ring +1",
	back={ name="Nantosuelta's Cape", augments={'INT+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Phys. dmg. taken-10%',}},
	}
	
	-- Idle Sets
	sets['idle'] = {
	main="Daybreak",
	sub="Genmei Shield",
	range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
	head={ name="Nyame Helm", augments={'Path: B',}},
	body="Shamash Robe", -- Azimuth Coat +3
	hands={ name="Nyame Gauntlets", augments={'Path: B',}},
	legs={ name="Nyame Flanchard", augments={'Path: B',}},
	feet={ name="Nyame Sollerets", augments={'Path: B',}},
	neck={ name="Loricate Torque +1", augments={'Path: A',}},
	waist="Carrier's Sash",
	left_ear="Sanare Earring",
	right_ear="Lugalbanda Earring",
    left_ring={ name="Stikini Ring +1", bag="wardrobe4"},
    right_ring="Shneddick Ring",
	back={ name="Nantosuelta's Cape", augments={'Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	}

	-- Pet Sets 
    sets['idle'].Pet = {
	main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
	sub="Genmei Shield",
	range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
	head="Azimuth Hood +3",
	body="Shamash Robe",
	hands="Geo. Mitaines +3",
	legs={ name="Nyame Flanchard", augments={'Path: B',}},
	feet={ name="Bagua Sandals +3", augments={'Enhances "Radial Arcana" effect',}},
	neck="Bagua Charm +2",
	waist="Isa Belt",
	left_ear="Etiolation Earring",
	right_ear="Lugalbanda Earring",
    left_ring={ name="Stikini Ring +1", bag="wardrobe4"},
    right_ring={ name="Stikini Ring +1", bag="wardrobe5"},
	back={ name="Nantosuelta's Cape", augments={'Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Pet: "Regen"+10','Pet: Damage taken -5%',}},
	}
	
	-- Engaged Sets
    sets['engaged'] = {
	main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
	sub="Genmei Shield",
    range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
    head={ name="Nyame Helm", augments={'Path: B',}},
    body={ name="Nyame Mail", augments={'Path: B',}},
	hands="Geo. Mitaines +3",
    legs={ name="Nyame Flanchard", augments={'Path: B',}},
    feet={ name="Nyame Sollerets", augments={'Path: B',}},
    neck="Bagua Charm +2",
    waist="Cornelia's Belt",
    left_ear="Telos Earring",
    right_ear="Crep. Earring",
    left_ring="Chirich Ring +1",
    right_ring="Chirich Ring +1",
	back={ name="Nantosuelta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Pet: Damage taken -5%',}},
	}

	-- Weaponskill Sets	
	sets.precast['WS'] ={
	main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
	sub="Genmei Shield",
	range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
	head={ name="Nyame Helm", augments={'Path: B',}},
	body={ name="Nyame Mail", augments={'Path: B',}},
	hands={ name="Nyame Gauntlets", augments={'Path: B',}},
	legs={ name="Nyame Flanchard", augments={'Path: B',}},
	feet={ name="Nyame Sollerets", augments={'Path: B',}},
	neck={ name="Bagua Charm +2", augments={'Path: A',}},
	waist="Grunfeld Rope",
    left_ear="Ishvara Earring",
    right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
	left_ring="Metamor. Ring +1",
    right_ring="Cornelia's Ring",
	back={ name="Nantosuelta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end

function job_buff_change(buff, gain)
    if player.indi and not classes.CustomIdleGroups:contains('Indi')then
        classes.CustomIdleGroups:append('Indi')
        handle_equipping_gear(player.status)
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        handle_equipping_gear(player.status)
    end
end

function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Geomancy' then
            if spell.english:startswith('Indi') then
                return 'Indi'
            end
        end
    end

function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
    classes.CustomIdleGroups:append('Indi')
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.skill == 'Elemental Magic' then
		if Elemental_Magic_RA:contains(spell.name) then
			equip (sets.midcast.RA)
		end
	if spell.skill == 'Elemental Magic' then
		if spell.name:startswith("Stonera") then
			equip({neck="Quanpur Necklace"})
		end
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})	
			end
        end 
    end
	if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast['Enhancing Magic'])
			if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
            end
        end
    end
end

function select_default_macro_book()
    set_macro_page(1, 21)
end