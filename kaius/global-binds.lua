-------------------------------------------------------------------------------------------------------------------
--  Global Keybinds
-------------------------------------------------------------------------------------------------------------------

--  Spells:     
--              [ ALT+, ]           Spectral Jig/Monomi/Sneak/Silent Oil
--              [ ALT+. ]           Tonko/Invisible/Prism Powder
--              [ Shift+Numpad7 ]     Paralyna
--              [ Shift+Numpad8 ]     Blindna 
--              [ Shift+Numpad9 ]     Silena
--              [ Shift+Numpad4 ]     Poisona
--              [ Shift+Numpad5 ]     Stona
--              [ Shift+Numpad6 ]     Viruna
--              [ Shift+Numpad1 ]     Cursna
--              [ Shift+Numpad0 ]     Erase
--
--  Items:      
--              [ CTRL+Numpad7 ]     Remedy
--              [ CTRL+Numpad8 ]     Echo Drops
--              [ CTRL+Numpad9 ]     Eye Drops
--              [ CTRL+Numpad4 ]     Antidote
--              [ CTRL+Numpad5 ]     Remedy
--              [ CTRL+Numpad6 ]     Holy Water
--
-------------------------------------------------------------------------------------------------------------------
send_command('bind !q input //sm all follow')
send_command('bind !w input //sm mirror')
send_command('bind !e input //sm all toggle')

if player.main_job == 'DNC' or player.sub_job == 'DNC' then
    send_command('bind !, input /ja "Spectral Jig" <me>')
    send_command('unbind !.')
elseif player.main_job == 'RDM' or player.sub_job == 'RDM'
    or player.main_job == 'SCH' or player.sub_job == 'SCH'
    or player.main_job == 'WHM' or player.sub_job == 'WHM' then
    send_command('bind !, input /ma "Sneak" <me>')
    send_command('bind !. input /ma "Invisible" <me>')
else
    send_command('bind !, input /item "Silent Oil" <me>')
    send_command('bind !. input /item "Prism Powder" <me>')
end

-- Default Status Cure HotKeys (SHIFT)
if player.main_job == 'WHM' or player.main_job == 'SCH' or player.sub_job == 'WHM' or player.sub_job == 'SCH' then
    send_command('bind ~numpad7 input /ma "Paralyna" <stpc>')
    send_command('bind ~numpad8 input /ma "Blindna" <stpc>')
    send_command('bind ~numpad9 input /ma "Silena" <stpc>')
    send_command('bind ~numpad4 input /ma "Poisona" <stpc>')
    send_command('bind ~numpad5 input /ma "Stona" <stpc>')
    send_command('bind ~numpad6 input /ma "Viruna" <stpc>')
    send_command('bind ~numpad1 input /ma "Cursna" <stpc>')
    send_command('bind ~numpad0 input /ma "Erase" <stpc>')
end

if player.main_job == 'DNC' or  player.sub_job == 'DNC' then
    send_command('bind ~numpad0 input /ja "Healing Waltz" <stpc>')
end


send_command('bind !numpad/ input /item "Holy Water" <me>')
send_command('bind !numpad* input /item "Panacea" <me>')
send_command('bind !numpad- input /item "Remedy" <me>')

send_command('bind @numpad7 input /ma "Valaineral" <me>')
send_command('bind @numpad8 input /ma "AAEV" <me>')
send_command('bind @numpad9 input /ma "Selh\'teus" <me>')
send_command('bind @numpad4 input /ma "Ulmia" <me>')
send_command('bind @numpad5 input /ma "Joachim" <me>')
send_command('bind @numpad6 input /ma "Qultada" <me>')
send_command('bind @numpad1 input /ma "Koru-Moru" <me>')
send_command('bind @numpad2 input /ma "King of Hearts" <me>')
send_command('bind @numpad3 input /ma "Sylvie (UC)" <me>')
send_command('bind @numpad0 input /ma "Monberaux" <me>')