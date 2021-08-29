extends ColorRect

onready var player = get_node(PG.ActualScene + "/Player")

var TextEditBool1 = false
var TextEditBool2 = false

var ActualObject = ""

func _ready():
	HideEverything()
	self.visible = false
func _input(event):
	if PG.CantdisplayMenu: pass
	elif UIFight.IsFightLaunch : pass
	elif (Input.is_action_just_pressed("ui_cheat_console")) :
		if get_parent().get_node("MenuUser").visible : pass
		elif visible :
			HideEverything()
			get_node(PG.ActualScene + "/GUITotal/CheatConsole").visible = false
			get_tree().paused = false
		else : 
			HideSecondaryThings()
			get_node(PG.ActualScene + "/GUITotal/CheatConsole").visible = true
			get_tree().paused = true

#OTHERS
func HideEverything() :
	$PositionPopup.hide()
	$ObjetsPopup.hide()
	$ArgentPopup.hide()
	HideSecondaryThings()
func HideSecondaryThings() :
	$PositionPopup/ChoixEdit.visible = false
	$PositionPopup/ChoixEdit2.visible = false
	$PositionPopup/ValiderChoix.visible = false
	$PositionPopup/Scenepopup.hide()
	$ObjetsPopup.hide()

func GetAndSetObjectToAdd(number):
	match ActualObject :
		"Potion" : PG.AllObject["NumberObject"].Potion += number
		"SuperPotion" : PG.AllObject["NumberObject"].SuperPotion += number
		"HyperPotion" : PG.AllObject["NumberObject"].HyperPotion += number
		"MaxPotion" : PG.AllObject["NumberObject"].MaxPotion += number
		"Guerison" : PG.AllObject["NumberObject"].Guerison += number
		"Rappel" : PG.AllObject["NumberObject"].Rappel += number
		"RappelMax" : PG.AllObject["NumberObject"].RappelMax += number
		"Antidote" : PG.AllObject["NumberObject"].Antidote += number
		"AntiPara" : PG.AllObject["NumberObject"].AntiPara += number
		"AntiBrule" : PG.AllObject["NumberObject"].AntiBrule += number
		"TotalSoin" : PG.AllObject["NumberObject"].TotalSoin += number
		"Eau" : PG.AllObject["NumberObject"].Eau += number
		"Soda" : PG.AllObject["NumberObject"].Soda += number
		"Limonade" : PG.AllObject["NumberObject"].Limonade += number
		"Lait" : PG.AllObject["NumberObject"].Lait += number
		"Pokeball" : PG.AllObject["NumberObject"].Pokeball += number
		"SuperBall" : PG.AllObject["NumberObject"].SuperBall += number
		"HyperBall" : PG.AllObject["NumberObject"].HyperBall += number
		"FiletBall" : PG.AllObject["NumberObject"].FiletBall += number
		"FaibloBall" : PG.AllObject["NumberObject"].FaibloBall += number
		"MasterBall" : PG.AllObject["NumberObject"].MasterBall += number
		"Repousse" : PG.AllObject["NumberObject"].Repousse += number
		"SuperRepousse" : PG.AllObject["NumberObject"].SuperRepousse += number
#POSITION :
func _on_Position_pressed():
	$PositionPopup.popup_centered()

func _on_Origine_pressed():
	HideEverything()
	self.visible = false
	get_tree().paused = false
	player.position = Vector2(0,0)
	Save.saveGame(false)
func _on_Choix_pressed():
	HideSecondaryThings()
	$PositionPopup/ChoixEdit.visible = true
	$PositionPopup/ChoixEdit2.visible = true
	$PositionPopup/ValiderChoix.visible = true
func _on_ChoixEdit_text_changed(new_text):
	if float(new_text) or new_text == "-" : TextEditBool1 = true
	else : 
		TextEditBool1 = false
		$PositionPopup/ChoixEdit.text = "ERROR"
func _on_ChoixEdit2_text_changed(new_text):
	if float(new_text) or new_text == "-" : TextEditBool2 = true
	else : 
		TextEditBool2 = false
		$PositionPopup/ChoixEdit2.text = "ERROR"
func _on_ValiderChoix_pressed():
	if TextEditBool1 and TextEditBool2 :
		player.position = Vector2(float($PositionPopup/ChoixEdit.text),float($PositionPopup/ChoixEdit2.text))
		HideEverything()
		self.visible = false
		get_tree().paused = false
		Save.saveGame(false)
#MAIN
func _on_Scene_pressed():
	HideSecondaryThings()
	$PositionPopup/Scenepopup.popup_centered()
#SECONDARIES
func _on_StartHouse_pressed():
	get_tree().paused = false
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/BourgPalette/StartHouse1-Down.tscn")
func _on_LaboChen_pressed():
	get_tree().paused = false
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/BourgPalette/LaboChen.tscn")
func _on_PokemonCenterJadielle_pressed():
	get_tree().paused = false
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/PokemonCenter/PokemonCenterInside - Jadielle.tscn")
func _on_PokemonCenterArgenta_pressed():
	get_tree().paused = false
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/PokemonCenter/PokemonCenterInside - Argenta.tscn")
func _on_ShopJadielle_pressed():
	get_tree().paused = false
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/Shop/Shop - Jadielle.tscn")
func _on_ShopArgenta_pressed():
	get_tree().paused = false
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/Shop/Shop - Argenta.tscn")
func _on_Musee_pressed():
	get_tree().paused = false
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/Argenta/Musee.tscn")
func _on_ForetJade_pressed():
	get_tree().paused = false
	PG.UnUsed = get_tree().change_scene("res://Map/AllInsideObject/ForetDeJade/ForetDeJade.tscn")

#OBJETS :
func _on_Objets_pressed(): $ObjetsPopup.popup_centered()
func _on_Potion_pressed(): ActualObject = "Potion"
func _on_SuperPotion_pressed(): ActualObject = "SuperPotion"
func _on_HyperPotion_pressed(): ActualObject = "HyperPotion"
func _on_Guerison_pressed(): ActualObject = "Guerison"
func _on_Rappel_pressed(): ActualObject = "Rappel"
func _on_RappelMax_pressed(): ActualObject = "RappelMax"
func _on_Antidote_pressed(): ActualObject = "Antidote"
func _on_AntiBrule_pressed(): ActualObject = "AntiBrule"
func _on_TotalSoin_pressed(): ActualObject = "TotalSoin"
func _on_Pokeball_pressed(): ActualObject = "Pokeball"
func _on_SuperBall_pressed(): ActualObject = "SuperBall"
func _on_HyperBall_pressed(): ActualObject = "HyperBall"
func _on_MasterBall_pressed(): ActualObject = "MasterBall"
func _on_Repousse_pressed(): ActualObject = "Repousse"
func _on_SuperRepousse_pressed(): ActualObject = "SuperRepousse"
func _on_LineEdit_text_entered(new_text):
	if ActualObject == null or ActualObject == "" or !int(new_text) : $ObjetsPopup/LineEdit.text = "ERROR"
	else : 
		GetAndSetObjectToAdd(int(new_text))
		$ObjetsPopup/LineEdit.text = "OBJET AJOUTE !"
	Save.saveGame(false)

#ARGENT :
func _on_Argent_pressed():
	$ArgentPopup.popup_centered()
func _on_Valider_pressed():
	if int($ArgentPopup/ArgentAdd.text) :
		PG.Argent += int($ArgentPopup/ArgentAdd.text)
		HideEverything()
		self.visible = false
		get_tree().paused = false
		Save.saveGame(false)
	else : $ArgentPopup/ArgentAdd.text = "ERROR"
