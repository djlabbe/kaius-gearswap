function get_sets()
    sets.precast = {}
    sets.precast.JA = {}
	send_command('wait 6;input /lockstyleset 004')
    -- Precast Sets
    sets.precast.JA.Nightingale = {feet = "Bihu Slippers"}

    sets.precast.JA.Troubadour = {body = "Bihu Jstcorps. +3"}

    sets.precast.JA['Soul Voice'] = {legs = "Bihu Cannions"}

    sets.precast.FC = {}

    sets.precast.FC.Song = {
		head="Bunzi's Hat",
		body="Inyanga Jubbah +2",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Aya. Cosciales +2",
		feet="Fili Cothurnes +3",
		neck="Voltsurge Torque",
		waist="Embla Sash",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Rahab Ring",
		right_ring="Kishar Ring",
		back={ name="Fi Follet Cape +1", augments={'Path: A',}},
    }
	
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.Song,{range="Marsyas"})
	
	sets.precast.FC['Aria of Passion'] = set_combine(sets.precast.FC.Song,{range="Loughnashade"})
	
    sets.precast.FC.Normal = {
		head="Bunzi's Hat",
		body="Inyanga Jubbah +2",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Aya. Cosciales +2",
		feet="Fili Cothurnes +3",
		neck="Voltsurge Torque",
		waist="Embla Sash",
		left_ear="Loquac. Earring",
		right_ear="Etiolation Earring",
		left_ring="Rahab Ring",
		right_ring="Kishar Ring",
		back={ name="Fi Follet Cape +1", augments={'Path: A',}},
    }

    sets.precast.EnhancingMagic = {waist = "Siegel Sash"}

    sets.precast.Cure = {
		head="Bunzi's Hat",
		body="Inyanga Jubbah +2",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Aya. Cosciales +2",
		feet="Volte Gaiters",
		neck="Voltsurge Torque",
		waist="Embla Sash",
		left_ear="Loquac. Earring",
		right_ear="Steelflash Earring",
		left_ring="Rahab Ring",
		right_ring="Kishar Ring",
		back={ name="Fi Follet Cape +1", augments={'Path: A',}},
    }

    sets.precast.WS = {}
    sets.MordantRime = {
		range={ name="Linos", augments={'Accuracy+14','Weapon skill damage +3%','STR+6 DEX+6',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Bihu Jstcorps. +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear="Regal Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Cornelia's Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Accuracy+20 Attack+20','CHR+10','Weapon skill damage +10%',}},
    }
	
	sets.precast.WS = {}
    sets.SavageBlade = {
		range={ name="Linos", augments={'Accuracy+14','Weapon skill damage +3%','STR+6 DEX+6',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Bard's Charm +2",
		waist="Sailfi Belt +1",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ring="Cornelia's Ring",
		left_ring="Sroda Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }

    sets.precast.WS = {}
    sets.Rudra = {
		range={ name="Linos", augments={'Accuracy+14','Weapon skill damage +3%','STR+6 DEX+6',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Bihu Jstcorps. +3", augments={'Enhances "Troubadour" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist={ name="Kentarch Belt +1", augments={'Path: A',}},
		left_ear="Mache Earring +1",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		left_ring="Petrov Ring",
		right_ring="Cornelia's Ring",
		back={ name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%',}},
    }

    sets.precast.WS = {}
    sets.Exen = {
		range={ name="Linos", augments={'Accuracy+14','Weapon skill damage +3%','STR+6 DEX+6',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Bard's Charm +2",
		waist="Sailfi Belt +1",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ring="Cornelia's Ring",
		left_ring="Sroda Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }

    sets.precast.WS = {}
    sets.Evisceration = {
		range={ name="Linos", augments={'Accuracy+14','Weapon skill damage +3%','STR+6 DEX+6',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Bard's Charm +2",
		waist="Sailfi Belt +1",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
		right_ring="Cornelia's Ring",
		left_ring="Sroda Ring",
		back={ name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }

    sets.TP = {
		range={ name="Linos", augments={'Accuracy+19','"Store TP"+4','Quadruple Attack +3',}},
		head={ name="Bunzi's Hat", augments={'Path: A',}},
		body="Ashera Harness",
		hands={ name="Bunzi's Gloves", augments={'Path: A',}},
		legs="Volte Tights",
		feet="Volte Spats",
		neck={ name="Bard's Charm +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Telos Earring",
		left_ring="Moonlight Ring",
		right_ring="Moonlight Ring",
		back="Null Shawl",
    }

    -- Midcast Sets
    sets.midcast = {}

    sets.midcast.Haste = {
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'Accuracy+20','"Store TP"+6','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		waist="Embla Sash",
		left_ear="Mimir Earring",
		right_ear="Andoaa Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
    }

    sets.midcast.Debuff = {
		main="Carnwenhan",
		range="Gjallarhorn",
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Brioso Cuffs +3",
		legs="Fili Rhingrave +3",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Obstin. Sash",
		left_ear="Regal Earring",
		right_ear="Fili Earring +1",
		left_ring="Metamor. Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
    }

    sets.midcast.Threnody = {
		main="Carnwenhan",
		range="Gjallarhorn",
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Brioso Cuffs +3",
		legs="Fili Rhingrave +3",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Obstin. Sash",
		left_ear="Regal Earring",
		right_ear="Fili Earring +1",
		left_ring="Metamor. Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
    }

    sets.midcast.Buff = {
		main="Carnwenhan",
		sub={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Flume Belt +1",
		left_ear="Hearty Earring",
		right_ear="Fili Earring +1",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
    }

    sets.midcast.Cure = {
		head={ name="Vanya Hood", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
		body={ name="Kaykaus Bliaut", augments={'MP+60','"Cure" potency +5%','"Conserve MP"+6',}},
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','"Conserve MP"+7','"Fast Cast"+4',}},
		legs="Doyen Pants",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Nodens Gorget",
		waist="Bishop's Sash",
		left_ear="Mendi. Earring",
		right_ear="Magnetic Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Solemnity Cape",
    }
	sets.midcast.AbsorbTP = {
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Brioso Cuffs +3",
		legs="Fili Rhingrave +3",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Obstin. Sash",
		left_ear="Digni. Earring",
		right_ear="Fili Earring +1",
		left_ring="Metamor. Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
    }

    sets.midcast.Marsyas = {
		range="Marsyas",
		main="Carnwenhan",
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Flume Belt +1",
		left_ear="Hearty Earring",
		right_ear="Fili Earring +1",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
    }

    sets.midcast.Lullaby = {
		main="Carnwenhan",
		range="Daurdabla",    
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Brioso Cuffs +3",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Obstin. Sash",
		left_ear="Digni. Earring",
		right_ear="Fili Earring +1",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
    }
	sets.midcast.Loughnashade = {
		range="Loughnashade",
		main="Carnwenhan",
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Flume Belt +1",
		left_ear="Hearty Earring",
		right_ear="Fili Earring +1",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
    }

    sets.midcast.DBuff = {range = "Daurdabla", ammo = empty}

    sets.midcast.GBuff = {range = "Loughnashade", ammo = empty}

    sets.midcast.Duration = {
		main="Carnwenhan",
		sub={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Mnbw. Whistle +1",
		waist="Flume Belt +1",
		left_ear="Hearty Earring",
		right_ear="Eabani Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
    }

    sets.midcast.Ballad = {legs = "Fili Rhingrave +3"}

    sets.midcast.Scherzo = {feet = "Fili cothurnes +3"}

    sets.midcast.Paeon = {range = "Daurdabla"}

    sets.midcast.Base = sets.midcast.Haste

    sets.midcast.Waltz = {}

    sets.midcast.Stoneskin = {
		head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}},
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +9',}},
		hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
		neck="Nodens Gorget",
		waist="Embla Sash",
		left_ear="Mimir Earring",
		right_ear="Andoaa Earring",
		left_ring="Metamor. Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Damage taken-5%',}},
    }

    -- Aftercast Sets
    sets.aftercast = {}

    sets.aftercast.PDT = {
		head="Fili Calot +3",
		body="Fili Hongreline +3",
		hands="Fili Manchettes +3",
		legs="Fili Rhingrave +3",
		feet="Fili Cothurnes +3",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Infused Earring",
		right_ear="Fili Earring +1",
		left_ring={ name="Moonlight Ring", bag="wardrobe1"},
		right_ring={ name="Moonlight Ring", bag="wardrobe2"},
		back="Null Shawl",
    }
	
    sets.aftercast._tab = {'PDT'}

    sets.aftercast._index = 1

    sets.aftercast.Idle = sets.aftercast[sets.aftercast._tab[sets.aftercast._index]]

	DaurdSongs = T{"Army's Paeon", "Army's Paeon II", "Army's Paeon III", "Army's Paeon IV", "Army's Paeon V", "Army's Paeon VI"}
 
    send_command('input /macro book 13;wait .1;input /macro set 1')
    timer_reg = {}
    pianissimo_cycle = false
end

function pretarget(spell)
    if spell.type == 'BardSong' and spell.target.type and spell.target.type == 'PLAYER' and not buffactive.pianissimo and not spell.target.charmed and not pianissimo_cycle then
        cancel_spell()
        pianissimo_cycle = true
        send_command('input /ja "Pianissimo" <me>;wait 1.5;input /ma "' .. spell.name .. '" ' .. spell.target.name .. ';')
        return
    end
    if spell.name ~= 'Pianissimo' then pianissimo_cycle = false end
end

function precast(spell)
    if spell.type == "BardSong" then
		if spell.name == 'Honor March' then
            equip(sets.precast.FC['Honor March'])
		elseif spell.name == 'Aria of Passion' then
            equip(sets.precast.FC['Aria of Passion'])
		else
			equip(sets.precast.FC.Song)
        end
        --if buffactive["Nightingale"] then
            --if spell.english == "Honor March" then
                --equip(sets.midcast.Buff, sets.midcast.Marsyas)
            --elseif spell.english == "Aria of Passion" then
                --equip(sets.midcast.Buff, sets.midcast.Loughnashade)
            --else
                --equip_song_gear(spell)
            --end
        --end
	end
    if spell.action_type == "Magic" then
        equip(sets.precast.FC.Normal)
    end
    if spell.action_type == "Magic" then
        if sets.precast.FC[tostring(spell.element)] then 
			equip(sets.precast.FC[tostring(spell.element)]) 
		end
    end
    if sets.precast.JA[spell.name] then 
		equip(sets.precast.JA[spell.name]) 
	end

    if spell.english == 'Mordant Rime' then
        equip(sets.MordantRime)
        send_command('@input /echo Mordant Rime Set')

    elseif spell.english == "Rudra's Storm" then
        equip(sets.Rudra)
        send_command('@input /echo Rudra Set')

    elseif spell.english == 'Evisceration' then
        equip(sets.Evisceration)
        send_command('@input /echo Evisceration Set')

    elseif spell.english == 'Exenterator' then
        equip(sets.Exen)
        send_command('@input /echo Exenterator Set')
	
	elseif spell.english == 'Savage Blade' then
			equip(sets.SavageBlade)
		
	elseif spell.type == 'WeaponSkill' then
			equip(sets.MordantRime)
    end
end

function midcast(spell)
    if spell.type == "BardSong" then
        if spell.english == "Honor March" then
            equip(sets.midcast.Buff, sets.midcast.Marsyas)
        elseif spell.english == "Aria of Passion" then
            equip(sets.midcast.Buff, sets.midcast.Loughnashade)
        else
            equip_song_gear(spell)
            if spell.name == "Ice Threnody II" then 
				equip({waist = "Chaac belt"})
			end
        end
	end
    if string.find(spell.name, "Cure") or string.find(spell.name, "Curaga") then
        equip(sets.midcast.EnmityRecast, sets.midcast.Cure)
    elseif spell.name == "Cursna" then
        equip(sets.midcast.EnmityRecast, sets.midcast.Cursna)
	elseif spell.name == "Absorb-TP" then
        equip(sets.midcast.EnmityRecast, sets.midcast.AbsorbTP)
    elseif spell.name == "Haste" then
        equip(sets.midcast.EnmityRecast, sets.midcast.Stoneskin)
    elseif spell.name == "Stoneskin" then
        equip(sets.midcast.EnmityRecast, sets.midcast.Stoneskin)
        if buffactive["Stoneskin"] then windower.send_command('wait 1;cancel 37;') end
    elseif string.find(spell.name, "Protect") or string.find(spell.name, "Shell") then
        equip(sets.midcast.EnmityRecast, sets.midcast.ProShell)
    elseif spell.name == "Sneak" and buffactive["Sneak"] and spell.target.type == "SELF" then
        windower.send_command('cancel 71;')
    elseif spell.type == "Ninjutsu" then
        if spell.name == "Utsusemi: Ichi" then
            equip(sets.aftercast.PDT)
            if buffactive["Copy Image"] then windower.send_command('wait 1;cancel 66;') end
        else
            equip(sets.aftercast.PDT)
        end
    elseif spell.action_type == "Magic" then
        equip(sets.midcast.EnmityRecast)
    end
end

function aftercast(spell)
    if midaction() then return end
    --[[    if spell.type and spell.type == 'BardSong' and spell.target and spell.target.type:upper() == 'SELF' then
        local t = os.time()
        
        -- Eliminate songs that have already expired
        local tempreg = {}
        for i,v in pairs(timer_reg) do
            if v < t then tempreg[i] = true end
        end
        for i,v in pairs(tempreg) do
            timer_reg[i] = nil
        end
        
        local dur = calculate_duration(spell.name)
        if timer_reg[spell.name] then
            if (timer_reg[spell.name] - t) <= 120 then
                send_command('timers delete "'..spell.name..'"')
                timer_reg[spell.name] = t + dur
                send_command('timers create "'..spell.name..'" '..dur..' down')
            end
        else
            local maxsongs = 2
            if player.equipment.range == 'Daurdabla' then
                maxsongs = maxsongs+2
            end
            if buffactive['Clarion Call'] then
                maxsongs = maxsongs+1
            end
            if maxsongs < table.length(timer_reg) then
                maxsongs = table.length(timer_reg)
            end
            
            if table.length(timer_reg) < maxsongs then
                timer_reg[spell.name] = t+dur
                send_command('timers create "'..spell.name..'" '..dur..' down')
            else
                local rep,repsong
                for i,v in pairs(timer_reg) do
                    if t+dur > v then
                        if not rep or rep > v then
                            rep = v
                            repsong = i
                        end
                    end
                end
                if repsong then
                    timer_reg[repsong] = nil
                    send_command('timers delete "'..repsong..'"')
                    timer_reg[spell.name] = t+dur
                    send_command('timers create "'..spell.name..'" '..dur..' down')
                end
            end
        end
    end]]
    if player.status == 'Engaged' then
        equip(sets.TP)
    else
        equip(sets.aftercast.Idle)
    end
end

function status_change(new, old)
    if new == 'Engaged' then
        equip(sets.TP)
    elseif T{'Idle', 'Resting'}:contains(new) then
        equip(sets.aftercast.Idle)
    end
end

function self_command(cmd)
    if cmd == 'unlock' then
        enable('main', 'sub', 'ammo')
    elseif cmd == 'midact' then
        midaction(false)
    elseif cmd == 'idle' then
        sets.aftercast._index = sets.aftercast._index % (#sets.aftercast._tab) + 1
        windower.add_to_chat(
            8,
            'Aftercast Set: ' .. sets.aftercast._tab[sets.aftercast._index]
        )
        sets.aftercast.Idle = sets.aftercast[sets.aftercast._tab[sets.aftercast._index]]
        equip(sets.aftercast.Idle)
    end
end

function equip_song_gear(spell)
    if DaurdSongs:contains(spell.english) then
        equip(sets.midcast.Base, sets.midcast.DBuff)
    else
        if spell.target.type == 'MONSTER' then
            equip(
                sets.midcast.Base,
                sets.midcast.Debuff,
                sets.midcast.GBuff
            )
            if buffactive.troubadour or buffactive['elemental seal'] then equip(sets.midcast.Duration) end
            if string.find(spell.english, 'Lullaby') then equip(sets.midcast.Duration, sets.midcast.Lullaby) end
        else
            equip(
                sets.midcast.Base,
                sets.midcast.Buff,
                sets.midcast.GBuff
            )
            if string.find(spell.english, 'Ballad') then equip(sets.midcast.Ballad) end
            if string.find(spell.english, 'Scherzo') then equip(sets.midcast.Scherzo) end
            if string.find(spell.english, 'Paeon') then equip(sets.midcast.Paeon) end
        end
    end
end

function calculate_duration(name)
    local mult, ext = 1, 0
    if player.equipment.range == 'Marsyas' then mult = mult + 1.0 end
    if player.equipment.range == "Loughnashade" then mult = mult + 0.4 end

    if player.equipment.neck == "Moonbow whistle +1" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.1 end
    if player.equipment.body == "Fili Hongreline +3" then mult = mult + 0.1 end
    if player.equipment.legs == "Inyanga Shalwar +2" then mult = mult + 0.1 end
    if player.equipment.main == "Carnwenhan" then mult = mult + 1.0 end

    if string.find(name, 'March') and player.equipment.hands == 'Fili Manchettes +3' then mult = mult + 0.1 end
    if string.find(name, 'Minuet') and player.equipment.body == "Fili Hongreline +3" then mult = mult + 0.1 end
    if string.find(name, 'Madrigal') and player.equipment.head == "Fili Calot +3" then mult = mult + 0.1 end
    if string.find(name, 'Ballad') and player.equipment.legs == "Fili Rhingrave +3" then mult = mult + 0.1 end
    if string.find(name, 'Scherzo') and player.equipment.feet == "Fili Cothurnes +3" then mult = mult + 0.1 end
    if string.find(name, 'Paeon') and player.equipment.head == "Bihu Roundlet +1" then mult = mult + 0.1 end

    if buffactive.Troubadour then mult = mult * 2 end
    if string.find(name, 'Scherzo') and buffactive['Soul Voice'] then
        mult = mult * 2
    elseif string.find(name, 'Scherzo') and buffactive.marcato then
        mult = mult * 1.5
    end

    if buffactive['Clarion Call'] then ext = 20 end

    return mult * 120 + ext
end

function reset_timers()
    for i, v in pairs(timer_reg) do send_command('timers delete "' .. i .. '"') end
    timer_reg = {}
end

windower.register_event('zone change', reset_timers)
windower.register_event('logout', reset_timers)