function package_init(package) 
    package:declare_package_id("com.gemini0.player.shanghai")
    package:set_special_description("NetNavi of Alice Shinki.")
    package:set_speed(1.0)
    package:set_attack(5)
    package:set_charged_attack(50)
    package:set_icon_texture(Engine.load_texture(_modpath.."shanghai_face.png"))
    package:set_preview_texture(Engine.load_texture(_modpath.."shanghai_preview.png"))
    package:set_overworld_animation_path(_modpath.."ShanghaiOW.animation")
    package:set_overworld_texture_path(_modpath.."ShanghaiOW.png")
    package:set_mugshot_texture_path(_modpath.."mug.png")
    package:set_mugshot_animation_path(_modpath.."mug.animation")
    package:set_emotions_texture_path(_modpath.."emotions.png")
end

function player_init(player)
    player:set_name("Shanghai")
    player:set_health(500)
    player:set_element(Element.None)
    player:set_height(50.0)
    player:set_animation(_modpath.."shanghai.animation")
    player:set_texture(Engine.load_texture(_modpath.."navi_shanghai_atlas.png"), true)
    player:set_fully_charged_color(Color.new(255,255,0,255))

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
    return Battle.Buster.new(player, true, 50)
end

function create_special_attack(player)
    print("execute special")
    return nil
end