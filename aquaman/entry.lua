function package_init(package)
    package:declare_package_id("com.D3str0y3d.player.Aquaman")
    package:set_special_description("Aquas the name, Aquas the game!")
    package:set_speed(5.0)
    package:set_attack(2)
    package:set_charged_attack(50)
    package:set_icon_texture(Engine.load_texture(_modpath.."aquaman_face.png"))
    package:set_preview_texture(Engine.load_texture(_modpath.."preview.png"))
    package:set_overworld_animation_path(_modpath.."aquamanOW.animation")
    package:set_overworld_texture_path(_modpath.."aquamanOW.png")
    package:set_mugshot_texture_path(_modpath.."mug.png")
    package:set_mugshot_animation_path(_modpath.."mug.animation")
end

function player_init(player)
    player:set_name("Aquaman")
    player:set_health(1400)
    player:set_element(Element.Aqua)
    player:set_height (50.0)
    player:set_animation(_modpath.."aquaman_battle.animation")
    player:set_texture(Engine.load_texture(_modpath.."aquaman_atlas.png"), true)
    player:set_fully_charged_color(Color.new(255,0,0,255))


    player.update_func = function(self, dt) 
        -- nothing in particular
    end
end

function create_normal_attack(player)
    print("buster attack")
    return Battle.Buster.new(player, false, 5)
end

function create_charged_attack(player)
    print("charged attack")
    return Battle.Bomb.new(player, 80)
end

function create_special_attack(player)
    print("execute special")
    return Battle.Sword.new(player, 40)
end