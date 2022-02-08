function package_init(package)
    package:declare_package_id("com.D3str0y3d.player.Quickman")
    package:set_special_description("Speedy")
    package:set_speed(5.0)
    package:set_attack(2)
    package:set_charged_attack(50)
    package:set_icon_texture(Engine.load_texture(_modpath.."quickman_face.png"))
    package:set_preview_texture(Engine.load_texture(_modpath.."preview.png"))
    package:set_overworld_animation_path(_modpath.."QuickwipOW.animation")
    package:set_overworld_texture_path(_modpath.."QuickwipOW.png")
    package:set_mugshot_texture_path(_modpath.."mug.png")
    package:set_mugshot_animation_path(_modpath.."mug.animation")
end

function player_init(player)
    player:set_name("Quickman")
    player:set_health(1800)
    player:set_element(Element.None)
    player:set_height (50.0)
    player:set_animation(_modpath.."quickman.animation")
    player:set_texture(Engine.load_texture(_modpath.."quickman_atlas.png"), true)
    player:set_fully_charged_color(Color.new(255,0,0,255))

    player.normal_attack_func = function()
    return Battle.Buster.new(player, false, player:get_attack_level())
    end

    player.charged_attack_func = function()
    return Battle.Buster.new(player, true, player:get_attack_level() * 10)
    end

end
