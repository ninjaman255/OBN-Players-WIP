function package_init(package)
    package:declare_package_id("com.D3stroy3d.player.Heatman")
    package:set_special_description("Uncage your inner beast!")
    package:set_speed(5.0)
    package:set_attack(2)
    package:set_charged_attack(50)
    --package:set_icon_texture(Engine.load_texture(_modpath.."gutsman_face.png"))
    package:set_preview_texture(Engine.load_texture(_modpath.."preview.png"))
    package:set_overworld_animation_path(_modpath.."heatmanOW.animation")
    package:set_overworld_texture_path(_modpath.."heatmanOW.png")
    package:set_mugshot_texture_path(_modpath.."mug.png")
    package:set_mugshot_animation_path(_modpath.."mug.animation")
end

function player_init(player)
    player:set_name("Heatman")
    player:set_health(2000)
    player:set_element(Element.Fire)
    player:set_height (60.0)
    --player:set_animation(_modpath.."heatman_battle.animation")
    --player:set_texture(Engine.load_texture(_modpath.."hatman.png"), true)
    player:set_fully_charged_color(Color.new(255,0,0,255))


    player.update_func = function(self, dt) 
        -- nothing in particular
    end
end

function create_normal_attack(player)
    print("buster attack")
    return Battle.Buster.new(player, false, 10)
end

function create_charged_attack(player)
    print("charged attack")
    return Battle.Bomb.new(player, 80)
end

function create_special_attack(player)
    print("execute special")
    return Battle.Sword.new(player, 40)
end