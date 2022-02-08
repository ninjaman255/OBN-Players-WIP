-- TODO: Define missile counter location with checks for field:width() and field:height()

-- Check missile spawn time, probably ahead by a frame

function package_init(package) 
    package:declare_package_id("com.alrysc.player.metabee")
    package:set_special_description("It's Metabee")
    package:set_speed(1.0)
    package:set_attack(1)
 --   package:set_icon_texture(Engine.load_texture(_modpath..".png"))
    package:set_preview_texture(Engine.load_texture(_modpath.."preview.png"))
    package:set_overworld_animation_path(_modpath.."MetabeeOW.animation")
    package:set_overworld_texture_path(_modpath.."metabee_ow.png")
    package:set_mugshot_texture_path(_modpath.."mug.png")
    package:set_mugshot_animation_path(_modpath.."mug.animation")
   -- package:set_emotions_texture_path(_modpath.."emotions.png")

end

local metabee_effects_texture = Engine.load_texture(_modpath.. "effects.png")
local metabee_effects_animation = _modpath.."effects.animation"
local METABEE_SHOT = Engine.load_audio(_modpath.."shot.ogg") 
local METABEE_SHOT_HIT = Engine.load_audio(_modpath.."hit.ogg")  
local METABEE_MISSILE = Engine.load_audio(_modpath.."missile.ogg")
local METABEE_MISSILE_HIT = Engine.load_audio(_modpath.."missile_hit.ogg")

-- For gun held up in PLAYER_SHOOTING
--frame duration="0.134" x="46" y="276" w="36" h="64" originx="14" originy="49"
--point label="Head" x="13" y="17"


function player_init(player)
    player:set_name("Metabee")
    player:set_health(1000)
    player:set_element(Element.None)
    player:set_height(60.0)
    player:set_animation(_modpath.."metabee.animation")
    player:set_texture(Engine.load_texture(_modpath.."battle.png"), true)
    player:set_fully_charged_color(Color.new(72,192,240,255))
    player:set_charge_position(-3, -20)
    player:set_shadow(Engine.load_texture(_modpath.."shadow.png"))
    player:show_shadow(true)
    
    
    --local counter = 0

    player.missile_count = 3

    player.missile = Battle.Artifact.new()


    local METABEE_FIRST_FRAME = true
    player.update_func = function(self, dt) 

   --     if counter == 0 then 
     --       player:show_shadow(true)
       
       -- end
       -- counter = counter+1
       -- if counter == 7 then 
        --    player:show_shadow(false)
         --   counter = 0
        --end

      if METABEE_FIRST_FRAME then 
        player.missile:sprite():set_layer(-5)
        player.missile:set_texture(metabee_effects_texture, true)
        local offsetX = -15
        if player:get_facing() == Direction.Left then 
            offsetX = offsetX * -1
        end
        player.missile:set_offset(offsetX, -80)
        player.missile:get_animation():load(metabee_effects_animation)
        player.missile:get_animation():set_state("MISSILE_COUNTER_3")
        player.missile:get_animation():refresh(player.missile:sprite())
        if player:get_facing() == Direction.Left then 
            player:get_field():spawn(player.missile, player:get_field():tile_at(6, 0))
        else player:get_field():spawn(player.missile, player:get_field():tile_at(1, 0))
        end
        METABEE_FIRST_FRAME = false
      end

      player.missile:get_animation():set_state("MISSILE_COUNTER_"..player.missile_count)
    end

    player.normal_attack_func = create_normal_attack
    player.charged_attack_func = create_charged_attack
    player.special_attack_func = create_special_attack
end

function create_normal_attack(player)
    print("buster attack")
    return Battle.Buster.new(player, false, player:get_attack_level())
end

function create_charged_attack(player)
    print("Charge attack")
    local action = Battle.CardAction.new(player, "PLAYER_CHARGE")
    action:set_lockout(make_animation_lockout())
    action.execute_func = function(self, user)
        local tile = player:get_tile(player:get_facing(), 1)
        local artifact = Battle.Artifact.new()
        artifact:sprite():set_layer(-2)
        artifact:set_texture(metabee_effects_texture, true)
        local offsetX = -17
        if player:get_facing() == Direction.Left then 
            offsetX = offsetX * -1
        end
        artifact:set_offset(offsetX, -54)
        artifact:get_animation():load(metabee_effects_animation)
        artifact:get_animation():set_state("SHOT_BURST")
        artifact:get_animation():refresh(artifact:sprite())
        Engine.play_audio(METABEE_SHOT, AudioPriority.High)
        
        artifact:get_animation():on_complete(function()
            artifact:erase()
        end)
        player:get_field():spawn(artifact, tile)

        artifact:get_animation():on_frame(2, function()
            local shot = create_shot(player)
            player:get_field():spawn(shot, tile)
            

        end)

        
	end



    return action
end


function create_shot(user)
    local spell = Battle.Spell.new(user:get_team())
	spell:set_facing(user:get_facing())
    local offsetX = -17
    if user:get_facing() == Direction.Left then 
        offsetX = offsetX * -1
    end
    spell:set_offset(offsetX, -51)
    spell:set_texture(metabee_effects_texture, true)
    spell:highlight_tile(Highlight.Solid)
    spell:set_animation(metabee_effects_animation)
    spell:get_animation():set_state("PLAYER_CHARGE")

	spell.slide_started = false

    local direction = spell:get_facing()
    spell:set_hit_props(
        HitProps.new(
            20 + user:get_attack_level() * 20, 
            Hit.Impact | Hit.Flinch | Hit.Flash, 
            Element.None, 
            user:get_context(),
            Drag.None
        )
    )
    
    spell.update_func = function(self, dt) 
        self:get_current_tile():attack_entities(self)
		if self:is_sliding() == false then
            if self:get_current_tile():is_edge() and self.slide_started then 
                self:delete()
            end 
			
            local dest = self:get_tile(direction, 1)
         --   local ref = self
            self:slide(dest, frames(5), frames(0), ActionOrder.Voluntary, 
                function()
                    self.slide_started = true 
                end
            )
        end
    end

    spell.attack_func = function(self, other) 
        Engine.play_audio(METABEE_SHOT_HIT, AudioPriority.High)
        self:erase()
    end
    
	spell.can_move_to_func = function(tile)
        return true
    end


    return spell
end

function create_special_attack(player)
    if player.missile_count < 1 then 
        print("No missiles!")
        return nil
    end
    print("execute special")
    local action = Battle.CardAction.new(player, "PLAYER_MISSILE")
    action:set_lockout(make_animation_lockout())
    action.execute_func = function(self, user)
        local tile = player:get_tile(player:get_facing(), 1)
        local artifact = Battle.Artifact.new()
        artifact:sprite():set_layer(-2)
        artifact:set_texture(metabee_effects_texture, true)
        local offsetX = 48
        if player:get_facing() == Direction.Left then 
            offsetX = offsetX * -1
        end
        artifact:set_offset(offsetX, -76)
        artifact:get_animation():load(metabee_effects_animation)
        artifact:get_animation():set_state("MISSILE_START")
        artifact:get_animation():refresh(artifact:sprite())
      --  Engine.play_audio(METABEE_SHOT, AudioPriority.High)
    

        artifact:get_animation():on_complete(function()
            artifact:erase()
        end)

        player:get_animation():on_frame(4, function() 
            player:get_field():spawn(artifact, player:get_current_tile())
            Engine.play_audio(METABEE_MISSILE, AudioPriority.High)
            player.missile_count = player.missile_count-1

        end)
        
        player:get_animation():on_frame(5, function()
            local missile = create_missile(player)
            player:get_field():spawn(missile, tile)
        end)

    end

    return action
end

function create_missile(user)
    local spell = Battle.Spell.new(user:get_team())
	spell:set_facing(user:get_facing())
    local offsetX = -24
    if user:get_facing() == Direction.Left then 
        offsetX = offsetX * -1
    end
    spell:set_offset(offsetX, -76)
    spell:set_texture(metabee_effects_texture, true)
    spell:highlight_tile(Highlight.Solid)
    spell:set_animation(metabee_effects_animation)
    spell:get_animation():set_state("MISSILE")

    spell:get_animation():on_complete(function()
        spell:get_animation():set_state("MISSILE")

    end)

    spell.slide_started = false

    local direction = spell:get_facing()
    spell:set_hit_props(
        HitProps.new(
            30 + user:get_attack_level() * 50, 
            Hit.Impact | Hit.Flinch | Hit.Flash, 
            Element.None, 
            user:get_context(),
            Drag.None
        )
    )

    spell.update_func = function(self, dt) 
        self:get_current_tile():attack_entities(self)
		if self:is_sliding() == false then
            if self:get_current_tile():is_edge() and self.slide_started then 
                self:delete()
            end 
			
            local dest = self:get_tile(direction, 1)
         --   local ref = self
            self:slide(dest, frames(10), frames(0), ActionOrder.Voluntary, 
                function()
                    self.slide_started = true 
                end
            )
        end
    end

    spell.attack_func = function(self) 
        Engine.play_audio(METABEE_MISSILE_HIT, AudioPriority.High)

        local artifact = Battle.Artifact.new()
        artifact:sprite():set_layer(-2)
        artifact:set_texture(metabee_effects_texture, true)
        artifact:set_offset(0, -76)
        artifact:get_animation():load(metabee_effects_animation)
        artifact:get_animation():set_state("MISSILE_HIT")
        artifact:get_animation():refresh(artifact:sprite())

        artifact:get_animation():on_complete(function()
            artifact:erase()
        end)
        
        user:get_field():spawn(artifact, self:get_current_tile())

        self:erase()
    end
    
	spell.can_move_to_func = function(tile)
        return true
    end


    return spell
end

