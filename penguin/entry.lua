function LoadTexture(path)
    return Engine.ResourceHandle.new().Textures:LoadFile(path)
end

function roster_init(info) 
    info:set_special_description("")
    info:set_speed(1.0)
    info:set_attack(1)
    info:set_charged_attack(10)
    info:set_icon_texture(LoadTexture(_modpath.."face.png"))
    info:set_preview_texture(LoadTexture(_modpath.."preview.png"))
    info:set_overworld_animation_path(_modpath.."overworld.animation")
    info:set_overworld_texture_path(_modpath.."overworld.png")
    info:set_mugshot_texture_path(_modpath.."mug.png")
    info:set_mugshot_animation_path(_modpath.."mug.animation")
end

function battle_init(player)
    player:set_name("Club Penguin")
    player:set_health(1000)
    player:set_element(Element.Ice)
    player:set_height(100.0)
    player:set_animation(_modpath.."battle.animation")
    player:set_texture(LoadTexture(_modpath.."battle.png"), true)
    player:set_fully_charge_color(Color.new(-100,0,255,255))
end

function execute_special_attack(player)
    return nil
end

function execute_buster_attack(player)
    return Battle.Buster.new(player, false, 1)
end

function execute_charged_attack(player)
    return Battle.Buster.new(player, false, 10)
end
