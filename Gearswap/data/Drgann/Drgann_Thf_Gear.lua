-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal','PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
	state.IdleMode:options('Normal', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'SuppaBrutal', 'DAEarrings', 'DWEarrings', 'DWMax'}
	state.AmbushMode = M(false, 'Ambush Mode')

	gear.da_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	gear.ws_jse_back = {name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}

	--Delete or comment out this line if you don't use Addon legs with Waltz cost-50
	waltz_tp_cost = {['Curing Waltz'] = 150, ['Curing Waltz II'] = 300, ['Curing Waltz III'] = 450, ['Curing Waltz IV'] = 600, ['Curing Waltz V'] = 750}
		
    -- Additional local binds
    send_command('bind ^` input /ja "Flee" <me>')
    send_command('bind !` input /ra <t>')
    send_command('bind !- gs c cycle targetmode')
	send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind @f10 gs c toggle AmbushMode')
	send_command('bind ^backspace gs equip sets.Throwing')
	send_command('bind !backspace input /ja "Hide" <me>')
	send_command('bind !r gs equip sets.MagicWeapons;gs c update user')
	send_command('bind !q gs equip sets.FodderWeapons;gs c update user')
	send_command('bind ^\\\\ input /ja "Despoil" <t>')
	send_command('bind !\\\\ input /ja "Mug" <t>')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Special sets (required by rules)
    --------------------------------------

	sets.TreasureHunter = set_combine(sets.TreasureHunter, {hands="Plunderer's Armlets +1",feet="Skulk. Poulaines +1"})
    sets.ExtraRegen = {}
    sets.Kiting = {back="Solemnity Cape",feet="Skadi's Jambeaux +1"}

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	
    sets.buff['Sneak Attack'] = {}
    sets.buff['Trick Attack'] = {}
		
    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.SuppaBrutal = {ear1="Brutal Earring", ear2="Suppanomimi"}
	sets.Weapons = {main="Taming Sari",sub="Taming Sari"}
	sets.MagicWeapons = {main="Malevolence",sub="Malevolence"}
	sets.FodderWeapons = {main="Atoyac",sub="Jugo Kukri +1"}
	sets.Throwing = {range="Raider's Bmrng."}
	sets.DAEarrings = {ear1="Bladeborn Earring",ear2="Steelflash Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body="Adhemar Jacket",hands="Floral Gauntlets",waist="Shetal Stone"}
	sets.Ambush = {} --body="Plunderer's Vest +1"
	
    -- Actions we want to use to tag TH.
    sets.precast.Step = set_combine(sets.engaged.FullAcc, sets.TreasureHunter)
    sets.precast.JA['Violent Flourish'] = set_combine(sets.engaged.FullAcc, sets.TreasureHunter)
    sets.precast.JA.Provoke = sets.TreasureHunter

    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Collaborator'] = {} --head="Skulker's Bonnet"
    sets.precast.JA['Accomplice'] = {} --head="Skulker's Bonnet"
    sets.precast.JA['Flee'] = {} --feet="Pillager's Poulaines +1"
    sets.precast.JA['Hide'] = {} --body="Pillager's Vest +1"
    sets.precast.JA['Conspirator'] = {} --body="Skulker's Vest"
    sets.precast.JA['Steal'] = {hands="Pill. Armlets +1"}
	sets.precast.JA['Mug'] = {}
    sets.precast.JA['Despoil'] = {legs="Skulker's Culottes",feet="Skulk. Poulaines +1"}
    sets.precast.JA['Perfect Dodge'] = {hands="Plunderer's Armlets +1"}
    sets.precast.JA['Feint'] = {} -- {legs="Assassin's Culottes +2"}

    sets.precast.JA['Sneak Attack'] = sets.buff['Sneak Attack']
    sets.precast.JA['Trick Attack'] = sets.buff['Trick Attack']


    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Haruspex Hat +1",ear1="Handler's Earring +1",
        body="Passion Jacket",hands="Slither Gloves +1",ring1="Asklepian Ring",ring2="Valseur's Ring",
        back="Mollusca Mantle",waist="Chaac Belt",legs="Desultor Tassets",feet="Rawhide Boots"}

    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {legs="Desultor Tassets"}


    -- Fast cast sets for spells
    sets.precast.FC = {ammo="Impatiens",
	head="Haruspex Hat +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
	body="Dread Jupon",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
	legs="Rawhide Trousers"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


    -- Ranged snapshot gear
    sets.precast.RA = {hands="Iuitl Wristbands +1",legs="Adhemar Kecks"}


    -- Weaponskill sets

    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Falcon Eye",
        head="Dampening Tam",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
        back=gear.da_jse_back,waist="Wanion Belt",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque",hands="Meg. Gloves +1"})
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {neck="Combatant's Torque",ear1="Telos Earring",ear2="Domin. Earring +1",body="Meg. Cuirie +1",hands="Meg. Gloves +1",waist="Anguinus Belt",legs="Meg. Chausses +1"})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {neck="Combatant's Torque",ear1="Telos Earring",ear2="Domin. Earring +1",body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",waist="Olseni Belt",legs="Meg. Chausses +1"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Karieyh Ring",ring2="Apate Ring",back=gear.ws_jse_back})
    sets.precast.WS["Rudra's Storm"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Domin. Earring +1",ear2="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Karieyh Ring",ring2="Apate Ring",back=gear.ws_jse_back})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS.Acc, {ear2="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Karieyh Ring",ring2="Apate Ring",back=gear.ws_jse_back})
	sets.precast.WS["Rudra's Storm"].FullAcc = set_combine(sets.precast.WS.FullAcc, {back=gear.ws_jse_back})
    sets.precast.WS["Rudra's Storm"].Fodder = set_combine(sets.precast.WS["Rudra's Storm"], {})
    sets.precast.WS["Rudra's Storm"].SA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {ammo="Qirmiz Tathlum",head="Adhemar Bonnet",legs="Darraigner's Brais"})
    sets.precast.WS["Rudra's Storm"].TA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {ammo="Qirmiz Tathlum",head="Adhemar Bonnet",legs="Darraigner's Brais"})
    sets.precast.WS["Rudra's Storm"].SATA = set_combine(sets.precast.WS["Rudra's Storm"].Fodder, {ammo="Qirmiz Tathlum",head="Adhemar Bonnet",legs="Darraigner's Brais"})
	
    sets.precast.WS["Mandalic Stab"] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Karieyh Ring",ring2="Apate Ring",back=gear.ws_jse_back})
    sets.precast.WS["Mandalic Stab"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Domin. Earring +1",ear2="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Karieyh Ring",ring2="Apate Ring",back=gear.ws_jse_back})
    sets.precast.WS["Mandalic Stab"].Acc = set_combine(sets.precast.WS.Acc, {ear2="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Karieyh Ring",ring2="Apate Ring",back=gear.ws_jse_back})
	sets.precast.WS["Mandalic Stab"].FullAcc = set_combine(sets.precast.WS.FullAcc, {back=gear.ws_jse_back})
    sets.precast.WS["Mandalic Stab"].Fodder = set_combine(sets.precast.WS["Mandalic Stab"], {})
    sets.precast.WS["Mandalic Stab"].SA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {ammo="Qirmiz Tathlum",head="Adhemar Bonnet",legs="Darraigner's Brais"})
    sets.precast.WS["Mandalic Stab"].TA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {ammo="Qirmiz Tathlum",head="Adhemar Bonnet",legs="Darraigner's Brais"})
    sets.precast.WS["Mandalic Stab"].SATA = set_combine(sets.precast.WS["Mandalic Stab"].Fodder, {ammo="Qirmiz Tathlum",head="Adhemar Bonnet",legs="Darraigner's Brais"})
	
    sets.precast.WS["Shark Bite"] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Ishvara Earring",ear2="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Karieyh Ring",ring2="Apate Ring",back=gear.ws_jse_back})
    sets.precast.WS["Shark Bite"].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Lilitu Headpiece",neck="Caro Necklace",ear1="Domin. Earring +1",ear2="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Karieyh Ring",ring2="Apate Ring",back=gear.ws_jse_back})
    sets.precast.WS["Shark Bite"].Acc = set_combine(sets.precast.WS.Acc, {ear2="Moonshade Earring",body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Karieyh Ring",ring2="Apate Ring",back=gear.ws_jse_back})
	sets.precast.WS["Shark Bite"].FullAcc = set_combine(sets.precast.WS.FullAcc, {back=gear.ws_jse_back})
    sets.precast.WS["Shark Bite"].Fodder = set_combine(sets.precast.WS["Shark Bite"], {})
    sets.precast.WS["Shark Bite"].SA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Qirmiz Tathlum",head="Adhemar Bonnet",legs="Darraigner's Brais"})
    sets.precast.WS["Shark Bite"].TA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Qirmiz Tathlum",head="Adhemar Bonnet",legs="Darraigner's Brais"})
    sets.precast.WS["Shark Bite"].SATA = set_combine(sets.precast.WS["Shark Bite"].Fodder, {ammo="Qirmiz Tathlum",head="Adhemar Bonnet",legs="Darraigner's Brais"})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {ammo="Qirmiz Tathlum",head="Adhemar Bonnet",neck="Fotia Gorget",body="Abnoba Kaftan",ring1="Begrudging Ring",waist="Fotia Belt",legs="Darraigner's Brais"})
    sets.precast.WS['Evisceration'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {head="Adhemar Bonnet",neck="Fotia Gorget",body="Abnoba Kaftan",ring1="Begrudging Ring",waist="Fotia Belt"})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS.Acc, {ring1="Begrudging Ring",neck="Fotia Gorget",waist="Fotia Belt"})
	sets.precast.WS['Evisceration'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
	sets.precast.WS['Evisceration'].Fodder = set_combine(sets.precast.WS['Evisceration'], {})
    sets.precast.WS['Evisceration'].SA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})
    sets.precast.WS['Evisceration'].TA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})
    sets.precast.WS['Evisceration'].SATA = set_combine(sets.precast.WS['Evisceration'].Fodder, {})
	
    sets.precast.WS['Last Stand'] = {
        head="Adhemar Bonnet",neck="Fotia Gorget",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
        back=gear.ws_jse_back,waist="Fotia Belt",legs="Meg. Chausses +1",feet="Vanir Boots"}
		
    sets.precast.WS['Last Stand'].SomeAcc = {
        head="Umbani Cap",neck="Fotia Gorget",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
        back=gear.ws_jse_back,waist="Fotia Belt",legs="Meg. Chausses +1",feet="Vanir Boots"}
		
    sets.precast.WS['Last Stand'].Acc = {
        head="Umbani Cap",neck="Combatant's Torque",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
        back="Libeccio Mantle",waist="Fotia Belt",legs="Meg. Chausses +1",feet="Vanir Boots"}
		
    sets.precast.WS['Last Stand'].FullAcc = {
        head="Umbani Cap",neck="Combatant's Torque",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
        back="Libeccio Mantle",waist="Fotia Belt",legs="Meg. Chausses +1",feet="Vanir Boots"}

    sets.precast.WS['Aeolian Edge'] = {ammo="Seeth. Bomblet +1",
        head="Herculean Helm",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Karieyh Ring",ring2="Acumen Ring",
        back=gear.ws_jse_back,waist="Chaac Belt",legs="Darraigner's Brais",feet=gear.herculean_acc_feet}

    sets.precast.WS['Aeolian Edge'].TH = set_combine(sets.precast.WS['Aeolian Edge'], sets.TreasureHunter)

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Ishvara Earring",ear2="Domin. Earring +1"}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Domin. Earring +1"}
	
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head="Haruspex Hat +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
        back="Mollusca Mantle",waist="Hurch'lan Sash",legs="Rawhide Trousers",feet=gear.herculean_acc_feet}

    -- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
	
	sets.midcast.Dia = set_combine(sets.midcast.FastRecast, sets.TreasureHunter)
	
    -- Ranged gear

    sets.midcast.RA = {
        head="Umbani Cap",neck="Combatant's Torque",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
        back="Libeccio Mantle",waist="Chaac Belt",legs="Meg. Chausses +1",feet="Vanir Boots"}

    sets.midcast.RA.Acc = {
        head="Umbani Cap",neck="Combatant's Torque",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
        back="Libeccio Mantle",waist="Flax Sash",legs="Meg. Chausses +1",feet="Vanir Boots"}

    --------------------------------------
    -- Idle/resting/defense sets
    --------------------------------------

    -- Resting sets
    sets.resting = {}

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)

    sets.idle = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Solemnity Cape",waist="Flume Belt",legs="Meg. Chausses +1",feet=gear.herculean_acc_feet}
		
    sets.idle.Sphere = set_combine(sets.idle, {body="Mekosu. Harness"})

    sets.idle.Weak = set_combine(sets.idle, {})

	sets.DayIdle = {}
	sets.NightIdle = {}

    -- Defense sets

    sets.defense.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +1",hands="Iuitl Wristbands +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Mollusca Mantle",waist="Flume Belt",legs="Meg. Chausses +1",feet=gear.herculean_acc_feet}

    sets.defense.MDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +1",hands="Floral Gauntlets",ring1="Defending Ring",ring2="Dark Ring",
        back="Engulfer Cape +1",waist="Engraved Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_acc_feet}
		
	sets.defense.MEVA = {ammo="Staunch Tathlum",
		head="Haruspex Hat +1",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Adhemar Jacket",hands="Leyline Gloves",ring1="Vengeful Ring",ring2="Purity Ring",
		back="Mujin Mantle",waist="Engraved Belt",legs="Adhemar Kecks",feet=gear.herculean_acc_feet}


    --------------------------------------
    -- Melee sets  
    --------------------------------------

    -- Normal melee group
    sets.engaged = {ammo="Ginsen",
        head="Dampening Tam",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Adhemar Jacket",hands="Floral Gauntlets",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
		
    sets.engaged.SomeAcc = {ammo="Ginsen",
        head="Dampening Tam",neck="Defiant Collar",ear1="Brutal Earring",ear2="Suppanomimi",
        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
    
	sets.engaged.Acc = {ammo="Seeth. Bomblet +1",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Telos Earring",ear2="Cessance Earring",
        body="Adhemar Jacket",hands="Floral Gauntlets",ring1="Rajas Ring",ring2="Epona's Ring",
        back=gear.da_jse_back,waist="Anguinus Belt",legs="Meg. Chausses +1",feet=gear.herculean_acc_feet}
		
    sets.engaged.FullAcc = {ammo="Falcon Eye",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Telos Earring",ear2="Digni. Earring",
        body="Adhemar Jacket",hands="Floral Gauntlets",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
        back=gear.da_jse_back,waist="Olseni Belt",legs="Adhemar Kecks",feet=gear.herculean_acc_feet}

    sets.engaged.Fodder = {ammo="Ginsen",
        head="Dampening Tam",neck="Ainia Collar",ear1="Brutal Earring",ear2="Dedition Earring",
        body="Adhemar Jacket",hands="Floral Gauntlets",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.da_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_acc_feet}

    -- Mod set for trivial mobs (Thaumas)
    sets.engaged.Fodder2 = {ammo="Ginsen",
        head="Dampening Tam",neck="Ainia Collar",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Adhemar Jacket",hands="Floral Gauntlets",ring1="Petrov Ring",ring2="Epona's Ring",
        back=gear.da_jse_back,waist="Shetal Stone",legs="Samnuha Tights",feet=gear.herculean_acc_feet}

    sets.engaged.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Mollusca Mantle",waist="Flume Belt",legs="Meg. Chausses +1",feet=gear.herculean_acc_feet}

    sets.engaged.SomeAcc.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Defending Ring",ring2="Patricius Ring",
        back="Mollusca Mantle",waist="Flume Belt",legs="Meg. Chausses +1",feet=gear.herculean_acc_feet}
		
    sets.engaged.Acc.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Defending Ring",ring2="Patricius Ring",
        back="Mollusca Mantle",waist="Flume Belt",legs="Meg. Chausses +1",feet=gear.herculean_acc_feet}

    sets.engaged.FullAcc.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Defending Ring",ring2="Patricius Ring",
        back="Mollusca Mantle",waist="Olseni Belt",legs="Meg. Chausses +1",feet=gear.herculean_acc_feet}
		
    sets.engaged.Fodder.PDT = {ammo="Staunch Tathlum",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Mollusca Mantle",waist="Flume Belt",legs="Meg. Chausses +1",feet=gear.herculean_acc_feet}
		
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(8, 5)
    elseif player.sub_job == 'WAR' then
        set_macro_page(7, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(10, 5)
    else
        set_macro_page(6, 5)
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
					return true
				elseif spell_recasts[952] == 0 and not havetrust("Koru-Moru") then
					windower.send_command('input /ma "Koru-Moru" <me>')
					return true
				elseif spell_recasts[914] == 0 and not havetrust("Ulmia") then
					windower.send_command('input /ma "Ulmia" <me>')
					return true
				elseif spell_recasts[989] == 0 and not havetrust("KingofHearts") then
					windower.send_command('input /ma "King of Hearts" <me>')
					return true
				elseif spell_recasts[968] == 0 and not havetrust("Adelheid") then
					windower.send_command('input /ma "Adelheid" <me>')
					return true
				else
					return false
				end
			end
		end
	end
	return false
end