-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

    state.Buff['Afflatus Solace'] = buffactive['Afflatus Solace'] or false
    state.Buff['Afflatus Misery'] = buffactive['Afflatus Misery'] or false
	
	state.RecoverMode = M('35%', '60%', 'Always', 'Never')
	state.AutoCaress = M(true, 'Auto Caress Mode')
	autows = 'Mystic Boon'
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

	if spell.action_type == 'Magic' then
		if spellMap == 'Cure' or spellMap == 'Curaga' then
			gear.default.obi_waist = gear.obi_cure_waist
			gear.default.obi_back = gear.obi_cure_back
		elseif spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
			gear.default.obi_waist = gear.obi_nuke_waist
			gear.default.obi_back = gear.obi_nuke_back
		elseif spellMap == 'StatusRemoval' and not (spell.english == "Erase" or spell.english == "Esuna" or spell.english == "Sacrifice") then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			if abil_recasts[32] == 0 and not buffactive['amnesia'] and state.AutoCaress.value then
				cast_delay(1.1)
				send_command('@input /ja "Divine Caress" <me>')
				return
			end
		end
	end
		
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
end

function job_post_precast(spell, action, spellMap, eventArgs)

end

function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Apply Divine Caress boosting items as highest priority over other gear, if applicable.
    if spellMap == 'StatusRemoval' and buffactive['Divine Caress'] then
        equip(sets.buff['Divine Caress'])
    elseif spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' and spell.english ~= 'Impact' then
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
		
		if spell.element == 'Wind' and sets.WindNuke then
			equip(sets.WindNuke)
		elseif spell.element == 'Ice' and sets.IceNuke then
			equip(sets.IceNuke)
		end
		
		if state.RecoverMode.value == 'Always' then equip(sets.RecoverMP)
		elseif state.RecoverMode.value == 'Never' then
		elseif state.RecoverMode.value == '60%' then
			if player.mpp <60 then equip(sets.RecoverMP) end
		elseif state.RecoverMode.value == '35%' then
			if player.mpp <35 then equip(sets.RecoverMP) end
		end
    end
	
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

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.action_type == 'Magic' then
		if default_spell_map == 'Curaga' then
			if world.weather_element == 'Light' then
				return 'LightWeatherCuraga'
			elseif world.day_element == 'Light' then
				return 'LightDayCuraga'	
			end
		elseif default_spell_map == 'Cure' then
			if player.status == 'Engaged' then
				return "CureMelee"
			elseif state.Buff['Afflatus Solace'] then
				if world.weather_element == 'Light' then
					return 'LightWeatherCureSolace'
				elseif world.day_element == 'Light' then
					return 'LightDayCureSolace'
				else
					return "CureSolace"
				end
			elseif world.weather_element == 'Light' then
                return 'LightWeatherCure'
			elseif world.day_element == 'Light' then
                return 'LightDayCure'
			end
		elseif spell.skill == "Enfeebling Magic" then
            if spell.type == "WhiteMagic" then
                return "MndEnfeebles"
            else
                return "IntEnfeebles"
            end
        end
    end
end


function job_customize_idle_set(idleSet)

    if player.mpp < 51 and (state.IdleMode.value == 'Normal' or state.IdleMode.value == 'Sphere') and state.DefenseMode.value == 'None' then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
	
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)

	if cmdParams[1] == 'user' then checkarts() end

end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

    -- Allow jobs to override this code
function job_self_command(commandArgs, eventArgs)

end

function job_tick()
	if checkarts() then return true end
	return false
end

function checkarts()
	if state.AutoArts.value and not moving and not areas.Cities:contains(world.area) then

		local abil_recasts = windower.ffxi.get_ability_recasts()

		if abil_recasts[29] == 0 and not buffactive['Afflatus Solace'] and not buffactive['Afflatus Misery'] then
			send_command('@input /ja "Afflatus Solace" <me>')
			tickdelay = 1320
			return true

		else
			local needsArts = 
				player.sub_job:lower() == 'sch' and
				not buffactive['Light Arts'] and
				not buffactive['Addendum: White'] and
				not buffactive['Dark Arts'] and
				not buffactive['Addendum: Black']
				

			if needsArts and abil_recasts[228] == 0 then
				send_command('@input /ja "Light Arts" <me>')
				tickdelay = 1320
				return true
			end
		end
		
	end

	return false
end