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
-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

function get_sets()
    mote_include_version = 2.
    include('Mote-Include.lua')
end

function job_setup()
end

function user_setup()
    state.OffenseMode:options('Normal')
    state.WeaponskillMode:options('Normal')
    state.HybridMode:options('Normal', 'DT')
    state.IdleMode:options('Normal', 'DT')

    state.WeaponSet = M{['description']='Weapon Set', 'Naegling', 'ShiningOne', 'Loxotic' }
    state.WeaponLock = M(false, 'Weapon Lock')

    -- Additional local binds
    include('Global-Binds.lua')

    -- gear.Artifact_Head = { name= "Pummeler's Mask +1" }
    gear.Artifact_Body = { name= "Pummeler's Lorica +3" }
    -- gear.Artifact_Hands = { name= "Pummeler's Mufflers +1" }
    gear.Artifact_Legs = { name= "Pummeler's Cuisses +3" }
    gear.Artifact_Feet = { name= "Pummeler's Calligae +3" }

    gear.Relic_Head = { name= "Agoge Mask +3" }
    gear.Relic_Body = { name= "Agoge Lorica +3" }
    gear.Relic_Hands = { name= "Agoge Mufflers +3" }
    gear.Relic_Legs = { name= "Agoge Cuisses +3" }
    gear.Relic_Feet = { name= "Agoge Calligae +3" }

    -- gear.Empyrean_Head = { name= "Boii Mask +1" }
    gear.Empyrean_Body = { name= "Boii Lorica +2" }
    gear.Empyrean_Hands = { name= "Boii Mufflers +3" }
    gear.Empyrean_Legs = { name= "Boii Cuisses +3" }
    gear.Empyrean_Feet = { name= "Boii Calligae +2" }

    send_command('bind @w gs c toggle WeaponLock')
    
    send_command('bind ^numpad7 gs c set WeaponSet Naegling;input /macro set 1')
    send_command('bind ^numpad8 gs c set WeaponSet Naegling;input /macro set 2')
    send_command('bind ^numpad9 gs c set WeaponSet Loxotic;input /macro set 3')
    send_command('bind ^numpad4 gs c set WeaponSet ShiningOne;input /macro set 4')
    
    if player.sub_job == 'SAM' then
        send_command('bind !` input /ja "Hasso" <me>')
        send_command('bind ^` input /ja "Seigan" <me>')
    end

    send_command('bind !F1 input /ja "Mighty Strikes" <me>')
    send_command('bind !F2 input /ja "Brazen Rush" <me>')
    
    send_command('bind !t input /ja "Provoke" <t>')

    -- Set macros and style
    set_macro_page(1, 1)
    send_command('wait 3; input /lockstyleset 1' )

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind !`')
    send_command('unbind ^`')
    send_command('unbind !t')
end

-- Define sets and vars used by this job file.
function init_gear_sets()

    sets.precast.JA["Berserk"] = {
        body=gear.Artifact_Body,
        feet=gear.Relic_Feet,
    }

    sets.precast.JA["Warcry"] = {
        head=gear.Relic_Head
    }

    sets.precast.JA['Restraint'] = {
        hands=gear.Empyrean_Hands,
    }

    sets.precast.JA['Blood Rage'] = {
        body=gear.Empyrean_Body,
    }
    
    sets.precast.JA['Aggressor'] = {
        body=gear.Relic_Body,
        head=gear.Relic_Head,
    }
    sets.engaged = {
        ammo="Aurgelmir Orb +1",
        head="Flamma Zucchetto +2",
        body=gear.Empyrean_Body, --12
        hands=gear.Sakpata_Hands, --8
        legs="Pumm. Cuisses +3",
        -- feet="Pummeler's Calligae +3",
        feet="Tatenashi Sune-Ate +1",
        neck="War. Beads +1",
        waist="Sailfi Belt +1",
        ear1="Schere Earring",
        ear2="Boii Earring +1",
        ring1="Niqmaddu Ring",
        ring2=gear.Chirich_2,
        back=gear.WAR_TP_Cape,
    }

    sets.engaged.Hybrid = {
        head="Sakpata's Helm", --7
        body="Sakpata's Breastplate", --12
        hands="Sakpata's Gauntlets", --8
        legs="Sakpata's Cuisses", --9
        feet="Sakpata's Leggings", --6
    }

    sets.engaged.DT = set_combine(sets.engaged, sets.engaged.Hybrid)

    sets.precast.WS = {
        ammo="Knobkierrie",        
        head=gear.Relic_Head,
        body=gear.Nyame_Body,        
        hands=gear.Nyame_Hands,
        legs=gear.Empyrean_Legs, --9
        feet=gear.Nyame_Feet,
        neck="Warrior's Bead Necklace +1",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2="Sroda Ring",       
        waist="Sailfi Belt +1",  
        back=gear.WAR_WS1_Cape,
    }

    sets.precast.WS['Savage Blade'] = {
        ammo="Knobkierrie",        
        head=gear.Relic_Head,
        body=gear.Nyame_Body,       
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Nyame_Feet,
        neck="Warrior's Bead Necklace +1",
        ear1="Thrud Earring",
        ear2="Moonshade Earring",
        ring1="Epaminondas's Ring",
        ring2="Sroda Ring",
        waist="Sailfi Belt +1",  
        back=gear.WAR_WS1_Cape,
    }
    -- Add custom WSs here
    -- sets.precast.WS['Raging Fists'] = {
        -- TODO
    -- }

    sets.precast.FC = {
        ammo="Sapience Orb", --2
        head=gear.Sakpata_Head, --8
        hands="Leyline Gloves", --8
        neck="Baetyl Pendant", --4
        ear1="Etiolation Earring", --1
        ear2="Enchanter's Earring +1", --2
    }

    sets.buff.Doom = {
        neck="Nicander's Necklace", --20
        ring1="Eshmun's Ring", --20
        ring2="Purity Ring", --20
        waist="Gishdubar Sash", --10
    }

    sets.idle = sets.engaged.DT
    sets.Naegling = { main="Naegling", sub="Blurred Shield +1" }
    sets.Loxotic = { main="Loxotic Mace +1", sub="Blurred Shield +1" }
    sets.ShiningOne = { main="Shining One", sub="Utu Grip" }
    sets.Kiting = { ring1="Shneddick Ring" }
    sets.idle.Town = sets.precast.WS['Savage Blade']
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
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
    if buff == "doom" then
        if gain then
            equip(sets.buff.Doom)
            disable('ring1','ring2','waist')
            send_command('@input /p Doomed.')
        else
            enable('ring1','ring2','waist')
            handle_equipping_gear(player.status)
        end
    end

    if buff == 'Hasso' and not gain then
        add_to_chat(167, 'Hasso just expired!')
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

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if state.Auto_Kite.value == true then
       idleSet = set_combine(idleSet, sets.Kiting)
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    check_weaponset()
    return meleeSet
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

    local msg = ''
    if state.Kiting.value then
        msg = msg .. ' Kiting: On |'
    end

    add_to_chat(002, '| ' ..string.char(31,210).. 'Melee' ..cf_msg.. ': ' ..string.char(31,001)..m_msg.. string.char(31,002)..  ' |'
        ..string.char(31,207).. ' WS: ' ..string.char(31,001)..ws_msg.. string.char(31,002)..  ' |'
        ..string.char(31,004).. ' Defense: ' ..string.char(31,001)..d_msg.. string.char(31,002)..  ' |'
        ..string.char(31,008).. ' Idle: ' ..string.char(31,001)..i_msg.. string.char(31,002)..  ' |'
        ..string.char(31,002)..msg)

    eventArgs.handled = true
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    gearinfo(cmdParams, eventArgs)
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

function check_weaponset()
    equip(sets[state.WeaponSet.current])
end
