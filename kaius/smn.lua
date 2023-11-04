-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Also, you'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.

--[[
    Custom commands:
    
    gs c petweather
        Automatically casts the storm appropriate for the current avatar, if possible.
    
    gs c siphon
        Automatically run the process to: dismiss the current avatar; cast appropriate
        weather; summon the appropriate spirit; Elemental Siphon; release the spirit;
        and re-summon the avatar.
        
        Will not cast weather you do not have access to.
        Will not re-summon the avatar if one was not out in the first place.
        Will not release the spirit if it was out before the command was issued.
        
    gs c pact [PactType]
        Attempts to use the indicated pact type for the current avatar.
        PactType can be one of:
            cure
            curaga
            buffOffense
            buffDefense
            buffSpecial
            debuff1
            debuff2
            sleep
            nuke2
            nuke4
            bp70
            bp75 (merits and lvl 75-80 pacts)
            astralflow
--]]


-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff["Avatar's Favor"] = buffactive["Avatar's Favor"] or false
    state.Buff["Astral Conduit"] = buffactive["Astral Conduit"] or false
    state.Buff.Doom = buffactive["Doom"] or false

    spirits = S{"LightSpirit", "DarkSpirit", "FireSpirit", "EarthSpirit", "WaterSpirit", "AirSpirit", "IceSpirit", "ThunderSpirit"}
    avatars = S{"Carbuncle", "Fenrir", "Diabolos", "Ifrit", "Titan", "Leviathan", "Garuda", "Shiva", "Ramuh", "Odin", "Alexander", "Cait Sith"}

    hybridRagePacts = S{
        'Flaming Crush',
    }

    magicalRagePacts = S{
        'Inferno',
        'Earthen Fury',
        'Tidal Wave',
        'Aerial Blast',
        'Diamond Dust',
        'Judgment Bolt',
        'Searing Light',
        'Howling Moon',
        'Ruinous Omen',
        'Fire II',
        'Stone II',
        'Water II',
        'Aero II',
        'Blizzard II',
        'Thunder II',
        'Fire IV',
        'Stone IV',
        'Water IV',
        'Aero IV',
        'Blizzard IV',
        'Thunder IV',
        'Thunderspark',
        'Burning Strike',
        'Meteorite',
        'Nether Blast',
        'Meteor Strike',
        'Heavenly Strike',
        'Wind Blade',
        'Geocrush',
        'Grand Fall',
        'Thunderstorm',
        'Holy Mist',
        'Lunar Bay',
        'Night Terror',
        'Level ? Holy'
    }


    pacts = {}
    pacts.cure = {['Carbuncle']='Healing Ruby'}

    pacts.curaga = {['Carbuncle']='Healing Ruby II', ['Garuda']='Whispering Wind', ['Leviathan']='Spring Water'}
    
    pacts.buffoffense = {
        ['Carbuncle']='Glittering Ruby', 
        ['Ifrit']='Crimson Howl', 
        ['Garuda']='Hastega II',
        ['Ramuh']='Rolling Thunder',
        ['Fenrir']='Ecliptic Growl'
    }

    pacts.buffdefense = {['Carbuncle']='Shining Ruby', ['Shiva']='Frost Armor', ['Garuda']='Aerial Armor', ['Titan']='Earthen Ward',
        ['Ramuh']='Lightning Armor', ['Fenrir']='Ecliptic Howl', ['Diabolos']='Noctoshield', ['Cait Sith']='Reraise II'}
    pacts.buffspecial = {['Ifrit']='Inferno Howl', ['Garuda']='Fleet Wind', ['Titan']='Earthen Armor', ['Diabolos']='Dream Shroud',
        ['Carbuncle']='Soothing Ruby', ['Fenrir']='Heavenward Howl', ['Cait Sith']='Raise II'}
    pacts.debuff1 = {['Shiva']='Diamond Storm', ['Ramuh']='Shock Squall', ['Leviathan']='Tidal Roar', ['Fenrir']='Lunar Cry',
        ['Diabolos']='Pavor Nocturnus', ['Cait Sith']='Eerie Eye'}
    pacts.debuff2 = {['Shiva']='Sleepga', ['Leviathan']='Slowga', ['Fenrir']='Lunar Roar', ['Diabolos']='Somnolence'}
    pacts.sleep = {['Shiva']='Sleepga', ['Diabolos']='Nightmare', ['Cait Sith']='Mewing Lullaby'}
    pacts.nuke2 = {['Ifrit']='Fire II', ['Shiva']='Blizzard II', ['Garuda']='Aero II', ['Titan']='Stone II',
        ['Ramuh']='Thunder II', ['Leviathan']='Water II'}
    pacts.nuke4 = {['Ifrit']='Fire IV', ['Shiva']='Blizzard IV', ['Garuda']='Aero IV', ['Titan']='Stone IV',
        ['Ramuh']='Thunder IV', ['Leviathan']='Water IV'}
    pacts.bp70 = {['Ifrit']='Flaming Crush', ['Shiva']='Rush', ['Garuda']='Predator Claws', ['Titan']='Mountain Buster',
        ['Ramuh']='Chaotic Strike', ['Leviathan']='Spinning Dive', ['Carbuncle']='Meteorite', ['Fenrir']='Eclipse Bite',
        ['Diabolos']='Nether Blast',['Cait Sith']='Regal Scratch'}
    pacts.bp75 = {['Ifrit']='Meteor Strike', ['Shiva']='Heavenly Strike', ['Garuda']='Wind Blade', ['Titan']='Geocrush',
        ['Ramuh']='Thunderstorm', ['Leviathan']='Grand Fall', ['Carbuncle']='Holy Mist', ['Fenrir']='Lunar Bay',
        ['Diabolos']='Night Terror', ['Cait Sith']='Level ? Holy'}
    pacts.astralflow = {['Ifrit']='Inferno', ['Shiva']='Diamond Dust', ['Garuda']='Aerial Blast', ['Titan']='Earthen Fury',
        ['Ramuh']='Judgment Bolt', ['Leviathan']='Tidal Wave', ['Carbuncle']='Searing Light', ['Fenrir']='Howling Moon',
        ['Diabolos']='Ruinous Omen', ['Cait Sith']="Altana's Favor"}

    -- Wards table for creating custom timers   
    wards = {}
    -- Base duration for ward pacts.
    wards.durations = {
        ['Crimson Howl'] = 60,
        ['Earthen Armor'] = 60, 
        ['Inferno Howl'] = 60, 
        ['Heavenward Howl'] = 60,
        ['Rolling Thunder'] = 120, 
        ['Fleet Wind'] = 120,
        ['Shining Ruby'] = 180, 
        ['Frost Armor'] = 180, 
        ['Lightning Armor'] = 180, 
        ['Ecliptic Growl'] = 180,
        ['Glittering Ruby'] = 180,
        ['Hastega'] = 180, 
        ['Noctoshield'] = 180, 
        ['Ecliptic Howl'] = 180,
        ['Dream Shroud'] = 180,
        ['Reraise II'] = 3600
    }
    -- Icons to use when creating the custom timer.
    wards.icons = {
        ['Earthen Armor']   = 'spells/00299.png', -- 00299 for Titan
        ['Shining Ruby']    = 'spells/00043.png', -- 00043 for Protect
        ['Dream Shroud']    = 'spells/00304.png', -- 00304 for Diabolos
        ['Noctoshield']     = 'spells/00106.png', -- 00106 for Phalanx
        ['Inferno Howl']    = 'spells/00298.png', -- 00298 for Ifrit
        ['Hastega']         = 'spells/00358.png', -- 00358 for Hastega
        ['Hastega II']      = 'spells/00358.png', -- 00358 for Hastega
        ['Rolling Thunder'] = 'spells/00104.png', -- 00358 for Enthunder
        ['Frost Armor']     = 'spells/00250.png', -- 00250 for Ice Spikes
        ['Lightning Armor'] = 'spells/00251.png', -- 00251 for Shock Spikes
        ['Reraise II']      = 'spells/00135.png', -- 00135 for Reraise
        ['Fleet Wind']      = 'abilities/00074.png', -- 
    }
    -- Flags for code to get around the issue of slow skill updates.
    wards.flag = false
    wards.spell = ''
end

function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')
    state.WeaponLock = M(false, 'Weapon Lock')

    include('Global-Binds.lua') 
    
    gear.perp_staff = {name="Gridarvor"}

    gear.Artifact_Head = { name="Convoker's Horn +2" }
    gear.Artifact_Body = { name="Convoker's Doublet +3" }
    gear.Artifact_Hands = { name="Convoker's Bracers +2" }
    gear.Artifact_Legs = { name="Convoker's Spats +2" }
    gear.Artifact_Feet = { name="Convoker's Pigaches +3" }

    gear.Relic_Head = { name="Glyphic Horn +3" }
    gear.Relic_Body = { name="Glyphic Doublet +3" }
    gear.Relic_Hands = { name="Glyphic Bracers +3" }
    gear.Relic_Legs = { name="Glyphic Spats +3" }
    gear.Relic_Feet = { name="Glyphic Pigaches +3" }

    gear.Empyrean_Head = { name="Beckoner's Horn +3" }
    gear.Empyrean_Body = { name="Beckoner's Doublet +2" }
    gear.Empyrean_Hands = { name="Beckoner's Bracers +2" }
    gear.Empyrean_Legs = { name="Beckoner's Spats +2" }
    gear.Empyrean_Feet = { name="Beckoner's Pigaches +2"}

    gear.SMN_Magic_Cape = { name="Campestres's Cape", augments={
        'Pet: M.Acc.+20 Pet: M.Dmg.+20',
        'Eva.+20 /Mag. Eva.+20',
        'Pet: "Regen"+10',
        'Pet: Damage taken -5%',
    }}

    gear.SMN_Physical_Cape = { name="Campestres's Cape", augments={
        'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20',
        'Eva.+20 /Mag. Eva.+20',
        'Pet: "Regen"+10',
        'Pet: Damage taken -5%',
    }}
    
    send_command('bind ^` input /macro book 15; input /macro set 1')

    send_command('bind !F1 input /ja "Astral Flow" <me>')
    send_command('bind !F2 input /ja "Astral Conduit" <me>')

    send_command('bind !` input /pet "Avatar\'s Favor" <me>')
    send_command('bind !t input /ja "Apogee" <me>')

    if player.sub_job == 'RDM' then
        send_command('bind !y input /ja "Convert" <me>')
        send_command('bind !h input /ma "Haste" <stpc>')
        send_command('bind !u input /ma "Aquaveil" <me>')
        send_command('bind !i input /ma "Phalanx" <me>')
        send_command('bind !b input /ma "Bind" <t>')
        send_command('bind !g input /ma "Gravity" <t>')
    end

    -- ALT + Numpad ===> Summons --
    send_command('bind !numpad7 input /ma "Ramuh" <me>;input /macro book 15;input /macro set 1')
    send_command('bind !numpad8 input /ma "Shiva" <me>;input /macro book 15;input /macro set 2')
    send_command('bind !numpad9 input /ma "Ifrit" <me>;input /macro book 15;input /macro set 3')  

    send_command('bind !numpad4 input /ma "Garuda" <me>;input /macro book 15;input /macro set 4')
    send_command('bind !numpad5 input /ma "Leviathan" <me>;input /macro book 15;input /macro set 5')
    send_command('bind !numpad6 input /ma "Titan" <me>;input /macro book 15;input /macro set 6')

    send_command('bind !numpad1 input /ma "Siren" <me>;input /macro book 15;input /macro set 7')
    send_command('bind !numpad2 input /ma "Cait Sith" <me>;input /macro book 15;input /macro set 8')
    send_command('bind !numpad3 input /ma "Diabolos" <me>;input /macro book 15;input /macro set 9')

    send_command('bind !numpad0 input /ma "Carbuncle" <me>;input /macro book 23;input /macro set 1')
    send_command('bind !numpad. input /ma "Fenrir" <me>;input /macro book 23;input /macro set 2')

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false

    set_macro_page(1, 15)
    send_command('wait 3; input /lockstyleset 15')
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !F1')
    send_command('unbind !F2')

    send_command('unbind !`')
    send_command('unbind !t')

    send_command('unbind !h')
    send_command('unbind !u')
    send_command('unbind !i')
    send_command('unbind !y')
    send_command('unbind !b')
    send_command('unbind !g')
    unbind_numpad()
end


-- Define sets and vars used by this job file.
function init_gear_sets()

    sets.precast.JA['Astral Flow'] = {head=gear.Relic_Head}
    
    sets.precast.JA['Elemental Siphon'] = {
        head=gear.Artifact_Head,
        neck="Caller's Pendant",
        body=gear.Empyrean_Body,
        hands=gear.Relic_Hands,
        ring1=gear.Stikini_1,
        ring2="Evoker's Ring",
        back="Conveyance Cape",
        legs="Baayami Slops +1",
        feet=gear.Empyrean_Feet,
    }

    sets.precast.JA['Mana Cede'] = {
        hands=gear.Empyrean_Hands,
    }

    -- Pact delay reduction gear
    sets.precast.BloodPactWard = {
        main="Espiritus",
        sub="Elan Strap +1",
        ammo="Epitaph",
        head="Baayami Hat +1",
        neck="Incanter's Torque",
        ear1="C. Palug Earring",
        ear2="Lodurr Earring",
        body="Baayami Robe +1",
        hands="Baayami Cuffs +1",
        ring1="Evoker's Ring",
        ring2=gear.Stikini_2,
        back="Conveyance Cape",
        waist="Kobo Obi",
        legs="Baayami Slops +1",
        feet="Baayami Sabots +1",
    }

    sets.precast.BloodPactRage = {
        main="Espiritus",
        sub="Elan Strap +1",
        ammo="Sancus Sachet +1",
        head=gear.Empyrean_Head,
        neck="Incanter's Torque",
        ear1="C. Palug Earring",
        ear2="Lodurr Earring",
        body="Baayami Robe +1",
        hands="Baayami Cuffs +1",
        ring1="Evoker's Ring",
        ring2=gear.Stikini_2,
        back="Conveyance Cape",
        waist="Kobo Obi",
        legs="Baayami Slops +1",
        feet="Baayami Sabots +1",
    }

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        main=gear.Grioavolr_FC, -- +10
        sub="Khonsu",
        ammo="Sapience Orb", --2
        head="Amalric Coif +1", -- 11
        body="Inyanga Jubbah +2", -- +14
        hands="Volte Gloves", --6
        -- legs={ name="Merlinic Shalwar", augments={'"Fast Cast"+6','CHR+6','Mag. Acc.+14','"Mag.Atk.Bns."+14',}},
        feet=gear.Merlinic_FC_Feet, --12
        neck="Orunmila's Torque", --5
        ear1="Malignance Earring", -- +4
        ear2="Loquacious Earring", -- +2
        ring1="Lebeche Ring",
        ring2="Kishar Ring", -- +4
        back="Fi Follet Cape +1", --10
        waist="Embla Sash", -- +5
    } --75 no weapon

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"}) 


    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.Cure = {
        main="Chatoyant Staff",
        sub="Khonsu",
        head="Vanya Hood",
        body="Inyanga Jubbah +2",
        hands="Inyanga Dastanas +2",
        legs=gear.Artifact_Legs,
        feet="Vanya Clogs",
        neck="Incanter's Torque",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        ear1="Meili Earring",
        ear2="Beatific Earring",
        back="Fi Follet Cape +1",
        waist="Luminary Sash",
    }

    sets.midcast.Stoneskin = {
        neck="Nodens Gorget"
    }

    -- Avatar pact sets.  All pacts are Ability type.
    sets.midcast.Pet.BloodPactWard = {
        main="Espiritus",
        sub="Elan Strap +1",
        ammo="Epitaph",
        head="Baayami Hat +1",
        neck="Incanter's Torque",
        body="Baayami Robe +1",
        hands="Baayami Cuffs +1",
        legs="Baayami Slops +1",
        feet="Baayami Sabots +1",
        ear1="Cath Palug Earring",
        ear2="Lodurr Earring",
        ring1="Evoker's Ring",
        ring2=gear.Stikini_2,
        back="Conveyance Cape",
        waist="Kobo Obi",
    }

    sets.midcast.Pet.DebuffBloodPactWard = {
        main="Espiritus",
        sub="Elan Strap +1",
        head=gear.Empyrean_Head,
        neck="Summoner's Collar +2",
        hands="Lamassu Mitts +1",
        ring1="Evoker's Ring",
        ring2=gear.Stikini_2,
        back="Conveyance Cape",
        waist="Lucidity Sash",
    }
        
    sets.midcast.Pet.DebuffBloodPactWard.Acc = sets.midcast.Pet.DebuffBloodPactWard

    sets.midcast.Pet.MagicalBloodPactRage = {
        main=gear.Grioavolr_BP,
        sub="Elan Strap +1",
        ammo="Epitaph",
        head="Cath Palug Crown",
        neck="Summoner's Collar +2",
        ear1="Lugalbanda Earring",
        ear2="Beckoner's Earring +2",
        body=gear.Apogee_A_Body,
        hands=gear.Merlinic_BP_Hands,
        ring1=gear.Varar_1,
        ring2=gear.Varar_2,
        waist="Regal Belt",
        legs=gear.Apogee_D_Legs,
        feet=gear.Apogee_A_Feet,
    }


    sets.midcast.Pet.PhysicalBloodPactRage = {
        main="Gridarvor",
        sub="Elan Strap +1",
        ammo="Epitaph",
        head=gear.Apogee_B_Head,
        neck="Summoner's Collar +2",
        ear1="Lugalbanda Earring",
        ear2="Beckoner's Earring +2",
        body=gear.Relic_Body,
        hands=gear.Merlinic_BP_Hands,
        ring1="Cath Palug Ring",
        ring2=gear.Varar_2,
        waist="Incarnation Sash",
        legs=gear.Apogee_D_Legs,
        feet=gear.Apogee_B_Feet, -- Helios Boots?
    }

    sets.midcast.Pet.HybridBloodPactRage = {
        main=gear.Grioavolr_BP,
        sub="Elan Strap +1",
        ammo="Epitaph",
        head=gear.Apogee_A_Head,
        neck="Summoner's Collar +2",
        ear1="Lugalbanda Earring",
        ear2="Beckoner's Earring +2",
        body=gear.Artifact_Body,
        hands=gear.Merlinic_BP_Hands,
        ring1=gear.Varar_1,
        ring2=gear.Varar_2,
        waist="Regal Belt",
        legs=gear.Apogee_D_Legs,
        feet=gear.Apogee_B_Feet,
        back=gear.SMN_Magic_Cape,
    }

    sets.midcast.Pet.PhysicalBloodPactRage.Acc = sets.midcast.Pet.PhysicalBloodPactRage

    sets.midcast.Pet.MagicalBloodPactRage.Acc = sets.midcast.Pet.MagicalBloodPactRage

    -- Spirits cast magic spells, which can be identified in standard ways.
    
    sets.midcast.Pet.WhiteMagic = {legs=gear.Relic_Legs}
    
    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.BloodPactRage, {legs=gear.Relic_Legs})

    sets.midcast.Pet['Elemental Magic'].Resistant = {}
    
    
    -- Idle sets
    sets.idle = {
        main="Gridarvor",
        sub="Khonsu",
        ammo="Epitaph",
        head=gear.Empyrean_Head,
        neck="Caller's Pendant",
        ear1="Lugalbanda Earring",
        ear2="Beckoner's Earring +2",
        body=gear.Apogee_A_Body,
        hands="Asteria Mitts +1",
        ring1="Shneddick Ring +1",
        ring2="Defending Ring",
        back=gear.SMN_Magic_Cape,
        waist="Lucidity Sash",
        legs="Assid. Pants +1",
        feet="Baayami Sabots +1",
    }

    sets.idle.PDT = {  
        main="Gridarvor",
        sub="Khonsu",
        ammo="Epitaph",
        head=gear.Empyrean_Head,
        neck="Caller's Pendant",
        ear1="Evans Earring",
        ear2="Beckoner's Earring +2",
        body=gear.Apogee_A_Body,
        hands="Asteria Mitts +1",
        ring1=gear.Stikini_1,
        ring2="Defending Ring",
        back=gear.SMN_Magic_Cape,
        waist="Lucidity Sash",
        legs="Assid. Pants +1",
        feet="Baayami Sabots +1",
    }
        
    sets.idle.Pet = {
        main="Gridarvor", --5
        sub="Khonsu", --(6)
        ammo="Epitaph",
        head=gear.Empyrean_Head, --(10)
        body=gear.Empyrean_Body, --7 --(6)
        hands="Asteria Mitts +1",
        legs="Assid. Pants +1", --3
        feet="Baayami Sabots +1",
        neck="Caller's Pendant", --1
        ear1="Lugalbanda Earring",
        ear2="Beckoner's Earring +2", --(6)
        ring1="Shneddick Ring +1",
        ring2="Defending Ring", --(10)
        back=gear.SMN_Magic_Cape,
        waist="Regal Belt", --(3)
    } -- +14 Refresh, -16 Perp, -41% DT, +25 PetRegain 

    sets.idle.PDT.Avatar = {
        main="Gridarvor",
        sub="Elan Strap +1",
        ammo="Epitaph",
        head=gear.Empyrean_Head,
        neck="Caller's Pendant",
        ear1="Evans Earring",
        ear2="Beckoner's Earring +2",
        body=gear.Apogee_A_Body,
        hands="Asteria Mitts +1",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.SMN_Magic_Cape,
        waist="Lucidity Sash",
        legs="Assid. Pants +1",
        feet=gear.Apogee_A_Feet,
    }

    sets.idle.Spirit = {
        main="Gridarvor",
        sub="Elan Strap +1",
        ammo="Epitaph",
        head=gear.Empyrean_Head,
        neck="Caller's Pendant",
        ear1="Evans Earring",
        ear2="Beckoner's Earring +2",
        body=gear.Apogee_A_Body,
        hands="Asteria Mitts +1",
        ring1=gear.Stikini_1,
        ring2=gear.Stikini_2,
        back=gear.SMN_Magic_Cape,
        waist="Lucidity Sash",
        legs="Assid. Pants +1",
        feet=gear.Apogee_A_Feet,
    }

    -- Favor uses Caller's Horn instead of Convoker's Horn for refresh
    sets.idle.Avatar_Favor = {
        head=gear.Empyrean_Head,
    }

    sets.idle.Avatar_Melee = {
        hands=gear.Relic_Hands,
        waist="Incarnation Sash",
        legs=gear.Empyrean_Legs
    }

  
        
    sets.perp = {}

    -- Caller's Bracer's halve the perp cost after other costs are accounted for.
    -- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
    -- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
    -- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.

    sets.perp.Day = {
        hands=gear.Empyrean_Hands,
    }

    sets.perp.Weather = {
        neck="Caller's Pendant",
        hands=gear.Empyrean_Hands,
    }

    -- -- Carby: Mitts+Conv.feet = 1/tick perp.  Everything else should be +refresh
    sets.perp.Carbuncle = {
        main="Bolelabunga",
        sub="Genmei Shield",
        head=gear.Artifact_Head,
        hands="Asteria Mitts +1",
        feet=gear.Artifact_Feet,
    }

    sets.perp.Alexander = sets.midcast.Pet.BloodPactWard
    sets.perp.staff_and_grip = {main=gear.perp_staff,sub="Khonsu"}
    
    -- Defense sets
    sets.defense.PDT = {
        main="Gridarvor",
        sub="Khonsu",
        ammo="Epitaph",
        head=gear.Empyrean_Head,
        neck="Caller's Pendant",
        ear1="Loquacious Earring",
        ear2="Evans Earring",
        body=gear.Apogee_A_Body,
        hands="Asteria Mitts +1",
        ring1="Evoker's Ring",
        ring2=gear.Stikini_2,
        back=gear.SMN_Magic_Cape,
        waist="Lucidity Sash",
        legs="Assid. Pants +1",
        feet=gear.Apogee_A_Feet,
    }

    sets.defense.MDT = {
        main="Gridarvor",
        sub="Khonsu",
        ammo="Epitaph",
        head=gear.Empyrean_Head,
        neck="Caller's Pendant",
        ear1="Loquacious Earring",
        ear2="Evans Earring",
        body=gear.Apogee_A_Body,
        hands="Asteria Mitts +1",
        ring1="Evoker's Ring",
        ring2=gear.Stikini_2,
        back=gear.SMN_Magic_Cape,
        waist="Lucidity Sash",
        legs="Assid. Pants +1",
        feet=gear.Apogee_A_Feet,
    }

    sets.Kiting = { ring1="Shneddick Ring +1" }
    
    sets.latent_refresh = {
        waist="Fucho-no-obi"
    }

    
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

function job_midcast(spell, action, spellMap, eventArgs)
    if state.Buff['Astral Conduit'] and pet_midaction() then
        eventArgs.handled = true
    end
end

-- Runs when pet completes an action.
function job_pet_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted and spell.type == 'BloodPactWard' and spellMap ~= 'DebuffBloodPactWard' then
        wards.flag = true
        wards.spell = spell.english
        send_command('wait 4; gs c reset_ward_flag')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == "Doom" then
        if gain then
            state.Buff.Doom = true
            send_command('@input /p Doomed.')
        else
            state.Buff.Doom = false
        end
    end

    if state.Buff[buff] ~= nil then
        handle_equipping_gear(player.status)
    elseif storms:contains(buff) then
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if state.WeaponLock.value == true then
        disable('main','sub')
    else
        enable('main','sub')
    end
end

function job_handle_equipping_gear(playerStatus, eventArgs)
    check_gear()
    check_moving()
end


-- Called when the player's pet's status changes.
-- This is also called after pet_change after a pet is released.  Check for pet validity.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
    if pet.isvalid and not midaction() and not pet_midaction() and (newStatus == 'Engaged' or oldStatus == 'Engaged') then
        handle_equipping_gear(player.status, newStatus)
    end
end


-- Called when a player gains or loses a pet.
-- pet == pet structure
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(petparam, gain)
    classes.CustomIdleGroups:clear()
    if gain then
        if avatars:contains(pet.name) then
            classes.CustomIdleGroups:append('Avatar')
        elseif spirits:contains(pet.name) then
            classes.CustomIdleGroups:append('Spirit')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell)
    if spell.type == 'BloodPactRage' then
        if hybridRagePacts:contains(spell.english) then
            return 'HybridBloodPactRage'
        elseif magicalRagePacts:contains(spell.english) then
            return 'MagicalBloodPactRage'
        else
            return 'PhysicalBloodPactRage'
        end
    elseif spell.type == 'BloodPactWard' and spell.target.type == 'MONSTER' then
        return 'DebuffBloodPactWard'
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if pet.isvalid then
        if pet.element == world.day_element then
            idleSet = set_combine(idleSet, sets.perp.Day)
        end
        if pet.element == world.weather_element then
            idleSet = set_combine(idleSet, sets.perp.Weather)
        end
        if sets.perp[pet.name] then
            idleSet = set_combine(idleSet, sets.perp[pet.name])
        end
        if state.Buff["Avatar's Favor"] and avatars:contains(pet.name) then
            idleSet = set_combine(idleSet, sets.idle.Avatar_Favor)
        end
        if pet.status == 'Engaged' then
            idleSet = set_combine(idleSet, sets.idle.Avatar_Melee)
        end
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Auto_Kite.value == true then
        idleSet = set_combine(idleSet, sets.Kiting)
     end
    
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    handle_equipping_gear(player.status)
    -- classes.CustomIdleGroups:clear()
    -- if pet.isvalid then
    --     if avatars:contains(pet.name) then
    --         classes.CustomIdleGroups:append('Avatar')
    --     elseif spirits:contains(pet.name) then
    --         classes.CustomIdleGroups:append('Spirit')
    --     end
    -- end
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    -- gearinfo(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'petweather' then
        handle_petweather()
        eventArgs.handled = true
    elseif cmdParams[1]:lower() == 'siphon' then
        handle_siphoning()
        eventArgs.handled = true
    elseif cmdParams[1] == 'reset_ward_flag' then
        wards.flag = false
        wards.spell = ''
        eventArgs.handled = true
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Cast the appopriate storm for the currently summoned avatar, if possible.
function handle_petweather()
    -- if player.sub_job ~= 'SCH' then
    --     add_to_chat(122, "You can not cast storm spells")
    --     return
    -- end
        
    if not pet.isvalid then
        add_to_chat(122, "You do not have an active avatar.")
        return
    end
    
    local element = pet.element
    if element == 'Thunder' then
        element = 'Lightning'
    end
    
    if S{'Light','Dark','Lightning'}:contains(element) then
        add_to_chat(122, 'You do not have access to '..elements.storm_of[element]..'.')
        return
    end 
    
    local storm = elements.storm_of[element]
    
    if storm then
        send_command('@input /ma "'..elements.storm_of[element]..'" <me>')
    else
        add_to_chat(123, 'Error: Unknown element ('..tostring(element)..')')
    end
end



-- Custom uber-handling of Elemental Siphon
function handle_siphoning()
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'Cannot use Elemental Siphon in a city area.')
        return
    end

    local siphonElement
    local stormElementToUse
    local releasedAvatar
    local dontRelease
    
    -- If we already have a spirit out, just use that.
    if pet.isvalid and spirits:contains(pet.name) then
        siphonElement = pet.element
        dontRelease = true
        -- If current weather doesn't match the spirit, but the spirit matches the day, try to cast the storm.
        if player.sub_job == 'SCH' and pet.element == world.day_element and pet.element ~= world.weather_element then
            if not S{'Light','Dark','Lightning'}:contains(pet.element) then
                stormElementToUse = pet.element
            end
        end
    -- If we're subbing /sch, there are some conditions where we want to make sure specific weather is up.
    -- If current (single) weather is opposed by the current day, we want to change the weather to match
    -- the current day, if possible.
    elseif player.sub_job == 'SCH' and world.weather_element ~= 'None' then
        -- We can override single-intensity weather; leave double weather alone, since even if
        -- it's partially countered by the day, it's not worth changing.
        if get_weather_intensity() == 1 then
            -- If current weather is weak to the current day, it cancels the benefits for
            -- siphon.  Change it to the day's weather if possible (+0 to +20%), or any non-weak
            -- weather if not.
            -- If the current weather matches the current avatar's element (being used to reduce
            -- perpetuation), don't change it; just accept the penalty on Siphon.
            if world.weather_element == elements.weak_to[world.day_element] and
                (not pet.isvalid or world.weather_element ~= pet.element) then
                -- We can't cast lightning/dark/light weather, so use a neutral element
                if S{'Light','Dark','Lightning'}:contains(world.day_element) then
                    stormElementToUse = 'Wind'
                else
                    stormElementToUse = world.day_element
                end
            end
        end
    end
    
    -- If we decided to use a storm, set that as the spirit element to cast.
    if stormElementToUse then
        siphonElement = stormElementToUse
    elseif world.weather_element ~= 'None' and (get_weather_intensity() == 2 or world.weather_element ~= elements.weak_to[world.day_element]) then
        siphonElement = world.weather_element
    else
        siphonElement = world.day_element
    end
    
    local command = ''
    local releaseWait = 0
    
    if pet.isvalid and avatars:contains(pet.name) then
        command = command..'input /pet "Release" <me>;wait 1.1;'
        releasedAvatar = pet.name
        releaseWait = 10
    end
    
    if stormElementToUse then
        command = command..'input /ma "'..elements.storm_of[stormElementToUse]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    if not (pet.isvalid and spirits:contains(pet.name)) then
        command = command..'input /ma "'..elements.spirit_of[siphonElement]..'" <me>;wait 4;'
        releaseWait = releaseWait - 4
    end
    
    command = command..'input /ja "Elemental Siphon" <me>;'
    releaseWait = releaseWait - 1
    releaseWait = releaseWait + 0.1
    
    if not dontRelease then
        if releaseWait > 0 then
            command = command..'wait '..tostring(releaseWait)..';'
        else
            command = command..'wait 1.1;'
        end
        
        command = command..'input /pet "Release" <me>;'
    end
    
    if releasedAvatar then
        command = command..'wait 1.1;input /ma "'..releasedAvatar..'" <me>'
    end
    
    send_command(command)
end

-- -- Event handler for updates to player skill, since we can't rely on skill being
-- -- correct at pet_aftercast for the creation of custom timers.
-- windower.raw_register_event('incoming chunk',
--     function (id)
--         if id == 0x62 then
--             if wards.flag then
--                 create_pact_timer(wards.spell)
--                 wards.flag = false
--                 wards.spell = ''
--             end
--         end
--     end)

-- Function to create custom timers using the Timers addon.  Calculates ward duration
-- based on player skill and base pact duration (defined in job_setup).
function create_pact_timer(spell_name)
    -- Create custom timers for ward pacts.
    if wards.durations[spell_name] then
        local ward_duration = wards.durations[spell_name]
        if ward_duration < 181 then
            local skill = player.skills.summoning_magic
            if skill > 300 then
                skill = skill - 300
                if skill > 200 then skill = 200 end
                ward_duration = ward_duration + skill
            end
        end
        
        local timer_cmd = 'timers c "'..spell_name..'" '..tostring(ward_duration)..' down'
        
        if wards.icons[spell_name] then
            timer_cmd = timer_cmd..' '..wards.icons[spell_name]
        end

        send_command(timer_cmd)
    end
end


-- function gearinfo(cmdParams, eventArgs)
--     if cmdParams[1] == 'gearinfo' then
--         if type(cmdParams[4]) == 'string' then
--             if cmdParams[4] == 'true' then
--                 moving = true
--             elseif cmdParams[4] == 'false' then
--                 moving = false
--             end
--         end
--         if not midaction() then
--             job_update()
--         end
--     end
-- end