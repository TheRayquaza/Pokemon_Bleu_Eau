extends ColorRect

var NewGameSur = false
var TypeOfPressed = ""
var CantChange = false

func _ready():
	$Continuer/NomJoueur.text = PG.PlayerName
	$Continuer/Temps.text = str(PG.GameTime.Hours) + ":" + str(PG.GameTime.Minutes)
func _input(event):
	if visible :
		$Continuer/NomJoueur.text = PG.PlayerName
		$Continuer/Temps.text = str(PG.GameTime.Hours) + ":" + str(PG.GameTime.Minutes)

func _on_Continuer_pressed():
	if CantChange :
		pass
	else :
		$Sure.popup()
		$Sure.dialog_text = "Continuer votre partie ?"
		$Sure.window_title = "Confirmation"
		TypeOfPressed = "Continuer"
func _on_NewGame_pressed():
	if CantChange :
		pass
	else :
		$Sure.popup()
		$Sure.dialog_text = "Commencer une nouvelle partie ?"
		$Sure.window_title = "Attention !"
		TypeOfPressed = "NewGame"
		NewGameSur = true
func _on_Credits_pressed():
	pass # Replace with function body.
func _on_Sure_confirmed():
	if NewGameSur and TypeOfPressed == "NewGame" :
		$Sure.hide()
		$NewGameForSur.popup()
		NewGameSur = false
	elif TypeOfPressed == "Continuer" : 
		CantChange = true
		$AnimationPlayer.play("ChangeScene")
		yield($AnimationPlayer,"animation_finished")
		Save.FirstTimeSave = true
		if PG.PlayerName == "1" :
			Save.restartGame()
			PG.UnUsed = get_tree().change_scene("res://Others/NewGame/NewGame.tscn")
		else : PG.UnUsed = get_tree().change_scene(PG.ActualSceneFile)
	else : NewGameSur = true
func _on_NewGameForSur_confirmed():
	NewGameSur = false
	$AnimationPlayer.play("ChangeScene")
	yield($AnimationPlayer,"animation_finished")
	Save.restartGame()
	PG.UnUsed = get_tree().change_scene("res://Others/NewGame/NewGame.tscn")
func _on_MenuSysteme_tree_entered():
	Save.loadGame()
func _on_Leave_pressed():
	get_tree().quit()
