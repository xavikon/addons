-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

    -- Setup vars that are user-independent.
function job_setup()

    state.Buff.Souleater = buffactive.Souleater or false
    state.Buff['Dark Seal'] = buffactive['Dark Seal'] or false
	
    state.Buff['Aftermath'] = buffactive['Aftermath: Lv.1'] or
    buffactive['Aftermath: Lv.2'] or
    buffactive['Aftermath: Lv.3'] or false
	
	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Savage Blade','Requiescat','Resolution'}
	
	autows = 'Resolution'
	
	update_combat_form()
	update_melee_groups()
end
	
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
	
function job_filtered_action(spell)

end

function job_pretarget(spell, action, spellMap, eventArgs)

end

function job_precast(spell, action, spellMap, eventArgs)

end

function job_post_precast(spell, action, spellMap, eventArgs)

end

function job_aftercast(spell, action, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.skill == 'Elemental Magic' and state.MagicBurstMode.value == 'Single' then
            state.MagicBurstMode:reset()
        end
    end
end

-- Modify the default idle set after it was constructed.
function job_customize_idle_set(idleSet)
    if player.mpp < 51 and (state.IdleMode.value == 'Normal' or state.IdleMode.value == 'Sphere') and state.DefenseMode.value == 'None' then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)

    if state.ExtraMeleeMode.value ~= 'None' then
        meleeSet = set_combine(meleeSet, sets[state.ExtraMeleeMode.value])
    end

    if state.Buff.Souleater and state.DefenseMode.current ~= 'None' then
        meleeSet = set_combine(meleeSet, sets.buff.Souleater)
    end

    return meleeSet
end

function job_customize_defense_set(defenseSet)
    return defenseSet
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' and state.Buff.Souleater then   
            equip(sets.buff.Souleater)
    end
	
	if spell.type == 'WeaponSkill' then
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 and moonshade_ws:contains(spell.english) then
			if state.WeaponskillMode.Current:contains('Acc') then
				if sets.precast.AccMaxTP then
					equip(sets.precast.AccMaxTP)
				end
						
			elseif sets.precast.MaxTP then
					equip(sets.precast.MaxTP)
			end
		end
    end
	
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' and spell.english ~= 'Impact' then
        if state.MagicBurstMode.value ~= 'Off' then equip(sets.MagicBurst) end
		if spell.element == world.weather_element or spell.element == world.day_element then
			if state.CastingMode.value == 'Normal' or state.CastingMode.value == 'Fodder' then
				if player.inventory['Twilight Cape'] or player.wardrobe['Twilight Cape'] or player.wardrobe2['Twilight Cape'] or player.wardrobe3['Twilight Cape'] or player.wardrobe4['Twilight Cape'] then
					sets.TwilightCape = {back="Twilight Cape"}
					equip(sets.TwilightCape)
				end
				if spell.element == world.day_element then
					if player.inventory['Zodiac Ring'] or player.wardrobe['Zodiac Ring'] or player.wardrobe2['Zodiac Ring'] or player.wardrobe3['Zodiac Ring'] or player.wardrobe4['Zodiac Ring'] then
						sets.ZodiacRing = {ring2="Zodiac Ring"}
						equip(sets.ZodiacRing)
					end
				end
			end
		end
    end
end

function job_self_command(commandArgs, eventArgs)

end

function job_tick()

	return false
end

function job_update(cmdParams, eventArgs)
    update_combat_form()
    update_melee_groups()
end

function update_combat_form()
    if player.equipment.main == "Ragnarok" then
        state.CombatForm:set('Ragnarok')
    elseif player.equipment.main == "Apocalypse" then
        state.CombatForm:set('Apocalypse')
    elseif player.equipment.main == "Liberator" then
        state.CombatForm:set('Liberator')
    else
        state.CombatForm:reset()
    end
end

function job_buff_change(buff, gain)
	if buff:startswith('Aftermath') then
		state.Buff.Aftermath = gain
		update_melee_groups()
	end
end
	
function update_melee_groups()
    classes.CustomMeleeGroups:clear()
	
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
		classes.CustomMeleeGroups:append('Adoulin')
    end
	
	if state.Buff.Charge then
		classes.CustomMeleeGroups:append('Charge')
	end
	
	if state.CombatForm.Value == "Liberator" then
		if buffactive['Aftermath: Lv.3'] then
			classes.CustomMeleeGroups:append('AM')
		end
	elseif state.Buff.Aftermath then
		classes.CustomMeleeGroups:append('AM')
	end
	
end