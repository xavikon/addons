function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','MinAcc','SlightAcc','SomeAcc','Acc','FullAcc', 'Fodder')
    state.WeaponskillMode:options('Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
    state.HybridMode:options('Normal', 'PDT','PDTOnly')
    state.PhysicalDefenseMode:options('PDT', 'HP')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None'}
	
    update_combat_form()
    update_melee_groups()

	--Delete or comment out this line if you don't use Addon legs with Waltz cost-50
	waltz_tp_cost = {['Curing Waltz'] = 150, ['Curing Waltz II'] = 300, ['Curing Waltz III'] = 450, ['Curing Waltz IV'] = 600, ['Curing Waltz V'] = 750}
	
	-- Additional local binds
	send_command('bind ^` input /ja "Boost" <me>')
	send_command('bind !` input /ja "Perfect Counter" <me>')
	send_command('bind ^backspace input /ja "Mantra" <me>')
    send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind @f10 gs c toggle FootworkWS')
	
	select_default_macro_book()
end

function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	sets.Weapons = {main="Denouements"}
	sets.ProcStaff = {main="Terra's Staff"}
	sets.ProcClub = {main="Eosuchus Club"}
    sets.Knockback = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Precast Sets
	
	-- Precast sets to enhance JAs on use
	sets.precast.JA['Hundred Fists'] = {legs="Hesychast's Hose +1"}
	sets.precast.JA['Boost'] = {} --hands="Anchorite's Gloves +1"
	sets.precast.JA['Dodge'] = {feet="Anchorite's Gaiters +1"}
	sets.precast.JA['Focus'] = {head="Anchorite's Crown +1"}
	sets.precast.JA['Counterstance'] = {} --feet="Hesychast's Gaiters +1"
	sets.precast.JA['Footwork'] = {} --feet="Tantra Gaiters +2"      lolfootwork
	sets.precast.JA['Formless Strikes'] = {body="Hesychast's Cyclas"}
	sets.precast.JA['Mantra'] = {feet="Mel. Gaiters +2"} --feet="Hesychast's Gaiters +1"

	sets.precast.JA['Chi Blast'] = {}
	
	sets.precast.JA['Chakra'] = {
		head="Dampening Tam",
		body="Emet Harness +1",hands="Hesychast's Gloves +1",
		legs="Hes. Hose +1",feet="Anch. Gaiters +1"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {legs="Desultor Tassets"}

	sets.precast.Step = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Bhikku Cyclas +1",hands="Hesychast's Gloves +1",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
		back="Anchoret's Mantle",waist="Anguinus Belt",legs="Manibozho Brais",feet=gear.herculean_acc_feet}
		
	sets.precast.Flourish1 = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Mekosu. Harness",hands="Hesychast's Gloves +1",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
		back="Anchoret's Mantle",waist="Anguinus Belt",legs="Manibozho Brais",feet=gear.herculean_acc_feet}


	-- Fast cast sets for spells
	
	sets.precast.FC = {ammo="Impatiens",
	head="Haruspex Hat +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
	body="Dread Jupon",hands="Leyline Gloves",ring2="Lebeche Ring",ring2="Prolix Ring",
	legs="Kaabnax Trousers"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})

       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Ginsen",
		head="Dampening Tam",neck="Fotia Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Dread Jupon",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Fotia Belt",legs="Tatena. Haidate +1",feet=gear.herculean_acc_feet}
	sets.precast.WSMinAcc = {}
	sets.precast.WSSomeAcc = {ammo="Falcon Eye",hands="Hesychast's Gloves +1",back="Letalis Mantle"}
	sets.precast.WSAcc = {ammo="Falcon Eye",head="Dampening Tam",neck="Combatant's Torque",body="Bhikku Cyclas +1",hands="Hesychast's Gloves +1",ring2="Cacoethic Ring +1",waist="Anguinus Belt",back="Letalis Mantle",feet=gear.herculean_acc_feet}
	sets.precast.WSFullAcc = {ammo="Falcon Eye",head="Dampening Tam",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Steelflash Earring",body="Bhikku Cyclas +1",hands="Hesychast's Gloves +1",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",back="Anchoret's Mantle",waist="Olseni Belt",feet=gear.herculean_acc_feet}
	sets.precast.WSFodder = {ear1="Trux Earring", ear2="Brutal Earring",body="Adhemar Jacket"}
	sets.precast.WS.MinAcc = set_combine(sets.precast.WS, sets.precast.WSMinAcc)	
	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, sets.precast.WSSomeAcc)	
	sets.precast.WS.Acc = set_combine(sets.precast.WS, sets.precast.WSAcc)
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, sets.precast.WSFullAcc)
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, sets.precast.WSFodder)

	-- Specific weaponskill sets.

	sets.precast.WS['Raging Fists']    = set_combine(sets.precast.WS, {waist="Wanion Belt"})
	sets.precast.WS['Howling Fist']    = set_combine(sets.precast.WS, {head="Lilitu Headpiece"})
	sets.precast.WS['Asuran Fists']    = set_combine(sets.precast.WS, {waist="Wanion Belt"})
	sets.precast.WS["Ascetic's Fury"]  = set_combine(sets.precast.WS, {head="Adhemar Bonnet",neck="Rancor Collar",back="Buquwik Cape",waist="Wanion Belt"})
	sets.precast.WS["Victory Smite"]   = set_combine(sets.precast.WS, {head="Adhemar Bonnet",neck="Rancor Collar",ear1="Moonshade Earring",ear2="Brutal Earring",back="Buquwik Cape",waist="Wanion Belt"})
	sets.precast.WS['Shijin Spiral']   = set_combine(sets.precast.WS, {head="Dampening Tam"})
	sets.precast.WS['Dragon Kick']     = set_combine(sets.precast.WS, {waist="Wanion Belt"})
	sets.precast.WS['Tornado Kick']    = set_combine(sets.precast.WS, {ring1="Spiral Ring"})
	sets.precast.WS['Spinning Attack'] = set_combine(sets.precast.WS, {waist="Wanion Belt"})

	sets.precast.WS["Raging Fists"].MinAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSMinAcc)
	sets.precast.WS["Howling Fist"].MinAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSMinAcc)
	sets.precast.WS["Asuran Fists"].MinAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSMinAcc)
	sets.precast.WS["Ascetic's Fury"].MinAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSMinAcc, {head="Adhemar Bonnet",neck="Rancor Collar",back="Buquwik Cape",waist="Wanion Belt"})
	sets.precast.WS["Victory Smite"].MinAcc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSMinAcc, {head="Adhemar Bonnet",neck="Rancor Collar",ear1="Moonshade Earring",ear2="Brutal Earring",back="Buquwik Cape",waist="Wanion Belt"})
	sets.precast.WS["Shijin Spiral"].MinAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSMinAcc, {})
	sets.precast.WS["Dragon Kick"].MinAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSMinAcc)
	sets.precast.WS["Tornado Kick"].MinAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSMinAcc)
	
	sets.precast.WS["Raging Fists"].SomeAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSSomeAcc)
	sets.precast.WS["Howling Fist"].SomeAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSSomeAcc)
	sets.precast.WS["Asuran Fists"].SomeAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSSomeAcc)
	sets.precast.WS["Ascetic's Fury"].SomeAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSSomeAcc, {head="Ptica Headgear",neck="Rancor Collar"})
	sets.precast.WS["Victory Smite"].SomeAcc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSSomeAcc, {head="Ptica Headgear",neck="Rancor Collar",ear1="Moonshade Earring",ear2="Brutal Earring"})
	sets.precast.WS["Shijin Spiral"].SomeAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSSomeAcc, {})
	sets.precast.WS["Dragon Kick"].SomeAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSSomeAcc)
	sets.precast.WS["Tornado Kick"].SomeAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSSomeAcc)
	
	sets.precast.WS["Raging Fists"].Acc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
	sets.precast.WS["Howling Fist"].Acc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
	sets.precast.WS["Asuran Fists"].Acc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
	sets.precast.WS["Ascetic's Fury"].Acc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc, {head="Ptica Headgear",neck="Rancor Collar"})
	sets.precast.WS["Victory Smite"].Acc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc, {head="Ptica Headgear",neck="Rancor Collar",ear1="Zennaroi Earring",ear2="Moonshade Earring",})
	sets.precast.WS["Shijin Spiral"].Acc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
	sets.precast.WS["Dragon Kick"].Acc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
	sets.precast.WS["Tornado Kick"].Acc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

	sets.precast.WS["Raging Fists"].FullAcc = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSFullAcc)
	sets.precast.WS["Howling Fist"].FullAcc = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSFullAcc)
	sets.precast.WS["Asuran Fists"].FullAcc = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSFullAcc)
	sets.precast.WS["Ascetic's Fury"].FullAcc = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSFullAcc, {head="Ptica Headgear",neck="Rancor Collar"})
	sets.precast.WS["Victory Smite"].FullAcc = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSFullAcc, {head="Ptica Headgear",neck="Rancor Collar"})
	sets.precast.WS["Shijin Spiral"].FullAcc = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSFullAcc)
	sets.precast.WS["Dragon Kick"].FullAcc = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSFullAcc)
	sets.precast.WS["Tornado Kick"].FullAcc = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSFullAcc)
	
	sets.precast.WS["Raging Fists"].Fodder = set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSFodder)
	sets.precast.WS["Howling Fist"].Fodder = set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSFodder)
	sets.precast.WS["Asuran Fists"].Fodder = set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSFodder)
	sets.precast.WS["Ascetic's Fury"].Fodder = set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSFodder, {head="Adhemar Bonnet",neck="Rancor Collar",back="Buquwik Cape",waist="Wanion Belt"})
	sets.precast.WS["Victory Smite"].Fodder = set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSFodder, {head="Adhemar Bonnet",neck="Rancor Collar",ear1="Moonshade Earring",ear2="Brutal Earring",back="Buquwik Cape",waist="Wanion Belt"})
	sets.precast.WS["Shijin Spiral"].Fodder = set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSFodder)
	sets.precast.WS["Dragon Kick"].Fodder = set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSFodder)
	sets.precast.WS["Tornado Kick"].Fodder = set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSFodder)


	sets.precast.WS['Cataclysm'] = {ammo="Dosis Tathlum",
		neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
		hands="Otronif Gloves +1",ring1="Acumen Ring",
		back="Toro Cape",legs="Nahtirah Trousers"}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Bladeborn Earring",ear2="Steelflash Earring"}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Steelflash Earring"}
	
	-- Midcast Sets
	sets.midcast.FastRecast = {ammo="Staunch Tathlum",
		head="Haruspex Hat +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Dread Jupon",hands="Leyline Gloves",ring2="Defending Ring",ring2="Prolix Ring",
		back="Mollusca Mantle",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
		
	-- Specific spells
	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
		
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {body="Hesychast's Cyclas",ring2="Sheltered Ring"}
	

	-- Idle sets
	sets.idle = {ammo="Staunch Tathlum",
		head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Sheltered Ring",
		back="Solemnity Cape",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}

	sets.idle.Weak = {ammo="Staunch Tathlum",
		head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Hesychast's Cyclas",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Sheltered Ring",
		back="Solemnity Cape",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	
	-- Defense sets
	sets.defense.PDT = {ammo="Staunch Tathlum",
		head="Genmei Kabuto",neck="Loricate Torque +1",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
		
	-- Defense sets
	sets.defense.HP = {ammo="Staunch Tathlum",
		head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Anchoret's Mantle",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}

	sets.defense.MDT = {ammo="Staunch Tathlum",
		head="Dampening Tam",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Shadow Ring",
		back="Mollusca Mantle",waist="Flax Sash",legs="Otronif Brais +1",feet="Otronif Boots +1"}
		
	sets.defense.MEVA = {ammo="Staunch Tathlum",
		head=empty,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Respite Cloak",hands="Leyline Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
		back="Toro Cape",waist="Flax Sash",legs="Samnuha Tights",feet=gear.herculean_acc_feet}

	sets.Kiting = {feet="Herald's Gaiters",back="Solemnity Cape"}

	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee sets
	sets.engaged = {ammo="Ginsen",
		head="Dampening Tam",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
	sets.engaged.MinAcc = {ammo="Ginsen",
		head="Dampening Tam",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Adhemar Jacket",hands="Hesychast's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Windbuffet Belt +1",legs="Hesychast's Hose +1",feet="Soku. Sune-Ate"}
	sets.engaged.SlightAcc = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Adhemar Jacket",hands="Hesychast's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Windbuffet Belt +1",legs="Hesychast's Hose +1",feet="Soku. Sune-Ate"}
	sets.engaged.SomeAcc = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Bhikku Cyclas +1",hands="Hesychast's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Hesychast's Hose +1",feet="Soku. Sune-Ate"}
	sets.engaged.Acc = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Bhikku Cyclas +1",hands="Hesychast's Gloves +1",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
	sets.engaged.FullAcc = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Steelflash Earring",
		body="Bhikku Cyclas +1",hands="Hesychast's Gloves +1",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
		back="Anchoret's Mantle",waist="Olseni Belt",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
	sets.engaged.Fodder = {ammo="Ginsen",
		head="Dampening Tam",neck="Asperity Necklace",ear1="Trux Earring", ear2="Brutal Earring",
		body="Bhikku Cyclas +1",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Hesychast's Hose +1",feet="Soku. Sune-Ate"}

	-- Defensive melee hybrid sets
	sets.engaged.PDT = {ammo="Ginsen",
		head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.MinAcc.PDT = {ammo="Ginsen",
		head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.SlightAcc.PDT = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.SomeAcc.PDT = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.Acc.PDT = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Patricius Ring",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.FullAcc.PDT = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Steelflash Earring",
		body="Bhikku Cyclas +1",hands="Hesychast's Gloves +1",ring1="Defending Ring",ring2="Patricius Ring",
		back="Letalis Mantle",waist="Olseni Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.Fodder.PDT = {ammo="Staunch Tathlum",
		head="Genmei Kabuto",neck="Loricate Torque +1",ear1="Trux Earring", ear2="Brutal Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.PDTOnly = {ammo="Ginsen",
		head="Genmei Kabuto",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Emet Harness +1",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Patricius Ring",
		back="Solemnity Cape",waist="Black Belt",legs="Hesychast's Hose +1",feet="Soku. Sune-Ate"}
	sets.engaged.MinAcc.PDTOnly = {ammo="Ginsen",
		head="Genmei Kabuto",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Emet Harness +1",hands="Adhemar Wristbands",ring1="Rajas Ring",ring2="Patricius Ring",
		back="Solemnity Cape",waist="Black Belt",legs="Hesychast's Hose +1",feet="Soku. Sune-Ate"}
	sets.engaged.SlightAcc.PDTOnly = {ammo="Ginsen",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Emet Harness +1",hands="Hes. Gloves +1",ring1="Rajas Ring",ring2="Patricius Ring",
		back="Solemnity Cape",waist="Black Belt",legs="Hesychast's Hose +1",feet="Soku. Sune-Ate"}
	sets.engaged.SomeAcc.PDTOnly = {ammo="Ginsen",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Emet Harness +1",hands="Hes. Gloves +1",ring1="Rajas Ring",ring2="Patricius Ring",
		back="Solemnity Cape",waist="Black Belt",legs="Hesychast's Hose +1",feet="Soku. Sune-Ate"}
	sets.engaged.Acc.PDTOnly = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Emet Harness +1",hands="Hesychast's Gloves +1",ring1="Rajas Ring",ring2="Patricius Ring",
		back="Solemnity Cape",waist="Black Belt",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
	sets.engaged.FullAcc.PDTOnly = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Steelflash Earring",
		body="Emet Harness +1",hands="Hesychast's Gloves +1",ring1="Cacoethic Ring",ring2="Patricius Ring",
		back="Solemnity Cape",waist="Black Belt",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
	sets.engaged.Counter = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="K'ayres Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Otronif Brais +1",feet="Otronif Boots +1"}
	sets.engaged.Acc.Counter = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Mollusca Mantle",waist="Black Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}

	-- Hundred Fists/Impetus melee set mods
	
	sets.engaged.HF = set_combine(sets.engaged, {})
	sets.engaged.MinAcc.HF = set_combine(sets.engaged.MinAcc, {})
	sets.engaged.SlightAcc.HF = set_combine(sets.engaged.SlightAcc, {})
	sets.engaged.SomeAcc.HF = set_combine(sets.engaged.SomeAcc, {})
	sets.engaged.Acc.HF = set_combine(sets.engaged.Acc, {})
	sets.engaged.FullAcc.HF = set_combine(sets.engaged.FullAcc, {})
	sets.engaged.Fodder.HF = set_combine(sets.engaged.Fodder, {})

	sets.engaged.Impetus = set_combine(sets.engaged, {body="Bhikku Cyclas +1"})
	sets.engaged.MinAcc.Impetus = set_combine(sets.engaged.MinAcc, {body="Bhikku Cyclas +1"})
	sets.engaged.SlightAcc.Impetus = set_combine(sets.engaged.SlightAcc, {body="Bhikku Cyclas +1"})
	sets.engaged.SomeAcc.Impetus = set_combine(sets.engaged.SomeAcc, {body="Bhikku Cyclas +1"})
	sets.engaged.Acc.Impetus = set_combine(sets.engaged.Acc, {body="Bhikku Cyclas +1"})
	sets.engaged.FullAcc.Impetus = set_combine(sets.engaged.FullAcc, {body="Bhikku Cyclas +1"})
	sets.engaged.Fodder.Impetus = set_combine(sets.engaged.Fodder, {body="Bhikku Cyclas +1"})
	
	sets.engaged.HF.Impetus = set_combine(sets.engaged, {body="Bhikku Cyclas +1"})
	sets.engaged.MinAcc.HF.Impetus = set_combine(sets.engaged.MinAcc, {body="Bhikku Cyclas +1"})
	sets.engaged.SlightAcc.HF.Impetus = set_combine(sets.engaged.SlightAcc, {body="Bhikku Cyclas +1"})
	sets.engaged.SomeAcc.HF.Impetus = set_combine(sets.engaged.SomeAcc, {body="Bhikku Cyclas +1"})
	sets.engaged.Acc.HF.Impetus = set_combine(sets.engaged.Acc, {body="Bhikku Cyclas +1"})
	sets.engaged.FullAcc.HF.Impetus = set_combine(sets.engaged.FullAcc, {body="Bhikku Cyclas +1"})
	sets.engaged.Fodder.HF.Impetus = set_combine(sets.engaged.Fodder, {body="Bhikku Cyclas +1"})

	sets.engaged.Counter.HF = set_combine(sets.engaged.Counter, {})
	sets.engaged.Counter.HF.Impetus = set_combine(sets.engaged.Counter, {body="Bhikku Cyclas +1"})
	sets.engaged.Acc.Counter.HF = set_combine(sets.engaged.Acc.Counter, {})
	sets.engaged.Acc.Counter.HF.Impetus = set_combine(sets.engaged.Acc.Counter, {body="Bhikku Cyclas +1"})


	-- Footwork combat form
	sets.engaged.Footwork = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Adhemar Jacket",hands="Hesychast's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
		back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Hesychast's Hose +1",feet="Soku. Sune-Ate"}
	sets.engaged.Footwork.Acc = {ammo="Falcon Eye",
		head="Dampening Tam",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Bhikku Cyclas +1",hands="Hesychast's Gloves +1",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
		back="Letalis Mantle",waist="Anguinus Belt",legs="Manibozho Brais",feet=gear.herculean_acc_feet}
		
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
		
	-- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
	sets.impetus_body = {body="Bhikku Cyclas +1"}
	sets.footwork_kick_feet = {feet="Soku. Sune-Ate"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(5, 20)
	elseif player.sub_job == 'NIN' then
		set_macro_page(4, 20)
	elseif player.sub_job == 'THF' then
		set_macro_page(6, 20)
	elseif player.sub_job == 'RUN' then
		set_macro_page(7, 20)
	else
		set_macro_page(6, 20)
	end
end