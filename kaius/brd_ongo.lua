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
end

function user_setup()
    state.OffenseMode:options('Normal')
    state.HybridMode:options('Normal')
    state.WeaponskillMode:options('Normal')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal')

    state.LullabyMode = M{['description']='Lullaby Instrument', 'Harp', 'Horn'}
    state.Carol = M{['description']='Carol','Lightning Carol', 'Lightning Carol II' }
    state.Threnody = M{['description']='Threnody', 'Earth Threnody II' }
    state.WeaponSet = M{['description']='Weapon Set', 'Carnwenhan' }
    state.WeaponLock = M(true, 'Weapon Lock')

    include('Global-Binds.lua') 
    
    info.ExtraSongInstrument = 'Daurdabla'
    info.ExtraSongs = 2

    gear.Kali_Idle = {name="Kali", augments={'MP+60','Mag. Acc.+20','"Refresh"+1',}}
    gear.Ipetam_Eva = { name="Ipetam", augments={'Evasion+14','STR+14 AGI+14',}}
    gear.Linos_EVA = { name="Linos", augments={'Evasion+13','AGI+7',}}

    gear.Artifact_Head = { name= "Brioso Roundlet +3" }
    gear.Artifact_Body = { name= "Brioso Justaucorps +3" }
    gear.Artifact_Hands = { name= "Brioso Cuffs +3" }
    gear.Artifact_Legs = { name= "Brioso Cannions +2" }
    gear.Artifact_Feet = { name= "Brioso Slippers +3" }

    gear.Relic_Head = { name= "Bihu Roundlet +3" }
    gear.Relic_Body = { name= "Bihu Justaucorps +3" }
    gear.Relic_Hands = { name= "Bihu Cuffs +3" }
    gear.Relic_Legs = { name= "Bihu Cannions +3" }
    gear.Relic_Feet = { name= "Bihu Slippers +3" }

    gear.Empyrean_Head = { name= "Fili Calot +2" }
    gear.Empyrean_Body = { name= "Fili Hongreline +3" }
    gear.Empyrean_Hands = { name= "Fili Manchettes +3" }
    gear.Empyrean_Legs = { name= "Fili Rhingrave +2" }
    gear.Empyrean_Feet = { name= "Fili Cothurnes +2" }

    gear.BRD_Song_Cape = { name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}} --*
    gear.BRD_DW_Cape = { name="Intarabus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}}
    gear.BRD_KITE_Cape = { name="Intarabus's Cape", augments={'VIT+20','Eva.+20 /Mag. Eva.+20','CHR+10','Enmity+10','DEF+50',}} --*
    gear.BRD_WS2_Cape = { name="Intarabus's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}} --*

    send_command('bind !` gs c cycle SongMode')
    send_command('bind ^` input /ma "Chocobo Mazurka" <me>')
    send_command('bind !p input /ja "Pianissimo" <me>')
    send_command('bind !t input /ja "Troubadour" <me>')
    send_command('bind ^t input /ja "Tenuto" <me>')
    send_command('bind !m input /ja "Marcato" <me>')
    send_command('bind !n input /ja "Nightingale" <me>')
    send_command('bind !h input /ma "Horde Lullaby II" <t>')
    send_command('bind !g input /ma "Foe Lullaby II" <t>')

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
    send_command('bind !numpad7 input /ma "Learned Etude" <stpc>')
    send_command('bind !numpad8 input /ma "Sage Etude" <stpc>')
    send_command('bind !numpad9 input /ma "Mage\'s Ballad III" <stpc>')

    send_command('bind !numpad4 input /ma "Victory March" <stpc>')
    send_command('bind !numpad5 input /ma "Honor March" <stpc>')

    send_command('bind !numpad1 input /ja "Pianissimo" <me>;pause 1.0;input /ma "Foe Sirvente" <me>')
    send_command('bind !numpad2 input /ja "Pianissimo" <me>;pause 1.0;input /ma "Knight\'s Minne V" <me>')
    send_command('bind !numpad3 input /ja "Pianissimo" <me>;pause 1.0;input /ma "Knight\'s Minne IV" <me>')

    set_macro_page(1, 40)

    send_command('wait 3; input /lockstyleset 10')
    send_command('gs enable range')

    state.Auto_Kite = M(false, 'Auto_Kite')
    moving = false
end

function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
    send_command('unbind ^backspace')
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
        head="Vanya Hood", --10
        body="Zendik Robe", --13
        hands="Volte Gloves", --6
        legs="Kaykaus Tights +1", --7
        feet=gear.Empyrean_Feet, --10
        neck="Orunmila's Torque", --5
        ear1="Enchanter's Earring +1", --2    
        ear2="Etiolation Earring", --1
        ring1="Ragelise's Ring", --2
        ring2="Kishar Ring", --4
        back="Fi Follet Cape +1", --10
        waist="Embla Sash", --5
    } --74


    sets.precast.FC.BardSong = set_combine(sets.precast.FC, {
        head=gear.Empyrean_Head, --14
        body=gear.Artifact_Body, --15
    })

    sets.precast.FC.SongPlaceholder = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})

    sets.precast.JA.Nightingale = {feet=gear.Relic_Feet}
    sets.precast.JA.Troubadour = {body=gear.Relic_Body}
    sets.precast.JA['Soul Voice'] = {legs=gear.Relic_Legs}

    sets.midcast.SpellInterrupt = {
        ammo="Staunch Tathlum +1", --11
        neck="Loricate Torque +1",
        ear1="Halasz Earring",
        ear2="Magnetic Earring",
        ring2="Evanescence Ring",
        waist="Rumination Sash",
    }

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
        range="Gjallarhorn",
        head=gear.Nyame_Head,
        body=gear.Empyrean_Body,
        hands=gear.Empyrean_Hands,
        legs="Inyanga Shalwar +2",
        feet=gear.Artifact_Feet,
        neck="Mnbw. Whistle +1",
        ear1="Odnowa Earring +1",
        ear1="Gelatinous Ring +1",
        ear2="Odnowa Earring +1",
        ring1=gear.Moonlight_1,
        ring2="Ragelise's Ring",
        waist="Flume Belt +1",
        back=gear.BRD_Song_Cape,
    }

    sets.midcast.SongEnfeeble = {
        range="Gjallarhorn",
        head=gear.Nyame_Head,
        body=gear.Nyame_Body,
        hands=gear.Empyrean_Hands,
        legs=gear.Empyrean_Legs,
        feet=gear.Nyame_Feet,
        neck="Unmoving Collar +1",
        ear1="Cryptic Earring",
        ear2="Trux Earring",
        ring1="Eihwaz Ring",
        ring2="Petrov Ring",
        waist="Kasiri Belt",
        back=gear.BRD_KITE_Cape,
    }

    sets.midcast['Carnage Elegy'] = {
        range="Gjallarhorn",
        head=gear.Nyame_Head,
        body=gear.Artifact_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Artifact_Feet,
        neck="Mnbw. Whistle +1",
        ear1="Crep. Earring",
        ear2="Regal Earring",
        ring1=gear.Stikini_1,
        ring2="Ragelise's Ring",
        waist="Acuity Belt +1",
        back=gear.BRD_Song_Cape,
    }

    sets.midcast['Earth Threnody II'] = {
        range="Gjallarhorn",
        head=gear.Nyame_Head,
        body=gear.Artifact_Body,
        hands=gear.Artifact_Hands,
        legs=gear.Nyame_Legs,
        feet=gear.Artifact_Feet,
        neck="Mnbw. Whistle +1",
        ear1="Crep. Earring",
        ear2="Regal Earring",
        ring1=gear.Stikini_1,
        ring2="Ragelise's Ring",
        waist="Acuity Belt +1",
        back=gear.BRD_Song_Cape,
    }

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.SongEnfeebleAcc = set_combine(sets.midcast.SongEnfeeble, {
        legs=gear.Artifact_Legs
    })

    -- Placeholder song; minimize duration to make it easy to overwrite.
    sets.midcast.SongPlaceholder = {
        range=info.ExtraSongInstrument,
        head=gear.Bunzi_Head,
        body=gear.Bunzi_Body,
        hands=gear.Bunzi_Hands,
        ring1=gear.Moonlight_1,
        ring2="Ragelise's Ring",
        legs=gear.Bunzi_Legs,
        feet=gear.Bunzi_Feet,
        neck="Loricate Torque +1",       
    }

    sets.idle = {
        main=gear.Ipetam_Eva,
        sub="Genmei Shield",
        range="Gjallarhorn",
        head=gear.Nyame_Head, --7
        body=gear.Nyame_Body, --10
        hands=gear.Nyame_Hands, --8
        legs=gear.Nyame_Legs, --9
        feet=gear.Nyame_Feet, --6
        neck="Loricate Torque +1",
        ear1="Tuisto Earring",
        ear2="Odnowa Earring +1",
        ring1="Ragelise's Ring",
        ring2="Gelatinous Ring +1",
        back=gear.BRD_KITE_Cape,
        waist="Plat. Mog. Belt",
    }

    sets.defense.PDT = sets.idle
    sets.defense.MDT = sets.idle
    sets.idle.Town = sets.idle

    sets.Carnwenhan = { main="Carnwenhan", sub="Genmei Shield" }
    sets.Kiting = { feet=gear.Empyrean_Feet }

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
            else
                equip({range="Gjallarhorn"})
            end
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



function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'carol' then
        send_command('@input /ma '..state.Carol.value..' <stpc>')
    elseif cmdParams[1]:lower() == 'threnody' then
        send_command('@input /ma '..state.Threnody.value..' <t>')
    end

    gearinfo(cmdParams, eventArgs)
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
        return 'SongEnfeeble'
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