---------------------------------------------
-- Gearswap Commands Specific to this File --
---------------------------------------------
-- Universal Ready Move Commands -
-- //gs c Ready one
-- //gs c Ready two
-- //gs c Ready three
-- //gs c Ready four
--
-- alt+F8 cycles through designated Jug Pets
-- ctrl+F8 cycles backwards through designated Jug Pets
-- alt+= switches between Pet-Only (Axe Swaps) and Master (no Axe Swap) modes
-- ctrl+= switches between Reward Modes (Theta / Roborant)
-- alt+` can swap in the usage of Chaac Belt for Treasure Hunter on common subjob abilities.
-- ctrl+F11 cycles between Magical Defense Modes
--
-------------------------------
-- General Gearswap Commands --
-------------------------------
-- F9 cycles Accuracy modes
-- ctrl+F9 cycles Hybrid modes
-- F10 equips Physical Defense
-- alt+F10 toggles Kiting on or off
-- ctrl+F10 cycles Physical Defense modes
-- F11 equips Magical Defense
-- alt+F12 turns off Defense modes
-- ctrl+F12 cycles Idle modes
--
-- Keep in mind that any time you Change Jobs/Subjobs, your Pet/Correlation/etc reset to default options.
-- F12 will list your current options.
--
-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function job_setup()
    DisplayPetBuffTimers = 'false'
    DisplayModeInfo = 'false'

    PetName = 'None';
    PetJob = 'None';
    PetInfo = 'None';
    ReadyMoveOne = 'None';
    ReadyMoveTwo = 'None';
    ReadyMoveThree = 'None';
    ReadyMoveFour = 'None'
    pet_info_update()

    -- (Adjust Run Wild Duration based on # of Job Points)
    RunWildDuration = 340;RunWildIcon = 'abilities/00121.png'
    RewardRegenIcon = 'spells/00023.png'
    SpurIcon = 'abilities/00037.png'
    BubbleCurtainDuration = 180;BubbleCurtainIcon = 'spells/00048.png'
    ScissorGuardIcon = 'spells/00043.png'
    SecretionIcon = 'spells/00053.png'
    RageIcon = 'abilities/00002.png'
    RhinoGuardIcon = 'spells/00053.png'
    ZealousSnortIcon = 'spells/00057.png'

    -- Display Mode Info as on-screen Text
    TextBoxX = 1075
    TextBoxY = 47
    TextSize = 10

    state.Buff['Killer Instinct'] = buffactive['Killer Instinct'] or false

    if DisplayModeInfo == 'true' then
        DisplayTrue = 1
    end

end

function user_setup()
    state.OffenseMode:options('Normal')
    state.WeaponskillMode:options('Normal')
    state.HybridMode:options('Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'PetPDT')
    state.MagicalDefenseMode:options('MDT', 'PetMDT')

    state.WeaponSet = M{['description']='Weapon Set', 'Pangu', 'Dolichenus', 'Tauret'}
    state.WeaponLock = M(false, 'Weapon Lock')
    include('Global-Binds.lua')

    -- Set up Jug Pet cycling and keybind Alt+F8/Ctrl+F8
    -- INPUT PREFERRED JUG PETS HERE
    state.JugMode = M{['description']='Jug Mode', 'Dire Broth', 'Tant. Broth', 'Lyrical Broth', 'Spicy Broth', 'C. Plasma Broth', 'Bubbly Broth'}
    send_command('bind !f8 gs c cycle JugMode')
    send_command('bind ^f8 gs c cycleback JugMode')

    -- Set up Reward Modes and keybind ctrl+=
    state.RewardMode = M{['description']='Reward Mode', 'Theta', 'Roborant'}
    send_command('bind ^= gs c cycle RewardMode')

    -- Keybind Ctrl+F11 to cycle Magical Defense Modes
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')

    -- 'Out of Range' distance; Melee WSs will auto-cancel
    target_distance = 8

    -- Categorized list of Ready moves
    physical_ready_moves = S{'Foot Kick','Whirl Claws','Sheep Charge','Lamb Chop','Head Butt','Wild Oats',
        'Leaf Dagger','Claw Cyclone','Razor Fang','Crossthrash','Nimble Snap','Cyclotail','Rhino Attack',
        'Power Attack','Mandibular Bite','Big Scissors','Grapple','Spinning Top','Double Claw','Frogkick',
        'Blockhead','Brain Crush','Tail Blow','Scythe Tail','Ripper Fang','Chomp Rush','Needleshot',
        'Recoil Dive','Sudden Lunge','Spiral Spin','Wing Slap','Beak Lunge','Suction','Back Heel',
        'Fantod','Tortoise Stomp','Sensilla Blades','Tegmina Buffet','Pentapeck','Sweeping Gouge',
        'Somersault','Tickling Tendrils','Pecking Flurry','Sickle Slash','Disembowel','Extirpating Salvo',
        'Mega Scissors','Rhinowrecker','Hoof Volley','Fluid Toss','Fluid Spread'}

    magic_atk_ready_moves = S{'Dust Cloud','Cursed Sphere','Venom','Toxic Spit','Bubble Shower','Drainkiss',
        'Silence Gas','Dark Spore','Fireball','Plague Breath','Snow Cloud','Charged Whisker','Corrosive Ooze',
        'Aqua Breath','Stink Bomb','Nectarous Deluge','Nepenthic Plunge','Pestilent Plume','Foul Waters',
        'Acid Spray','Infected Leech','Gloom Spray','Venom Shower'}

    magic_acc_ready_moves = S{'Sheep Song','Scream','Dream Flower','Roar','Predatory Glare','Gloeosuccus',
        'Palsy Pollen','Soporific','Geist Wall','Toxic Spit','Numbing Noise','Spoil','Hi-Freq Field',
        'Sandpit','Sandblast','Venom Spray','Filamented Hold','Queasyshroom','Numbshroom','Spore','Shakeshroom',
        'Infrasonics','Chaotic Eye','Blaster','Purulent Ooze','Intimidate','Noisome Powder','Acid Mist',
        'Choke Breath','Jettatura','Nihility Song','Molting Plumage','Swooping Frenzy','Spider Web'}

    multi_hit_ready_moves = S{'Pentapeck','Tickling Tendrils','Sweeping Gouge','Chomp Rush','Wing Slap',
        'Pecking Flurry'}

    tp_based_ready_moves = S{'Foot Kick','Dust Cloud','Snow Cloud','Sheep Song','Sheep Charge','Lamb Chop',
        'Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang','Roar',
        'Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Somersault','Geist Wall','Numbing Noise',
        'Frogkick','Nimble Snap','Cyclotail','Spoil','Rhino Attack','Hi-Freq Field','Sandpit','Sandblast',
        'Mandibular Bite','Metallic Body','Bubble Shower','Grapple','Spinning Top','Double Claw','Spore',
        'Filamented Hold','Blockhead','Fireball','Tail Blow','Plague Breath','Brain Crush','Infrasonics',
        'Needleshot','Chaotic Eye','Blaster','Ripper Fang','Intimidate','Recoil Dive','Water Wall',
        'Sudden Lunge','Noisome Powder','Wing Slap','Beak Lunge','Suction','Drainkiss','Acid Mist',
        'TP Drainkiss','Back Heel','Jettatura','Choke Breath','Fantod','Charged Whisker','Purulent Ooze',
        'Corrosive Ooze','Tortoise Stomp','Aqua Breath','Sensilla Blades','Tegmina Buffet','Sweeping Gouge',
        'Tickling Tendrils','Pecking Flurry','Pestilent Plume','Foul Waters','Spider Web','Gloom Spray',
        'Disembowel','Extirpating Salvo','Rhinowrecker','Venom Shower','Fluid Toss','Fluid Spread','Digest'}

    -- List of Pet Buffs and Ready moves exclusively modified by Pet TP Bonus gear.
    pet_buff_moves = S{'Wild Carrot','Bubble Curtain','Scissor Guard','Secretion','Rage','Harden Shell',
        'TP Drainkiss','Fantod','Rhino Guard','Zealous Snort','Frenzied Rage','Digest'}

    -- List of Jug Modes that will cancel if Call Beast is used (Bestial Loyalty-only jug pets, HQs generally).
    call_beast_cancel = S{'Vis. Broth','Ferm. Broth','Bubbly Broth','Windy Greens','Bug-Ridden Broth','Tant. Broth',
        'Glazed Broth','Slimy Webbing','Deepwater Broth','Venomous Broth','Heavenly Broth'}

    -- List of abilities to reference for applying Treasure Hunter gear.
    abilities_to_check = S{'Feral Howl','Quickstep','Box Step','Stutter Step','Desperate Flourish',
        'Violent Flourish','Animated Flourish','Provoke','Dia','Dia II','Flash','Bio','Bio II',
        'Sleep','Sleep II','Drain','Aspir','Dispel','Stun','Steal','Mug'}

    enmity_plus_moves = S{'Provoke','Berserk','Warcry','Aggressor','Holy Circle','Sentinel','Last Resort',
        'Souleater','Vallation','Swordplay'}

    gear.Artifact_Head = { name= "Totemic Helm +2" }
    gear.Artifact_Body = { name= "Totemic Jackcoat +2" }
    gear.Artifact_Hands = { name= "Totemic Gloves +3" }
    -- gear.Artifact_Legs = { name= "Totemic Trousers +1" }
    -- gear.Artifact_Feet = { name= "Totemic Gaiters +1" }

    gear.Relic_Head = { name= "Ankusa Helm +3" }
    gear.Relic_Body = { name= "Ankusa Jackcoat +3" }
    gear.Relic_Hands = { name= "Ankusa Gloves +3" }
    gear.Relic_Legs = { name= "Ankusa Trousers +3" }
    gear.Relic_Feet = { name= "Ankusa Gaiters +3" }

    gear.Empyrean_Head = { name= "Nukumi Cabasset +2" }
    gear.Empyrean_Body = { name= "Nukumi Gausape +2" }
    gear.Empyrean_Hands = { name= "Nukumi Manoplas +2" }
    gear.Empyrean_Legs = { name= "Nukumi Quijotes +1" }
    gear.Empyrean_Feet = { name= "Nukumi Ocreae +2" }

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycle WeaponSet')

    send_command('bind !F1 input /ja "Familiar" <me>')
    send_command('bind !F2 input /ja "Unleash" <me>')

    send_command('bind !l input /pet Leave <me>')
    send_command('bind !h input /pet Heel <me>')

    if player.sub_job == 'DNC' then
        send_command('bind ^` input /ja "Chocobo Jig" <me>')
        set_macro_page(1, 9)
    elseif player.sub_job == 'NIN' then
        set_macro_page(2, 9)
    elseif player.sub_job == 'WAR' then
        send_command('bind !t input /ja Provoke <t>')
        set_macro_page(3, 9)
    end

    send_command('wait 3; input /lockstyleset 9')
    display_mode_info()

    state.Auto_Kite = M(false, 'Auto_Kite')
    Haste = 0
    DW_needed = 0
    DW = false
    moving = false
    update_combat_form()
    determine_haste_group()
end

function user_unload()
    -- Unbinds the Reward, Correlation, JugMode, and Treasure hotkeys.
    send_command('unbind ^=')
    send_command('unbind @=')
    send_command('unbind !f8')
    send_command('unbind ^f8')
    send_command('unbind @f8')
    send_command('unbind ^f11')
    send_command('unbind !l')
    send_command('unbind !h')
    unbind_numpad()
    -- Removes any Text Info Boxes
    send_command('text JugPetText delete')
    send_command('text CorrelationText delete')
    send_command('text AccuracyText delete')
end

-- BST gearsets
function init_gear_sets()

    gear.BST_DW_Cape = { name="Artio's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}}
    gear.BST_WS1_Cape = { name="Artio's Mantle", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}

    sets.Enmity = {
        head="Halitus Helm",
        body="Emet Harness +1",
        legs="Zoar Subligar +1",
        hands="Macabre Gauntlets +1",
        neck="Unmoving Collar +1",
        ear2="Cryptic Earring",
        -- ring1="Pernicious Ring",
        ring2="Eihwaz Ring",
        waist="Kasiri Belt",
    }

    ---------------------
    -- JA PRECAST SETS --
    ---------------------
    -- Most gearsets are divided into 3 categories:
    -- 1. Default - No Axe swaps involved.
    -- 2. NE (Not engaged) - Axe/Shield swap included, for use with Pet Only mode.
    -- 3. NEDW (Not engaged; Dual-wield) - Axe swaps included, for use with Pet Only mode.

    sets.precast.JA.Familiar = {legs=gear.Relic_Legs}

    sets.precast.JA['Call Beast'] = {
        hands=gear.Relic_Hands,
    }

    sets.precast.JA['Bestial Loyalty'] = sets.precast.JA['Call Beast']

    -- sets.precast.JA.Tame = {
    --     head=gear.Artifact_Head,
    -- }

    sets.precast.JA.Spur = {
        feet=gear.Empyrean_Feet
    }

    sets.precast.JA['Killer Instinct'] = set_combine(sets.Enmity, {
        head=gear.Relic_Head
    })

    sets.precast.JA.Reward = {
        body=gear.Artifact_Body,
        hands=gear.Malignance_Hands,
        ring1="Metamorph Ring +1",
        ring2=gear.Stikini_2,
        back=gear.BST_DW_Cape,
        waist="Engraved Belt",
        legs=gear.Relic_Legs,
        feet=gear.Relic_Feet,
    }

    sets.precast.JA.Charm = {
        -- head=gear.Artifact_Head,
        neck="Unmoving Collar +1",
        ear2="Enchanter's Earring +1",
        body=gear.Relic_Body,
        hands=gear.Relic_Hands,
        ring1="Metamorph Ring +1",
        back=gear.BST_DW_Cape,
        legs=gear.Relic_Legs,
        feet=gear.Relic_Feet,
    }

    ---------------------------
    -- PET SIC & READY MOVES --
    ---------------------------

    sets.ReadyRecast = { legs=gear.Gleti_Legs }

    sets.midcast.Pet = {
        ammo="Hesperiidae",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Relic_Legs,
        feet=gear.Gleti_Feet,
        neck="Shulmanu Collar",
        ear1="Sroda Earring",
        ear2="Nukumi Earring +1",
        ring1="Tali'ah Ring",
        ring2="Cath Palug Ring",
        waist="Incarnation Sash",
        back=gear.BST_DW_Cape,
    }

    sets.midcast.Pet.MultiStrike = set_combine(sets.midcast.Pet, {
        neck="Beastmaster Collar +2",
    })
    
  
    sets.midcast.Pet.MagicAtkReady = {
        ammo="Hesperiidae",
        head=gear.Nyame_Head,
        body="Udug Jacket",   
        hands=gear.Empyrean_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Adad Amulet",
        ear1="Crepuscular Earring",
        ear2="Nukumi Earring +1",
        ring1="Tali'ah Ring",
        ring2="Cath Palug Ring",
        waist="Incarnation Sash",       
        back="Argocham Mantle",
    }

    sets.midcast.Pet.MagicAccReady = {
        ammo="Hesperiidae",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Bst. Collar +2",
        waist="Incarnation Sash",
        ear1="Crepuscular Earring",
        ear2="Enmerkar Earring",
        ring1="Tali'ah Ring",
        ring2="Cath Palug Ring",
        back=gear.BST_TP_Cape,
    }

    sets.midcast.Pet.Buff = {
        ammo="Hesperiidae",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Relic_Legs,
        feet=gear.Gleti_Feet,
        neck="Shulmanu Collar",
        ear1="Sroda Earring",
        ear2="Nukumi Earring +1",
        ring1="Tali'ah Ring",
        ring2="Cath Palug Ring",
        waist="Incarnation Sash",
        back=gear.BST_DW_Cape,
    }


    ------------------
    -- DEFENSE SETS --
    ------------------

    -- Pet PDT and MDT sets:
    sets.defense.PetPDT = {
        ammo="Hesperiidae",
        head=gear.Nyame_Head,
        neck="Beastmaster Collar +2",
        ear1="Handler's Earring +1",
        ear2="Enmerkar Earring",
        body=gear.Nyame_Body,
        hands=gear.Gleti_Hands,
        ring1=gear.Moonlight_1,
        ring2="Defending Ring",
        back=gear.BST_DW_Cape,
        waist="Isa Belt",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet
    }

    sets.defense.PetMDT = {
        ammo="Hesperiidae",
        head=gear.Nyame_Head,
        neck="Beastmaster Collar +2",
        ear1="Enmerkar Earring",
        ear2="Nukumi Earring +1",
        body=gear.Nyame_Body,
        hands=gear.Gleti_Hands,
        ring1=gear.Moonlight_1,
        ring2="Defending Ring",
        back=gear.BST_DW_Cape,
        waist="Isa Belt",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
    }

    -- Master PDT and MDT sets:
    sets.defense.PDT = {
        ammo="Staunch Tathlum +1",
        head=gear.Gleti_Head,
        neck="Loricate Torque +1",
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1",
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        ring1=gear.Moonlight_1,
        ring2="Defending Ring",
        back=gear.BST_DW_Cape,
        waist="Flume Belt +1",
        legs=gear.Gleti_Legs,
        feet=gear.Gleti_Feet
    }

    sets.defense.MDT = {
        ammo="Staunch Tathlum +1",
        head=gear.Malignance_Head,
        neck="Loricate Torque +1",
        ear1="Etiolation Earring",
        ear2="Eabani Earring",
        body=gear.Gleti_Body,
        hands=gear.Malignance_Hands,
        ring1="Defending Ring",
        ring2="Purity Ring",
        back=gear.BST_DW_Cape,
        waist="Engraved Belt",
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
    }

    sets.defense.MEva = {
        ammo="Staunch Tathlum +1",
        head=gear.Malignance_Head,
        neck="Warder's Charm +1",
        ear1="Etiolation Earring",
        ear2="Eabani Earring",
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        ring1="Defending Ring",
        ring2="Purity Ring",
        back=gear.BST_DW_Cape,
        waist="Engraved Belt",
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
    }

    sets.Kiting = { ring1="Shneddick Ring" }


    --------------------
    -- FAST CAST SETS --
    --------------------

    sets.precast.FC = {
        ammo="Sapience Orb",
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring",
        ear2="Enchanter's Earring +1",
        body="Sacro Breastplate",
        hands="Leyline Gloves",
        ring1="Prolix Ring",
    }

    sets.precast.FC["Utsusemi: Ichi"] = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

    sets.precast.FC["Utsusemi: Ni"] = set_combine(sets.precast.FC, {
        ammo="Impatiens",
        neck="Magoraga Beads",
        ring1="Lebeche Ring",
    })

    ------------------
    -- MIDCAST SETS --
    ------------------

    sets.midcast.FastRecast = {
        ammo="Sapience Orb",
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring",
        ear2="Enchanter's Earring +1",
        body="Sacro Breastplate",
        hands="Leyline Gloves",
        ring1="Kishar Ring",
        ring2="Prolix Ring",
    }


    --------------------------------------
    -- SINGLE-WIELD MASTER ENGAGED SETS --
    --------------------------------------

    sets.engaged = {
        ammo="Coiste Bodhar",
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Malignance_Feet,
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Dedition Earring",    
        ring1="Gere Ring",
        ring2="Epona's Ring",
        back=gear.BST_WS1_Cape,
        waist="Sailfi Belt +1",
    }

    ------------------------------------
    -- DUAL-WIELD MASTER ENGAGED SETS --
    ------------------------------------

    -- No Magic Haste (74% DW to cap) 49 NIN
    sets.engaged.DW = {
        ammo="Coiste Bodhar",
        head=gear.Malignance_Head,
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Eabani Earring", --4    
        ring1="Gere Ring",
        ring2=gear.Chirich_2,
        back=gear.BST_DW_Cape,
        waist="Sailfi Belt +1",
    } --31

    -- 15% Magic Haste (67% DW to cap) 42 NIN
    sets.engaged.DW.LowHaste = sets.engaged.DW

    -- 30% Magic Haste (56% DW to cap) 31 NIN
    sets.engaged.DW.MidHaste = sets.engaged.DW

    -- 35% Magic Haste (51% DW to cap) 20 NIN
    sets.engaged.DW.HighHaste = sets.engaged.DW

    -- 45% Magic Haste (36% DW to cap) 11 NIN
    sets.engaged.DW.MaxHaste = set_combine(sets.engaged.DW, {
        ammo="Coiste Bodhar",
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Malignance_Feet,
        neck="Anu Torque",
        ear1="Sherida Earring",
        ear2="Dedition Earring",    
        ring1="Gere Ring",
        ring2="Epona's Ring",
        back=gear.BST_DW_Cape,
        waist="Sailfi Belt +1",
    })

    sets.engaged.Hybrid = {
        ring2=gear.Moonlight_2
    }

    --------------------
    -- MASTER WS SETS --
    --------------------

    -- AXE WSs --
    sets.precast.WS = {
        ammo="Aurgelmir Orb +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Beastmaster Collar +2",
        ear1="Moonshade Earring",
        ear2="Telos Earring",     
        ring1="Regal Ring",
        ring2="Epona's Ring",
        back=gear.BST_WS1_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Decimation'] = {
        ammo="Coiste Bodhar",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Nukumi Earring +1",
        ring1="Gere Ring",
        ring2="Sroda Ring",
        back=gear.BST_WS1_Cape,
        waist="Sailfi Belt +1",
    }

    
    sets.precast.WS['Mistral Axe'] = {
        ammo="Coiste Bodhar",
        head=gear.Relic_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Rep. Plat. Medal",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",    
        ring1="Gere Ring",
        ring2="Sroda Ring",
        back=gear.BST_WS1_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Calamity'] = {
        ammo="Coiste Bodhar",
        head=gear.Relic_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Rep. Plat. Medal",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",      
        ring1="Regal Ring",
        ring2="Epaminondas's Ring",
        back=gear.BST_WS1_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS['Rampage'] = {
        ammo="Aurgelmir Orb +1",
        head="Blistering Sallet +1",
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",      
        ring1="Gere Ring",
        ring2="Sroda Ring",
        waist="Fotia Belt",
        back=gear.BST_WS1_Cape,
    } 

    sets.precast.WS['Bora Axe'] = {
        ammo="Aurgelmir Orb +1",
        head=gear.Relic_Head,
        neck="Beastmaster Collar +2",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        body=gear.Gleti_Body,
        hands=gear.Artifact_Hands,
        ring1="Ilabrat Ring",
        ring2="Epona's Ring",
        waist="Sailfi Belt +1",
        legs=gear.Gleti_Legs,
        feet=gear.Gleti_Feet,
        back=gear.BST_WS1_Cape,
    }

    sets.precast.WS['Ruinator'] = {
        ammo="Coiste Bodhar",
        head=gear.Gleti_Head,
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        ring1="Gere Ring",
        ring2="Epona's Ring",
        back=gear.BST_WS1_Cape,
        waist="Fotia Belt",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
    }

    sets.precast.WS['Onslaught'] = {
        ammo="Aurgelmir Orb +1",
        head=gear.Relic_Head,
        neck="Bst. Collar +2",
        ear1="Ishvara Earring",
        ear2="Thrud Earring",
        body=gear.Gleti_Body,
        hands=gear.Artifact_Hands,
        ring1="Epaminondas's Ring",
        ring2="Ilabrat Ring",
        back=gear.BST_WS1_Cape,
        waist="Sailfi Belt +1",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
    }

    sets.precast.WS['Primal Rend'] = {
        ammo="Oshasha's Treatise",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Baetyl Pendant",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        ring1="Beithir Ring",
        ring2="Epaminondas's Ring",
        back=gear.BST_WS1_Cape,
        waist="Orpheus's Sash",
    }

    sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS['Primal Rend'], {
    })

    sets.precast.WS['Evisceration'] = {
        ammo="Coiste Bodhar",
        head="Blistering Sallet +1",
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Moonshade Earring",
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        ring1="Gere Ring",
        ring2="Begrudging Ring",
        back=gear.BST_WS1_Cape,
        waist="Fotia Belt",
        legs="Zoar Subligar +1",
        feet=gear.Nyame_Feet,
    }

    sets.precast.WS['Aeolian Edge'] = {
        ammo="Pemphredo Tathlum",
        head=gear.Nyame_Head,
        neck="Baetyl Pendant",
        ear1="Moonshade Earring",
        ear2="Friomisi Earring",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        ring1="Shiva Ring +1",
        ring2="Epaminondas's Ring",
        back=gear.BST_WS1_Cape,
        waist="Orpheus's Sash",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
    }

    sets.precast.WS['Exenterator'] = {
        ammo="Coiste Bodhar",
        head=gear.Nyame_Head,
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        ring1="Gere Ring",
        ring2="Epona's Ring",
        back=gear.BST_WS1_Cape,
        waist="Fotia Belt",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet
    }


    -- SWORD WSs --
    sets.precast.WS['Savage Blade'] = {
        ammo="Aurgelmir Orb +1",
        head=gear.Nyame_Head,
        neck="Rep. Plat. Medal",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        ring1="Epaminondas's Ring",
        ring2="Regal Ring",
        back=gear.BST_WS1_Cape,
        waist="Sailfi Belt +1",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
    }

    -- SCYTHE WSs --
    sets.precast.WS['Spiral Hell'] = {
        ammo="Aurgelmir Orb +1",
        head=gear.Relic_Head,
        neck="Beastmaster Collar +2",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",
        body=gear.Nyame_Body,
        hands=gear.Artifact_Hands,
        ring1="Epaminondas's Ring",
        ring2="Ilabrat Ring",
        back=gear.BST_WS1_Cape,
        waist="Sailfi Belt +1",
        legs=gear.Relic_Legs,
        feet=gear.Relic_Feet,
    }

    sets.precast.WS['Cross Reaper'] = {
        ammo="Aurgelmir Orb +1",
        head=gear.Relic_Head,
        neck="Beastmaster Collar +2",
        ear1="Moonshade Earring",
        ear2="Thrud Earring",
        body=gear.Nyame_Body,
        hands=gear.Artifact_Hands,
        ring1="Epaminondas's Ring",
        ring2="Ilabrat Ring",
        back=gear.BST_WS1_Cape,
        waist="Sailfi Belt +1",
        legs=gear.Relic_Legs,
        feet=gear.Relic_Feet,
    }

    sets.precast.WS['Entropy'] = {
        ammo="Coiste Bodhar",
        head=gear.Gleti_Head,
        neck="Fotia Gorget",
        ear1="Sherida Earring",
        ear2="Telos Earring",
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        ring1="Gere Ring",
        ring2="Epona's Ring",
        back=gear.BST_WS1_Cape,
        waist="Fotia Belt",
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet
    }
    sets.midcast.ExtraMAB = {ear1="Novio Earring"}
    sets.midcast.ExtraWSDMG = {ear1="Ishvara Earring"}

    ---------------
    -- IDLE SETS --
    ---------------/

    sets.idle = sets.engaged.DW.MaxHaste


    sets.idle.Pet = sets.idle

    sets.idle.Pet.Engaged = {
        ammo="Hesperiidae",
        head=gear.Emicho_C_Head,
        neck="Beastmaster Collar +2",
        ear1="Enmerkar Earring",
        ear2="Nukumi Earring +1",
        body=gear.Nyame_Body,
        hands=gear.Emicho_C_Hands,
        ring1=gear.Varar_1,
        ring2=gear.Varar_2,
        back=gear.BST_DW_Cape,
        waist="Incarnation Sash",
        legs=gear.Relic_Legs,
        feet=gear.Nyame_Feet
    }

    ----------------
    -- OTHER SETS --
    ----------------

    --Precast Gear Sets for DNC subjob abilities:
    sets.precast.Waltz = {
        head=gear.Nyame_Head,
        neck="Unmoving Collar +1",
        ear1="Handler's Earring +1",
        ear2="Enchanter's Earring +1",
        body=gear.Gleti_Body,
        hands=gear.Artifact_Hands,
        ring1="Asklepian Ring",
        legs="Dashing Subligar",
        feet=gear.Nyame_Feet,
        back=gear.BST_DW_Cape,
    }

    sets.precast.Step = {
        ammo="Aurgelmir Orb +1",
        head=gear.Nyame_Head,
        neck="Beastmaster Collar +2",
        ear2="Telos Earring",
        body=gear.Artifact_Body,
        hands=gear.Artifact_Hands,
        ring1="Ilabrat Ring",
        ring2="Regal Ring",
        waist="Eschan Stone",
        legs=gear.Gleti_Legs,
        feet=gear.Gleti_Feet,
        back=gear.BST_DW_Cape,
    }

    sets.precast.Flourish1 = {}

    sets.precast.Flourish1['Violent Flourish'] = {
        ammo="Pemphredo Tathlum",
        head=gear.Malignance_Head,
        neck="Beastmaster Collar +2",
        ear1="Dignitary's Earring",
        ear2="Nukumi Earring +1",
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        ring1="Metamorph Ring +1",
        ring2="Kishar Ring",
        back=gear.BST_DW_Cape,
        waist="Eschan Stone",
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
    }

    sets.buff['Killer Instinct'] = {body=gear.Empyrean_Body}

    sets.Pangu = {main="Pangu", sub="Agwu's Axe"}
    sets.Dolichenus = {main="Dolichenus", sub="Ikenga's Axe" }    
    sets.Tauret = {main="Tauret", sub="Agwu's Axe" }
    sets.DefaultShield = {sub="Thuellaic Ecu +1"}
    
    sets.midcast.Pet.MagicAtkReady = {}
    sets.midcast.Pet.MagicAtkReady.TPBonus = {}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

function job_pretarget(spell)
    
end

function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == "Monster" and not spell.interrupted then
        equip_ready_gear(spell)
        if not buffactive['Unleash'] then
            equip(sets.ReadyRecast)
        end

        eventArgs.handled = true
    end

    if spell.english == 'Reward' then
        RewardAmmo = ''
        if state.RewardMode.value == 'Theta' then
            RewardAmmo = 'Pet Food Theta'
        elseif state.RewardMode.value == 'Roborant' then
            RewardAmmo = 'Pet Roborant'
        else
            RewardAmmo = 'Pet Food Theta'
        end
    end

    if spell.english == 'Reward' then
        RewardAmmo = ''
        if state.RewardMode.value == 'Theta' then
            RewardAmmo = 'Pet Food Theta'
        elseif state.RewardMode.value == 'Roborant' then
            RewardAmmo = 'Pet Roborant'
        else
            RewardAmmo = 'Pet Food Theta'
        end
        
        equip({ammo=RewardAmmo}, sets.precast.JA.Reward)
    end

    if enmity_plus_moves:contains(spell.english) then
        equip(sets.Enmity)
    end

    if spell.english == 'Bestial Loyalty' or spell.english == 'Call Beast' then
        jug_pet_info()
        if spell.english == "Call Beast" and call_beast_cancel:contains(JugInfo) then
            add_to_chat(123, spell.name..' Canceled: [HQ Jug Pet]')
            return
        end
        equip({ammo=JugInfo})
    end


    if spell.type == "WeaponSkill" and spell.name ~= 'Mistral Axe' and spell.name ~= 'Bora Axe' and spell.target.distance > target_distance then
        cancel_spell()
        add_to_chat(123, spell.name..' Canceled: [Out of Range]')
        handle_equipping_gear(player.status)
        return
    end

    if spell.prefix == '/magic' or spell.prefix == '/ninjutsu' or spell.prefix == '/song' then
        equip(sets.precast.FC)
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
    --If Killer Instinct is active during WS (except for Primal/Cloudsplitter where Sacro Body is superior), equip Nukumi Gausape +2.
    if spell.type:lower() == 'weaponskill' and buffactive['Killer Instinct'] then
        if spell.english ~= "Primal Rend" and spell.english ~= "Cloudsplitter" then
            equip(sets.buff['Killer Instinct'])
        end
    end

    if spell.english == "Calamity" or spell.english == "Mistral Axe" then
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            if player.tp > 2750 then
                equip(sets.midcast.ExtraWSDMG)
            end
        else
            if player.tp > 2520 then
                equip(sets.midcast.ExtraWSDMG)
            end
        end
    end

    if spell.english == "Primal Rend" or spell.english == "Cloudsplitter" then
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            if player.tp > 2750 then
                equip(sets.midcast.ExtraMAB)
            end
        else
            if player.tp > 2520 then
                equip(sets.midcast.ExtraMAB)
            end
        end
    end

end

function job_midcast(spell, action, spellMap, eventArgs)
end

-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == "Monster" or spell.name == "Sic" then
        equip_ready_gear(spell)
        eventArgs.handled = true
    end

    if spell.english == 'Fight' or spell.english == 'Bestial Loyalty' or spell.english == 'Call Beast' then
        if not spell.interrupted then
            pet_info_update()
        end
    end

    if spell.english == "Leave" and not spell.interrupted then
        clear_pet_buff_timers()
        PetName = 'None';PetJob = 'None';PetInfo = 'None';ReadyMoveOne = 'None';ReadyMoveTwo = 'None';ReadyMoveThree = 'None';ReadyMoveFour = 'None'
    end

    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

function job_pet_midcast(spell, action, spellMap, eventArgs)
    if spell.type == "Monster" or spell.name == "Sic" then
        eventArgs.handled = true
    end
end

function job_pet_aftercast(spell, action, spellMap, eventArgs)
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hook for idle and melee sets.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

function customize_melee_set(meleeSet)
    check_weaponset()
    return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- Hooks for Reward, Correlation, Treasure Hunter, and Pet Mode handling.
-------------------------------------------------------------------------------------------------------------------

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Correlation Mode' then
        state.CorrelationMode:set(newValue)
    elseif stateField == 'Treasure Mode' then
        state.TreasureMode:set(newValue)
    elseif stateField == 'Reward Mode' then
        state.RewardMode:set(newValue)
    elseif stateField == 'Pet Mode' then
        state.CombatWeapon:set(newValue)
    end
    if state.WeaponLock.value == true then
        disable('main','sub','range')
    else
        enable('main','sub','range')
    end

    check_weaponset()
end



-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    update_combat_form()
    determine_haste_group()
    -- get_melee_groups()
    check_moving()
    pet_info_update()
    update_display_mode_info()
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
end

-- Updates gear based on pet status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if newStatus == 'Idle' or newStatus == 'Engaged' then
        if state.DefenseMode.value ~= "Physical" and state.DefenseMode.value ~= "Magical" then
            handle_equipping_gear(player.status)
        end
    end

    if pet.hpp == 0 then
        clear_pet_buff_timers()
        PetName = 'None';PetJob = 'None';PetInfo = 'None';ReadyMoveOne = 'None';ReadyMoveTwo = 'None';ReadyMoveThree = 'None';ReadyMoveFour = 'None'
    end

    customize_melee_set(meleeSet)
    pet_info_update()
end 

function job_buff_change(status, gain, gain_or_loss)
end

-------------------------------------------------------------------------------------------------------------------
-- Ready Move Presets and Pet TP Evaluation Functions - Credit to Bomberto and Verda
-------------------------------------------------------------------------------------------------------------------

pet_tp=0
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'ready' then
        if pet.status == "Engaged" then
            ready_move(cmdParams)
        else
            send_command('input /pet "Fight" <t>')
        end
        eventArgs.handled = true
    end
    if cmdParams[1] == 'pet_tp' then
	    pet_tp = tonumber(cmdParams[2])
    end
    if cmdParams[1]:lower() == 'charges' then
        charges = 3
        ready = windower.ffxi.get_ability_recasts()[102]
	    if ready ~= 0 then
	        charges = math.floor(((30 - ready) / 10))
	    end
	    add_to_chat(28,'Ready Recast:'..ready..'   Charges Remaining:'..charges..'')
    end

    gearinfo(cmdParams, eventArgs)
end


 
function ready_move(cmdParams)
    local move = cmdParams[2]:lower()
    local ReadyMove = ''
    if move == 'one' then
        ReadyMove = ReadyMoveOne
    elseif move == 'two' then
        ReadyMove = ReadyMoveTwo
    elseif move == 'three' then
        ReadyMove = ReadyMoveThree
    else
        ReadyMove = ReadyMoveFour
    end
    send_command('input /pet "'.. ReadyMove ..'" <me>')
end

pet_tp = 0
--Fix missing Pet.TP field by getting the packets from the fields lib
packets = require('packets')
function update_pet_tp(id,data)
    if id == 0x068 then
        pet_tp = 0
        local update = packets.parse('incoming', data)
        pet_tp = update["Pet TP"]
        windower.send_command('lua c gearswap c pet_tp '..pet_tp)
    end
end
id = windower.raw_register_event('incoming chunk', update_pet_tp)

-------------------------------------------------------------------------------------------------------------------
-- Current Job State Display
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    msg = msg .. ', Corr.: '..state.CorrelationMode.value

    if state.JugMode.value ~= 'None' then
        add_to_chat(8,'-- Jug Pet: '.. PetName ..' -- (Pet Info: '.. PetInfo ..', '.. PetJob ..')')
    end

    add_to_chat(28,'Ready Moves: 1.'.. ReadyMoveOne ..'  2.'.. ReadyMoveTwo ..'  3.'.. ReadyMoveThree ..'  4.'.. ReadyMoveFour ..'')
    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function equip_ready_gear(spell)
    if physical_ready_moves:contains(spell.name) then
        if multi_hit_ready_moves:contains(spell.name) then
            equip(sets.midcast.Pet.MultiStrike)
        else
            equip(sets.midcast.Pet)
        end
    end

    if magic_atk_ready_moves:contains(spell.name) then
       equip(sets.midcast.Pet.MagicAtkReady)
    end

    if magic_acc_ready_moves:contains(spell.name) then
        equip(sets.midcast.Pet.MagicAccReady)
    end

    if pet_buff_moves:contains(spell.name) then
        equip(sets.midcast.Pet.Buff)
    end

end

function jug_pet_info()
    JugInfo = ''
    if state.JugMode.value == 'FunguarFamiliar' or state.JugMode.value == 'Seedbed Soil' then
        JugInfo = 'Seedbed Soil'
    elseif state.JugMode.value == 'CourierCarrie' or state.JugMode.value == 'Fish Oil Broth' then
        JugInfo = 'Fish Oil Broth'
    elseif state.JugMode.value == 'AmigoSabotender' or state.JugMode.value == 'Sun Water' then
        JugInfo = 'Sun Water'
    elseif state.JugMode.value == 'NurseryNazuna' or state.JugMode.value == 'Dancing Herbal Broth' or state.JugMode.value == 'D. Herbal Broth' then
        JugInfo = 'D. Herbal Broth'
    elseif state.JugMode.value == 'CraftyClyvonne' or state.JugMode.value == 'Cunning Brain Broth' or state.JugMode.value == 'Cng. Brain Broth' then
        JugInfo = 'Cng. Brain Broth'
    elseif state.JugMode.value == 'PrestoJulio' or state.JugMode.value == 'Chirping Grasshopper Broth' or state.JugMode.value == 'C. Grass Broth' then
        JugInfo = 'C. Grass Broth'
    elseif state.JugMode.value == 'SwiftSieghard' or state.JugMode.value == 'Mellow Bird Broth' or state.JugMode.value == 'Mlw. Bird Broth' then
        JugInfo = 'Mlw. Bird Broth'
    elseif state.JugMode.value == 'MailbusterCetas' or state.JugMode.value == 'Goblin Bug Broth' or state.JugMode.value == 'Gob. Bug Broth' then
        JugInfo = 'Gob. Bug Broth'
    elseif state.JugMode.value == 'AudaciousAnna' or state.JugMode.value == 'Bubbling Carrion Broth' then
        JugInfo = 'B. Carrion Broth'
    elseif state.JugMode.value == 'TurbidToloi' or state.JugMode.value == 'Auroral Broth' then
        JugInfo = 'Auroral Broth'
    elseif state.JugMode.value == 'SlipperySilas' or state.JugMode.value == 'Wormy Broth' then
        JugInfo = 'Wormy Broth'
    elseif state.JugMode.value == 'LuckyLulush' or state.JugMode.value == 'Lucky Carrot Broth' or state.JugMode.value == 'L. Carrot Broth' then
        JugInfo = 'L. Carrot Broth'
    elseif state.JugMode.value == 'DipperYuly' or state.JugMode.value == 'Wool Grease' then
        JugInfo = 'Wool Grease'
    elseif state.JugMode.value == 'FlowerpotMerle' or state.JugMode.value == 'Vermihumus' then
        JugInfo = 'Vermihumus'
    elseif state.JugMode.value == 'DapperMac' or state.JugMode.value == 'Briny Broth' then
        JugInfo = 'Briny Broth'
    elseif state.JugMode.value == 'DiscreetLouise' or state.JugMode.value == 'Deepbed Soil' then
        JugInfo = 'Deepbed Soil'
    elseif state.JugMode.value == 'FatsoFargann' or state.JugMode.value == 'Curdled Plasma Broth' or state.JugMode.value == 'C. Plasma Broth' then
        JugInfo = 'C. Plasma Broth'
    elseif state.JugMode.value == 'FaithfulFalcorr' or state.JugMode.value == 'Lucky Broth' then
        JugInfo = 'Lucky Broth'
    elseif state.JugMode.value == 'BugeyedBroncha' or state.JugMode.value == 'Savage Mole Broth' or state.JugMode.value == 'Svg. Mole Broth' then
        JugInfo = 'Svg. Mole Broth'
    elseif state.JugMode.value == 'BloodclawShasra' or state.JugMode.value == 'Razor Brain Broth' or state.JugMode.value == 'Rzr. Brain Broth' then
        JugInfo = 'Rzr. Brain Broth'
    elseif state.JugMode.value == 'GorefangHobs' or state.JugMode.value == 'Burning Carrion Broth' then
        JugInfo = 'B. Carrion Broth'
    elseif state.JugMode.value == 'GooeyGerard' or state.JugMode.value == 'Cloudy Wheat Broth' or state.JugMode.value == 'Cl. Wheat Broth' then
        JugInfo = 'Cl. Wheat Broth'
    elseif state.JugMode.value == 'CrudeRaphie' or state.JugMode.value == 'Shadowy Broth' then
        JugInfo = 'Shadowy Broth'
    elseif state.JugMode.value == 'DroopyDortwin' or state.JugMode.value == 'Swirling Broth' then
        JugInfo = 'Swirling Broth'
    elseif state.JugMode.value == 'PonderingPeter' or state.JugMode.value == 'Viscous Broth' or state.JugMode.value == 'Vis. Broth' then
        JugInfo = 'Vis. Broth'
    elseif state.JugMode.value == 'SunburstMalfik' or state.JugMode.value == 'Shimmering Broth' then
        JugInfo = 'Shimmering Broth'
    elseif state.JugMode.value == 'AgedAngus' or state.JugMode.value == 'Fermented Broth' or state.JugMode.value == 'Ferm. Broth' then
        JugInfo = 'Ferm. Broth'
    elseif state.JugMode.value == 'WarlikePatrick' or state.JugMode.value == 'Livid Broth' then
        JugInfo = 'Livid Broth'
    elseif state.JugMode.value == 'ScissorlegXerin' or state.JugMode.value == 'Spicy Broth' then
        JugInfo = 'Spicy Broth'
    elseif state.JugMode.value == 'BouncingBertha' or state.JugMode.value == 'Bubbly Broth' then
        JugInfo = 'Bubbly Broth'
    elseif state.JugMode.value == 'RhymingShizuna' or state.JugMode.value == 'Lyrical Broth' then
        JugInfo = 'Lyrical Broth'
    elseif state.JugMode.value == 'AttentiveIbuki' or state.JugMode.value == 'Salubrious Broth' then
        JugInfo = 'Salubrious Broth'
    elseif state.JugMode.value == 'SwoopingZhivago' or state.JugMode.value == 'Windy Greens' then
        JugInfo = 'Windy Greens'
    elseif state.JugMode.value == 'AmiableRoche' or state.JugMode.value == 'Airy Broth' then
        JugInfo = 'Airy Broth'
    elseif state.JugMode.value == 'HeraldHenry' or state.JugMode.value == 'Translucent Broth' or state.JugMode.value == 'Trans. Broth' then
        JugInfo = 'Trans. Broth'
    elseif state.JugMode.value == 'BrainyWaluis' or state.JugMode.value == 'Crumbly Soil' then
        JugInfo = 'Crumbly Soil'
    elseif state.JugMode.value == 'HeadbreakerKen' or state.JugMode.value == 'Blackwater Broth' then
        JugInfo = 'Blackwater Broth'
    elseif state.JugMode.value == 'RedolentCandi' or state.JugMode.value == 'Electrified Broth' then
        JugInfo = 'Electrified Broth'
    elseif state.JugMode.value == 'AlluringHoney' or state.JugMode.value == 'Bug-Ridden Broth' then
        JugInfo = 'Bug-Ridden Broth'
    elseif state.JugMode.value == 'CaringKiyomaro' or state.JugMode.value == 'Fizzy Broth' then
        JugInfo = 'Fizzy Broth'
    elseif state.JugMode.value == 'VivaciousVickie' or state.JugMode.value == 'Tantalizing Broth' or state.JugMode.value == 'Tant. Broth' then
        JugInfo = 'Tant. Broth'
    elseif state.JugMode.value == 'HurlerPercival' or state.JugMode.value == 'Pale Sap' then
        JugInfo = 'Pale Sap'
    elseif state.JugMode.value == 'BlackbeardRandy' or state.JugMode.value == 'Meaty Broth' then
        JugInfo = 'Meaty Broth'
    elseif state.JugMode.value == 'GenerousArthur' or state.JugMode.value == 'Dire Broth' then
        JugInfo = 'Dire Broth'
    elseif state.JugMode.value == 'ThreestarLynn' or state.JugMode.value == 'Muddy Broth' then
        JugInfo = 'Muddy Broth'
    elseif state.JugMode.value == 'BraveHeroGlenn' or state.JugMode.value == 'Wispy Broth' then
        JugInfo = 'Wispy Broth'
    elseif state.JugMode.value == 'SharpwitHermes' or state.JugMode.value == 'Saline Broth' then
        JugInfo = 'Saline Broth'
    elseif state.JugMode.value == 'ColibriFamiliar' or state.JugMode.value == 'Sugary Broth' then
        JugInfo = 'Sugary Broth'
    elseif state.JugMode.value == 'ChoralLeera' or state.JugMode.value == 'Glazed Broth' then
        JugInfo = 'Glazed Broth'
    elseif state.JugMode.value == 'SpiderFamiliar' or state.JugMode.value == 'Sticky Webbing' then
        JugInfo = 'Sticky Webbing'
    elseif state.JugMode.value == 'GussyHachirobe' or state.JugMode.value == 'Slimy Webbing' then
        JugInfo = 'Slimy Webbing'
    elseif state.JugMode.value == 'AcuexFamiliar' or state.JugMode.value == 'Poisonous Broth' then
        JugInfo = 'Poisonous Broth'
    elseif state.JugMode.value == 'FluffyBredo' or state.JugMode.value == 'Venomous Broth' then
        JugInfo = 'Venomous Broth'
    elseif state.JugMode.value == 'SuspiciousAlice' or state.JugMode.value == 'Furious Broth' then
        JugInfo = 'Furious Broth'
    elseif state.JugMode.value == 'AnklebiterJedd' or state.JugMode.value == 'Crackling Broth' then
        JugInfo = 'Crackling Broth'
    elseif state.JugMode.value == 'FleetReinhard' or state.JugMode.value == 'Rapid Broth' then
        JugInfo = 'Rapid Broth'
    elseif state.JugMode.value == 'CursedAnnabelle' or state.JugMode.value == 'Creepy Broth' then
        JugInfo = 'Creepy Broth'
    elseif state.JugMode.value == 'SurgingStorm' or state.JugMode.value == 'Insipid Broth' then
        JugInfo = 'Insipid Broth'
    elseif state.JugMode.value == 'SubmergedIyo' or state.JugMode.value == 'Deepwater Broth' then
        JugInfo = 'Deepwater Broth'
    elseif state.JugMode.value == 'MosquitoFamiliar' or state.JugMode.value == 'Wetlands Broth' then
        JugInfo = 'Wetlands Broth'
    elseif state.JugMode.value == 'Left-HandedYoko' or state.JugMode.value == 'Heavenly Broth' then
        JugInfo = 'Heavenly Broth'
    elseif state.JugMode.value == 'SweetCaroline' or state.JugMode.value == 'Aged Humus' then
        JugInfo = 'Aged Humus'
    elseif state.JugMode.value == 'WeevilFamiliar' or state.JugMode.value == 'Pristine Sap' then
        JugInfo = 'Pristine Sap'
    elseif state.JugMode.value == 'StalwartAngelin' or state.JugMode.value == 'Truly Pristine Sap' or state.JugMode.value == 'T. Pristine Sap' then
        JugInfo = 'Truly Pristine Sap'
    elseif state.JugMode.value == 'P.CrabFamiliar' or state.JugMode.value == 'Rancid Broth' then
        JugInfo = 'Rancid Broth'
    elseif state.JugMode.value == 'JovialEdwin' or state.JugMode.value == 'Pungent Broth' then
        JugInfo = 'Pungent Broth'
    elseif state.JugMode.value == 'Y.BeetleFamiliar' or state.JugMode.value == 'Zestful Sap' then
        JugInfo = 'Zestful Sap'
    elseif state.JugMode.value == 'EnergeticSefina' or state.JugMode.value == 'Gassy Sap' then
        JugInfo = 'Gassy Sap'
    elseif state.JugMode.value == 'LynxFamiliar' or state.JugMode.value == 'Frizzante Broth' then
        JugInfo = 'Frizzante Broth'
    elseif state.JugMode.value == 'VivaciousGaston' or state.JugMode.value == 'Spumante Broth' then
        JugInfo = 'Spumante Broth'
    elseif state.JugMode.value == 'Hip.Familiar' or state.JugMode.value == 'Turpid Broth' then
        JugInfo = 'Turpid Broth'
    elseif state.JugMode.value == 'DaringRoland' or state.JugMode.value == 'Feculent Broth' then
        JugInfo = 'Feculent Broth'
    elseif state.JugMode.value == 'SlimeFamiliar' or state.JugMode.value == 'Decaying Broth' then
        JugInfo = 'Decaying Broth'
    elseif state.JugMode.value == 'SultryPatrice' or state.JugMode.value == 'Putrescent Broth' then
        JugInfo = 'Putrescent Broth'
    end
end

function pet_info_update()
    if pet.isvalid then
        PetName = pet.name

        if pet.name == 'DroopyDortwin' or pet.name == 'PonderingPeter' or pet.name == 'HareFamiliar' or pet.name == 'KeenearedSteffi' then
            PetInfo = "Rabbit, Beast";PetJob = 'Warrior';ReadyMoveOne = 'Foot Kick';ReadyMoveTwo = 'Whirl Claws';ReadyMoveThree = 'Wild Carrot';ReadyMoveFour = 'Dust Cloud'
        elseif pet.name == 'LuckyLulush' then
            PetInfo = "Rabbit, Beast";PetJob = 'Warrior';ReadyMoveOne = 'Foot Kick';ReadyMoveTwo = 'Whirl Claws';ReadyMoveThree = 'Wild Carrot';ReadyMoveFour = 'Snow Cloud'
        elseif pet.name == 'SunburstMalfik' or pet.name == 'AgedAngus' or pet.name == 'HeraldHenry' or pet.name == 'CrabFamiliar' or pet.name == 'CourierCarrie' then
            PetInfo = "Crab, Aquan";PetJob = 'Paladin';ReadyMoveOne = 'Big Scissors';ReadyMoveTwo = 'Scissor Guard';ReadyMoveThree = 'Bubble Curtain';ReadyMoveFour = 'Metallic Body'
        elseif pet.name == 'P.CrabFamiliar' or pet.name == 'JovialEdwin' then
            PetInfo = "Barnacle Crab, Aquan";PetJob = 'Paladin';ReadyMoveOne = 'Mega Scissors';ReadyMoveTwo = 'Venom Shower';ReadyMoveThree = 'Bubble Curtain';ReadyMoveFour = 'Metallic Body'
        elseif pet.name == 'WarlikePatrick' or pet.name == 'LizardFamiliar' or pet.name == 'ColdbloodComo' or pet.name == 'AudaciousAnna' then
            PetInfo = "Lizard, Lizard";PetJob = 'Warrior';ReadyMoveOne = 'Tail Blow';ReadyMoveTwo = 'Fireball';ReadyMoveThree = 'Brain Crush';ReadyMoveFour = 'Blockhead'
        elseif pet.name == 'ScissorlegXerin' or pet.name == 'BouncingBertha' then
            PetInfo = "Chapuli, Vermin";PetJob = 'Warrior';ReadyMoveOne = 'Sensilla Blades';ReadyMoveTwo = 'Tegmina Buffet';ReadyMoveThree = 'Tegmina Buffet';ReadyMoveFour = 'Tegmina Buffet'
        elseif pet.name == 'RhymingShizuna' or pet.name == 'SheepFamiliar' or pet.name == 'LullabyMelodia' or pet.name == 'NurseryNazuna' then
            PetInfo = "Sheep, Beast";PetJob = 'Warrior';ReadyMoveOne = 'Sheep Charge';ReadyMoveTwo = 'Rage';ReadyMoveThree = 'Sheep Song';ReadyMoveFour = 'Lamb Chop'
        elseif pet.name == 'AttentiveIbuki' or pet.name == 'SwoopingZhivago' then
            PetInfo = "Tulfaire, Bird";PetJob = 'Warrior';ReadyMoveOne = 'Swooping Frenzy';ReadyMoveTwo = 'Pentapeck';ReadyMoveThree = 'Molting Plumage';ReadyMoveFour = 'Molting Plumage'
        elseif pet.name == 'AmiableRoche' or pet.name == 'TurbidToloi' then
            PetInfo = "Pugil, Aquan";PetJob = 'Warrior';ReadyMoveOne = 'Recoil Dive';ReadyMoveTwo = 'Water Wall';ReadyMoveThree = 'Intimidate';ReadyMoveFour = 'Intimidate'
        elseif pet.name == 'BrainyWaluis' or pet.name == 'FunguarFamiliar' or pet.name == 'DiscreetLouise' then
            PetInfo = "Funguar, Plantoid";PetJob = 'Warrior';ReadyMoveOne = 'Frogkick';ReadyMoveTwo = 'Spore';ReadyMoveThree = 'Silence Gas';ReadyMoveFour = 'Dark Spore'
        elseif pet.name == 'HeadbreakerKen' or pet.name == 'MayflyFamiliar' or pet.name == 'ShellbusterOrob' or pet.name == 'MailbusterCetas' then
            PetInfo = "Fly, Vermin";PetJob = 'Warrior';ReadyMoveOne = 'Somersault';ReadyMoveTwo = 'Cursed Sphere';ReadyMoveThree = 'Venom';ReadyMoveFour = 'Venom'
        elseif pet.name == 'RedolentCandi' or pet.name == 'AlluringHoney' then
            PetInfo = "Snapweed, Plantoid";PetJob = 'Warrior';ReadyMoveOne = 'Tickling Tendrils';ReadyMoveTwo = 'Stink Bomb';ReadyMoveThree = 'Nectarous Deluge';ReadyMoveFour = 'Nepenthic Plunge'
        elseif pet.name == 'CaringKiyomaro' or pet.name == 'VivaciousVickie' then
            PetInfo = "Raaz, Beast";PetJob = 'Monk';ReadyMoveOne = 'Sweeping Gouge';ReadyMoveTwo = 'Zealous Snort';ReadyMoveThree = 'Zealous Snort';ReadyMoveFour = 'Zealous Snort'
        elseif pet.name == 'HurlerPercival' or pet.name == 'BeetleFamiliar' or pet.name == 'PanzerGalahad' then
            PetInfo = "Beetle, Vermin";PetJob = 'Paladin';ReadyMoveOne = 'Power Attack';ReadyMoveTwo = 'Rhino Attack';ReadyMoveThree = 'Hi-Freq Field';ReadyMoveFour = 'Rhino Guard'
        elseif pet.name == 'Y.BeetleFamilia' or pet.name == 'EnergizedSefina' then
            PetInfo = "Beetle (Horn), Vermin";PetJob = 'Paladin';ReadyMoveOne = 'Rhinowrecker';ReadyMoveTwo = 'Hi-Freq Field';ReadyMoveThree = 'Rhino Attack';ReadyMoveFour = 'Rhino Guard'
        elseif pet.name == 'BlackbeardRandy' or pet.name == 'TigerFamiliar' or pet.name == 'SaberSiravarde' or pet.name == 'GorefangHobs' then
            PetInfo = "Tiger, Beast";PetJob = 'Warrior';ReadyMoveOne = 'Razor Fang';ReadyMoveTwo = 'Crossthrash';ReadyMoveThree = 'Roar';ReadyMoveFour = 'Predatory Glare'
        elseif pet.name == 'ColibriFamiliar' or pet.name == 'ChoralLeera' then
            PetInfo = "Colibri, Bird";PetJob = 'Red Mage';ReadyMoveOne = 'Pecking Flurry';ReadyMoveTwo = 'Pecking Flurry';ReadyMoveThree = 'Pecking Flurry';ReadyMoveFour = 'Pecking Flurry'
        elseif pet.name == 'SpiderFamiliar' or pet.name == 'GussyHachirobe' then
            PetInfo = "Spider, Vermin";PetJob = 'Warrior';ReadyMoveOne = 'Sickle Slash';ReadyMoveTwo = 'Acid Spray';ReadyMoveThree = 'Spider Web';ReadyMoveFour = 'Spider Web'
        elseif pet.name == 'GenerousArthur' or pet.name == 'GooeyGerard' then
            PetInfo = "Slug, Amorph";PetJob = 'Warrior';ReadyMoveOne = 'Purulent Ooze';ReadyMoveTwo = 'Corrosive Ooze';ReadyMoveThree = 'Corrosive Ooze';ReadyMoveFour = 'Corrosive Ooze'
        elseif pet.name == 'ThreestarLynn' or pet.name == 'DipperYuly' then
            PetInfo = "Ladybug, Vermin";PetJob = 'Thief';ReadyMoveOne = 'Spiral Spin';ReadyMoveTwo = 'Sudden Lunge';ReadyMoveThree = 'Noisome Powder';ReadyMoveFour = 'Noisome Powder'
        elseif pet.name == 'SharpwitHermes' or pet.name == 'SweetCaroline' or pet.name == 'FlowerpotBill' or pet.name == 'FlowerpotBen' or pet.name == 'Homunculus' or pet.name == 'FlowerpotMerle' then
            PetInfo = "Mandragora, Plantoid";PetJob = 'Monk';ReadyMoveOne = 'Head Butt';ReadyMoveTwo = 'Leaf Dagger';ReadyMoveThree = 'Wild Oats';ReadyMoveFour = 'Scream'
        elseif pet.name == 'AcuexFamiliar' or pet.name == 'FluffyBredo' then
            PetInfo = "Acuex, Amorph";PetJob = 'Black Mage';ReadyMoveOne = 'Foul Waters';ReadyMoveTwo = 'Pestilent Plume';ReadyMoveThree = 'Pestilent Plume';ReadyMoveFour = 'Pestilent Plume'
        elseif pet.name == 'FlytrapFamiliar' or pet.name == 'VoraciousAudrey' or pet.name == 'PrestoJulio' then
            PetInfo = "Flytrap, Plantoid";PetJob = 'Warrior';ReadyMoveOne = 'Soporific';ReadyMoveTwo = 'Palsy Pollen';ReadyMoveThree = 'Gloeosuccus';ReadyMoveFour = 'Gloeosuccus'
        elseif pet.name == 'EftFamiliar' or pet.name == 'AmbusherAllie' or pet.name == 'BugeyedBroncha' or pet.name == 'SuspiciousAlice' then
            PetInfo = "Eft, Lizard";PetJob = 'Warrior';ReadyMoveOne = 'Nimble Snap';ReadyMoveTwo = 'Cyclotail';ReadyMoveThree = 'Geist Wall';ReadyMoveFour = 'Numbing Noise'
        elseif pet.name == 'AntlionFamiliar' or pet.name == 'ChopsueyChucky' or pet.name == 'CursedAnnabelle' then
            PetInfo = "Antlion, Vermin";PetJob = 'Warrior';ReadyMoveOne = 'Mandibular Bite';ReadyMoveTwo = 'Venom Spray';ReadyMoveThree = 'Sandblast';ReadyMoveFour = 'Sandpit'
        elseif pet.name == 'MiteFamiliar' or pet.name == 'LifedrinkerLars' or pet.name == 'AnklebiterJedd' then
            PetInfo = "Diremite, Vermin";PetJob = 'Dark Knight';ReadyMoveOne = 'Double Claw';ReadyMoveTwo = 'Spinning Top';ReadyMoveThree = 'Filamented Hold';ReadyMoveFour = 'Grapple'
        elseif pet.name == 'AmigoSabotender' then
            PetInfo = "Cactuar, Plantoid";PetJob = 'Warrior';ReadyMoveOne = 'Needle Shot';ReadyMoveTwo = '??? Needles';ReadyMoveThree = '??? Needles';ReadyMoveFour = '??? Needles'
        elseif pet.name == 'CraftyClyvonne' then
            PetInfo = "Coeurl, Beast";PetJob = 'Warrior';ReadyMoveOne = 'Blaster';ReadyMoveTwo = 'Chaotic Eye';ReadyMoveThree = 'Chaotic Eye';ReadyMoveFour = 'Chaotic Eye'
        elseif pet.name == 'BloodclawShasra' then
            PetInfo = "Lynx, Beast";PetJob = 'Warrior';ReadyMoveOne = 'Blaster';ReadyMoveTwo = 'Charged Whisker';ReadyMoveThree = 'Chaotic Eye';ReadyMoveFour = 'Chaotic Eye'
        elseif pet.name == 'LynxFamiliar' or pet.name == 'VivaciousGaston' then
            PetInfo = "Collared Lynx, Beast";PetJob = 'Warrior';ReadyMoveOne = 'Frenzied Rage';ReadyMoveTwo = 'Charged Whisker';ReadyMoveThree = 'Chaotic Eye';ReadyMoveFour = 'Blaster'
        elseif pet.name == 'SwiftSieghard' or pet.name == 'FleetReinhard' then
            PetInfo = "Raptor, Lizard";PetJob = 'Warrior';ReadyMoveOne = 'Scythe Tail';ReadyMoveTwo = 'Ripper Fang';ReadyMoveThree = 'Chomp Rush';ReadyMoveFour = 'Chomp Rush'
        elseif pet.name == 'DapperMac' or pet.name == 'SurgingStorm' or pet.name == 'SubmergedIyo' then
            PetInfo = "Apkallu, Bird";PetJob = 'Monk';ReadyMoveOne = 'Beak Lunge';ReadyMoveTwo = 'Wing Slap';ReadyMoveThree = 'Wing Slap';ReadyMoveFour = 'Wing Slap'
        elseif pet.name == 'FatsoFargann' then
            PetInfo = "Leech, Amorph";PetJob = 'Warrior';ReadyMoveOne = 'Suction';ReadyMoveTwo = 'TP Drainkiss';ReadyMoveThree = 'Drainkiss';ReadyMoveFour = 'Acid Mist'
        elseif pet.name == 'Hip.Familiar' or pet.name == 'DaringRoland' or pet.name == 'FaithfulFalcorr' then
            PetInfo = "Hippogryph, Bird";PetJob = 'Thief';ReadyMoveOne = 'Hoof Volley';ReadyMoveTwo = 'Fantod';ReadyMoveThree = 'Nihility Song';ReadyMoveFour = 'Back Heel'
        elseif pet.name == 'CrudeRaphie' then
            PetInfo = "Adamantoise, Lizard";PetJob = 'Paladin';ReadyMoveOne = 'Tortoise Stomp';ReadyMoveTwo = 'Harden Shell';ReadyMoveThree = 'Aqua Breath';ReadyMoveFour = 'Aqua Breath'
        elseif pet.name == 'MosquitoFamilia' or pet.name == 'Left-HandedYoko' then
            PetInfo = "Mosquito, Vermin";PetJob = 'Dark Knight';ReadyMoveOne = 'Infected Leech';ReadyMoveTwo = 'Gloom Spray';ReadyMoveThree = 'Gloom Spray';ReadyMoveFour = 'Gloom Spray'
        elseif pet.name == 'WeevilFamiliar' or pet.name == 'StalwartAngelin' then
            PetInfo = "Weevil, Vermin";PetJob = 'Thief';ReadyMoveOne = 'Disembowel';ReadyMoveTwo = 'Extirpating Salvo';ReadyMoveThree = 'Extirpating Salvo';ReadyMoveFour = 'Extirpating Salvo'
        elseif pet.name == 'SlimeFamiliar' or pet.name == 'SultryPatrice' then
            PetInfo = "Slime, Amorph";PetJob = 'Warrior';ReadyMoveOne = 'Fluid Toss';ReadyMoveTwo = 'Fluid Spread';ReadyMoveThree = 'Digest';ReadyMoveFour = 'Digest'
        end
    else
        PetName = 'None';PetJob = 'None';PetInfo = 'None';ReadyMoveOne = 'None';ReadyMoveTwo = 'None';ReadyMoveThree = 'None';ReadyMoveFour = 'None'
    end
end


function pet_buff_timer(spell)
    if spell.english == 'Reward' then
        send_command('timers c "Pet: Regen" 180 down '..RewardRegenIcon..'')
    elseif spell.english == 'Spur' then
        send_command('timers c "Pet: Spur" 90 down '..SpurIcon..'')
    elseif spell.english == 'Run Wild' then
        send_command('timers c "'..spell.english..'" '..RunWildDuration..' down '..RunWildIcon..'')
    end
end

function clear_pet_buff_timers()
    send_command('timers c "Pet: Regen" 0 down '..RewardRegenIcon..'')
    send_command('timers c "Pet: Spur" 0 down '..SpurIcon..'')
    send_command('timers c "Run Wild" 0 down '..RunWildIcon..'')
end

function display_mode_info()
    if DisplayModeInfo == 'true' and DisplayTrue == 1 then
        local x = TextBoxX
        local y = TextBoxY
        send_command('text AccuracyText create Acc. Mode: '..state.OffenseMode.value..'')
        send_command('text AccuracyText pos '..x..' '..y..'')
        send_command('text AccuracyText size '..TextSize..'')
        y = y + (TextSize + 6)
        send_command('text CorrelationText create Corr. Mode: '..state.CorrelationMode.value..'')
        send_command('text CorrelationText pos '..x..' '..y..'')
        send_command('text CorrelationText size '..TextSize..'')
        y = y + (TextSize + 6)
        send_command('text JugPetText create Jug Mode: '..state.JugMode.value..'')
        send_command('text JugPetText pos '..x..' '..y..'')
        send_command('text JugPetText size '..TextSize..'')
        DisplayTrue = DisplayTrue - 1
    end
end

function update_display_mode_info()
    if DisplayModeInfo == 'true' then
        send_command('text AccuracyText text Acc. Mode: '..state.OffenseMode.value..'')
        send_command('text CorrelationText text Corr. Mode: '..state.CorrelationMode.value..'')
        send_command('text JugPetText text Jug Mode: '..state.JugMode.value..'')
    end
end

function checkblocking(spell)
    if buffactive.sleep or buffactive.petrification or buffactive.terror then 
        --add_to_chat(3,'Canceling Action - Asleep/Petrified/Terror!')
        cancel_spell()
        return
    end 
    if spell.english == "Double-Up" then
        if not buffactive["Double-Up Chance"] then 
            add_to_chat(3,'Canceling Action - No ability to Double Up')
            cancel_spell()
            return
        end
    end
    if spell.name ~= 'Ranged' and spell.type ~= 'WeaponSkill' and spell.type ~= 'Scholar' and spell.type ~= 'Monster' then
        if spell.action_type == 'Ability' then
            if buffactive.Amnesia then
                cancel_spell()
                add_to_chat(3,'Canceling Ability - Currently have Amnesia')
                return
            else
                recasttime = windower.ffxi.get_ability_recasts()[spell.recast_id] 
                if spell and (recasttime >= 1) then
                    --add_to_chat(3,'Ability Canceled:'..spell.name..' - Waiting on Recast:(seconds) '..recasttime..'')
                    cancel_spell()
                    return
                end
            end
        end
    end
    --if spell.type == 'WeaponSkill' and player.tp < 1000 then
    --    cancel_spell()
    --    add_to_chat(3,'Canceled WS:'..spell.name..' - Current TP is less than 1000.')
    --    return
    --end
    --if spell.type == 'WeaponSkill' and buffactive.Amnesia then
    --    cancel_spell()
    --    add_to_chat(3,'Canceling Ability - Currently have Amnesia.')
    --    return	  
    --end
    --if spell.name == 'Utsusemi: Ichi' and (buffactive['Copy Image (3)'] or buffactive ['Copy Image (4+)']) then
    --    cancel_spell()
    --    add_to_chat(3,'Canceling Utsusemi - Already have maximum shadows (3).')
    --    return
    --end
    if spell.type == 'Monster' or spell.name == 'Reward' then
        if pet.isvalid then
            if spell.name == 'Fireball' and pet.status ~= "Engaged" then
                cancel_spell()
                send_command('input /pet Fight <t>')
                return
            end
            local s = windower.ffxi.get_mob_by_target('me')
            local pet = windower.ffxi.get_mob_by_target('pet')
            local PetMaxDistance = 4
            local pettargetdistance = PetMaxDistance + pet.model_size + s.model_size
            if pet.model_size > 1.6 then 
                pettargetdistance = PetMaxDistance + pet.model_size + s.model_size + 0.1
            end
            if pet.distance:sqrt() >= pettargetdistance then
                --add_to_chat(3,'Canceling: '..spell.name..' - Outside valid JA Distance.')
                cancel_spell()
                return
            end
        else
            add_to_chat(3,'Canceling: '..spell.name..' - That action requires a pet.')
            cancel_spell()
            return
        end
    end
    if spell.name == 'Fight' then
        if pet.isvalid then 
            local t = windower.ffxi.get_mob_by_target('t') or windower.ffxi.get_mob_by_target('st')
            local pet = windower.ffxi.get_mob_by_target('pet')
            local PetMaxDistance = 32 
            local DistanceBetween = ((t.x - pet.x)*(t.x-pet.x) + (t.y-pet.y)*(t.y-pet.y)):sqrt()
            if DistanceBetween > PetMaxDistance then 
                --add_to_chat(3,'Canceling: Fight - Replacing with Heel since target is 30 yalms away from pet.')
                cancel_spell()
                send_command('@wait .5; input /pet Heel <me>')
                return
            end
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

function determine_haste_group()
    classes.CustomMeleeGroups:clear()
    if DW == true then
        if DW_needed <= 11 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif DW_needed > 11 and DW_needed <= 21 then
            classes.CustomMeleeGroups:append('MaxHastePlus')
        elseif DW_needed > 21 and DW_needed <= 27 then
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

function update_combat_form()
    if DW == true then
        state.CombatForm:set('DW')
    elseif DW == false then
        state.CombatForm:reset()
    end
end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
       equip(sets.DefaultShield)
    end
end