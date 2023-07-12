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
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--  Abilities:  [ CTRL+- ]          Primary step element cycle forward.
--              [ CTRL+= ]          Primary step element cycle backward.
--              [ ALT+- ]           Secondary step element cycle forward.
--              [ ALT+= ]           Secondary step element cycle backward.
--              [ CTRL+[ ]          Toggle step target type.
--              [ CTRL+] ]          Toggle use secondary step.
--              [ Numpad0 ]         Perform Current Step
--
--  Spells:     [ WIN+, ]           Utsusemi: Ichi
--              [ WIN+. ]           Utsusemi: Ni
--
--              (Global-Binds.lua contains additional non-job-related keybinds)

-------------------------------------------------------------------------------------------------------------------
--  Custom Commands (preface with /console to use these in macros)
-------------------------------------------------------------------------------------------------------------------

--  gs c step                       Uses the currently configured step on the target, with either <t> or
--                                  <stnpc> depending on setting.
--  gs c step t                     Uses the currently configured step on the target, but forces use of <t>.
--
--  gs c cycle mainstep             Cycles through the available steps to use as the primary step when using
--                                  one of the above commands.
--  gs c cycle altstep              Cycles through the available steps to use for alternating with the
--                                  configured main step.
--  gs c toggle usealtstep          Toggles whether or not to use an alternate step.
--  gs c toggle selectsteptarget    Toggles whether or not to use <stnpc> (as opposed to <t>) when using a step.


-------------------------------------------------------------------------------------------------------------------
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
    state.Buff['Climactic Flourish'] = buffactive['climactic flourish'] or false
    state.Buff['Sneak Attack'] = buffactive['sneak attack'] or false
end

function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.IdleMode:options('Normal', 'DT')
    state.MainStep = M{['description']='Main Step', 'Box Step', 'Quickstep', 'Feather Step', 'Stutter Step'}
    state.AltStep = M{['description']='Alt Step', 'Feather Step', 'Quickstep', 'Stutter Step', 'Box Step'}
    state.UseAltStep = M(false, 'Use Alt Step')
    state.SelectStepTarget = M(false, 'Select Step Target')
    state.IgnoreTargetting = M(true, 'Ignore Targetting')

    state.WeaponSet = M{['description']='Weapon Set', 'Twash_TP', 'Twash_Gleti', }
    state.WeaponLock = M(false, 'Weapon Lock')

    gear.Artifact_Head = { name= "Maxixi Tiara +1" }
    gear.Artifact_Body = { name= "Maxixi Casaque +3" }
    gear.Artifact_Hands = { name= "Maxixi Bangles +1" }
    gear.Artifact_Legs = { name= "Maxixi Tights +1" }
    gear.Artifact_Feet = { name= "Maxixi Toe shoes +1" }

    gear.Relic_Head = { name= "Horos Tiara +3" }
    gear.Relic_Body = { name= "Horos Casaque +3" }
    gear.Relic_Hands = { name= "Horos Bangles +3" }
    gear.Relic_Legs = { name= "Horos Tights +3" }
    -- gear.Relic_Feet = { name= "Horos Toe shoes +3" }

    gear.Empyrean_Head = { name= "Maculele Tiara +3" }
    gear.Empyrean_Body = { name= "Maculele Casaque +2" }
    gear.Empyrean_Hands = { name= "Maculele Bangles +2" }
    gear.Empyrean_Legs = { name= "Maculele Tights +2" }
    gear.Empyrean_Feet = { name= "Maculele Toe shoes +3" }


    gear.DNC_TP_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+8','Phys. dmg. taken-10%',}}
    gear.DNC_WS1_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    gear.DNC_WS2_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}
    gear.DNC_WS3_Cape = { name="Senuna's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}

    include('Global-Binds.lua')

    send_command('bind !insert gs c cycleback mainstep')
    send_command('bind !delete gs c cycle mainstep')
    send_command('bind !home gs c cycleback altstep')
    send_command('bind !end gs c cycle altstep')

    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind !F1 input /ja "Trance" <me>')
    send_command('bind !F2 input /ja "Grand Pas" <me>')

    send_command('bind !` input /ja "Saber Dance" <me>')
    send_command('bind ^` input /ja "Fan Dance" <me>')
    send_command('bind @` input /ja "Chocobo Jig II" <me>')
    send_command('bind @1 gs c step')
    send_command('bind @2 gs c step2')
    send_command('bind !t input /ja "Animated Flourish" <t>')
    

    send_command('bind ^numpad7 gs c set WeaponLock false;gs c set WeaponSet Twash_TP; gs c set WeaponLock true')
    send_command('bind ^numpad8 gs c set WeaponLock false;gs c set WeaponSet Twash_Gleti; gs c set WeaponLock true')

    if player.sub_job == 'SAM' then
        set_macro_page(1, 19)
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
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
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
    send_command('unbind ^numlock')
    send_command('unbind ^numpad/')
    send_command('unbind ^numpad*')
    send_command('unbind ^numpad-')
    send_command('unbind ^numpad+')
    send_command('unbind ^numpadenter')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad1')
    send_command('unbind numpad0')
    send_command('unbind ^numpad0')
    send_command('unbind ^numpad.')

    send_command('unbind #`')
    send_command('unbind #1')
    send_command('unbind #2')
    send_command('unbind #3')
    send_command('unbind #4')
    send_command('unbind #5')
    send_command('unbind #6')
    send_command('unbind #7')
    send_command('unbind #8')
    send_command('unbind #9')
    send_command('unbind #0')
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
        -- ear2="Trux Earring", --5
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
        ring1="Carbuncle Ring", --CHR
        ring2="Metamor. Ring +1", --CHR
        -- back=gear.DNC_WTZ_Cape,
        waist="Carrier's Sash",
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
        hands="Gazu Bracelets +1",
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
        ear1="Digni. Earring",
        ear2="Enchntr. Earring +1",
        ring1="Metamor. Ring +1",
        ring2=gear.Stikini_2,
        waist="Eschan Stone",
        back=gear.DNC_TP_Cape,
        } -- Magic Accuracy

    sets.precast.Flourish1['Desperate Flourish'] = {
        ammo="Yamarang",
        head=gear.Artifact_Head,
        body=gear.Artifact_Body,
        hands="Gazu Bracelets +1",
        legs=gear.Nyame_Legs,
        feet=gear.Artifact_Feet,
        neck="Etoile Gorget +2",
        ear1="Cessance Earring",
        ear2="Telos Earring",
        ring1="Regal Ring",
        ring2=gear.Chirich_2,
        back=gear.DNC_TP_Cape,
        } -- Accuracy

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {hands=gear.Empyrean_Hands, back="Toetapper Mantle"}
    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {body=gear.Empyrean_Body}
    sets.precast.Flourish3['Climactic Flourish'] = {head=gear.Empyrean_Head,}

    sets.precast.FC = {
        ammo="Sapience Orb",
        head=gear.Herc_WSD_head, --7
        body=gear.Taeon_FC_body, --9
        hands="Leyline Gloves", --8
        legs="Rawhide Trousers", --5
        feet=gear.Nyame_Feet, --2
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
        ammo="Aurgelmir Orb +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Epaminondas's Ring",
        back=gear.DNC_WS1_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS.Acc = set_combine(sets.precast.WS, {
        ammo="Voluspa Tathlum",
        ear2="Telos Earring",
    })

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
        ear1="Sherida Earring",
        ear2="Macu. Earring +1",
        back=gear.DNC_WS2_Cape,
    })

    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {
        ammo="Voluspa Tathlum",
        ear2="Telos Earring",
    })

    sets.precast.WS['Pyrrhic Kleos'] = {
        ammo="Coiste Bodhar",
        head=gear.Empyrean_Head,
        body=gear.Relic_Body,
        hands=gear.Adhemar_B_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Mache Earring +1",
        ring1="Regal Ring",
        ring2="Gere Ring",
        back=gear.DNC_WS2_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS['Pyrrhic Kleos'], {
        ammo="Voluspa Tathlum",
        hands=gear.Adhemar_A_Hands,
        legs=gear.Nyame_Legs,
    })

    sets.precast.WS['Evisceration'] = {
        ammo="Coiste Bodhar",
        head="Blistering Sallet +1",
        body=gear.Gleti_Body,
        hands=gear.Adhemar_B_Hands,
        legs=gear.Lustratio_B_Legs,
        feet=gear.Adhemar_B_Feet,
        neck="Fotia Gorget",
        ear1="Odr Earring",
        ear2="Moonshade Earring",
        ring1="Gere Ring",
        ring2="Regal Ring",
        waist="Fotia Belt",
        back=gear.DNC_WS3_Cape,
    }

    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {
        body=gear.Relic_Body,
        legs=gear.Gleti_Legs,
        feet=gear.Artifact_Feet,
        ring1="Regal Ring",
    })

    sets.precast.WS['Rudra\'s Storm'] = set_combine({
        ammo="Coiste Bodhar",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Etoile Gorget +2",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Regal Ring",
        ring2="Epaminondas's Ring",
        back=gear.DNC_WS1_Cape,
        waist="Kentarch Belt +1",
    }, {
        ring1="Cornelia's Ring",
    })

    sets.precast.WS['Rudra\'s Storm'].Acc = set_combine(sets.precast.WS['Rudra\'s Storm'], {
        ammo="Voluspa Tathlum",
        ear2="Telos Earring",
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

    sets.precast.Skillchain = {
        hands=gear.Empyrean_Hands,
    }

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Midcast Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --11
        body=gear.Taeon_Phalanx_body, --10
        hands="Rawhide Gloves", --15
        legs=gear.Taeon_Phalanx_legs, --10
        feet=gear.Taeon_Phalanx_Feet, --10
        neck="Loricate Torque +1", --5
        ear1="Halasz Earring", --5
        ear2="Magnetic Earring", --8
        ring2="Evanescence Ring", --5
    }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Defense Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    sets.Kiting = {feet="Skd. Jambeaux +1"}

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Engaged Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        ammo="Aurgelmir Orb +1",
        head=gear.Adhemar_B_Head,
        body=gear.Relic_Body,
        hands=gear.Adhemar_B_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Etoile Gorget +2",
        ear1="Cessance Earring",
        ear2="Macu. Earring +1",
        ring1="Gere Ring",
        ring2="Epona's Ring",
        back=gear.DNC_TP_Cape,
        waist="Windbuffet Belt +1",
    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
    })

    -- * DNC Native DW Trait: 30% DW
    -- * DNC Job Points DW Gift: 5% DW

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
        ammo="Coiste Bodhar",
        head=gear.Malignance_Head,
        body=gear.Empyrean_Body, --11
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Empyrean_Feet,
        neck="Etoile Gorget +2",
        ear1="Eabani Earring", --4
        ear2="Suppanomimi", --5
        ring1="Gere Ring",
        ring2="Epona's Ring",
        back=gear.DNC_TP_Cape,
        waist="Reiki Yotai", --7
    } --35 + 27 = 62


    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
    })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = {
        ammo="Coiste Bodhar",
        head=gear.Malignance_Head,
        body=gear.Empyrean_Body, --11
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Empyrean_Feet,
        neck="Etoile Gorget +2",
        ear1="Eabani Earring", --4
        ear2="Suppanomimi", --5
        ring1="Gere Ring",
        ring2="Epona's Ring",
        back=gear.DNC_TP_Cape,
        waist="Reiki Yotai", --7
    }

    sets.engaged.DW.Acc.LowHaste = set_combine(sets.engaged.DW.LowHaste, {
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
    })
    
    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = {
        ammo="Coiste Bodhar",
        head=gear.Adhemar_B_Head,
        body=gear.Empyrean_Body, --11
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Empyrean_Feet,
        neck="Etoile Gorget +2",
        ear1="Eabani Earring", --4
        ear2="Suppanomimi", --5
        ring1="Gere Ring",
        ring2="Epona's Ring",
        back=gear.DNC_TP_Cape,
        waist="Reiki Yotai", --7
        } -- 16%

    sets.engaged.DW.Acc.MidHaste = set_combine(sets.engaged.DW.MidHaste, {

        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
    })

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = {
        ammo="Coiste Bodhar",
        head=gear.Adhemar_B_Head,
        body=gear.Relic_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Empyrean_Feet,
        neck="Etoile Gorget +2",
        ear1="Eabani Earring", --4
        ear2="Balder Earring +1",
        ring1="Gere Ring",
        ring2="Epona's Ring",
        back=gear.DNC_TP_Cape,
        waist="Sailfi Belt +1",
      } -- 4% Gear

    sets.engaged.DW.Acc.HighHaste = set_combine(sets.engaged.DW.HighHaste, {
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
    })

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = {
        ammo="Coiste Bodhar",
        head=gear.Adhemar_B_Head,
        body=gear.Relic_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Empyrean_Feet,
        neck="Etoile Gorget +2",
        ear1="Sherida Earring",
        ear2="Balder Earring +1",
        ring1="Gere Ring",
        ring2="Epona's Ring",
        back=gear.DNC_TP_Cape,
        waist="Sailfi Belt +1",
    } -- 0%

    sets.engaged.DW.Acc.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, {
        ear2="Telos Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
    })

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Hybrid Sets -------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.engaged.Hybrid = {
        head=gear.Malignance_Head, --6/6
        body=gear.Gleti_Body, --9/0
        legs=gear.Malignance_Legs, --7/7
        hands=gear.Gleti_Hands, --7/0  
        ring1=gear.Moonlight_1, --5/5
        ring2=gear.Moonlight_2, --5/5
        back=gear.DNC_TP_Cape, --10/0
    } --49/23

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.Acc.DT = set_combine(sets.engaged.Acc, sets.engaged.Hybrid)

    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT = set_combine(sets.engaged.DW.Acc, sets.engaged.Hybrid)

    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.LowHaste = set_combine(sets.engaged.DW.Acc.LowHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MidHaste = set_combine(sets.engaged.DW.Acc.MidHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.HighHaste = set_combine(sets.engaged.DW.Acc.HighHaste, sets.engaged.Hybrid)

    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHaste = set_combine(sets.engaged.DW.Acc.MaxHaste, sets.engaged.Hybrid)

     ------------------------------------------------------------------------------------------------
    ----------------------------------------- Idle Sets --------------------------------------------
    ------------------------------------------------------------------------------------------------

    sets.resting = {}

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head=gear.Gleti_Head,
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Gleti_Feet,
        neck="Bathy Choker +1",
        ear1="Eabani Earring",
        ear2="Etiolation Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.DNC_TP_Cape,
        waist="Engraved Belt",
    }

    sets.idle.DT = set_combine(sets.idle, {
        ammo="Staunch Tathlum +1", --3/3
        head=gear.Malignance_Head, --6/6
        body=gear.Malignance_Body, --9/9
        hands=gear.Malignance_Hands, --5/5
        legs=gear.Malignance_Legs, --7/7
        feet=gear.Malignance_Feet, --4/4
        neck="Warder's Charm +1",
        ear2="Etiolation Earring",
        ring1="Purity Ring", --0/4
        ring2="Defending Ring", --10/10
        back="Moonlight Cape", --6/6
    })

    sets.idle.Town = sets.precast.WS['Rudra\'s Storm']

    ------------------------------------------------------------------------------------------------
    ---------------------------------------- Special Sets ------------------------------------------
    ------------------------------------------------------------------------------------------------
    

    sets.buff['Saber Dance'] = {legs=gear.Relic_Legs}
    sets.buff['Fan Dance'] = {hands=gear.Relic_Hands}
    sets.buff['Climactic Flourish'] = {head=gear.Empyrean_Head}
    -- sets.buff['Closed Position'] = {feet=gear.Relic_Feet}

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Purity Ring", --20
        waist="Gishdubar Sash", --10
    }

    sets.Twash_TP = { main="Twashtar", sub="Fusetto +3" }
    sets.Twash_Gleti = { main="Twashtar", sub="Gleti's Knife" }

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

function job_state_change(field, new_value, old_value)
    if state.WeaponLock.value == true then
        disable('main','sub','range')
    else
        enable('main','sub','range')
    end
    check_weaponset()
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
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

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    determine_haste_group()
    check_moving()
end

function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'MidAcc' or state.OffenseMode.value == 'HighAcc' then
        wsmode = 'Acc'
    end

    return wsmode
end

function customize_idle_set(idleSet)
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

function customize_melee_set(meleeSet)
    --if state.Buff['Climactic Flourish'] then
    --    meleeSet = set_combine(meleeSet, sets.buff['Climactic Flourish'])
    --end
    -- if state.ClosedPosition.value == true then
    --     meleeSet = set_combine(meleeSet, sets.buff['Closed Position'])
    -- end

    return meleeSet
end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        if state.IgnoreTargetting.value == true then
            state.IgnoreTargetting:reset()
            eventArgs.handled = true
        end

        eventArgs.SelectNPCTargets = state.SelectStepTarget.value
    end
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

    local s_msg = state.MainStep.current

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Step: '  ..string.char(31,001)..s_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 1 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 1 and DW_needed <= 9 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 9 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 21 and DW_needed <= 39 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 39 then
            classes.CustomMeleeGroups:append('')
        end
    end
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'step' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end
        send_command('@input /ja "'..state['MainStep'].current..'" <t>')
    end

    if cmdParams[1] == 'step2' then
        if cmdParams[2] == 't' then
            state.IgnoreTargetting:set()
        end
        send_command('@input /ja "'..state['AltStep'].current..'" <t>')
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


-- Automatically use Presto for steps when it's available and we have less than 3 finishing moves
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'Step' then
        local allRecasts = windower.ffxi.get_ability_recasts()
        local prestoCooldown = allRecasts[236]
        --local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']

        if player.main_job_level >= 77 and prestoCooldown < 1 then --and under3FMs then
            cast_delay(1.1)
            send_command('input /ja "Presto" <me>')
        end
    end
end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
end