extends Sprite

var PokemonEnnemi
var ActualPokemon
var TempPokemon
onready var UIPokemonBoxScene = get_node("/root/FightScene/UIPokemonBoxEnnemi")
onready var PokemonPlayer = get_node("/root/FightScene/PokemonPlayer")
onready var UiFight = get_node("/root/FightScene/UIFight")
onready var UiFight_ShowText = get_node("/root/FightScene/UIFight/ShowText")
onready var AttaqueAnimation = get_node("/root/FightScene/AttaqueAnimation")

func _on_PokemonEnnemi_tree_entered():
	FirstPokemonAssignement(EG.Pokemon1)
	self.texture = load(PokemonEnnemi.TextureFront)
	yield(get_tree().create_timer(1),"timeout")
	UIPokemonBoxScene.load_values(PokemonEnnemi.Name,PokemonEnnemi.Lvl,PokemonEnnemi.Hp,PokemonEnnemi.MaxHp)

func loadSettings(PokemonToLoad) :
	
	if PokemonToLoad.Hp == null : pass
	else : PokemonEnnemi.Hp = PokemonToLoad.Hp
	
	if PokemonToLoad.MaxHp == null : pass
	else : PokemonEnnemi.MaxHp = PokemonToLoad.MaxHp
	
	if PokemonToLoad.Lvl == null : pass
	else : PokemonEnnemi.Lvl = PokemonToLoad.Lvl
	
	if PokemonToLoad.Puissance == null : pass
	else : PokemonEnnemi.Puissance = PokemonToLoad.Puissance
	
	if PokemonToLoad.Defense == null : pass
	else : PokemonEnnemi.Defense = PokemonToLoad.Defense
	
	if PokemonToLoad.DefenseSpecial == null : pass
	else : PokemonEnnemi.DefenseSpecial = PokemonToLoad.DefenseSpecial
	
	if PokemonToLoad.Vitesse == null : pass
	else : PokemonEnnemi.Vitesse = PokemonToLoad.Vitesse
	
	if PokemonToLoad.AttaqueSpecial == null : pass
	else : PokemonEnnemi.AttaqueSpecial = PokemonToLoad.AttaqueSpecial
	
	if PokemonToLoad.Attaque1 == null : pass
	else : PokemonEnnemi.Attaque1 = PokemonToLoad.Attaque1
	
	if PokemonToLoad.Attaque2 == null : pass
	else : PokemonEnnemi.Attaque2 = PokemonToLoad.Attaque2
	
	if PokemonToLoad.Attaque3 == null : pass
	else : PokemonEnnemi.Attaque3 = PokemonToLoad.Attaque3
	
	if PokemonToLoad.Attaque4 == null : pass
	else : PokemonEnnemi.Attaque4 = PokemonToLoad.Attaque4
	
	if PokemonToLoad.ActualPPAttaque1 == null : pass
	else : PokemonEnnemi.ActualPPAttaque1 = PokemonToLoad.ActualPPAttaque1
	
	if PokemonToLoad.ActualPPAttaque2 == null : pass
	else : PokemonEnnemi.ActualPPAttaque2 = PokemonToLoad.ActualPPAttaque2
	
	if PokemonToLoad.ActualPPAttaque3 == null : pass
	else : PokemonEnnemi.ActualPPAttaque3 = PokemonToLoad.ActualPPAttaque3
	
	if PokemonToLoad.ActualPPAttaque4 == null : pass
	else : PokemonEnnemi.ActualPPAttaque4 = PokemonToLoad.ActualPPAttaque4

func saveParameters(PokemonToSave) :
	PokemonToSave["Hp"] = PokemonEnnemi.Hp
	PokemonToSave["Experience"] = PokemonEnnemi.Experience
	PokemonToSave["Lvl"] = PokemonEnnemi.Lvl
	PokemonToSave["MaxHp"] = PokemonEnnemi.MaxHp
	PokemonToSave["Puissance"] = PokemonEnnemi.Puissance
	PokemonToSave["Defense"] = PokemonEnnemi.Defense
	PokemonToSave["AttaqueSpecial"] = PokemonEnnemi.AttaqueSpecial
	PokemonToSave["DefenseSpecial"] = PokemonEnnemi.DefenseSpecial
	PokemonToSave["Vitesse"] = PokemonEnnemi.Vitesse
	PokemonToSave["LvlNeededToEvolve"] = PokemonEnnemi.LvlNeededToEvolve
	PokemonToSave["ExperienceNeededToLvlUp"] = PokemonEnnemi.ExperienceNeededToLvlUp
	PokemonToSave["Statut"] = PokemonEnnemi.Statut
	PokemonToSave["Attaque1"] = PokemonEnnemi.Attaque1
	PokemonToSave["Attaque2"] = PokemonEnnemi.Attaque2
	PokemonToSave["Attaque3"] = PokemonEnnemi.Attaque3
	PokemonToSave["Attaque4"] = PokemonEnnemi.Attaque4
	PokemonToSave["ActualPPAttaque1"] = PokemonEnnemi.ActualPPAttaque1
	PokemonToSave["ActualPPAttaque2"] = PokemonEnnemi.ActualPPAttaque2
	PokemonToSave["ActualPPAttaque3"] = PokemonEnnemi.ActualPPAttaque3
	PokemonToSave["ActualPPAttaque4"] = PokemonEnnemi.ActualPPAttaque4
	PokemonToSave["Type1"] = PokemonEnnemi.Type1
	PokemonToSave["Type2"] = PokemonEnnemi.Type2

func ChangePokemon(Number) :
#	Save
	saveParameters(ActualPokemon)
	match Number :
		"2" :
			TempPokemon = EG.Pokemon1
			EG.Pokemon1 = EG.Pokemon2
			EG.Pokemon2 = TempPokemon
		"3" :
			TempPokemon = EG.Pokemon1
			EG.Pokemon1 = EG.Pokemon3
			EG.Pokemon3 = TempPokemon
		"4" :
			TempPokemon = EG.Pokemon1
			EG.Pokemon1 = EG.Pokemon4
			EG.Pokemon4 = TempPokemon
		"5" :
			TempPokemon = EG.Pokemon1
			EG.Pokemon1 = EG.Pokemon5
			EG.Pokemon5 = TempPokemon
		"6" :
			TempPokemon = EG.Pokemon1
			EG.Pokemon1 = EG.Pokemon6
			EG.Pokemon6 = TempPokemon
#	Instance the new Pokemon with a "Typical" Object => a class
	for x in Pokemon.List :
		if x == EG.Pokemon1.Name :
			PokemonPlayer = Pokemon.List[x].new()
	#	Load all settings of the personnal pokemon
	loadSettings(EG.Pokemon1)

func FirstPokemonAssignement(Pokemon1) :
	for x in Pokemon.List :
		if x == Pokemon1.Name :
			PokemonEnnemi = Pokemon.List[x].new()
	loadSettings(Pokemon1)
	ActualPokemon = EG.Pokemon1

func EnnemiLaunchAttack() :
	var ARandom = RandomNumberGenerator.new()
	ARandom.randomize()
	var ListAttack = [PokemonEnnemi.Attaque1,PokemonEnnemi.Attaque2,PokemonEnnemi.Attaque3,PokemonEnnemi.Attaque4]
	var Random = ARandom.randi_range(0,3)
	while ListAttack[Random] == "" or ListAttack[Random] == " " or ListAttack[Random] == "-" or ListAttack[Random] == null :
		Random = RandomNumberGenerator.new().randi_range(0,3)
	return ListAttack[Random]

func _on_UIAttaque_LoadValues():
	UIPokemonBoxScene.load_values(PokemonEnnemi.Name,PokemonEnnemi.Lvl,PokemonEnnemi.Hp,PokemonEnnemi.MaxHp)
func loadTextures() :
	self.texture = load(PokemonEnnemi.TextureBack)
