
ring = {}

ring.Stikini_1 = {name="Stikini ring +1", bag="wardrobe7"}
ring.Stikini_2 = {name="Stikini ring +1", bag="wardrobe8"}

ring.Chirich_1 = {name="Chirich ring +1", bag="wardrobe7"}
ring.Chirich_2 = {name="Chirich ring +1", bag="wardrobe8"}

ring.Moonlight_1 = {name="Moonlight ring", bag="wardrobe7", priority=110}
ring.Moonlight_2 = {name="Moonlight ring", bag="wardrobe8", priority=110}

ring.Varar_1 = {name="Varar ring +1", bag="wardrobe7"}
ring.Varar_2 = {name="Varar ring +1", bag="wardrobe8"}

ring.Shadowring = {name ="Shadow ring"}

ring.Cornelia_Or_Epaminondas = { name = "Epaminondas's ring" }
ring.Cornelia_Or_Sroda = { name = "Sroda ring" }
ring.Cornelia_Or_Niqmaddu = { name = "Niqmaddu ring" }
ring.Cornelia_Or_Regal = { name = "Regal ring" }
ring.Cornelia_Or_Ilabrat = { name = "Ilabrat ring" }
ring.Cornelia_Or_Gere = { name = "Gere ring" }

ring.Ephramad_Or_Regal = { name = "Regal ring" }
ring.Ephramad_Or_Petrov = { name = "Petrov ring" }
ring.Ephramad_Or_Ilabrat = { name = "Ilabrat ring" }
ring.Ephramad_Or_Epaminondas = { name = "Epaminondas's ring" }
ring.Ephramad_Or_Sroda = { name = "Sroda ring" }
ring.Ephramad_Or_Moonlight2 = { name="Moonlight ring", bag="wardrobe8" }

ring.Lehko_Or_Chirich1 = {name="Chirich ring +1", bag="wardrobe7"}
ring.Lehko_Or_Chirich2 = {name="Chirich ring +1", bag="wardrobe8"}
ring.Lehko_Or_Begrudging = {name="Begrudging ring" }
ring.Lehko_Or_Dingir = {name="Dingir ring" }
ring.Lehko_Or_Hetairoi = {name="Hetairoi ring"}
ring.Lehko_Or_Moonlight2 = {name="Moonlight ring", bag="wardrobe8"}
ring.Lehko_Or_Petrov = {name="Petrov ring"}
ring.Lehko_Or_Gere = {name="Gere ring"}

ring.Gerubu_Or_Stikini1 = {name="Stikini ring +1", bag="wardrobe7"}
ring.Gerubu_Or_Stikini2 = {name="Stikini ring +1", bag="wardrobe8"}
ring.Gerubu_Or_Shadow = { name = "Shadow ring" }

ring.Medada_Or_Freke = { name = "Freke ring" }
ring.Medada_Or_Metamorph = { name = "Metamorph ring +1" }

ring.Janniston_Or_Gelatinous = {name="Gelatinous ring +1", priority=135}
ring.Janniston_Or_Haomas = {name="Haoma's ring"}
ring.Janniston_Or_Eihwaz = {name="Eihwaz ring"}

if item_available("Cornelia's ring") then
    ring.Cornelia_Or_Epaminondas = { name = "Cornelia's ring" }     
    ring.Cornelia_Or_Sroda = { name = "Cornelia's ring" }
    ring.Cornelia_Or_Niqmaddu = { name = "Cornelia's ring" }
    ring.Cornelia_Or_Regal = { name = "Cornelia's ring" }
    ring.Cornelia_Or_Ilabrat = { name = "Cornelia's ring" }
    ring.Cornelia_Or_Gere = { name = "Cornelia's ring" }
end   

if item_available("Ephramad's ring") then
    ring.Ephramad_Or_Regal = { name = "Ephramad's ring" }
    ring.Ephramad_Or_Petrov = { name = "Ephramad's ring" }
    ring.Ephramad_Or_Ilabrat = { name = "Ephramad's ring" }
    ring.Ephramad_Or_Epaminondas = { name = "Ephramad's ring" }
    ring.Ephramad_Or_Sroda = { name = "Ephramad's ring" }
    ring.Ephramad_Or_Moonlight2 = { name = "Ephramad's ring" }
end

if item_available("Lehko Habhoka's ring") then
    ring.Lehko_Or_Chirich1 = { name = "Lehko Habhoka's ring" }
    ring.Lehko_Or_Chirich2 = { name = "Lehko Habhoka's ring" }
    ring.Lehko_Or_Begrudging = { name = "Lehko Habhoka's ring" }
    ring.Lehko_Or_Dingir = { name = "Lehko Habhoka's ring" }
    ring.Lehko_Or_Hetairoi = { name = "Lehko Habhoka's ring" }
    ring.Lehko_Or_Moonlight2 = { name = "Lehko Habhoka's ring" }
    ring.Lehko_Or_Petrov = { name = "Lehko Habhoka's ring" }
    ring.Lehko_Or_Gere = { name = "Lehko Habhoka's ring" }
end


if item_available("Gurebu's ring") then
    ring.Gerubu_Or_Stikini1 = { name = "Gurebu's ring" }
    ring.Gerubu_Or_Stikini2 = { name = "Gurebu's ring" }
    ring.Gerubu_Or_Shadow = { name = "Gurebu's ring" }
end

if item_available("Medada's ring") then
    ring.Medada_Or_Freke = { name = "Medada's ring" }
    ring.Medada_Or_Metamorph = { name = "Medada's ring"  }
end

if item_available("Janniston ring +1") then
    ring.Janniston_Or_Gelatinous = { name = "Janniston ring +1", priority=1 }
    ring.Janniston_Or_Haomas = { name = "Janniston ring +1", priority=1 }
    ring.Janniston_Or_Eihwaz = { name = "Janniston ring +1", priority=1 }
end
