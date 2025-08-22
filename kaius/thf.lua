-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Modes
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--
-------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
    include('lib/enchantments.lua')
    include('Mote-TreasureHunter')
end

function job_setup()    
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
    state.Buff['Trick Attack'] = buffactive['trick attack'] or false
    state.Buff['Feint'] = buffactive['feint'] or false
    state.Buff.Doom = false
    state.Buff.AM = false

    -- JA IDs for actions that always have TH: Provoke, Animated Flourish
    info.default_ja_ids = S{35, 204}
    -- Unblinkable JA IDs for actions that always have TH: Quick/Box/Stutter Step, Desperate/Violent Flourish
    info.default_u_ja_ids = S{201, 202, 203, 205, 207}
end

function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'PDL')
    state.WeaponskillMode:options('Normal', 'PDL')
    state.RangedMode:options('Normal')
    state.HybridMode:options('Normal', 'DT', 'TH', 'Evasion')
    state.IdleMode:options('Normal')

    state.WeaponSet = M{['description']='Weapon Set',  'Mpu_TP', 'Mpu_Gleti', 'Mpu_Crep', 'Twashtar_Gleti', 'Twashtar_Crep', 'Twashtar_TP', 'Tauret_Gleti', 'Gandring', 'Savage'}
    state.WeaponLock = M(false, 'Weapon Lock')

    gear.Artifact_Head = { name="Pillager's Bonnet +3" }
    gear.Artifact_Body = { name="Pillager's Vest +4" }
    gear.Artifact_Hands = { name="Pillager's Armlets +3" }
    gear.Artifact_Legs = { name="Pillager's Culottes +3" }
    gear.Artifact_Feet = { name="Pillager's Poulaines +3" }

    gear.Relic_Head = { name="Plunderer's Bonnet +3" }
    gear.Relic_Body = { name="Plunderer's Vest +3" }
    gear.Relic_Hands = { name="Plunderer's Armlets +3" }
    gear.Relic_Legs = { name="Plunderer's Culottes +3" }
    gear.Relic_Feet = { name="Plunderer's Poulaines +4" }

    gear.Empyrean_Head = { name="Skulker's Bonnet +3" }
    gear.Empyrean_Body = { name="Skulker's Vest +3" }
    gear.Empyrean_Hands = { name="Skulker's Armlets +2" }
    gear.Empyrean_Legs = { name="Skulker's Culottes +3" }
    gear.Empyrean_Feet = { name="Skulker's Poulaines +3" }

    gear.THF_TP_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}} --X
    gear.THF_WSD_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --X
    gear.THF_CRIT_Cape = { name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}} --X

    include('Global-Binds.lua')
    send_command('bind ^` gs c cycle treasuremode')
    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind !F1 input /ja "Perfect Dodge" <me>')
    send_command('bind !F2 input /ja "Larceny" <t>')

    send_command('bind !` input /ja "Flee" <me>')    
    send_command('bind !f input /ja "Feint" <me>')
    send_command('bind !b input /ja "Bully" <t>')    
    send_command('bind !h input /ja "Hide" <me>')
    send_command('bind !m input /ja "Mug" <t>')
    send_command('bind !y input /ja "Steal" <t>')
    
    if player.sub_job == 'WAR' then
        send_command('bind !t input /ja "Provoke" <t>')
        send_command('bind ^numpad7 gs c set WeaponSet Mpu_TP;/input macro set 1;')
        send_command('bind ^numpad8 gs c set WeaponSet Mpu_Gleti;/input macro set 1;')
        send_command('bind ^numpad9 gs c set WeaponSet Mpu_Crep;/input macro set 1;')
        send_command('bind ^numpad4 gs c set WeaponSet Twashtar_Gleti;/input macro set 2;')
        send_command('bind ^numpad5 gs c set WeaponSet Twashtar_Crep;/input macro set 2;')
        send_command('bind ^numpad6 gs c set WeaponSet Twashtar_TP;/input macro set 2;')
        send_command('bind ^numpad1 gs c set WeaponSet Tauret_Gleti;/input macro set 2;')
        send_command('bind ^numpad2 gs c set WeaponSet Gandring;/input macro set 2;')
        send_command('bind ^numpad3 gs c set WeaponSet Savage;/input macro set 3;')
        set_macro_page(1, 6)
    elseif player.sub_job == 'DNC' then
        send_command('bind !t input /ja "Animated Flourish" <t>')
        send_command('bind ^numpad7 gs c set WeaponSet Mpu_TP;/input macro set 4;')
        send_command('bind ^numpad8 gs c set WeaponSet Mpu_Gleti;/input macro set 4;')
        send_command('bind ^numpad9 gs c set WeaponSet Mpu_Crep;/input macro set 4;')
        send_command('bind ^numpad4 gs c set WeaponSet Twashtar_Gleti;/input macro set 5;')
        send_command('bind ^numpad5 gs c set WeaponSet Twashtar_Crep;/input macro set 5;')
        send_command('bind ^numpad6 gs c set WeaponSet Twashtar_TP;/input macro set 5;')
        send_command('bind ^numpad1 gs c set WeaponSet Tauret_Gleti;/input macro set 5;')
        send_command('bind ^numpad2 gs c set WeaponSet Gandring;/input macro set 5;')
        send_command('bind ^numpad3 gs c set WeaponSet Savage;/input macro set 6;')
        set_macro_page(4, 6)
    else
        send_command('bind ^numpad7 gs c set WeaponSet Mpu_TP;/input macro set 4;')
        send_command('bind ^numpad8 gs c set WeaponSet Mpu_Gleti;/input macro set 4;')
        send_command('bind ^numpad9 gs c set WeaponSet Mpu_Crep;/input macro set 4;')
        send_command('bind ^numpad4 gs c set WeaponSet Twashtar_Gleti;/input macro set 5;')
        send_command('bind ^numpad5 gs c set WeaponSet Twashtar_Crep;/input macro set 5;')
        send_command('bind ^numpad6 gs c set WeaponSet Twashtar_TP;/input macro set 5;')
        send_command('bind ^numpad1 gs c set WeaponSet Tauret_Gleti;/input macro set 5;')
        send_command('bind ^numpad2 gs c set WeaponSet Gandring;/input macro set 5;')
        send_command('bind ^numpad3 gs c set WeaponSet Savage;/input macro set 6;')
        set_macro_page(1, 6)
    end

    -- I put these in for farming abyssea
    
    -- send_command('bind !numpad7 input /equip Main "Ceremonial Dagger"; input /equip Sub "Ceremonial Dagger"; input /ws "Cyclone" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad8 input /equip Main "Ceremonial Dagger"; input /equip Sub "Ceremonial Dagger"; input /ws "Energy Drain" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad9 input /equip Main "Fermion Sword"; input /equip Sub "Ceremonial Dagger"; input /ws "Red Lotus Blade" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad4 input /equip Main "Fermion Sword"; input /equip Sub "Ceremonial Dagger"; input /ws "Seraph Blade" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad5 input /equip Main "Ash Club"; input /equip Sub "Ceremonial Dagger"; input /ws "Seraph Strike" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad6 input /equip Main "Iapetus"; input /ws "Raiden Thrust" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad1 input /equip Main "Irradiance Blade";input /ws "Freezebite" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad2 input /equip Main "Chatoyant Staff"; input /ws "Earth Crusher" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad3 input /equip Main "Chatoyant Staff"; input /ws "Sunburst" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad0 input /equip Main "Lost Sickle"; input /ws "Shadow of Death" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad. input /equip Main "Debahocho +1"; input /equip sub empty; input /ws "Blade: Ei" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad+ input /equip Main "Mutsunokami"; input /ws "Tachi: Jinpu" <t>;gs c set WeaponLock true;')
    -- send_command('bind !numpad- input /equip Main "Mutsunokami"; input /ws "Tachi: Koki" <t>;gs c set WeaponLock true;')
   

    send_command('wait 3; input /lockstyleset 6')

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind ^=')
    send_command('unbind @w')
    send_command('unbind !F1')
    send_command('unbind !F2')
    send_command('unbind !`')    
    send_command('unbind !f')
    send_command('unbind !b')    
    send_command('unbind !h')
    send_command('unbind !m')
    send_command('unbind !t')
    unbind_numpad()
end

function init_gear_sets()
    sets.TreasureHunter = {
        feet=gear.Empyrean_Feet,
    }

    sets.buff['Sneak Attack'] = {}
    sets.buff['Trick Attack'] = {}

    sets.precast.JA['Accomplice'] = { head=gear.Empyrean_Head }
    sets.precast.JA['Collaborator'] = { head=gear.Empyrean_Head }
    sets.precast.JA['Flee'] = { feet=gear.Artifact_Feet }
    sets.precast.JA['Hide'] = { body=gear.Artifact_Body }

    sets.precast.JA['Steal'] = {
        head=gear.Relic_Head,
        feet=gear.Artifact_Feet,
    }

    sets.precast.JA['Despoil'] = { 
        legs=gear.Empyrean_Legs, 
        feet=gear.Empyrean_Feet,
    }

    sets.precast.JA['Perfect Dodge'] = { hands=gear.Relic_Hands }
    sets.precast.JA['Feint'] = { legs=gear.Relic_Legs }

    sets.precast.Waltz = {
        ammo="Yamarang",
        head="Mummu Bonnet +2",
        body="Passion Jacket",
        legs="Dashing Subligar",
        neck="Unmoving Collar +1",
        ear1="Handler's Earring +1",
        ear2="Tuisto Earring",
        ring1="Asklepian Ring",
        ring2="Gelatinous Ring +1",
    }

    sets.precast.Waltz['Healing Waltz'] = {}

    sets.precast.FC = {
        ammo="Sapience Orb",
        head=gear.Herc_FC_Head, --13
        body=gear.Taeon_FC_Body, --9
        hands="Leyline Gloves", --8
        legs="Enif Cosciales", --8
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring2="Prolix Ring", --2
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        body="Passion Jacket",
        ring1="Lebeche Ring",
    })

    sets.precast.WS = {
        ammo="Aurgelmir Orb +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1=gear.Cornelia_Or_Ilabrat,
        ring2=gear.Ephramad_Or_Epaminondas,
        back=gear.THF_WSD_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS['Savage Blade'] = {
        ammo="Coiste Bodhar",
        head=gear.Nyame_Head,
        body=gear.Empyrean_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Rep. Plat. Medal",
        ear1="Telos Earring",
        ear2="Moonshade Earring",
        ring1=gear.Cornelia_Or_Ilabrat,
        ring2=gear.Ephramad_Or_Epaminondas,
        back=gear.THF_WSD_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS.Critical = {
        ammo="Yetshila +1",
    }

    sets.precast.WS['Rudra\'s Storm'] = {
        ammo="Coiste Bodhar",
        head=gear.Nyame_Head,
        body=gear.Empyrean_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Asn. Gorget +2",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1=gear.Cornelia_Or_Ilabrat,
        ring2=gear.Ephramad_Or_Regal,
        waist="Kentarch Belt +1",
        back=gear.THF_WSD_Cape,
    }

    sets.precast.WS["Rudra's Storm"].PDL = set_combine(sets.precast.WS["Rudra's Storm"], {
        ammo="Crepuscular Pebble",
        ear1="Odr Earring",
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
     })

     sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"],{
        ammo="Yetshila +1",
    })

    sets.precast.WS["Rudra's Storm"].PDLSA = set_combine(sets.precast.WS["Rudra's Storm"].PDL, sets.precast.WS["Rudra's Storm"].SA)

    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"],{
        ammo="Yetshila +1",
    })

    sets.precast.WS["Rudra's Storm"].PDLTA = set_combine(sets.precast.WS["Rudra's Storm"].PDL, sets.precast.WS["Rudra's Storm"].TA)

    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"],{
        ammo="Yetshila +1",
    })

    sets.precast.WS["Rudra's Storm"].PDLSATA = set_combine(sets.precast.WS["Rudra's Storm"].PDL, sets.precast.WS["Rudra's Storm"].SATA)

    -- 

    sets.precast.WS['Ruthless Stroke'] = {
        ammo="Coiste Bodhar",
        head=gear.Nyame_Head,
        body=gear.Empyrean_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Asn. Gorget +2",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1=gear.Cornelia_Or_Ilabrat,
        ring2=gear.Ephramad_Or_Regal,
        waist="Kentarch Belt +1",
        back=gear.THF_WSD_Cape,
    }

    sets.precast.WS["Ruthless Stroke"].PDL = set_combine(sets.precast.WS["Ruthless Stroke"], {
        ammo="Crepuscular Pebble",
        ear1="Odr Earring",
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
     })

     sets.precast.WS["Ruthless Stroke"].SA = set_combine(sets.precast.WS["Ruthless Stroke"],{
        ammo="Yetshila +1",
    })

    sets.precast.WS["Ruthless Stroke"].PDLSA = set_combine(sets.precast.WS["Ruthless Stroke"].PDL, sets.precast.WS["Ruthless Stroke"].SA)

    sets.precast.WS["Ruthless Stroke"].TA = set_combine(sets.precast.WS["Ruthless Stroke"],{
        ammo="Yetshila +1",
    })

    sets.precast.WS["Ruthless Stroke"].PDLTA = set_combine(sets.precast.WS["Ruthless Stroke"].PDL, sets.precast.WS["Ruthless Stroke"].TA)

    sets.precast.WS["Ruthless Stroke"].SATA = set_combine(sets.precast.WS["Ruthless Stroke"],{
        ammo="Yetshila +1",
    })

    sets.precast.WS["Ruthless Stroke"].PDLSATA = set_combine(sets.precast.WS["Ruthless Stroke"].PDL, sets.precast.WS["Ruthless Stroke"].SATA)

    sets.precast.WS['Evisceration'] = {
        ammo="Yetshila +1",
        head=gear.Empyrean_Head,
        neck="Fotia Gorget",
        body=gear.Relic_Body,
        hands=gear.Gleti_Hands,
        waist="Fotia Belt",
        legs=gear.Gleti_Legs,
        feet=gear.Gleti_Feet,
        ear1="Odr Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Begrudging Ring",
        back=gear.THF_CRIT_Cape,
    }

    sets.precast.WS['Evisceration'].PDL = {
        ammo="Yetshila +1",
        head=gear.Empyrean_Head,
        neck="Fotia Gorget",
        body=gear.Relic_Body,
        hands=gear.Gleti_Hands,
        waist="Fotia Belt",
        legs=gear.Gleti_Legs,
        feet=gear.Gleti_Feet,
        ear1="Odr Earring",
        ear2="Mache Earring +1",
        ring1="Regal Ring",
        ring2="Gere Ring",
        back=gear.THF_CRIT_Cape,
    }

    sets.precast.WS['Exenterator'] = {
        ammo="Coiste Bodhar",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Relic_Feet,
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Epaminondas's Ring",
        back=gear.THF_WSD_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS['Mandalic Stab'] = sets.precast.WS["Rudra's Storm"]

    sets.precast.WS['Aeolian Edge'] = set_combine(sets.precast.WS, {
        ammo="Ghastly Tathlum +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Baetyl Pendant",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1="Dingir Ring",
        ring2="Epaminondas's Ring",
        waist="Orpheus's Sash",
    })

    sets.midcast.FastRecast = sets.precast.FC

    sets.engaged = {
         ammo="Aurgelmir Orb +1",
        head=gear.Empyrean_Head,
        body=gear.Artifact_Body,
        hands=gear.Malignance_Hands, --5
        legs=gear.Gleti_Legs, --8
        feet=gear.Relic_Feet,
        neck="Asn. Gorget +2",
        ear1="Sherida Earring",
        ear2="Skulker's Earring +2",
        ring1="Gere Ring",
        ring2=gear.Moonlight_2, --5
        back=gear.THF_TP_Cape, --10
        waist="Reiki Yotai", 
    } --28% PDT

    sets.engaged.Hybrid = {
        legs=gear.Empyrean_Legs, --13
        feet=gear.Empyrean_Feet, --4/4
    } -- 28 + 17 = 45% PDT

    sets.engaged.HybridEvasion = {
        ammo="Yamarang",
        head=gear.Malignance_Head, --6/6
        body=gear.Malignance_Body, --9/9
        hands=gear.Malignance_Hands, --5/5
        legs=gear.Malignance_Legs, --7/7
        feet=gear.Malignance_Feet, --7/7
        neck="Asn. Gorget +2",
        ring1="Vengeful Ring", 
        ring2="Ilabrat Ring", 
        waist="Reiki Yotai",
        ear1="Eabani Earring",
        ear2="Balder Earring +1",
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Evasion = set_combine(sets.engaged, sets.engaged.HybridEvasion)
    sets.engaged.TH = set_combine(sets.engaged, sets.TreasureHunter)

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Purity Ring", --20
        waist="Gishdubar Sash", --10
    }

    sets.Mpu_Gleti = {main="Mpu Gandring", sub="Gleti's Knife"}
    sets.Mpu_Crep = {main="Mpu Gandring", sub="Crepuscular Knife"}
    sets.Mpu_TP = {main="Mpu Gandring", sub="Centovente"}
    sets.Twashtar_Gleti = {main="Twashtar", sub="Gleti's Knife"}
    sets.Twashtar_Crep = {main="Twashtar", sub="Crepuscular Knife"}
    sets.Twashtar_TP = {main="Twashtar", sub="Centovente"}
    sets.Tauret_Gleti = {main="Tauret", sub="Gleti's Knife"}
    sets.Gandring = {main="Gandring", sub="Gleti's Knife"}
    sets.Savage = {main="Naegling", sub="Centovente"}

    sets.resting = {}

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head="Null Masque",
        body=gear.Gleti_Body, 
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Empyrean_Feet,
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Sanare Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back="Null Shawl",
        waist="Null Belt",
    }

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Aurgelmir Orb +1",
        head=gear.Empyrean_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Empyrean_Feet,
        neck="Asn. Gorget +2",
        ear1="Sherida Earring",
        ear2="Skulker's Earring +2",
        ring1=gear.Moonlight_1,
        ring2=gear.Moonlight_2,
        back=gear.THF_TP_Cape,
        waist="Reiki Yotai", 
    })

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT =sets.idle.DT

    if (item_available("Shneddick Ring +1")) then
        sets.Kiting = { ring1="Shneddick Ring +1" }
    else
        sets.Kiting =  { feet=gear.Artifact_Feet }
    end

    sets.idle.Town = sets.engaged

end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Utsusemi' then
        if buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
            cancel_spell()
            add_to_chat(123, '**!! '..spell.english..' Canceled: [3+ IMAGES] !!**')
            eventArgs.handled = true
            return
        elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] then
            send_command('cancel 66; cancel 444; cancel Copy Image; cancel Copy Image (2)')
        end
    end
    if spell.type == "WeaponSkill" then
        if state.Buff['Sneak Attack'] == true or state.Buff['Trick Attack'] == true then
            equip(sets.precast.WS.Critical)
        end
        if spell.english == 'Aeolian Edge' then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA/Feint.  Turn those state vars off before default gearing is attempted.
    
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
        state.Buff['Trick Attack'] = false
        state.Buff['Feint'] = false
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-- Called after the default aftercast handling is complete.
function job_post_aftercast(spell, action, spellMap, eventArgs)
    -- If Feint is active, put that gear set on on top of regular gear.
    -- This includes overlaying SATA gear.
    check_buff('Feint', eventArgs)
end

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    -- Check for SATA when equipping gear.  If either is active, equip
    -- that gear specifically, and block equipping default gear.
    check_buff('Sneak Attack', eventArgs)
    check_buff('Trick Attack', eventArgs)
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    th_update(cmdParams, eventArgs)
end


function job_buff_change(buff,gain)
    if buff == "Doom" then
        if gain then
            state.Buff.Doom = true
            send_command('@input /p Doomed.')
        else
            state.Buff.Doom = false
        end
    end

    if buff == "Aftermath: Lv.3" then
        if gain then
            state.Buff.AM = true
        else
            state.Buff.AM = false
        end
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
    check_weaponset()
end

function customize_idle_set(idleSet)
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end

    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

function customize_melee_set(meleeSet)
    check_weaponset()

     if state.TreasureMode.value == 'Fulltime' then
        meleeSet = set_combine(meleeSet, sets.TreasureHunter)
    end

    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    return meleeSet
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode

    if state.OffenseMode.value == 'PDL' then
        wsmode = (wsmode or '') .. 'PDL'
    end

    if state.Buff['Sneak Attack'] then
        wsmode = (wsmode or '') .. 'SA'
    end

    if state.Buff['Trick Attack'] then
        wsmode = (wsmode or '') .. 'TA'
    end

    return wsmode
end

-- Function to display the current relevant user state when doing an update.
-- Return true if display was handled, and you don't want the default info shown.
function display_current_job_state(eventArgs)
    local cf_msg = ''
    if state.CombatForm.has_value then
        cf_msg = ' (' ..state.CombatForm.value.. ')'
    end

    local m_msg = state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        m_msg = m_msg .. '/' ..state.HybridMode.value
    end

    local ws_msg = state.WeaponskillMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002))

    eventArgs.handled = true
end

function job_self_command(cmdParams, eventArgs)
    if (cmdParams[1]:lower() == 'enchantment') then
        handle_enchantment_command(cmdParams)
        eventArgs.handled = true
    end
    gearinfo(cmdParams, eventArgs)
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
        if type(tonumber(cmdParams[2])) == 'number' then
            if tonumber(cmdParams[2]) ~= DW_needed then
            DW_needed = tonumber(cmdParams[2])
            DW = true
            end
        elseif type(cmdParams[2]) == 'string' then
            if cmdParams[2] == 'false' then
                DW_needed = 0
                DW = false
            end
        end
        if type(tonumber(cmdParams[3])) == 'number' then
            if tonumber(cmdParams[3]) ~= Haste then
                Haste = tonumber(cmdParams[3])
            end
        end
        if type(cmdParams[4]) == 'string' then
            if cmdParams[4] == 'true' then
                moving = true
            elseif cmdParams[4] == 'false' then
                moving = false
            end
        end
        if not midaction() then
            job_update()
        end
    end
end

-- State buff checks that will equip buff gear and mark the event as handled.
function check_buff(buff_name, eventArgs)
    if state.Buff[buff_name] then
        equip(sets.buff[buff_name] or {})
        eventArgs.handled = true
    end
end


function check_weaponset()
    equip(sets[state.WeaponSet.current])
end