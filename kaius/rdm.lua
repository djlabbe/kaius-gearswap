-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------
--
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
--              [ WIN+Q ]           Toggle Magic Burst Mode
--
--  Abilities:  [ CTRL+` ]          Composure
--              [ CTRL+- ]          Light Arts/Addendum: White
--              [ CTRL+= ]          Dark Arts/Addendum: Black
--              [ CTRL+; ]          Celerity/Alacrity
--              [ ALT+[ ]           Accesion/Manifestation
--              [ ALT+; ]           Penury/Parsimony
--
--  Weapons:    [ CTRL+W ]          Toggles Weapon Lock
-------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()

    state.Buff.Composure = buffactive.Composure or false
    state.Buff.Saboteur = buffactive.Saboteur or false
    state.Buff.Stymie = buffactive.Stymie or false
    state.Buff.Doom = false

    enfeebling_magic_acc = S{'Bind', 'Break', 'Dispel', 'Distract', 'Distract II', 'Frazzle', 'Frazzle II', 'Gravity', 'Gravity II', 'Silence'}

    enfeebling_magic_skill = S{'Distract III', 'Frazzle III', 'Poison II'}
    enfeebling_magic_potency = S{'Dia', 'Dia II', 'Dia III', 'Diaga', 'Blind', 'Blind II'}
    enfeebling_magic_sleep = S{'Sleep', 'Sleep II', 'Sleepga'}

    skill_spells = S{
        'Temper', 'Temper II', 'Enfire', 'Enfire II', 'Enblizzard', 'Enblizzard II', 'Enaero', 'Enaero II',
        'Enstone', 'Enstone II', 'Enthunder', 'Enthunder II', 'Enwater', 'Enwater II'}
end

function user_setup()
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'DT')

    state.EnSpell = M{['description']='EnSpell', 'Enfire', 'Enblizzard', 'Enaero', 'Enstone', 'Enthunder', 'Enwater'}
    state.BarElement = M{['description']='BarElement', 'Barfire', 'Barblizzard', 'Baraero', 'Barstone', 'Barthunder', 'Barwater'}
    state.BarStatus = M{['description']='BarStatus', 'Baramnesia', 'Barvirus', 'Barparalyze', 'Barsilence', 'Barpetrify', 'Barpoison', 'Barblind', 'Barsleep'}
    state.GainSpell = M{['description']='GainSpell', 'Gain-STR', 'Gain-INT', 'Gain-AGI', 'Gain-VIT', 'Gain-DEX', 'Gain-MND', 'Gain-CHR'}

    state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'Maxentius', 'Tauret', 'CroceaLight', 'CroceaDark'}
    state.WeaponLock = M(false, 'Weapon Lock')
    state.MagicBurst = M(false, 'Magic Burst')
    state.SleepMode = M{['description']='Sleep Mode', 'Normal', 'MaxDuration'}
    state.EnspellMode = M(false, 'Enspell Melee Mode')

    gear.Artifact_Head = { name= "Atrophy Chapeau +2" }
    gear.Artifact_Body = { name="Atrophy Tabard +3" }
    gear.Artifact_Hands = { name="Atrophy Gloves +3" }
    gear.Artifact_Legs = { name="Atrophy Tights +3" }
    gear.Artifact_Feet = { name="Atrophy Boots +2" }

    gear.Relic_Head = { name="Vitiation Chapeau +3" }
    gear.Relic_Body = { name="Vitiation Tabard +3" }
    gear.Relic_Hands = { name="Vitiation Gloves +3" }
    gear.Relic_Legs = { name="Vitiation Tights +3" }
    gear.Relic_Feet = { name="Vitiation Boots +3" }

    gear.Empyrean_Head = { name="Lethargy Chappel +3" }
    gear.Empyrean_Body = { name="Lethargy Sayon +3" }
    gear.Empyrean_Hands = { name="Lethargy Gantherots +3" }
    gear.Empyrean_Legs = { name="Lethargy Fuseau +3" }
    gear.Empyrean_Feet = { name="Lethargy Houseaux +3" }

    gear.RDM_DW_Cape = { name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}} --X
    gear.RDM_ENF_Cape = { name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Enmity-10','Mag. Evasion+15',}} --X
    gear.RDM_NUKE_Cape = { name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}} --X
    gear.RDM_WS1_Cape = { name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --X

    gear.RDM_ENH_Cape = { name="Ghostfyre Cape", augments={'Enfb.mag. skill +7','Enha.mag. skill +10','Mag. Acc.+7','Enh. Mag. eff. dur. +20',}}

    include('Global-Binds.lua')

    send_command('bind !` input /ja "Composure" <me>')
    send_command('bind @q gs c toggle MagicBurst')

    send_command('bind !F1 input /ja "Chainspell" <me>')
    send_command('bind !F2 input /ja "Stymie" <me>')

    if player.sub_job == 'SCH' then
        send_command('bind !- gs c scholar light')
        send_command('bind != gs c scholar dark')
        send_command('bind ^; gs c scholar speed')   
        send_command('bind ^[ gs c scholar aoe')
        send_command('bind !; gs c scholar cost')
        send_command('bind ![ gs c scholar power')
    end

    send_command('bind !s input /ja "Saboteur" <me>')
    send_command('bind !p input /ma "Protect V" <stpc>')
    send_command('bind !o input /ma "Shell V" <stpc>')
    send_command('bind !i input /ma "Phalanx II" <stpc>')
    send_command('bind !u input /ma "Aquaveil" <me>')
    send_command('bind !y input /ja "Convert" <me>')

    send_command('bind !h input /ma "Haste II" <stpc>')
    send_command('bind !j input /ma "Temper II" <me>')
    send_command('bind !k gs c enspell')
    send_command('bind !l gs c gainspell')
    send_command('bind !f input /ma "Flurry II" <stpc>')
    send_command('bind !g input /ma "Gravity II" <t>')
    send_command('bind !b input /ma "Bind" <t>')

     -- ALT + Numpad ===> Enfeebles --
    send_command('bind !numpad7 input /ma "Paralyze II" <t>')
    send_command('bind !numpad8 input /ma "Slow II" <t>')
    send_command('bind !numpad9 input /ma "Silence" <t>')  
    send_command('bind !numpad4 input /ma "Addle II" <t>')
    send_command('bind !numpad5 input /ma "Distract III" <t>')
    send_command('bind !numpad6 input /ma "Frazzle III" <t>')
    send_command('bind !numpad1 input /ma "Inundation" <t>')
    send_command('bind !numpad2 input /ma "Blind II" <t>')
    send_command('bind !numpad3 input /ma "Poison II" <t>')
    send_command('bind !numpad0 input /ma "Bio III" <t>')

    send_command('bind !insert gs c cycleback EnSpell')
    send_command('bind !delete gs c cycle EnSpell')
    
    send_command('bind !pageup gs c cycleback BarElement')
    send_command('bind !pagedown gs c cycle BarElement')

    send_command('bind !pageup gs c cycleback BarStatus')
    send_command('bind !pagedown gs c cycle BarStatus')

    send_command('bind ^insert gs c cycleback GainSpell')
    send_command('bind ^delete gs c cycle GainSpell')

    send_command('bind ^, input /ja "Chainspell" <me>')
    send_command('bind ^. input /ja "Stymie" <me>')

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @r gs c cycle EnspellMode')
    send_command('bind @s gs c cycle SleepMode')


    if player.sub_job == 'NIN' then
        send_command('bind ^numpad7 gs c set WeaponSet Naegling;input /macro set 1')
        send_command('bind ^numpad8 gs c set WeaponSet Maxentius;input /macro set 2')
        send_command('bind ^numpad9 gs c set WeaponSet Tauret;input /macro set 3')
        send_command('bind ^numpad4 gs c set WeaponSet CroceaLight;input /macro set 1')
        send_command('bind ^numpad5 gs c set WeaponSet CroceaDark;input /macro set 1')
        set_macro_page(1, 5)
    elseif player.sub_job == 'DNC' then
        send_command('bind ^numpad7 gs c set WeaponSet Naegling;input /macro set 4')
        send_command('bind ^numpad8 gs c set WeaponSet Maxentius;input /macro set 5')
        send_command('bind ^numpad9 gs c set WeaponSet Tauret;input /macro set 6')
        send_command('bind ^numpad4 gs c set WeaponSet CroceaLight;input /macro set 4')
        send_command('bind ^numpad5 gs c set WeaponSet CroceaDark;input /macro set 4')
        set_macro_page(4, 5)
    elseif player.sub_job == 'SCH' then
        set_macro_page(7, 5)
    else
        send_command('bind ^numpad7 gs c set WeaponSet Naegling;input /macro set 1')
        send_command('bind ^numpad8 gs c set WeaponSet Maxentius;input /macro set 2')
        send_command('bind ^numpad9 gs c set WeaponSet Tauret;input /macro set 3')
        send_command('bind ^numpad4 gs c set WeaponSet CroceaLight;input /macro set 1')
        send_command('bind ^numpad5 gs c set WeaponSet CroceaDark;input /macro set 1')
        set_macro_page(1, 5)
    end

    send_command('wait 3; input /lockstyleset 5')

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end

function user_unload()
    send_command('unbind ^=')
    send_command('unbind !~')

    send_command('unbind ^;')   
    send_command('unbind ^[')
    send_command('unbind !;')

    send_command('unbind !s')
    send_command('unbind !p')
    send_command('unbind !o')
    send_command('unbind !i')
    send_command('unbind !u')
    send_command('unbind !y')
    send_command('unbind !h')
    send_command('unbind !f')
    send_command('unbind !g')
    send_command('unbind !b')
    send_command('unbind !j')
    send_command('unbind !k')
    send_command('unbind !l')

    send_command('unbind !insert')
    send_command('unbind !delete')
    send_command('unbind ^insert')
    send_command('unbind ^delete')
    send_command('unbind !home')
    send_command('unbind !end')
    send_command('unbind !pageup')
    send_command('unbind !pagedown')

    send_command('unbind @q')
    send_command('unbind @s')
    send_command('unbind @e')
    send_command('unbind @w')
    send_command('unbind @r')

    unbind_numpad()
end

function init_gear_sets()
    sets.precast.JA['Chainspell'] = {
        body=gear.Relic_Body
    }

    sets.precast.FC = {
        -- head=gear.Artifact_Head, --16
        body=gear.Relic_Body, --15
        -- legs="Volte Brais", --8
        neck="Orunmila's Torque", --5
        ear1="Malignance Earring", --4
        ear2="Leth. Earring +1", --8 
        feet=gear.Carmine_B_Feet, --8
        ring2="Prolix Ring", --2
        waist="Embla Sash" --5
    } --42

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {
        waist="Siegel Sash"
    })

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {
        ammo="Impatiens", --(2)
        ring1="Lebeche Ring", --(2)
        back="Perimede Cape", --(4)
        waist="Embla Sash",
    })

    sets.precast.FC.Curaga = sets.precast.FC.Cure
    sets.precast.FC['Healing Magic'] = sets.precast.FC.Cure
    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

    sets.precast.FC.Dispelga = set_combine(sets.precast.FC, {
        main="Daybreak", 
        sub="Ammurapi Shield", 
        waist="Shinjutsu-no-Obi +1"
    })

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {
        head=empty,
        body="Crepuscular Cloak",
        waist="Shinjutsu-no-Obi +1", --5
    })

    sets.precast.Storm = set_combine(sets.precast.FC, {
        ring1=gear.Stikini_1,
    })

    sets.precast.FC.Utsusemi = sets.precast.FC.Cure

    sets.precast.WS = {
        ammo="Aurgelmir Orb +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Fotia Gorget",
        ear1="Ishvara Earring",
        ear2="Moonshade Earring",
        ring1="Metamorph Ring +1",
        ring2="Epaminondas's Ring",
        back=gear.RDM_WS1_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS['Chant du Cygne'] =  {
        ammo="Yetshila +1",
        head="Blistering Sallet +1",
        body=gear.Malignance_Body,
        hands=gear.Nyame_Hands,
        legs="Zoar Subligar +1",
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Mache Earring +1",
        ring1="Begrudging Ring",
        ring2="Ilabrat Ring",
        back=gear.RDM_WS1_Cape,
    }

    sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']

    sets.precast.WS['Savage Blade'] = {
        ammo="Coiste Bodhar",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Rep. Plat. Medal",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Sroda Ring",
        ring2="Cornelia's Ring",
        back=gear.RDM_WS1_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Savage Blade'].PDL = set_combine(sets.precast.WS['Savage Blade'], {
        ammo="Crepuscular Pebble",
        neck="Duelist's Torque +2",
        ear1="Ishvara Earring",
        hands=gear.Malignance_Hands,
    })

    sets.precast.WS['Death Blossom'] = {
        ammo="Coiste Bodhar",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Rep. Plat. Medal",
        ear1="Sherida Earring",
        ear2="Regal Earring",
        ring1="Sroda Ring",
        ring2="Epaminondas's Ring",
        back=gear.RDM_WS1_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Requiescat'] = {
        ammo="Coiste Bodhar",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Rep. Plat. Medal",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        ring1="Sroda Ring",
        ring2="Cornelia's Ring",
        back=gear.RDM_WS1_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Sanguine Blade'] = {
        ammo="Sroda Tathlum",
        head="Pixie Hairpin +1",
        body=gear.Nyame_Body,
        hands="Jhakri Cuffs +2",
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Duelist's Torque +2",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Archon Ring",
        ring2="Cornelia's Ring",
        back=gear.RDM_WS1_Cape,
        waist="Orpheus's Sash",
    }

    sets.precast.WS['Seraph Blade'] = {
        ammo="Sroda Tathlum",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Fotia Gorget",
        ear1="Malignance Earring",
        ear2="Moonshade Earring",
        ring1="Freke Ring",
        ring2="Cornelia's Ring",
        back=gear.RDM_WS1_Cape,
        waist="Orpheus's Sash",
    }

    sets.precast.WS['Shining Blade'] = sets.precast.WS['Savage Blade']

    sets.precast.WS['Aeolian Edge'] = {
        ammo="Sroda Tathlum",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands="Jhakri Cuffs +2",
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Sibyl Scarf",
        ear1="Malignance Earring",
        ear2="Moonshade Earring",
        ring1="Freke Ring",
        ring2="Epaminondas's Ring",
        back=gear.RDM_WS1_Cape,
        waist="Orpheus's Sash",
    }

    sets.precast.WS['Red Lotus Blade'] = {
        ammo="Sroda Tathlum",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands="Jhakri Cuffs +2",
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Sibyl Scarf",
        ear1="Malignance Earring",
        ear2="Moonshade Earring",
        ring1="Freke Ring",
        ring2="Epaminondas's Ring",
        back=gear.RDM_WS1_Cape,
        waist="Orpheus's Sash",
    }

    sets.precast.WS['Mercy Stroke'] = {
        ammo="Coiste Bodhar",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Rep. Plat. Medal",
        ear1="Sherida Earring",
        ear2="Ishvara Earring",
        ring1="Sroda Ring",
        ring2="Cornelia's Ring",
        back=gear.RDM_WS1_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Black Halo'] = {
        ammo="Coiste Bodhar",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Empyrean_Feet,
        neck="Rep. Plat. Medal",
        ear1="Regal Earring",
        ear2="Moonshade Earring",
        ring1="Metamorph Ring +1",
        ring2="Cornelia's Ring",
        back=gear.RDM_WS1_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Black Halo'].PDL = set_combine(sets.precast.WS['Black Halo'], {
        ammo="Crepuscular Pebble",
        neck="Duelist's Torque +2",
        ring1="Sroda Ring",
    })

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --11
        body="Ros. Jaseran +1", --25
        -- hands=gear.Chironic_WSD_Hands, --20
        legs="Carmine Cuisses +1", --20
        neck="Loricate Torque +1", --5
        ear1="Halasz Earring", --5
        ear2="Magnetic Earring", --8
        ring2="Evanescence Ring", --5
        waist="Rumination Sash", --10
    }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast.Cure = {
        main="Daybreak", --30
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head=gear.Kaykaus_B_Head, --11(+2)/(-6)
        body=gear.Kaykaus_A_Body, --(+4)/(-6)
        hands=gear.Kaykaus_D_Hands, --11(+2)/(-6)
        legs=gear.Kaykaus_A_Legs, --11(+2)/(-6)
        feet=gear.Kaykaus_B_Feet, --11(+2)/(-12)
        neck="Incanter's Torque",
        ear1="Meili Earring",
        ear2="Lethargy Earring +1",
        ring1="Haoma's Ring",
        ring2="Menelaus's Ring",
        back=gear.RDM_ENF_Cape, --(-10)
        waist="Luminary Sash",
    }

    sets.midcast.CureWeather = set_combine(sets.midcast.Cure, {
        main="Chatoyant Staff",
        sub="Enki Strap",
        back="Twilight Cape",
        waist="Hachirin-no-Obi",
    })

    sets.midcast.CureSelf = set_combine(sets.midcast.Cure, {
        -- neck="Phalaina Locket", -- 4(4)
        ring2="Asklepian Ring", -- (3)
        waist="Gishdubar Sash", -- (10)
    })

    sets.midcast.Curaga = set_combine(sets.midcast.Cure, {
        ammo="Regal Gem",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        waist="Luminary Sash",
    })

    sets.midcast.StatusRemoval = {
        head=gear.Kaykaus_B_Head, --11
        body=gear.Relic_Body,
        legs=gear.Artifact_Legs,
        feet="Vanya Clogs",
        neck="Incanter's Torque",
        ear1="Magnetic Earring",
        ear2="Meili Earring",
        ring1="Haoma's Ring",
        ring2="Menelaus's Ring",
        back="Perimede Cape",
        waist="Luminary Sash",
    }

    sets.midcast.Cursna = set_combine(sets.midcast.StatusRemoval, {
        -- hands="Hieros Mittens",
        body=gear.Relic_Body,
        neck="Debilis Medallion",       
        ring2="Menelaus's Ring",
        back="Oretan. Cape +1",
        waist="Bishop's Sash",
    })

    sets.midcast['Enhancing Magic'] = {
        main=gear.Colada_ENH,
        sub="Ammurapi Shield",
        ammo="Regal Gem",
        -- head="Befouled Crown",
        head=gear.Carmine_D_Head,
        body=gear.Relic_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Artifact_Legs,
        feet=gear.Empyrean_Feet,
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.RDM_ENH_Cape,
        waist="Embla Sash",
    }

    sets.midcast.EnhancingDuration = {
        main=gear.Colada_ENH,
        sub="Ammurapi Shield",
        head=gear.Telchine_ENH_Head,
        body=gear.Relic_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Telchine_ENH_Legs,
        feet=gear.Empyrean_Feet,
        ear2="Leth. Earring +1",
        neck="Dls. Torque +2",
        back=gear.RDM_ENH_Cape,
        waist="Embla Sash",
    }

    sets.midcast.EnhancingSkill = {
        main="Pukulatmuj +1",
        sub="Pukulatmuj",
        -- head="Befouled Crown",
        head=gear.Carmine_D_Head,
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        hands=gear.Relic_Hands,
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.RDM_ENH_Cape,
        waist="Olympus Sash",
        legs=gear.Artifact_Legs,
        feet=gear.Empyrean_Feet,
    }

    sets.midcast.Regen = set_combine(sets.midcast.EnhancingDuration, {
        main="Bolelabunga",
        sub="Ammurapi Shield",
        head=gear.Telchine_ENH_Head,
        body=gear.Telchine_ENH_Body,
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Telchine_ENH_Legs,
        feet=gear.Telchine_ENH_Feet,
    })

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head=gear.Amalric_A_Head, -- +2
        body=gear.Artifact_Body, -- +3
        legs=gear.Empyrean_Legs, -- +2
    })

    sets.midcast.RefreshSelf = {
        waist="Gishdubar Sash",
    }

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        neck="Nodens Gorget",
        waist="Siegel Sash",
    })

    sets.midcast.PhalanxSelf = set_combine(sets.midcast.EnhancingDuration, {
        main="Sakpata's Sword",
        body=gear.Taeon_Phalanx_Body, --3(10)
        hands=gear.Taeon_Phalanx_Hands, --3(10)
        legs=gear.Chironic_PHLX_Legs, --3(10)
        feet=gear.Taeon_Phalanx_Feet, --3(10)
    })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        ammo="Staunch Tathlum +1",
        head=gear.Amalric_A_Head,
        hands="Regal Cuffs",
        ear1="Halasz Earring",
        ring1="Freke Ring",
        ring2="Evanescence Ring",
        waist="Emphatikos Rope",
    })

    sets.midcast.Storm = sets.midcast.EnhancingDuration
    sets.midcast.GainSpell = {hands=gear.Relic_Hands}
    sets.midcast.SpikesSpell = {legs=gear.Relic_Pants}

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {
        ring2="Sheltered Ring"
    })
    
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Shell

    -- MND + Accuracy + Duration
    -- Paralyze, Paralyze II, Slow, Slow II, Indundation
    sets.midcast.MndEnfeebles = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Regal Gem",
        head=gear.Relic_Head,
        body=gear.Empyrean_Body,
        hands="Regal Cuffs",
        legs=gear.Empyrean_Legs,
        feet=gear.Relic_Feet,
        neck="Dls. Torque +2",
        ear1="Malignance Earring",
        ear2="Snotra Earring",
        ring1=gear.Stikini_1,
        ring2="Metamor. Ring +1",
        back=gear.RDM_ENF_Cape,
        waist="Obstinate Sash",
    } --587 skill

    -- MND + Accuracy + Duration
    -- Silence
    sets.midcast.MndEnfeeblesAcc =  {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        range="Ullr",
        ammo=empty,
        head=gear.Relic_Head, -- TODO Should be AF
        body=gear.Artifact_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Dls. Torque +2",
        ear1="Malignance Earring",
        ear2="Snotra Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
    }

    -- Duration + Potency
    -- Dia, Dia II, Dia III, Diaga
    sets.midcast.MndEnfeeblesEffect =  {
        main="Daybreak",
        sub="Ammurapi Shield", -- TODO: Sacro
        ammo="Regal Gem",
        head=gear.Relic_Head,
        body=gear.Empyrean_Body,
        hands="Regal Cuffs",
        legs=gear.Empyrean_Legs,
        feet=gear.Relic_Feet,
        neck="Dls. Torque +2",
        ear1="Etiolation Earring",
        ear2="Snotra Earring",
        ring1="Kishar Ring",
        ring2="Metamor. Ring +1",
        back=gear.RDM_ENF_Cape,
        waist="Obstinate Sash",
    }

    -- Duration + Skill
    -- Distract III, Frazzle III, Poison II
    -- Frazzle cap 625, Distract Cap 610, poison unknown/no cap
    sets.midcast.SkillEnfeebles = {
        main="Contemplator +1",
        sub="Mephitis Grip",
        ammo="Regal Gem",
        head=gear.Relic_Head,
        body=gear.Artifact_Body,
        hands="Regal Cuffs",
        legs=gear.Empyrean_Legs,
        feet=gear.Relic_Feet,
        neck="Incanter's Torque",
        ear1="Vor Earring",
        ear2="Snotra Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.RDM_ENF_Cape,
        waist="Obstinate Sash",
    } --644

    -- INT + Accuracy + Duration
    -- Addle, Addle II, Break
    sets.midcast.IntEnfeebles = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Regal Gem",
        head=gear.Relic_Head,
        body=gear.Empyrean_Body,
        hands="Regal Cuffs",
        legs=gear.Chironic_ENF_Legs,
        feet=gear.Relic_Feet,
        neck="Dls. Torque +2",
        ear1="Malignance Earring",
        ear2="Snotra Earring",
        ring1="Kishar Ring",
        ring2="Metamor. Ring +1",
        back=gear.RDM_ENF_Cape,
        waist="Acuity Belt +1",
    }

    -- INT + Accuracy + Duration
    -- Bind, Break, Dispel, Distract, Distract II, Frazzle, Frazzle II,  Gravity, Gravity II
    sets.midcast.IntEnfeeblesAcc = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        range="Ullr",
        ammo=empty,
        head=gear.Relic_Head,
        body=gear.Artifact_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Chironic_ENF_Legs,
        feet=gear.Relic_Feet,
        neck="Dls. Torque +2",
        ear1="Malignance Earring",
        ear2="Snotra Earring",
        ring1=gear.Stikini_1,
        ring2="Metamor. Ring +1",
        back=gear.RDM_ENF_Cape,
        waist="Acuity Belt +1",
    }

    -- Blind, Blind II
    sets.midcast.IntEnfeeblesEffect = {
        main="Maxentius",
        sub="Ammurapi Shield",
        ammo="Regal Gem",
        head=gear.Relic_Head,
        body=gear.Empyrean_Body,
        hands="Regal Cuffs",
        legs=gear.Chironic_ENF_Legs,
        feet=gear.Relic_Feet,
        neck="Dls. Torque +2",
        ear1="Malignance Earring",
        ear2="Snotra Earring",
        ring1="Kishar Ring",
        ring2="Metamor. Ring +1",
        back=gear.RDM_ENF_Cape,
        waist="Acuity Belt +1",
    }

    sets.midcast.Sleep = {
        main="Crocea Mors",
        sub="Ammurapi Shield",
        range="Ullr",
        ammo=empty,
        head=gear.Relic_Head,
        body=gear.Artifact_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Chironic_ENF_Legs,
        feet=gear.Relic_Feet,
        neck="Dls. Torque +2",
        ear1="Malignance Earring",
        ear2="Snotra Earring",
        ring1="Kishar Ring",
        ring2="Metamor. Ring +1",
        back=gear.RDM_NUKE_Cape,
        waist="Acuity Belt +1",
    }

    sets.midcast.SleepMaxDuration = {
        main="Crocea Mors",
        sub="Ammurapi Shield",
        range="Ullr",
        ammo=empty,
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands="Regal Cuffs",
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Dls. Torque +2",
        ear1="Malignance Earring",
        ear2="Snotra Earring",
        ring1="Kishar Ring",
        ring2="Metamor. Ring +1",
        back=gear.RDM_NUKE_Cape,
        waist="Acuity Belt +1",
    }

    sets.midcast.ElementalEnfeeble = sets.midcast.IntEnfeebles
    sets.midcast.Dispelga = set_combine(sets.midcast.IntEnfeeblesAcc, {main="Daybreak", sub="Ammurapi Shield", waist="Shinjutsu-no-Obi +1"})

    -- Stun (not drain/aspir)
    sets.midcast['Dark Magic'] = {
        main="Rubicundity",
        sub="Ammurapi Shield",
        ammo="Pemphredo Tathlum",
        head=gear.Artifact_Head,
        body=gear.Empyrean_Body,
        hands=gear.Kaykaus_D_Hands,
        legs="Ea Slops +1",
        -- feet="Merlinic Crackows",
        neck="Erra Pendant",
        ear1="Malignance Earring",
        ear2="Mani Earring",
        ring1=gear.Stikini_1,
        ring2="Evanescence Ring",
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
    }

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {
        head=gear.Merlinic_DRAIN_Head,
        body=gear.Merlinic_DRAIN_Body,
        hands=gear.Merlinic_DRAIN_Hands,
        -- feet="Merlinic Crackows",
        ear1="Hirudinea Earring",
        ring1="Archon Ring",
        ring2="Evanescence Ring",
        back="Perimede Cape",
        waist="Fucho-no-obi",
    })

    sets.midcast.Aspir = sets.midcast.Drain
    sets.midcast['Bio III'] = set_combine(sets.midcast['Dark Magic'], { legs=gear.Relic_Legs })

    sets.midcast['Elemental Magic'] = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Ghastly Tathlum +1",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Sibyl Scarf",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        ring1="Freke Ring",
        ring2="Metamor. Ring +1",
        back=gear.RDM_NUKE_Cape,
        waist="Acuity Belt +1",
    }

    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {
        head=empty,
        body="Crepuscular Cloak",
        ring1="Archon Ring",
        waist="Shinjutsu-no-Obi +1",
    })

    sets.MagicBurst = {
        main="Bunzi's Rod",
        sub="Ammurapi Shield",
        ammo="Ghastly Tathlum +1",
        head="Ea Hat +1", --7/(7)
        neck="Sibyl Scarf",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        body="Ea Houppe. +1", --9/(9)
        hands=gear.Bunzi_Hands, --(6)
        ring1="Freke Ring",
        ring2="Mujin Band", --(5)
        waist="Acuity Belt +1",
        legs=gear.Empyrean_Legs, --8/(8)
        feet=gear.Bunzi_Feet, --6  
        back=gear.NUKE_Cape,
    }
    
    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast.Trust = sets.precast.FC

    sets.buff.ComposureOther = set_combine(sets.midcast.EnhancingDuration, {
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
    });

    sets.buff.Saboteur = {hands=gear.Empyrean_Hands}

    sets.idle = {
        ammo="Homiliary",
        head=gear.Relic_Head,
        body=gear.Empyrean_Body,
        hands="Volte Gloves",
        legs=gear.Bunzi_Legs,
        feet=gear.Bunzi_Feet,
        neck="Sibyl Scarf",
        ear1="Arete Del Luna +1",
        ear2="Etiolation Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.RDM_ENF_Cape,
         waist="Platinum Moogle Belt",
    }

    sets.idle.DT = set_combine(sets.idle, {
        head=gear.Malignance_Head, --6/6
        body=gear.Malignance_Body, --9/9
        hands=gear.Malignance_Hands, --5/5
        legs=gear.Malignance_Legs, --7/7
        feet=gear.Malignance_Feet, --4/4
        neck="Warder's Charm +1",
        ear1="Odnowa Earring +1",
        ear2="Etiolation Earring",
        ring2="Defending Ring", --10/10
        back=gear.RDM_ENF_Cape,
         waist="Platinum Moogle Belt",
    })

    sets.idle.Town = set_combine(sets.idle, {
        ammo="Regal Gem",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Dls. Torque +2",
        ear1="Malignance Earring",
        ear2="Regal Earring",
        back=gear.RDM_ENF_Cape,
        waist="Acuity Belt +1",
    })

    sets.resting = set_combine(sets.idle, {
        main="Chatoyant Staff",
        waist="Shinjutsu-no-Obi +1",
    })

    sets.defense.PDT = sets.idle.DT
    sets.defense.MDT = sets.idle.DT


    if (item_available("Shneddick Ring +1")) then
        sets.Kiting = { ring1="Shneddick Ring +1" }
    else
        sets.Kiting = { feet="Skadi's Jambeaux +1" }
    end

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion

    sets.engaged = {
        ammo="Aurgelmir Orb +1",
        head=gear.Malignance_Head, --6
        body=gear.Malignance_Body, --9
        hands=gear.Malignance_Hands, --5
        legs=gear.Malignance_Legs, --7
        feet=gear.Malignance_Feet, --4
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        ring1="Ilabrat Ring",
        ring2=gear.Chirich_2,
        back=gear.RDM_DW_Cape,
        waist="Sailfi Belt +1",
    }

    -- No Magic Haste (74% DW to cap) (49% DW Needed)
    sets.engaged.DW = {
        ammo="Coiste Bodhar",
        head=gear.Bunzi_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Carmine_D_Legs, --6
        feet=gear.Malignance_Feet,
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Suppanomimi", --5
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.RDM_DW_Cape, --10
        waist="Sailfi Belt +1",
    } --41

    -- 15% Magic Haste (67% DW to cap) (42% DW Needed)
    sets.engaged.DW.LowHaste = set_combine(sets.engaged.DW, {
        ammo="Coiste Bodhar",
        head=gear.Bunzi_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Carmine_D_Legs, --6
        feet=gear.Malignance_Feet,
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Suppanomimi", --5
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.RDM_DW_Cape, --10
        waist="Sailfi Belt +1",
    }) --41

    -- 30% Magic Haste (56% DW to cap) (31% DW Needed)
    -- This is self haste II only, no external buffs.
    sets.engaged.DW.MidHaste = set_combine(sets.engaged.DW, {
        ammo="Coiste Bodhar",
        head=gear.Bunzi_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Carmine_D_Legs, --6
        feet=gear.Malignance_Feet,
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Suppanomimi", --5
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.RDM_DW_Cape, --10
        waist="Sailfi Belt +1",
    }) --31

    -- 35% Magic Haste (51% DW to cap)
    sets.engaged.DW.HighHaste = {
        ammo="Coiste Bodhar",
        head=gear.Bunzi_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Suppanomimi", --5
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.RDM_DW_Cape, --10
        waist="Sailfi Belt +1",
    } --22

    -- 45% Magic Haste (36% DW to cap) (11% DW Needed)
    sets.engaged.DW.MaxHaste = {
        ammo="Coiste Bodhar",
        head=gear.Bunzi_Head, --7DT
        body=gear.Malignance_Body, --9DT
        hands=gear.Malignance_Hands, --5DT
        legs=gear.Malignance_Legs, --7DT
        feet=gear.Malignance_Feet, --4DT
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Dedition Earring",
        ring1=gear.Chirich_1,
        ring2=gear.Chirich_2,
        back=gear.RDM_DW_Cape, --10DW 10PDT
        waist="Sailfi Belt +1",
    } --42% PDT

    sets.engaged.Hybrid = {
        ring2="Defending Ring",
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.DW.DT.LowHaste = set_combine(sets.engaged.DW.LowHaste, sets.engaged.Hybrid)
    sets.engaged.DW.DT.MidHaste = set_combine(sets.engaged.DW.MidHaste, sets.engaged.Hybrid)
    sets.engaged.DW.DT.HighHaste = set_combine(sets.engaged.DW.HighHaste, sets.engaged.Hybrid)
    sets.engaged.DW.DT.MaxHaste = set_combine(sets.engaged.DW.MaxHaste, sets.engaged.Hybrid)

    sets.engaged.Enspell = {
        hands="Ayanmo Manopolas +2",
        neck="Dls. Torque +2",
        waist="Orpheus's Sash",
    }

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Purity Ring", --20
        waist="Gishdubar Sash", --10
    }

    sets.Obi = {waist="Hachirin-no-Obi"}

    sets.DefaultShield = { sub="Genmei Shield" }
    
    sets.Naegling = {main="Naegling", sub="Thibron"}
    sets.Maxentius = { main="Maxentius", sub="Thibron" }
    sets.Tauret = { main="Tauret", sub="Gleti's Knife" }
    sets.CroceaDark = { main="Crocea Mors", sub="Bunzi's Rod" }
    sets.CroceaLight = { main="Crocea Mors", sub="Daybreak" }
end

function job_precast(spell, action, spellMap, eventArgs)

    if spell.name:startswith('Aspir') then
        refine_various_spells(spell, action, spellMap, eventArgs)
    end
    if spell.skill == 'Elemental Magic' and spell.english ~= 'Impact' and spellMap ~= 'Helix' then
        refine_various_spells(spell, action, spellMap, eventArgs)
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
    if spell.name == 'Impact' then
        equip(sets.precast.FC.Impact)
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enhancing Magic' then
        if classes.NoSkillSpells:contains(spell.english) then
            equip(sets.midcast.EnhancingDuration)
            if spellMap == 'Refresh' then
                equip(sets.midcast.Refresh)
                if spell.target.type == 'SELF' then
                    equip (sets.midcast.RefreshSelf)
                end
            end
        elseif skill_spells:contains(spell.english) then
            equip(sets.midcast.EnhancingSkill)
        elseif spell.english:startswith('Gain') then
            equip(sets.midcast.GainSpell)
        elseif spell.english:contains('Spikes') then
            equip(sets.midcast.SpikesSpell)
        elseif spell.english:startswith('Phalanx') then
            if spell.target.type == 'SELF' then
                equip(sets.midcast.PhalanxSelf)
            end
        end
        if (spell.target.type == 'PLAYER' or spell.target.type == 'NPC') and buffactive.Composure then
            equip(sets.buff.ComposureOther)
        end
    end
    if spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
    if spell.skill == 'Elemental Magic' then
        if state.MagicBurst.value and spell.english ~= 'Death' then
            equip(sets.MagicBurst)
            if spell.english == "Impact" then
                equip(sets.midcast.Impact)
            end
        end
        if spell.skill == 'Elemental Magic' or spell.english == "Kaustra" then
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip(sets.Obi)
            -- Target distance under 1.7 yalms.
            elseif spell.target.distance < (1.7 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Matching day and weather.
            elseif spell.element == world.day_element and spell.element == world.weather_element then
                equip(sets.Obi)
            -- Target distance under 8 yalms.
            elseif spell.target.distance < (8 + spell.target.model_size) then
                equip({waist="Orpheus's Sash"})
            -- Match day or weather.
            elseif spell.element == world.day_element or spell.element == world.weather_element then
                equip(sets.Obi)
            end
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.english:contains('Sleep') and not spell.interrupted then
        set_sleep_timer(spell)
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

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub','range')
    else
        enable('main','sub','range')
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

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
        if default_spell_map == 'Cure' or default_spell_map == 'Curaga' then
            if (world.weather_element == 'Light' or world.day_element == 'Light') then
                return 'CureWeather'
            end
        end
        if spell.skill == 'Enfeebling Magic' then
            if enfeebling_magic_skill:contains(spell.english) then
                return "SkillEnfeebles"
            elseif spell.type == "WhiteMagic" then
                if enfeebling_magic_acc:contains(spell.english) and not buffactive.Stymie then
                    return "MndEnfeeblesAcc"
                elseif enfeebling_magic_potency:contains(spell.english) then
                    return "MndEnfeeblesEffect"
                else
                    return "MndEnfeebles"
              end
            elseif spell.type == "BlackMagic" then
                if enfeebling_magic_acc:contains(spell.english) and not buffactive.Stymie then
                    return "IntEnfeeblesAcc"
                elseif enfeebling_magic_potency:contains(spell.english) then
                    return "IntEnfeeblesEffect"
                elseif enfeebling_magic_sleep:contains(spell.english) and ((buffactive.Stymie and buffactive.Composure) or state.SleepMode.value == 'MaxDuration') then
                    return "SleepMaxDuration"
                elseif enfeebling_magic_sleep:contains(spell.english) then
                    return "Sleep"
                else
                    return "IntEnfeebles"
                end
            else
                return "MndEnfeebles"
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
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

function customize_melee_set(meleeSet)
    if state.EnspellMode.value == true then
        meleeSet = set_combine(meleeSet, sets.engaged.Enspell)
    end
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end

    check_weaponset()

    return meleeSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
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

    local c_msg = state.CastingMode.value

    local d_msg = 'None'
    if state.DefenseMode.value ~= 'None' then
        d_msg = state.DefenseMode.value .. state[state.DefenseMode.value .. 'DefenseMode'].value
    end

    local i_msg = state.IdleMode.value

    local msg = ''
    if state.MagicBurst.value then
        msg = ' Burst: On |'
    end
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

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 11 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 11 and DW_needed <= 26 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif DW_needed > 26 and DW_needed <= 32 then
            classes.CustomMeleeGroups:append('MidHaste')
        elseif DW_needed > 32 and DW_needed <= 43 then
            classes.CustomMeleeGroups:append('LowHaste')
        elseif DW_needed > 43 then
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

function refine_various_spells(spell, action, spellMap, eventArgs)
    local newSpell = spell.english
    local spell_recasts = windower.ffxi.get_spell_recasts()
    local cancelling = 'All '..spell.english..' are on cooldown. Cancelling.'
    local spell_index

    if spell_recasts[spell.recast_id] > 0 then
        if spell.skill == 'Elemental Magic' and spellMap ~= 'GeoElem' then
            spell_index = table.find(elemental_degrade_array[spell.element],spell.name)
            if spell_index ~= nil and spell_index > 1 then
                newSpell = elemental_degrade_array[spell.element][spell_index - 1]
                send_command('@input /ma "'..newSpell..'" '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        elseif spell.name:startswith('Aspir') then
            spell_index = table.find(elemental_degrade_array['Aspirs'],spell.name)
            if spell_index > 1 then
                newSpell = elemental_degrade_array['Aspirs'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        elseif spell.name:startswith('Sleep') then
            spell_index = table.find(elemental_degrade_array['Sleeps'],spell.name)
            if spell_index > 1 then
                newSpell = elemental_degrade_array['Sleeps'][spell_index - 1]
                send_command('@input /ma '..newSpell..' '..tostring(spell.target.raw))
                eventArgs.cancel = true
            end
        end
    end
end

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'nuke' then
        handle_nuking(cmdParams)
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'enspell' then
        send_command('@input /ma '..state.EnSpell.value..' <me>')
    elseif cmdParams[1]:lower() == 'barelement' then
        send_command('@input /ma '..state.BarElement.value..' <me>')
    elseif cmdParams[1]:lower() == 'barstatus' then
        send_command('@input /ma '..state.BarStatus.value..' <me>')
    elseif cmdParams[1]:lower() == 'gainspell' then
        send_command('@input /ma '..state.GainSpell.value..' <me>')
    end

    gearinfo(cmdParams, eventArgs)
end

function set_sleep_timer(spell)
    local self = windower.ffxi.get_player()

    if spell.en == "Sleep II" then
        base = 90
    elseif spell.en == "Sleep" or spell.en == "Sleepga" then
        base = 60
    end

    if state.Buff.Saboteur then
        base = base * 2 -- Only for non-NM?
    end

    -- Merit Points Duration Bonus
    base = base + self.merits.enfeebling_magic_duration*6

    -- Relic Head Duration Bonus
    if not ((buffactive.Stymie and buffactive.Composure) or state.SleepMode.value == 'MaxDuration') then
        base = base + self.merits.enfeebling_magic_duration*3
    end

    -- Job Points Duration Bonus
    base = base + self.job_points.rdm.enfeebling_magic_duration

    --Enfeebling duration non-augmented gear total
    gear_mult = 1.40
    --Enfeebling duration augmented gear total
    aug_mult = 1.25
    --Estoquer/Lethargy Composure set bonus
    --2pc = 1.1 / 3pc = 1.2 / 4pc = 1.35 / 5pc = 1.5
    empy_mult = 1 --from sets.midcast.Sleep

    if ((buffactive.Stymie and buffactive.Composure) or state.SleepMode.value == 'MaxDuration') then
        if buffactive.Stymie then
            base = base + self.job_points.rdm.stymie_effect
        end
        empy_mult = 1.35 --from sets.midcast.SleepMaxDuration
    end

    totalDuration = math.floor(base * gear_mult * aug_mult * empy_mult)

    -- Create the custom timer
    if spell.english == "Sleep II" then
        send_command('@timers c "Sleep II ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00259.png')
    elseif spell.english == "Sleep" or spell.english == "Sleepga" then
        send_command('@timers c "Sleep ['..spell.target.name..']" ' ..totalDuration.. ' down spells/00253.png')
    end
    add_to_chat(1, 'Base: ' ..base.. ' Merits: ' ..self.merits.enfeebling_magic_duration.. ' Job Points: ' ..self.job_points.rdm.stymie_effect.. ' Set Bonus: ' ..empy_mult)

end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
       equip(sets.DefaultShield)
    end
end