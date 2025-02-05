-- SMODS.load_file("cry_credits_badges.lua")()
SMODS.load_file('atlas.lua')()

SMODS.create_mod_badges(obj, badges)

-- Lily Joker
SMODS.Joker {
  discovered = true,
  unlocked = false,

    key = 'LilyJoker',
    rarity = 1,
    atlas = 'JokersTextures',
    pos = { x = 0, y = 0 },
    cost = 4,

    loc_txt = {
        name = 'Lily',
        
        text = {
            "{C:chips}+#2#{} Chips",
            "{C:mult}+#1#{} Mult",
            "{C:inactive}mario"
        }
    },

    config = { extra = { mult = 10, chips = 20 } },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
      end,

      
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chips = card.ability.extra.chips,
        mult = card.ability.extra.mult,
      }
    end
  end,
}


-- Spooker Joker
SMODS.Joker {
  key = "SpookerJoker",
  atlas = 'JokersTextures',
  pos = { x = 1, y = 0 },
  rarity = 2,
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  loc_txt = {
    name = "Spooker",
    text = {
      "Gains {C:mult}+#2#{} Mult",
			"everytime a",
			"{C:attention}Spectral Card{} is played",
			"{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)"
    }
  },

  config = { extra = { mult = 0, mult_add = 15 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.mult, card.ability.extra.mult_add}}
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult = card.ability.extra.mult
      }
    end

    if context.using_consumeable and (context.consumeable.ability.set == "Spectral") then
      card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_add
      return {
        message = 'Upgraded!',
				colour = G.C.MULT,
				card = card
      }
    end

  end

}


-- Coge Joker
SMODS.Joker {
  key = "CogeJoker",
  atlas = 'JokersTextures',
  pos = { x = 1, y = 1 },
  rarity = 2,
  cost = 4,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,

  loc_txt = {
    name = "Coge",
    text = {
      "Gains {C:chips}+#2#{} Chips",
			"everytime a",
			"{C:attention}Spectral Card{} is played",
			"{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)"
    }
  },

  config = { extra = { chips = 0, chips_add = 45 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.chips_add}}
  end,
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult = card.ability.extra.chips
      }
    end

    if context.using_consumeable and (context.consumeable.ability.set == "Spectral") then
      card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_add
      return {
        message = 'Upgraded!',
				colour = G.C.CHIPS,
				card = card
      }
    end

  end

}


-- george Joker
SMODS.Joker {
  key = 'GeorgeJoker',
  rarity = 1,
  atlas = 'GeorgeTexture',
  pos = { x = 0, y = 0 },
  cost = 1,

  loc_txt = {
      name = 'george',
      
      text = {
          "{C:mult}+#1#{} Mult"
      }
  },

  config = { extra = { mult = 5 } },

  loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.mult} }
    end,

    
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult = card.ability.extra.mult,
      }
    end
  end
}

-- Mint Joker
SMODS.Joker {
  discovered = true,
  unlocked = false,


  key = 'MintJoker',
  rarity = 2,
  atlas = 'JokersTextures',
  pos = { x = 2, y = 0 },
  cost = 4,

  loc_txt = {
    name = 'Mint',
        
    text = {
      "{C:chips}+#1#{} Chips for each other {C:attention}Joker{}",
      "{C:chips}-#2#{} Chips for each hand played",
      "{C:chips}+#3#{} Chips for each {C:attention}Joker{} added",
      -- "{s:0.8}(They can get debuffed)",
      -- "chips: #1# / chips removed: #2#",
    }
  },

  config = { extra = { chips = 100, chip_removal = 5, chip_add = 20 }},
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.chips, card.ability.extra.chip_removal, card.ability.extra.chip_add } }
  end,
  calculate = function(self, card, context)
    if context.other_joker and card ~= context.other_joker then
      return {
        chips = card.ability.extra.chips
      }
    end

    if context.after and card.ability.extra.chips - card.ability.extra.chip_removal >= 0 then
      card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chip_removal
      return {
        message = localize{type='variable',key='a_chips_minus',vars={card.ability.extra.chip_removal}},
        colour = G.C.CHIPS
      }
    end

    -- if context. then
    --   card.ability.extra.chips = card.ability.extra.chips - card.ability.extra.chip_removal
    --   return {
    --     message = localize{type='variable',key='a_chips_minus',vars={card.ability.extra.chip_removal}},
    --     colour = G.C.CHIPS
    --   }
    -- end

  end
}

-- Ivory Joker
SMODS.Joker {
  key = 'IvoryJoker',
  rarity = 2,
  atlas = 'JokersTextures',
  pos = { x = 2, y = 1 },
  cost = 4,

  loc_txt = {
    name = 'Ivory',
        
    text = {
      "{C:green}#1# in #2#{} chance to spawn",
      "a {C:dark_edition}negative{} {C:attention}Ice Cream{} Joker",
      "when blind is selected",
    }
  },

  config = {extra ={ odds = 8}},
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = G.P_CENTERS.e_negative
    info_queue[#info_queue+1] = G.P_CENTERS.j_ice_cream
    return { vars = { (G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
  end,
  calculate = function(self, card, context)
    if context.setting_blind and pseudorandom('Ivory') < G.GAME.probabilities.normal / card.ability.extra.odds then
      G.E_MANAGER:add_event(Event({
        func = function()
          local icecream = create_card('Joker', G.jokers, nil, nil, nil, nil, "j_ice_cream")
          icecream:set_edition('e_negative', true)
          icecream:add_to_deck()
          G.jokers:emplace(icecream)
          return true
        end
      }))
    end
  end
}