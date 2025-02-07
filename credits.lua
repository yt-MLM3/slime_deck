SMODS.current_mod.extra_tabs = function()
	return {
		{
			label = 'Credits',
			tab_definition_function = function()
				-- works in the same way as mod.config_tab
				return {n = G.UIT.ROOT, config = {
					-- config values here, see 'Building a UI' page
				}, nodes = {
					-- work your UI wizardry here, see 'Building a UI' page
				}}
			end,
		},
		-- insert more tables with the same structure here
	}
end