-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Notes: 
-- Order of states applied:
--   sets.engaged[state.CombatForm][state.CombatWeapon][state.OffenseMode][state.DefenseMode][classes.CustomMeleeGroups (any number)]
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()

    ------------------------
    -- TVR FALLBACK RING ---
    ------------------------

    gear.Cornelia_Or_Epaminondas = { name = "Epaminondas's Ring" }
    gear.Cornelia_Or_Sroda = { name = "Sroda Ring" }
    gear.Cornelia_Or_Niqmaddu = { name = "Niqmaddu Ring" }
    gear.Cornelia_Or_Regal = { name = "Regal Ring" }
    gear.Cornelia_Or_Ilabrat = { name = "Ilabrat Ring" }
    gear.Cornelia_Or_Gere = { name = "Gere Ring" }

    gear.Lehko_Or_Chirich1 = {name="Chirich Ring +1", bag="wardrobe7"}
    gear.Lehko_Or_Chirich2 = {name="Chirich Ring +1", bag="wardrobe8"}
    gear.Lehko_Or_Begrudging = {name="Begrudging Ring" }
    gear.Lehko_Or_Dingir = {name="Dingir Ring" }
    gear.Lehko_Or_Hetairoi = {name="Hetairoi Ring"}
    gear.Lehko_Or_Moonlight2 = {name="Moonlight Ring", bag="wardrobe8"}
    gear.Lehko_Or_Petrov = {name="Petrov Ring"}

    gear.Gerubu_Or_Stikini1 = {name="Stikini Ring +1", bag="wardrobe7"}
    gear.Gerubu_Or_Stikini2 = {name="Stikini Ring +2", bag="wardrobe8"}
    gear.Gerubu_Or_Shadow = { name = "Shadow Ring" }

    if item_available("Cornelia's Ring") then
        gear.Cornelia_Or_Epaminondas = { name = "Cornelia's Ring" }     
        gear.Cornelia_Or_Sroda = { name = "Cornelia's Ring" }
        gear.Cornelia_Or_Niqmaddu = { name = "Cornelia's Ring" }
        gear.Cornelia_Or_Regal = { name = "Cornelia's Ring" }
        gear.Cornelia_Or_Ilabrat = { name = "Cornelia's Ring" }
        gear.Cornelia_Or_Gere = { name = "Cornelia's Ring" }
    end   

    if item_available("Lehko Habhoka's Ring") then
        gear.Lehko_Or_Chirich1 = { name = "Lehko Habhoka's Ring" }
        gear.Lehko_Or_Chirich2 = { name = "Lehko Habhoka's Ring" }
        gear.Lehko_Or_Begrudging = { name = "Lehko Habhoka's Ring" }
        gear.Lehko_Or_Dingir = { name = "Lehko Habhoka's Ring" }
        gear.Lehko_Or_Hetairoi = { name = "Lehko Habhoka's Ring" }
        gear.Lehko_Or_Moonlight2 = { name = "Lehko Habhoka's Ring" }
        gear.Lehko_Or_Petrov = { name = "Lehko Habhoka's Ring" }
    end
 

    if item_available("Gurebu's Ring") then
        gear.Gerubu_Or_Stikini1 = { name = "Gurebu's Ring" }
        gear.Gerubu_Or_Stikini2 = { name = "Gurebu's Ring" }
        gear.Gerubu_Or_Shadow = { name = "Gurebu's Ring" }
    end

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
    ----- PRIO. ITEMS -----
    -----------------------
    
    gear.Platinum_Moogle_Belt = {name="Platinum Moogle Belt", priority=999}
    
    -----------------------
    -- Augmented Weapons --
    -----------------------

    gear.Malevolence_A = {name="Malevolence", augments={'INT+9','Mag. Acc.+10','"Mag.Atk.Bns."+9','"Fast Cast"+4',}}
    gear.Malevolence_B = {name="Malevolence", augments={'INT+10','"Mag.Atk.Bns."+6',}}

    gear.Colada_ENH = {name="Colada", augments={'Enh. Mag. eff. dur. +4','STR+5','Mag. Acc.+18',}}

    gear.Gada_ENH = {name="Gada", augments={'Enh. Mag. eff. dur. +6','Mag. Acc.+16',}}
    gear.Gada_INDI = { name="Gada", augments={'Indi. eff. dur. +11','DMG:+3',}}

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

    gear.Telchine_REGEN_Body = { name="Telchine Chas.", augments={'"Regen" potency+3',}}
    gear.Telchine_REGEN_Hands = { name="Telchine Gloves", augments={'"Regen" potency+3',}}
    gear.Telchine_REGEN_Legs = { name="Telchine Braconi", augments={'"Regen" potency+3',}}
    gear.Telchine_REGEN_Feet = { name="Telchine Pigaches", augments={'Mag. Evasion+25','Song spellcasting time -6%','"Regen" potency+3',}}
    gear.Telchine_CURE_Hands = { name="Telchine Gloves", augments={'Mag. Evasion+19','"Cure" potency +8%','MND+9',}}

    gear.Yorium_PHLX_Head = {name="Yorium Barbuta", augments={'Phalanx +3',}}
    gear.Yorium_PHLX_Body = {name="Yorium Cuirass", augments={'Phalanx +3',}}

    --------------------------
    -- ESCHA AUGMENTED GEAR --
    --------------------------

    gear.Eschite_C_Feet = {name="Eschite Greaves", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}, priority=18}
    gear.Eschite_D_Legs = { name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}, priority=52}

    gear.Rawhide_B_Hands = {name="Rawhide Gloves", augments={'HP+50','Accuracy+15','Evasion+20',}}

    gear.Chironic_ENF_Legs = {name="Chironic Hose", augments={'Mag. Acc.+29','"Cure" spellcasting time -9%','MND+10','"Mag.Atk.Bns."+15',}}
    gear.Chironic_PHLX_Legs = {name="Chironic Hose", augments={'Attack+7','Crit.hit rate+1','Phalanx +5','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}

    gear.Herc_FC_Head = { name="Herculean Helm", augments={'"Mag.Atk.Bns."+1','"Fast Cast"+6','INT+3','Mag. Acc.+10',}}
    gear.Herc_PHLX_Body = { name="Herculean Vest", augments={'CHR+9','AGI+3','Phalanx +4','Mag. Acc.+3 "Mag.Atk.Bns."+3',}}
    gear.Herc_PHLX_Hands = { name="Herculean Gloves", augments={'"Fast Cast"+2','Attack+25','Phalanx +4','Mag. Acc.+13 "Mag.Atk.Bns."+13',}}

    gear.Valo_PET_Body = {name="Valorous Mail", augments={'Pet: Mag. Acc.+24','Pet: "Dbl.Atk."+4 Pet: Crit.hit rate +4','Pet: MND+8','Pet: Accuracy+12 Pet: Rng. Acc.+12',}}
    gear.Valo_QA_Body = { name="Valorous Mail", augments={'Crit.hit rate+5','STR+8','Quadruple Attack +2','Accuracy+19 Attack+19',}}
    gear.Valo_STP_Body = { name="Valorous Mail", augments={'Mag. Acc.+12','"Store TP"+8','AGI+3','Accuracy+8','Attack+5',}}
    gear.Valo_STP_Feet = { name="Valorous Greaves", augments={'Attack+30','"Store TP"+7','VIT+2','Accuracy+15',}}
    gear.Ody_STP_Legs = { name="Odyssean Cuisses", augments={'"Store TP"+7','STR+7','Accuracy+10','Attack+15',}}
    gear.Ody_CURE_Feet = {name="Odyssean Greaves", augments={'Accuracy+29','"Cure" potency +6%','STR+5','Attack+1',}}

    gear.Merlinic_FC_Feet = {name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+7','CHR+6','Mag. Acc.+7',}}
    gear.Merlinic_MB_Feet = {name="Merlinic Crackows", augments={'Mag. Acc.+22','Magic burst dmg.+11%','INT+3','"Mag.Atk.Bns."+10',}}
    gear.Merlinic_BP_Hands = {name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+13 Pet: "Mag.Atk.Bns."+13','Blood Pact Dmg.+8','Pet: DEX+2','Pet: Mag. Acc.+10','Pet: "Mag.Atk.Bns."+8',}}

    gear.Merlinic_DRAIN_Head = { name="Merlinic Hood", augments={'Mag. Acc.+30','"Drain" and "Aspir" potency +11','MND+10',}}
    gear.Merlinic_DRAIN_Body = { name="Merlinic Jubbah", augments={'Mag. Acc.+9 "Mag.Atk.Bns."+9','"Drain" and "Aspir" potency +11','CHR+9','Mag. Acc.+15','"Mag.Atk.Bns."+1',}}
    gear.Merlinic_DRAIN_Hands = { name="Merlinic Dastanas", augments={'Mag. Acc.+27','"Drain" and "Aspir" potency +11','CHR+3','"Mag.Atk.Bns."+12',}}

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

    gear.Kaykaus_C_Feet = { name="Kaykaus Boots +1", augments={'MP+80','Spell interruption rate down +12%','"Cure" spellcasting time -7%',}}
    gear.Kaykaus_C_Head = { name="Kaykaus Mitra +1", augments={'MP+80','Spell interruption rate down +12%','"Cure" spellcasting time -7%',}}

    gear.Amalric_A_Head = {name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_A_Body = {name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_D_Hands = {name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_A_Legs = {name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_D_Feet = {name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}}

    gear.Souveran_C_Head = { name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=280}
    gear.Souveran_C_Body = { name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=171}
    gear.Souveran_C_Hands = { name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=239}
    gear.Souveran_C_Legs = { name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=163}
    gear.Souveran_D_Feet = { name="Souveran Schuhs +1", augments={'HP+65','Attack+25','Magic dmg. taken -4',}, priority=187}

    gear.Ryuo_A_Hands = {name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}}
    gear.Ryuo_C_Head = {name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}
    gear.Ryuo_C_Feet = {name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}}
    gear.Ryuo_D_Legs = {name="Ryuo Hakama +1", augments={'Accuracy+25','"Store TP"+5','Phys. dmg. taken -4',}}

    gear.Rao_D_Head = {name="Rao Kabuto +1", augments={'VIT+12','Attack+25','"Counter"+4',}}

    gear.Rao_C_Body = {name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
    gear.Rao_C_Hands = {name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
    gear.Rao_C_Legs = {name="Rao Haidate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
    gear.Rao_C_Feet = {name="Rao Sune-Ate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}

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
    "Trizek Ring", "Echad Ring", "Facility Ring", "Capacity Ring", "Reraise Hairpin", "Airmid's Gorget", "Nexus Cape",
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

function unbind_numpad()
    send_command('unbind !numpad/')
    send_command('unbind !numpad*')
    send_command('unbind !numpad-')
    send_command('unbind !numpad+')
    send_command('unbind !numpad7')
    send_command('unbind !numpad8')
    send_command('unbind !numpad9')  
    send_command('unbind !numpad4')
    send_command('unbind !numpad5')
    send_command('unbind !numpad6')
    send_command('unbind !numpad1')
    send_command('unbind !numpad2')
    send_command('unbind !numpad3')
    send_command('unbind !numpad0')
    send_command('unbind !numpad.')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad+')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad9')  
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad3')
    send_command('unbind ^numpad0')
    send_command('unbind ^numpad.')
    send_command('unbind @numpad/')
    send_command('unbind @numpad*')
    send_command('unbind @numpad-')
    send_command('unbind @numpad+')
    send_command('unbind @numpad7')
    send_command('unbind @numpad8')
    send_command('unbind @numpad9')  
    send_command('unbind @numpad4')
    send_command('unbind @numpad5')
    send_command('unbind @numpad6')
    send_command('unbind @numpad1')
    send_command('unbind @numpad2')
    send_command('unbind @numpad3')
    send_command('unbind @numpad0')
    send_command('unbind @numpad.')
    send_command('unbind ~numpad7')
    send_command('unbind ~numpad8')
    send_command('unbind ~numpad9')
    send_command('unbind ~numpad4')
    send_command('unbind ~numpad5')
    send_command('unbind ~numpad6')
    send_command('unbind ~numpad1')
    send_command('unbind ~numpad0')
    send_command('unbind @numpadenter')
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


function check_moving()
    if state.DefenseMode.value == 'None'  and state.Kiting.value == false then
        if state.Auto_Kite.value == false and moving then
            state.Auto_Kite:set(true)
        elseif state.Auto_Kite.value == true and moving == false then
            state.Auto_Kite:set(false)
        end
    end
end

function item_available(item)
	if player.inventory[item] or player.wardrobe[item] or player.wardrobe2[item] or player.wardrobe3[item] or player.wardrobe4[item] or player.wardrobe5[item] or player.wardrobe6[item] or player.wardrobe7[item] or player.wardrobe8[item] then
		return true
	else
		return false
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
    if no_swap_gear:contains(player.equipment.neck) then
        disable("neck")
    else
        enable("neck")
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
        if no_swap_gear:contains(player.equipment.neck) then
            enable("neck")
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