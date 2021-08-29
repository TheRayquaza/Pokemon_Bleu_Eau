extends ColorRect

var ActualPokemon = ""

func _ready():
	loadModulate()

func _input(event):
	if visible :
		loadModulate()
	if Input.is_action_just_pressed("ui_accept") and ActualPokemon != "" :
		if GetNodePath(ActualPokemon).modulate == Color.black :
			pass
		else :
			$Description1.texture_normal = load("res://img Pokemon/img Pokedex/Description/"+ActualPokemon + ".png")
			$Description2.texture_normal = load("res://img Pokemon/img Pokedex/Description/"+ActualPokemon + "2.png")
			$Description1.visible = true

#IMPORTANT BUTTONS
func _on_OutsideButton_pressed():
	PG.CantdisplayMenu = false
	get_tree().paused = false
	self.visible = false
func _on_Description1_pressed():
	$Description1.visible = false
	$Description2.visible = true
func _on_Description2_pressed():
	$Description2.visible = false

#BUTTONS POKEMON
func _on_Bulbizarre_pressed():
	ActualPokemon = "Bulbizarre"
func _on_Herbizarre_pressed():
	ActualPokemon = "Herbizarre"
func _on_Florizarre_pressed():
	ActualPokemon = "Florizarre"
func _on_Salameche_pressed():
	ActualPokemon = "Salameche"
func _on_Reptincel_pressed():
	ActualPokemon = "Reptincel"
func _on_Dracaufeu_pressed():
	ActualPokemon = "Dracaufeu"
func _on_Carapuce_pressed():
	ActualPokemon = "Carapuce"
func _on_Carabaffe_pressed():
	ActualPokemon = "Carabaffe"
func _on_Tortank_pressed():
	ActualPokemon = "Tortank"
func _on_Chenipan_pressed():
	ActualPokemon = "Chenipan"
func _on_Chrysacier_pressed():
	ActualPokemon = "Chrysacier"
func _on_Papilusion_pressed():
	ActualPokemon = "Papilusion"
func _on_Aspicot_pressed():
	ActualPokemon = "Aspicot"
func _on_Coconfort_pressed():
	ActualPokemon = "Coconfort"
func _on_Dardagnan_pressed():
	ActualPokemon = "Dardagnan"
func _on_Roucool_pressed():
	ActualPokemon = "Roucool"
func _on_Roucoups_pressed():
	ActualPokemon = "Roucoups"
func _on_Roucanarge_pressed():
	ActualPokemon = "Roucarnage"
func _on_Rattata_pressed():
	ActualPokemon = "Rattata"
func _on_Rattatac_pressed():
	ActualPokemon = "Rattatac"

func loadModulate() :
	for x in Pokedex.PokedexList["AllDiscover"] :
		if !Pokedex.PokedexList["AllDiscover"][x] :
			GetNodePath(x).modulate = Color.black
			GetNodePath(x).get_node("Name").visible = false
		else :
			GetNodePath(x).modulate = Color.white
			GetNodePath(x).get_node("Name").visible = true

func GetNodePath(x) :
	var ThePath
	match x :
		"Bulbizarre" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon1/Bulbizarre")
		"Herbizarre" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon1/Herbizarre")
		"Florizarre" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon1/Florizarre")
		"Salameche" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon1/Salameche")
		"Reptincel" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon1/Reptincel")
		"Dracaufeu" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon1/Dracaufeu")
		"Carapuce" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon2/Carapuce")
		"Carabaffe" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon2/Carabaffe")
		"Tortank" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon2/Tortank")
		"Chenipan" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon2/Chenipan")
		"Chrysacier" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon2/Chrysacier")
		"Papilusion" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon2/Papilusion")
		"Aspicot" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon3/Aspicot")
		"Coconfort" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon3/Coconfort")
		"Dardagnan" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon3/Dardagnan")
		"Roucool" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon3/Roucool")
		"Roucoups" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon3/Roucoups")
		"Roucarnage" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon3/Roucarnage")
		"Rattata" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon4/Rattata")
		"Rattatac" : ThePath = get_node("All Pokemon/VBoxContainer/Pokemon4/Rattatac")
	return ThePath
