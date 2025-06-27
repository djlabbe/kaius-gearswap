function init_hud()
    res = require('resources')
    config = require('config')
    local default = { visible = true, debug = false, info = true, warn = true,
		Display_Box = {text={size=10,font='Consolas',red=255,green=255,blue=255,alpha=255},pos={x=1636,y=803},bg={visible=true,red=0,green=0,blue=0,alpha=102},},}

    local settings = config.load(default)

    local gs_status = texts.new("",settings.Display_Box)
    if settings.visible then gs_status:show() end

    -- UI for displaying the current states
    function display_box_update()
        local width = 25
        local dialog = {}
        dialog[1] = {description = 'Weapon', value = state.WeaponSet.value}
        dialog[2] = {description = 'Weapons Locked', value = state.WeaponLock.value}
        dialog[3] = {description = 'Offense', value = state.OffenseMode.value}
        dialog[4] = {description = 'Hybrid', value = state.HybridMode.value}
        -- dialog[4] = {description = 'QD', value = state.QD.value}
        local lines = T{}
        for k, v in next, dialog do
            lines:insert(v.description ..string.format('[%s]',tostring(v.value)):lpad(' ',width-string.len(tostring(v.description))))
        end
        local maxWidth = math.max(1, table.reduce(lines, function(a, b) return math.max(a, #b) end, '1'))
        -- Pad each entry
        for i,line in ipairs(lines) do lines[i] = lines[i]:rpad(' ', maxWidth) end
        gs_status:text(lines:concat('\n'))
    end

    coroutine.schedule(display_box_update, 2)
end

init_hud()