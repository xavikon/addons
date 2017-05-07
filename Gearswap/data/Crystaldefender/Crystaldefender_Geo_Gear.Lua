function user_setup()

	-- Options: Override default values
    state.OffenseMode:options('None', 'Normal')
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
    state.IdleMode:options('Normal', 'PDT', 'TPEat', 'Regain')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock', 'GeoLock', 'PetPDT')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')

	gear.obi_cure_back = "Tempered Cape"

	gear.obi_low_nuke_back = gear.nuke_jse_back
	gear.obi_low_nuke_waist = "Sekhmet Corset"

	gear.obi_high_nuke_back = gear.nuke_jse_back
	gear.obi_high_nuke_waist = "Refoccilation Stone"

	-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` input /ja "Full Circle" <me>')
	send_command('bind @pause gs c toggle AutoBuffMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind ^backspace input /ja "Entrust" <me>')
	send_command('bind !backspace input /ja "Life Cycle" <me>')
	send_command('bind @backspace input /ma "Sleep II" <t>')
	send_command('bind ^delete input /ma "Aspir III" <t>')
	send_command('bind @delete input /ma "Sleep" <t>')
	
	indi_duration = 290
	
	select_default_macro_book()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
	sets.precast.JA.Bolster = {body="Bagua Tunic +1"}
	sets.precast.JA['Life Cycle'] = {body="Geo. Tunic +1",back="Nantosuelta's Cape"}
	sets.precast.JA['Radial Arcana'] = {feet="Bagua Sandals"}
	sets.precast.JA['Mending Halation'] = {legs="Bagua Pants"}
	sets.precast.JA['Full Circle'] = {head="Azimuth Hood",hands="Bagua Mitaines"}
	
	-- Indi Duration in slots that would normally have skill here to make entrust more efficient.
	sets.buff.Entrust = {}
	
	-- Fast cast sets for spells

	sets.precast.FC = {body="Helios Jacket",hands="Helios Gloves", back="Lifestream Cape",waist="Witful Belt",legs="Geo. Pants +1",feet="Regal Pumps"}

	sets.precast.FC.Geomancy = set_combine(sets.precast.FC, {range="Dunna",ammo=empty})
	
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
	
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {hands="Bagua Mitaines"})
	
	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {body="Helios Jacket",hands="Helios Gloves", back="Lifestream Cape",legs="Geo. Pants +1",feet="Regal Pumps"}

	sets.midcast.Geomancy = {range="Dunna", head="Azimuth hood",body="Bagua Tunic +1", hands="Geo. Mitaines +1",ring1="Defending Ring",ring2="Renaye Ring",
		back="Lifestream cape"}


	--Extra Indi duration on any slot you can't get skill on here.
	sets.midcast.Geomancy.Indi = set_combine(sets.midcast.Geomancy, {legs="Bagua Pants"})
		
    sets.midcast.Cure = {hands="Telchine Gloves", ring2="Sirona's Ring",
        back="Tempered Cape",legs="Geo. Pants +1",feet="Regal Pumps"}
		
    sets.midcast.Curaga = sets.midcast.Cure
	
    sets.midcast['Elemental Magic'] = {main=gear.grioavolr_nuke_staff,sub="Zuuxowu Grip",ammo="Dosis Tathlum",
        head="Merlinic Hood",neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Strendu Ring",ring2="Acumen Ring",
        back=gear.nuke_jse_back,waist=gear.ElementalObi,legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

    sets.midcast['Elemental Magic'].Resistant = {main=gear.grioavolr_nuke_staff,sub="Niobid Strap",ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Barkaro. Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Strendu Ring",ring2="Acumen Ring",
        back=gear.nuke_jse_back,waist="Yamabuki-no-Obi",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
    sets.midcast['Elemental Magic'].Fodder = {main=gear.grioavolr_nuke_staff,sub="Zuuxowu Grip",ammo="Dosis Tathlum",
        head="Merlinic Hood",neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Strendu Ring",ring2="Acumen Ring",
        back=gear.nuke_jse_back,waist=gear.ElementalObi,legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Niobid Strap",ammo="Pemphredo Tathlum",ear1="Friomisi Earring",ear2="Barkaro. Earring",feet=gear.merlinic_nuke_feet})
	sets.midcast['Elemental Magic'].Resistant.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Resistant, {sub="Niobid Strap",ammo="Pemphredo Tathlum",ear1="Friomisi Earring",ear2="Barkaro. Earring"})
	sets.midcast['Elemental Magic'].Fodder.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Fodder, {sub="Niobid Strap",ammo="Pemphredo Tathlum",ear1="Friomisi Earring",ear2="Barkaro. Earring",feet=gear.merlinic_nuke_feet})
		
    sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Culminus",ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Incanter's Torque",ear1="Digni. Earring",ear2="Barkaro. Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Vertigo Ring",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Yamabuki-no-Obi",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
    sets.midcast.Drain = {main="Rubicundity",sub="Culminus",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Incanter's Torque",ear1="Digni. Earring",ear2="Barkaro. Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Archon Ring",ring2="Metamor. Ring +1",
        back=gear.nuke_jse_back,waist="Fucho-no-obi",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
    
    sets.midcast.Aspir = sets.midcast.Drain
		
	sets.midcast.Stun = {main=gear.grioavolr_nuke_staff,sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
		head="Amalric Coif",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Helios Jacket",hands="Helios Gloves",ring1="Prolix Ring",ring2="Sangoma Ring",
		back="Lifestream Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
	sets.midcast.Stun.Resistant = {main=gear.grioavolr_nuke_staff,sub="Clerisy Strap +1",ammo="Pemphredo Tathlum",
		head="Amalric Coif",neck="Incanter's Torque",ear1="Digni. Earring",ear2="Barkaro. Earring",
		body="Merlinic Jubbah",hands="Amalric Gages",ring1="Vertigo Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

		
	sets.midcast.Impact = {main=gear.grioavolr_nuke_staff,sub="Clerisy Strap +1",ammo="Pemphredo Tathlum",
		head=empty,neck="Incanter's Torque",ear1="Digni. Earring",ear2="Barkaro. Earring",
		body="Twilight Cloak",hands="Lurid Mitts",ring1="Vertigo Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Acuity Belt +1",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
	sets.midcast['Enfeebling Magic'] = {main=gear.grioavolr_nuke_staff,sub="Clerisy Strap +1",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Imbodla Necklace",ear1="Digni. Earring",ear2="Barkaro. Earring",
		body="Merlinic Jubbah",hands="Lurid Mitts",ring1="Vertigo Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Ovate Rope",legs="Psycloth Lappas",feet="Uk'uxkaj Boots"}
		
	sets.midcast['Enfeebling Magic'].Resistant = {main=gear.grioavolr_nuke_staff,sub="Clerisy Strap +1",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Imbodla Necklace",ear1="Digni. Earring",ear2="Barkaro. Earring",
		body="Merlinic Jubbah",hands="Lurid Mitts",ring1="Vertigo Ring",ring2="Metamor. Ring +1",
		back=gear.nuke_jse_back,waist="Ovate Rope",legs="Psycloth Lappas",feet="Medium's Sabots"}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",waist="Acuity Belt +1"})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",waist="Acuity Belt +1"})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",waist="Acuity Belt +1"})
	
	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {range=empty,ring1="Globidonta Ring"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {range=empty,ring1="Globidonta Ring"})
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {ring1="Globidonta Ring"})
		
	sets.midcast['Enhancing Magic'] = {main=gear.grioavolr_enhance_staff,sub="Fulcio Grip",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Prolix Ring",
		back="Perimede Cape",waist="Olympus Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genbu's Shield",head="Amalric Coif",waist="Emphatikos Rope"})
	
	sets.midcast.Protect = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Loquacious Earring",waist="Sekhmet Corset"})
	sets.midcast.Protectra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Loquacious Earring",waist="Sekhmet Corset"})
	sets.midcast.Shell = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Loquacious Earring",waist="Sekhmet Corset"})
	sets.midcast.Shellra = set_combine(sets.midcast['Enhancing Magic'], {ring2="Sheltered Ring",ear1="Gifted Earring",ear2="Loquacious Earring",waist="Sekhmet Corset"})

	-- Gear for specific elemental nukes.
	sets.WindNuke = {main="Marin Staff +1"}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

	-- Resting sets

	-- Idle sets

	sets.idle = {main="Nehushtan",sub="Genbu's Shield",neck="Veisa Collar",body="Geo. Tunic +1",hands="Bagua Mitaines +1",ring2="Renaye Ring",waist="Acuity belt"}
		
	sets.idle.PDT = {main="Earth Staff",neck="Veisa collar"}
		

	-- .Pet sets are for when Luopan is present.
	sets.idle.Pet = {sub="Genbu's Shield",range="Dunna",head="Azimuth Hood",neck="Veisa Collar",ear2="Handler's Earring",hands="Geo. Mitaines +1",ring1="Defending Ring", back="Lifestream cape",feet="Bagua Sandals"}

	sets.idle.PDT.Pet = {main="Earth Staff",head="Azimuth Hood",ear2="Handler's Earring",hands="Geo. Mitaines +1",feet="Bagua Sandals"}

	-- .Indi sets are for when an Indi-spell is active.
	sets.idle.Indi = set_combine(sets.idle, {})
	sets.idle.Pet.Indi = set_combine(sets.idle.Pet, {}) 
	sets.idle.PDT.Indi = set_combine(sets.idle.PDT, {}) 
	sets.idle.PDT.Pet.Indi = set_combine(sets.idle.PDT.Pet, {})

	-- Defense sets
	
	sets.defense.PDT = {main="Earth Staff",neck="Veisa Collar",ear2="Handler's Earring"}

	sets.defense.MDT = {main="Earth Staff",head="Azimuth Hood",neck="Veisa Collar",ear2="Handler's Earring"}
		
    sets.defense.MEVA = {head="Azimuth Hood",neck="Warder's Charm",hands="Telchine Gloves"}
		
	sets.defense.PetPDT = sets.idle.PDT.Pet
		
	sets.defense.NukeLock = sets.midcast['Elemental Magic']
	
	sets.defense.GeoLock = sets.midcast.Geomancy.Indi

	sets.Kiting = {feet="Herald's Gaiters"}
	sets.NightIdle = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	--------------------------------------
	-- Engaged sets
	--------------------------------------

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion

	-- Normal melee group

	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	
	-- Gear that converts elemental damage done to recover MP.	
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {ring1="Mujin Band",ring2="Locus Ring",feet="Jhakri Pigaches"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(1, 3)
end