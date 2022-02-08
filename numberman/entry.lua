function LoadTexture(path)
    return Engine.ResourceHandle.new().Textures:LoadFile(path)
end

function roster_init(info) 
    print("modpath: ".._modpath)
    info:set_special_description("Scripted net navi!")
    info:set_speed(5.0)
    info:set_attack(2)
    info:set_charged_attack(50)
    info:set_icon_texture(LoadTexture(_modpath..""))
    info:set_preview_texture(LoadTexture(_modpath.."preview.png"))
    info:set_overworld_animation_path(_modpath.."numberman_overworld.animation")
    info:set_overworld_texture_path(_modpath.."numberman_overworld.png")
    info:set_mugshot_texture_path(_modpath.."mug.png")
    info:set_mugshot_animation_path(_modpath.."mug.animation")
end

function battle_init(player)
    player:set_name("Numberman")
    player:set_health(1800)
    player:set_element(Element.Plus)
    player:set_height (160.0)
    print("here 1")
    player:set_animation(_modpath.."")
    print("here 2")
    player:set_texture(LoadTexture(_modpath..""), true)
    print("here 3")
    player:set_fully_charge_color(Color.new(255,0,0,255))
    print("here 4")
    player:set_float_shoe(true)
    print("here 5")
end
--player.SetFloatShoe(true)

function execute_special_attack(player)
    print("execute special")
    return Battle.Sword.new(player, 40)
end

function execute_buster_attack(player)
    print("buster attack")
    return Battle.Buster.new(player, false, 5)
end

function execute_charged_attack(player)
    print("charged attack")
    return Battle.Bomb.new(player, 80)
end