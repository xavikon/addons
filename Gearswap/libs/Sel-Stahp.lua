--Requires Gearswap and Motenten includes.

include('Sel-MonsterAbilities.lua')

state.AutoDefenseMode = M(false, 'Auto Defense Mode')
state.AutoStunMode = M(false, 'Auto Stun Mode')

CureAbility = S{"Cure","Cure II","Cure III","Cure IV","Cure V","Cure VI","Magic Fruit","Plenilune Embrace","Curaga","Curaga II",
				"Curaga III","Curaga IV","Curaga V",
				 }
				 
CuragaAbility = S{"Curaga","Curaga II","Curaga III","Curaga IV","Curaga V","Cura","Cura III","Cura III","White Wind",
				 }
				 
ProshellAbility = S{"Protect","Protect II","Protect III","Protect IV","Protect V",
					"Shell","Shell II","Shell III","Shell IV","Shell V",
				 }
				 
ProshellraAbility = S{"Protectra","Protectra II","Protectra III","Protectra IV","Protectra V",
					"Shellra","Shellra II","Shellra III","Shellra IV","Shellra V",
				 }
				 
RefreshAbility = S{"Refresh","Refresh II", "Refresh III"
				 }

windower.raw_register_event('action', function(act)

	--Gather Info
    local curact = T(act)
    local actor = T{}
	local otherTarget = T{}

    actor.id = curact.actor_id
	
	-- Make sure it's something we actually care about reacting to.
	if not ((curact.category == 3 or curact.category == 4 or curact.category == 7 or curact.category == 8 or curact.category == 11 or curact.category == 13)) then return end
	
	-- Make sure it's a mob that's doing something.
    if windower.ffxi.get_mob_by_id(actor.id) then
        actor = windower.ffxi.get_mob_by_id(actor.id)
    else
        return
    end

	-- Make sure it's not US!
	if actor.id == player.id then
		return
	end

	-- Check if we're targetting it.
    if actor.id == player.target.id then
        isTarget = true
    else
		isTarget = false
    end

	if curact.targets[1].id == nil then
		targetsMe = false
		otherTarget.in_party = false
		otherTarget.in_alliance = false
		targetsDistance = 50
	elseif curact.targets[1].id == player.id then
		otherTarget.in_party = false
		otherTarget.in_alliance = false
		targetsMe = true
		targetsDistance = 0
	else
		otherTarget = windower.ffxi.get_mob_by_id(curact.targets[1].id)
		targetsMe = false
		targetsDistance = math.sqrt(otherTarget.distance)
	end	
	
	-- Turn off Defense if needed for things we're targetting.
	if (curact.category == 3 or curact.category == 4 or curact.category == 11 or curact.category == 13) then
		if isTarget and state.AutoDefenseMode.value and state.DefenseMode.value ~= 'None' then
			send_command('gs c reset DefenseMode')
			return
		elseif not midaction() and (targetsMe or (otherTarget.in_alliance and targetsDistance < 10)) then
			send_command('gs c update')
			return
		end
	end
	
    -- Make sure it's a WS or MA before reacting to it.		
    if curact.category ~= 7 and curact.category ~= 8 then return end
	
    -- Get the name of the action.
    if curact.category == 7 then act_info = res.monster_abilities[curact.targets[1].actions[1].param] end
    if curact.category == 8 then act_info = res.spells[curact.targets[1].actions[1].param] end
	if act_info == nil then return end
	
	if midaction() or curact.category ~= 7 or state.DefenseMode.value ~= 'None' then
	
	elseif targetsMe then
		if CureAbility:contains(act_info.name) then
			if sets.Cure_Recieved then
				equip(sets.Cure_Recieved)
			elseif sets.Self_Healing then
				equip(sets.Self_Healing) 
			end
			return
		elseif RefreshAbility:contains(act_info.name) then
			if sets.Self_Refresh then equip(sets.Self_Refresh) return end
		elseif ProshellAbility:contains(act_info.name) then
			if sets.Sheltered then equip(sets.Sheltered) return end
		end
	elseif actor.in_party and otherTarget.in_party and targetsDistance < 10 then
		if CuragaAbility:contains(act_info.name) then
			if sets.Cure_Recieved then
				equip(sets.Cure_Recieved)
			elseif sets.Self_Healing then
				equip(sets.Self_Healing) 
			end
			return
		elseif ProshellraAbility:contains(act_info.name) and sets.Sheltered then
			equip(sets.Sheltered) return
		end
	end
	
	-- Make sure this is our target. 	send_command('input /echo Actor:'..actor.id..' Target:'..player.target.id..'')
	if isTarget then

		if state.AutoStunMode.value then
			if curact.param == 24931 then
				if StunAbility:contains(act_info.name) and not midaction() then
					
					if not buffactive.silence then

						local spell_recasts = windower.ffxi.get_spell_recasts()
					
						if player.main_job == 'BLM' or player.sub_job == 'BLM' or player.main_job == 'DRK' or player.sub_job == 'DRK' and spell_recasts[252] == 0 then
							send_command('input /ma "Stun" <t>') return
						elseif player.main_job == 'BLU' and spell_recasts[692] == 0 then
							send_command('input /ma "Sudden Lunge" <t>') return
						elseif player.sub_job == 'BLU' and spell_recasts[623] == 0 then
							send_command('input /ma "Head Butt" <t>') return
						end
					end


					local abil_recasts = windower.ffxi.get_ability_recasts()
					
					if buffactive.amnesia then return
					elseif (player.main_job == 'PLD' or player.sub_job == 'PLD') and abil_recasts[73] == 0 then
						send_command('input /ja "Shield Bash" <t>')
					elseif (player.main_job == 'DRK' or player.sub_job == 'DRK') and abil_recasts[88] == 0 then
						send_command('input /ja "Weapon Bash" <t>')
					elseif player.main_job == 'SMN' and pet.name == "Ramuh" then
						send_command('input /pet "Volt Stike" <t>')
					elseif not player.in_combat then
						add_to_chat(123,'No stuns ready! Good luck!')
						return
					elseif (player.main_job == 'DNC' or player.sub_job == 'DNC') and abil_recasts[221] == 0 then
						send_command('input /ja "Violent Flourish" <t>')
					elseif player.main_job == 'SAM' then
						send_command('input /ws "Tachi: Hobaku" <t>')
					elseif player.main_job == 'MNK' or player.main_job == 'PUP' then
						send_command('input /ws "Shoulder Tackle" <t>')
					elseif (player.main_job == 'PLD' or player.main_job == 'BLU') and player.tp > 999 then
						send_command('input /ws "Flat Blade" <t>')
					elseif player.main_job == 'BST' then
						send_command('input /ws "Smash Axe" <t>')
					else
						add_to_chat(123,'No stuns ready! Good luck!')
					end
					return
				end
			end
		end

		if state.AutoDefenseMode.value then
			if curact.param == 24931 then
				if PhysicalAbility:contains(act_info.name) and state.DefenseMode.value ~= 'Physical' then
					send_command('gs c set DefenseMode Physical')
				elseif MagicalAbility:contains(act_info.name) and state.DefenseMode.value ~= 'Magical'  then
					send_command('gs c set DefenseMode Magical')
				elseif ResistAbility:contains(act_info.name) and state.DefenseMode.value ~= 'Resist'  then
					send_command('gs c set DefenseMode Resist')
				end
			end
		end
		
	elseif (targetsMe or (otherTarget.in_alliance and targetsDistance < 10)) and state.AutoDefenseMode.value then
		if state.AutoDefenseMode.value then
			if curact.param == 24931 then
				if PhysicalAbility:contains(act_info.name) and state.DefenseMode.value ~= 'Physical' then
					send_command('gs c set DefenseMode Physical')
				elseif MagicalAbility:contains(act_info.name) and state.DefenseMode.value ~= 'Magical'  then
					send_command('gs c set DefenseMode Magical')
				elseif ResistAbility:contains(act_info.name) and state.DefenseMode.value ~= 'Resist'  then
					send_command('gs c set DefenseMode Resist')
				end
			end
		end
	end

end)