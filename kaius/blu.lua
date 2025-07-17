-------------------------------------------------------------------------------------------------------------------
--  Keybinds
-------------------------------------------------------------------------------------------------------------------
--
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
--------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
    include('lib/enchantments.lua')
end

function job_setup()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false

    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
    blue_magic_maps = {}

    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.

    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{'Bilgestorm'}

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{'Heavy Strike'}

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{'Battle Dance','Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Saurian Slide','Sinker Drill','Spinal Cleave','Sweeping Gouge',
        'Uppercut','Vertical Cleave'}

    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{'Amorphic Spikes','Asuran Claws','Barbed Crescent','Claw Cyclone',
        'Disseverment','Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Seedspray','Sickle Slash','Smite of Rage','Terror Touch','Thrashing Assault','Vanity Dive'}

    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum','Sprout Smack','Sub-zero Smash'}

    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{'Benthic Typhoon','Feather Storm','Helldive','Hydro Shot','Jet Stream',
        'Pinecone Bomb','Spiral Spin','Wild Oats'}

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{'Mandibular Bite','Queasyshroom'}

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{'Ram Charge','Screwdriver','Tourbillion'}

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{'Bludgeon'}

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{'Final Sting'}

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{'Anvil Lightning','Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere',
        'Droning Whirlwind','Embalming Earth','Entomb','Firespit','Foul Waters','Ice Break','Leafstorm',
        'Maelstrom','Molting Plumage','Nectarous Deluge','Regurgitation','Rending Deluge','Scouring Spate',
        'Silent Storm','Spectral Floe','Subduction','Tem. Upheaval','Water Bomb'}

    blue_magic_maps.MagicalDark = S{'Dark Orb','Death Ray','Eyes On Me','Evryone. Grudge','Palling Salvo',
        'Tenebral Crush'}

    blue_magic_maps.MagicalLight = S{'Blinding Fulgor','Diffusion Ray','Radiant Breath','Rail Cannon',
        'Retinal Glare'}

    -- Magical spells with a primary Mnd mod
    blue_magic_maps.MagicalMnd = S{'Acrid Stream','Magic Hammer','Mind Blast'}

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{'Mysterious Light'}

    -- Magical spells with a Vit stat mod (on top of Int)
    blue_magic_maps.MagicalVit = S{'Thermal Pulse'}

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{'Charged Whisker','Gates of Hades'}

    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{'1000 Needles','Absolute Terror','Actinic Burst','Atra. Libations',
        'Auroral Drape','Awful Eye', 'Blank Gaze','Blistering Roar','Blood Saber','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Demoralizing Roar','Digest','Dream Flower',
        'Enervation','Feather Tickle','Filamented Hold','Frightful Roar','Geist Wall','Hecatomb Wave',
        'Infrasonics','Jettatura','Light of Penance','Lowing','Mind Blast','Mortal Ray','MP Drainkiss',
        'Osmosis','Reaving Wind','Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast',
        'Stinking Gas','Sub-zero Smash','Venom Shell','Voracious Trunk','Yawn'}

    -- Breath-based spells
    blue_magic_maps.Breath = S{'Bad Breath','Flying Hip Press','Frost Breath','Heat Breath','Hecatomb Wave',
        'Magnetite Cloud','Poison Breath','Self-Destruct','Thunder Breath','Vapor Spray','Wind Breath'}

    -- Stun spells
    blue_magic_maps.StunPhysical = S{'Frypan','Head Butt','Sudden Lunge','Tail slap','Whirl of Rage'}
    blue_magic_maps.StunMagical = S{'Blitzstrahl','Temporal Shift','Thunderbolt'}

    -- Healing spells
    blue_magic_maps.Healing = S{'Healing Breeze','Magic Fruit','Plenilune Embrace','Pollen','Restoral',
        'Wild Carrot'}

    -- Buffs that depend on blue magic skill
    blue_magic_maps.SkillBasedBuff = S{'Barrier Tusk','Diamondhide','Magic Barrier','Metallic Body',
        'Plasma Charge','Pyric Bulwark','Reactor Cool','Occultation'}

    -- Other general buffs
    blue_magic_maps.Buff = S{'Amplification','Animating Wail','Carcharian Verve','Cocoon',
        'Erratic Flutter','Exuviation','Fantod','Feather Barrier','Harden Shell','Memento Mori',
        'Nat. Meditation','Orcish Counterstance','Refueling','Regeneration','Saline Coat','Triumphant Roar',
        'Warm-Up','Winds of Promyvion','Zephyr Mantle'}

    blue_magic_maps.Refresh = S{'Battery Charge'}

    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{'Absolute Terror','Bilgestorm','Blistering Roar','Bloodrake','Carcharian Verve','Cesspool',
        'Crashing Thunder','Cruel Joke','Droning Whirlwind','Gates of Hades','Harden Shell','Mighty Guard',
        'Polar Roar','Pyric Bulwark','Tearing Gust','Thunderbolt','Tourbillion','Uproot'}
end

function user_setup()
    state.OffenseMode:options('Normal', 'PDL')
    state.HybridMode:options('Normal', 'DT', 'Learning')
    state.RangedMode:options('Normal')
    state.WeaponskillMode:options('Normal', 'PDL')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'MDT')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Tizona', 'Naegling', 'Maxentius', 'Nuking', 'Tanking'}
    state.WeaponLock = M(false, 'Weapon Lock')
    include('Global-Binds.lua')

    gear.Artifact_Hands = { name="Assimilator's Bazubands +2" }
    -- gear.Artifact_Body = { name="Assim. Jubbah +3" }
    
    gear.Relic_Head = { name="Luhlaza Keffiyeh +3" }
    gear.Relic_Body = { name="Luhlaza Jubbah +3" }
    gear.Relic_Hands = { name="Luhlaza Bazubands +3" }
    gear.Relic_Legs = { name="Luhlaza Shalwar +3" }
    gear.Relic_Feet = { name="Luhlaza Charuqs +3" }

    gear.Empyrean_Head = { name="Hashishin Kavuk +3" }
    gear.Empyrean_Body = { name="Hashishin Mintan +3" }
    gear.Empyrean_Hands = { name="Hashishin Bazubands +3" }
    gear.Empyrean_Legs = { name="Hashishin Tayt +3" }
    gear.Empyrean_Feet = { name="Hashishin Basmak +3" }

    gear.BLU_TP_Cape = { name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Phys. dmg. taken-10%',}} --X
    gear.BLU_WS1_Cape = { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}} --X
    gear.BLU_WS2_Cape = { name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}}  --X
    gear.BLU_MAB_Cape = { name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10','Phys. dmg. taken-10%',}} --X
    gear.BLU_EVA_Cape = { name="Rosmerta's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Fast Cast"+10','Evasion+15',}} --X

    send_command('lua l azureSets')

    send_command('bind @w gs c toggle WeaponLock')
    send_command('bind @e gs c cycleback WeaponSet')

    send_command('bind !F1 input /ja "Azure Lore" <me>')
    send_command('bind !F2 input /ja "Unbridled Wisdom" <me>')

    send_command('bind !t input /ma "Glutinous Dart" <t>')
    send_command('bind !i input /ma "Barrier Tusk" <me>')
    send_command('bind !j input /ma "Reactor Cool" <me>')
    send_command('bind ^[ input /ja "Diffusion" <me>')
    send_command('bind !u input /ma "Aquaveil" <me>')
    send_command('bind !h input /ma "Erratic Flutter" <me>')
    send_command('bind !b input /ma "Battery Charge" <me>')

    if player.sub_job == 'DRG' then
        send_command('bind ^numpad7 gs c set WeaponSet Tizona;input /macro set 16;input /macro set 1')
        send_command('bind ^numpad8 gs c set WeaponSet Naegling;input /macro set 16;input /macro set 2')
        send_command('bind ^numpad9 gs c set WeaponSet Maxentius;input /macro set 16;input /macro set 3')
        send_command('bind ^numpad4 gs c set WeaponSet Nuking;input /macro set 16;input /macro set 10')
        send_command('bind ^numpad5 gs c set WeaponSet Tanking;input /macro book 16;input /macro set 1')
        send_command('bind !c input /ja "Ancient Circle" <me>')
        set_macro_page(1, 16)
    elseif player.sub_job == 'WAR' then
        send_command('bind ^numpad7 gs c set WeaponSet Tizona;input /macro set 16;input /macro set 4')
        send_command('bind ^numpad8 gs c set WeaponSet Naegling;input /macro set 16;input /macro set 5')
        send_command('bind ^numpad9 gs c set WeaponSet Maxentius;input /macro set 16;input /macro set 6')
        send_command('bind ^numpad4 gs c set WeaponSet Nuking;input /macro set 16;input /macro set 10')
        send_command('bind ^numpad5 gs c set WeaponSet Tanking;input /macro book 16;input /macro set 1')
        set_macro_page(4, 16)
    elseif player.sub_job == 'RDM' then
        send_command('bind ^numpad7 gs c set WeaponSet Tizona;input /macro set 16;input /macro set 7')
        send_command('bind ^numpad8 gs c set WeaponSet Naegling;input /macro set 16;input /macro set 8')
        send_command('bind ^numpad9 gs c set WeaponSet Maxentius;input /macro set 16;input /macro set 9')
        send_command('bind ^numpad4 gs c set WeaponSet Nuking;input /macro set 16;input /macro set 10')
        send_command('bind ^numpad5 gs c set WeaponSet Tanking;input /macro book 16;input /macro set 1')
        send_command('bind !p input /ma "Protect III" <me>')
        send_command('bind !o input /ma "Shell III" <me>')
        send_command('bind !i input /ma "Phalanx" <me>')
        set_macro_page(7, 16)
    else
        send_command('bind ^numpad7 gs c set WeaponSet Tizona;input /macro set 16;input /macro set 1')
        send_command('bind ^numpad8 gs c set WeaponSet Naegling;input /macro set 16;input /macro set 2')
        send_command('bind ^numpad9 gs c set WeaponSet Maxentius;input /macro set 16;input /macro set 3')
        send_command('bind ^numpad4 gs c set WeaponSet Nuking;input /macro set 16;input /macro set 4')
        send_command('bind ^numpad5 gs c set WeaponSet Tanking;input /macro book 36;input /macro set 1')
        set_macro_page(1, 16)
    end
    
    send_command('wait 3; input /lockstyleset 16')
end

function user_unload()
    send_command('unbind @w')
    send_command('unbind @e')
    send_command('unbind @q')
    send_command('unbind !F1')
    send_command('unbind !F2')
    send_command('unbind !`')
    send_command('unbind ![')
    send_command('unbind !]')
    send_command('unbind !t')
    send_command('unbind !u')
    send_command('unbind !h')
    send_command('unbind !i')
    send_command('unbind !j')
    unbind_numpad()
    send_command('lua u azureSets')
    send_command('lua u bluguide')
end

function init_gear_sets()

    sets.Enmity = {
        ammo="Sapience Orb", --2
        head="Halitus Helm", --8
        body="Emet Harness +1", --10
        hands="Kurys Gloves", --9
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet, --7
        neck="Unmoving Collar +1", --10
        ear1="Cryptic Earring", --4
        ear2="Trux Earring", --5
        ring1="Defending Ring",
        ring2="Eihwaz Ring", --5
        waist="Platinum Moogle Belt", --3
    }

    sets.precast.JA['Provoke'] = sets.Enmity

    sets.buff['Burst Affinity'] = {legs=gear.Artifact_Legs, feet=gear.Empyrean_Feet}
    sets.buff['Diffusion'] = {feet=gear.Relic_Feet}
    sets.buff['Efflux'] = {legs=gear.Relic_Legs}

    sets.precast.JA['Azure Lore'] = {hands=gear.Relic_Hands}
    sets.precast.JA['Chain Affinity'] = {feet=gear.Artifact_Feet}
    sets.precast.JA['Convergence'] = {head=gear.Relic_Head}
    sets.precast.JA['Enchainment'] = {body=gear.Relic_Body}

    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head=gear.Carmine_D_Head, --14
        body="Pinga Tunic +1", --15
        hands="Leyline Gloves", --8
        legs="Pinga Pants +1", --13
        feet=gear.Carmine_B_Feet, --8
        neck="Orunmila's Torque", --5
        ear1="Loquacious Earring", --2
        ear2="Enchntr. Earring +1", --2
        ring1="Kishar Ring", --4
        ring2="Prolix Ring", --2
        back="Fi Follet Cape +1", --10
    }

    sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body=gear.Empyrean_Body})
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
    sets.precast.FC.Cure = set_combine(sets.precast.FC, {ammo="Impatiens", ear1="Mendi. Earring"})

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {
        ammo="Impatiens",
        ring1="Lebeche Ring",
        waist="Rumination Sash",
    })

    sets.precast.WS = {
        ammo="Aurgelmir Orb +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1="Epaminondas's Ring",
        ring2="Ilabrat Ring",
        back=gear.BLU_WS1_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS.PDL = set_combine(sets.precast.WS, {})

    sets.precast.WS['Chant du Cygne'] = {
        ammo="Aurgelmir Orb +1",
        head=gear.Nyame_Head,
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Gleti_Feet,
        neck="Mirage Stole +2",
        ear1="Mache Earring +1",
        ear2="Odr Earring",
        ring1="Begrudging Ring",
        ring2="Epona's Ring",
        back=gear.BLU_WS1_Cape,
    }

    sets.precast.WS['Vorpal Blade'] = sets.precast.WS['Chant du Cygne']

    sets.precast.WS['Savage Blade'] = {
        ammo="Coiste Bodhar",
        head=gear.Empyrean_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Mirage Stole +2",
        ear1="Moonshade Earring",
        ear2="Ishvara Earring",
        ring1=gear.Cornelia_Or_Epaminondas,
        ring2=gear.Ephramad_Or_Sroda,
        back=gear.BLU_WS1_Cape,
        waist="Sailfi Belt +1",
    }

    sets.precast.WS["Savage Blade"].PDL = set_combine(sets.precast.WS["Savage Blade"], {
        ammo="Crepuscular Pebble",
        body=gear.Gleti_Body,
    })

    sets.precast.WS['True Strike'] = sets.precast.WS['Savage Blade']
    sets.precast.WS['True Strike'].PDL = sets.precast.WS["Savage Blade"].PDL
    sets.precast.WS['Judgment'] = sets.precast.WS['Savage Blade']
    sets.precast.WS['Judgment'].PDL = sets.precast.WS["Savage Blade"].PDL
    sets.precast.WS['Black Halo'] = set_combine(sets.precast.WS['Savage Blade'], {
        ear2="Regal Earring",
    })
    sets.precast.WS['Black Halo'].PDL = set_combine(sets.precast.WS['Savage Blade'].PDL, {
        ear2="Regal Earring",
    })

    sets.precast.WS['Requiescat'] = {
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Fotia Gorget",
        ear1="Moonshade Earring",
        ear2="Regal Earring",
        ring1="Metamorph Ring +1",
        ring2=gear.Cornelia_Or_Sroda,
        back=gear.BLU_WS1_Cape,
        waist="Fotia Belt",
    }

    sets.precast.WS["Requiescat"].PDL = set_combine(sets.precast.WS["Requiescat"], {
        ammo="Crepuscular Pebble",
        body=gear.Gleti_Body,
    })

    sets.precast.WS['Expiacion'] = sets.precast.WS['Savage Blade']

    sets.precast.WS['Sanguine Blade'] = {
        ammo="Ghastly Tathlum +1",
        head="Pixie Hairpin +1",
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Sibyl Scarf",
        ear1="Moonshade Earring",
        ear2="Regal Earring",
        ring1="Metamorph Ring +1",
        ring2="Archon Ring",
        back=gear.BLU_MAB_Cape,
        waist="Orpheus's Sash",
    }

    sets.precast.WS['Realmrazer'] = sets.precast.WS['Requiescat']

    sets.precast.WS['Flash Nova'] = set_combine(sets.precast.WS['Sanguine Blade'], {
        head=gear.Nyame_Head,
    })

    sets.midcast.FastRecast = sets.precast.FC

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1",
        body=gear.Taeon_Phalanx_Body,
        hands=gear.Taeon_Phalanx_Hands,
        legs=gear.Carmine_D_Legs,
        feet=gear.Taeon_Phalanx_Feet,
        neck="Loricate Torque +1",
        ear1="Halasz Earring",
        ear2="Magnetic Earring",
        ring2="Evanescence Ring",
        waist="Rumination Sash", 
    }

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.midcast['Blue Magic'] = {
        ammo="Pemphredo Tathlum",
        head=gear.Relic_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Mirage Stole +2",
        ear1="Njordr Earring",
        ear2="Hashi. Earring +1",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Aurist's Cape +1"
    }

    sets.midcast['Blue Magic'].Physical = {
        ammo="Aurgelmir Orb +1",
        head=gear.Relic_Head,
        body=gear.Gleti_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Relic_Feet,
        neck="Mirage Stole +2",
        ring1="Regal Ring",
        ring2="Ilabrat Ring",
        back=gear.BLU_WS1_Cape,
        waist="Sailfi Belt +1",
    }

    sets.midcast['Blue Magic'].PhysicalAcc = set_combine(sets.midcast['Blue Magic'].Physical, {
        head=gear.Carmine_D_Head,
        hands=gear.Empyrean_Hands,
        legs=gear.Carmine_D_Legs,
        neck="Mirage Stole +2",
        ear2="Telos Earring",
        back="Cornflower Cape",
        waist="Kentarch Belt +1",
    })

    sets.midcast['Blue Magic'].PhysicalStr = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {
        ear2="Mache Earring +1",
        ring2="Ilabrat Ring",
        back=gear.BLU_WS1_Cape,
        waist="Kentarch Belt +1",
    })

    sets.midcast['Blue Magic'].PhysicalVit = sets.midcast['Blue Magic'].Physical

    sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {
        hands=gear.Gleti_Hands,
        ring2="Ilabrat Ring",
    })

    sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {
        ammo="Ghastly Tathlum +1",
        ear2="Regal Earring",
        ring1="Shiva Ring +1",
        ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
    })

    sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {
        ear2="Regal Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Aurist's Cape +1",
    })

    sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {
        ear1="Regal Earring", 
        ear2="Enchntr. Earring +1"
    })

    sets.midcast['Blue Magic'].Magical = {
        ammo="Ghastly Tathlum +1",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Sibyl Scarf",
        ear1="Regal Earring",
        ear2="Friomisi Earring",
        ring1="Shiva Ring +1",
        ring2="Metamor. Ring +1",
        back=gear.BLU_MAB_Cape,
        waist="Orpheus's Sash",
    }

    sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical, {
        neck="Mirage Stole +2",
        ear2="Hashishin Earring +1",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        waist="Acuity Belt +1",
    })

    sets.midcast['Blue Magic'].MagicalDark = set_combine(sets.midcast['Blue Magic'].Magical, {
        head="Pixie Hairpin +1",
        ring2="Archon Ring",
    })

    sets.midcast['Blue Magic'].MagicalLight = set_combine(sets.midcast['Blue Magic'].Magical, {
        -- ring2="Weather. Ring"
    })

    sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Aurist's Cape +1",
    })

    sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {
        ammo="Aurgelmir Orb +1",
        ear2="Mache Earring +1",
        ring2="Ilabrat Ring",
    })

    sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {
        ammo="Aurgelmir Orb +1",
    })

    sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {
        ear1="Regal Earring",
        ear2="Enchntr. Earring +1"
    })

    sets.midcast['Blue Magic'].MagicAccuracy = {
        ammo="Pemphredo Tathlum",
        head=gear.Empyrean_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Empyrean_Feet,
        neck="Mirage Stole +2",
        ear1="Crepuscular Earring",
        ear2="Hashi. Earring +1",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
    }

    sets.midcast['Blue Magic']['Reaving Wind'] = {
        ammo="Pemphredo Tathlum",
        head=gear.Carmine_D_Head,
        neck="Mirage Stole +2",
        ear1="Crepuscular Earring",
        ear2="Hashi. Earring +1",
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.BLU_MAB_Cape, -- TODO
        waist="Acuity Belt +1",
        legs=gear.Empyrean_Legs,
        feet="Malignance Boots"
    }

    sets.midcast['Blue Magic']['Feather Tickle'] = sets.midcast['Reaving Wind']

    sets.midcast['Blue Magic'].Breath = set_combine(sets.midcast['Blue Magic'].Magical, {
        head=gear.Relic_Head,
    })

    sets.midcast['Blue Magic'].StunPhysical = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Mirage Stole +2",
        ear2="Mache Earring +1",
        back="Aurist's Cape +1",
        waist="Acuity Belt +1",
    })

    sets.midcast['Blue Magic'].StunMagical = sets.midcast['Blue Magic'].MagicAccuracy

    sets.midcast['Blue Magic'].Healing = {
        ammo="Staunch Tathlum +1",
        head=gear.Empyrean_Head,
        body="Pinga Tunic +1",
        hands=gear.Telchine_CURE_Hands,
        legs="Pinga Pants +1",
        feet="Medium's Sabots",
        neck="Loricate Torque +1",
        ear1="Mendi. Earring",
        ear2="Regal Earring",
        ring1="Metamorph Ring +1",
        ring2=gear.Stikini_2,
        back="Oretan. Cape +1",
        waist="Luminary Sash",
    }

    sets.midcast['Blue Magic'].HealingSelf = set_combine(sets.midcast['Blue Magic'].Healing, {
        -- legs="Gyve Trousers",
        neck="Phalaina Locket",
        ring2="Asklepian Ring",
        back="Solemnity Cape",
        waist="Gishdubar Sash",
    })

    sets.midcast['Blue Magic']['White Wind'] = {
        ammo="Staunch Tathlum +1",
        head=gear.Nyame_Head,
        body="Pinga Tunic +1",
        hands=gear.Telchine_CURE_Hands,
        legs="Pinga Pants +1",
        feet=gear.Carmine_D_Feet,
        neck="Unmoving Collar +1",
        ear1="Mendicant's Earring",
        ear2="Odnowa Earring +1",
        ring1="Gelatinous Ring +1",
        ring2=gear.Janniston_Or_Eihwaz,
        back="Moonlight Cape",
        waist="Platinum Moogle Belt",
    }

    sets.midcast['Blue Magic'].Buff = sets.midcast['Blue Magic']
    sets.midcast['Blue Magic'].Refresh = set_combine(sets.midcast['Blue Magic'], {
        head=gear.Amalric_A_Head, 
        waist="Gishdubar Sash",
    })

    sets.midcast['Blue Magic'].SkillBasedBuff = sets.midcast['Blue Magic']

    sets.midcast['Blue Magic']['Occultation'] = set_combine(sets.midcast['Blue Magic'], {
        hands=gear.Empyrean_Hands,
        ear1="Njordr Earring",
        ear2="Enchntr. Earring +1",
    })

    sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {
        head=gear.Amalric_A_Head, 
        waist="Emphatikos Rope",
    })  

    sets.midcast['Enhancing Magic'] = {
        ammo="Pemphredo Tathlum",
        head=gear.Carmine_D_Head,
        body=gear.Telchine_ENH_Body,
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Carmine_D_Legs,
        feet=gear.Telchine_ENH_Feet,
        neck="Incanter's Torque",
        ear1="Mimir Earring",
        ear2="Andoaa Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back="Fi Follet Cape +1",
        waist="Olympus Sash",
    }

    sets.midcast.EnhancingDuration = {
        head=gear.Telchine_ENH_Head,
        body=gear.Telchine_ENH_Body,
        hands=gear.Telchine_ENH_Hands,
        legs=gear.Telchine_ENH_Legs,
        feet=gear.Telchine_ENH_Feet,
    }

    sets.midcast.Refresh = set_combine(sets.midcast.EnhancingDuration, {
        head=gear.Amalric_A_Head, 
        waist="Gishdubar Sash",
    })

    sets.midcast.Stoneskin = set_combine(sets.midcast.EnhancingDuration, {
        waist="Siegel Sash"
    })

    sets.midcast.Phalanx = set_combine(sets.midcast.EnhancingDuration, {
        sub="Sakpata's Sword",
        -- head=
        body=gear.Herc_PHLX_Body, --4(10)
        hands=gear.Herc_PHLX_Hands, --3(10)
        legs=gear.Taeon_Phalanx_Legs, --4(10)
        feet=gear.Herc_PHLX_Feet, --5(10)
    })

    sets.midcast.Aquaveil = set_combine(sets.midcast.EnhancingDuration, {
        head=gear.Amalric_A_Head, 
        hands="Regal Cuffs",
        waist="Emphatikos Rope",
    })

    sets.midcast.Protect = set_combine(sets.midcast.EnhancingDuration, {ring1="Sheltered Ring"})
    sets.midcast.Protectra = sets.midcast.Protect
    sets.midcast.Shell = sets.midcast.Protect
    sets.midcast.Shellra = sets.midcast.Protect

    sets.midcast['Enfeebling Magic'] = set_combine(sets.midcast['Blue Magic'].MagicAccuracy, {
        head=empty;
        body="Cohort Cloak +1",
        ear2="Vor Earring",
    })

    sets.midcast.Utsusemi = sets.midcast.SpellInterrupt

    sets.engaged = {
        ammo="Coiste Bodhar",
        head=gear.Malignance_Head,
        body=gear.Gleti_Body,
        hands=gear.Adhemar_A_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Mirage Stole +2",
        ear1="Dedition Earring",
        ear2="Hashishin Earring +1",
        ring1=gear.Lehko_Or_Chirich1,
        ring2=gear.Chirich_2,
        back=gear.BLU_TP_Cape,
        waist="Sailfi Belt +1",
    }

    sets.engaged.DW = {
        ammo="Coiste Bodhar",
        head=gear.Malignance_Head,
        body=gear.Gleti_Body,
        hands=gear.Gleti_Hands,
        legs=gear.Gleti_Legs,
        feet=gear.Malignance_Feet,
        neck="Mirage Stole +2",
        ear1="Telos Earring",
        ear2="Hashishin Earring +1",
        ring1=gear.Lehko_Or_Chirich1,
        ring2="Epona's Ring",
        back=gear.BLU_TP_Cape,
        waist="Sailfi Belt +1", 
    } 

    sets.engaged.Aftermath = {
        ammo="Aurgelmir Orb +1",
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Mirage Stole +2",
        ear1="Telos Earring",
        ear2="Hashishin Earring +1",
        ring1=gear.Lehko_Or_Chirich1,
        ring2=gear.Chirich_2,
        back=gear.BLU_TP_Cape,
        waist="Kentarch Belt +1", 
    }

    sets.engaged.Hybrid = {
        ring2=gear.Chirich_2,
    }
    
    sets.engaged.AftermathHybrid = {
        ammo="Aurgelmir Orb +1",
        head=gear.Malignance_Head,
        body=gear.Malignance_Body,
        hands=gear.Malignance_Hands,
        legs=gear.Malignance_Legs,
        feet=gear.Malignance_Feet,
        neck="Mirage Stole +2",
        ear1="Telos Earring",
        ear2="Hashishin Earring +1",
        ring1=gear.Lehko_Or_Chirich1,
        ring2=gear.Chirich_2,
        back=gear.BLU_TP_Cape,
        waist="Kentarch Belt +1", 
    }

    sets.engaged.Learning = {
        body=gear.Gleti_Body,
        feet=gear.Nyame_Feet,
        head=gear.Nyame_Head,
        legs=gear.Nyame_Legs,
        ring1="Epona's Ring",
        ring2="Hetairoi Ring",
        hands=gear.Artifact_Hands,
        ear1="Mache Earring +1",
    }

    
    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)
    sets.engaged.DW.DT = set_combine(sets.engaged.DW, sets.engaged.Hybrid)
    sets.engaged.Learning = set_combine(sets.engaged, sets.engaged.Learning)
    sets.engaged.DW.Learning = set_combine(sets.engaged.DW, sets.engaged.Learning)

    sets.idle = {
        ammo="Staunch Tathlum +1",
        head="Null Masque",
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Malignance_Feet,
        neck="Warder's Charm +1",
        ear1="Eabani Earring",
        ear2="Sanare Earring",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.BLU_MAB_Cape,
        waist="Plat. Mog. Belt",
    }

    sets.idle.DT = {
        ammo="Staunch Tathlum +1",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Bathy Choker +1",
        waist="Plat. Mog. Belt",
        ear1="Eabani Earring",
        ear2="Sanare Earring",
        ring1="Vengeful Ring",
        ring2="Gelatinous Ring +1",
        back=gear.BLU_EVA_Cape,
    }

    sets.idle.Town =  sets.idle
    sets.idle.Weak = sets.idle.DT

    if (item_available("Shneddick Ring +1")) then
        sets.Kiting = { ring1="Shneddick Ring +1" }
    else
        sets.Kiting = { legs=gear.Carmine_A_Legs }
    end
    
    -- sets.latent_refresh = {waist="Fucho-no-obi"}

    sets.defense.PDT = {
        ammo="Staunch Tathlum +1",
        head=gear.Nyame_Head,
        body=gear.Empyrean_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Loricate Torque +1",
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1",
        ring1="Shadow Ring",
        ring2="Defending Ring",
        back=gear.BLU_TP_Cape,
        waist="Plat. Mog. Belt",
    }

    sets.defense.MDT = {
        ammo="Staunch Tathlum +1",
        head=gear.Nyame_Head,
        body=gear.Empyrean_Body,
        hands=gear.Nyame_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Nyame_Feet,
        neck="Loricate Torque +1",
        ear1="Eabani Earring",
        ear2="Etiolation Earring",
        ring1="Shadow Ring",
        ring2="Defending Ring",
        back=gear.BLU_TP_Cape,
        waist="Plat. Mog. Belt",
    }


    sets.buff.Doom = {
        neck="Nicander's Necklace",
        ring1="Eshmun's Ring",
        ring2="Purity Ring",
        waist="Gishdubar Sash",
    }

    sets.Tizona = {main="Tizona", sub="Thibron"}
    sets.Naegling = {main="Naegling", sub="Thibron"}
    sets.Maxentius = {main="Maxentius", sub="Thibron"}
    sets.Nuking = {main="Maxentius", sub="Bunzi's Rod"}
    sets.Tanking = {main="Tizona", sub="Sakpata's Sword"}
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if unbridled_spells:contains(spell.english) and not state.Buff['Unbridled Learning'] then
        eventArgs.cancel = true
        windower.send_command('@input /ja "Unbridled Learning" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
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

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
        if spellMap == 'Magical' then
            if spell.element == world.weather_element and (get_weather_intensity() == 2 and spell.element ~= elements.weak_to[world.day_element]) then
                equip({waist="Hachirin-no-Obi"})
            end
        end
        if spellMap == 'Healing' and spell.target.type == 'SELF' then
            equip(sets.midcast['Blue Magic'].HealingSelf)
        end
    end

    if spell.skill == 'Enhancing Magic' and classes.NoSkillSpells:contains(spell.english) then
        equip(sets.midcast.EnhancingDuration)
        if spellMap == 'Refresh' then
            equip(sets.midcast.Refresh)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == "Dream Flower" then
            send_command('@timers c "Dream Flower ['..spell.target.name..']" 90 down spells/00098.png')
        elseif spell.english == "Soporific" then
            send_command('@timers c "Sleep ['..spell.target.name..']" 90 down spells/00259.png')
        elseif spell.english == "Sheep Song" then
            send_command('@timers c "Sheep Song ['..spell.target.name..']" 60 down spells/00098.png')
        elseif spell.english == "Yawn" then
            send_command('@timers c "Yawn ['..spell.target.name..']" 60 down spells/00098.png')
        elseif spell.english == "Entomb" then
            send_command('@timers c "Entomb ['..spell.target.name..']" 60 down spells/00547.png')
        end
    end
    if player.status ~= 'Engaged' and state.WeaponLock.value == false then
        check_weaponset()
    end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff,gain)
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

-- Handle notifications of general user state change.
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
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end



function get_custom_wsmode(spell, action, spellMap)
    local wsmode
    if state.OffenseMode.value == 'PDL' then
        wsmode = 'PDL'
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
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end

    if (buffactive['Aftermath: Lv.3'] and player.equipment.main == "Tizona") then
        if (state.HybridMode == "DT") then
            meleeSet = set_combine(meleeSet, sets.engaged.AftermathHybrid)
        else
            meleeSet = set_combine(meleeSet, sets.engaged.Aftermath)
        end
    end
    return meleeSet
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


    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,060).. ' Magic: ' ..string.char(31,001)..c_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002))

    eventArgs.handled = true
end


function job_self_command(cmdParams, eventArgs)
    if not midaction() then
        job_update()
    end
    if (cmdParams[1]:lower() == 'enchantment') then
        handle_enchantment_command(cmdParams[2], eventArgs)
    end
end


function update_active_abilities()
    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Efflux'] = buffactive['Efflux'] or false
    state.Buff['Diffusion'] = buffactive['Diffusion'] or false
end

-- State buff checks that will equip buff gear and mark the event as handled.
function apply_ability_bonuses(spell, action, spellMap)
    if state.Buff['Burst Affinity'] and (spellMap == 'Magical' or spellMap == 'MagicalLight' or spellMap == 'MagicalDark' or spellMap == 'Breath') then
        equip(sets.buff['Burst Affinity'])
    end
    if state.Buff.Efflux and spellMap == 'Physical' then
        equip(sets.buff['Efflux'])
    end
    if state.Buff.Diffusion and (spellMap == 'Buffs' or spellMap == 'BlueSkill') then
        equip(sets.buff['Diffusion'])
    end

    if state.Buff['Burst Affinity'] then equip (sets.buff['Burst Affinity']) end
    if state.Buff['Efflux'] then equip (sets.buff['Efflux']) end
    if state.Buff['Diffusion'] then equip (sets.buff['Diffusion']) end
end

function check_weaponset()
    equip(sets[state.WeaponSet.current])
    if player.sub_job ~= 'NIN' and player.sub_job ~= 'DNC' then
       equip(sets.DefaultShield)
    end
end