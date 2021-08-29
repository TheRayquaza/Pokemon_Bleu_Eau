extends ColorRect

var LearnButtonActivated = false
var TheCTSelected = ""
var PokemonSelected = 0
var AttaqueSelected = 0
var LvlToGetCT
var TypeRequired

func _input(event):
	if PG.CantdisplayMenu : pass
	elif UIFight.IsFightLaunch : pass
	elif Input.is_action_pressed("ui_ct") :
		if get_parent().get_node("MenuUser").visible or get_parent().get_node("CheatConsole").visible : pass
		else :
			if visible :
				self.visible = false
				get_tree().paused = false
			else : 
				self.visible = true
				get_tree().paused = true
	if event is InputEventMouseButton:
		var focused = get_focus_owner()
		if focused != null :
			if focused is ButtonPokemonCT :
				loadValueButtonPressed(focused)
				TheCTSelected = get_node(focused.get_path()).AttackName
				LvlToGetCT = int(get_node(focused.get_path()).get_node("Lvl").text)
				TypeRequired = GetAttackDictionnary(get_node(focused.get_path()).AttackName).Type

func _ready():
	HideSecondariesThings()
	self.visible = true

#LOAD FUNCTIONS

func loadValueButtonPressed(focused):
	var TheNode = get_node(focused.get_path())
	var AttackDictionary = GetAttackDictionnary(TheNode.AttackName)
	$BGDown/MaxPP.text = str(AttackDictionary.MaxPP)
	$BGDown/Precision.text = str(AttackDictionary.Precision)
	$BGDown/Puissance.text = str(AttackDictionary.Puissance)
	$BGDown/Type.texture = Pokemon.GetImageType(AttackDictionary.Type)
func loadPokemonButton() :
	$BGDown/Pokemon/Pokemon1.visible = true
	$BGDown/Pokemon/Pokemon2.visible = true
	$BGDown/Pokemon/Pokemon3.visible = true
	$BGDown/Pokemon/Pokemon4.visible = true
	$BGDown/Pokemon/Pokemon5.visible = true
	$BGDown/Pokemon/Pokemon6.visible = true
	if PG.Pokemon1 != null : $BGDown/Pokemon/Pokemon1.text = PG.Pokemon1.Name
	else : $BGDown/Pokemon/Pokemon1.visible = false
	if PG.Pokemon2 != null : $BGDown/Pokemon/Pokemon2.text = PG.Pokemon2.Name
	else : $BGDown/Pokemon/Pokemon2.visible = false
	if PG.Pokemon3 != null : $BGDown/Pokemon/Pokemon3.text = PG.Pokemon3.Name
	else : $BGDown/Pokemon/Pokemon3.visible = false
	if PG.Pokemon4 != null : $BGDown/Pokemon/Pokemon4.text = PG.Pokemon4.Name
	else : $BGDown/Pokemon/Pokemon4.visible = false
	if PG.Pokemon5 != null : $BGDown/Pokemon/Pokemon5.text = PG.Pokemon5.Name
	else : $BGDown/Pokemon/Pokemon5.visible = false
	if PG.Pokemon6 != null : $BGDown/Pokemon/Pokemon6.text = PG.Pokemon6.Name
	else : $BGDown/Pokemon/Pokemon6.visible = false
func loadAttackButton(TheDico) :
	$BGDown/Attaques.visible = true
	$BGDown/Attaques/Attaque1.text = str(TheDico.Attaque1)
	$BGDown/Attaques/Attaque2.text = str(TheDico.Attaque2)
	$BGDown/Attaques/Attaque3.text = str(TheDico.Attaque3)
	$BGDown/Attaques/Attaque4.text = str(TheDico.Attaque4)
func HideSecondariesThings():
	$BGDown/Attaques.visible = false
	$BGDown/ConfirmButton.visible = false
	$BGDown/Pokemon.visible = false

#CONDITIONS
func Conditions(Lvl,Type1,Type2) :
	if Lvl < LvlToGetCT and (Type1 != TypeRequired and Type2 != TypeRequired) and TypeRequired != "Normal" and TypeRequired != "Tenebre" and TypeRequired != "Psy" :
		return false
	else :
		if TypeRequired == "Normal" or TypeRequired == "Tenebre" or TypeRequired == "Psy" :
			if Lvl < LvlToGetCT : return false
			else : return true
		else : return true

#GET FUNCTIONS

func GetAttackDictionnary(AttackName) :
	for x in Attaque.List : if x == AttackName : return Attaque.List[x]
func GetPokemonDictionary(Number) :
	match Number :
		1 : return PG.Pokemon1
		2 : return PG.Pokemon2
		3 : return PG.Pokemon3
		4 : return PG.Pokemon4
		5 : return PG.Pokemon5
		6 : return PG.Pokemon6
		_ : pass

#SIGNALS

func _on_LearnButton_pressed():
	loadPokemonButton()
	if LearnButtonActivated :
		LearnButtonActivated = false
		HideSecondariesThings()
	else :
		$BGDown/Pokemon.visible = true
		LearnButtonActivated = true
#POKEMONS
func _on_Pokemon1_pressed():
	loadAttackButton(PG.Pokemon1)
	PokemonSelected = 1
func _on_Pokemon2_pressed():
	loadAttackButton(PG.Pokemon2)
	PokemonSelected = 2
func _on_Pokemon3_pressed():
	loadAttackButton(PG.Pokemon3)
	PokemonSelected = 3
func _on_Pokemon4_pressed():
	loadAttackButton(PG.Pokemon4)
	PokemonSelected = 4
func _on_Pokemon5_pressed():
	loadAttackButton(PG.Pokemon5)
	PokemonSelected = 5
func _on_Pokemon6_pressed():
	loadAttackButton(PG.Pokemon6)
	PokemonSelected = 6

#ATTACKS
func _on_Attaque1_pressed():
	$BGDown/ConfirmButton.visible = true
	AttaqueSelected = 1
func _on_Attaque2_pressed():
	$BGDown/ConfirmButton.visible = true
	AttaqueSelected = 2
func _on_Attaque3_pressed():
	$BGDown/ConfirmButton.visible = true
	AttaqueSelected = 3
func _on_Attaque4_pressed():
	$BGDown/ConfirmButton.visible = true
	AttaqueSelected = 4

#CONFIRM BUTTON
func _on_ConfirmButton_pressed():
	if TheCTSelected != "" and TheCTSelected != null :
		if AttaqueSelected != 0 and PokemonSelected != 0 :
			if Conditions(GetPokemonDictionary(PokemonSelected).Lvl,GetPokemonDictionary(PokemonSelected).Type1,GetPokemonDictionary(PokemonSelected).Type2) :
				match AttaqueSelected :
					1 : GetPokemonDictionary(PokemonSelected).Attaque1 = TheCTSelected
					2 : GetPokemonDictionary(PokemonSelected).Attaque2 = TheCTSelected
					3 : GetPokemonDictionary(PokemonSelected).Attaque3 = TheCTSelected
					4 : GetPokemonDictionary(PokemonSelected).Attaque4 = TheCTSelected
				loadAttackButton(GetPokemonDictionary(PokemonSelected))
				$Confirmation.popup_centered()
				$Confirmation.dialog_text = "Votre "+ GetPokemonDictionary(PokemonSelected).Name + " a obtenu une nouvelle Attaque : "+TheCTSelected
				HideSecondariesThings()
				PokemonSelected = 0
				AttaqueSelected = 0
				Save.saveGame(false)
			else : 
				$Confirmation.popup_centered()
				$Confirmation.dialog_text = "Vous ne remplissez pas les bonnes conditions pour obtenir cette CT sur ce pokemon ! TRY AGAIN !"
				HideSecondariesThings()
				PokemonSelected = 0
				AttaqueSelected = 0
	else :
		loadAttackButton(GetPokemonDictionary(PokemonSelected))
		$Confirmation.popup_centered()
		$Confirmation.dialog_text = "ERREUR ! Vous n'avez pas selectionné de CT ! Recommencez de nouveau !"
		HideSecondariesThings()
		PokemonSelected = 0
		AttaqueSelected = 0


func _on_Outside_pressed():
	Save.saveGame(false)
	PG.UnUsed = get_tree().change_scene(PG.ActualSceneFile)


