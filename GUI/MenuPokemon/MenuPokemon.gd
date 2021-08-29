extends ColorRect

#Position
var ActualPosition
var ActualPositionConfirmChoice = 0
#Change Pokemon
var ChangePokemon = false
var ChangePokemonInFight = false
var ConfirmChoice = false
var Choice = null
var PokemonChoice = false
#Others
var PokemonHasChanged = null
var PokemonToChanged = ""
var TempPokemon
#For Bag
var UsingObject = false
var TheObject

func _input(_event) :
	loadsValues(PG.CheckNumberOfPokemon())
	if !self.visible or self.modulate == Color(1, 1, 1, 0):
		if ChangePokemonInFight :
			$UIInfo/RichTextLabel.text = "Remplacer votre pokemon ?"
		elif ChangePokemon :
			$UIInfo/RichTextLabel.text = "Changer l'ordre de vos pokemons ?"
		elif UsingObject :
			$UIInfo/RichTextLabel.text = "Utiliser un objet ?"
		else :
			pass
	elif ActualPosition == null : ActualPosition = 0
	elif ((Input.is_action_pressed("ui_up") or Input.is_action_just_pressed("ui_down") or Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right")) and ConfirmChoice) :
		match ActualPositionConfirmChoice :
			0 :
				ActualPositionConfirmChoice = 1
				$SpeackBox/Arrow1.visible = false
				$SpeackBox/Arrow2.visible = true
			1 :
				ActualPositionConfirmChoice = 0
				$SpeackBox/Arrow2.visible = false
				$SpeackBox/Arrow1.visible = true
	elif (Input.is_action_just_pressed("ui_accept") and ConfirmChoice) :
		ConfirmChoice = false
		match ActualPositionConfirmChoice :
			0 : Choice = true
			1 : Choice =  false
		$SpeackBox.hide()
	elif (Input.is_action_just_pressed("ui_accept") and ChangePokemon) :
		match ActualPosition :
			0 : 
				self.visible = false
				get_tree().paused = false
				ChangePokemon = false
				PG.CantdisplayMenu = false
			1 :
				ChangePokemon = false
				if (PG.CheckNumberOfPokemon() >= 6) :
					PokemonChoice = true
					PokemonToChanged = "6"
					$Out.texture = load("res://img Pokemon/img MenuPokemon/Annuler.png")
					$UIInfo/RichTextLabel.text = "Quel Pokemon ?"
				else : pass
			2 :
				ChangePokemon = false
				if (PG.CheckNumberOfPokemon() >= 5) :
					PokemonChoice = true
					PokemonToChanged = "5"
					$Out.texture = load("res://img Pokemon/img MenuPokemon/Annuler.png")
					$UIInfo/RichTextLabel.text = "Quel Pokemon ?"
				else : pass
			3 :
				ChangePokemon = false
				if (PG.CheckNumberOfPokemon() >= 4) :
					PokemonChoice = true
					PokemonToChanged = "4"
					$Out.texture = load("res://img Pokemon/img MenuPokemon/Annuler.png")
					$UIInfo/RichTextLabel.text = "Quel Pokemon ?"
				else : pass
			4 :
				ChangePokemon = false
				if (PG.CheckNumberOfPokemon() >= 3) :
					PokemonChoice = true
					PokemonToChanged = "3"
					$Out.texture = load("res://img Pokemon/img MenuPokemon/Annuler.png")
					$UIInfo/RichTextLabel.text = "Quel Pokemon ?"
				else : pass
			5 :
				ChangePokemon = false
				if (PG.CheckNumberOfPokemon() >= 2) :
					PokemonChoice = true
					PokemonToChanged = "2"
					$Out.texture = load("res://img Pokemon/img MenuPokemon/Annuler.png")
					$UIInfo/RichTextLabel.text = "Quel Pokemon ?"
				else : pass
	elif (Input.is_action_just_pressed("ui_accept") and ChangePokemonInFight) :
		match ActualPosition :
			0 : LeaveAndChangePokemon(false)
			1 :
				if (PG.CheckNumberOfPokemon() >= 6) :
					$SpeackBox.popup()
					ConfirmChoice = true
					while (Choice == null) :
						yield(get_tree().create_timer(0.1),"timeout")
					if Choice :
						PokemonToChanged = "6"
						LeaveAndChangePokemon(true)
					else : pass
					Choice = null
				else : pass
				loadsValues(PG.CheckNumberOfPokemon())
			2 :
				if (PG.CheckNumberOfPokemon() >= 5) :
					$SpeackBox.popup()
					ConfirmChoice = true
					while (Choice == null) :
						yield(get_tree().create_timer(0.1),"timeout")
					if Choice :
						PokemonToChanged = "5"
						LeaveAndChangePokemon(true)
					else : pass
					Choice = null
				else : pass
				loadsValues(PG.CheckNumberOfPokemon())
			3 :
				if (PG.CheckNumberOfPokemon() >= 4) :
					$SpeackBox.popup()
					ConfirmChoice = true
					while (Choice == null) :
						yield(get_tree().create_timer(0.1),"timeout")
					if Choice :
						PokemonToChanged = "4"
						LeaveAndChangePokemon(true)
					else : pass
					Choice = null
				else : pass
				loadsValues(PG.CheckNumberOfPokemon())
			4 :
				if (PG.CheckNumberOfPokemon() >= 3) :
					$SpeackBox.popup()
					ConfirmChoice = true
					while (Choice == null) :
						yield(get_tree().create_timer(0.1),"timeout")
					if Choice :
						PokemonToChanged = "3"
						LeaveAndChangePokemon(true)
					else : pass
					Choice = null
				else : pass
				loadsValues(PG.CheckNumberOfPokemon())
			5 :
				if (PG.CheckNumberOfPokemon() >= 2) :
					$SpeackBox.popup()
					ConfirmChoice = true
					while (Choice == null) :
						yield(get_tree().create_timer(0.1),"timeout")
					if Choice :
						PokemonToChanged = "2"
						LeaveAndChangePokemon(true)
					else : pass
					Choice = null
				else : pass
				loadsValues(PG.CheckNumberOfPokemon())
			_ : pass
	elif (Input.is_action_just_pressed("ui_accept") and PokemonChoice) :
		match ActualPosition :
			1 :
				match PokemonToChanged :
					"1" :
						if (PG.CheckNumberOfPokemon() >= 6) :
							TempPokemon = PG.Pokemon6
							PG.Pokemon6 = PG.Pokemon1
							PG.Pokemon1 = TempPokemon
							PokemonChoice = false
					"2" :
						if (PG.CheckNumberOfPokemon() >= 6) :
							TempPokemon = PG.Pokemon6
							PG.Pokemon6 = PG.Pokemon2
							PG.Pokemon2 = TempPokemon
							PokemonChoice = false
					"3" :
						if (PG.CheckNumberOfPokemon() >= 6) :
							TempPokemon = PG.Pokemon6
							PG.Pokemon6 = PG.Pokemon3
							PG.Pokemon3 = TempPokemon
							PokemonChoice = false
					"4" :
						if (PG.CheckNumberOfPokemon() >= 6) :
							TempPokemon = PG.Pokemon6
							PG.Pokemon6 = PG.Pokemon4
							PG.Pokemon4 = TempPokemon
							PokemonChoice = false
					"5" :
						if (PG.CheckNumberOfPokemon() >= 6) :
							TempPokemon = PG.Pokemon6
							PG.Pokemon6 = PG.Pokemon5
							PG.Pokemon5 = TempPokemon
							PokemonChoice = false
					_,"6" : pass
				loadsValues(PG.CheckNumberOfPokemon())
			2 :
				match PokemonToChanged :
					"1" :
						if (PG.CheckNumberOfPokemon() >= 5) :
							TempPokemon = PG.Pokemon5
							PG.Pokemon5 = PG.Pokemon1
							PG.Pokemon1 = TempPokemon
							PokemonChoice = false
					"2" :
						if (PG.CheckNumberOfPokemon() >= 5) :
							TempPokemon = PG.Pokemon5
							PG.Pokemon5 = PG.Pokemon2
							PG.Pokemon2 = TempPokemon
							PokemonChoice = false
					"3" :
						if (PG.CheckNumberOfPokemon() >= 5) :
							TempPokemon = PG.Pokemon5
							PG.Pokemon5 = PG.Pokemon3
							PG.Pokemon3 = TempPokemon
							PokemonChoice = false
					"4" :
						if (PG.CheckNumberOfPokemon() >= 5) :
							TempPokemon = PG.Pokemon5
							PG.Pokemon5 = PG.Pokemon4
							PG.Pokemon4 = TempPokemon
							PokemonChoice = false
					"6" :
						if (PG.CheckNumberOfPokemon() >= 5) :
							TempPokemon = PG.Pokemon5
							PG.Pokemon5 = PG.Pokemon6
							PG.Pokemon6 = TempPokemon
							PokemonChoice = false
					"5",_ :
						pass
				loadsValues(PG.CheckNumberOfPokemon())
			3 :
				match PokemonToChanged :
					"1" :
						if (PG.CheckNumberOfPokemon() >= 4) :
							TempPokemon = PG.Pokemon4
							PG.Pokemon4 = PG.Pokemon1
							PG.Pokemon1 = TempPokemon
							PokemonChoice = false
					"2" :
						if (PG.CheckNumberOfPokemon() >= 4) :
							TempPokemon = PG.Pokemon4
							PG.Pokemon4 = PG.Pokemon2
							PG.Pokemon2 = TempPokemon
							PokemonChoice = false
					"3" :
						if (PG.CheckNumberOfPokemon() >= 4) :
							TempPokemon = PG.Pokemon4
							PG.Pokemon4 = PG.Pokemon3
							PG.Pokemon3 = TempPokemon
							PokemonChoice = false
					"4" :
						pass
					"5" :
						if (PG.CheckNumberOfPokemon() >= 4) :
							TempPokemon = PG.Pokemon4
							PG.Pokemon4 = PG.Pokemon5
							PG.Pokemon5 = TempPokemon
							PokemonChoice = false
					"6" :
						if (PG.CheckNumberOfPokemon() >= 4) :
							TempPokemon = PG.Pokemon4
							PG.Pokemon4 = PG.Pokemon6
							PG.Pokemon6 = TempPokemon
							PokemonChoice = false
				loadsValues(PG.CheckNumberOfPokemon())
			4 :
				match PokemonToChanged :
					"1" :
						if (PG.CheckNumberOfPokemon() >= 3) :
							TempPokemon = PG.Pokemon3
							PG.Pokemon3 = PG.Pokemon1
							PG.Pokemon1 = TempPokemon
							PokemonChoice = false
					"2" :
						if (PG.CheckNumberOfPokemon() >= 3) :
							TempPokemon = PG.Pokemon3
							PG.Pokemon3 = PG.Pokemon2
							PG.Pokemon2 = TempPokemon
							PokemonChoice = false
					"3" :
						pass
					"4" :
						if (PG.CheckNumberOfPokemon() >= 3) :
							TempPokemon = PG.Pokemon3
							PG.Pokemon3 = PG.Pokemon4
							PG.Pokemon4 = TempPokemon
							PokemonChoice = false
					"5" :
						if (PG.CheckNumberOfPokemon() >=3) :
							TempPokemon = PG.Pokemon3
							PG.Pokemon3 = PG.Pokemon5
							PG.Pokemon5 = TempPokemon
							PokemonChoice = false
					"6" :
						if (PG.CheckNumberOfPokemon() >= 3) :
							TempPokemon = PG.Pokemon3
							PG.Pokemon3 = PG.Pokemon6
							PG.Pokemon6 = TempPokemon
							PokemonChoice = false
					_ : pass
				loadsValues(PG.CheckNumberOfPokemon())
			5 :
				match PokemonToChanged :
					"1" :
						if (PG.CheckNumberOfPokemon() >= 2) :
							TempPokemon = PG.Pokemon2
							PG.Pokemon2 = PG.Pokemon1
							PG.Pokemon1 = TempPokemon
							PokemonChoice = false
					"2" :
						pass
					"3" :
						if (PG.CheckNumberOfPokemon() >= 2) :
							TempPokemon = PG.Pokemon2
							PG.Pokemon2 = PG.Pokemon3
							PG.Pokemon3 = TempPokemon
							PokemonChoice = false
					"4" :
						if (PG.CheckNumberOfPokemon() >= 2) :
							TempPokemon = PG.Pokemon2
							PG.Pokemon2 = PG.Pokemon4
							PG.Pokemon4 = TempPokemon
							PokemonChoice = false
					"5" :
						if (PG.CheckNumberOfPokemon() >= 2) :
							TempPokemon = PG.Pokemon2
							PG.Pokemon2 = PG.Pokemon5
							PG.Pokemon5 = TempPokemon
							PokemonChoice = false
					"6" :
						if (PG.CheckNumberOfPokemon() >= 2) :
							TempPokemon = PG.Pokemon2
							PG.Pokemon2 = PG.Pokemon6
							PG.Pokemon6 = TempPokemon
							PokemonChoice = false
					_ : pass
				loadsValues(PG.CheckNumberOfPokemon())
			6 :
				match PokemonToChanged :
					"1" :
						pass
					"2" :
						if (PG.CheckNumberOfPokemon() >= 1) :
							TempPokemon = PG.Pokemon1
							PG.Pokemon1 = PG.Pokemon2
							PG.Pokemon2 = TempPokemon
							PokemonChoice = false
					"3" :
						if (PG.CheckNumberOfPokemon() >= 1) :
							TempPokemon = PG.Pokemon1
							PG.Pokemon1 = PG.Pokemon3
							PG.Pokemon3 = TempPokemon
							PokemonChoice = false
					"4" :
						if (PG.CheckNumberOfPokemon() >= 1) :
							TempPokemon = PG.Pokemon1
							PG.Pokemon1 = PG.Pokemon4
							PG.Pokemon4 = TempPokemon
							PokemonChoice = false
					"5" :
						if (PG.CheckNumberOfPokemon() >= 1) :
							TempPokemon = PG.Pokemon1
							PG.Pokemon1 = PG.Pokemon5
							PG.Pokemon5 = TempPokemon
							PokemonChoice = false
					"6" :
						if (PG.CheckNumberOfPokemon() >= 1) :
							TempPokemon = PG.Pokemon1
							PG.Pokemon1 = PG.Pokemon6
							PG.Pokemon6 = TempPokemon
							PokemonChoice = false
					_ : pass
				loadsValues(PG.CheckNumberOfPokemon())
		ChangePokemon = true
		PokemonChoice = false
		$Out.texture = load("res://img Pokemon/img MenuPokemon/Out.png")
		PokemonToChanged = ""
		$UIInfo/RichTextLabel.text = "Changer l'ordre de vos pokemons ?"
	elif (Input.is_action_just_pressed("ui_accept")) :
		match ActualPosition :
			0 :
				PG.CantdisplayMenu = false
				self.visible = false
				get_tree().paused = false
				ChangePokemon = false
			_ :
				pass
	elif (Input.is_action_just_pressed("ui_up")) :
		match ActualPosition :
			0 :
				ActualPosition = 1
				$Pokemon6/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-open.png")
				$Pokemon6.texture = load ("res://img Pokemon/img MenuPokemon/boxHSelected.png")
				$Empty6.texture = load ("res://img Pokemon/img MenuPokemon/EmptySelected.png")
				if PokemonChoice : pass
				else : $Out.texture = load("res://img Pokemon/img MenuPokemon/Out.png")
			1 :
				ActualPosition = 2
				$Pokemon6/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-close.png")
				$Pokemon6.texture = load ("res://img Pokemon/img MenuPokemon/boxH.png")
				$Empty6.texture = load ("res://img Pokemon/img MenuPokemon/Empty.png")
				$Pokemon5/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-open.png")
				$Pokemon5.texture = load ("res://img Pokemon/img MenuPokemon/boxHSelected.png")
				$Empty5.texture = load("res://img Pokemon/img MenuPokemon/EmptySelected.png")
			2 :
				ActualPosition = 3
				$Pokemon5/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-close.png")
				$Pokemon5.texture = load ("res://img Pokemon/img MenuPokemon/boxH.png")
				$Empty5.texture = load ("res://img Pokemon/img MenuPokemon/Empty.png")
				$Pokemon4/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-open.png")
				$Pokemon4.texture = load ("res://img Pokemon/img MenuPokemon/boxHSelected.png")
				$Empty4.texture = load("res://img Pokemon/img MenuPokemon/EmptySelected.png")
			3 :
				ActualPosition = 4
				$Pokemon4/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-close.png")
				$Pokemon4.texture = load ("res://img Pokemon/img MenuPokemon/boxH.png")
				$Empty4.texture = load ("res://img Pokemon/img MenuPokemon/Empty.png")
				$Pokemon3/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-open.png")
				$Pokemon3.texture = load ("res://img Pokemon/img MenuPokemon/boxHSelected.png")
				$Empty3.texture = load("res://img Pokemon/img MenuPokemon/EmptySelected.png")
			4 :
				ActualPosition = 5
				$Pokemon3/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-close.png")
				$Pokemon3.texture = load ("res://img Pokemon/img MenuPokemon/boxH.png")
				$Empty3.texture = load ("res://img Pokemon/img MenuPokemon/Empty.png")
				$Pokemon2/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-open.png")
				$Pokemon2.texture = load ("res://img Pokemon/img MenuPokemon/boxHSelected.png")
				$Empty2.texture = load("res://img Pokemon/img MenuPokemon/EmptySelected.png")
			_,5 :
				pass
	elif (Input.is_action_just_pressed("ui_down")) :
		match ActualPosition :
			5 :
				ActualPosition = 4
				$Pokemon2/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-close.png")
				$Pokemon2.texture = load ("res://img Pokemon/img MenuPokemon/boxH.png")
				$Empty2.texture = load ("res://img Pokemon/img MenuPokemon/Empty.png")
				$Pokemon3/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-open.png")
				$Pokemon3.texture = load ("res://img Pokemon/img MenuPokemon/boxHSelected.png")
				$Empty3.texture = load("res://img Pokemon/img MenuPokemon/EmptySelected.png")
			4 :
				ActualPosition = 3
				$Pokemon3/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-close.png")
				$Pokemon3.texture = load ("res://img Pokemon/img MenuPokemon/boxH.png")
				$Empty3.texture = load ("res://img Pokemon/img MenuPokemon/Empty.png")
				$Pokemon4/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-open.png")
				$Pokemon4.texture = load ("res://img Pokemon/img MenuPokemon/boxHSelected.png")
				$Empty4.texture = load("res://img Pokemon/img MenuPokemon/EmptySelected.png")
			3 :
				ActualPosition = 2
				$Pokemon4/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-close.png")
				$Pokemon4.texture = load ("res://img Pokemon/img MenuPokemon/boxH.png")
				$Empty4.texture = load ("res://img Pokemon/img MenuPokemon/Empty.png")
				$Pokemon5/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-open.png")
				$Pokemon5.texture = load ("res://img Pokemon/img MenuPokemon/boxHSelected.png")
				$Empty5.texture = load("res://img Pokemon/img MenuPokemon/EmptySelected.png")
			2 :
				ActualPosition = 1
				$Pokemon5/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-close.png")
				$Pokemon5.texture = load ("res://img Pokemon/img MenuPokemon/boxH.png")
				$Empty5.texture = load ("res://img Pokemon/img MenuPokemon/Empty.png")
				$Pokemon6/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-open.png")
				$Pokemon6.texture = load ("res://img Pokemon/img MenuPokemon/boxHSelected.png")
				$Empty6.texture = load("res://img Pokemon/img MenuPokemon/EmptySelected.png")
			1 :
				ActualPosition = 0
				$Pokemon6/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-close.png")
				$Pokemon6.texture = load ("res://img Pokemon/img MenuPokemon/boxH.png")
				$Empty6.texture = load ("res://img Pokemon/img MenuPokemon/Empty.png")
				if PokemonChoice : pass
				else : $Out.texture = load("res://img Pokemon/img MenuPokemon/OutOpen.png")
				$UIInfo/RichTextLabel.text = "Sortir/Annuler ?"
			0,_ :
				pass
	elif (Input.is_action_just_pressed("ui_left")) :
		match ActualPosition :
			6 :
				pass
			_ :
				ActualPosition = 6
				$Pokemon1.texture = load("res://img Pokemon/img MenuPokemon/boxPSelected.png")
				$Pokemon1/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-open.png")
				$Out.texture = load("res://img Pokemon/img MenuPokemon/Out.png")
				$Pokemon6/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-close.png")
				$Pokemon6.texture = load ("res://img Pokemon/img MenuPokemon/boxH.png")
				$Empty6.texture = load ("res://img Pokemon/img MenuPokemon/Empty.png")
				$Pokemon5/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-close.png")
				$Pokemon5.texture = load ("res://img Pokemon/img MenuPokemon/boxH.png")
				$Empty5.texture = load ("res://img Pokemon/img MenuPokemon/Empty.png")
				$Pokemon4/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-close.png")
				$Pokemon4.texture = load ("res://img Pokemon/img MenuPokemon/boxH.png")
				$Empty4.texture = load ("res://img Pokemon/img MenuPokemon/Empty.png")
				$Pokemon3/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-close.png")
				$Pokemon3.texture = load ("res://img Pokemon/img MenuPokemon/boxH.png")
				$Empty3.texture = load ("res://img Pokemon/img MenuPokemon/Empty.png")
				$Pokemon2/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-close.png")
				$Pokemon2.texture = load ("res://img Pokemon/img MenuPokemon/boxH.png")
				$Empty2.texture = load ("res://img Pokemon/img MenuPokemon/Empty.png")
	elif (Input.is_action_pressed("ui_right")) :
		match ActualPosition :
			6 :
				ActualPosition = 5
				$Pokemon1.texture = load("res://img Pokemon/img MenuPokemon/boxP.png")
				$Pokemon1/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-close.png")
				$Pokemon2.texture = load("res://img Pokemon/img MenuPokemon/boxHSelected.png")
				$Pokemon2/Pokeball.texture = load("res://img Pokemon/img MenuPokemon/pokeball-open.png")
				$Empty2.texture = load ("res://img Pokemon/img MenuPokemon/EmptySelected.png")
			_ :
				pass

#SET AND GET VALUES
func loadsValues(NumberOfPokemon) :
	match NumberOfPokemon :
		0 :
			$Pokemon1.visible = false
			$Pokemon2.visible = false
			$Pokemon3.visible = false
			$Pokemon4.visible = false
			$Pokemon5.visible = false
			$Pokemon6.visible = false
		1 :
			$Pokemon1/Name.text = PG.Pokemon1.Name
			$Pokemon1/Lvl.text = "NV." + str(PG.Pokemon1.Lvl)
			$Pokemon1/Hp/TextureProgress.value = PG.Pokemon1.Hp
			$Pokemon1/Hp/TextureProgress.max_value = PG.Pokemon1.MaxHp
			$Pokemon1/HpScript.text = str(PG.Pokemon1.Hp) + "/" + str(PG.Pokemon1.MaxHp)
			$Pokemon1/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon1.Name)
			$Pokemon2.visible = false
			$Pokemon3.visible = false
			$Pokemon4.visible = false
			$Pokemon5.visible = false
			$Pokemon6.visible = false
		2 :
			$Pokemon1/Name.text = PG.Pokemon1.Name
			$Pokemon1/Lvl.text = "NV." + str(PG.Pokemon1.Lvl)
			$Pokemon1/Hp/TextureProgress.value = PG.Pokemon1.Hp
			$Pokemon1/Hp/TextureProgress.max_value = PG.Pokemon1.MaxHp
			$Pokemon1/HpScript.text = str(PG.Pokemon1.Hp) + "/" + str(PG.Pokemon1.MaxHp)
			$Pokemon1/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon1.Name)
			$Pokemon2/Name.text = PG.Pokemon2.Name
			$Pokemon2/Lvl.text = "NV." + str(PG.Pokemon2.Lvl)
			$Pokemon2/Hp/TextureProgress.value = PG.Pokemon2.Hp
			$Pokemon2/Hp/TextureProgress.max_value = PG.Pokemon2.MaxHp
			$Pokemon2/HpScript.text = str(PG.Pokemon2.Hp) + "/" + str(PG.Pokemon2.MaxHp)
			$Pokemon2/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon2.Name)
			$Pokemon3.visible = false
			$Pokemon4.visible = false
			$Pokemon5.visible = false
			$Pokemon6.visible = false
		3 :
			$Pokemon1/Name.text = PG.Pokemon1.Name
			$Pokemon1/Lvl.text = "NV." + str(PG.Pokemon1.Lvl)
			$Pokemon1/Hp/TextureProgress.value = PG.Pokemon1.Hp
			$Pokemon1/Hp/TextureProgress.max_value = PG.Pokemon1.MaxHp
			$Pokemon1/HpScript.text = str(PG.Pokemon1.Hp) + "/" + str(PG.Pokemon1.MaxHp)
			$Pokemon1/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon1.Name)
			$Pokemon2/Name.text = PG.Pokemon2.Name
			$Pokemon2/Lvl.text = "NV." + str(PG.Pokemon2.Lvl)
			$Pokemon2/Hp/TextureProgress.value = PG.Pokemon2.Hp
			$Pokemon2/Hp/TextureProgress.max_value = PG.Pokemon2.MaxHp
			$Pokemon2/HpScript.text = str(PG.Pokemon2.Hp) + "/" + str(PG.Pokemon2.MaxHp)
			$Pokemon2/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon2.Name)
			$Pokemon3/Name.text = PG.Pokemon3.Name
			$Pokemon3/Lvl.text = "NV." + str(PG.Pokemon3.Lvl)
			$Pokemon3/Hp/TextureProgress.value = PG.Pokemon3.Hp
			$Pokemon3/Hp/TextureProgress.max_value = PG.Pokemon3.MaxHp
			$Pokemon3/HpScript.text = str(PG.Pokemon3.Hp) + "/" + str(PG.Pokemon3.MaxHp)
			$Pokemon3/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon3.Name)
			$Pokemon4.visible = false
			$Pokemon5.visible = false
			$Pokemon6.visible = false
		4 :
			$Pokemon1/Name.text = PG.Pokemon1.Name
			$Pokemon1/Lvl.text = "NV." + str(PG.Pokemon1.Lvl)
			$Pokemon1/Hp/TextureProgress.value = PG.Pokemon1.Hp
			$Pokemon1/Hp/TextureProgress.max_value = PG.Pokemon1.MaxHp
			$Pokemon1/HpScript.text = str(PG.Pokemon1.Hp) + "/" + str(PG.Pokemon1.MaxHp)
			$Pokemon1/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon1.Name)
			$Pokemon2/Name.text = PG.Pokemon2.Name
			$Pokemon2/Lvl.text = "NV." + str(PG.Pokemon2.Lvl)
			$Pokemon2/Hp/TextureProgress.value = PG.Pokemon2.Hp
			$Pokemon2/Hp/TextureProgress.max_value = PG.Pokemon2.MaxHp
			$Pokemon2/HpScript.text = str(PG.Pokemon2.Hp) + "/" + str(PG.Pokemon2.MaxHp)
			$Pokemon2/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon2.Name)
			$Pokemon3/Name.text = PG.Pokemon3.Name
			$Pokemon3/Lvl.text = "NV." + str(PG.Pokemon3.Lvl)
			$Pokemon3/Hp/TextureProgress.value = PG.Pokemon3.Hp
			$Pokemon3/Hp/TextureProgress.max_value = PG.Pokemon3.MaxHp
			$Pokemon3/HpScript.text = str(PG.Pokemon3.Hp) + "/" + str(PG.Pokemon3.MaxHp)
			$Pokemon3/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon3.Name)
			$Pokemon4/Name.text = PG.Pokemon4.Name
			$Pokemon4/Lvl.text = "NV." + str(PG.Pokemon4.Lvl)
			$Pokemon4/Hp/TextureProgress.value = PG.Pokemon4.Hp
			$Pokemon4/Hp/TextureProgress.max_value = PG.Pokemon4.MaxHp
			$Pokemon4/HpScript.text = str(PG.Pokemon4.Hp) + "/" + str(PG.Pokemon4.MaxHp)
			$Pokemon4/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon4.Name)
			$Pokemon5.visible = false
			$Pokemon6.visible = false
		5 :
			$Pokemon1/Name.text = PG.Pokemon1.Name
			$Pokemon1/Lvl.text = "NV." + str(PG.Pokemon1.Lvl)
			$Pokemon1/Hp/TextureProgress.value = PG.Pokemon1.Hp
			$Pokemon1/Hp/TextureProgress.max_value = PG.Pokemon1.MaxHp
			$Pokemon1/HpScript.text = str(PG.Pokemon1.Hp) + "/" + str(PG.Pokemon1.MaxHp)
			$Pokemon1/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon1.Name)
			$Pokemon2/Name.text = PG.Pokemon2.Name
			$Pokemon2/Lvl.text = "NV." + str(PG.Pokemon2.Lvl)
			$Pokemon2/Hp/TextureProgress.value = PG.Pokemon2.Hp
			$Pokemon2/Hp/TextureProgress.max_value = PG.Pokemon2.MaxHp
			$Pokemon2/HpScript.text = str(PG.Pokemon2.Hp) + "/" + str(PG.Pokemon2.MaxHp)
			$Pokemon2/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon2.Name)
			$Pokemon3/Name.text = PG.Pokemon3.Name
			$Pokemon3/Lvl.text = "NV." + str(PG.Pokemon3.Lvl)
			$Pokemon3/Hp/TextureProgress.value = PG.Pokemon3.Hp
			$Pokemon3/Hp/TextureProgress.max_value = PG.Pokemon3.MaxHp
			$Pokemon3/HpScript.text = str(PG.Pokemon3.Hp) + "/" + str(PG.Pokemon3.MaxHp)
			$Pokemon3/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon3.Name)
			$Pokemon4/Name.text = PG.Pokemon4.Name
			$Pokemon4/Lvl.text = "NV." + str(PG.Pokemon4.Lvl)
			$Pokemon4/Hp/TextureProgress.value = PG.Pokemon4.Hp
			$Pokemon4/Hp/TextureProgress.max_value = PG.Pokemon4.MaxHp
			$Pokemon4/HpScript.text = str(PG.Pokemon4.Hp) + "/" + str(PG.Pokemon4.MaxHp)
			$Pokemon4/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon4.Name)
			$Pokemon5/Name.text = PG.Pokemon5.Name
			$Pokemon5/Lvl.text = "NV." + str(PG.Pokemon5.Lvl)
			$Pokemon5/Hp/TextureProgress.value = PG.Pokemon5.Hp
			$Pokemon5/Hp/TextureProgress.max_value = PG.Pokemon5.MaxHp
			$Pokemon5/HpScript.text = str(PG.Pokemon5.Hp) + "/" + str(PG.Pokemon5.MaxHp)
			$Pokemon5/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon5.Name)
			$Pokemon6.visible = false
		6 :
			$Pokemon1/Name.text = PG.Pokemon1.Name
			$Pokemon1/Lvl.text = "NV." + str(PG.Pokemon1.Lvl)
			$Pokemon1/Hp/TextureProgress.value = PG.Pokemon1.Hp
			$Pokemon1/Hp/TextureProgress.max_value = PG.Pokemon1.MaxHp
			$Pokemon1/HpScript.text = str(PG.Pokemon1.Hp) + "/" + str(PG.Pokemon1.MaxHp)
			$Pokemon1/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon1.Name)
			$Pokemon2/Name.text = PG.Pokemon2.Name
			$Pokemon2/Lvl.text = "NV." + str(PG.Pokemon2.Lvl)
			$Pokemon2/Hp/TextureProgress.value = PG.Pokemon2.Hp
			$Pokemon2/Hp/TextureProgress.max_value = PG.Pokemon2.MaxHp
			$Pokemon2/HpScript.text = str(PG.Pokemon2.Hp) + "/" + str(PG.Pokemon2.MaxHp)
			$Pokemon2/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon2.Name)
			$Pokemon3/Name.text = PG.Pokemon3.Name
			$Pokemon3/Lvl.text = "NV." + str(PG.Pokemon3.Lvl)
			$Pokemon3/Hp/TextureProgress.value = PG.Pokemon3.Hp
			$Pokemon3/Hp/TextureProgress.max_value = PG.Pokemon3.MaxHp
			$Pokemon3/HpScript.text = str(PG.Pokemon3.Hp) + "/" + str(PG.Pokemon3.MaxHp)
			$Pokemon3/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon3.Name)
			$Pokemon4/Name.text = PG.Pokemon4.Name
			$Pokemon4/Lvl.text = "NV." + str(PG.Pokemon4.Lvl)
			$Pokemon4/Hp/TextureProgress.value = PG.Pokemon4.Hp
			$Pokemon4/Hp/TextureProgress.max_value = PG.Pokemon4.MaxHp
			$Pokemon4/HpScript.text = str(PG.Pokemon4.Hp) + "/" + str(PG.Pokemon4.MaxHp)
			$Pokemon4/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon4.Name)
			$Pokemon5/Name.text = PG.Pokemon5.Name
			$Pokemon5/Lvl.text = "NV." + str(PG.Pokemon5.Lvl)
			$Pokemon5/Hp/TextureProgress.value = PG.Pokemon5.Hp
			$Pokemon5/Hp/TextureProgress.max_value = PG.Pokemon5.MaxHp
			$Pokemon5/HpScript.text = str(PG.Pokemon5.Hp) + "/" + str(PG.Pokemon5.MaxHp)
			$Pokemon5/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon5.Name)
			$Pokemon6/Name.text = PG.Pokemon6.Name
			$Pokemon6/Lvl.text = "NV." + str(PG.Pokemon6.Lvl)
			$Pokemon6/Hp/TextureProgress.value = PG.Pokemon6.Hp
			$Pokemon6/Hp/TextureProgress.max_value = PG.Pokemon6.MaxHp
			$Pokemon6/HpScript.text = str(PG.Pokemon6.Hp) + "/" + str(PG.Pokemon6.MaxHp)
			$Pokemon6/PokemonTexture.texture = Pokemon.GetImageOverworld(PG.Pokemon6.Name)
		_ :
			$Pokemon1.visible = false
			$Pokemon2.visible = false
			$Pokemon3.visible = false
			$Pokemon4.visible = false
			$Pokemon5.visible = false
			$Pokemon6.visible = false

#REPEAT FONCTIONS
	#IMPORTANT FUNCTIONS
func LeaveAndChangePokemon(boole) :
	PG.CantdisplayMenu = false
	PokemonHasChanged = boole
	ChangePokemonInFight = false
	ConfirmChoice = false
	Choice = null
	TempPokemon = null
	ActualPosition = null
	self.visible = false
#OTHERS FUNCTIONS
func CheckLife(Life,MaxLife) :
	if Life < 0 :
		return "dead"
	elif Life <= MaxLife :
		return false
	else :
		return true
