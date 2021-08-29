extends Sprite

var PokemonPlayer
var ActualPokemon
var TempPokemon
onready var UIPokemonBoxScene = get_node("/root/FightScene/UIPokemonBox")

func _on_PokemonPlayer_tree_entered():
	FirstPokemonAssignement(PG.Pokemon1)
	self.texture = load(PokemonPlayer.TextureBack)
	yield(get_tree().create_timer(1),"timeout")
	UIPokemonBoxScene.load_values(PokemonPlayer.Name,PokemonPlayer.Lvl,PokemonPlayer.Hp,PokemonPlayer.MaxHp,PokemonPlayer.Experience,PokemonPlayer.ExperienceNeededToLvlUp)

func loadSettings(PokemonToLoad) :
	
	if PokemonToLoad.Name == null : pass
	else : PokemonPlayer.Name = PokemonToLoad.Name
	
	if PokemonToLoad.Hp == null : pass
	else : PokemonPlayer.Hp = PokemonToLoad.Hp
	
	if PokemonToLoad.MaxHp == null : pass
	else : PokemonPlayer.MaxHp = PokemonToLoad.MaxHp
	
	if PokemonToLoad.Lvl == null : pass
	else : PokemonPlayer.Lvl = PokemonToLoad.Lvl
	
	if PokemonToLoad.Experience == null : pass
	else : PokemonPlayer.Experience = PokemonToLoad.Experience
	
	if PokemonToLoad.ExperienceNeededToLvlUp == null : pass
	else : PokemonPlayer.ExperienceNeededToLvlUp = PokemonToLoad.ExperienceNeededToLvlUp
	
	if PokemonToLoad.Statut == null : pass
	else : PokemonPlayer.Statut = PokemonToLoad.Statut
	
	if PokemonToLoad.Puissance == null : pass
	else : PokemonPlayer.Puissance = PokemonToLoad.Puissance
	
	if PokemonToLoad.Defense == null : pass
	else : PokemonPlayer.Defense = PokemonToLoad.Defense
	
	if PokemonToLoad.DefenseSpecial == null : pass
	else : PokemonPlayer.DefenseSpecial = PokemonToLoad.DefenseSpecial
	
	if PokemonToLoad.Vitesse == null : pass
	else : PokemonPlayer.Vitesse = PokemonToLoad.Vitesse
	
	if PokemonToLoad.AttaqueSpecial == null : pass
	else : PokemonPlayer.AttaqueSpecial = PokemonToLoad.AttaqueSpecial
	
	if PokemonToLoad.Attaque1 == null : pass
	else : PokemonPlayer.Attaque1 = PokemonToLoad.Attaque1
	
	if PokemonToLoad.Attaque2 == null : pass
	else : PokemonPlayer.Attaque2 = PokemonToLoad.Attaque2
	
	if PokemonToLoad.Attaque3 == null : pass
	else : PokemonPlayer.Attaque3 = PokemonToLoad.Attaque3
	
	if PokemonToLoad.Attaque4 == null : pass
	else : PokemonPlayer.Attaque4 = PokemonToLoad.Attaque4
	
	if PokemonToLoad.ActualPPAttaque1 == null : pass
	else : PokemonPlayer.ActualPPAttaque1 = PokemonToLoad.ActualPPAttaque1
	
	if PokemonToLoad.ActualPPAttaque2 == null : pass
	else : PokemonPlayer.ActualPPAttaque2 = PokemonToLoad.ActualPPAttaque2
	
	if PokemonToLoad.ActualPPAttaque3 == null : pass
	else : PokemonPlayer.ActualPPAttaque3 = PokemonToLoad.ActualPPAttaque3
	
	if PokemonToLoad.ActualPPAttaque4 == null : pass
	else : PokemonPlayer.ActualPPAttaque4 = PokemonToLoad.ActualPPAttaque4

func saveParameters(PokemonToSave) :
	PokemonToSave["Hp"] = PokemonPlayer.Hp
	PokemonToSave["Experience"] = PokemonPlayer.Experience
	PokemonToSave["Lvl"] = PokemonPlayer.Lvl
	PokemonToSave["MaxHp"] = PokemonPlayer.MaxHp
	PokemonToSave["Puissance"] = PokemonPlayer.Puissance
	PokemonToSave["Defense"] = PokemonPlayer.Defense
	PokemonToSave["AttaqueSpecial"] = PokemonPlayer.AttaqueSpecial
	PokemonToSave["DefenseSpecial"] = PokemonPlayer.DefenseSpecial
	PokemonToSave["Vitesse"] = PokemonPlayer.Vitesse
	PokemonToSave["LvlNeededToEvolve"] = PokemonPlayer.LvlNeededToEvolve
	PokemonToSave["ExperienceNeededToLvlUp"] = PokemonPlayer.ExperienceNeededToLvlUp
	PokemonToSave["Statut"] = PokemonPlayer.Statut
	PokemonToSave["Attaque1"] = PokemonPlayer.Attaque1
	PokemonToSave["Attaque2"] = PokemonPlayer.Attaque2
	PokemonToSave["Attaque3"] = PokemonPlayer.Attaque3
	PokemonToSave["Attaque4"] = PokemonPlayer.Attaque4
	PokemonToSave["ActualPPAttaque1"] = PokemonPlayer.ActualPPAttaque1
	PokemonToSave["ActualPPAttaque2"] = PokemonPlayer.ActualPPAttaque2
	PokemonToSave["ActualPPAttaque3"] = PokemonPlayer.ActualPPAttaque3
	PokemonToSave["ActualPPAttaque4"] = PokemonPlayer.ActualPPAttaque4

func ChangePokemon(Number) :
#	Save
	saveParameters(ActualPokemon)
	match Number :
		"2" :
			TempPokemon = PG.Pokemon1
			PG.Pokemon1 = PG.Pokemon2
			PG.Pokemon2 = TempPokemon
		"3" :
			TempPokemon = PG.Pokemon1
			PG.Pokemon1 = PG.Pokemon3
			PG.Pokemon3 = TempPokemon
		"4" :
			TempPokemon = PG.Pokemon1
			PG.Pokemon1 = PG.Pokemon4
			PG.Pokemon4 = TempPokemon
		"5" :
			TempPokemon = PG.Pokemon1
			PG.Pokemon1 = PG.Pokemon5
			PG.Pokemon5 = TempPokemon
		"6" :
			TempPokemon = PG.Pokemon1
			PG.Pokemon1 = PG.Pokemon6
			PG.Pokemon6 = TempPokemon
#	Instance the new Pokemon with a "Typical" Object => a class
	for x in Pokemon.List :
		if x == PG.Pokemon1.Name :
			PokemonPlayer = Pokemon.List[x].new()
	#	Load all settings of the personnal pokemon
	loadSettings(PG.Pokemon1)

func FirstPokemonAssignement(Pokemon1) :
	for x in Pokemon.List :
		if x == Pokemon1.Name :
			PokemonPlayer = Pokemon.List[x].new()
	#	Load all settings of the personnal pokemon
	loadSettings(Pokemon1)
	ActualPokemon = PG.Pokemon1

func _on_UIAttaque_LoadValues():
	UIPokemonBoxScene.load_values(PokemonPlayer.Name,PokemonPlayer.Lvl,PokemonPlayer.Hp,PokemonPlayer.MaxHp,PokemonPlayer.Experience,PokemonPlayer.ExperienceNeededToLvlUp)
func loadTextures() :
	self.texture = load(PokemonPlayer.TextureBack)
