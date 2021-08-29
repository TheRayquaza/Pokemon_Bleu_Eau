extends Popup

onready var UiFight = get_node("/root/FightScene/UIFight")
onready var UiFight_Text = get_node("/root/FightScene/UIFight/Text")
onready var UiFight_ShowText = get_node("/root/FightScene/UIFight/ShowText")
onready var UiAction = get_node("/root/FightScene/UIAction")
onready var AttaqueAnimation = get_node("/root/FightScene/AttaqueAnimation")
onready var UiPokemonBox = get_node("/root/FightScene/UIPokemonBox/AnimationPlayer")
onready var UiPokemonBoxE = get_node("/root/FightScene/UIPokemonBoxEnnemi/AnimationPlayer")

onready var PokemonPlayer = get_node("/root/FightScene/PokemonPlayer")
onready var PokemonEnnemi = get_node("/root/FightScene/PokemonEnnemi")
var actual_arrow

signal ChangeUIFightText
signal AboutLoadingValues
signal LoadValues
signal ChangeStatut(TheStatut)
signal ChangeStatutE(TheStatut)
signal ProcessRepeatOthersSignal

func DisplayUIAttaque():
	loadGUIScript()
	popup()
	yield(get_tree().create_timer(0.2),"timeout")
	actual_arrow = 0
	$UIAttaqueInformation1.popup()
	$Arrow1.visible = true
	$Arrow2.visible = false
	$Arrow3.visible = false
	$Arrow4.visible = false

func loadGUIScript() :
#	UIAtaque
#	Attaque 1
	$Attaque1.text = PokemonPlayer.PokemonPlayer.Attaque1
#	Attaque 2
	$Attaque2.text = PokemonPlayer.PokemonPlayer.Attaque2
#	Attaque 3
	$Attaque3.text = PokemonPlayer.PokemonPlayer.Attaque3
#	Attaque 4
	$Attaque4.text = PokemonPlayer.PokemonPlayer.Attaque4
#	UIAttaqueInformation
	$UIAttaqueInformation1/BG/TextureRect/NumberOfPP.text = str(PokemonPlayer.PokemonPlayer.ActualPPAttaque1) + "/" + str(Attaque.GetAttaqueMaxPP(PokemonPlayer.PokemonPlayer.Attaque1))
	$UIAttaqueInformation1/BG/TextureRect/Type.text = "TYPE/" + str(Attaque.GetAttaqueType(PokemonPlayer.PokemonPlayer.Attaque1))
	$UIAttaqueInformation2/BG/TextureRect/NumberOfPP.text = str(PokemonPlayer.PokemonPlayer.ActualPPAttaque2) + "/" + str(Attaque.GetAttaqueMaxPP(PokemonPlayer.PokemonPlayer.Attaque2))
	$UIAttaqueInformation2/BG/TextureRect/Type.text = "TYPE/" + str(Attaque.GetAttaqueType(PokemonPlayer.PokemonPlayer.Attaque2))
	$UIAttaqueInformation3/BG/TextureRect/NumberOfPP.text = str(PokemonPlayer.PokemonPlayer.ActualPPAttaque3) + "/" + str(Attaque.GetAttaqueMaxPP(PokemonPlayer.PokemonPlayer.Attaque3))
	$UIAttaqueInformation3/BG/TextureRect/Type.text = "TYPE/" + str(Attaque.GetAttaqueType(PokemonPlayer.PokemonPlayer.Attaque3))
	$UIAttaqueInformation4/BG/TextureRect/NumberOfPP.text = str(PokemonPlayer.PokemonPlayer.ActualPPAttaque4) + "/" + str(Attaque.GetAttaqueMaxPP(PokemonPlayer.PokemonPlayer.Attaque4))
	$UIAttaqueInformation4/BG/TextureRect/Type.text = "TYPE/" + str(Attaque.GetAttaqueType(PokemonPlayer.PokemonPlayer.Attaque4))

func _input(_event):
	if !self.visible :
		pass
	elif (Input.is_action_pressed("ui_accept")) :
			match actual_arrow :
#				GetFirstOpenent,GetAttaque and Use, Animation, process repeat
				null :
					pass
				0 :
					if Attaque.CheckPP(PokemonPlayer.PokemonPlayer,"1") :
						$UIAttaqueInformation1.hide()
						self.hide()
						yield(ProcessRepeat(Attaque.GetFirstAttacker(PokemonPlayer.PokemonPlayer.Vitesse,PokemonEnnemi.PokemonEnnemi.Vitesse,PokemonPlayer.PokemonPlayer.Attaque1),PokemonPlayer.PokemonPlayer.Attaque1,false,null),"completed")
						UiFight_Text.text = "Que va faire " + PokemonPlayer.PokemonPlayer.Name + " ?"
						UiAction.popup()
						actual_arrow = null
					else :
						UiFight.changeText("Vous ne pouvez plus utiliser cette attaque !")
				1 :
					if Attaque.CheckPP(PokemonPlayer.PokemonPlayer,"2") :
						$UIAttaqueInformation2.hide()
						self.hide()
						yield(ProcessRepeat(Attaque.GetFirstAttacker(PokemonPlayer.PokemonPlayer.Vitesse,PokemonEnnemi.PokemonEnnemi.Vitesse,PokemonPlayer.PokemonPlayer.Attaque2),PokemonPlayer.PokemonPlayer.Attaque2,false,null),"completed")
						UiFight_Text.text = "Que va faire " + PokemonPlayer.PokemonPlayer.Name + " ?"
						UiAction.popup()
						actual_arrow = null
					else :
						UiFight.changeText("Vous ne pouvez plus utiliser cette attaque !")
				2 :
					if Attaque.CheckPP(PokemonPlayer.PokemonPlayer,"3") :
						$UIAttaqueInformation3.hide()
						self.hide()
						yield(ProcessRepeat(Attaque.GetFirstAttacker(PokemonPlayer.PokemonPlayer.Vitesse,PokemonEnnemi.PokemonEnnemi.Vitesse,PokemonPlayer.PokemonPlayer.Attaque3),PokemonPlayer.PokemonPlayer.Attaque3,false,null),"completed")
						UiFight_Text.text = "Que va faire " + PokemonPlayer.PokemonPlayer.Name + " ?"
						UiAction.popup()
						actual_arrow = null
					else :
						UiFight.changeText("Vous ne pouvez plus utiliser cette attaque !")
				3 :
					if Attaque.CheckPP(PokemonPlayer.PokemonPlayer,"4") :
						$UIAttaqueInformation4.hide()
						self.hide()
						yield(ProcessRepeat(Attaque.GetFirstAttacker(PokemonPlayer.PokemonPlayer.Vitesse,PokemonEnnemi.PokemonEnnemi.Vitesse,PokemonPlayer.PokemonPlayer.Attaque4),PokemonPlayer.PokemonPlayer.Attaque4,false,null),"completed")
						UiFight_Text.text = "Que va faire " + PokemonPlayer.PokemonPlayer.Name + " ?"
						UiAction.popup()
						actual_arrow = null
					else :
						UiFight.changeText("Vous ne pouvez plus utiliser cette attaque !")
	elif ((Input.is_action_just_pressed("ui_down")) or (Input.is_action_just_pressed("ui_up")) and visible) :
		match actual_arrow :
			null :
				pass
			0 :
				$UIAttaqueInformation1.hide()
				$UIAttaqueInformation3.popup()
				actual_arrow = 2
				$Arrow1.visible = false
				$Arrow3.visible = true
			1 :
				$UIAttaqueInformation2.hide()
				$UIAttaqueInformation4.popup()
				actual_arrow = 3
				$Arrow2.visible = false
				$Arrow4.visible = true
			2 :
				$UIAttaqueInformation3.hide()
				$UIAttaqueInformation1.popup()
				actual_arrow = 0
				$Arrow1.visible = true
				$Arrow3.visible = false
			3 :
				$UIAttaqueInformation4.hide()
				$UIAttaqueInformation2.popup()
				actual_arrow = 1
				$Arrow2.visible = true
				$Arrow4.visible = false
	elif ((Input.is_action_just_pressed("ui_left")) or (Input.is_action_just_pressed("ui_right")) and visible) :
		match actual_arrow :
			null :
				pass
			0 :
				$UIAttaqueInformation1.hide()
				$UIAttaqueInformation2.popup()
				actual_arrow = 1
				$Arrow1.visible = false
				$Arrow2.visible = true
			1 :
				$UIAttaqueInformation2.hide()
				$UIAttaqueInformation1.popup()
				actual_arrow = 0
				$Arrow2.visible = false
				$Arrow1.visible = true
			2 :
				$UIAttaqueInformation3.hide()
				$UIAttaqueInformation4.popup()
				actual_arrow = 3
				$Arrow4.visible = true
				$Arrow3.visible = false
			3 :
				$UIAttaqueInformation4.hide()
				$UIAttaqueInformation3.popup()
				actual_arrow = 2
				$Arrow3.visible = true
				$Arrow4.visible = false
	elif(Input.is_action_just_pressed("ui_cancel")) :
		actual_arrow = null
		self.hide()
		$UIAttaqueInformation1.hide()
		$UIAttaqueInformation2.hide()
		$UIAttaqueInformation3.hide()
		$UIAttaqueInformation4.hide()
		UiAction.popup()
		UiFight_Text.text = "Que va faire " + PokemonPlayer.PokemonPlayer.Name + " ?"

func ProcessRepeat(FirstAttacker,TheAttaque,SpecialProcessRepeat,StringSpecial) :
	PokemonPlayer.saveParameters(PokemonPlayer.ActualPokemon)
	get_node("/root/FightScene/AnimationPlayer").stop()
	UIFight.CantPassTxt = true
	if SpecialProcessRepeat :
		if StringSpecial == "Player" :
			Attaque.IsPlayerTheFirstAttacker = true
			self.hide()
			UiFight.changeText(PokemonPlayer.PokemonPlayer.Name + " utilise " + TheAttaque + " !")
			yield(UiFight_ShowText,"animation_finished")
			if Attaque.CheckSuccess("Player",TheAttaque) :
				AttaqueAnimation.play(TheAttaque+Attaque.SpecialAnimation)
				emit_signal("AboutLoadingValues")
				Attaque.CheckAttack(TheAttaque,PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi,"Player")
				yield(get_tree().create_timer(1),"timeout")
				Attaque.EventText("Player")
				if (Attaque.EvenText != "") :
					UiFight.changeText(Attaque.EvenText)
					yield(UiFight_ShowText,"animation_finished")
				if (Attaque.SpecialText != "") :
					UiFight.changeText(Attaque.SpecialText)
					yield(UiFight_ShowText,"animation_finished")
					Attaque.SpecialText = ""
				emit_signal("ChangeStatutE",Attaque.GetAndSetStatut(PokemonEnnemi.PokemonEnnemi))
			else :
				UiFight.changeText(PokemonPlayer.PokemonPlayer.Name + " rate son attaque !")
				yield(UiFight_ShowText,"animation_finished")
			emit_signal("LoadValues")
			yield(ProcessRepeatOthers(),"completed")
		else :
			Attaque.IsPlayerTheFirstAttacker = false
			self.hide()
			var AttaqueEnnemi = PokemonEnnemi.EnnemiLaunchAttack()
			yield(get_tree().create_timer(0.75),"timeout")
			UiFight.changeText(PokemonEnnemi.PokemonEnnemi.Name + " utilise " + AttaqueEnnemi + " !")
			yield(UiFight_ShowText,"animation_finished")
			if Attaque.CheckSuccess("Ennemi",AttaqueEnnemi) :
				AttaqueAnimation.play(AttaqueEnnemi+" E")
				emit_signal("AboutLoadingValues")
				Attaque.CheckAttack(AttaqueEnnemi,PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi,"Ennemi")
				yield(get_tree().create_timer(1),"timeout")
				Attaque.EventText("Ennemi")
				if (Attaque.EvenText != "") :
					UiFight.changeText(Attaque.EvenText)
					yield(UiFight_ShowText,"animation_finished")
				if (Attaque.SpecialText != "") :
					UiFight.changeText(Attaque.SpecialText)
					yield(UiFight_ShowText,"animation_finished")
					Attaque.SpecialText = ""
				emit_signal("ChangeStatut",Attaque.GetAndSetStatut(PokemonPlayer.PokemonPlayer))
			else :
				UiFight.changeText(PokemonEnnemi.PokemonEnnemi.Name + " rate son attaque !")
				yield(UiFight_ShowText,"animation_finished")
			yield(CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi),"completed")
			emit_signal("LoadValues")
			yield(ProcessRepeatOthers(),"completed")
		UIFight.CantPassTxt = false
	else :
		if FirstAttacker :
			Attaque.IsPlayerTheFirstAttacker = true
			self.hide()
			UiFight.changeText(PokemonPlayer.PokemonPlayer.Name + " utilise " + TheAttaque + " !")
			yield(UiFight_ShowText,"animation_finished")
			if Attaque.CheckSuccess("Player",TheAttaque) :
				AttaqueAnimation.play(TheAttaque+Attaque.SpecialAnimation)
				emit_signal("AboutLoadingValues")
				Attaque.CheckAttack(TheAttaque,PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi,"Player")
				yield(get_tree().create_timer(1),"timeout")
				Attaque.EventText("Player")
				if (Attaque.EvenText != "") :
					UiFight.changeText(Attaque.EvenText)
					yield(UiFight_ShowText,"animation_finished")
				if (Attaque.SpecialText != "") :
					UiFight.changeText(Attaque.SpecialText)
					yield(UiFight_ShowText,"animation_finished")
					Attaque.SpecialText = ""
				emit_signal("ChangeStatutE",Attaque.GetAndSetStatut(PokemonEnnemi.PokemonEnnemi))
			else :
				UiFight.changeText(PokemonPlayer.PokemonPlayer.Name + " rate son attaque !")
				yield(UiFight_ShowText,"animation_finished")
			emit_signal("LoadValues")
			yield(CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi),"completed")
			var AttaqueEnnemi = PokemonEnnemi.EnnemiLaunchAttack()
			yield(get_tree().create_timer(0.75),"timeout")
			UiFight.changeText(PokemonEnnemi.PokemonEnnemi.Name + " utilise " + AttaqueEnnemi + " !")
			yield(UiFight_ShowText,"animation_finished")
			if Attaque.CheckSuccess("Ennemi",AttaqueEnnemi) :
				AttaqueAnimation.play(AttaqueEnnemi+" E")
				emit_signal("AboutLoadingValues")
				Attaque.CheckAttack(AttaqueEnnemi,PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi,"Ennemi")
				yield(get_tree().create_timer(1),"timeout")
				Attaque.EventText("Ennemi")
				if (Attaque.EvenText != "") :
					UiFight.changeText(Attaque.EvenText)
					yield(UiFight_ShowText,"animation_finished")
				if (Attaque.SpecialText != "") :
					UiFight.changeText(Attaque.SpecialText)
					yield(UiFight_ShowText,"animation_finished")
					Attaque.SpecialText = ""
				emit_signal("ChangeStatut",Attaque.GetAndSetStatut(PokemonPlayer.PokemonPlayer))
			else :
				UiFight.changeText(PokemonEnnemi.PokemonEnnemi.Name + " rate son attaque !")
				yield(UiFight_ShowText,"animation_finished")
			yield(CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi),"completed")
			emit_signal("LoadValues")
			yield(ProcessRepeatOthers(),"completed")
		else :
			Attaque.IsPlayerTheFirstAttacker = false
			hide()
			var AttaqueEnnemi = PokemonEnnemi.EnnemiLaunchAttack()
			yield(get_tree().create_timer(0.75),"timeout")
			UiFight.changeText(PokemonEnnemi.PokemonEnnemi.Name + " utilise " + AttaqueEnnemi + " !")
			yield(UiFight_ShowText,"animation_finished")
			if Attaque.CheckSuccess("Ennemi",AttaqueEnnemi) :
				AttaqueAnimation.play(AttaqueEnnemi+" E")
				emit_signal("AboutLoadingValues")
				Attaque.CheckAttack(AttaqueEnnemi,PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi,"Ennemi")
				yield(get_tree().create_timer(1),"timeout")
				Attaque.EventText("Ennemi")
				if (Attaque.EvenText != "") :
					UiFight.changeText(Attaque.EvenText)
					yield(UiFight_ShowText,"animation_finished")
				if (Attaque.SpecialText != "") :
					UiFight.changeText(Attaque.SpecialText)
					yield(UiFight_ShowText,"animation_finished")
					Attaque.SpecialText = ""
				emit_signal("ChangeStatut",Attaque.GetAndSetStatut(PokemonPlayer.PokemonPlayer))
			else :
				UiFight.changeText(PokemonEnnemi.PokemonEnnemi.Name + " rate son attaque !")
				yield(UiFight_ShowText,"animation_finished")
			yield(CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi),"completed")
			emit_signal("LoadValues")
			UiFight.changeText(PokemonPlayer.PokemonPlayer.Name + " utilise " + TheAttaque + " !")
			yield(UiFight_ShowText,"animation_finished")
			if Attaque.CheckSuccess("Player",TheAttaque) :
				AttaqueAnimation.play(TheAttaque+Attaque.SpecialAnimation)
				emit_signal("AboutLoadingValues")
				Attaque.CheckAttack(TheAttaque,PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi,"Player")
				yield(get_tree().create_timer(1),"timeout")
				Attaque.EventText("Player")
				if (Attaque.EvenText != "") :
					UiFight.changeText(Attaque.EvenText)
					yield(UiFight_ShowText,"animation_finished")
				if (Attaque.SpecialText != "") :
					UiFight.changeText(Attaque.SpecialText)
					yield(UiFight_ShowText,"animation_finished")
					Attaque.SpecialText = ""
				emit_signal("ChangeStatutE",Attaque.GetAndSetStatut(PokemonEnnemi.PokemonEnnemi))
			else :
				UiFight.changeText(PokemonPlayer.PokemonPlayer.Name + " rate son attaque !")
				yield(UiFight_ShowText,"animation_finished")
			emit_signal("LoadValues")
			yield(CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi),"completed")
			yield(ProcessRepeatOthers(),"completed")
		UIFight.CantPassTxt = false
	if Attaque.IsSolarBeamActive or Attaque.IsSkyAttackActive :
		yield(TwoRoundsIn(FirstAttacker,TheAttaque,SpecialProcessRepeat,StringSpecial),"completed")
		Attaque.SpecialAnimation = ""

func ProcessRepeatOthers() :
	yield(get_tree().create_timer(0.5),"timeout")
	if Attaque.IsFlying :
			emit_signal("AboutLoadingValues")
			Attaque.UseVol(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi)
			AttaqueAnimation.play("UseVol")
			UiFight.changeText(PokemonPlayer.PokemonPlayer.Name + " utilise Vol !")
			yield(UiFight_ShowText,"animation_finished")
			yield(CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi),"completed")
			emit_signal("LoadValues")
	if Attaque.IsFlyingE :
			emit_signal("AboutLoadingValues")
			Attaque.UseVolE(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi)
			AttaqueAnimation.play("UseVolE")
			UiFight.changeText(PokemonEnnemi.PokemonEnnemi.Name + " utilise Vol !")
			yield(UiFight_ShowText,"animation_finished")
			yield(CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi),"completed")
			emit_signal("LoadValues")
	if Attaque.VampiDraine :
			emit_signal("AboutLoadingValues")
			Attaque.DrainVampigraine(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi)
			AttaqueAnimation.play("VampigraineDrain")
			UiFight.changeText("Vampigraine drain l'énergie de " + PokemonEnnemi.PokemonEnnemi.Name + " ennemi !")
			yield(UiFight_ShowText,"animation_finished")
			yield(CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi),"completed")
			emit_signal("LoadValues")
	if Attaque.VampiDraineE :
			emit_signal("AboutLoadingValues")
			Attaque.DrainVampigraineE(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi)
			AttaqueAnimation.play("VampigraineDrain E")
			UiFight.changeText("Vampigraine drain l'énergie de " + PokemonPlayer.PokemonPlayer.Name)
			yield(UiFight_ShowText,"animation_finished")
			yield(CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi),"completed")
			emit_signal("LoadValues")
	emit_signal("AboutLoadingValues")
	if Attaque.CheckPokemonStatut(PokemonEnnemi.PokemonEnnemi) :
			UiFight.changeText(Attaque.StatutSentence)
			yield(UiFight_ShowText,"animation_finished")
			AttaqueAnimation.play(PokemonEnnemi.PokemonEnnemi.Statut + " E")
			yield(get_tree().create_timer(1),"timeout")
			yield(CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi),"completed")
			emit_signal("LoadValues")
	emit_signal("AboutLoadingValues")
	if Attaque.CheckPokemonStatut(PokemonPlayer.PokemonPlayer) :
			UiFight.changeText(Attaque.StatutSentence)
			yield(UiFight_ShowText,"animation_finished")
			AttaqueAnimation.play(PokemonPlayer.PokemonPlayer.Statut)
			yield(get_tree().create_timer(1),"timeout")
			yield(CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi),"completed")
			emit_signal("LoadValues")

func CheckSomeoneDead(Player,Ennemi) :
	yield(get_tree().create_timer(0.1),"timeout")
	if Ennemi.Hp <= 0 :
		if (EG.CheckNumberOfPokemon() == 0) :
			UiFight.changeText(PokemonEnnemi.PokemonEnnemi.Name + " est KO ! Le combat est fini !")
			yield(UiFight_ShowText,"animation_finished")
			UiFight.changeText(Pokedex.CheckNewPokemonDiscover(PokemonEnnemi.PokemonEnnemi.Name))
			yield(UiFight_ShowText,"animation_finished")
			Pokemon.CheckLvlUp(PG.Pokemon1,Pokemon.CheckExpWin(PokemonEnnemi.PokemonEnnemi))
			get_node("/root/FightScene/AnimationPlayer").play("EndOfFight")
			yield(get_node("/root/FightScene/AnimationPlayer"),"animation_finished")
			UIFight.CantPassTxt = false
			PG.UnUsed = get_tree().change_scene(UIFight.SceneAfterFight)
		else :
			PokemonEnnemi.ChangePokemon(EG.GetAPokemonInLife())
			get_node("/root/FightScene/AnimationPlayer").play("ChangePokemon-Ennemi-Normal")
			yield(get_node("/root/FightScene/AnimationPlayer"),"animation_finished")
			PokemonEnnemi.loadTextures()
			get_node("/root/FightScene/UIPokemonBox").load_values(PokemonEnnemi.PokemonEnnemi.Name,PokemonEnnemi.PokemonEnnemi.Lvl,PokemonEnnemi.PokemonEnnemi.Hp,PokemonEnnemi.PokemonEnnemi.MaxHp,PokemonEnnemi.PokemonEnnemi.Experience,PokemonEnnemi.PokemonEnnemi.ExperienceNeededToLvlUp)
	elif Player.Hp <= 0 :
		#Case -> No more Pokemon
		if (PG.CheckNumberOfPokemon() == 0) :
			UiFight.changeText(PokemonPlayer.PokemonPlayer.Name + " n'est plus en état de se battre !")
			yield(UiFight_ShowText,"animation_finished")
			UiFight.changeText(PG.PlayerName + " a perdu ! Le combat est fini !")
			yield(UiFight_ShowText,"animation_finished")
			UIFight.CantPassTxt = false
			PG.ReloadDictionnary()
			for x in PG.ListPokemon : if x != null : Pokemon.health(x)
			PG.UnUsed = get_tree().change_scene(UIFight.SceneAfterFight)
		else :
			UiFight.changeText(PokemonPlayer.PokemonPlayer.Name + " n'est plus en état de se battre !")
			yield(UiFight_ShowText,"animation_finished")
			PokemonPlayer.ChangePokemon(PG.GetAPokemonInLife())
			UiFight.changeText(PokemonPlayer.PokemonPlayer.Name + " go !")
			get_node("/root/FightScene/AnimationPlayer").play("ChangePokemon-Normal")
			yield(get_node("/root/FightScene/AnimationPlayer"),"animation_finished")
			PokemonPlayer.loadTextures()
			get_node("/root/FightScene/UIPokemonBox").load_values(PokemonPlayer.PokemonPlayer.Name,PokemonPlayer.PokemonPlayer.Lvl,PokemonPlayer.PokemonPlayer.Hp,PokemonPlayer.PokemonPlayer.MaxHp,PokemonPlayer.PokemonPlayer.Experience,PokemonPlayer.PokemonPlayer.ExperienceNeededToLvlUp)

func TwoRoundsIn(FirstAttacker,TheAttaque,SpecialProcessRepeat,StringSpecial) :
	yield(ProcessRepeat(FirstAttacker,TheAttaque,SpecialProcessRepeat,StringSpecial),"completed")
