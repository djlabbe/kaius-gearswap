-- Original: Motenten / Modified: Arislan

-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Modes:      [ F9 ]              Cycle Offense Mode
--              [ CTRL+F9 ]         Cycle Hybrid Modes
--              [ WIN+F9 ]          Cycle Weapon Skill Modes
--              [ F10 ]             Emergency -PDT Mode
--              [ ALT+F10 ]         Toggle Kiting Mode
--              [ F11 ]             Emergency -MDT Mode
--              [ CTRL+F11 ]        Cycle Casting Modes
--              [ F12 ]             Update Current Gear / Report Current Status
--              [ CTRL+F12 ]        Cycle Idle Modes
--              [ ALT+F12 ]         Cancel Emergency -PDT/-MDT Mode
--              [ WIN+C ]           Toggle Capacity Points Mode
--
--
--              (Global-Binds.lua contains additional non-job-related keybinds)


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    SongMode may take one of three values: None, Placeholder
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle SongMode
    gs c set SongMode Placeholder
    The Placeholder state will equip the bonus song instrument and ensure non-duration gear is equipped.
    Simple macro to cast a placeholder Daurdabla song:
    /console gs c set SongMode Placeholder
    /ma "Shining Fantasia" <me>
    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
    state.SongMode = M{['description']='Song Mode', 'None', 'Placeholder'}
    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false
    state.Buff.Doom = false
end

function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'DT', 'Refresh')

    state.LullabyMode = M{['description']='Lullaby Instrument', 'Harp', 'Horn'}

    state.Carol = M{['description']='Carol',
        'Fire Carol', 'Fire Carol II', 'Ice Carol', 'Ice Carol II', 'Wind Carol', 'Wind Carol II',
        'Earth Carol', 'Earth Carol II', 'Lightning Carol', 'Lightning Carol II', 'Water Carol', 'Water Carol II',
        'Light Carol', 'Light Carol II', 'Dark Carol', 'Dark Carol II',
        }

    state.Threnody = M{['description']='Threnody',
        'Fire Threnody II', 'Ice Threnody II', 'Wind Threnody II', 'Earth Threnody II',
        'Ltng. Threnody II', 'Water Threnody II', 'Light Threnody II', 'Dark Threnody II',
        }

    state.Etude = M{['description']='Etude', 'Sinewy Etude', 'Herculean Etude', 'Learned Etude', 'Sage Etude',
        'Quick Etude', 'Swift Etude', 'Vivacious Etude', 'Vital Etude', 'Dextrous Etude', 'Uncanny Etude',
        'Spirited Etude', 'Logical Etude', 'Enchanting Etude', 'Bewitching Etude'}

    state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'Tauret', 'Carnwenhan' }
    state.WeaponLock = M(true, 'Weapon Lock')

 
    info.ExtraSongInstrument = 'Daurdabla'
    info.ExtraSongs = 2

    gear.Kali_Idle = {name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}
    gear.Kali_Song = {name="Kali", augments={'DMG:+15','CHR+15','Mag. Acc.+15',}}

    gear.Linos_STP = {name="Linos", augments={'Accuracy+12','"Store TP"+3','Quadruple Attack +3',}} -- Missing 1 step, and acc
    gear.Linos_WS = { name="Linos", augments={'Attack+16','Weapon skill damage +3%','STR+6 VIT+6',}} -- BAD STR, Could use more attack or attack/acc
    gear.Linos_MATK = { name="Linos", augments={'"Mag.Atk.Bns."+15',}}

    gear.Artifact_Head = { name= "Brioso Roundlet +1" }
    gear.Artifact_Body = { name= "Brioso Justaucorps +2" }
    gear.Artifact_Hands = { name= "Brioso Cuffs +1" }
    gear.Artifact_Legs = { name= "Brioso Cannions +1" }
    gear.Artifact_Feet = { name= "Brioso Slippers +3" }

    gear.Relic_Head = { name= "Bihu Roundlet +3" }
    gear.Relic_Body = { name= "Bihu Justaucorps +3" }
    gear.Relic_Hands = { name= "Bihu Cuffs +3" }
    gear.Relic_Legs = { name= "Bihu Cannions +3" }
    gear.Relic_Feet = { name= "Bihu Slippers +3" }

    gear.Empyrean_Head = { name= "Fili Calot +3" }
    gear.Empyrean_Body = { name= "Fili Hongreline +3" }
    gear.Empyrean_Hands = { name= "Fili Manchettes +3" }
    gear.Empyrean_Legs = { name= "Fili Rhingrave +3" }
    gear.Empyrean_Feet = { name= "Fili Cothurnes +3" }

    gear.BRD_Song_Cape = { name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10','Phys. dmg. taken-10%',}} --X
    gear.BRD_DW_Cape = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}} --X
    -- gear.BRD_KITE_Cape = { name="Intarabus's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','VIT+10','Enmity+10','DEF+50',}} --X
    gear.BRD_WS2_Cape = { name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --X

    include('Global-Binds.lua')

    send_command('bind !` gs c cycle SongMode')
    send_command('bind ^` input /ma "Chocobo Mazurka" <me>')
    send_command('bind !p input /ja "Pianissimo" <me>')
    send_command('bind !t input /ja "Troubadour" <me>')
    send_command('bind ^t input /ja "Tenuto" <me>')
    send_command('bind !m input /ja "Marcato" <me>')
    send_command('bind !n input /ja "Nightingale" <me>')
    send_command('bind !h input /ma "Horde Lullaby II" <t>')
    send_command('bind !g input /ma "Foe Lullaby II" <t>')

    send_command('bind !insert gs c cycleback Threnody')
    send_command('bind !delete gs c cycle Threnody')

    send_command('bind !pageup gs c cycleback Etude')
    send_command('bind !pagedown gs c cycle Etude')

    send_command('bind !home gs c cycleback Carol')
    send_command('bind !end gs c cycle Carol')

    send_command('bind @` gs c cycle LullabyMode')
    send_command('bind @w gs c toggle WeaponLock')

    send_command('bind @1  gs c set SongMode Placeholder;pause .1;input /ma "Army\'s Paeon VI" <me>')
    send_command('bind @2  gs c set SongMode Placeholder;pause .1;input /ma "Army\'s Paeon V" <me>')
    send_command('bind @3  gs c set SongMode Placeholder;pause .1;input /ma "Army\'s Paeon IV" <me>')
    send_command('bind @4  gs c set SongMode Placeholder;pause .1;input /ma "Army\'s Paeon III" <me>')
    send_command('bind @5  gs c set SongMode Placeholder;pause .1;input /ma "Army\'s Paeon II" <me>')
    
    send_command('bind !F1 input /ja "Soul Voice" <me>')
    send_command('bind !F2 input /ja "Clarion Call" <me>')

    -- ALT + Numpad ===> Songs --
    send_command('bind !numpad7 input /ma "Valor Minuet III" <stpc>')
    send_command('bind !numpad8 input /ma "Valor Minuet IV" <stpc>')
    send_command('bind !numpad9 input /ma "Valor Minuet V" <stpc>')

    send_command('bind !numpad4 input /ma "Victory March" <stpc>')
    send_command('bind !numpad5 input /ma "Honor March" <stpc>')
    send_command('bind !numpad6 input /ma "Blade Madrigal" <stpc>')

    send_command('bind !numpad1 input /ma "Knight\'s Minne V" <stpc>')
    send_command('bind !numpad2 input /ma "Knight\'s Minne IV" <stpc>')
    send_command('bind !numpad3 input /ma "Herculean Etude" <stpc>')

    send_command('bind !numpad0 input /ma "Mage\'s Ballad III" <stpc>')
    send_command('bind !numpad. input /ma "Mage\'s Ballad II" <stpc>')

    if player.sub_job == 'NIN' then
        send_command('bind ^numpad7 gs c set WeaponSet Naegling;input /macro set 1')
        send_command('bind ^numpad9 gs c set WeaponSet Tauret;input /macro set 2')
        send_command('bind ^numpad4 gs c set WeaponSet Carnwenhan;input /macro set 2')
        set_macro_page(1, 10)
    elseif player.sub_job == 'DNC' then
        send_command('bind ^numpad7 gs c set WeaponSet Naegling;input /macro set 3')
        send_command('bind ^numpad9 gs c set WeaponSet Tauret;input /macro set 4')
        send_command('bind ^numpad4 gs c set WeaponSet Carnwenhan;input /macro set 4')
        set_macro_page(3, 10)
    elseif player.sub_job == 'WHM' then
        send_command('bind ^numpad7 gs c set WeaponSet Naegling;input /macro set 5')
        send_command('bind ^numpad9 gs c set WeaponSet Tauret;input /macro set 6')
        send_command('bind ^numpad4 gs c set WeaponSet Carnwenhan;input /macro set 6')
        set_macro_page(5, 10)
    elseif player.sub_job == 'PLD' then
        send_command('bind ^numpad7 gs c set WeaponSet Naegling;input /macro set 7')
        send_command('bind ^numpad9 gs c set WeaponSet Tauret;input /macro set 8')
        send_command('bind ^numpad4 gs c set WeaponSet Carnwenhan;input /macro set 8')
        set_macro_page(7, 10)
    else
        set_macro_page(1, 10)
    end

    send_command('wait 3; input /lockstyleset 10')
    send_command('gs enable range')

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^backspace')
    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind !home')
    send_command('unbind !end')
    send_command('unbind !pageup')
    send_command('unbind !pagedown')
    send_command('unbind @`')
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @r')
    send_command('unbind !t')
    send_command('unbind ^t')
    send_command('unbind !n')
    send_command('unbind !m')
    send_command('unbind !p')
    send_command('unbind !h')
    send_command('unbind !g')
    send_command('unbind @1')
    send_command('unbind @2')
    send_command('unbind @3')
    send_command('unbind @4')
    send_command('unbind @5')
    unbind_numpad()
end

function init_gear_sets()
    sets.precast.FC = {
        head=gear.Bunzi_Head, --10
        body="Inyanga Jubbah +2", --10?
        hands="Gendewitha Gages +1", --7 + 5(song)
        legs=gear.Kaykaus_A_Legs, --7
        feet=gear.Empyrean_Feet, --10
        neck="Baetyl Pendant", --4
        ear1="Enchanter's Earring +1", --2    
        ear2="Etiolation Earring", --1
        ring1="Prolix Ring", --2
        ring2="Kishar Ring", --4
        back="Fi Follet Cape +1", --10
        waist="Embla Sash", --5
    } --74

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        feet="Kaykaus Boots +1", --0/7
        -- ear2="Mendi. Earring", --0/5
    })

    sets.precast.FC.BardSong = set_combine(sets.precast.FC, {
        head=gear.Empyrean_Head, --14
        body=gear.Artifact_Body, --15
    })

    sets.precast.FC.SongPlaceholder = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})

    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
        main="Daybreak", 
        sub="Ammurapi Shield", 
        waist="Shinjutsu-no-Obi +1"
    })

    sets.precast.JA.Nightingale = {feet=gear.Relic_Feet}
    sets.precast.JA.Troubadour = {body=gear.Relic_Body}
    sets.precast.JA['Soul Voice'] = {legs=gear.Relic_Legs}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}

    sets.precast.WS = {
        range=gear.Linos_WS,
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        ring1=gear.Cornelia_Or_Epaminondas,
        ring2="Ilabrat Ring",
        back=gear.BRD_WS2_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS['Evisceration'] = {
        range=gear.Linos_WS,
        head="Blistering Sallet +1",
        neck="Bard's Charm +2",
        body=gear.Relic_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        ear1="Mache Earring +1",
        ear2="Moonshade Earring",
        ring1="Begrudging Ring",
        ring2="Ilabrat Ring",
        back=gear.BRD_WS2_Cape,
    }

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {
        range=gear.Linos_WS,
        body=gear.Relic_Body,
        hands=gear.Relic_Hands,
        back=gear.BRD_WS2_Cape,
    })

    sets.precast.WS['Mordant Rime'] = {
        head=gear.Nyame_Head,
        body=gear.Relic_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        ear1="Ishvara Earring",
        ear2="Regal Earring",
        neck="Bard's Charm +2",
        ring1="Epaminondas's Ring",
        ring2="Metamorph Ring +1",
        waist="Sailfi Belt +1",
        back=gear.BRD_WS2_Cape,
    }

    sets.precast.WS['Rudra\'s Storm'] = {
        head=gear.Nyame_Head,
        body=gear.Relic_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        ear1="Mache Earring +1",
        ear2="Moonshade Earring",
        neck="Bard's Charm +2",
        ring1="Epaminondas's Ring",
        ring2=gear.Cornelia_Or_Ilabrat,
        waist="Kentarch Belt +1",
        back=gear.BRD_WS2_Cape,
    }

    sets.precast.WS['Aeolian Edge'] = {
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Baetyl Pendant",
        ring1="Epaminondas's Ring",
        ring2="Shiva Ring +1",
        ear1="Friomisi Earring",
        ear2="Moonshade Earring",
        waist="Orpheus's Sash",
        back=gear.BRD_WS2_Capem
    }

    sets.precast.WS['Savage Blade'] = {
        range=gear.Linos_WS,
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Bard's Charm +2",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2=gear.Cornelia_Or_Sroda,
        waist="Sailfi Belt +1",
        back=gear.BRD_WS2_Cape,
    }

    sets.precast.WS['Shell Crusher'] = {
        head=gear.Empyrean_Head,
        neck="Moonlight Necklace",
        ear1="Crepuscular Earring",
        ear2="Fili Earring +1",
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        ring1=gear.Stikini_1,
        ring2="Metamorph Ring +1",
        back=gear.BRD_Song_Cape,
        waist="Acuity Belt +1",
    }


    -- General set for recast times.
    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --11
        -- hands=gear.Chironic_WSD_Hands, --20
        neck="Loricate Torque +1",
        ear1="Halasz Earring",
        ear2="Magnetic Earring",
        ring2="Evanescence Ring",
        waist="Rumination Sash",
    }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    -- Gear to enhance certain classes of songs.
    sets.midcast.Ballad = { legs=gear.Empyrean_Legs }
    sets.midcast.Carol = { hands="Mousai Gages +1" }
    sets.midcast.Etude = { head="Mousai Turban +1" }
    sets.midcast.HonorMarch = { range="Marsyas", hands=gear.Empyrean_Hands }
    sets.midcast.Lullaby = {
        body=gear.Empyrean_Body,
        hands=gear.Artifact_Hands,
    }
    sets.midcast.Lullaby = { body=gear.Empyrean_Body }
    sets.midcast.Madrigal = { head=gear.Empyrean_Head }
    sets.midcast.Mambo = { feet="Mousai Crackows +1" }
    sets.midcast.March = { hands=gear.Empyrean_Hands }
    sets.midcast.Minne = { legs="Mousai Seraweels +1" }
    sets.midcast.Minuet = { body=gear.Empyrean_Body }
    sets.midcast.Paeon = { head=gear.Artifact_Head }
    sets.midcast.Threnody = { body="Mousai Manteel +1" }
    sets.midcast['Adventurer\'s Dirge'] = { range="Marsyas", hands=gear.Relic_Hands }
    sets.midcast['Adventurer\'s Dirge'] = { range="Marsyas" }
    sets.midcast['Foe Sirvente'] = { head=gear.Relic_Head }
    sets.midcast['Magic Finale'] = { legs=gear.Empyrean_Legs }
    sets.midcast["Sentinel's Scherzo"] = { feet=gear.Empyrean_Feet }
    sets.midcast["Chocobo Mazurka"] = { range="Marsyas" }

    sets.midcast.SongEnhancing = {
        main="Carnwenhan",
        sub=gear.Kali_Song,
        range="Gjallarhorn",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs="Inyanga Shalwar +2",
        feet=gear.Artifact_Feet,
        neck="Moonbow Whistle +1",
        ear1="Enchanter's Earring +1",
        ear2="Odnowa Earring +1",
        ring1=gear.Moonlight_1,
        ring2="Defending Ring",
        waist="Platinum Moogle Belt",
        back=gear.BRD_Song_Cape,
    }

    -- For song debuffs (duration primary, accuracy secondary)
    sets.midcast.SongEnfeeble = {
        main="Carnwenhan",
        sub="Ammurapi Shield",
        range="Gjallarhorn",
        head=gear.Artifact_Head,
        body=gear.Artifact_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Artifact_Legs,
        feet=gear.Artifact_Feet,
        neck="Moonbow Whistle +1",
        ear1="Crep. Earring",
        ear2="Regal Earring",
        ring1=gear.Stikini_1,
        ring2="Metamor. Ring +1",
        waist="Acuity Belt +1",
        back=gear.BRD_Song_Cape,
    }

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.SongEnfeebleAcc = set_combine(sets.midcast.SongEnfeeble, {
        legs=gear.Artifact_Legs
    })

    -- For Horde Lullaby maxiumum AOE range.
    sets.midcast.SongStringSkill = {
        ear1="Gersemi Earring",
        -- ear2="Darkside Earring",
        body=gear.Empyrean_Body,
        hands="Inyanga Dastanas +2",
        neck="Moonbow Whistle +1",
        waist="Acuity Belt +1",
        legs="Inyanga Shalwar +2",
        feet=gear.Relic_Feet,
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.BRD_Song_Cape,
    }

    -- Placeholder song; minimize duration to make it easy to overwrite.
    sets.midcast.SongPlaceholder = {
        range=info.ExtraSongInstrument,
        head=gear.Bunzi_Head,
        body=gear.Bunzi_Body,
        hands=gear.Bunzi_Hands,
        ring1=gear.Moonlight_1,
        ring2="Defending Ring",
        legs=gear.Bunzi_Legs,
        feet=gear.Bunzi_Feet,
        neck="Loricate Torque +1",       
    }

    sets.midcast["Army's Paeon VI"] = set_combine(sets.midcast.SongPlaceholder, { range="Daurdabla",})
    sets.midcast["Army's Paeon V"] = set_combine(sets.midcast.SongPlaceholder, { range="Daurdabla",})
    sets.midcast["Army's Paeon IV"] = set_combine(sets.midcast.SongPlaceholder, { range="Daurdabla",})
    sets.midcast["Army's Paeon III"] = set_combine(sets.midcast.SongPlaceholder, { range="Daurdabla",})
    sets.midcast["Army's Paeon II"] = set_combine(sets.midcast.SongPlaceholder, { range="Daurdabla",})
    sets.midcast["Army's Paeon"] = set_combine(sets.midcast.SongPlaceholder, { range="Daurdabla",})

    -- Other general spells and classes.
    sets.midcast.Cure = {
        main="Daybreak", --30
        sub="Ammurapi Shield",
        head=gear.Kaykaus_B_Head, --11
        body=gear.Bunzi_Body,
        hands=gear.Kaykaus_D_Hands, --11(+2)/(-6)
        legs=gear.Kaykaus_A_Legs, --11/(+2)/(-6)
        feet=gear.Kaykaus_B_Feet, --11(+2)/(-12)
        neck="Loricate Torque +1",
        ear1="Meili Earring",
        ear2="Fili Earring +1",
        ring1="Menelaus's Ring",
        ring2="Haoma's Ring",
        back="Oretania's Cape +1", --6
        waist="Bishop's Sash",
    }

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        ring1=gear.Stikini_1,
        ring2="Metamor. Ring +1",
        waist="Luminary Sash",
    })

    sets.midcast.StatusRemoval = {
        head=gear.Kaykaus_B_Head, --11
        body=gear.Nyame_Body,
        legs="Vanya Slops",
        feet="Vanya Clogs",
        neck="Loricate Torque +1",
        ear1="Meili Earring",
        ear2="Fili Earring +1",
        ring1="Menelaus's Ring",
        ring2="Haoma's Ring",
        back=gear.BRD_Song_Cape,
        waist="Bishop's Sash",
    }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        -- hands="Hieros Mittens",
        neck="Debilis Medallion",
        back="Oretan. Cape +1",
    })

    sets.midcast['Enhancing Magic'] = {
        main="Carnwenhan",
        sub="Ammurapi Shield",
        head=gear.Telchine_ENH_Head,
        body=gear.Telchine_ENH_Body,
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Telchine_ENH_Legs,
        feet=gear.Telchine_ENH_Feet,
        neck="Loricate Torque +1",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Fi Follet Cape +1",
        waist="Embla Sash",
    }

    sets.midcast.Haste = sets.midcast['Enhancing Magic']

    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {
        waist="Gishdubar Sash", 
    })

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {
        neck="Nodens Gorget", 
        waist="Siegel Sash"
    })

    sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {
        waist="Emphatikos Rope"
    })

    sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {
        ring2="Sheltered Ring"
    })

    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

    sets.midcast['Enfeebling Magic'] = {
        main="Carnwenhan",
        sub="Ammurapi Shield",
        head=empty;
        body="Cohort Cloak +1",
        hands=gear.Artifact_Hands,
        legs=gear.Artifact_Legs,
        feet=gear.Artifact_Feet,
        neck="Moonbow Whistle +1",
        ear1="Crepuscular Earring",
        ear2="Regal Earring",
        ring1="Kishar Ring",
        ring2="Metamor. Ring +1",
        waist="Acuity Belt +1",
        back="Aurist's Cape +1",
    }

    sets.midcast.Dispelga = set_combine(sets.midcast['Enfeebling Magic'], {
        main="Daybreak", 
        sub="Ammurapi Shield", 
        waist="Shinjutsu-no-Obi +1"
    })

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT

    if (item_available("Shneddick Ring +1")) then
        sets.Kiting = { ring1="Shneddick Ring +1" }
    else
        sets.Kiting = { feet=gear.Empyrean_Feet }
    end

    sets.latent_refresh = { waist="Fucho-no-obi" }

    sets.engaged = {
        range=gear.Linos_STP,
        head=gear.Bunzi_Head,
        body="Ashera Harness",
        hands=gear.Bunzi_Hands, --(8/8)
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Bard's Charm +2",
        ear1="Telos Earring",
        ear2="Cessance Earring",
        ring1=gear.Lehko_Or_Chirich1,
        ring2=gear.Chirich_2,
        back=gear.BRD_DW_Cape,
        waist="Sailfi Belt +1", --7

    }

    sets.engaged.Acc = set_combine(sets.engaged, {
        feet=gear.Relic_Feet,
        waist="Kentarch Belt +1",
    })

    -- * DNC Subjob DW Trait: +15%
    -- * NIN Subjob DW Trait: +25%

    -- No Magic Haste (74% DW to cap)
    sets.engaged.DW = {
        range=gear.Linos_STP,
        head=gear.Bunzi_Head,
        body="Ashera Harness",
        hands=gear.Bunzi_Hands, --(8/8)
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet, --(7/7)
        neck="Bard's Charm +2",
        ear1="Eabani Earring", --4
        ear2="Suppanomimi", --5
        ring1=gear.Moonlight_1, --(5/5)
        ring2=gear.Chirich_2, --(5/5)
        back=gear.BRD_DW_Cape, --10
        waist="Sailfi Belt +1",
        } -- 26%

    sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {
        feet="Bihu Slippers +3",
    })

    -- 15% Magic Haste (67% DW to cap)
    sets.engaged.DW.LowHaste = sets.engaged.DW
    sets.engaged.DW.Acc.LowHaste = sets.engaged.DW.Acc

    -- 30% Magic Haste (56% DW to cap)
    sets.engaged.DW.MidHaste = sets.engaged.DW
    sets.engaged.DW.Acc.MidHaste = sets.engaged.DW.Acc

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = sets.engaged.DW
    sets.engaged.DW.Acc.HighHaste = sets.engaged.DW.Acc

    -- 45% Magic Haste (36% DW to cap)
    sets.engaged.DW.MaxHaste = {
        range=gear.Linos_STP,
        head="Ayanmo Zucchetto +2",
        body="Ashera Harness",
        hands=gear.Bunzi_Hands, --(8/8)
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet, --(7/7)
        neck="Bard's Charm +2",
        ear1="Telos Earring", --4
        ear2="Cessance Earring",
        ring1=gear.Lehko_Or_Chirich1,
        ring2="Petrov Ring", 
        back=gear.BRD_DW_Cape, --(10/0)
        waist="Sailfi Belt +1", --7
    } --DT=(41/31)|DW=11

    sets.engaged.DW.MaxHaste.Acc = set_combine(sets.engaged.DW.MaxHaste, {
    })

    sets.engaged.Aftermath = {
        -- head="Volte Tiara",
        body="Ashera Harness",
        -- hands=gear.Telchine_STP_Hands,
        legs=gear.Nyame_Legs,
        -- feet="Volte Spats",
        neck="Bard's Charm +2",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.BRD_DW_Cape,
    }

    sets.engaged.Hybrid = {
        head=gear.Bunzi_Head,
        legs=gear.Nyame_Legs,
        ring1=gear.Moonlight_1,
        ring2=gear.Moonlight_2,
    }

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

    sets.engaged.DW.DT.MaxHastePlus = set_combine(sets.engaged.DW.MaxHastePlus, sets.engaged.Hybrid)
    sets.engaged.DW.Acc.DT.MaxHastePlus = set_combine(sets.engaged.DW.Acc.MaxHastePlus, sets.engaged.Hybrid)

    sets.idle = {
        range="Daurdabla",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Warder's Charm +1",
        ear1="Arete Del Luna +1",
        ear2="Eabani Earring",
        ring1=gear.Moonlight_1,
        ring2=gear.Chirich_2,
        back=gear.BRD_DW_Cape,
        waist="Platinum Moogle Belt",
    }

    sets.idle.Refresh = {
        range="Daurdabla",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Warder's Charm +1",
        ear1="Arete Del Luna +1",
        ear2="Eabani Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.BRD_DW_Cape,
        waist="Platinum Moogle Belt",
    }

    sets.idle.DT = {
        main=gear.Ipetam_Eva,
        sub="Genmei Shield",
        range=gear.Linos_EVA,
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Loricate Torque +1",
        waist="Platinum Moogle Belt",
        left_ear="Eabani Earring",
        right_ear="Infused Earring",
        left_ring="Defending Ring",
        right_ring="Moonlight Ring",
        back=gear.BRD_KITE_Cape,
    }

    sets.idle.MEva = {
        head=gear.Bunzi_Head,
        body=gear.Bunzi_Body,
        hands=gear.Bunzi_Hands,
        legs=gear.Bunzi_Legs, 
        feet=gear.Bunzi_Feet,
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Etiolation Earring",
        ring1="Purity Ring",
        ring2=gear.Moonlight_2,
        back=gear.BRD_Song_Cape, --6/6
        waist="Platinum Moogle Belt",
    }

    sets.idle.Town = sets.idle

    sets.SongDWDuration = { main="Carnwenhan", sub=gear.Kali_Idle }

    sets.buff.Doom = {
        neck="Nicander's Necklace",
        ring1="Eshmun's Ring",
        ring2="Purity Ring",
        waist="Gishdubar Sash",
    }

    sets.Obi = { waist="Hachirin-no-Obi" }
    sets.Naegling = { main="Naegling", sub="Fusetto +2" }
    sets.Carnwenhan = { main="Carnwenhan", sub="Gleti's Knife" }
    sets.Tauret = { main="Tauret", sub="Gleti's Knife" }
    sets.DefaultShield = { sub="Genmei Shield" }

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
        if string.find(spell.name,'Lullaby') then
            if buffactive.Troubadour then
                equip({range="Marsyas"})
            elseif state.LullabyMode.value == 'Harp' and spell.english:contains('Horde') then
                equip({range="Daurdabla"})
            else
                equip({range="Gjallarhorn"})
            end
        end
    end
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
    if spell.type == 'WeaponSkill' then
        if elemental_ws:contains(spell.name) then
            -- Matching double weather (w/o day conflict).
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Matching day and weather
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Match day or weather
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip({waist="Hachirin-no-Obi"})
            end
        end
    end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        -- layer general gear on first, then let default handler add song-specific gear.
        local generalClass = get_song_class(spell)
        if generalClass and sets.midcast[generalClass] then
            equip(sets.midcast[generalClass])
        end
        if spell.name == 'Honor March' then
            equip({range="Marsyas"})
        end
        if string.find(spell.name,'Lullaby') then
            if buffactive.Troubadour then
                equip({range="Marsyas"})
            elseif state.LullabyMode.value == 'Harp' and spell.english:contains('Horde') then
                equip({range="Daurdabla"})
                equip(sets.midcast.SongStringSkill)
            else
                equip({range="Gjallarhorn"})
            end
        end
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if player.status ~= 'Engaged' and state.WeaponLock.value == false and (player.sub_job == 'DNC' or player.sub_job == 'NIN') then
            equip(sets.SongDWDuration)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english:contains('Lullaby') and not spell.interrupted then
        get_lullaby_duration(spell)
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
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
end

function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end

    check_weaponset()
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

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'etude' then
        send_command('@input /ma '..state.Etude.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'carol' then
        send_command('@input /ma '..state.Carol.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'threnody' then
        send_command('@input /ma '..state.Threnody.value..' <t>')
    end

    gearinfo(cmdParams, eventArgs)
end

function customize_melee_set(meleeSet)
    if buffactive['Aftermath: Lv.3'] and player.equipment.main == "Carnwenhan" then
        meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end

    check_weaponset()

    return meleeSet
end

function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'Acc' then
        wsmode = 'Acc'
    end

    return wsmode
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 and (player.sub_job == "WHM" or player.sub_job == "RDM" or player.sub_job == "SCH") then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
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

    local c_msg = state.CastingMode.value

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
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'SongEnfeebleAcc'
        else
            return 'SongEnfeeble'
        end
    elseif state.SongMode.value == 'Placeholder' then
        return 'SongPlaceholder'
    else
        return 'SongEnhancing'
    end
end

function get_lullaby_duration(spell)
    local self = windower.ffxi.get_player()

    local troubadour = false
    local clarioncall = false
    local soulvoice = false
    local marcato = false

    for i,v in pairs(self.buffs) do
        if v == 348 then troubadour = true end
        if v == 499 then clarioncall = true end
        if v == 52 then soulvoice = true end
        if v == 231 then marcato = true end
    end

    local mult = 1

    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    if player.equipment.range == "Marsyas" then mult = mult + 0.5 end

    if player.equipment.main == "Carnwenhan" then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.main == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.neck == "Mnbw. Whistle" then mult = mult + 0.2 end
    if player.equipment.neck == "Mnbw. Whistle +1" then mult = mult + 0.3 end
    if player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.12 end
    if player.equipment.legs == "Inyanga Shalwar +1" then mult = mult + 0.15 end
    if player.equipment.legs == "Inyanga Shalwar +2" then mult = mult + 0.17 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
    if player.equipment.feet == "Brioso Slippers +2" then mult = mult + 0.13 end
    if player.equipment.feet == "Brioso Slippers +3" then mult = mult + 0.15 end
    if player.equipment.hands == 'Brioso Cuffs +1' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +2' then mult = mult + 0.1 end
    if player.equipment.hands == 'Brioso Cuffs +3' then mult = mult + 0.2 end

    --JP Duration Gift
    if self.job_points.brd.jp_spent >= 1200 then
        mult = mult + 0.05
    end

    if troubadour then
        mult = mult * 2
    end

    if spell.en == "Foe Lullaby II" or spell.en == "Horde Lullaby II" then
        base = 60
    elseif spell.en == "Foe Lullaby" or spell.en == "Horde Lullaby" then
        base = 30
    end

    totalDuration = math.floor(mult * base)

    -- Job Points Buff
    totalDuration = totalDuration + self.job_points.brd.lullaby_duration
    if troubadour then
        totalDuration = totalDuration + self.job_points.brd.lullaby_duration
        -- adding it a second time if Troubadour up
    end

    if clarioncall then
        if troubadour then
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2 * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade.  * 2 again for Troubadour
        else
            totalDuration = totalDuration + (self.job_points.brd.clarion_call_effect * 2)
            -- Clarion Call gives 2 seconds per Job Point upgrade.
        end
    end

    if marcato and not soulvoice then
        totalDuration = totalDuration + self.job_points.brd.marcato_effect
    end

    -- Create the custom timer
    if spell.english == "Foe Lullaby II" or spell.english == "Horde Lullaby II" then
        send_command('@timers c "Lullaby II ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00377.png')
    elseif spell.english == "Foe Lullaby" or spell.english == "Horde Lullaby" then
        send_command('@timers c "Lullaby ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00376.png')
    end
end

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 12 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 12 and DW_needed <= 27 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 27 and DW_needed <= 31 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 31 and DW_needed <= 42 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 42 then
            classes.CustomMeleeGroups:append('')
        end
    end
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

function check_weaponset()
    equip(sets[state.WeaponSet.current])
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
       equip(sets.DefaultShield)
    end
end