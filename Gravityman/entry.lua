function package_init(package) 
    package:declare_package_id("com.navi.Gravityman")
    package:set_speed(2.0)
    package:set_attack(1)
    package:set_charged_attack(10)
    package:set_special_description("Can you feel the gravity of the situation?")
    package:set_icon_texture(Engine.load_texture(_modpath.."mega_face.png"))
    package:set_preview_texture(Engine.load_texture(_modpath.."preview.png"))
    package:set_overworld_animation_path(_modpath.."overworld.animation")
    package:set_overworld_texture_path(_modpath.."overworld.png")
    package:set_mugshot_animation_path(_modpath.."mug.animation")
    package:set_mugshot_texture_path(_modpath.."mug.png")
end

function player_init(player)
    player:set_name("GravityMan")
    player:set_health(3000)
    player:set_element(Element.None)
    player:set_height(48.0)
    player:set_charge_position(0,-14)

    local base_animation_path = _modpath.."GravityMan.animation"
    local base_texture = Engine.load_texture(_modpath.."GravityMan.png")

    player:set_animation(base_animation_path)
    player:set_texture(base_texture)
    player:set_fully_charged_color(Color.new(255, 55, 198, 255))

    player.normal_attack_func = function()
        return Battle.Buster.new(player, false, player:get_attack_level())
    end

    player.charged_attack_func = function()
        return Battle.Buster.new(player, true, player:get_attack_level() * 10)
    end
end
