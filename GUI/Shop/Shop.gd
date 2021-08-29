extends Control

var ActualObject = ""


func _process(_delta):
	if visible :
		$Argent/Number.text = str(PG.Argent)
		$BGDown/Label.text = str(ActualObject)
		if ActualObject != null and ActualObject != "" : $BGDown/ObjectSelected.texture = load("res://img Pokemon/img Shop/Object/"+str(ActualObject) + ".png")

#BUTTONS
func _on_Potion_pressed():
	ActualObject = "Potion"
	$LineEdit.visible = true
func _on_SuperPotion_pressed():
	ActualObject = "SuperPotion"
	$LineEdit.visible = true
func _on_HyperPotion_pressed():
	ActualObject = "HyperPotion"
	$LineEdit.visible = true
func _on_MaxPotion_pressed():
	ActualObject = "MaxPotion"
	$LineEdit.visible = true
func _on_Guerison_pressed():
	ActualObject = "Guerison"
	$LineEdit.visible = true
func _on_Rappel_pressed():
	ActualObject = "Rappel"
	$LineEdit.visible = true
func _on_RappelMax_pressed():
	ActualObject = "RappelMax"
	$LineEdit.visible = true
func _on_Antidote_pressed():
	ActualObject = "Antidote"
	$LineEdit.visible = true
func _on_AntiPara_pressed():
	ActualObject = "AntiPara"
	$LineEdit.visible = true
func _on_AntiBrule_pressed():
	ActualObject = "AntiBrule"
	$LineEdit.visible = true
func _on_TotalSoin_pressed():
	ActualObject = "TotalSoin"
	$LineEdit.visible = true
func _on_Eau_pressed():
	ActualObject = "Eau"
	$LineEdit.visible = true
func _on_Soda_pressed():
	ActualObject = "Soda"
	$LineEdit.visible = true
func _on_Limonade_pressed():
	ActualObject = "Limonade"
	$LineEdit.visible = true
func _on_Lait_pressed():
	ActualObject = "Lait"
	$LineEdit.visible = true
func _on_Pokeball_pressed():
	ActualObject = "Pokeball"
	$LineEdit.visible = true
func _on_SuperBall_pressed():
	ActualObject = "SuperBall"
	$LineEdit.visible = true
func _on_HyperBall_pressed():
	ActualObject = "HyperBall"
	$LineEdit.visible = true
func _on_FiletBall_pressed():
	ActualObject = "FiletBall"
	$LineEdit.visible = true
func _on_FaibloBall_pressed():
	ActualObject = "FaibloBall"
	$LineEdit.visible = true
func _on_MasterBall_pressed():
	ActualObject = "MasterBall"
	$LineEdit.visible = true
func _on_Repousse_pressed():
	ActualObject = "Repousse"
	$LineEdit.visible = true
func _on_SuperRepousse_pressed():
	ActualObject = "SuperRepousse"
	$LineEdit.visible = true

func GetPrice() :
	if ActualObject != "" and ActualObject != null :
		return get_node(PG.ActualScene + "/GUITotal/Shop/Objets/"+ActualObject).text
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
func _on_LineEdit_text_entered(new_text):
	if (int(new_text)) and ActualObject != "" and ActualObject != null  : 
		if int(new_text)*int(GetPrice())<= PG.Argent : 
			PG.Argent -=int(new_text)*int(GetPrice())
			GetAndSetObjectToAdd(int(new_text))
		else : $LineEdit.text = "RETRY"
	else : 
		$LineEdit.text = "ERROR"

func _on_Outside_button_up():
	ActualObject = ""
	self.visible = false
	get_tree().paused = false
	Save.saveGame(false)
