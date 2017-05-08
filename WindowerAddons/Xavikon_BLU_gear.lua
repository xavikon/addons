function user_setup()
	--Override default values
	state.OffenseMode:options('Default', 'HighAcc')
	state.HybridMode:options('Default')
	state.WeaponskillMode:options('Default')
	state.CastingMode:options('Default')
	state.IdleMode:options('Default', 'PDT')
	state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenceMode:options('MDT')
--state.ResistDefenseMode:options()
	
-- TODO: Create bind list for BLU

	update_combat_form()
	select_default_macro_book()
end

function init_gear_sets()
	---------------------------------
	-- Gear Set Definitions --
	---------------------------------
	sets.buff['Burst Affinity'] = {feet="Hashi. Basmak +1"}
	sets.buff['Chain Affinity'] = {feet="Assim. Charuqs +1"}
	self.buff.Diffusion = {feet="Luhlaza Charuqs +1"}

	-- Precast Sets

	-- FastCast sets

	sets.precast.FC = {}

	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1"})

	-- Weaponskill Sets

	sets.precast.WS = {}
	sets.precast.WS.HighAcc = {}

	-- Can combine sets, e.g. set_combine(sets.precast.WS, {extra_piece="abc ring"})

	sets.precast.WS['Chant du Cygne'] = {}
	sets.precast.WS['Chant du Cygne'].HighAcc = {}
	sets.precast.WS['Savage Blade'] = {}
	sets.precast.WS['Savage Blade'].HighAcc = {}
	sets.precast.WS['Vorpal Blade'] = {}
	sets.precast.WS['Vorpal Blade'].HighAcc = {}


	-- Midcast Sets

	sets.midcast.FastRecast = {}

	sets.midcast['Blue Magic'].Physical = {}

	sets.midcast['Blue Magic'].Magical = {}

	sets.midcast.Cure = {}

	-- Physical Added Effect Spells, mostly 'Stun' spells --

	sets.midcast['Blue Magic'].Stun = {}

	-- Resting sets

	sets.resting = {}

	-- Idle sets

	sets.idle = {}

	sets.idle.PDT = {}

	-- Defense sets

	sets.defense.PDT = {}

	sets.defense.MDT = {}

	-- Engages sets

	sets.engaged = {}

	sets.engaged.PDT = {}

	sets.engaged.MDT = {}

end
-- Select default macro book on initial load or subjob change
	function select_default_macro_boo()
	if player.sub_job == 'DNC' then
		--set_macro_page(page, book)
		set_macro_page(3, 3)
	elseif player.sub_job == 'WAR' then
		set_macro_page(4, 3)
	elseif player.sub_job == 'RDM' then
		set_macro_page(5, 3)
	elseif player.sub_job == 'NIN' then
		set_macro_page(6, 3)
	else
		set_macro_page(1, 3)
	end
end
