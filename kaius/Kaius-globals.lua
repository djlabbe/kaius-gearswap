-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()

    ---------------------
    -- DUPLICATE RINGS --
    ---------------------

    gear.Stikini_1 = {name="Stikini Ring +1", bag="wardrobe7"}
    gear.Stikini_2 = {name="Stikini Ring +1", bag="wardrobe8"}

    gear.Chirich_1 = {name="Chirich Ring +1", bag="wardrobe7"}
    gear.Chirich_2 = {name="Chirich Ring +1", bag="wardrobe8"}

    gear.Moonlight_1 = {name="Moonlight Ring", bag="wardrobe7", priority=110}
    gear.Moonlight_2 = {name="Moonlight Ring", bag="wardrobe8", priority=110}

    gear.Varar_1 = {name="Varar Ring +1", bag="wardrobe7"}
    gear.Varar_2 = {name="Varar Ring +1", bag="wardrobe8"}
    
    -----------------------
    -- Augmented Weapons --
    -----------------------

    gear.Malevolence_A = {name="Malevolence", augments={'INT+9','Mag. Acc.+10','"Mag.Atk.Bns."+9','"Fast Cast"+4',}}
    gear.Malevolence_B = {name="Malevolence", augments={'INT+10','"Mag.Atk.Bns."+6',}}

    gear.Colada_ENH = {name="Colada", augments={'Enh. Mag. eff. dur. +4','STR+5','Mag. Acc.+18',}}

    gear.Gada_ENH = {name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+16',}}

    gear.Grioavolr_BP = {name="Grioavolr", augments={'Blood Pact Dmg.+9','Pet: Mag. Acc.+7','Pet: "Mag.Atk.Bns."+17',}}
    gear.Grioavolr_FC = {name="Grioavolr", augments={'"Fast Cast"+6','Mag. Acc.+17','"Mag.Atk.Bns."+13',}}

    -------------------
    -- SKIRMISH GEAR --
    -------------------

    gear.Taeon_SNAP_Head = {name="Taeon Chapeau", augments={'"Snapshot"+5','"Snapshot"+5',}}
    gear.Taeon_FC_Body = {name="Taeon Tabard", augments={'"Fast Cast"+5',}}
    gear.Taeon_SIRD_Body = {name="Taeon Tabard", augments={'Mag. Evasion+20','Spell interruption rate down -10%','HP+48',}}
    gear.Taeon_Phalanx_Body ={name="Taeon Tabard", augments={'Mag. Evasion+15','Spell interruption rate down -10%','Phalanx +3',}}
    gear.Taeon_Phalanx_Hands ={name="Taeon Gloves", augments={'Mag. Evasion+20','Spell interruption rate down -10%','Phalanx +3',}}
    gear.Taeon_Phalanx_Legs = {name="Taeon Tights", augments={'Mag. Evasion+16','Spell interruption rate down -8%','Phalanx +3',}}
    gear.Taeon_Phalanx_Feet ={name="Taeon Boots", augments={'Mag. Evasion+15','Spell interruption rate down -9%','Phalanx +3',}}
    gear.Taeon_Pet_Head = {name="Taeon Chapeau", augments={'Pet: Accuracy+20 Pet: Rng. Acc.+20','Pet: "Dbl. Atk."+4','Pet: Damage taken -4%',}}
    gear.Taeon_Pet_Hands = {name="Taeon Gloves", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}}
    gear.Taeon_Pet_Legs = {name="Taeon Tights", augments={'Pet: Accuracy+18 Pet: Rng. Acc.+18','Pet: "Dbl. Atk."+4','Pet: Damage taken -4%',}}
    gear.Taeon_Pet_Feet = {name="Taeon Boots", augments={'Pet: Accuracy+21 Pet: Rng. Acc.+21','Pet: "Dbl. Atk."+4','Pet: Damage taken -4%',}}
    
    gear.Telchine_ENH_Head = {name="Telchine Cap", augments={'Mag. Evasion+24','"Conserve MP"+3','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_Body = {name="Telchine Chas.", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_Hands= {name="Telchine Gloves", augments={'Mag. Evasion+20','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_Legs = {name="Telchine Braconi", augments={'Mag. Evasion+23','"Conserve MP"+5','Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_Feet = {name="Telchine Pigaches", augments={'Mag. Evasion+19','"Conserve MP"+4','Enh. Mag. eff. dur. +10',}}

    gear.Yorium_PHLX_Head = {name="Yorium Barbuta", augments={'Phalanx +3',}}
    gear.Yorium_PHLX_Body = {name="Yorium Cuirass", augments={'Phalanx +3',}}

    --------------------------
    -- ESCHA AUGMENTED GEAR --
    --------------------------

    gear.Eschite_A_Feet = {name="Eschite Greaves", augments={'HP+80','Enmity+7','Phys. dmg. taken -4',}}
    gear.Eschite_C_Feet = {name="Eschite Greaves", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}}

    gear.Rawhide_B_Hands = {name="Rawhide Gloves", augments={'HP+50','Accuracy+15','Evasion+20',}}

    gear.Chironic_ENF_Legs = {name="Chironic Hose", augments={'Mag. Acc.+29','"Cure" spellcasting time -9%','MND+10','"Mag.Atk.Bns."+15',}}
    gear.Chironic_PHLX_Legs = {name="Chironic Hose", augments={'Attack+7','Crit.hit rate+1','Phalanx +5','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}

    gear.Herc_WSD_Head ={name="Herculean Helm", augments={'Accuracy+14','Weapon skill damage +3%','STR+7','Attack+10',}}

    gear.Valo_PET_Body = {name="Valorous Mail", augments={'Pet: Mag. Acc.+24','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: MND+8','Pet: Accuracy+12 Pet: Rng. Acc.+12',}}
   
    gear.Ody_CURE_Feet = {name="Odyssean Greaves", augments={'Accuracy+29','"Cure" potency +6%','STR+5','Attack+1',}}

    gear.Merl_FC_Feet = {name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+7','CHR+6','Mag. Acc.+7',}}
    gear.Merl_MB_Feet = {name="Merlinic Crackows", augments={'Mag. Acc.+22','Magic burst dmg.+11%','INT+3','"Mag.Atk.Bns."+10',}}
    gear.Merl_BP_Hands = {name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+13 Pet: "Mag.Atk.Bns."+13','Blood Pact Dmg.+8','Pet: DEX+2','Pet: Mag. Acc.+10','Pet: "Mag.Atk.Bns."+8',}}

    --------------
    -- SKY SETS --
    --------------

    gear.Adhemar_A_Head = {name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    gear.Adhemar_B_Head = {name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
    gear.Adhemar_A_Body = {name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    gear.Adhemar_B_Body = {name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}}
    gear.Adhemar_A_Hands = {name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    gear.Adhemar_B_Hands = {name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}}    
    gear.Adhemar_D_Legs = {name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}
    gear.Adhemar_B_Feet = {name="Adhemar Gamashes +1", augments={'STR+12','DEX+12','Attack+20',}}
    gear.Adhemar_D_Feet = {name="Adhemar Gamashes +1", augments={'HP+65','"Store TP"+7','"Snapshot"+10',}}

    gear.Apogee_A_Head = {name="Apogee Crown +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
    gear.Apogee_A_Body = {name="Apogee Dalmatica +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
    gear.Apogee_D_Legs = {name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}}
    gear.Apogee_A_Feet = {name="Apogee Pumps +1", augments={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',}}
    gear.Apogee_B_Feet = {name="Apogee Pumps +1", augments={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}}

    gear.Carmine_D_Head = {name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}
    gear.Carmine_B_Body = {name="Carmine Scale Mail +1", augments={'Accuracy+12','DEX+12','MND+20',}}
    gear.Carmine_D_Hands ={name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}
    gear.Carmine_A_Legs = {name="Carmine Cuisses +1", augments={'HP+80','STR+12','INT+12',}}
    gear.Carmine_D_Legs = {name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}}
    gear.Carmine_B_Feet = {name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}}
    gear.Carmine_D_Feet = {name="Carmine Greaves +1", augments={'HP+80','MP+80','Phys. dmg. taken -4',}}

    gear.Emicho_C_Head = {name="Emicho Coronet +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}}
    gear.Emicho_C_Hands = {name="Emicho Gauntlets +1", augments={'Pet: Accuracy+20','Pet: Attack+20','Pet: "Dbl. Atk."+4',}}
    gear.Emicho_D_Hands = {name="Emicho Gauntlets +1", augments={'Accuracy+25','"Dual Wield"+6','Pet: Accuracy+25',}}

    gear.Kaykaus_B_Head = {name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}
    gear.Kaykaus_A_Body = {name="Kaykaus Bliaut +1", augments={'MP+80','MND+12','Mag. Acc.+20',}} 
    gear.Kaykaus_D_Hands = {name="Kaykaus Cuffs +1", augments={'MP+80','"Conserve MP"+7','"Fast Cast"+4',}}
    gear.Kaykaus_A_Legs = {name="Kaykaus Tights +1", augments={'MP+80','MND+12','Mag. Acc.+20',}}
    gear.Kaykaus_B_Feet = {name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}

    gear.Amalric_A_Head = {name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_A_Body = {name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_D_Hands = {name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_A_Legs = {name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_D_Feet = {name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}}

    gear.Souveran_C_Head = {name="Souveran Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}
    gear.Souveran_C_Body = {name="Souveran Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}
    gear.Souveran_C_Hands = {name="Souveran Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}
    gear.Souveran_C_Legs = {name="Souveran Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}
    gear.Souveran_D_Feet = {name="Souveran Schuhs +1", augments={'HP+65','Attack+25','Magic dmg. taken -4',}}

    gear.Ryuo_A_Hands = {name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}}
    gear.Ryuo_C_Head = {name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}
    gear.Ryuo_C_Feet = {name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}
    gear.Ryuo_D_Legs = {name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}}

    gear.Rao_D_Head = {name="Rao Kabuto +1", augments={'VIT+12','Attack+25','"Counter"+4',}}
    gear.Rao_D_Hands = {name="Rao Kote +1", augments={'MND+12','Mag. Evasion+20','Magic dmg. taken -5',}}
    gear.Rao_D_Feet = {name="Rao Sune-Ate +1", augments={'HP+65','Crit. hit rate+4%','"Dbl.Atk."+4',}}
    gear.Rao_B_Legs = {name="Rao Haidate +1", augments={'STR+12','DEX+12','Attack+20',}}
    
    gear.Lustratio_B_Legs = {name="Lustratio Subligar +1", augments={'Accuracy+20','DEX+8','Crit. hit rate+3%',}}
    gear.Lustratio_D_Feet = {name="Lustratio Leggings +1", augments={'HP+65','STR+15','DEX+15',}}

    ------------------
    -- ODYSSEY SETS --
    ------------------

    gear.Nyame_Head = {name="Nyame Helm", priority=91}
    gear.Nyame_Body = {name="Nyame Mail", priority=136}
    gear.Nyame_Hands = {name="Nyame Gauntlets", priority=91}
    gear.Nyame_Legs= {name="Nyame Flanchard", priority=114}
    gear.Nyame_Feet = {name="Nyame Sollerets", priority=68}

    gear.Sakpata_Head = {name="Sakpata's Helm", priority=91}
    gear.Sakpata_Body = {name="Sakpata's Breastplate", priority=136}
    gear.Sakpata_Hands = {name="Sakpata's Gauntlets", priority=91}
    gear.Sakpata_Legs= {name="Sakpata's Cuisses", priority=114}
    gear.Sakpata_Feet = {name="Sakpata's Leggings", priority=68}

    gear.Gleti_Head = {name="Gleti's Mask", priority=68}
    gear.Gleti_Body = {name="Gleti's Cuirass", priority=91}
    gear.Gleti_Hands = {name="Gleti's Gauntlets", priority=68}
    gear.Gleti_Legs= {name="Gleti's Breeches", priority=79}
    gear.Gleti_Feet = {name="Gleti's Boots", priority=57}

    gear.Mpaca_Head = {name="Mpaca's Cap", priority=61}
    gear.Mpaca_Body = {name="Mpaca's Doublet", priority=84}
    gear.Mpaca_Hands = {name="Mpaca's Gloves", priority=61}
    gear.Mpaca_Legs= {name="Mpaca's Hose", priority=72}
    gear.Mpaca_Feet = {name="Mpaca's Boots", priority=50}

    gear.Ikenga_Head = {name="Ikenga's Hat", priority=57}
    gear.Ikenga_Body = {name="Ikenga's Vest", priority=79}
    gear.Ikenga_Hands = {name="Ikenga's Gloves", priority=57}
    gear.Ikenga_Legs= {name="Ikenga's Trousers", priority=68}
    gear.Ikenga_Feet = {name="Ikenga's Clogs", priority=45}

    gear.Bunzi_Head = {name="Bunzi's Hat", priority=50}
    gear.Bunzi_Body = {name="Bunzi's Robe", priority=72}
    gear.Bunzi_Hands = {name="Bunzi's Gloves", priority=50}
    gear.Bunzi_Legs= {name="Bunzi's Pants", priority=61}
    gear.Bunzi_Feet = {name="Bunzi's Sabots", priority=38}

    gear.Agwu_Head = {name="Agwu's Cap", priority=38}
    gear.Agwu_Body = {name="Agwu's Robe", priority=61}
    gear.Agwu_Hands = {name="Agwu's Gages", priority=38}
    gear.Agwu_Legs= {name="Agwu's Slops", priority=50}
    gear.Agwu_Feet = {name="Agwu's Pigaches", priority=27}

    ----------------
    -- MISC. SETS --
    ----------------

    gear.Malignance_Head = {name="Malignance Chapeau"}
    gear.Malignance_Body = {name="Malignance Tabard"}
    gear.Malignance_Hands = {name="Malignance Gloves"}
    gear.Malignance_Legs= {name="Malignance Tights"}
    gear.Malignance_Feet = {name="Malignance Boots"}

    gear.Tatenashi_Body = {name="Tatenashi Haramaki +1"}
    gear.Tatenashi_Hands = {name="Tatenashi Gote +1"}
    gear.Tatenashi_Legs = {name="Tatenashi Haidate +1"}
    gear.Tatenashi_Feet = {name="Tatenashi Sune-Ate +1"}
end

no_swap_gear = S{"Warp Ring", "Dim. Ring (Dem)", "Dim. Ring (Holla)", "Dim. Ring (Mea)",
    "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring", "Reraise Hairpin", "Nexus Cape",
    "Dev. Bul. Pouch", "Chr. Bul. Pouch", "Liv. Bul. Pouch", "Era. Bul. Pouch", "Quelling B. Quiver",
    "Yoichi's Quiver", "Artemis's Quiver", "Chrono Quiver"}

elemental_degrade_array = {
    ['Aspirs'] = {'Aspir','Aspir II','Aspir III'},
    ['Earth'] = {'Stone','Stone II','Stone III','Stone IV','Stone V','Stone VI'},
    ['Water'] = {'Water','Water II','Water III','Water IV','Water V','Water VI'},
    ['Wind'] = {'Aero','Aero II','Aero III','Aero IV','Aero V','Aero VI'},
    ['Fire'] = {'Fire','Fire II','Fire III','Fire IV','Fire V','Fire VI'},
    ['Ice'] = {'Blizzard','Blizzard II','Blizzard III','Blizzard IV','Blizzard V','Blizzard VI'},
    ['Lightning'] = {'Thunder','Thunder II','Thunder III','Thunder IV','Thunder V','Thunder VI'},
    ['Sleeps'] = {'Sleep','Sleep II',},
}

elemental_ws = S{"Gust Slash", "Cyclone", "Energy Steal", "Energy Drain", "Aeolian Edge",
                 "Burning Blade", "Red Lotus Blade", "Shining Blade", "Seraph Blade", "Spirits Within", "Sanguine Blade", "Atonement",
                 "Frostbite", "Freezebite", "Herculean Slash",
                 "Cloudsplitter", "Primal Rend",
                 "Dark Harvest", "Shadow of Death", "Infernal Scythe",
                 "Thunder Thrust", "Raiden Thrust",
                 "Blade: Teki", "Blade: To", "Blade: Chi", "Blade: Ei", "Blade: Yu",
                 "Tachi: Goten", "Tachi: Kagero", "Tachi: Jinpu", "Tachi: Koki",
                 "Shining Strike", "Seraph Strike", "Flash Nova",
                 "Rock Crusher", "Earth Crusher", "Starburst", "Sunburst", "Cataclysm", "Vidohunir", "Garland of Bliss", "Omniscience",
                 "Flaming Arrow",
                 "Hot Shot", "Wildfire", "Trueflight", "Leaden Salute"}

function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

function handle_strategems(cmdParams)
    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            if player.main_job == 'SCH' then
                send_command('input /ja Perpetuance <me>')
            else
                add_to_chat(122,'Error: ' ..player.job.. ' does not have a Duration strategem.')
            end
        elseif strategem == 'accuracy' then
            if player.main_job == 'SCH' then
                send_command('input /ja Altruism <me>')
            else
                add_to_chat(122,'Error: ' ..player.job.. ' does not have an Accuracy strategem.')
            end
        elseif strategem == 'enmity' then
            if player.main_job == 'SCH' then
                send_command('input /ja Tranquility <me>')
            else
                add_to_chat(122,'Error: ' ..player.job.. ' does not have an Enmity strategem.')
            end
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a Duration strategem.')
        elseif strategem == 'accuracy' then
            if player.main_job == 'SCH' then
                send_command('input /ja Focalization <me>')
            else
                add_to_chat(122,'Error: ' ..player.job.. ' does not have a Duration strategem.')
            end
        elseif strategem == 'enmity' then
            if player.main_job == 'SCH' then
                send_command('input /ja Equanimity <me>')
            else
                add_to_chat(122,'Error: ' ..player.job.. ' does not have a Duration strategem.')
            end
        elseif strategem == 'skillchain' then
            if player.main_job == 'SCH' then
                send_command('input /ja Immanence <me>')
            else
                add_to_chat(122,'Error: ' ..player.job.. ' does not have a Skillchain strategem.')
            end
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts has been activated yet.')
    end
end

function check_gear()
    if no_swap_gear:contains(player.equipment.left_ring) then
        disable("ring1")
    else
        enable("ring1")
    end
    if no_swap_gear:contains(player.equipment.right_ring) then
        disable("ring2")
    else
        enable("ring2")
    end
    if no_swap_gear:contains(player.equipment.head) then
        disable("head")
    else
        enable("head")
    end
    if no_swap_gear:contains(player.equipment.back) then
        disable("back")
    else
        enable("back")
    end
    if no_swap_gear:contains(player.equipment.waist) then
        disable("waist")
    else
        enable("waist")
    end
end

windower.register_event('zone change',
    function()
        if no_swap_gear:contains(player.equipment.left_ring) then
            enable("ring1")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.right_ring) then
            enable("ring2")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.head) then
            enable("head")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.back) then
            enable("back")
            equip(sets.idle)
        end
        if no_swap_gear:contains(player.equipment.waist) then
            enable("waist")
            equip(sets.idle)
        end
    end
)