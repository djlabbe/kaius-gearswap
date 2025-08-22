function get_sets()
 
        send_command('bind f9 gs c toggle TP set')
        send_command('bind f10 gs c toggle Idle set')
		send_command('bind f11 gs c toggle Weapons')
		send_command('input /macro book 9;wait .1;input /macro set 1')
		send_command('wait 6;input /lockstyleset 011')
         function file_unload()
    
        send_command('unbind ^f9')
        send_command('unbind ^f10')
		send_command('unbind ^f11')

        send_command('unbind !f9')
        send_command('unbind !f10')
		send_command('unbind !f11')
		
        send_command('unbind f9')
        send_command('unbind f10')
		send_command('unbind f11')
 
        end    
		
		--Weapons--
		
		sets.Weapons = {}
		
		sets.Weapons.Index = {'SwordShield', 'ClubShield', 'Chango', 'SO'}
		Weapons_ind = 1
		
		sets.Weapons.SwordShield = {main ="Naegling", sub ="Blurred Shield +1"}
		
		sets.Weapons.ClubShield = {main ="Loxotic Mace +1", sub ="Blurred Shield +1"}
		
		sets.Weapons.Chango = {main ="Chango", sub ="Utu Grip"}
		
		sets.Weapons.SO = {main ="Shining One", sub ="Utu Grip"}

		
        --Idle Sets--  
        sets.Idle = {}
       
        sets.Idle.index = {'Standard'}
        Idle_ind = 1                  
       
        sets.Idle.Standard = {
		    ammo="Staunch Tathlum +1",
			head={ name="Sakpata's Helm", augments={'Path: A',}},
			body={ name="Sakpata's Plate", augments={'Path: A',}},
			hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
			legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
			feet={ name="Sakpata's Leggings", augments={'Path: A',}},
			neck={ name="Bathy Choker +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Hearty Earring",
			right_ear="Infused Earring",
			left_ring="Defending Ring",
			right_ring="Shneddick Ring",
			back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
}								
        --TP Sets--
        sets.TP = {}
 
           sets.TP.index = {'Standard','DT'}
                --1=Standard, 2 = DT, 
				
                TP_ind = 1
					sets.TP.Standard = {
					ammo={ name="Coiste Bodhar", augments={'Path: A',}},
					head="Hjarrandi Helm",
					body="Boii Lorica +3",
					hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
					legs="Pumm. Cuisses +3",
					feet="Pumm. Calligae +3",
					neck={ name="War. Beads +1", augments={'Path: A',}},
					waist={ name="Sailfi Belt +1", augments={'Path: A',}},
					left_ear={ name="Schere Earring", augments={'Path: A',}},
					right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','Crit.hit rate+5',}},
					left_ring="Niqmaddu Ring",
					right_ring="Moonlight Ring",
					back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        }                                              
                sets.TP.DT = {
					ammo={ name="Coiste Bodhar", augments={'Path: A',}},
					head={ name="Sakpata's Helm", augments={'Path: A',}},
					body="Boii Lorica +3",
					hands={ name="Sakpata's Gauntlets", augments={'Path: A',}},
					legs={ name="Sakpata's Cuisses", augments={'Path: A',}},
					feet={ name="Sakpata's Leggings", augments={'Path: A',}},
					neck={ name="Vim Torque +1", augments={'Path: A',}},
					waist={ name="Sailfi Belt +1", augments={'Path: A',}},
					left_ear={ name="Schere Earring", augments={'Path: A',}},
					right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','Crit.hit rate+5',}},
					left_ring="Niqmaddu Ring",
					right_ring="Chirich Ring +1",
					back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
        }
									
       --Weaponskill Sets--
        sets.WS = {}
       
        sets.Resolution = {}
		
		sets.Resolution.Index ={'Attack'}
		
		Reso_ind= 1
		
		sets.Resolution.Attack = {
			ammo="Knobkierrie",
			head={ name="Nyame Helm", augments={'Path: B',}},
			body={ name="Nyame Mail", augments={'Path: B',}},
			hands="Boii Mufflers +3",
			legs="Boii Cuisses +3",
			feet={ name="Nyame Sollerets", augments={'Path: B',}},
			neck={ name="War. Beads +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Thrud Earring",
			right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			left_ring="Sroda Ring",
			right_ring="Cornelia's Ring",
			back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
		}                                                 
        sets.Ukkos = {} 
		sets.Ukkos.Index ={'Attack'}		
		Ukkos_Ind = 1		
		sets.Ukkos.Atack = {			
			ammo="Knobkierrie",
			head={ name="Nyame Helm", augments={'Path: B',}},
			body={ name="Nyame Mail", augments={'Path: B',}},
			hands="Boii Mufflers +3",
			legs="Boii Cuisses +3",
			feet={ name="Nyame Sollerets", augments={'Path: B',}},
			neck={ name="War. Beads +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Thrud Earring",
			right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			left_ring="Sroda Ring",
			right_ring="Cornelia's Ring",
			back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},}

		sets.Decimation = {}
		sets.Decimation.Index ={'Attack'}		
		KJ_Ind= 1		
		sets.Decimation.Attack = {		
			ammo="Knobkierrie",
			head={ name="Nyame Helm", augments={'Path: B',}},
			body={ name="Nyame Mail", augments={'Path: B',}},
			hands="Boii Mufflers +3",
			legs="Boii Cuisses +3",
			feet={ name="Nyame Sollerets", augments={'Path: B',}},
			neck={ name="War. Beads +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Thrud Earring",
			right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			left_ring="Sroda Ring",
			right_ring="Cornelia's Ring",
			back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},}
									
    	sets.Upheavel = {}
		sets.Upheavel.Index ={'Attack'}
		Upheavel_ind= 1
		sets.Upheavel.AttackLowTP = {
			ammo="Knobkierrie",
			head={ name="Nyame Helm", augments={'Path: B',}},
			body={ name="Nyame Mail", augments={'Path: B',}},
			hands="Boii Mufflers +3",
			legs="Boii Cuisses +3",
			feet={ name="Nyame Sollerets", augments={'Path: B',}},
			neck={ name="War. Beads +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Thrud Earring",
			right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			left_ring="Sroda Ring",
			right_ring="Cornelia's Ring",
			back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Damage taken-5%',}},
}
									  
		sets.Upheavel.AttackHighTP = {
			ammo="Knobkierrie",
			head={ name="Nyame Helm", augments={'Path: B',}},
			body={ name="Nyame Mail", augments={'Path: B',}},
			hands="Boii Mufflers +3",
			legs="Boii Cuisses +3",
			feet={ name="Nyame Sollerets", augments={'Path: B',}},
			neck={ name="War. Beads +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Thrud Earring",
			right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			left_ring="Sroda Ring",
			right_ring="Cornelia's Ring",
			back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%','Damage taken-5%',}},				
        }
		sets.SB ={}
		sets.SB.Attack = {
			ammo="Knobkierrie",
			head={ name="Nyame Helm", augments={'Path: B',}},
			body={ name="Nyame Mail", augments={'Path: B',}},
			hands="Boii Mufflers +3",
			legs="Boii Cuisses +3",
			feet={ name="Nyame Sollerets", augments={'Path: B',}},
			neck={ name="War. Beads +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Thrud Earring",
			right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			left_ring="Sroda Ring",
			right_ring="Cornelia's Ring",
			back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},
			}	
		sets.HS = {}		
		sets.HS.Attack = { 			
			ammo="Knobkierrie",
			head={ name="Nyame Helm", augments={'Path: B',}},
			body={ name="Nyame Mail", augments={'Path: B',}},
			hands="Boii Mufflers +3",
			legs="Boii Cuisses +3",
			feet={ name="Nyame Sollerets", augments={'Path: B',}},
			neck={ name="War. Beads +1", augments={'Path: A',}},
			waist={ name="Sailfi Belt +1", augments={'Path: A',}},
			left_ear="Thrud Earring",
			right_ear={ name="Moonshade Earring", augments={'Accuracy+4','TP Bonus +250',}},
			left_ring="Sroda Ring",
			right_ring="Cornelia's Ring",
			back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Damage taken-5%',}},}
        --Ninja Magic Sets--
        sets.NINMagic = {}
       				
	    sets.NINMagic.Utsusemi ={
                              head="Dampening Tam",neck="Loricate Torque +1", ear1="Brutal Earring",ear2="Cessance Earring",
                              body="Emet harness +1",hands="Sulev. Gauntlets +2",ring1="Chirich Ring +1",ring2="Petrov Ring",
                              back="Moonbeam Cape",waist="Carrier's Sash",legs="Herculean Trousers",feet="Valorous Greaves"}
 
                                              
        --Utility Sets--
        sets.Utility = {}
       
        sets.Utility.Weather = {waist="Hachirin-no-obi",back="Twilight Cape"}
 
        sets.Utility.MB = {head="Herculean Helm",body="Amalric Doublet",ear1="Static Earring",ring1="Locus Ring",ring2="Mujin Band"} 
       
        sets.Utility.Stoneskin = {head="Haruspex hat",neck="Stone Gorget",ear1="Loquac. earring",ear2="Earthcry earring",
                                                          body="Assim. jubbah +1",hands="Stone Mufflers",ring1="Rahab ring",
                                                          back="Swith cape",waist="Siegel sash",legs="Haven hose",feet="Valorous Greaves"}
                                                         
        sets.Utility.Phalanx = {head="Haruspex hat",neck="Colossus's torque",ear1="Loquac. earring",ear2="Augment. earring",
                                                    body="Assim. jubbah +1",hands="Ayao's gages",ring1="Rahab ring",
                                                        back="Swith cape",waist="Pythia sash +1",legs="Portent pants",feet="Valorous Greaves"}
                                                       
        sets.Utility.Steps = {ammo="Coiste Bodhar",
							head="Boii Mask +1", body={ name="Valorous Mail", augments={'Accuracy+20 Attack+20','"Store TP"+8','Accuracy+12','Attack+8',}}, hands="Rawhide Gloves",legs=="Odyssean Cuisses",
							feet="Valorous Greaves", neck="Subtlety Spec.",waist="Chaac Belt", left_ear="Heartseeker Earring",
							right_ear="Dignitary's Earring", left_ring="Yacuruna Ring", right_ring="Cacoethic Ring",  back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},}
                                                 
		sets.Utility.Doomed = {waist="Gishdubar Sash", ring1 ="Eshmun's Ring"}
		
		sets.Utility.Enmity = {    
							ammo="Sapience Orb",
							head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
							body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
							hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
							legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
							feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
							neck={ name="Unmoving Collar +1", augments={'Path: A',}},
							waist="Flume Belt +1",
							left_ear="Trux Earring",
							right_ear={ name="Boii Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','Crit.hit rate+5',}},
							left_ring="Supershear Ring",
							right_ring="Petrov Ring",
							back={ name="Cichol's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},}
		
		sets.Utility.Sleeping = {neck="Opo-Opo Necklace"}
        --Job Ability Sets--
       
        sets.JA = {}
               
		sets.JA.Berserk ={back = "Cichol's Mantle",feet = "Agoge Calligae +1", body = "Pumm. Lorica +3"}

		sets.JA.Aggressor = { body={ name="Agoge Lorica +1", augments={'Enhances "Aggressive Aim" effect',}}, head ="Pummeler's mask +2"}
		
		sets.JA.Warcry = {head = "Agoge Mask +1"}		
		
		sets.JA.MightyStrikes = {hands = "Agoge Mufflers +1"}
		
		sets.JA.Ret ={feet = "Boii Calligae +2"}
		
		sets.JA.BloodRage ={body = "Ravager's Lorica +2"}
		
		sets.JA.Tomahawk = {ammo = "Throwing Tomahawk",
						feet = "Agoge Calligae +1", waist ="Chaac Belt", 
						head={ name="Valorous Mask", augments={'Blood Pact Dmg.+3','Potency of "Cure" effect received+7%','"Treasure Hunter"+2','Mag. Acc.+7 "Mag.Atk.Bns."+7',}}}

		sets.JA.Restraint ={}
        --Precast Sets--
        sets.precast = {}
       
        sets.precast.FC = {}
       
       sets.precast.FC.Standard = { ammo="Sapience Orb",
							head="Carmine Mask +1", 
							body="Odyssean Chestplate",
							hands="Leyline Gloves",
							legs={ name="Odyssean Cuisses", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Fast Cast"+3','INT+1','Mag. Acc.+9','"Mag.Atk.Bns."+3',}},
						    feet="Ahosi Leggings",
							neck="Voltsurge Torque",
							waist="Witful Belt",
							left_ear="Etiolation Earring",
						    right_ear="Loquac. Earring",
							left_ring="Rahab Ring",
							right_ring="Kishar Ring", 
							back="Swith Cape +1"}
       
end
 
  
function precast(spell)
        if spell.type == 'Magic' then
                equip(sets.precast.FC.Standard)
        elseif spell.english == 'Resolution' or spell.english == 'Shockwave' or spell.english == 'Stardiver' or spell.english == 'Impulse Drive' or spell.english == "Vorpal Blade" then
                equip(sets.Resolution.Attack)
        elseif spell.english == "Ukko's Fury" then
                equip(sets.Ukkos.Attack)
        elseif spell.english == 'Savage Blade' or spell.english == 'Ground Strike' or spell.english == 'Steel Cyclone' or spell.english == "Mistral Axe" or spell.english =='Fell Cleave' or spell.english == "Judgment" or spell.english == 'Black Halo'
				or spell.english == "Metatron Torment" then
			equip(sets.SB.Attack)
		elseif spell.english == "Decimation"  then
                equip(sets.Decimation.Attack)
        elseif spell.english == "Upheaval"  then
			equip(sets.Upheavel.AttackHighTP)
		elseif spell.english =='Scourge' then
			equip(sets.Upheavel.AttackHighTP)
		elseif spell.english =="Hexa Strike" then
			equip(sets.HS.Attack)
		elseif spell.english =='Berserk' then
			equip(set_combine(sets.Utility.Enmity,sets.JA.Berserk))
		elseif spell.english =='Aggressor' then
			equip(set_combine(sets.Utility.Enmity,sets.JA.Aggressor))
		elseif spell.english =='Warcry' then
			equip(set_combine(sets.Utility.Enmity,sets.JA.Warcry))
		elseif spell.english =='Tomahawk' then
			equip(set_combine(sets.Utility.Enmity,sets.JA.Tomahawk))
		elseif spell.english =='Bloodrage' then
			equip(set_combine(sets.Utility.Enmity,sets.JA.BloodRage))
		elseif spell.english =='Mighty Strikes' then
			equip(set_combine(sets.Utility.Enmity,sets.JA.MightyStrikes))
		elseif spell.english =='Provoke' then
			equip(sets.Utility.Enmity)
		elseif spell.english == 'Box Step' then
                equip(sets.Utility.Steps)
        elseif spell.type == 'Weapon Skill' then
			equip(sets.Resolution.Attack)
		end
       
end
       
function midcast(spell,act)
		if spell.skill =='Ninjutsu' then
			equip(sets.NINMagic.Nuke)
			 if spell.element == world.day_element or spell.element == world.weather_element then
                              equip(set_combine(sets.NINMagic.Nuke,sets.Utility.Weather))
                        end
		end
		
	    if spell.english == 'Utsusemi: Ichi' then
                equip(sets.NINMagic.Utsusemi)
                        if buffactive['Copy Image (3)'] then
                                send_command('@wait 0.3; input //cancel Copy Image*')
                        end
                        if buffactive['Copy Image (2)'] then
                                send_command('@wait 0.3; input //cancel Copy Image*')
                        end
                        if buffactive['Copy Image (1)'] then
                                send_command('@wait 0.3; input //cancel Copy Image*')
                        end
                        if buffactive['Copy Image'] then
                                send_command('@wait 0.3; input //cancel Copy Image*')
                        end
        end
 
        if spell.english == 'Utsusemi: Ni'  or spell.english == 'Utsusemi: San' then
                equip(sets.NINMagic.Utsusemi)
        end
end	
 
function aftercast(spell)
        if player.status == 'Engaged' then
                equip(sets.TP[sets.TP.index[TP_ind]])
				if buffactive['doom'] then
					equip(sets.Utility.Doom)
				end
				if buffactive['terror'] or buffactive['stun'] or buffactive['sleep']	then 
					equip(sets.TP.DT)
				end

		else
                equip(sets.Idle[sets.Idle.index[Idle_ind]])					
					if buffactive['doom'] then
					equip(sets.Utility.Doom)
				end
				if buffactive['terror'] or buffactive['stun'] or buffactive['sleep']	then 
					equip(sets.TP.DT)
				end

        end
end

 
function status_change(new,old)
        if player.status == 'Engaged' then
                equip(sets.TP[sets.TP.index[TP_ind]])
        else
                equip(sets.Idle[sets.Idle.index[Idle_ind]])					
        end
end 
function self_command(command)
        if command == 'toggle TP set' then
                TP_ind = TP_ind +1
                if TP_ind > #sets.TP.index then TP_ind = 1 end
                send_command('@input /echo <----- TP Set changed to '..sets.TP.index[TP_ind]..' ----->')
                equip(sets.TP[sets.TP.index[TP_ind]])
        elseif command == 'toggle Idle set' then
                Idle_ind = Idle_ind +1
                if Idle_ind > #sets.Idle.index then Idle_ind = 1 end
                send_command('@input /echo <----- Idle Set changed to '..sets.Idle.index[Idle_ind]..' ----->')
                equip(sets.Idle[sets.Idle.index[Idle_ind]])
		elseif command == 'toggle Weapons' then
                Weapons_ind = Weapons_ind +1
               if Weapons_ind > #sets.Weapons.Index then Weapons_ind = 1 end
                send_command('@input /echo <----- Weapons Set changed to '..sets.Weapons.Index[Weapons_ind]..' ----->')
                equip(sets.Weapons[sets.Weapons.Index[Weapons_ind]])
        elseif command == 'equip TP set' then
                equip(sets.TP[sets.TP.index[TP_ind]])
        elseif command == 'equip Idle set' then
                equip(sets.Idle[sets.Idle.index[Idle_ind]])
        end
end