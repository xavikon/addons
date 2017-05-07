function user_setup()
	-- Options: Override default values
	state.CastingMode:options('Normal', 'Resistant', 'Fodder', 'Proc')
	state.OffenseMode:options('None', 'Normal')
	state.IdleMode:options('Normal', 'PDT', 'TPEat','Regain')

	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_low_nuke_back = "Bane Cape"
	gear.obi_low_nuke_waist = "Sekhmet Corset"

	
	gear.obi_high_nuke_back = "Toro Cape"
	gear.obi_high_nuke_waist = "Refoccilation Stone"
	
		-- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !\\\\ input /ja "Manawell" <me>')
	send_command('bind !` input /ma "Aspir II" <t>')
	send_command('bind @` gs c cycle MagicBurstMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind @pause gs c toggle AutoSubMode')
	send_command('bind !pause gs c toggle AutoBuffMode')
	send_command('bind @f9 gs c toggle DeathMode')
	send_command('bind @^` input /ja "Parsimony" <me>')
	send_command('bind ^backspace input /ma "Stun" <t>')
	send_command('bind !backspace input /ja "Enmity Douse" <t>')
	send_command('bind @backspace input /ja "Alacrity" <me>')
	send_command('bind != input /ja "Light Arts" <me>')
	send_command('bind @= input /ja "Addendum: White" <me>')
	send_command('bind ^delete input /ja "Dark Arts" <me>')
	send_command('bind !delete input /ja "Addendum: Black" <me>')
	send_command('bind @delete input /ja "Manifestation" <me>')
    
	select_default_macro_book()
end

function init_gear_sets()

    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Goetia Sabots +2"}

    sets.precast.JA.Manafont = {} --body="Sorcerer's Coat +2"
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}


    -- Fast cast sets for spells

    sets.precast.FC = {main=gear.grioavolr_nuke_staff,sub="Clerisy Strap +1",ammo="Impatiens",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Anhur Robe",hands="Helios Gloves",ring1="Prolix Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
	sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {})

	sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Serenity",sub="Clerisy Strap +1",body="Heka's Kalasiris", back="Pahtli Cape",main="Serenity",sub="Curatio Grip"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure
	
	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})

	sets.precast.FC.Death = {}
		
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Dosis Tathlum",
		head="Hagondes Hat +1",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Strendu Ring",ring2="Acumen Ring",
		back="Toro Cape",waist="Fotia Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {ammo="Dosis Tathlum",
		head="Hagondes Hat +1",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Vanir Cotehardie",hands="Hagondes Cuffs +1",ring1="Strendu Ring",ring2="Acumen Ring",
		back="Toro Cape",waist="Fotia Belt",legs="Hagondes Pants +1",feet=gear.merlinic_nuke_feet}

    sets.precast.WS['Myrkr'] = {ammo="Staunch Tathlum",
		head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Gifted Earring",ear2="Etiolation Earring",
		body="Amalric Doublet",hands="Telchine Gloves",ring1="Metamor. Ring +1",ring2="Sangoma Ring",
		back="Bane Cape",waist="Yamabuki-no-Obi",legs="Psycloth Lappas",feet="Medium's Sabots"}
    
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {main=gear.grioavolr_nuke_staff,ammo="Hasty Pinion +1",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Helios Jacket",hands="Helios Gloves",ring1="Prolix Ring",ring2="Dark Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}

    sets.midcast.Cure = {main="Serenity",sub="Curatio Grip",ammo="Hasty Pinion +1",
        head="Nahtirah Hat",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Etiolation Earring",
        body="Vanir Cotehardie",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Haoma's Ring",
        back="Tempered Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
    sets.midcast.LightWeatherCure = {main="Chatoyant Staff",sub="Curatio Grip",ammo="Hasty Pinion +1",
        head="Nahtirah Hat",neck="Phalaina Locket",ear1="Gifted Earring",ear2="Etiolation Earring",
        body="Heka's Kalasiris",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Lebeche Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
		--Cureset for if it's not light weather but is light day.
    sets.midcast.LightDayCure = {main="Serenity",sub="Curatio Grip",ammo="Hasty Pinion +1",
        head="Nahtirah Hat",neck="Phalaina Locket",ear1="Gifted Earring",ear2="Etiolation Earring",
        body="Vanir Cotehardie",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Lebeche Ring",
        back="Twilight Cape",waist="Hachirin-no-Obi",legs="Psycloth Lappas",feet="Regal Pumps +1"}

    sets.midcast.Curaga = sets.midcast.Cure
	
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Malison Medallion",hands="Hieros Mittens",ring1="Haoma's Ring",ring2="Haoma's Ring"})
	
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Marin Staff +1",sub="Clemency Grip"})

	sets.midcast['Enhancing Magic'] = {main=gear.grioavolr_enhance_staff,sub="Fulcio Grip",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Prolix Ring","Dark Ring",
		back="Perimede Cape",waist="Olympus Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
	
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {main="Vadose Rod",sub="Genmei Shield",head="Amalric Coif",waist="Emphatikos Rope"})

    sets.midcast['Enfeebling Magic'] = {main=gear.grioavolr_nuke_staff,sub="Clerisy Strap +1",ammo="Pemphredo Tathlum",
        head="Befouled Crown",neck="Imbodla Necklace",ear1="Barkaro. Earring",ear2="Digni. Earring",
        body="Vanya Robe",hands="Lurid Mitts",ring1="Vertigo Ring",ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",waist="Ovate Rope",legs="Psycloth Lappas",feet="Uk'uxkaj Boots"}
		
    sets.midcast['Enfeebling Magic'].Resistant = {main=gear.grioavolr_nuke_staff,sub="Clerisy Strap +1",ammo="Pemphredo Tathlum",
        head="Befouled Crown",neck="Imbodla Necklace",ear1="Barkaro. Earring",ear2="Digni. Earring",
        body="Vanya Robe",hands="Lurid Mitts",ring1="Vertigo Ring",ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",waist="Ovate Rope",legs="Psycloth Lappas",feet="Medium's Sabots"}
		
    sets.midcast.ElementalEnfeeble = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",waist="Acuity Belt +1"})
    sets.midcast.ElementalEnfeeble.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",waist="Acuity Belt +1"})
	
	sets.midcast.IntEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {head="Amalric Coif",waist="Acuity Belt +1"})
	sets.midcast.IntEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {head="Amalric Coif",waist="Acuity Belt +1"})

	sets.midcast.MndEnfeebles = set_combine(sets.midcast['Enfeebling Magic'], {ring1="Globidonta Ring"})
	sets.midcast.MndEnfeebles.Resistant = set_combine(sets.midcast['Enfeebling Magic'].Resistant, {ring1="Globidonta Ring"})
	
	sets.midcast['Divine Magic'] = set_combine(sets.midcast['Enfeebling Magic'], {ring1="Globidonta Ring"})

    sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Culminus",ammo="Pemphredo Tathlum",
        head="Amalric Coif",neck="Incanter's Torque",ear1="Barkaro. Earring",ear2="Digni. Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Vertigo Ring",ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",waist="Acuity Belt +1",legs="Merlinic Shalwar",feet="Helios Boots"}

    sets.midcast.Drain = {main="Rubicundity",sub="Culminus",ammo="Pemphredo Tathlum",
        head="Amalric Coif",neck="Incanter's Torque",ear1="Barkaro. Earring",ear2="Digni. Earring",
        body="Vanya Robe",hands="Amalric Gages",ring1="Vertigo Ring",ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",waist="Fucho-no-obi",legs="Merlinic Shalwar",feet="Helios Boots"}
    
    sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast.DeathAspir = {}
	
	sets.midcast.Death = {}

    sets.midcast.Stun = {main="Rubicundity",sub="Culminus",ammo="Hasty Pinion +1",
        head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Helios Jacket",hands="Helios Gloves",ring1="Vertigo Ring",ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
    sets.midcast.Stun.Resistant = {main=gear.grioavolr_nuke_staff,sub="Clerisy Strap +1",ammo="Pemphredo Tathlum",
        head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Barkaro. Earring",ear2="Digni. Earring",
        body="Helios Jacket",hands="Helios Gloves",ring1="Vertigo Ring",ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Helios Boots"}

    sets.midcast.BardSong = {main=gear.grioavolr_nuke_staff,sub="Clerisy Strap +1",ammo="Dosis Tathlum",
        head="Amalric Coif",neck="Sanctity Necklace",ear1="Barkaro. Earring",ear2="Digni. Earring",
        body="Vanir Cotehardie",hands="Lurid Mitts",ring1="Metamor. Ring +1",ring2="Sangoma Ring",
        back="Aurist's Cape +1",waist="Ovate Rope",legs="Hagondes Pants +1",feet="Medium's Sabots"}
		
	sets.midcast.Impact = {main=gear.grioavolr_nuke_staff,sub="Clerisy Strap +1",ammo="Pemphredo Tathlum",
		head=empty,neck="Incanter's Torque",ear1="Barkaro. Earring",ear2="Digni. Earring",
		body="Twilight Cloak",hands="Lurid Mitts",ring1="Vertigo Ring",ring2="Metamor. Ring +1",
		back="Aurist's Cape +1",waist="Acuity Belt +1",legs="Hagondes Pants +1",feet="Helios Boots"}

    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {main=gear.grioavolr_nuke_staff,sub="Zuuxowu Grip",ammo="Dosis Tathlum",
        head="Merlinic Hood",neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Strendu Ring",ring2="Acumen Ring",
        back="Bane Cape",waist=gear.ElementalObi,legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

    sets.midcast['Elemental Magic'].Resistant = {main=gear.grioavolr_nuke_staff,sub="Niobid Strap",ammo="Pemphredo Tathlum",
        head="Merlinic Hood",neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Barkaro. Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Strendu Ring",ring2="Acumen Ring",
        back="Bane Cape",waist="Yamabuki-no-Obi",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
    sets.midcast['Elemental Magic'].Fodder = {main=gear.grioavolr_nuke_staff,sub="Zuuxowu Grip",ammo="Dosis Tathlum",
        head="Merlinic Hood",neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Strendu Ring",ring2="Acumen Ring",
        back="Bane Cape",waist=gear.ElementalObi,legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

	sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Niobid Strap",ammo="Pemphredo Tathlum",ear1="Friomisi Earring",ear2="Barkaro. Earring",back="Toro Cape",feet=gear.merlinic_nuke_feet})
	sets.midcast['Elemental Magic'].Resistant.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Resistant, {sub="Niobid Strap",ammo="Pemphredo Tathlum",ear1="Friomisi Earring",ear2="Barkaro. Earring",back="Toro Cape"})
	sets.midcast['Elemental Magic'].Fodder.HighTierNuke = set_combine(sets.midcast['Elemental Magic'].Fodder, {sub="Niobid Strap",ammo="Pemphredo Tathlum",ear1="Friomisi Earring",ear2="Barkaro. Earring",back="Toro Cape",feet=gear.merlinic_nuke_feet})
	
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Resistant
		
		-- Minimal damage gear, maximum recast gear for procs.
    sets.midcast['Elemental Magic'].Proc = {main=empty, sub=empty,ammo="Impatiens",
        head="Nahtirah Hat",neck="Loricate Torque +1",ear1="Gifted Earring",ear2="Loquacious Earring",
        body="Spae. Coat +1",hands="Serpentes Cuffs",ring1="Prolix Ring",ring2="Lebeche Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Assid. Pants +1",feet="Regal Pumps +1"}
	
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Chatoyant Staff",sub="Oneiros Grip",
		head="Befouled Crown",neck="Chrys. Torque",ear1="Ethereal Earring",ear2="Sanare Earring",
		body="Vrikodara Jupon",hands="Serpentes Cuffs",ring1="Defending Ring",ring2="Sheltered Ring",
		back="Umbra Cape",waist="Refoccilation Stone",legs="Assid. Pants +1",feet="Serpentes Sabots"}
    

    -- Idle sets
    
    -- Normal refresh idle set
    sets.idle = {main="Bolelabunga", sub="Genbu's Shield",ammo="Staunch Tathlum",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Etiolation Earring",
		body="Jhakri Robe +1",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Sheltered Ring",
		back="Umbra Cape",waist="Flax Sash",legs="Assid. Pants +1",feet="Battlecast Gaiters"}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {main="Terra's Staff", sub="Oneiros Grip",ammo="Staunch Tathlum",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Etiolation Earring",
        body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}
		
    sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque",ring2="Karieyh Ring"})
	sets.idle.Regain = set_combine(sets.idle, {ring2="Karieyh Ring"})

	sets.idle.Death = {}

    sets.idle.Weak = {main="Bolelabunga", sub="Genbu's Shield",ammo="Staunch Tathlum",
		head="Befouled Crown",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Sanare Earring",
		body="Vrikodara Jupon",hands="Serpentes Cuffs",ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Flax Sash",legs="Assid. Pants +1",feet="Serpentes Sabots"}

    -- Defense sets

    sets.defense.PDT = {main="Terra's Staff", sub="Umbra Strap",ammo="Staunch Tathlum",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Etiolation Earring",
        body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}

    sets.defense.MDT = {main="Terra's Staff", sub="Umbra Strap",ammo="Staunch Tathlum",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Etiolation Earring",
        body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet=gear.merlinic_nuke_feet}
		
    sets.defense.MEVA = {ammo="Staunch Tathlum",
        head=empty,neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Etiolation Earring",
		body="Respite Cloak",hands="Telchine Gloves",ring1="Vengeful Ring",ring2="Purity Ring",
        back="Aurist's Cape +1",waist="Ovate Rope",legs="Telchine Braconi",feet="Telchine Pigaches"}

    sets.Kiting = {feet="Herald's Gaiters"}
		sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {feet="Serpentes Sabots"}
	sets.NightIdle = {hands="Serpentes Cuffs"}
	
    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff['Mana Wall'] = {feet="Goetia Sabots +2"}
	
	-- Gear that converts elemental damage done to recover MP.	
	sets.RecoverMP = {body="Spae. Coat +1"}
	
	-- Gear for Magic Burst mode.
    sets.MagicBurst = {neck="Mizu. Kubikazari",ring1="Mujin Band",ring2="Locus Ring",feet="Jhakri Pigaches +1"}
	
	-- Gear for specific elemental nukes.
	sets.WindNuke = {main="Marin Staff +1"}
	sets.IceNuke = {main="Ngqoqwanb"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Dosis Tathlum",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Ethereal Earring",ear2="Sanare Earring",
		body="Vanya Robe",hands="Hagondes Cuffs +1",ring1="Dark Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Refoccilation Stone",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}

	--Situational sets: Gear that is equipped on certain targets
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 7)
end