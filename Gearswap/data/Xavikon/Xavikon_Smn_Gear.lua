-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'TPEat', 'Regain')

    gear.perp_staff = {name="Gridarvor"}
	
    send_command('bind ^` input /ja "Release" <me>')
	send_command('bind @` gs c cycle MagicBurst')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @pause gs c toggle AutoSubMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast Sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Astral Flow'] = {head="Glyphic Horn"}
    
    sets.precast.JA['Elemental Siphon'] = {main="Keraunos",
        head="Convoker's Horn",neck="Incanter's Torque",ear2="Andoaa Earring",
        body="Caller's Doublet +2",hands="Glyphic Bracers",ring1="Evoker's Ring",ring2="Globidonta Ring",
        back="Conveyance Cape",legs="Caller's Spats +2",feet="Caller's Pigaches +2"}

    sets.precast.JA['Mana Cede'] = {hands="Caller's Bracers +2"}

    -- Pact delay reduction gear
    sets.precast.BloodPactWard = {ammo="Seraphicaller",
		head="Glyphic Horn",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Andoaa Earring",
        body="Con. Doublet +1",hands="Glyphic Bracers",ring1="Evoker's Ring",ring2="Globidonta Ring",
        back="Conveyance Cape",legs="Caller's Spats +2",feet="Con. Pigaches +1"}

    sets.precast.BloodPactRage = sets.precast.BloodPactWard

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        head="Nahtirah Hat",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Anhur Robe",ring1="Prolix Ring",ring2="Lebeche Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Serenity",sub="Curatio Grip",body="Heka's Kalasiris",back="Pahtli Cape"})
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Con. Doublet +1",hands="Hagondes Cuffs +1",ring1="Rajas Ring",ring2="Cacoethic Ring +1",
        back="Pahtli Cape",waist="Fotia Belt",legs="Hagondes Pants +1",feet="Hag. Sabots +1"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {
        head="Nahtirah Hat",ear1="Gifted Earring",ear2="Loquacious Earring",
        body="Con. Doublet +1",hands="Caller's Bracers +2",ring1="Evoker's Ring",ring2="Metamor. Ring +1",
        back="Conveyance Cape",waist="Fucho-no-Obi",legs="Assid. Pants +1",feet="Con. Pigaches +1"}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {main="Marin Staff +1",ammo="Hasty Pinion +1",
		head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Helios Jacket",hands="Helios Gloves",ring1="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}

    sets.midcast.Cure = {main="Serenity",sub="Curatio Grip",
        head="Nahtirah Hat",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Loquacious Earring",
        body="Heka's Kalasiris",hands="Telchine Gloves",ring1="Haoma's Ring",ring2="Sirona's Ring",
        back="Tempered Cape +1",waist="Sekhmet Corset",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Malison Medallion",hands="Hieros Mittens",
		ring1="Haoma's Ring",ring2="Haoma's Ring", back="Tempered Cape +1",waist="Witful Belt",feet="Gende. Galosh. +1"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Marin Staff +1",sub="Clemency Grip"})

    sets.midcast.Stoneskin = {waist="Siegel Sash"}

	sets.midcast['Elemental Magic'] = {main="Serenity",sub="Zuuxowu Grip",ammo="Dosis Tathlum",
		head="Buremte Hat",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Witching Robe",hands="Helios Gloves",ring1="Acumen Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Sekhmet Corset",legs="Psycloth Lappas",feet="Helios Boots"}
		
	sets.midcast['Elemental Magic'].Resistant = {main="Serenity",sub="Clerisy Strap +1",ammo="Dosis Tathlum",
		head="Buremte Hat",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Vanir Cotehardie",hands="Helios Gloves",ring1="Acumen Ring",ring2="Strendu Ring",
		back="Toro Cape",waist="Yamabuki-no-Obi",legs="Psycloth Lappas",feet="Helios Boots"}

    sets.midcast['Divine Magic'] = {main="Serenity",sub="Clerisy Strap +1",
        head="Buremte Hat",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Vanir Cotehardie",hands="Helios Gloves",ring1="Globidonta Ring",ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",waist="Ovate Rope",legs="Hagondes Pants +1",feet="Medium's Sabots"}
		
    sets.midcast['Dark Magic'] = {main="Serenity",sub="Clerisy Strap +1",
        head="Buremte Hat",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Helios Jacket",hands="Helios Gloves",ring1="Vertigo Ring",ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",waist="Fuchi-no-Obi",legs="Hagondes Pants +1",feet="Medium's Sabots"}
		
    sets.midcast.Stun = {main="Marin Staff +1",sub="Clerisy Strap +1",ammo="Hasty Pinion +1",
        head="Nahtirah Hat",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Helios Jacket",hands="Helios Gloves",ring1="Vertigo Ring",ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
    sets.midcast.Stun.Resistant = {main="Serenity",sub="Clerisy Strap +1",ammo="Pemphredo Tathlum",
        head="Nahtirah Hat",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Helios Jacket",hands="Helios Gloves",ring1="Vertigo Ring",ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Helios Boots"}
		
	sets.midcast['Enfeebling Magic'] = {main="Serenity",sub="Clerisy Strap +1",
        head="Befouled Crown",neck="Imbodla Necklace",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Vanya Robe",hands="Helios Gloves",ring1="Vertigo Ring",ring2="Metamor. Ring +1",
        back="Aurist's Cape +1",waist="Ovate Rope",legs="Psycloth Lappas",feet="Medium's Sabots"}
		
	sets.midcast['Enhancing Magic'] = {main="Serenity",sub="Fulcio Grip",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Prolix Ring",
		back="Perimede Cape",waist="Olympus Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif"})


    -- Avatar pact sets.  All pacts are Ability type.
    
    sets.midcast.Pet.BloodPactWard = {main="Keraunos",ammo="Seraphicaller",
        head="Caller's Horn +2",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Andoaa Earring",
        body="Caller's Doublet +2",hands="Glyphic Bracers",ring1="Evoker's Ring",ring2="Globidonta Ring",
        back="Conveyance Cape",legs="Caller's Spats +2",feet="Con. Pigaches +1"}

    sets.midcast.Pet.DebuffBloodPactWard = {main="Keraunos",ammo="Seraphicaller",
        head="Caller's Horn +2",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Andoaa Earring",
        body="Caller's Doublet +2",hands="Glyphic Bracers",ring1="Evoker's Ring",ring2="Globidonta Ring",
        back="Conveyance Cape",legs="Caller's Spats +2",feet="Con. Pigaches +1"}
        
    sets.midcast.Pet.DebuffBloodPactWard.Acc = sets.midcast.Pet.DebuffBloodPactWard
    
    sets.midcast.Pet.PhysicalBloodPactRage = {main="Keraunos",ammo="Seraphicaller",
        head="Caller's Horn +2",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Andoaa Earring",
        body="Con. Doublet +1",hands="Glyphic Bracers",ring1="Evoker's Ring",ring2="Globidonta Ring",
        back="Conveyance Cape",legs="Enticer's Pants",feet="Con. Pigaches +1"}

    sets.midcast.Pet.PhysicalBloodPactRage.Acc = sets.midcast.Pet.PhysicalBloodPactRage

    sets.midcast.Pet.MagicalBloodPactRage = {main="Keraunos",ammo="Seraphicaller",
        head="Glyphic Horn",neck="Incanter's Torque",ear1="Gifted Earring",ear2="Andoaa Earring",
        body="Con. Doublet +1",hands="Glyphic Bracers",ring1="Evoker's Ring",ring2="Globidonta Ring",
        back="Conveyance Cape",legs="Enticer's Pants",feet="Hag. Sabots +1"}

    sets.midcast.Pet.MagicalBloodPactRage.Acc = sets.midcast.Pet.MagicalBloodPactRage

	sets.midcast.Pet.PhysicalBloodPactRage.Carbuncle = {}
	sets.midcast.Pet.MagicalBloodPactRage.Carbuncle = {}
	sets.midcast.Pet.DebuffBloodPactWard.Carbuncle = {}
	
	sets.midcast.Pet.PhysicalBloodPactRage['Cait Sith'] = {}
	sets.midcast.Pet.MagicalBloodPactRage['Cait Sith'] = {}
	sets.midcast.Pet.DebuffBloodPactWard['Cait Sith'] = {}

    -- Spirits cast magic spells, which can be identified in standard ways.
    
    sets.midcast.Pet.WhiteMagic = {} --legs="Summoner's Spats"
    
    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.BloodPactRage, {}) --legs="Summoner's Spats"

    sets.midcast.Pet['Elemental Magic'].Resistant = {}
    

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {main="Chatoyant Staff",ammo="Seraphicaller",
        head="Caller's Horn +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Vrikodara Jupon",hands="Serpentes Cuffs",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Umbra Cape",waist="Fucho-no-obi",legs="Assid. Pants +1",feet="Chelona Boots"}
    
    -- Idle sets
    sets.idle = {main="Bolelabunga",sub="Genbu's Shield",ammo="Seraphicaller",
        head="Caller's Horn +2",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Assid. Pants +1",feet="Hag. Sabots +1"}

    sets.idle.PDT = {main="Terra's Staff",sub="Oneiros Grip",ammo="Seraphicaller",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Hag. Sabots +1"}

	sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque",ring2="Karieyh Ring"})
	sets.idle.Regain = set_combine(sets.idle, {ring2="Karieyh Ring"})

    -- perp costs:
    -- spirits: 7
    -- carby: 11 (5 with mitts)
    -- fenrir: 13
    -- others: 15
    -- avatar's favor: -4/tick
    
    -- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
    -- Aim for -14 perp, and refresh in other slots.
    
    -- -perp gear:
    -- Gridarvor: -5
    -- Glyphic Horn: -4
    -- Caller's Doublet +2/Glyphic Doublet: -4
    -- Evoker's Ring: -1
    -- Con. Pigaches +1: -4
    -- total: -18
    
    -- Can make due without either the head or the body, and use +refresh items in those slots.
    
    sets.idle.Avatar = {main="Gridarvor",sub="Oneiros Grip",ammo="Seraphicaller",
        head="Caller's Horn +2",neck="Caller's Pendant",ear1="Moonshade Earring",ear2="Ethereal Earring",
        body="Call. Doublet +2",hands="Serpentes Cuffs",ring1="Evoker's Ring",ring2="Sheltered Ring",
        back="Conveyance Cape",waist="Fucho-no-Obi",legs="Assid. Pants +1",feet="Con. Pigaches +1"}

    sets.idle.Spirit = {main="Gridarvor",sub="Oneiros Grip",ammo="Seraphicaller",
        head="Caller's Horn +2",neck="Caller's Pendant",ear1="Moonshade Earring",ear2="Ethereal Earring",
        body="Call. Doublet +2",hands="Serpentes Cuffs",ring1="Evoker's Ring",ring2="Sheltered Ring",
        back="Conveyance Cape",waist="Fucho-no-Obi",legs="Summoner's Spats",feet="Con. Pigaches +1"}

    -- Favor uses Caller's Horn instead of Convoker's Horn for refresh
    sets.idle.Avatar.Favor = {}
    sets.idle.Avatar.Melee = {hands="Regimen Mittens",back="Conveyance Cape",ear1="Domes. Earring",ear2="Handler's Earring +1"}
	
	sets.idle.Avatar.Melee.Carbuncle = {}
	sets.idle.Avatar.Melee['Cait Sith'] = {}
        
    sets.perp = {}
    -- Caller's Bracer's halve the perp cost after other costs are accounted for.
    -- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
    -- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
    -- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.
    sets.perp.Day = {body="Vrikodara Jupon",hands="Caller's Bracers +2"}
    sets.perp.Weather = {neck="Caller's Pendant",body="Vrikodara Jupon",hands="Caller's Bracers +2"}
    -- Carby: Mitts+Conv.feet = 1/tick perp.  Everything else should be +refresh (Tossed mitts for room)

	sets.perp.Carbuncle = {} --hands="Carbuncle Mitts"
    sets.perp.Diabolos = {}
    sets.perp.Alexander = sets.midcast.Pet.BloodPactWard

    sets.perp.staff_and_grip = {main=gear.perp_staff,sub="Oneiros Grip"}
    
    -- Defense sets
    sets.defense.PDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Seraphicaller",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Moonshade Earring",ear2="Handler's Earring +1",
        body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Hag. Sabots +1"}

    sets.defense.MDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Seraphicaller",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Hag. Sabots +1"}

    sets.defense.MEVA = {ammo="Seraphicaller",
        head=empty,neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Respite Cloak",hands="Telchine Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
        back="Aurist's Cape +1",waist="Ovate Rope",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
    sets.Kiting = {feet="Herald's Gaiters"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.DayIdle = {feet="Serpentes Sabots"}
	sets.NightIdle = {hands="Serpentes Cuffs"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})

	-- Gear for specific elemental nukes.
	sets.WindNuke = {main="Marin Staff +1"}
	sets.IceNuke = {main="Ngqoqwanb"}
	
    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    -- Normal melee group
    sets.engaged = {ammo="Seraphicaller",
        head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Vanya Robe",hands="Hagondes Cuffs +1",ring1="Rajas Ring",ring2="Cacoethic Ring +1",
        back="Conveyance Cape",waist="Windbuffet Belt +1",legs="Hagondes Pants +1",feet="Hag. Sabots +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end
    
    -- Default macro set/book
    set_macro_page(4, 17)
end
