--[[local zap_ring_texture = nil
local modpath = nil
local noop = function() end]]--

function package_init(package)
    package:declare_package_id("com.D3stroy3d.player.Elecman")
    package:set_special_description("Uncage your inner beast!")
    package:set_speed(5.0)
    package:set_attack(2)
    package:set_charged_attack(50)
    package:set_icon_texture(Engine.load_texture(_modpath.."elecman_face.png"))
    package:set_preview_texture(Engine.load_texture(_modpath.."preview.png"))
    package:set_overworld_animation_path(_modpath.."elecmanOW.animation")
    package:set_overworld_texture_path(_modpath.."elecmanOW.png")
    package:set_mugshot_texture_path(_modpath.."mug.png")
    package:set_mugshot_animation_path(_modpath.."mug.animation")
end

function player_init(player)
    player:set_name("Elecman")
    player:set_health(2000)
    player:set_element(Element.Elec)
    player:set_height (60.0)
    player:set_animation(_modpath.."elecman.animation")
    player:set_texture(Engine.load_texture(_modpath.."elecman_atlas.png"), true)
    player:set_fully_charged_color(Color.new(255,0,0,255))

    --[[zap_ring_texture = Engine.load_texture(_modpath.."thunder.png")
    modpath = _modpath]]--
    player.update_func = function(self, dt) 
        -- nothing in particular
    end
end

function create_normal_attack(player)
    print("buster attack")
    return Battle.Buster.new(player, false, 10)
end

--[[function create_bolt(player)
    local DAMAGE = 30
    local FRAMES_PER_MOVEMENT = 5

    local field = player:get_field()
    local player_tile = player:get_current_tile()

    local bolt = Battle.Spell.new(Team.Red)
    bolt:set_texture(zap_ring_texture, true)
    bolt:set_position(0, -30)
    bolt:set_hit_props(make_hit_props(
        DAMAGE,
        Hit.Impact | Hit.Flinch | Hit.Stun,
        Element.Elec,
        player:get_id(),
        drag(Direction.None, 0)
    ))

    -- animation
    local animation = bolt:get_animation()
    animation:load(modpath.."thunder.animation")
    animation:set_state("DEFAULT", Playback.Loop, noop)

    field:spawn(bolt, player_tile:x(), player_tile:y())

    -- lifetime stuff
    local remaining_time = 0
    local x = player_tile:x()

    function move()
        remaining_time = FRAMES_PER_MOVEMENT + 1
        x = x + 1
        local destination = field:tile_at(x, player_tile:y())
        bolt:slide(destination, frames(FRAMES_PER_MOVEMENT), frames(0), ActionOrder.Immediate, noop)
    end

    bolt.update_func = function(action, time)
        bolt:get_current_tile():attack_entities(bolt)

        -- test if we need to move
        remaining_time = remaining_time - 1

        if remaining_time > 0 then
            return
        end

        if x < field:width() + 2 then
            move()
        else
            -- reached the end, delete ourself
            bolt:delete()
        end
    end

    bolt.attack_func = function()
        -- delete the bolt if we've hit something
        bolt:delete()
    end

    bolt.delete_func = noop

    bolt.can_move_to_func = function(tile)
        return true
    end
end
]]--
function create_special_attack(player)
    --[[local zap_ring_action = Battle.CardAction.new(player, "PLAYER_SHOOTING")

    zap_ring_action.execute_func = function(action, time)
        Engine.play_audio(AudioType.Thunder, AudioPriority.Low)
        create_bolt(player)
    end

    zap_ring_action.update_func = noop]]--

    return nil --zap_ring_action
end

function create_charged_attack(player)
    print("charged attack")
    return Battle.Bomb.new(player, 80)
end

