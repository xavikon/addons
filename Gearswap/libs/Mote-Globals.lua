-------------------------------------------------------------------------------------------------------------------
-- Tables and functions for commonly-referenced gear that job files may need, but
-- doesn't belong in the global Mote-Include file since they'd get clobbered on each
-- update.
-- Creates the 'gear' table for reference in other files.
--
-- Note: Function and table definitions should be added to user, but references to
-- the contained tables via functions (such as for the obi function, below) use only
-- the 'gear' table.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Modify the sets table.  Any gear sets that are added to the sets table need to
-- be defined within this function, because sets isn't available until after the
-- include is complete.  It is called at the end of basic initialization in Mote-Include.
-------------------------------------------------------------------------------------------------------------------

function define_global_sets()
	-- Special gear info that may be useful across jobs.

	-- Staffs
	gear.Staff = {}
	gear.Staff.HMP = 'Chatoyant Staff'
	gear.Staff.PDT = 'Terra Staff'
	
	-- Default items for utility gear values.
	sets.TrizekRing = {ring2="Trizek Ring"}
	sets.EchadRing = {ring2="Echad Ring"}
	sets.FacilityRing = {ring2="Facility Ring"}
	sets.CapacityRing = {ring2="Capacity Ring"}
	sets.VocationRing = {ring2="Vocation Ring"}
	sets.HollaRing = {ring2="Dim. Ring (Holla)"}
	sets.DemRing = {ring2="Dim. Ring (Dem)"}
	sets.MeaRing = {ring2="Dim. Ring (Mea)"}
	sets.Nexus = {back="Nexus Cape"}
	sets.Warp = {ring2="Warp Ring"}
	sets.RREar = {ear2="Reraise Earring"}
	
	if player.inventory["Adoulin's Refuge +1"] or player.safe["Adoulin's Refuge +1"] or player.safe2["Adoulin's Refuge +1"] or player.storage["Adoulin's Refuge +1"] or player.locker["Adoulin's Refuge +1"] or player.satchel["Adoulin's Refuge +1"] or player.sack["Adoulin's Refuge +1"] or player.case["Adoulin's Refuge +1"] or player.wardrobe["Adoulin's Refuge +1"] or player.wardrobe2["Adoulin's Refuge +1"] or player.wardrobe3["Adoulin's Refuge +1"] or player.wardrobe4["Adoulin's Refuge +1"] then
		sets.Reive = {neck="Adoulin's Refuge +1"}
	elseif player.inventory["Arciela's Grace +1"] or player.safe["Arciela's Grace +1"] or player.safe2["Arciela's Grace +1"] or player.storage["Arciela's Grace +1"] or player.locker["Arciela's Grace +1"] or player.satchel["Arciela's Grace +1"] or player.sack["Arciela's Grace +1"] or player.case["Arciela's Grace +1"] or player.wardrobe["Arciela's Grace +1"] or player.wardrobe2["Arciela's Grace +1"] or player.wardrobe3["Arciela's Grace +1"] or player.wardrobe4["Arciela's Grace +1"] then
		sets.Reive = {neck="Arciela's Grace +1"}
	elseif player.inventory["Ygnas's Resolve +1"] or player.safe["Ygnas's Resolve +1"] or player.safe2["Ygnas's Resolve +1"] or player.storage["Ygnas's Resolve +1"] or player.locker["Ygnas's Resolve +1"] or player.satchel["Ygnas's Resolve +1"] or player.sack["Ygnas's Resolve +1"] or player.case["Ygnas's Resolve +1"] or player.wardrobe["Ygnas's Resolve +1"] or player.wardrobe2["Ygnas's Resolve +1"] or player.wardrobe3["Ygnas's Resolve +1"] or player.wardrobe4["Ygnas's Resolve +1"] then
		sets.Reive = {neck="Ygnas's Resolve +1"}
	else
	end
	
end

-------------------------------------------------------------------------------------------------------------------
-- Functions to set user-specified binds, generally on load and unload.
-- Kept separate from the main include so as to not get clobbered when the main is updated.
-------------------------------------------------------------------------------------------------------------------

-- Function to bind GearSwap binds when loading a GS script.
function global_on_load()
	send_command('@wait 3;gs c weapons')

	send_command('bind ^f8 gs c toggle AutoStunMode') --Turns auto-stun mode off and on.
	send_command('bind !f8 gs c toggle AutoDefenseMode') --Turns auto-defense mode off and on.
	send_command('bind ^@!f8 gs c toggle AutoTrustMode') --Summons trusts automatically.
	send_command('bind f9 gs c cycle OffenseMode') --Changes offense settings such as accuracy.
	send_command('bind ^f9 gs c cycle HybridMode') --Changes defense settings for melee such as PDT.
	send_command('bind @f9 gs c cycle RangedMode') --Changes ranged offense settings such as accuracy.
	send_command('bind !f9 gs c cycle WeaponskillMode') --Allows automatic weaponskilling if the job is setup to handle it.
	send_command('bind f10 gs c set DefenseMode Physical') --Turns your physical defense set on.
	send_command('bind ^f10 gs c cycle PhysicalDefenseMode') --Changes your physical defense set.
	send_command('bind !f10 gs c toggle Kiting') --Keeps your kiting gear on..
	send_command('bind f11 gs c set DefenseMode Magical') --Turns your magical defense set on.
	send_command('bind ^f11 gs c cycle MagicalDefenseMode') --Changes your magical defense set.
	send_command('bind @f11 gs c cycle CastingMode') --Changes your castingmode options such as magic accuracy.
	send_command('bind ^f12 gs c cycle ResistDefenseMode') --Changes your resist defense set.
	send_command('bind f12 gs c set DefenseMode Resist') --Turns your resist defense set on.
	send_command('bind @f12 gs c cycle IdleMode') --Changes your idle mode options such as refresh.
	send_command('bind !f12 gs c reset DefenseMode') --Turns your defensive mode off.
	send_command('bind ^@!f12 gs reload') --Reloads gearswap.
	send_command('bind pause gs c update user') --Runs a quick check to make sure you have the right gear on and checks variables.
	send_command('bind ^@!pause gs org') --Runs organizer.
	
--	send_command('bind ^- gs c toggle selectnpctargets')
--	send_command('bind ^= gs c cycle pctargetmode')
end

-- Function to revert binds when unloading.
function global_on_unload()
	send_command('unbind ^f8')
	send_command('unbind !f8')
	send_command('unbind @f8')
	send_command('unbind f9')
	send_command('unbind ^f9')
	send_command('unbind !f9')
	send_command('unbind @f9')
	send_command('unbind f10')
	send_command('unbind ^f10')
	send_command('unbind !f10')
	send_command('unbind @f10')
	send_command('unbind f11')
	send_command('unbind ^f11')
	send_command('unbind !f11')
	send_command('unbind @f11')
	send_command('unbind f12')
	send_command('unbind ^f12')
	send_command('unbind !f12')
	send_command('unbind @f12')
	send_command('unbind ^@!pause')
	send_command('unbind ^pause')
	send_command('unbind !pause')
	send_command('unbind @pause')
	send_command('unbind ^@!pause')

	send_command('unbind ^\\\\')
	send_command('unbind @\\\\')
	send_command('unbind !\\\\')
	
	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind @`')
	
	send_command('unbind ^backspace')
	send_command('unbind !backspace')
	send_command('unbind @backspace')
	
	send_command('unbind ^r')
	send_command('unbind !r')
	send_command('unbind @r')
	
	send_command('unbind ^y')
	send_command('unbind !y')
	send_command('unbind @y')
	
	send_command('unbind ^q')
	send_command('unbind !q')
	send_command('unbind @q')
	
	send_command('unbind ^-')
	send_command('unbind !-')
	send_command('unbind @-')
	
	send_command('unbind ^=')
	send_command('unbind !=')
	send_command('unbind @=')
	
	send_command('unbind ^delete')
	send_command('unbind !delete')
	send_command('unbind @delete')
end

-------------------------------------------------------------------------------------------------------------------
-- Global event-handling functions.
-------------------------------------------------------------------------------------------------------------------

function user_self_command(commandArgs, eventArgs)

end

function user_pretarget	(spell)

end

-- Global intercept on precast.
function user_precast(spell, action, spellMap, eventArgs)
	if check_disable(spell, action, spellMap, eventArgs) then return end
	if check_doom(spell, action, spellMap, eventArgs) then return end
	if check_abilities(spell, action, spellMap, eventArgs) then return end
	if check_recast(spell, action, spellMap, eventArgs) then return end
	if check_cost(spell, action, spellMap, eventArgs) then return end
	if check_silence(spell, action, spellMap, eventArgs) then return end
	if check_amnesia(spell, action, spellMap, eventArgs) then return end
    cancel_conflicting_buffs(spell, action, spellMap, eventArgs)
    refine_waltz(spell, action, spellMap, eventArgs)
end

function user_post_precast(spell, action, spellMap, eventArgs)
	if not eventArgs.handled then
		if spell.english == "Fire" or spell.english == "Blizzard" or spell.english == "Aero" or spell.english == "Stone" or spell.english == "Thunder" or spell.english == "Water" then
			equip(sets.midcast['Elemental Magic'])

		elseif spell.type == 'WeaponSkill' then
			
			if sets.Reive and buffactive['Reive Mark'] and sets.Reive.neck == "Ygnas's Resolve +1" then
				equip(sets.Reive)
			end
			
			if state.Capacity.value == true then 
				equip(sets.Capacity)
			end
		
		elseif spellMap == 'Cure' or spellMap == 'Curaga' then
			if spell.target.distance > 21 and spell.target.type == 'PLAYER' then
				--Delete the next line and uncomment the line after, if you'd rather it send a tell if they're too far to heal.
				add_to_chat(123,'Target out of range, too far to heal!')
				--windower.send_command('input /tell '..spell.target.name..' !!! OUT OF RANGE !!! TOO FAR TO HEAL !!!')
			end
		end
	end
end

-- Global intercept on midcast.
function user_midcast(spell, action, spellMap, eventArgs)
	-- Default base equipment layer of fast recast.
	if spell.action_type == 'Magic' and sets.midcast and sets.midcast.FastRecast then
		equip(sets.midcast.FastRecast)
	end
end

function user_post_midcast(spell, action, spellMap, eventArgs)

	if not eventArgs.handled then
		if spell.target.type == 'SELF' then
			if spellMap == 'Cure' and sets.Self_Healing then
				equip(sets.Self_Healing)
			elseif spellMap == 'Refresh' and sets.Self_Refresh then
				equip(sets.Self_Refresh)
			end
		end
		
		if state.Capacity.value == true then
			if set.contains(spell.targets, 'Enemy') then
		
				if spell.skill == 'Elemental Magic' then
					equip(sets.Capacity)
				
				elseif spell.skill == 'Blue Magic'then
					equip(sets.Capacity)
				
				end
			end
		end
	end		
	
	if sets.Reive and buffactive['Reive Mark'] and (spell.skill == 'Elemental Magic' or spellMap == 'Cure' or spellMap == 'Curaga') then
		if sets.Reive.neck == "Arciela's Grace +1" then
			equip(sets.Reive)
		end
	end
	
	if buffactive.doom then
		equip(sets.buff.Doom)
	end

end

function user_filtered_action(spell)
	if spell.english == 'Warp' then
		windower.send_command('get "Warp Ring" satchel;wait 2;gs c forceequip Warp ring2;wait 10;input /item "Warp Ring" <me>;wait 15;gs c quietenable ring2;put "Warp Ring" satchel')
		add_to_chat(217,"You can't cast warp, attempting to use Warp Ring instead.")
		cancel_spell()
		return
	elseif spell.english == 'Teleport-Holla' then
				windower.send_command('get "Dim. Ring (Holla)" satchel;wait 2;gs c forceequip HollaRing ring2;wait 10;input /item "Dim. Ring (Holla)" <me>;wait 15;gs c quietenable ring2;put "Dim. Ring (Holla)" satchel')
		add_to_chat(217,"You can't cast Teleport-Holla, attempting to use Dimensional Ring (Holla) instead.")
		cancel_spell()
		return
	elseif spell.english == 'Teleport-Dem' then
		windower.send_command('get "Dim. Ring (Dem)" satchel;wait 2;gs c forceequip DemRing ring2;wait 10;input /item "Dim. Ring (Dem)" <me>;wait 15;gs c quietenable ring2;put "Dim. Ring (Dem)" satchel')
				add_to_chat(217,"You can't cast Teleport-Dem, attempting to use Dimensional Ring (Dem) instead.")
		cancel_spell()
		return
	elseif spell.english == 'Teleport-Mea' then
		windower.send_command('get "Dim. Ring (Mea)" satchel;wait 2;gs c forceequip MeaRing ring2;wait 10;input /item "Dim. Ring (Mea)" <me>;wait 15;gs c quietenable ring2;put "Dim. Ring (Mea)" satchel')	
		add_to_chat(217,"You can't cast Teleport-Mea, attempting to use Dimensional Ring (Mea) instead.")
		cancel_spell()
		return
	end
end

function user_buff_change(buff, gain, eventArgs)

end

function user_customize_melee_set(meleeSet)

    return meleeSet
end

function user_customize_defense_set(defenseSet)

	return defenseSet
end

function pre_tick()
	if check_trust() then return true end
	
	return false
end

function user_tick()
	if check_sub() then return true end
	if check_ws() then return end
	if check_cpring_buff() then return end
	if check_cleanup() then return end
	if check_shoot() then return end
	if check_nuke() then return end
	return false
end