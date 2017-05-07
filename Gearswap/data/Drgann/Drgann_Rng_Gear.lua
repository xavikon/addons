-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	state.RangedMode:options('Normal', 'Acc')
	state.WeaponskillMode:options('Normal', 'Acc')
	
	DefaultAmmo = {['Ajjub Bow'] = "Achiyalabopa Arrow", ['Phaosphaelia'] = "Achiyalabopa Arrow", ['Hangaku-no-Yumi'] = "Achiyalabopa Arrow", ['Illapa'] = "Achiyalabopa Bolt"}
	U_Shot_Ammo = {['Ajjub Bow'] = "Achiyalabopa Arrow", ['Phaosphaelia'] = "Achiyalabopa Arrow", ['Hangaku-no-Yumi'] = "Achiyalabopa Arrow", ['Illapa'] = "Achiyalabopa Bolt"}

	--Delete or comment out this line if you don't use Addon legs with Waltz cost-50
	waltz_tp_cost = {['Curing Waltz'] = 150, ['Curing Waltz II'] = 300, ['Curing Waltz III'] = 450, ['Curing Waltz IV'] = 600, ['Curing Waltz V'] = 750}
	
	    -- Additional local binds
    send_command('bind !` input /ra <t>')
	send_command('bind !backspace input /ja "Bounty Shot" <t>')
	send_command('bind @f7 gs c toggle AutoShootMode')
	
	select_default_macro_book()

end

-- Set up all gear sets.
function init_gear_sets()
	--------------------------------------
	-- Precast sets
	--------------------------------------

	
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Bounty Shot'] = set_combine(sets.TreasureHunter, {hands="Amini Glove. +1"})
	sets.precast.JA['Camouflage'] = {body="Orion Jerkin +1"}
	sets.precast.JA['Scavenge'] = {feet="Orion Socks +1"}
	sets.precast.JA['Shadowbind'] = {hands="Orion Bracers +1"}
	sets.precast.JA['Sharpshot'] = {legs="Orion Braccae +1"}


	-- Fast cast sets for spells

	sets.precast.FC = {
		head="Haruspex Hat +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Dread Jupon",hands="Leyline Gloves",ring1="Lebeche Ring", ring2="Prolix Ring",
		legs="Blood Cuisses"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


	-- Ranged sets (snapshot)
	
	sets.precast.RA = {
		head="Amini Gapette",
		body="Amini Caban +1",hands="Iuitl Wristbands +1",
		back="Lutian Cape",waist="Impulse Belt",legs="Nahtirah Trousers",feet="Amini Bottillons"}


	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		head="Umbani Cap",neck="Ocachi Gorget",ear1="Enervating Earring",ear2="Neritic Earring",
		body="Amini Caban +1",hands="Amini Glove. +1",ring1="Paqichikaji Ring",ring2="Rajas Ring",
		back="Lutian Cape",waist="Elanid Belt",legs="Nahtirah Trousers",feet="Orion Socks +1"}

	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ring2="Hajduk Ring",hands="Floral Gauntlets",legs="Orion Braccae +1"})
		
	sets.precast.WS["Jishnu's Radiance"] = {
		head="Adhemar Bonnet",neck="Fotia Gorget",ear1="Jupiter's Pearl",ear2="Moonshade Earring",
		body="Amini Caban +1",hands="Amini Glove. +1",ring1="Paqichikaji Ring",ring2="Rajas Ring",
		back="Rancorous Mantle",waist="Fotia Belt",legs="Amini Brague +1",feet="Orion Socks +1" }
		
	sets.precast.WS["Jishnu's Radiance"].Acc = set_combine(sets.precast.WS["Jishnu's Radiance"], {head="Umbani Cap",ear1="Enervating Earring",hands="Floral Gauntlets",ring2="Hajduk Ring",legs="Orion Braccae +1"})
	
	sets.precast.WS["Empyreal Arrow"] = {
		head="Umbani Cap",neck="Fotia Gorget",ear1="Enervating Earring",ear2="Moonshade Earring",
		body="Amini Caban +1",hands="Amini Glove. +1",ring1="Paqichikaji Ring",ring2="Rajas Ring",
		back="Lutian Cape",waist="Fotia Belt",legs="Amini Brague +1",feet="Orion Socks +1" }
		
	sets.precast.WS["Empyreal Arrow"].Acc = set_combine(sets.precast.WS["Empyreal Arrow"], {hands="Floral Gauntlets",ring2="Hajduk Ring", legs="Orion Braccae +1"})
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Enervating Earring",ear2="Neritic Earring"}
	sets.precast.AccMaxTP = {ear1="Enervating Earring",ear2="Neritic Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.


	--------------------------------------
	-- Midcast sets
	--------------------------------------

	-- Fast recast for spells
	
	sets.midcast.FastRecast = {
		head="Haruspex Hat +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear1="Loquacious Earring",
		body="Amini Caban +1",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
		waist="Hurch'lan Sash",legs="Orion Braccae +1",feet="Orion Socks +1"}
		
	-- Ranged sets

	sets.midcast.RA = {
		head="Arcadian Beret +1",neck="Ocachi Gorget",ear1="Enervating Earring",ear2="Neritic Earring",
		body="Amini Caban +1",hands="Amini Glove. +1",ring1="Paqichikaji Ring",ring2="Rajas Ring",
		back="Lutian Cape",waist="Ponente Sash",legs="Amini Brague +1",feet="Orion Socks +1"}
	
	sets.midcast.RA.Acc = set_combine(sets.midcast.RA,
		{head="Umbani Cap",neck="Combatant's Torque",hands="Floral Gauntlets",waist="Flax Sash",legs="Orion Braccae +1"})
	
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Sets to return to when not performing an action.

	-- Resting sets
	sets.resting = {ring1="Defending Ring",ring2="Sheltered Ring"}

	-- Idle sets
	sets.idle = {
		head="Umbani Cap",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Amini Caban +1",hands="Iuitl Wristbands +1",ring1="Defending Ring",ring2="Karieyh Ring",
		back="Shadow Mantle",waist="Flume Belt",legs=gear.herculean_dt_legs,feet="Skd. Jambeaux +1"}
	
	-- Defense sets
	sets.defense.PDT = {
		head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Orion Jerkin +1",hands="Iuitl Wristbands +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Flume Belt",legs=gear.herculean_dt_legs,feet="Orion Socks +1"}

	sets.defense.MDT = {
		head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Orion Jerkin +1",hands="Floral Gauntlets",ring1="Defending Ring",ring2="Shadow Ring",
		back="Mollusca Mantle",waist="Flax Sash",legs=gear.herculean_dt_legs,feet="Orion Socks +1"}
		
	sets.defense.MEVA = {ammo="Staunch Tathlum",
		head=empty,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Respite Cloak",hands="Leyline Gloves",ring1="Vengeful Ring",ring2="Shadow Ring",
		back="Toro Cape",waist="Ovate Rope",legs="Meg. Chausses +1",feet=gear.herculean_acc_feet}

	sets.Kiting = {back="Solemnity Cape",feet="Skd. Jambeaux +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Weapons = {main="Oneiros Knife",sub="Perun +1",range="Phaosphaelia",ammo="Achiyalabopa Arrow"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	sets.engaged = {
		head="Dampening Tam",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Adhemar Jacket", hands="Floral Gauntlets", ring1="Epona's Ring",ring2="Rajas Ring",
		back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Meg. Chausses +1",feet=gear.herculean_acc_feet}

	sets.engaged.Acc = {
		head="Dampening Tam",neck="Combatant's Torque",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Mekosu. Harness", hands="Floral Gauntlets", ring1="Epona's Ring",ring2="Rajas Ring",
		back="Ground. Mantle +1",waist="Olseni Belt",legs="Meg. Chausses +1",feet=gear.herculean_acc_feet}

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Barrage = set_combine(sets.midcast.RA.Acc, {hands="Orion Bracers +1"})
	sets.buff.Camouflage = {body="Orion Jerkin +1"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 19)
end
