function user_setup()

    -- Options: Override default values	
	state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Tank', 'DDTank', 'BreathTank', 'NoShellTank', 'Reraise', 'Normal')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'PDT_HP', 'PDT_Reraise', 'Tank')
    state.MagicalDefenseMode:options('BDT','AegisMDT','AegisNoShellMDT','OchainMDT','OchainNoShellMDT','MDT_HP','MDT_Reraise')
	state.ResistDefenseMode:options('MEVA', 'Death','Charm')
	state.IdleMode:options('Normal', 'Tank', 'PDT', 'MDT', 'Refresh', 'Reraise')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Twilight'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')

    update_defense_mode()

	--Delete or comment out this line if you don't use Addon legs with Waltz cost-50
--	waltz_tp_cost = {['Curing Waltz'] = 150, ['Curing Waltz II'] = 300, ['Curing Waltz III'] = 450, ['Curing Waltz IV'] = 600, ['Curing Waltz V'] = 750}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind ^backspace input /ja "Shield Bash" <t>')
	send_command('bind @backspace input /ja "Cover" <stpt>')
	send_command('bind !backspace input /ja "Sentinel" <me>')
	send_command('bind @= input /ja "Chivalry" <me>')
	send_command('bind != input /ja "Palisade" <me>')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind @pause gs c toggle AutoRuneMode')
	send_command('bind @f8 gs c toggle AutoTankMode')
	
    select_default_macro_book()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
    sets.Enmity = {ammo="Paeapua",
        head="Loess Barbuta +1",neck="Unmoving Collar +1",ear1="Enchntr. Earring +1",ear2="Cessance Earring",
        body="Souveran Cuirass",hands="Macabre Gaunt. +1",ring1="Defending Ring",ring2="Vengeful Ring",
        back="Fierabras's Mantle",waist="Creed Baudrier",legs="Cab. Breeches +1",feet="Eschite Greaves"}
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity,{feet="Rev. Leggings +1"})
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity,{feet="Cab. Leggings +1"})
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity,{}) --head="Valor Coronet" (Also Vit?)
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity,{body="Cab. Surcoat +1"})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity,{feet="Chev. Sabatons +1"})
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, {head="Rev. Coronet +1",body="Cab. Surcoat +1"})
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
		head="Rev. Coronet +1",neck="Phalaina Locket",ear1="Etiolation Earring",ear2="Nourish. Earring +1",
		body="Found. Breastplate",hands="Cab. Gauntlets +1",ring1="Vertigo Ring",ring2="Rufescent Ring",
		back="Fierabras's Mantle",waist="Creed Baudrier",legs="Carmine Cuisses +1",feet="Cab. Leggings +1"}

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {hands="Cab. Gauntlets +1"})		
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Sulevia's Mask +1",
		body="Cab. Surcoat +1",hands="Rev. Gauntlets +1",ring1="Asklepian Ring",ring2="Valseur's Ring",
		waist="Chaac Belt",legs="Sulevi. Cuisses +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {ammo="Ginsen",
        head="Founder's Corona",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Steelflash Earring",
        body="Tartarus Platemail",hands="Leyline Gloves",ring1="Cacoethic Ring",ring2="Patricius Ring",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}
		
	sets.precast.JA['Violent Flourish'] = {ammo="Ginsen",
        head="Founder's Corona",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Found. Breastplate",hands="Leyline Gloves",ring1="Defending Ring",ring2="Sangoma Ring",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}
		
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",
		head="Carmine Mask",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Odyss. Chestplate",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring",
		back="Rudianos's Mantle",waist="Flume Belt",legs="Odyssean Cuisses",feet="Odyssean Greaves"}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {neck="Diemer Gorget",ear1="Nourish. Earring",ear2="Nourish. Earring +1",body="Jumalik Mail"})
  
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Paeapua",
		head="Sulevia's Mask +1",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +1",ring1="Rajas Ring",ring2="Rufescent Ring",
		back="Bleating Mantle",waist="Fotia Belt",legs="Sulevi. Cuisses +1",feet="Sulevia's Leggings +1"}

    sets.precast.WS.Acc = {ammo="Hasty Pinion +1",
        head="Sulevia's Mask +1",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Steelflash Earring",
        body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +1",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Sulevia's Leggings +1"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Zennaroi Earring",ear2="Moonshade Earring"})
	
	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Zennaroi Earring",ear2="Moonshade Earring"})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Ishvara Earring",ring1="Karieyh Ring",ear2="Moonshade Earring"})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Zennaroi Earring",ear2="Moonshade Earring"})
	
	sets.precast.WS['Flat Blade'] = {ammo="Ginsen",
        head="Founder's Corona",neck="Voltsurge Torque",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Sulevia's Plate. +1",hands="Leyline Gloves",ring1="Defending Ring",ring2="Vertigo Ring",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}
		
	sets.precast.WS['Flat Blade'].Acc = {ammo="Ginsen",
        head="Founder's Corona",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Found. Breastplate",hands="Leyline Gloves",ring1="Cacoethic Ring",ring2="Patricius Ring",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}
	
    sets.precast.WS['Sanguine Blade'] = {ammo="Dosis Tathlum",
        head="Jumalik Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Jumalik Mail",hands="Founder's Gauntlets",ring1="Acumen Ring",ring2="Archon Ring",
        back="Toro Cape",waist="Fotia Belt",legs="Reverence Breeches +1",feet="Founder's Greaves"}

	sets.precast.WS['Sanguine Blade'].Acc = sets.precast.WS['Sanguine Blade']
	
    sets.precast.WS['Atonement'] = {ammo="Paeapua",
		head="Rev. Coronet +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Ishvara Earring",
		body="Phorcys Korazin",hands="Macabre Gaunt. +1",ring1="Defending Ring",Ring2="Dark Ring",
		back="Fierabras's Mantle",waist="Fotia Belt",legs="Cab. Breeches +1",feet="Sulevia's Leggings +1"}
		
    sets.precast.WS['Atonement'].Acc = sets.precast.WS['Atonement']
    sets.precast.WS['Spirits Within'] = sets.precast.WS['Atonement']
    sets.precast.WS['Spirits Within'].Acc = sets.precast.WS['Atonement']
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Bladeborn Earring",ear2="Steelflash Earring"}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Steelflash Earring"}
    
    
	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {ammo="Paeapua",
        head="Chev. Armet +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Odyss. Chestplate",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
        waist="Zoran's Belt",legs="Odyssean Cuisses",feet="Odyssean Greaves"}
        
    sets.midcast.Flash = set_combine(sets.Enmity, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})
    
    sets.midcast.Cure = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Loricate Torque +1",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
		body="Jumalik Mail",hands="Macabre Gaunt. +1",ring1="Defending Ring",ring2="Dark Ring",
		back="Solemnity Cape",waist="Creed Baudrier",legs="Carmine Cuisses +1",feet="Odyssean Greaves"}
		
	sets.Self_Healing = {ammo="Staunch Tathlum",
		head="Souveran Schaller",neck="Loricate Torque +1",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
		body="Souveran Cuirass",hands="Macabre Gaunt. +1",ring1="Defending Ring",ring2="K'ayres Ring",
		back="Solemnity Cape",waist="Creed Baudrier",legs="Souveran Diechlings",feet="Amm Greaves"}
		
	sets.Cure_Recieved = {body="Souveran Cuirass",legs="Souveran Diechlings",feet="Souveran Schuhs"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

    sets.midcast['Enhancing Magic'] = {neck="Incanter's Torque",waist="Olympus Sash",legs="Reverence Breeches +1",ear1="Andoaa Earring",back="Merciful Cape"}
	
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
    
    sets.midcast.Protect = {ring2="Sheltered Ring"}
    sets.midcast.Shell = {ring2="Sheltered Ring"}
	
	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {hands="Souv. Handschuhs",back="Weard Mantle",feet="Souveran Schuhs"})
    
	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------
    
    sets.resting = {ammo="Homiliary",
		head="Jumalik Helm",neck="Coatl Gorget +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Jumalik Mail",hands="Rev. Gauntlets +1",ring1="Defending Ring",ring2="Sheltered Ring",
		back="Solemnity Cape",waist="Fucho-no-obi",legs="Sulevi. Cuisses +1",feet="Cab. Leggings +1"}

    -- Idle sets
    sets.idle = {ammo="Homiliary",
		head="Jumalik Helm",neck="Coatl Gorget +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Jumalik Mail",hands="Souv. Handschuhs",ring1="Defending Ring",ring2="Sheltered Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Sulevi. Cuisses +1",feet="Cab. Leggings +1"}
		
    sets.idle.PDT = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Diemer Gorget",ear1="Creed Earring",ear2="Thureous Earring",
		body="Tartarus Platemail",hands="Souv. Handschuhs",ring1="Defending Ring",Ring2="Dark Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Chev. Cuisses +1",feet="Souveran Schuhs"}
		
    sets.idle.MDT = {ammo="Staunch Tathlum",
		head="Jumalik Helm",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Tartarus Platemail",hands="Souv. Handschuhs",ring1="Defending Ring",Ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Flume Belt",legs="Odyssean Cuisses",feet="Founder's Greaves"}
	    		
	sets.idle.Refresh = {ammo="Homiliary",
		head="Jumalik Helm",neck="Coatl Gorget +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Jumalik Mail",hands="Rev. Gauntlets +1",ring1="Defending Ring",ring2="Karieyh Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Cab. Leggings +1"}

	sets.idle.Tank = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Loricate Torque +1",ear1="Creed Earring",ear2="Thureous Earring",
		body="Tartarus Platemail",hands="Souv. Handschuhs",ring1="Defending Ring",Ring2="Shadow Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Chev. Cuisses +1",feet="Souveran Schuhs"}
		
	sets.idle.KiteTank = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Thureous Earring",
		body="Tartarus Platemail",hands="Souv. Handschuhs",ring1="Defending Ring",Ring2="Shadow Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Amm Greaves"}
		
    sets.idle.Reraise = {ammo="Staunch Tathlum",
		head="Twilight Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Thureous Earring",
		body="Twilight Mail",hands="Rev. Gauntlets +1",ring1="Defending Ring",ring2="Sheltered Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Cab. Leggings +1"}
		
    sets.idle.Weak = {ammo="Staunch Tathlum",
		head="Twilight Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Thureous Earring",
		body="Twilight Mail",hands="Souv. Handschuhs",ring1="Defending Ring",ring2="Dark Ring",
		back="Solemnity Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet="Cab. Leggings +1"}
		
	sets.Kiting = {legs="Carmine Cuisses +1"}

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Weapons = {main="Deacon Sword",sub="Aegis"}
    sets.Knockback = {}
    sets.MP = {head="Chev. Armet +1",neck="Coatl Gorget +1",ear2="Ethereal Earring",waist="Flume Belt"}
    sets.MP_Knockback = {}
    sets.Twilight = {head="Twilight Helm", body="Twilight Mail"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {sub="Ochain"}
    sets.MagicalShield = {sub="Aegis"}
	
    sets.defense.PDT = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Diemer Gorget",ear1="Creed Earring",ear2="Thureous Earring",
		body="Tartarus Platemail",hands="Souv. Handschuhs",ring1="Defending Ring",Ring2="Dark Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Chev. Cuisses +1",feet="Souveran Schuhs"}
		
    sets.defense.PDT_HP = {ammo="Staunch Tathlum",
        head="Souveran Schaller",neck="Combatant's Torque",ear1="Thureous Earring",ear2="Etiolation Earring",
        body="Souveran Cuirass",hands="Souv. Handschuhs",ring1="K'ayres Ring",ring2="Kunaji Ring",
        back="Xucau Mantle",waist="Creed Baudrier",legs="Chev. Cuisses +1",feet="Amm Greaves"}
		
    sets.defense.MDT_HP = {ammo="Staunch Tathlum",
        head="Souveran Schaller",neck="Combatant's Torque",ear1="Thureous Earring",ear2="Etiolation Earring",
        body="Reverence Surcoat +1",hands="Cab. Gauntlets +1",ring1="K'ayres Ring",ring2="Kunaji Ring",
        back="Xucau Mantle",waist="Creed Baudrier",legs="Odyssean Cuisses",feet="Ejekamal Boots"}
		
    sets.defense.PDT_Reraise = {ammo="Staunch Tathlum",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Thureous Earring",ear2="Etiolation Earring",
        body="Twilight Mail",hands="Macabre Gaunt. +1",ring1="Defending Ring",Ring2="Dark Ring",
		back="Mollusca Mantle",waist="Flume Belt",legs="Chev. Cuisses +1",feet="Souveran Schuhs"}
		
    sets.defense.MDT_Reraise = {ammo="Staunch Tathlum",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Twilight Mail",hands="Rev. Gauntlets +1",ring1="Defending Ring",Ring2="Dark Ring",
		back="Engulfer Cape +1",waist="Flume Belt",legs="Odyssean Cuisses",feet="Cab. Leggings +1"}

	sets.defense.BDT = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Loricate Torque +1",ear1="Thureous Earring",ear2="Etiolation Earring",
		body="Tartarus Platemail",hands="Sulev. Gauntlets +1",ring1="Defending Ring",Ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Creed Baudrier",legs="Sulevi. Cuisses +1",feet="Amm Greaves"}
		
	sets.defense.Tank = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Loricate Torque +1",ear1="Creed Earring",ear2="Thureous Earring",
		body="Tartarus Platemail",hands="Souv. Handschuhs",ring1="Defending Ring",Ring2="Shadow Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Chev. Cuisses +1",feet="Souveran Schuhs"}
		
	sets.defense.MEVA = {ammo="Staunch Tathlum",
        head="Founder's Corona",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Tartarus Platemail",hands="Leyline Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
        back="Rudianos's Mantle",waist="Asklepian Belt",legs="Odyssean Cuisses",feet="Odyssean Greaves"}
		
	sets.defense.Death = {ammo="Staunch Tathlum",
        head="Founder's Corona",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Tartarus Platemail",hands="Leyline Gloves",ring1="Warden's Ring",Ring2="Shadow Ring",
        back="Rudianos's Mantle",waist="Asklepian Belt",legs="Odyssean Cuisses",feet="Odyssean Greaves"}
		
	sets.defense.Charm = {ammo="Staunch Tathlum",
        head="Founder's Corona",neck="Unmoving Collar +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Tartarus Platemail",hands="Leyline Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
        back="Solemnity Cape",waist="Asklepian Belt",legs="Souveran Diechlings",feet="Odyssean Greaves"}
		
		-- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.OchainMDT = {ammo="Staunch Tathlum",
		head="Founder's Corona",neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Etiolation Earring",
		body="Tartarus Platemail",hands="Souv. Handschuhs",ring1="Defending Ring",Ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Creed Baudrier",legs="Chev. Cuisses +1",feet="Chev. Sabatons +1"}
		
    sets.defense.OchainNoShellMDT = {ammo="Staunch Tathlum",
		head="Founder's Corona",neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Etiolation Earring",
		body="Tartarus Platemail",hands="Souv. Handschuhs",ring1="Defending Ring",Ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Flax Sash",legs="Sulevi. Cuisses +1",feet="Chev. Sabatons +1"}
		
    sets.defense.AegisMDT = {ammo="Staunch Tathlum",
		head="Founder's Corona",neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Ethereal Earring",
		body="Tartarus Platemail",hands="Leyline Gloves",ring1="Defending Ring",Ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Creed Baudrier",legs="Odyssean Cuisses",feet="Odyssean Greaves"}
		
    sets.defense.AegisNoShellMDT = {ammo="Staunch Tathlum",
		head="Founder's Corona",neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Etiolation Earring",
		body="Tartarus Platemail",hands="Souv. Handschuhs",ring1="Defending Ring",Ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Asklepian Belt",legs="Sulevi. Cuisses +1",feet="Amm Greaves"}		

	--------------------------------------
	-- Engaged sets
	--------------------------------------
    
sets.engaged = {ammo="Paeapua",
		head="Acro Helm",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
		body="Acro Surcoat",hands="Acro Gauntlets",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Sulevi. Cuisses +1",feet="Founder's Greaves"}

    sets.engaged.Acc = {ammo="Ginsen",
        head="Acro Helm",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Steelflash Earring",
        body="Acro Surcoat",hands="Acro Gauntlets",ring1="Cacoethic Ring",ring2="Cacoethic Ring +1",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}

    sets.engaged.DW = {ammo="Paeapua",
		head="Acro Helm",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Acro Surcoat",hands="Acro Gauntlets",ring1="Rajas Ring",ring2="K'ayres Ring",
		back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Sulevi. Cuisses +1",feet="Founder's Greaves"}

    sets.engaged.DW.Acc = {ammo="Ginsen",
		head="Sulevia's Mask +1",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +1",ring1="Rajas Ring",ring2="Cacoethic Ring +1",
		back="Letalis Mantle",waist="Olseni Belt",legs="Sulevi. Cuisses +1",feet="Founder's Greaves"}

	sets.engaged.Tank = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Loricate Torque +1",ear1="Creed Earring",ear2="Thureous Earring",
		body="Tartarus Platemail",hands="Souv. Handschuhs",ring1="Defending Ring",Ring2="Shadow Ring",
		back="Shadow Mantle",waist="Flume Belt",legs="Chev. Cuisses +1",feet="Souveran Schuhs"}
		
	sets.engaged.BreathTank = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Loricate Torque +1",ear1="Thureous Earring",ear2="Etiolation Earring",
		body="Tartarus Platemail",hands="Sulev. Gauntlets +1",ring1="Defending Ring",Ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Creed Baudrier",legs="Sulevi. Cuisses +1",feet="Amm Greaves"}
		
	sets.engaged.Acc.BreathTank = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Loricate Torque +1",ear1="Thureous Earring",ear2="Etiolation Earring",
		body="Tartarus Platemail",hands="Sulev. Gauntlets +1",ring1="Defending Ring",Ring2="Shadow Ring",
		back="Engulfer Cape +1",waist="Creed Baudrier",legs="Sulevi. Cuisses +1",feet="Amm Greaves"}
		
	sets.engaged.DDTank = {ammo="Hasty Pinion +1",
		head="Sulevia's Mask +1",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Tartarus Platemail",hands="Sulev. Gauntlets +1",ring1="Defending Ring",Ring2="Patricius Ring",
		back="Weard Mantle",waist="Tempus Fugit",legs="Sulevi. Cuisses +1",feet="Sulev. Leggings +1"}
		
	sets.engaged.Acc.DDTank = {ammo="Hasty Pinion +1",
		head="Sulevia's Mask +1",neck="Loricate Torque +1",ear1="Brutal Earring",ear2="Cessance Earring",
		body="Tartarus Platemail",hands="Sulev. Gauntlets +1",ring1="Defending Ring",Ring2="Patricius Ring",
		back="Weard Mantle",waist="Olseni Belt",legs="Sulevi. Cuisses +1",feet="Sulev. Leggings +1"}
		
	sets.engaged.NoShellTank = {ammo="Staunch Tathlum",
        head="Jumalik Helm",neck="Loricate Torque +1",ear1="Thureous Earring",ear2="Etiolation Earring",
        body="Cab. Surcoat +1",hands="Rev. Gauntlets +1",ring1="Defending Ring",Ring2="Dark Ring",
        back="Xucau Mantle",waist="Flume Belt",legs="Reverence Breeches +1",feet="Cab. Leggings +1"}
		
    sets.engaged.Acc.Tank = {ammo="Ginsen",
        head="Sulevia's Mask +1",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Steelflash Earring",
        body="Tartarus Platemail",hands="Sulev. Gauntlets +1",ring1="Defending Ring",Ring2="Patricius Ring",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Sulevi. Cuisses +1",feet="Sulev. Leggings +1"}
		
    sets.engaged.Reraise = set_combine(sets.engaged.Tank, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc.Tank, sets.Reraise)

    sets.engaged.DW.Tank = set_combine(sets.engaged.DW, {body="Reverence Surcoat +1",neck="Loricate Torque +1",ring1="Defending Ring",Ring2="Patricius Ring"})
    sets.engaged.DW.Acc.Tank = set_combine(sets.engaged.DW.Acc, {body="Reverence Surcoat +1",neck="Loricate Torque +1",ring1="Defending Ring",Ring2="Patricius Ring"})
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)
		
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Berserker's Torque"}
    sets.buff.Cover = {body="Cab. Surcoat +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'RUN' then
        set_macro_page(9, 4)
    elseif player.sub_job == 'RDM' then
        set_macro_page(6, 4)
    elseif player.sub_job == 'BLU' then
        set_macro_page(8, 4)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 4)
    else
        set_macro_page(1, 4) --War/Etc
    end
end