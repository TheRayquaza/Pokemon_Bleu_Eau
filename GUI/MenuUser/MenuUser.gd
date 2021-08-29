extends Popup

var ActualPosition

func _ready():
	ActualPosition = 0

func _input(_event) :
	if PG.CantdisplayMenu :
		pass
	elif UIFight.IsFightLaunch : pass
	elif (Input.is_action_just_pressed("ui_ct")) :
		PG.NodePositionPath = "LastPosition"
		Save.saveGame(false)
		PG.UnUsed = get_tree().change_scene("res://GUI/CT/CT.tscn")
	elif (Input.is_action_just_pressed("ui_menu_user")) :
		if get_parent().get_node("CheatConsole").visible : pass
		else :
			popup()
			get_tree().paused = true
	elif visible :
		match ActualPosition :
			0 :
				$UIInfo/Text.text = "Un appareil enregistrant les infos sur les POKéMONS."
			1 :
				$UIInfo/Text.text = "Examiner et organiser les POKéMON de votre équipe."
			2 :
				$UIInfo/Text.text = "Ranger et Utiliser des objets pour vos POKéMONS."
			3 :
				$UIInfo/Text.text = "Verifier votre progression et vos informations."
			4 :
				$UIInfo/Text.text = "Sauvegarder votre partie pour faire une pause."
			5 :
				$UIInfo/Text.text = "Fermer le menu."
		if (Input.is_action_just_pressed("ui_down")) :
			match ActualPosition :
				0 :
					ActualPosition = 1
					$Arrow1.visible = false
					$Arrow2.visible = true
				1 :
					ActualPosition = 2
					$Arrow2.visible = false
					$Arrow3.visible = true
				2 :
					ActualPosition = 3
					$Arrow3.visible = false
					$Arrow4.visible = true
				3 :
					ActualPosition = 4
					$Arrow4.visible = false
					$Arrow5.visible = true
				4 :
					ActualPosition = 5
					$Arrow5.visible = false
					$Arrow6.visible = true
				_ :
					pass
		elif (Input.is_action_just_pressed("ui_up")) :
			match ActualPosition :
				1 :
					ActualPosition = 0
					$Arrow1.visible = true
					$Arrow2.visible = false
				2 :
					ActualPosition = 1
					$Arrow3.visible = false
					$Arrow2.visible = true
				3 :
					ActualPosition = 2
					$Arrow4.visible = false
					$Arrow3.visible = true
				4 :
					ActualPosition = 3
					$Arrow5.visible = false
					$Arrow4.visible = true
				5 :
					ActualPosition = 4
					$Arrow6.visible = false
					$Arrow5.visible = true
				_ :
					pass
		elif (Input.is_action_just_pressed("ui_accept")) :
			match ActualPosition :
				0 :
					PG.CantdisplayMenu = true
					$ChangeScene.play("ChangeScene")
					yield(get_node("ChangeScene"),"animation_finished")
					self.hide()
					get_node(PG.ActualScene + "/GUITotal").get_node("Pokedex").visible = true
					get_tree().paused = true
				1 :
					PG.CantdisplayMenu = true
					$ChangeScene.play("ChangeScene")
					yield(get_node("ChangeScene"),"animation_finished")
					self.hide()
					get_node(PG.ActualScene + "/GUITotal").get_node("MenuPokemon").visible = true
					get_node(PG.ActualScene + "/GUITotal").get_node("MenuPokemon").ChangePokemon = true
					get_tree().paused = true
				2 :
					PG.CantdisplayMenu = true
					$ChangeScene.play("ChangeScene")
					yield(get_node("ChangeScene"),"animation_finished")
					self.hide()
					get_node(PG.ActualScene + "/GUITotal").get_node("Bag").visible = true
					get_tree().paused = true
				3 :
					PG.CantdisplayMenu = true
					$ChangeScene.play("ChangeScene")
					yield(get_node("ChangeScene"),"animation_finished")
					self.hide()
					get_node(PG.ActualScene + "/GUITotal").get_node("Profil").visible = true
					get_tree().paused = true
				4 :
					get_tree().paused = true
					Save.saveGame(false)
					yield(get_node("LoadingSave").loading(),"completed")
				5 :
					get_tree().paused = false
					self.hide()
