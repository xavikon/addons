function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','MinAcc','SomeAcc','Acc', 'HighAcc','FullAcc','Fodder','None')
	state.HybridMode:options('Normal','PDT','MDT','Shield')
    state.WeaponskillMode:options('Normal', 'SomeAcc','Acc','FullAcc', 'Fodder')
    state.CastingMode:options('Normal', 'Resistant', 'Fodder')
    state.IdleMode:options('Normal', 'Sphere', 'PDT')
	state.PhysicalDefenseMode:options('PDT', 'NukeLock')
	state.MagicalDefenseMode:options('MDT', 'NukeLock')
	state.ResistDefenseMode:options('MEVA')
	
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'MP','SuppaBrutal', 'DWEarrings','DWMax'}
	
	gear.da_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	gear.crit_jse_back = {name="Rosmerta's Cape",augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Crit.hit rate+10',}}
	gear.mab_jse_back = {name="Rosmerta's Cape",augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	
	gear.obi_cure_back = "Tempered Cape +1"
	gear.obi_cure_waist = "Witful Belt"

	gear.obi_nuke_back = "Cornflower Cape"
	gear.obi_nuke_waist = "Yamabuki-no-Obi"
	
	--Delete or comment out this line if you don't use Addon legs with Waltz cost-50
	waltz_tp_cost = {['Curing Waltz'] = 150, ['Curing Waltz II'] = 300, ['Curing Waltz III'] = 450, ['Curing Waltz IV'] = 600, ['Curing Waltz V'] = 750}
	
	-- Additional local binds
	send_command('bind ^` input /ja "Chain Affinity" <me>')
	send_command('bind !` input /ja "Efflux" <me>')
	send_command('bind @` input /ja "Burst Affinity" <me>')
	send_command('bind ^backspace input /ja "Unbridled Learning" <me>;wait 1;input /ja "Diffusion" <me>;wait 2;input /ma "Mighty Guard" <me>')
	send_command('bind !backspace input /ja "Diffusion" <me>')
	send_command('bind @backspace input /ja "Convergence" <me>')
    send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind @f10 gs c toggle LearningMode')
	send_command('bind ^@!` gs c cycle MagicBurstMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	send_command('bind !@^f7 gs c toggle AutoWSMode')
	send_command('bind !r gs c weapons MagicWeapons;gs c update')
	send_command('bind !q gs c weapons HybridWeapons;gs c update')

	update_combat_form()
	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------

	sets.buff['Burst Affinity'] = {feet="Hashi. Basmak +1"}
	sets.buff['Chain Affinity'] = {feet="Assim. Charuqs +1"}
	sets.buff.Convergence = {head="Luh. Keffiyeh +1"}
	sets.buff.Diffusion = {feet="Luhlaza Charuqs +1"}
	sets.buff.Enchainment = {} --body="Luhlaza Jubbah +1" (Don't have Enchainment, have Jubbah)
	sets.buff.Efflux = {back=gear.da_jse_back,legs="Hashishin Tayt +1"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	
	-- Precast Sets
	
	-- Precast sets to enhance JAs
	sets.precast.JA['Azure Lore'] = {hands="Luh. Bazubands +1"}


	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {legs="Desultor Tassets"} --
	
	sets.precast.Step = {ammo="Falcon Eye",
					head="Dampening Tam",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Telos Earring",
					body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
					back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
				
	sets.precast.Flourish1 = {ammo="Falcon Eye",
			       head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Gwati Earring",
                   body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Sangoma Ring",ring2="Vertigo Ring",
			       back="Cornflower Cape",waist="Olseni Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

	-- Fast cast sets for spells

	sets.precast.FC = {ammo="Impatiens",
		head="Carmine Mask",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Helios Jacket",hands="Leyline Gloves",ring1="Prolix Ring",ring2="Lebeche Ring",
		back="Perimede Cape",waist="Witful Belt",legs="Psycloth Lappas",feet="Helios Boots"}
		
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {body="Passion Jacket"})
		
	sets.precast.FC['Blue Magic'] = set_combine(sets.precast.FC, {body="Hashishin Mintan +1"})

	   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Ginsen",
				  head="Lilitu Headpiece",neck="Fotia Gorget",ear1="Cessance Earring",ear2="Brutal Earring",
                  body="Adhemar Jacket",hands="Jhakri Cuffs +1",ring1="Epona's Ring",ring2="Apate Ring",
				  back=gear.da_jse_back,waist="Fotia Belt",legs="Samnuha Tights",feet=gear.herculean_ta_feet}

	sets.precast.WS.SomeAcc = {ammo="Ginsen",
				  head="Dampening Tam",neck="Fotia Gorget",ear1="Cessance Earring",ear2="Brutal Earring",
                  body="Adhemar Jacket",hands="Jhakri Cuffs +1",ring1="Epona's Ring",ring2="Apate Ring",
				  back=gear.da_jse_back,waist="Fotia Belt",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
				  
	sets.precast.WS.Acc = {ammo="Falcon Eye",
				  head="Dampening Tam",neck="Fotia Gorget",ear1="Cessance Earring",ear2="Telos Earring",
				  body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Cacoethic Ring +1",
			      back=gear.da_jse_back,waist="Fotia Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
				  
	sets.precast.WS.FullAcc = {ammo="Falcon Eye",
				  head="Dampening Tam",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Telos Earring",
				  body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
			      back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {ear1="Moonshade Earring",ear2="Brutal Earring",ring1="Rufescent Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Requiescat'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {ear1="Moonshade Earring",ear2="Brutal Earring",hands="Adhemar Wristbands",ring1="Rufescent Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {ear1="Zennaroi Earring",ear2="Moonshade Earring",hands="Luh. Bazubands +1",ring1="Rufescent Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Requiescat'].FullAcc = set_combine(sets.precast.WS.FullAcc, {ring1="Rufescent Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Requiescat'].Fodder = set_combine(sets.precast.WS['Requiescat'], {ear1="Moonshade Earring",ear2="Brutal Earring",hands="Luh. Bazubands +1",legs="Carmine Cuisses +1"})
	
	sets.precast.WS['Realmrazer'] = set_combine(sets.precast.WS, {ring1="Rufescent Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Realmrazer'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {ring1="Rufescent Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Realmrazer'].Acc = set_combine(sets.precast.WS.Acc, {ring1="Rufescent Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Realmrazer'].FullAcc = set_combine(sets.precast.WS.FullAcc, {ring1="Rufescent Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Realmrazer'].Fodder = set_combine(sets.precast.WS['Realmrazer'], {ear1="Cessance Earring",hands="Luh. Bazubands +1",ear2="Brutal Earring",ring1="Rufescent Ring",legs="Carmine Cuisses +1"})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {ammo="Falcon Eye",head="Adhemar Bonnet",ear1="Moonshade Earring",ear2="Brutal Earring",body="Abnoba Kaftan",hands="Adhemar Wristbands",ring2="Begrudging Ring",back=gear.crit_jse_back,feet="Thereoid Greaves"})
	sets.precast.WS['Chant du Cygne'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {ammo="Falcon Eye",ear1="Moonshade Earring",ear2="Cessance Earring",body="Abnoba Kaftan",hands="Adhemar Wristbands",ring2="Begrudging Ring",back=gear.crit_jse_back})
	sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {ear1="Zennaroi Earring",ear2="Moonshade Earring",hands="Adhemar Wristbands",ring2="Begrudging Ring",back=gear.crit_jse_back,legs="Carmine Cuisses +1"})
	sets.precast.WS['Chant du Cygne'].FullAcc = set_combine(sets.precast.WS.FullAcc, {hands="Adhemar Wristbands",back=gear.crit_jse_back,legs="Carmine Cuisses +1"})
	sets.precast.WS['Chant du Cygne'].Fodder = set_combine(sets.precast.WS['Chant du Cygne'], {})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",hands="Jhakri Cuffs +1",ring1="Rufescent Ring",ring2="Karieyh Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Savage Blade'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {ear1="Moonshade Earring",ear2="Brutal Earring",hands="Jhakri Cuffs +1",ring1="Rufescent Ring",ring2="Karieyh Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {ear1="Zennaroi Earring",ear2="Moonshade Earring",hands="Jhakri Cuffs +1",ring1="Rufescent Ring",ring2="Karieyh Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Savage Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {hands="Jhakri Cuffs +1",ring1="Rufescent Ring",legs="Carmine Cuisses +1"})
	sets.precast.WS['Savage Blade'].Fodder = set_combine(sets.precast.WS['Savage Blade'], {})
	
	sets.precast.WS['Vorpal Blade'] = set_combine(sets.precast.WS, {head="Adhemar Bonnet",ear1="Cessance Earring", ear2="Brutal Earring",ring2="Begrudging Ring",back=gear.crit_jse_back,feet="Thereoid Greaves"})
	sets.precast.WS['Vorpal Blade'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Adhemar Bonnet",ring2="Begrudging Ring",back=gear.crit_jse_back})
	sets.precast.WS['Vorpal Blade'].Acc = set_combine(sets.precast.WS.Acc, {back=gear.crit_jse_back})
	sets.precast.WS['Vorpal Blade'].FullAcc = set_combine(sets.precast.WS.FullAcc, {back=gear.crit_jse_back})
	sets.precast.WS['Vorpal Blade'].Fodder = set_combine(sets.precast.WS['Vorpal Blade'], {})


	sets.precast.WS['Sanguine Blade'] = {ammo="Pemphredo Tathlum",
			         head="Pixie Hairpin +1",neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
		             body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Acumen Ring",ring2="Archon Ring",
			         back="Cornflower Cape",waist="Yamabuki-no-Obi",legs="Hagondes Pants +1",feet="Jhakri Pigaches +1"}
					 
	sets.precast.WS['Flash Nova'] = {ammo="Pemphredo Tathlum",
			         head="Jhakri Coronal +1",neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
		             body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Acumen Ring",ring2="Strendu Ring",
			         back="Cornflower Cape",waist="Yamabuki-no-Obi",legs="Hagondes Pants +1",feet="Jhakri Pigaches +1"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring"}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Telos Earring"}
	
	-- Midcast Sets
	sets.midcast.FastRecast = {ammo="Hasty Pinion +1",
		head="Carmine Mask",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Helios Jacket",hands="Leyline Gloves",ring1="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Helios Boots"}
		
	sets.midcast['Blue Magic'] = {}
	
	-- Physical Spells --
	
	sets.midcast['Blue Magic'].Physical = {main="Vampirism",sub="Vampirism",ammo="Mavi Tathlum",
		head="Lilitu Headpiece",neck="Caro Necklace",ear1="Suppanomimi",ear2="Telos Earring",
		body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Apate Ring",ring2="Rajas Ring",
		back="Cornflower Cape",waist="Wanion Belt",legs="Jhakri Slops +1",feet=gear.herculean_acc_feet}

	sets.midcast['Blue Magic'].Physical.Resistant = {main="Tanmogayi +1",sub="Colada",ammo="Falcon Eye",
		head="Jhakri Coronal +1",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Telos Earring",
	    body="Jhakri Robe +1",hands="Adhemar Wristbands",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
	    back=gear.da_jse_back,waist="Anguinus Belt",legs="Jhakri Slops +1",feet=gear.herculean_acc_feet}
		
	sets.midcast['Blue Magic'].Physical.Fodder = {main="Iris",sub="Iris",ammo="Mavi Tathlum",
		head="Luh. Keffiyeh +1",neck="Incanter's Torque",ear1="Suppanomimi",ear2="Telos Earring",
		body="Assim. Jubbah +1",hands="Adhemar Wristbands",ring1="Apate Ring",ring2="Rajas Ring",
		back="Cornflower Cape",waist="Wanion Belt",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs +1"}
		
	sets.midcast['Blue Magic'].PhysicalAcc = {main="Tanmogayi +1",sub="Colada",ammo="Falcon Eye",
		head="Jhakri Coronal +1",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Telos Earring",
	    body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
	    back=gear.da_jse_back,waist="Anguinus Belt",legs="Jhakri Slops +1",feet=gear.herculean_acc_feet}

	sets.midcast['Blue Magic'].PhysicalAcc.Resistant = set_combine(sets.midcast['Blue Magic'].PhysicalAcc, {})
	sets.midcast['Blue Magic'].PhysicalAcc.Fodder = sets.midcast['Blue Magic'].Fodder
		
	sets.midcast['Blue Magic'].PhysicalStr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalStr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalStr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalDex = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalDex.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalDex.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalVit = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalVit.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalVit.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalAgi = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalAgi.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalInt = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalInt.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalInt.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalMnd = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalMnd.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalChr = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalChr.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalChr.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})
	
	sets.midcast['Blue Magic'].PhysicalHP = set_combine(sets.midcast['Blue Magic'].Physical, {})
	sets.midcast['Blue Magic'].PhysicalHP.Resistant = set_combine(sets.midcast['Blue Magic'].Physical.Resistant, {})
	sets.midcast['Blue Magic'].PhysicalHP.Fodder = set_combine(sets.midcast['Blue Magic'].Physical.Fodder, {})


	-- Magical Spells --
	
	sets.midcast['Blue Magic'].Magical = {main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
					 head="Jhakri Coronal +1",neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
					 body="Jhakri Robe +1",hands="Amalric Gages",ring1="Acumen Ring",ring2="Strendu Ring",
				     back=gear.mab_jse_back,waist=gear.ElementalObi,legs="Hagondes Pants +1",feet="Jhakri Pigaches +1"}
					 
	sets.midcast['Blue Magic'].Magical.Resistant = set_combine(sets.midcast['Blue Magic'].Magical,
		{neck="Sanctity Necklace",hands="Jhakri Cuffs +1",ring1="Sangoma Ring",ring1="Metamor. Ring +1",ring1="Vertigo Ring",legs="Jhakri Slops +1",waist="Yamabuki-no-Obi"})
		
	sets.midcast['Blue Magic'].Magical.Fodder = {main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
					 head="Jhakri Coronal +1",neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
					 body="Jhakri Robe +1",hands="Amalric Gages",ring1="Acumen Ring",ring2="Strendu Ring",
				     back=gear.ElementalCape,waist=gear.ElementalObi,legs="Hagondes Pants +1",feet="Jhakri Pigaches +1"}
	
	sets.midcast['Blue Magic'].MagicalMnd = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalChr = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalVit = set_combine(sets.midcast['Blue Magic'].Magical, {})
	sets.midcast['Blue Magic'].MagicalDex = set_combine(sets.midcast['Blue Magic'].Magical, {})
	
	sets.midcast['Blue Magic'].MagicAccuracy = {main="Iris",sub="Iris",ammo="Pemphredo Tathlum",
			        head="Jhakri Coronal +1",neck="Incanter's Torque",ear1="Digni. Earring",ear2="Gwati Earring",
				    body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Metamor. Ring +1",ring1="Vertigo Ring",
					back="Cornflower Cape",waist="Ovate Rope",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}

	sets.midcast['Enfeebling Magic'] = {main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
			        head="Jhakri Coronal +1",neck="Incanter's Torque",ear1="Digni. Earring",ear2="Gwati Earring",
				    body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Sangoma Ring",ring2="Vertigo Ring",
					back=gear.mab_jse_back,waist="Ovate Rope",legs="Psycloth Lappas",feet="Medium's Sabots"}

	sets.midcast['Dark Magic'] = {main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
			        head="Jhakri Coronal +1",neck="Incanter's Torque",ear1="Digni. Earring",ear2="Gwati Earring",
				    body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Sangoma Ring",ring2="Vertigo Ring",
					back=gear.mab_jse_back,waist="Ovate Rope",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
					
	sets.midcast['Enhancing Magic'] = {main="Vampirism", sub="Vampirism",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Prolix Ring",
		back="Perimede Cape",waist="Olympus Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif",waist="Emphatikos Rope"})

	sets.midcast['Divine Magic'] = {ammo="Pemphredo Tathlum",
			        head="Jhakri Coronal +1",neck="Incanter's Torque",ear1="Digni. Earring",ear2="Gwati Earring",
				    body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Sangoma Ring",ring2="Vertigo Ring",
					back=gear.mab_jse_back,waist="Ovate Rope",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
					
	sets.midcast['Elemental Magic'] = {main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Dosis Tathlum",
					 head="Jhakri Coronal +1",neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
					 body="Jhakri Robe +1",hands="Amalric Gages",ring1="Acumen Ring",ring2="Strendu Ring",
				     back=gear.mab_jse_back,waist=gear.ElementalObi,legs="Hagondes Pants +1",feet="Jhakri Pigaches +1"}

	sets.midcast['Elemental Magic'].Resistant = {main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
					 head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Friomisi Earring",
					 body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Acumen Ring",ring2="Strendu Ring",
				     back=gear.mab_jse_back,waist="Yamabuki-no-Obi",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
					 
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Fodder
	
	sets.DarkNuke = {head="Pixie Hairpin +1",ring2="Archon Ring"}
	sets.LightNuke = {} --ring2="Weatherspoon Ring"
					 
	sets.midcast.Cure = {main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Pemphredo Tathlum",
					head="Telchine Cap",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Mendi. Earring",
			        body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Haoma's Ring",
			        back=gear.ElementalCape,waist=gear.ElementalObi,legs="Carmine Cuisses +1",feet="Medium's Sabots"}
					
	-- Breath Spells --
	
	sets.midcast['Blue Magic'].Breath = {ammo="Mavi Tathlum",
		head="Luh. Keffiyeh +1",neck="Mavi Scarf",ear1="Digni. Earring",ear2="Gwati Earring",
		body="Assim. Jubbah +1",hands="Luh. Bazubands +1",ring1="Kunaji Ring",ring2="Beeline Ring",
		back="Cornflower Cape",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs +1"}

	-- Physical Added Effect Spells most notably "Stun" spells --
	
	sets.midcast['Blue Magic'].Stun = {main="Iris",sub="Iris",ammo="Falcon Eye",
			       head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Gwati Earring",
                   body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Sangoma Ring",ring2="Vertigo Ring",
			       back="Cornflower Cape",waist="Ovate Rope",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
				   
	sets.midcast['Blue Magic'].Stun.Resistant = {main="Iris",sub="Iris",ammo="Falcon Eye",
			       head="Jhakri Coronal +1",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Gwati Earring",
                   body="Jhakri Robe +1",hands="Jhakri Cuffs +1",ring1="Sangoma Ring",ring2="Vertigo Ring",
			       back="Cornflower Cape",waist="Olseni Belt",legs="Jhakri Slops +1",feet="Jhakri Pigaches +1"}
				   
	sets.midcast['Blue Magic'].Stun.Fodder = sets.midcast['Blue Magic'].Stun

	-- Other Specific Spells --
	
	sets.midcast['Blue Magic']['White Wind'] = {ammo="Mavi Tathlum",
					head="Telchine Cap",neck="Phalaina Locket",ear1="Gifted Earring",ear2="Loquac. Earring",
			        body="Telchine Chas.",hands="Telchine Gloves",ring1="Asklepian Ring",ring2="Lebeche Ring",
			        back=gear.ElementalCape,waist=gear.ElementalObi,legs="Gyve Trousers",feet="Medium's Sabots"}

	sets.midcast['Blue Magic'].Healing = {main="Nibiru Cudgel",sub="Nibiru Cudgel",ammo="Staunch Tathlum",
					head="Carmine Mask",neck="Incanter's Torque",ear1="Handler's Earring +1",ear2="Mendi. Earring",
			        body="Vrikodara Jupon",hands="Telchine Gloves",ring1="Sirona's Ring",ring2="Haoma's Ring",
			        back=gear.ElementalCape,waist=gear.ElementalObi,legs="Carmine Cuisses +1",feet="Medium's Sabots"}
					
	--Overwrite certain spells with these peices even if the day matches, because of resource inconsistancies.
	sets.NonElementalCure = {back="Tempered Cape +1",waist="Ovate Rope"}

	sets.midcast['Blue Magic'].SkillBasedBuff = {main="Iris",sub="Iris",ammo="Mavi Tathlum",
		head="Luh. Keffiyeh +1",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Loquac. Earring",
		body="Assim. Jubbah +1",hands="Rawhide Gloves",ring1="Prolix Ring",ring2="Dark Ring",
		back="Cornflower Cape",waist="Witful Belt",legs="Hashishin Tayt +1",feet="Luhlaza Charuqs +1"}

	sets.midcast['Blue Magic'].Buff = {main="Vampirism",sub="Vampirism",ammo="Mavi Tathlum",
		head="Luh. Keffiyeh +1",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Loquac. Earring",
		body="Assim. Jubbah +1",hands="Hashi. Bazu. +1",ring1="Prolix Ring",ring2="Dark Ring",
		back="Cornflower Cape",waist="Witful Belt",legs="Lengo Pants",feet="Luhlaza Charuqs +1"}

	sets.midcast['Blue Magic']['Battery Charge'] = set_combine(sets.midcast['Blue Magic'].Buff, {head="Amalric Coif"})
	
	sets.midcast['Blue Magic']['Carcharian Verve'] = set_combine(sets.midcast['Blue Magic'].Buff, {head="Amalric Coif",waist="Emphatikos Rope"})
	
	sets.midcast.Protect = {ring2="Sheltered Ring"}
	sets.midcast.Protectra = {ring2="Sheltered Ring"}
	sets.midcast.Shell = {ring2="Sheltered Ring"}
	sets.midcast.Shellra = {ring2="Sheltered Ring"}
	

	
	
	-- Sets to return to when not performing an action.

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {feet="Serpentes Sabots"}
	sets.NightIdle = {hands="Serpentes Cuffs"}
	
	-- Gear for learning spells: +skill and AF hands.
	sets.Learning = {hands="Assim. Bazu. +1"}

	-- Resting sets
	sets.resting = {main="Bolelabunga",sub="Genmei Shield",ammo="Falcon Eye",
			      head="Rawhide Mask",neck="Loricate Torque +1",ear1="Etiolation Earring", ear2="Ethereal Earring",
			      body="Jhakri Robe +1",hands="Serpentes Cuffs",ring1="Defending Ring",ring2="Sheltered Ring",
			      back="Bleating Mantle",waist="Flume Belt",legs="Lengo Pants",feet="Serpentes Sabots"}
	
	-- Idle sets
	sets.idle = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum",
			      head="Rawhide Mask",neck="Loricate Torque +1",ear1="Etiolation Earring", ear2="Ethereal Earring",
			      body="Jhakri Robe +1",hands="Iuitl Wristbands +1",ring1="Defending Ring",ring2="Karieyh Ring",
			      back="Umbra Cape",waist="Flume Belt",legs="Lengo Pants",feet="Battlecast Gaiters"}
	
	sets.idle.Sphere = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum",
			      head="Rawhide Mask",neck="Loricate Torque +1",ear1="Etiolation Earring", ear2="Ethereal Earring",
			      body="Mekosu. Harness",hands="Iuitl Wristbands +1",ring1="Defending Ring",ring2="Karieyh Ring",
			      back="Umbra Cape",waist="Flume Belt",legs="Lengo Pants",feet="Battlecast Gaiters"}

	sets.idle.PDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Staunch Tathlum",
				head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Etiolation Earring", ear2="Ethereal Earring",
		        body="Emet Harness +1",hands="Iuitl Wristbands +1",ring1="Defending Ring",ring2="Dark Ring",
				back="Mollusca mantle",waist="Flume Belt",legs=gear.herculean_dt_legs,feet="Battlecast Gaiters"}
				  
	-- Defense sets
	sets.defense.PDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Staunch Tathlum",
				head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Dudgeon Earring", ear2="Heartseeker Earring",
		        body="Emet Harness +1",hands="Iuitl Wristbands +1",ring1="Defending Ring",ring2="Dark Ring",
				back="Mollusca Mantle",waist="Flume Belt",legs=gear.herculean_dt_legs,feet="Battlecast Gaiters"}

	sets.defense.MDT = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring", ear2="Sanare Earring",
		        body="Emet Harness +1",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Flax Sash",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}
				
    sets.defense.MEVA = {main="Bolelabunga",sub="Genmei Shield",ammo="Staunch Tathlum",
        head="Amalric Coif",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Hashishin Mintan +1",hands="Leyline Gloves",ring1="Vengeful Ring",ring2="Purity Ring",
        back=gear.mab_jse_back,waist="Ovate Rope",legs="Telchine Braconi",feet="Telchine Pigaches"}
				
	sets.defense.NukeLock = sets.midcast['Blue Magic'].Magical

	sets.Kiting = {legs="Carmine Cuisses +1",back="Umbra Cape"}
	
    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
    sets.MP = {waist="Flume Belt",ear1="Suppanomimi", ear2="Ethereal Earring"}
    sets.MP_Knockback = {}
	sets.SuppaBrutal = {ear1="Suppanomimi", ear2="Brutal Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body="Adhemar Jacket",waist="Shetal Stone"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Assault = {ring1="Balrahn's Ring"}
	sets.Weapons = {main="Tanmogayi +1", sub="Colada"}
	sets.MagicWeapons = {main="Nibiru Cudgel", sub="Nibiru Cudgel"}
	sets.HybridWeapons = {main="Vampirism", sub="Vampirism"}
	
	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Caps with Magic Haste Cap, +5DW = Change Earrings, 10DW
	
	sets.engaged = {ammo="Ginsen",
			    head="Dampening Tam",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
			    body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
			    back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}

	sets.engaged.MinAcc = {ammo="Ginsen",
				head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Brutal Earring",
				body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
				back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
				
	sets.engaged.SomeAcc = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Telos Earring",
				body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
				back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Adhemar Kecks",feet=gear.herculean_acc_feet}
				
	sets.engaged.Acc = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
				body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
				back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Adhemar Kecks",feet=gear.herculean_acc_feet}
				
	sets.engaged.HighAcc = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
				body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Rajas Ring",
				back=gear.da_jse_back,waist="Anguinus Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
				
	sets.engaged.FullAcc = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Telos Earring",
				body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
				back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}

	sets.engaged.Fodder = {ammo="Ginsen",
			    head="Dampening Tam",neck="Ainia Collar",ear1="Dedition Earring",ear2="Brutal Earring",
			    body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
			    back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
				
	sets.engaged.Shield = {ammo="Falcon Eye",
			    head="Dampening Tam",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
			    body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Rajas Ring",
			    back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
	
	sets.engaged.PDT = {ammo="Ginsen",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Brutal Earring",
		        body="Emet Harness +1",hands="Iuitl Wristbands +1",ring1="Defending Ring",ring2="Patricius Ring",
				back="Mollusca mantle",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_ta_feet}

	sets.engaged.MinAcc.PDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Cessance Earring",
		        body="Emet Harness +1",hands="Adhemar Wristbands",ring1="Defending Ring",ring2="Patricius Ring",
				back="Mollusca mantle",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_ta_feet}
				
	sets.engaged.SomeAcc.PDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Cessance Earring",
		        body="Emet Harness +1",hands="Adhemar Wristbands",ring1="Defending Ring",ring2="Patricius Ring",
				back="Mollusca mantle",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_ta_feet}
			
	sets.engaged.Acc.PDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Cessance Earring",
				body="Emet Harness +1",hands="Adhemar Wristbands",ring1="Defending Ring",ring2="Patricius Ring",
				back="Mollusca mantle",waist="Flume Belt",legs="Adhemar Kecks",feet=gear.herculean_acc_feet}
				
	sets.engaged.HighAcc.PDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Cessance Earring",
				body="Emet Harness +1",hands="Adhemar Wristbands",ring1="Defending Ring",ring2="Patricius Ring",
				back="Mollusca mantle",waist="Flume Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
				
	sets.engaged.FullAcc.PDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Zennaroi Earring",ear2="Suppanomimi",
		        body="Emet Harness +1",hands="Adhemar Wristbands",ring1="Defending Ring",ring2="Patricius Ring",
				back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
				
	sets.engaged.Fodder.PDT = {ammo="Ginsen",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Dudgeon Earring", ear2="Heartseeker Earring",
		        body="Emet Harness +1",hands="Iuitl Wristbands +1",ring1="Defending Ring",ring2="Dark Ring",
				back="Mollusca mantle",waist="Flume Belt",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}
				
	sets.engaged.MDT = {ammo="Ginsen",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Suppanomimi",ear2="Cessance Earring",
		        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Windbuffet Belt +1",legs="Hagondes Pants +1",feet=gear.herculean_ta_feet}

	sets.engaged.MinAcc.MDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
		        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Windbuffet Belt +1",legs="Hagondes Pants +1",feet=gear.herculean_ta_feet}
				
	sets.engaged.SomeAcc.MDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring", ear2="Suppanomimi",
		        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
			
	sets.engaged.Acc.MDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring", ear2="Suppanomimi",
		        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Olseni Belt",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
				
	sets.engaged.HighAcc.MDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring", ear2="Suppanomimi",
		        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
				
	sets.engaged.FullAcc.MDT = {ammo="Falcon Eye",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Zennaroi Earring", ear2="Suppanomimi",
		        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Defending Ring",ring2="Dark Ring",
				back=gear.da_jse_back,waist="Olseni Belt",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}
				
	sets.engaged.Fodder.MDT = {ammo="Ginsen",
				head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring", ear2="Suppanomimi",
		        body="Adhemar Jacket",hands="Leyline Gloves",ring1="Defending Ring",ring2="Dark Ring",
				back="Engulfer Cape +1",waist="Windbuffet Belt +1",legs="Hagondes Pants +1",feet=gear.herculean_ta_feet}

	sets.Self_Healing = {head="Telchine Cap",neck="Phalaina Locket",hands="Buremte Gloves",legs="Gyve Trousers",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Healing_Club = {head="Telchine Cap",neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Healing_DWClub = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Healing_Club = {body="Telchine Chas."}
	sets.Healing_DWClub = {body="Telchine Chas."}
	sets.Cure_Recieved = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
	sets.MagicBurst = {body="Samnuha Coat",ring1="Mujin Band",ring2="Locus Ring"}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(4, 2)
	elseif player.sub_job == 'NIN' then
		set_macro_page(5, 2)
	elseif player.sub_job == 'WAR' then
		set_macro_page(7, 2)
	elseif player.sub_job == 'RUN' then
		set_macro_page(3, 2)
	elseif player.sub_job == 'THF' then
		set_macro_page(2, 2)
	else
		set_macro_page(6, 2)
	end
end

--Dynamis Trust Overwrite
function checktrust()
	if not moving then
		if state.AutoTrustMode.value and not areas.Cities:contains(world.area) and (buffactive['Reive Mark'] or not player.in_combat) then
			local party = windower.ffxi.get_party()
			if party.p5 == nil then
				local spell_recasts = windower.ffxi.get_spell_recasts()
			
				if spell_recasts[936] == 0 and not havetrust("Karaha-Baruha") then
					windower.send_command('input /ma "Karaha-Baruha" <me>')
					tickdelay = 1100
					return true
				elseif spell_recasts[952] == 0 and not havetrust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					tickdelay = 1100
					return true
				elseif spell_recasts[914] == 0 and not havetrust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					tickdelay = 1100
					return true
				elseif spell_recasts[989] == 0 and not havetrust("KingOfHearts") then
					windower.send_command('input /ma "King of Hearts" <me>')
					tickdelay = 1100
					return true
				elseif spell_recasts[968] == 0 and not havetrust("Adelheid") then
					windower.send_command('input /ma "Adelheid" <me>')
					tickdelay = 1100
					return true
				else
					return false
				end
			end
		end
	end
	return false
end