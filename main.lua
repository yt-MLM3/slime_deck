-- SMODS.load_file("cry_credits_badges.lua")()
SMODS.load_file('atlas.lua')()
SMODS.load_file('credits.lua')()
-- local config = SMODS.current_mod.config

-- SMODS.create_mod_badges(obj, badges)



-- Lily Joker -- not working
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
        chips = card.ability.extra.chips
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


-- Mint Joker -- not working
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
      "{C:green}#1# in #2#{} chance to create",
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

-- Dee Foot Joker
SMODS.Joker {
  key = 'DeeFootJoker',
  atlas = 'JokersTextures',
  pos = { x = 3, y = 0},
  soul_pos = { x = 3, y = 1},
  rarity = 4,
  cost = 3+17,

  loc_txt = {
    name = 'Dee Foot',
    text = {
      "If played hand contains",
      "a {C:attention}3{}, an {C:attention}Ace{} and a {C:attention}7{},",
      "add {X:mult,C:white}x#1#{} Mult",
      "for each one scored",
    }
  },
  config = { extra = {x_mult = 3.17} },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.x_mult}}
  end,

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local numbers = {
        ['Three'] = 0,
        ['Ace'] = 0,
        ['Seven'] = 0,
      }
  
      for i = 1, #context.full_hand do
        if context.full_hand[i]:get_id() == 3 and numbers['Three'] == 0  then numbers['Three'] = numbers['Three'] + 1
        elseif context.full_hand[i]:get_id() == 14 and numbers['Ace'] == 0  then numbers['Ace'] = numbers['Ace'] + 1
        elseif context.full_hand[i]:get_id() == 7 and numbers['Seven'] == 0  then numbers['Seven'] = numbers['Seven'] + 1 
        end
      end
      if numbers['Three'] > 0 and numbers['Ace'] > 0 and numbers['Seven'] > 0 then
        return {
          -- message = localize{type='variable',key='a_xmult',vars={card.ability.extra}},
          Xmult = card.ability.extra.x_mult,
          card = card
        }
      end
    end
  end
}

-- Blobee Joker
SMODS.Joker {
  key = "BlobeeJoker",
  rarity = 1,
  atlas = 'JokersTextures',
  pos = { x = 0, y = 1},
  cost = 3,

  loc_txt = {
    name = "Blobee",
    text = {
      "{C:blue}+#2#{} hand,",
      "{C:attention}#1#{} hand size",
      "each round",
    }
  },
  config = { extra = {hand_size = -1, hands_number = 1}},
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.hand_size, card.ability.extra.hands_number} }
  end,

  add_to_deck = function(self, card, from_debuff)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands_number
		G.hand:change_size(card.ability.extra.hand_size)
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands_number
		G.hand:change_size(-card.ability.extra.hand_size)
	end
}

-- george Joker
SMODS.Joker {
  key = 'GeorgeJoker',
  rarity = 1,
  atlas = 'JokersTextures',
  pos = { x = 0, y = 2 },
  cost = 1,
  pixel_size = { w = 51, h = 95 },
  -- display_size = { w = 51, h = 95 },
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

-- Controversial Tilapia Joker
SMODS.Joker {
  key = "CTilapiaJoker",
  rarity = 1,
  atlas = 'JokersTextures',
  pos = { x = 1, y = 2},
  cost = 3,

  loc_txt = {
    name = "controversial tilapia in a frying pan",
    text = {
      "gives {X:mult,C:white}x#1#{} Mult but {C:chips}#2#{} chips",
      " because it's so controversial",
      "{C:inactive}(believes the moon landing was fake)",
    }
  },

  config = { extra = { x_mult = 2, chips = -30 } },

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.x_mult, card.ability.extra.chips } }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      SMODS.calculate_effect({x_mult = card.ability.extra.x_mult}, card)
      if hand_chips + card.ability.extra.chips >= 0 then
        return {
          chips = card.ability.extra.chips,
        }
      else
        hand_chips = 0,
        update_hand_text({delay = 0}, {chips = 0})
        return {
          message = tostring(card.ability.extra.chips),
          colour = G.C.CHIPS,
          card = card,
        }
      end
    end
  end,
}

-- MR Van Voucher
SMODS.Voucher {
  key = "MRVanVoucher",
  loc_txt = {
    name = "The van",
    text = {
      "{C:spectral}Spectral{} booster packs",
      "appear {C:attention}#1#X{} more",
      "frequently in the shop",
    }
  },
  atlas = "VouchersTextures",
  pos = { x = 0, y = 0 },
  cost = 10,
  config = { extra = { chancemult = 2 } },
  loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.chancemult } }
	end,

  redeem = function(self, card)
    G.P_CENTERS.p_spectral_normal_1.weight = G.P_CENTERS.p_spectral_normal_1.weight * card.ability.extra.chancemult
    G.P_CENTERS.p_spectral_normal_2.weight = G.P_CENTERS.p_spectral_normal_2.weight * card.ability.extra.chancemult
    G.P_CENTERS.p_spectral_jumbo_1.weight = G.P_CENTERS.p_spectral_jumbo_1.weight * card.ability.extra.chancemult
    G.P_CENTERS.p_spectral_mega_1.weight = G.P_CENTERS.p_spectral_mega_1.weight * card.ability.extra.chancemult
  end
}