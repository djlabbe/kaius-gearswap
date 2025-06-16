function item_available(item)
	if player.inventory[item] or player.wardrobe[item] or player.wardrobe2[item] or 
       player.wardrobe3[item] or player.wardrobe4[item] or player.wardrobe5[item] or 
       player.wardrobe6[item] or player.wardrobe7[item] or player.wardrobe8[item] then
		return true
	else
		return false
	end
end

gear = {}

include('gear/weapons.lua')
include('gear/ammo.lua')
include('gear/head.lua')
include('gear/neck.lua')
include('gear/body.lua')
include('gear/hands.lua')
include('gear/legs.lua')
include('gear/feet.lua')
include('gear/rings.lua')
include('gear/back.lua')
include('gear/waist.lua')





