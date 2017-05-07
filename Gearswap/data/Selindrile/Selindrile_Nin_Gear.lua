-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None','Knockback','SuppaBrutal','DWEarrings','DWMax'}
	
	--Delete or comment out this line if you don't use Addon legs with Waltz cost-50
	waltz_tp_cost = {['Curing Waltz'] = 150, ['Curing Waltz II'] = 300, ['Curing Waltz III'] = 450, ['Curing Waltz IV'] = 600, ['Curing Waltz V'] = 750}
	
	send_command('bind ^` input /ja "Innin" <me>')
    send_command('bind !` input /ja "Yonin" <me>')
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {} --legs="Mochizuki Hakama"
    sets.precast.JA['Futae'] = {legs="Hattori Tekko"}
    sets.precast.JA['Sange'] = {} --legs="Mochizuki Chainmail"

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {legs="Desultor Tassets"}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Steelflash Earring",
        body="Mes. Haubergeon",hands="Adhemar Wristbands",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
        back="Andartia's Mantle",waist="Olseni Belt",legs="Adhemar Kecks",feet=gear.herculean_acc_feet}

    sets.precast.Flourish1 = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Mekosu. Harness",hands="Adhemar Wristbands",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
        back="Andartia's Mantle",waist="Olseni Belt",legs="Hattori Hakama +1",feet=gear.herculean_acc_feet}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",
	head="Dampening Tam",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
	body="Dread Jupon",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
	legs="Rawhide Trousers",feet="Mochi. Kyahan +1"}
		
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket",feet="Hattori Kyahan"})

    -- Snapshot for ranged
    sets.precast.RA = {hands="Iuitl Wristbands +1",legs="Nahtirah Trousers"}
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Ginsen",
        head="Lilitu Headpiece",neck="Fotia Gorget",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Apate Ring",ring2="Epona's Ring",
        back="Andartia's Mantle",waist="Fotia Belt",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {head="Dampening Tam",legs="Hiza. Hizayoroi +1",ear2="Telos Earring"})
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {head="Dampening Tam",neck="Combatant's Torque",ear2="Telos Earring",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",waist="Anguinus Belt",legs="Hiza. Hizayoroi +1"})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {head="Dampening Tam",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Telos Earring",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",waist="Olseni Belt",legs="Hiza. Hizayoroi +1"})
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {ammo="Qirmiz Tathlum",head="Adhemar Bonnet",body="Abnoba Kaftan",ring1="Begrudging Ring",waist="Wanion Belt"})
    sets.precast.WS['Blade: Jin'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {ammo="Qirmiz Tathlum",head="Ptica Headgear",body="Abnoba Kaftan",waist="Wanion Belt"})
    sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS.Acc, {head="Ptica Headgear"})
    sets.precast.WS['Blade: Jin'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Blade: Jin'].Fodder = set_combine(sets.precast.WS['Blade: Jin'], {})
	
	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {ammo="Qirmiz Tathlum",head="Adhemar Bonnet",ear1="Moonshade Earring",ear2="Brutal Earring",body="Abnoba Kaftan",ring1="Begrudging Ring"})
    sets.precast.WS['Blade: Hi'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {ammo="Qirmiz Tathlum",head="Ptica Headgear",ear1="Moonshade Earring",ear2="Trux Earring",body="Abnoba Kaftan",ring1="Begrudging Ring"})
    sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS.Acc, {ear1="Moonshade Earring",ear2="Telos Earring"})
    sets.precast.WS['Blade: Hi'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Blade: Hi'].Fodder = set_combine(sets.precast.WS['Blade: Hi'], {legs="Nahtirah Trousers"})
	
    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {head="Dampening Tam"})
    sets.precast.WS['Blade: Shun'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS.Acc, {legs="Adhemar Kecks"})
    sets.precast.WS['Blade: Shun'].FullAcc = set_combine(sets.precast.WS.FullAcc, {legs="Adhemar Kecks"})
    sets.precast.WS['Blade: Shun'].Fodder = set_combine(sets.precast.WS['Blade: Shun'], {})

    sets.precast.WS['Aeolian Edge'] = {ammo="Dosis Tathlum",
        head="Dampening Tam",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Acumen Ring",ring2="Vertigo Ring",
        back="Toro Cape",waist="Chaac Belt",legs="Manibozho Brais",feet=gear.herculean_acc_feet}
		
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Bladeborn Earring",ear2="Steelflash Earring"}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Steelflash Earring"}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head="Haruspex Hat +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Dread Jupon",hands="Mochizuki Tekko +1",ring1="Defending Ring",ring2="Prolix Ring",
        legs="Rawhide Trousers",feet=gear.herculean_acc_feet}
        
    sets.midcast.ElementalNinjutsu = {ammo="Dosis Tathlum",
        head="Dampening Tam",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Dread Jupon",hands="Mochizuki Tekko +1",ring1="Acumen Ring",ring2="Vertigo Ring",
        back="Toro Cape",waist="Chaac Belt",legs="Rawhide Trousers",feet=gear.herculean_acc_feet}

    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, {ear1="Gwati Earring",ear2="Digni. Earring",
        back="Andartia's Mantle",body="Mekosu. Harness",ring1="Vertigo Ring",ring2="Sangoma Ring",back="Andartia's Mantle"})

    sets.midcast.NinjutsuDebuff = {ammo="Dosis Tathlum",
        head="Dampening Tam",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Mekosu. Harness",hands="Mochizuki Tekko +1",ring1="Vertigo Ring",ring2="Sangoma Ring",
        back="Andartia's Mantle",waist="Chaac Belt",legs="Rawhide Trousers",feet="Mochi. Kyahan +1"}

    sets.midcast.NinjutsuBuff = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
	
    sets.midcast.Utsusemi = set_combine(sets.midcast.NinjutsuBuff, {feet="Hattori Kyahan"})

    sets.midcast.RA = {
        head="Dampening Tam",neck="Combatant's Torque",ear1="Clearview Earring",
        body="Mekosu. Harness",hands="Manibozho Gloves",ring1="Beeline Ring",ring2="Paqichikaji Ring",
        back="Andartia's Mantle",waist="Chaac Belt",legs="Nahtirah Trousers",feet="Vanir Boots"}
		
    sets.midcast.RA.Acc = {
        head="Dampening Tam",neck="Combatant's Torque",ear1="Clearview Earring",
        body="Mekosu. Harness",hands="Manibozho Gloves",ring1="Beeline Ring",ring2="Paqichikaji Ring",
        back="Andartia's Mantle",waist="Chaac Belt",legs="Nahtirah Trousers",feet="Vanir Boots"}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Solemnity Cape",waist="Flume Belt",legs="Otronif Brais +1",feet="Danzo Sune-Ate"}

    sets.idle.PDT = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Solemnity Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet="Otronif Boots +1"}
		
    sets.idle.Sphere = set_combine(sets.idle, {body="Mekosu. Harness"})
		
    sets.idle.Weak = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Solemnity Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet="Danzo Sune-Ate"}
    
    -- Defense sets
    sets.defense.Evasion = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Beeline Ring",
        back="Andartia's Mantle",waist="Shetal Stone",legs="Nahtirah Trousers",feet=gear.herculean_acc_feet}

    sets.defense.PDT = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Mollusca Mantle",waist="Flume Belt",legs=gear.herculean_dt_legs,feet="Otronif Boots +1"}

    sets.defense.MDT = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape +1",waist="Engraved Belt",legs="Otronif Brais +1",feet="Otronif Boots +1"}
		
	sets.defense.MEVA = {ammo="Ginsen",
		head="Dampening Tam",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Mekosu. Harness",hands="Leyline Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
		back="Toro Cape",waist="Engraved Belt",legs="Samnuha Tights",feet=gear.herculean_acc_feet}


    sets.Kiting = {feet="Danzo Sune-Ate"}
	sets.DuskIdle = {}
	sets.DayIdle = {}
	sets.NightIdle = {}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Mes. Haubergeon",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Andartia's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
    sets.engaged.SomeAcc = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Defiant Collar",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Mes. Haubergeon",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Andartia's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
    sets.engaged.Acc = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
        body="Mes. Haubergeon",hands="Adhemar Wristbands",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
        back="Andartia's Mantle",waist="Anguinus Belt",legs="Adhemar Kecks",feet=gear.herculean_acc_feet}
    sets.engaged.FullAcc = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Mes. Haubergeon",hands="Adhemar Wristbands",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
        back="Andartia's Mantle",waist="Olseni Belt",legs="Adhemar Kecks",feet=gear.herculean_acc_feet}
    sets.engaged.Fodder = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Ainia Collar",ear1="Dedition Earring",ear2="Brutal Earring",
        body="Mes. Haubergeon",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Andartia's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
    sets.engaged.Evasion = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Emet Harness +1",hands="Adhemar Wristbands",ring1="Beeline Ring",ring2="Epona's Ring",
        back="Andartia's Mantle",waist="Shetal Stone",legs="Nahtirah Trousers",feet=gear.herculean_acc_feet}
		sets.engaged.SomeAcc.Evasion = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Emet Harness +1",hands="Buremte Gloves",ring1="Beeline Ring",ring2="Epona's Ring",
        back="Andartia's Mantle",waist="Shetal Stone",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
    sets.engaged.Acc.Evasion = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Mekosu. Harness",hands="Buremte Gloves",ring1="Beeline Ring",ring2="Cacoethic Ring +1",
        back="Andartia's Mantle",waist="Anguinus Belt",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
    sets.engaged.FullAcc.Evasion = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Mekosu. Harness",hands="Buremte Gloves",ring1="Beeline Ring",ring2="Cacoethic Ring +1",
        back="Andartia's Mantle",waist="Anguinus Belt",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
    sets.engaged.PDT = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Epona's Ring",
        back="Mollusca Mantle",waist="Flume Belt",legs=gear.herculean_dt_legs,feet="Otronif Boots +1"}
		sets.engaged.SomeAcc.PDT = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Epona's Ring",
        back="Mollusca Mantle",waist="Flume Belt",legs=gear.herculean_dt_legs,feet="Otronif Boots +1"}
	sets.engaged.Acc.PDT = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Epona's Ring",
        back="Mollusca Mantle",waist="Flume Belt",legs=gear.herculean_dt_legs,feet="Otronif Boots +1"}
	sets.engaged.FullAcc.PDT = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Zennaroi Earring",ear2="Steelflash Earring",
        body="Emet Harness +1",hands="Otronif Gloves +1",ring1="Defending Ring",ring2="Epona's Ring",
        back="Andartia's Mantle",waist="Olseni Belt",legs=gear.herculean_dt_legs,feet="Otronif Boots +1"}
		
    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {body="Hattori Ningi +1"}
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Yonin = {legs="Hattori Hakama +1"} --
    sets.buff.Innin = {} --head="Hattori Zukin +1"
	
    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.SuppaBrutal = {ear1="Suppanomimi", ear2="Brutal Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body="Adhemar Jacket",hands="Floral Gauntlets",waist="Shetal Stone"}
	sets.Weapons = {main="Kanaria",sub="Achiuchikapu"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'RNG' then
        set_macro_page(7, 5)
    elseif player.sub_job == 'RDM' then
        set_macro_page(10, 5)
    else
        set_macro_page(10, 12)
    end
end