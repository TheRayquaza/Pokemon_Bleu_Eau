extends ColorRect

var Price = 0
var PokemonSelected = 0

func _ready():
	self.visible = false

func _input(event):
	$Price.text = str(Price)
	loadPokemonButton()
#LOAD FUNCTIONS

func loadPokemonButton() :
	if PG.Pokemon1 != null : $Pokemon1.text = PG.Pokemon1.Name
	else : $Pokemon1.visible = false
	if PG.Pokemon2 != null : $Pokemon2.text = PG.Pokemon2.Name
	else : $Pokemon2.visible = false
	if PG.Pokemon3 != null : $Pokemon3.text = PG.Pokemon3.Name
	else : $Pokemon3.visible = false
	if PG.Pokemon4 != null : $Pokemon4.text = PG.Pokemon4.Name
	else : $Pokemon4.visible = false
	if PG.Pokemon5 != null : $Pokemon5.text = PG.Pokemon5.Name
	else : $Pokemon5.visible = false
	if PG.Pokemon6 != null : $Pokemon6.text = PG.Pokemon6.Name
	else : $Pokemon6.visible = false

#GET FUNCTIONS
func GetPokemonDictionary(Number) :
	match Number :
		1 : return PG.Pokemon1
		2 : return PG.Pokemon2
		3 : return PG.Pokemon3
		4 : return PG.Pokemon4
		5 : return PG.Pokemon5
		6 : return PG.Pokemon6
		_ : pass

#CALCUL
func calculPrice(TheDico) :
	match TheDico.Name :
		"Bulbizarre","Salameche","Carapuce" : Price += 10000
		"Reptincel","Carabaffe","Herbizarre" : Price += 50000
		"Roucool","Rattata","Chenipan","Aspicot" : Price += 100
		"Chrysacier","Coconfort","Roucoups" : Price += 500
		"Papilusion","Dardagnan","Rattatac": Price += 1500
		"Roucarnage","Florizarre","Dracaufeu","Tortank" : Price += 100000
		"Rayquaza" : Price += 10000000
	Price *= pow(TheDico.Lvl,0.3)
	Price = int(round(Price))
#POKEMONS
func _on_Pokemon1_pressed():
	pass
func _on_Pokemon2_pressed():
	Price = 0
	PokemonSelected = 2
	calculPrice(GetPokemonDictionary(PokemonSelected))
func _on_Pokemon3_pressed():
	Price = 0
	PokemonSelected = 3
	calculPrice(GetPokemonDictionary(PokemonSelected))
func _on_Pokemon4_pressed():
	Price = 0
	PokemonSelected = 4
	calculPrice(GetPokemonDictionary(PokemonSelected))
func _on_Pokemon5_pressed():
	Price = 0
	PokemonSelected = 5
	calculPrice(GetPokemonDictionary(PokemonSelected))
func _on_Pokemon6_pressed():
	Price = 0
	PokemonSelected = 6
	calculPrice(GetPokemonDictionary(PokemonSelected))

#CONFIRM BUTTON

func _on_Outside_pressed():
	Save.saveGame(false)
	self.visible = false
	get_tree().paused = false

func _on_ConfirmButton_pressed():
	match PokemonSelected :
		2 : PG.Pokemon2 = null
		3 : PG.Pokemon3 = null
		4 : PG.Pokemon4 = null
		5 : PG.Pokemon5 = null
		6 : PG.Pokemon6 = null
		_ : pass
	PG.Argent += Price
	Price = 0
