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

-------------------------------------------------------------------------------------------------------------------
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
    include('lib/enchantments.lua')
end

function job_setup()
    state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false
end

function user_setup()
    state.OffenseMode:options('Normal', 'PDL')
    state.HybridMode:options('Normal', 'DT', 'Regain')
    state.WeaponskillMode:options('Normal', 'PDL')
    state.IdleMode:options('Normal', 'Eva', 'Meva')

    state.WeaponSet = M{['description']='Weapon Set', 'Mpu_TP', 'Mpu_Gleti', 'Mpu_Crep', 'Twash_TP', 'Twash_Gleti', 'Twash_Crep', "Aeneas", "Tauret"  }
    state.WeaponLock = M(false, 'Weapon Lock')

    gear.Artifact_Head = { name= "Maxixi Tiara +3" }
    gear.Artifact_Body = { name= "Maxixi Casaque +3" }
    gear.Artifact_Hands = { name= "Maxixi Bangles +4" }
    gear.Artifact_Legs = { name= "Maxixi Tights +3" }
    gear.Artifact_Feet = { name= "Maxixi Toe shoes +3" }

    gear.Relic_Head = { name= "Horos Tiara +3" }
    gear.Relic_Body = { name= "Horos Casaque +3" }
    gear.Relic_Hands = { name= "Horos Bangles +3" }
    gear.Relic_Legs = { name= "Horos Tights +3" }
    gear.Relic_Feet = { name= "Horos Toe shoes +3" }

    gear.Empyrean_Head = { name= "Maculele Tiara +3" }
    gear.Empyrean_Body = { name= "Maculele Casaque +3" }
    gear.Empyrean_Hands = { name= "Maculele Bangles +3" }
    gear.Empyrean_Legs = { name= "Maculele Tights +3" }
    gear.Empyrean_Feet = { name= "Maculele Toe shoes +3" }

    gear.DNC_STP_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','"Regen"+5',}} --X
    gear.DNC_TP_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}} --X
    gear.DNC_WS1_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --X
    gear.DNC_WS2_Cape = { name="Senuna's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --X
    gear.DNC_WS3_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10','Phys. dmg. taken-10%',}} --X

    include('Global-Binds.lua')

    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind !F1 input /ja "Trance" <me>')
    send_command('bind !F2 input /ja "Grand Pas" <me>')
    send_command('bind !F3 gs c VolteHarness')

    send_command('bind !` input /ja "Saber Dance" <me>')
    send_command('bind ^` input /ja "Fan Dance" <me>')
    send_command('bind @` input /ja "Chocobo Jig II" <me>')
    send_command('bind @1 input /ja "Box Step" <t>')
    send_command('bind @2 input /ja "Quickstep" <t>')
    send_command('bind @3 input /ja "Stutter Step" <t>')
    send_command('bind @4 input /ja "Feather Step" <t>')
    send_command('bind !t input /ja "Animated Flourish" <t>')
    send_command('bind !h input /ja "Haste Samba" <me>')
    send_command('bind !p input /ja "Presto" <me>')
    
    send_command('bind ^numpad7 gs c set WeaponSet Mpu_TP')
    send_command('bind ^numpad8 gs c set WeaponSet Mpu_Gleti')
    send_command('bind ^numpad9 gs c set WeaponSet Mpu_Crep')
    send_command('bind ^numpad4 gs c set WeaponSet Twash_TP')
    send_command('bind ^numpad5 gs c set WeaponSet Twash_Gleti')
    send_command('bind ^numpad6 gs c set WeaponSet Twash_Crep')
    send_command('bind ^numpad1 gs c set WeaponSet Aeneas')
    send_command('bind ^numpad2 gs c set WeaponSet Tauret')

    if player.sub_job == 'DRG' then
        send_command('bind !c input /ja "Ancient Circle" <me>')
        set_macro_page(1, 19)
    elseif player.sub_job == 'SAM' then
        set_macro_page(2, 19)
    elseif player.sub_job == 'WAR' then
        set_macro_page(2, 19)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 19)
    elseif player.sub_job == 'RUN' then
        set_macro_page(4, 19)
    else
        set_macro_page(1, 19)
    end
    
    send_command('wait 3; input /lockstyleset 19')

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^-')
    send_command('unbind ^=')
    send_command('unbind !-')
    send_command('unbind !=')
    send_command('unbind ^]')
    send_command('unbind ^[')
    send_command('unbind ^]')
    send_command('unbind ![')
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind @`')
    send_command('unbind ^,')
    send_command('unbind @f')
    send_command('unbind @c')
    send_command('unbind !p')
    unbind_numpad()
end

function init_gear_sets()

    -- Enmity set
    sets.Enmity = {
        ammo="Sapience Orb", --2
        head="Halitus Helm", --8
        body="Emet Harness +1", --10
        hands=gear.Relic_Hands, --9
        -- feet="Ahosi Leggings", --7
        neck="Unmoving Collar +1", --10
        ear1="Cryptic Earring", --4
        ear2="Trux Earring", --5
        -- ring1="Pernicious Ring", --5
        ring2="Eihwaz Ring", --5
        -- back=gear.DNC_WTZ_Cape, --10
        waist="Kasiri Belt", --3
    }

    sets.precast.JA['Provoke'] = sets.Enmity
    sets.precast.JA['No Foot Rise'] = {body=gear.Relic_Body}
    sets.precast.JA['Trance'] = {head=gear.Relic_Head}

    sets.precast.Waltz = {
        head=gear.Relic_Head, --15
        body=gear.Gleti_Body, --10
        hands=gear.Relic_Hands, -- CHR
        legs="Dashing Subligar", --10
        feet=gear.Artifact_Feet, --10
        neck="Etoile Gorget +2", --10
        ear1="Handler's Earring +1", --CHR
        ear2="Enchntr. Earring +1", --CHR
        ring1="Defending Ring",
        ring2="Metamor. Ring +1", --CHR
        -- back=gear.DNC_WTZ_Cape,
        waist="Platinum Moogle Belt",
    } -- Waltz Potency/CHR (55%)

    sets.precast.WaltzSelf = set_combine(sets.precast.Waltz, {
        head="Mummu Bonnet +2", --(8)
        ring1="Asklepian Ring", --(3)
        -- ear1="Roundel Earring", --5
    }) -- Waltz effects received

    sets.precast.Waltz['Healing Waltz'] = {}
    sets.precast.Samba = {head=gear.Artifact_Head, back=gear.DNC_TP_Cape}
    sets.precast.Jig = {legs=gear.Relic_Legs, feet=gear.Artifact_Feet}

    sets.precast.Step = {
        ammo="Yamarang",
        head=gear.Artifact_Head,
        body=gear.Artifact_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Artifact_Feet,
        neck="Etoile Gorget +2",
        ear1="Mache Earring +1",
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2=gear.Chirich_2,
        waist="Kentarch Belt +1",
        back=gear.DNC_TP_Cape
    }

    sets.precast.Step['Feather Step'] = set_combine(sets.precast.Step, {feet=gear.Empyrean_Feet})
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Animated Flourish'] = sets.Enmity

    sets.precast.Flourish1['Violent Flourish'] = {
        ammo="Yamarang",
        head="Mummu Bonnet +2",
        body=gear.Relic_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Gleti_Feet,
        neck="Etoile Gorget +2",
        ear1="Enchanter's Earring +1",
        ear2="Maculele Earring +1",       
        ring1="Metamor. Ring +1",
        ring2=gear.Stikini_2,
        waist="Eschan Stone",
        back=gear.DNC_TP_Cape,
        } -- Magic Accuracy

    sets.precast.Flourish1['Desperate Flourish'] = {
        ammo="Yamarang",
        head=gear.Artifact_Head,
        body=gear.Artifact_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Artifact_Feet,
        neck="Etoile Gorget +2",
        ear1="Crepuscular Earring",
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2=gear.Chirich_2,
        back=gear.DNC_TP_Cape,
        } -- Accuracy

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {hands=gear.Empyrean_Hands, back="Toetapper Mantle"}
    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {body=gear.Empyrean_Body}
    sets.precast.Flourish3['Climactic Flourish'] = {head=gear.Empyrean_Head}

    sets.precast.FC = {
        ammo="Sapience Orb",
        head=gear.Herc_FC_Head, --13
        body=gear.Taeon_FC_Body, --9
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        feet=gear.Nyame_Feet, 
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring2="Prolix Ring", --2
    }

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        ammo="Impatiens",
        body="Passion Jacket",
        ring1="Lebeche Ring",
    })

    sets.precast.WS = {
        ammo="Coiste Bodhar",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Etoile Gorget +2",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2=gear.Cornelia_Or_Epaminondas,
        back=gear.DNC_WS1_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS.PDL = set_combine(sets.precast.WS, {
        ring1=gear.Ephramad_Or_Regal,
        ear2="Maculele Earring +1"
    })

    sets.precast.WS['Rudra\'s Storm'] = {
        ammo="Coiste Bodhar",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Etoile Gorget +2",
        ear1="Moonshade Earring",
        ear2="Maculele Earring +1",
        ring1=gear.Ephramad_Or_Regal,
        ring2=gear.Cornelia_Or_Epaminondas,
        back=gear.DNC_WS1_Cape,
        waist="Kentarch Belt +1",
    }

    sets.precast.WS['Rudra\'s Storm'].PDL = set_combine(sets.precast.WS['Rudra\'s Storm'], {
        body=gear.Gleti_Body,
    })

    sets.precast.WS['Ruthless Stroke'] = {
        ammo="Coiste Bodhar",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Etoile Gorget +2",
        ear1="Moonshade Earring",
        ear2="Maculele Earring +1",
        ring1=gear.Ephramad_Or_Regal,
        ring2=gear.Cornelia_Or_Epaminondas,
        back=gear.DNC_WS1_Cape,
        waist="Kentarch Belt +1",
    }

    sets.precast.WS['Ruthless Stroke'].PDL = set_combine(sets.precast.WS['Ruthless Stroke'], {
        body=gear.Gleti_Body,
    })

    sets.precast.WS['Pyrrhic Kleos'] = {
        ammo="Coiste Bodhar",
        head=gear.Empyrean_Head,
        body=gear.Relic_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Mache Earring +1",
        ring1=gear.Ephramad_Or_Regal,
        ring2="Gere Ring",
        back=gear.DNC_WS2_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS['Pyrrhic Kleos'].PDL = set_combine(sets.precast.WS['Pyrrhic Kleos'], {
        neck="Etoile Gorget +2",
        ear2="Maculele Earring +1",
    })

    sets.precast.WS['Evisceration'] = {
        -- ammo="Charis Feather",
        ammo="Coiste Bodhar",
        head="Blistering Sallet +1",
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Empyrean_Feet,
        neck="Fotia Gorget",
        ear1="Odr Earring",
        ear2="Maculele Earring +1",
        ring1="Gere Ring",
        ring2=gear.Ephramad_Or_Regal,
        waist="Fotia Belt",
        back=gear.DNC_WS3_Cape,
    }

    sets.precast.WS['Evisceration'].PDL = set_combine(sets.precast.WS['Evisceration'], {
        neck="Etoile Gorget +2",
    })

    sets.precast.WS['Shark Bite'] = {
        ammo="Coiste Bodhar",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Etoile Gorget +2",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Ilabrat Ring",
        ring2=gear.Ephramad_Or_Regal,
        waist="Sailfi Belt +1",
        back=gear.DNC_WS1_Cape,
    }

    sets.precast.WS['Shark Bite'].PDL = set_combine(sets.precast.WS['Shark Bite'], {
        body=gear.Gleti_Body,
        ear2="Maculele Earring +1",
    })
   

    sets.precast.WS['Aeolian Edge'] = {
        ammo="Ghastly Tathlum +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Sibyl Scarf",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1="Metamor. Ring +1",
        ring2="Shiva Ring +1",
        back=gear.DNC_WS1_Cape,
        waist="Orpheus's Sash",
    }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --11
        body=gear.Taeon_Phalanx_Body, --10
        hands="Rawhide Gloves", --15
        legs=gear.Taeon_Phalanx_Legs, --10
        feet=gear.Taeon_Phalanx_Feet, --10
        neck="Loricate Torque +1", --5
        ear1="Halasz Earring", --5
        ear2="Magnetic Earring", --8
        ring2="Evanescence Ring", --5
    }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged = {
        ammo="Coiste Bodhar",
        head=gear.Empyrean_Head,
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Empyrean_Feet,
        neck="Etoile Gorget +2",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        ring1="Gere Ring",
        ring2="Ilabrat Ring",
        back=gear.DNC_TP_Cape,
        waist="Sailfi Belt +1",
    }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.DT = set_combine(sets.engaged, {
        ring2=gear.Moonlight_2, 
    })

    sets.engaged.Regain = set_combine(sets.engaged, {
        head="Turms Cap +1",
        hands="Regal Gloves",
        ear1="Dedition Earring",
        ear2="Crepuscular Earring",
        ring1="Roller's Ring",
        ring2=gear.Chirich_2,
        waist="Sweordfaetels +1",
    })

     ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head="Null Masque",
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Gleti_Feet,
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Sanare Earring",
        ring1=gear.Chirich_1,
        ring2="Purity Ring",
        back="Null Shawl",
        waist="Null Belt",
    }

    sets.idle.Eva = {
        ammo="Yamarang",
        head="Null Masque",
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Bathy Choker +1",
        ear1="Eabani Earring",
        ear2="Balder Earring +1",
        ring1="Vengeful Ring",
        ring2="Ilabrat Ring",
        back="Null Shawl",
        waist="Null Belt",
    }

    sets.idle.Regain = {
        ammo="Aurgelmir Orb +1",
        head='Turms Cap +1',
        body=gear.Gleti_Body,
        hands="Regal Gloves",
        legs=gear.Gleti_Legs,
        feet=gear.Gleti_Feet,
        neck="Loricate Torque +1",
        ear1="Dedition Earring",
        ear2="Odnowa Earring +1",
        ring1="Defending Ring",
        ring2="Roller's Ring",
        back=gear.DNC_STP_Cape,
        waist="Sweordfaetels +1",
    }

    sets.idle.Meva = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1", --3/3
        head=gear.Gleti_Head,
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Gleti_Feet,
        neck="Warder's Charm +1",
        ear2="Etiolation Earring",
        ring1="Defending Ring", --10/10
        ring2="Purity Ring", --0/4
        back=gear.DNC_TP_Cape,
    })

    sets.idle.Town = sets.idle

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    

    sets.buff['Saber Dance'] = {legs=gear.Relic_Legs}
    sets.buff['Fan Dance'] = {hands=gear.Relic_Hands}
    sets.buff['Climactic Flourish'] = {
        head=gear.Empyrean_Head,
        -- ammo="Charis Feather",
    }

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Purity Ring", --20
        waist="Gishdubar Sash", --10
    }

    if (item_available("Shneddick Ring +1")) then
        sets.Kiting = { ring1="Shneddick Ring +1" }
    else
        sets.Kiting = { feet="Skadi's Jambeaux +1" }
    end


    sets.Mpu_TP = { main="Mpu Gandring", sub="Centovente" }
    sets.Mpu_Gleti = { main="Mpu Gandring", sub="Gleti's Knife" }
    sets.Mpu_Crep = { main="Mpu Gandring", sub="Crepuscular Knife" }

    sets.Twash_TP = { main="Twashtar", sub="Centovente" }
    sets.Twash_Gleti = { main="Twashtar", sub="Gleti's Knife" }
    sets.Twash_Crep = { main="Twashtar", sub="Crepuscular Knife" }
   
    sets.Aeneas = { main="Aeneas", sub="Centovente" }
    sets.Tauret = { main="Tauret", sub="Gleti's Knife" }
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    --auto_presto(spell)
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
end

function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == "WeaponSkill" then
        if state.Buff['Climactic Flourish'] then
            equip(sets.buff['Climactic Flourish'])
        end
    end
    if spell.type=='Waltz' and spell.english:startswith('Curing') and spell.target.type == 'SELF' then
        equip(sets.precast.WaltzSelf)
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    -- Weaponskills wipe SATA.  Turn those state vars off before default gearing is attempted.
    if spell.type == 'WeaponSkill' and not spell.interrupted then
        state.Buff['Sneak Attack'] = false
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function job_buff_change(buff,gain)
    if buff == 'Saber Dance' or buff == 'Climactic Flourish' or buff == 'Fan Dance' then
        handle_equipping_gear(player.status)
    end
    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            send_command('@input /p Doomed.')
            disable('ring1','ring2','waist')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

end

function job_state_change(field, new_value, old_value)
    if state.WeaponLock.value == true then
        disable('main','sub','range')
    else
        enable('main','sub','range')
    end
    check_weaponset()
end

function customize_idle_set(idleSet)
    if state.HybridMode.value == 'Regain' then
        idleSet = set_combine(idleSet, sets.idle.Regain)
    end
    
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

function customize_melee_set(meleeSet)
    return meleeSet
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'PDL' then
        wsmode = (wsmode or '') .. 'PDL'
    end
    return wsmode
end



-- Function to display the current relevant user state when doing an update.
-- Set eventArgs.handled to true if display was handled, and you don't want the default info shown.
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
    elseif cmdParams[1] == 'step' then
        send_command('@input /ja "'..state['MainStep'].current..'" <t>')
    elseif cmdParams[1] == 'step2' then
        send_command('@input /ja "'..state['AltStep'].current..'" <t>')
    elseif cmdParams[1] == 'VolteHarness' then
        equip({body="Volte Harness"})
        disable('body')
        send_command('pause 7;@input /item "Volte Harness" <me>;wait 0.5;@input //gs enable body')
    end
    gearinfo(cmdParams, eventArgs)
end

-- Automatically use Presto for steps when it's available 
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        local allRecasts = windower.ffxi.get_ability_recasts()
        local prestoCooldown = allRecasts[236]
        if player.main_job_level >= 77 and prestoCooldown < 1 then
            cast_delay(1.1)
            send_command('input /ja "Presto" <me>')
        end
    end
end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
end

function gearinfo(cmdParams, eventArgs)
    if cmdParams[1] == 'gearinfo' then
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