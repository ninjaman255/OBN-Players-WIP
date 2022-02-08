function LoadTexture(path)
    return Engine.ResourceHandle.new().Textures:LoadFile(path)
end

function roster_init(info) 
    print("modpath: ".._modpath)
    info:set_special_description("Only For OW")
    info:set_speed(5.0)
    info:set_attack(2)
    info:set_charged_attack(20)
    info:set_icon_texture(LoadTexture(_modpath..""))
    info:set_preview_texture(LoadTexture(_modpath.."preview.png"))
    info:set_overworld_animation_path(_modpath.."marioOW.animation")
    info:set_overworld_texture_path(_modpath.."marioOW.png")
    info:set_mugshot_texture_path(_modpath.."")
    info:set_mugshot_animation_path(_modpath.."")
end

function battle_init(player)
    player:set_name("Mario")
    player:set_health(1000)
    player:set_element(Element.None)
    player:set_height (81.0)
    print("here 1")
    player:set_animation(_modpath.."")
    print("here 2")
    player:set_texture(LoadTexture(_modpath..""), true)
    print("here 3")
    player:set_fully_charge_color(Color.new(255,0,0,255))
    print("here 4")
end

function execute_special_attack(player)
    print("execute special")
    return nil
end

function execute_buster_attack(player)
    print("buster attack")
    return Battle.Buster.new(player, false, 10)
end

function execute_charged_attack(player)
    print("charged attack")
    return Battle.Bomb.new(player, 40)
end