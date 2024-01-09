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

    -----------------------
    -- Augmented Weapons --
    -----------------------
        
    gear.Malevolence_A = { name="Malevolence", augments={'INT+2','Mag. Acc.+3','"Mag.Atk.Bns."+3',}}
    gear.Malevolence_B = { name="Malevolence", augments={'INT+4','Mag. Acc.+10','"Fast Cast"+3',}}
    gear.Gada_FC = { name="Gada", augments={'"Fast Cast"+6','DMG:+5',}}
    gear.Gada_ENH = { name="Gada", augments={'Enh. Mag. eff. dur. +6','"Mag.Atk.Bns."+15',}}
    gear.Colada_ENH = { name="Colada", augments={'Enh. Mag. eff. dur. +4','MND+1','"Mag.Atk.Bns."+13','DMG:+9',}}

    -------------------
    -- SKIRMISH GEAR --
    -------------------

    gear.Telchine_ENH_Head = { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_Body = { name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}}
    gear.Telchine_ENH_Hands = { name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +8',}}
    gear.Telchine_ENH_Legs = { name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +9',}}
    gear.Telchine_ENH_Feet = { name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}}

    
    --------------------------
    -- ESCHA AUGMENTED GEAR --
    --------------------------

    gear.Eschite_C_Feet = {name="Eschite Greaves", augments={'Mag. Evasion+15','Spell interruption rate down +15%','Enmity+7',}, priority=18}
    gear.Eschite_D_Legs = { name="Eschite Cuisses", augments={'"Mag.Atk.Bns."+25','"Conserve MP"+6','"Fast Cast"+5',}, priority=52}

    gear.Herc_WSD_Head = { name="Herculean Helm", augments={'Attack+23','Weapon skill damage +4%','STR+7',}}
    gear.Herc_WSD_Legs = { name="Herculean Trousers", augments={'Attack+18','Weapon skill damage +4%','STR+5',}}

    gear.Merlinic_FC_Body = { name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+28','"Fast Cast"+7','Mag. Acc.+13',}}
    gear.Chironic_REF_Hands = { name="Chironic Gloves", augments={'Attack+30','"Refresh"+2',}}
    gear.Ody_CURE_Feet = { name="Odyssean Greaves", augments={'Mag. Acc.+9','"Cure" potency +6%','DEX+1','"Mag.Atk.Bns."+14',}}
    
    gear.Valo_PHLX_Head = { name="Valorous Mask", augments={'Weapon skill damage +3%','"Fast Cast"+1','Phalanx +4','Mag. Acc.+12 "Mag.Atk.Bns."+12',}}
    gear.Valo_PHLX_Body = { name="Valorous Mail", augments={'Magic Damage +13','Attack+14','Phalanx +4','Accuracy+16 Attack+16','Mag. Acc.+8 "Mag.Atk.Bns."+8',}}

    --------------
    -- SKY SETS --
    --------------
    
    gear.Kaykaus_B_Head = { name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}
    gear.Kaykaus_B_Feet = { name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}}
    gear.Kaykaus_D_Hands = { name="Kaykaus Cuffs +1", augments={'MP+80','"Conserve MP"+7','"Fast Cast"+4',}}

    gear.Amalric_A_Head = { name="Amalric Coif +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_A_Body = { name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
    gear.Amalric_D_Hands = { name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}

    -- gear.Carmine_D_Head = { name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}
    -- gear.Carmine_B_Body = { name="Carm. Sc. Mail +1", augments={'Accuracy+12','DEX+12','MND+20',}}
    gear.Carmine_D_Hands ={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}}
    gear.Carmine_D_Legs = { name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}}
    -- gear.Carmine_B_Feet = { name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}}

    gear.Adhemar_A_Head = {name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    -- gear.Adhemar_B_Head = {name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}}
    gear.Adhemar_A_Body = {name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    -- gear.Adhemar_B_Body = {name="Adhemar Jacket +1", augments={'STR+12','DEX+12','Attack+20',}}
    gear.Adhemar_A_Hands = {name="Adhemar Wrist. +1", augments={'DEX+12','AGI+12','Accuracy+20',}}
    -- gear.Adhemar_B_Hands = {name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}}    
    gear.Adhemar_D_Legs = {name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}
    gear.Adhemar_B_Feet = { name="Adhe. Gamashes +1", augments={'STR+12','DEX+12','Attack+20',}}
    -- gear.Adhemar_D_Feet = {name="Adhe. Gamashes +1", augments={'HP+65','"Store TP"+7','"Snapshot"+10',}}

    gear.Souveran_C_Head = { name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=280}
    gear.Souveran_C_Body = { name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=171}
    gear.Souveran_C_Hands = { name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=239}
    gear.Souveran_C_Legs = { name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}, priority=163}
    gear.Souveran_D_Feet = { name="Souveran Schuhs +1", augments={'HP+65','Attack+25','Magic dmg. taken -4',}, priority=187}

    ------------------
    -- ODYSSEY SETS --
    ------------------

    gear.Nyame_Head = {name="Nyame Helm"}
    gear.Nyame_Body = {name="Nyame Mail"}
    gear.Nyame_Hands = {name="Nyame Gauntlets"}
    gear.Nyame_Legs= {name="Nyame Flanchard"}
    gear.Nyame_Feet = {name="Nyame Sollerets"}

    gear.Sakpata_Head = {name="Sakpata's Helm", priority=91}
    gear.Sakpata_Body = {name="Sakpata's Breastplate", priority=136}
    gear.Sakpata_Hands = {name="Sakpata's Gauntlets", priority=91}
    gear.Sakpata_Legs= {name="Sakpata's Cuisses", priority=114}
    gear.Sakpata_Feet = {name="Sakpata's Leggings", priority=68}

    gear.Gleti_Head = {name="Gleti's Mask"}
    gear.Gleti_Body = {name="Gleti's Cuirass"}
    gear.Gleti_Hands = {name="Gleti's Gauntlets"}
    gear.Gleti_Legs= {name="Gleti's Breeches"}
    gear.Gleti_Feet = {name="Gleti's Boots"}

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

