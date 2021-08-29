extends Popup

onready var PokemonPlayer = get_node("/root/FightScene/PokemonPlayer")
onready var PokemonEnnemi = get_node("/root/FightScene/PokemonEnnemi")
onready var UiFight = get_node("/root/FightScene/UIFight")
onready var MenuPokemon = get_node("/root/FightScene/MenuPokemon")
onready var Bag = get_node("/root/FightScene/Bag")
onready var UiFight_Text = get_node("/root/FightScene/UIFight/Text")
onready var UiFight_ShowText = get_node("/root/FightScene/UIFight/ShowText")
onready var UiAction = get_node("/root/FightScene/UIAction")
onready var AllAnimation = get_node("/root/FightScene/AnimationPlayer")
onready var AttaqueAnimation = get_node("/root/FightScene/AttaqueAnimation")
onready var UiPokemonBox = get_node("/root/FightScene/UIPokemonBox")
onready var UiPokemonBoxE = get_node("/root/FightScene/UIPokemonBoxEnnemi")
onready var UiAttaque = get_node("/root/FightScene/UIAttaque")

var actual_arrow = 0
var Cantmove = false
var NeedDisplayUIPokemonBox

var TempPokemon

signal DisplayUIAttaque
signal DisplayUIPokemonBox

func _input(_event):
	if (!self.visible) or Cantmove :  UIFight.CanAnimationBeSet = true
	elif UIFight.CanAnimationBeSet : 
		UIFight.CanAnimationBeSet = false
		get_node("/root/FightScene/AnimationPlayer").play("IDLEAnimation")
	elif (Input.is_action_pressed("ui_accept")) :
		match actual_arrow :
			0 :
#				UIATTAQUE
				emit_signal("DisplayUIAttaque")
				self.hide()
			1 :
#				BAG
				Bag.UseObjectInFight = true
				Cantmove = true
				get_node("/root/FightScene/AnimationPlayer").play("GoBag")
			2 :
				#MENU POKEMON
				get_node("/root/FightScene/AnimationPlayer").play("GoMenuPokemon")
				MenuPokemon.ChangePokemonInFight = true
				Cantmove = true
				MenuPokemon.PokemonHasChanged = null
				while(MenuPokemon.PokemonHasChanged == null) : yield(get_tree().create_timer(0.1),"timeout")
				self.popup()
				UiFight.visible = true
				UiPokemonBox.visible = true
				UiPokemonBoxE.visible = true
				if MenuPokemon.PokemonHasChanged :
					yield(get_tree().create_timer(0.5),"timeout")
					Attaque.IsPlayerTheFirstAttacker = true
					UiFight.changeText(PokemonPlayer.PokemonPlayer.Name + " revient !")
					yield(get_tree().create_timer(0.6),"timeout")
					AllAnimation.play("ChangePokemon-Return")
					yield(AllAnimation,"animation_finished")
					match MenuPokemon.PokemonToChanged :
						"2" :
							PokemonPlayer.ChangePokemon("2")
						"3" :
							PokemonPlayer.ChangePokemon("3")
						"4" :
							PokemonPlayer.ChangePokemon("4")
						"5" :
							PokemonPlayer.ChangePokemon("5")
						"6" :
							PokemonPlayer.ChangePokemon("6")
					UiFight.changeText(PokemonPlayer.PokemonPlayer.Name + " ! Go !")
					AllAnimation.play("ChangePokemon-Normal")
					get_node("/root/FightScene/UIPokemonBox").load_values(PokemonPlayer.PokemonPlayer.Name,PokemonPlayer.PokemonPlayer.Lvl,PokemonPlayer.PokemonPlayer.Hp,PokemonPlayer.PokemonPlayer.MaxHp,PokemonPlayer.PokemonPlayer.Experience,PokemonPlayer.PokemonPlayer.ExperienceNeededToLvlUp)
					yield(AllAnimation,"animation_finished")
					yield(UiAttaque.ProcessRepeat(false,null,true,"Ennemi"),"completed")
					Cantmove = false
					UiFight.changeText("Que va faire " + PokemonPlayer.PokemonPlayer.Name + " ?")
				else : Cantmove = false
			3 :
#				FUITE
				Cantmove = true
				if (UIFight.TypeOfFight == "FightDresseur") :
					UiFight.changeText("Vous ne pouvez pas fuire ce combat !")
					Cantmove = true
					self.hide()
					yield(UiFight_ShowText,"animation_finished")
					yield(get_tree().create_timer(0.3),"timeout")
					UiFight_Text.text = "Que va faire " + PokemonPlayer.PokemonPlayer.Name + " ?"
					Cantmove = false
					self.popup()
				elif(Attaque.fuite(PokemonPlayer.PokemonPlayer.Vitesse,PokemonEnnemi.PokemonEnnemi.Vitesse)) :
					UiFight.changeText("Vous prennez la fuite !")
					yield(UiFight_ShowText,"animation_finished")
					EndOfFight()
				else :
					Cantmove = true
					UiFight.changeText("Vous ne parvenez pas à prendre la fuite !")
					yield(UiFight_ShowText,"animation_finished")
					self.hide()
					yield(UiAttaque.ProcessRepeat(false,null,true,"Ennemi"),"completed")
					Cantmove = false
					self.popup()
	elif ((Input.is_action_just_pressed("ui_down")) or (Input.is_action_just_pressed("ui_up"))) :
		match actual_arrow :
			0 :
				actual_arrow = 2
				$AttaqueArrow.visible = false
				$PokemonArrow.visible = true
			1 :
				actual_arrow = 3
				$SacArrow.visible = false
				$FuiteArrow.visible = true
			2 :
				actual_arrow = 0
				$AttaqueArrow.visible = true
				$PokemonArrow.visible = false
			3 :
				actual_arrow = 1
				$SacArrow.visible = true
				$FuiteArrow.visible = false
	elif ((Input.is_action_just_pressed("ui_left")) or (Input.is_action_just_pressed("ui_right"))) :
		match actual_arrow :
			0 :
				actual_arrow = 1
				$AttaqueArrow.visible = false
				$SacArrow.visible = true
			1 :
				actual_arrow = 0
				$SacArrow.visible = false
				$AttaqueArrow.visible = true
			2 :
				actual_arrow = 3
				$FuiteArrow.visible = true
				$PokemonArrow.visible = false
			3 :
				actual_arrow = 2
				$PokemonArrow.visible = true
				$FuiteArrow.visible = false

func _on_Bag_catchapokemon(PokeballBonus,PokeballName):
	self.popup()
	UiFight.popup()
	UiPokemonBox.popup()
	UiPokemonBoxE.popup()
	UiFight.changeText("Vous utilisez une " + PokeballName)
	yield(UiFight_ShowText,"animation_finished")
	AllAnimation.play("CatchPokemon-Normal")
	yield(AllAnimation,"animation_finished")
	Attaque.CatchAPokemon(PokemonEnnemi.PokemonEnnemi.MaxHp,PokemonEnnemi.PokemonEnnemi.Hp,PokemonEnnemi.PokemonEnnemi.CatchRate,PokemonEnnemi.PokemonEnnemi.Statut,PokeballBonus)
	for x in range(0,3) :
		if UIAction.CatchShiver[x] :
			AllAnimation.play("CatchPokemon-Shiver")
			yield(get_tree().create_timer(2),"timeout")
		else :
			AllAnimation.play("CatchPokemon-Fail")
			yield(AllAnimation,"animation_finished")
			break
	var Bool = true
	for x in range(0,3) : if !UIAction.CatchShiver[x] : Bool = false
	if Bool : UIAction.ThePokemonIsCatch = true
	else : UIAction.ThePokemonIsCatch = false
	if UIAction.ThePokemonIsCatch :
		if ChangingPokemonAfterCatch(PG.CheckDictionnaryPokemonFree()) :
			AllAnimation.play("CatchPokemon-Success")
			UiFight.changeText("Et hop ! " + PokemonEnnemi.PokemonEnnemi.Name + " sauvage est attrapé !")
			yield(UiFight_ShowText,"animation_finished")
			yield(get_tree().create_timer(1),"timeout")
			UiFight.changeText(PokemonEnnemi.PokemonEnnemi.Name + " fait maintenant partie de votre équipe !")
			yield(UiFight_ShowText,"animation_finished")
			yield(get_tree().create_timer(1),"timeout")
			UiFight.changeText(Pokedex.CheckNewPokemonDiscover(PokemonEnnemi.PokemonEnnemi.Name))
			yield(UiFight_ShowText,"animation_finished")
			yield(EndOfFight(),"completed")
		elif ChangingPokemonAfterCatchPC(PSS.CheckFreeDico()) :
			AllAnimation.play("CatchPokemon-Success")
			UiFight.changeText("Et hop ! " + PokemonEnnemi.PokemonEnnemi.Name + " sauvage est attrapé !")
			yield(UiFight_ShowText,"animation_finished")
			yield(get_tree().create_timer(1),"timeout")
			UiFight.changeText("Vous n'avez plus de place dans votre equipe !")
			yield(UiFight_ShowText,"animation_finished")
			yield(get_tree().create_timer(0.5),"timeout")
			UiFight.changeText(PokemonEnnemi.PokemonEnnemi.Name + " est envoye dans votre PC !")
			yield(UiFight_ShowText,"animation_finished")
			yield(get_tree().create_timer(1),"timeout")
			UiFight.changeText(Pokedex.CheckNewPokemonDiscover(PokemonEnnemi.PokemonEnnemi.Name))
			yield(UiFight_ShowText,"animation_finished")
			yield(EndOfFight(),"completed")
		else : 
			AllAnimation.play("CatchPokemon-Fail")
			UiFight.changeText(PokemonEnnemi.PokemonEnnemi.Name + " sauvage n'a pas pu etre attrapé, Votre PC est plein !!")
			yield(UiFight_ShowText,"animation_finished")
			yield(get_tree().create_timer(1),"timeout")
			UiAttaque.hide()
			Attaque.IsPlayerTheFirstAttacker = false
			yield(UiAttaque.ProcessRepeat(false,null,true,"Ennemi"),"completed")
			UiAttaque.CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi)
			UiAttaque.emit_signal("LoadValues")
			UiFight_Text.text = "Que va faire " + PokemonPlayer.PokemonPlayer.Name + " ?"
			UiAttaque.hide()
			UiAction.popup()
			UiAttaque.actual_arrow = null
			Cantmove = false
	else :
		UiAttaque.hide()
		Attaque.IsPlayerTheFirstAttacker = false
		yield(UiAttaque.ProcessRepeat(false,null,true,"Ennemi"),"completed")
		UiAttaque.CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi)
		UiAttaque.emit_signal("LoadValues")
		UiFight_Text.text = "Que va faire " + PokemonPlayer.PokemonPlayer.Name + " ?"
		UiAttaque.hide()
		UiAction.popup()
		UiAttaque.actual_arrow = null
		Cantmove = false
func _on_Bag_theobjecthasbeenused(ObjectName):
	self.popup()
	UiFight.popup()
	UiPokemonBox.popup()
	UiPokemonBoxE.popup()
	UiAttaque.hide()
	UiFight.changeText("Vous utilisez un(e) " + ObjectName)
	yield(UiFight_ShowText,"animation_finished")
	Attaque.IsPlayerTheFirstAttacker = false
	yield(UiAttaque.ProcessRepeat(false,null,true,"Ennemi"),"completed")
	UiAttaque.CheckSomeoneDead(PokemonPlayer.PokemonPlayer,PokemonEnnemi.PokemonEnnemi)
	UiAttaque.emit_signal("LoadValues")
	UiFight_Text.text = "Que va faire " + PokemonPlayer.PokemonPlayer.Name + " ?"
	UiAttaque.hide()
	UiAction.popup()
	UiAttaque.actual_arrow = null
	Cantmove = false
#PRINT FUNCTIONS
func ShowExpWin(EXP,Name) :
	pass
#OTHERS FUNCTIONS
func ChangingPokemonAfterCatch(Something) :
	PokemonEnnemi.saveParameters(EG.Pokemon1)
	match Something :
		1 :
			PG.Pokemon1 = EG.Pokemon1
			Pokemon.restorePP(PG.Pokemon1)
			return true
		2 :
			PG.Pokemon2 = EG.Pokemon1
			Pokemon.restorePP(PG.Pokemon2)
			return true
		3 :
			PG.Pokemon3 = EG.Pokemon1
			Pokemon.restorePP(PG.Pokemon3)
			return true
		4 :
			PG.Pokemon4 = EG.Pokemon1
			Pokemon.restorePP(PG.Pokemon4)
			return true
		5 :
			PG.Pokemon5 = EG.Pokemon1
			Pokemon.restorePP(PG.Pokemon5)
			return true
		6 :
			PG.Pokemon6 = EG.Pokemon1
			Pokemon.restorePP(PG.Pokemon6)
			return true
		_ : return false
func ChangingPokemonAfterCatchPC(Something) :
	PokemonEnnemi.saveParameters(EG.Pokemon1)
	match Something :
		1 : 
			PSS.Pokemon1 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon1)
			return true
		2 : 
			PSS.Pokemon2 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon2)
			return true
		3 : 
			PSS.Pokemon3 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon3)
			return true
		4 : 
			PSS.Pokemon4 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon4)
			return true
		5 : 
			PSS.Pokemon5 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon5)
			return true
		6 : 
			PSS.Pokemon6 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon6)
			return true
		7 : 
			PSS.Pokemon7 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon7)
			return true
		8 : 
			PSS.Pokemon8 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon8)
			return true
		9 : 
			PSS.Pokemon9 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon9)
			return true
		10 : 
			PSS.Pokemon10 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon10)
			return true
		11 : 
			PSS.Pokemon11 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon11)
			return true
		12 : 
			PSS.Pokemon12 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon12)
			return true
		13 : 
			PSS.Pokemon13 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon13)
			return true
		14 : 
			PSS.Pokemon14 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon14)
			return true
		15 : 
			PSS.Pokemon15 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon15)
			return true
		16 : 
			PSS.Pokemon16 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon16)
			return true
		17 : 
			PSS.Pokemon17 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon17)
			return true
		18 : 
			PSS.Pokemon18 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon18)
			return true
		19 : 
			PSS.Pokemon19 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon19)
			return true
		20 : 
			PSS.Pokemon20 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon20)
			return true
		21 : 
			PSS.Pokemon21 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon21)
			return true
		22 : 
			PSS.Pokemon22 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon22)
			return true
		23 : 
			PSS.Pokemon23 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon23)
			return true
		24 : 
			PSS.Pokemon24 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon24)
			return true
		25 : 
			PSS.Pokemon25 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon25)
			return true
		26 : 
			PSS.Pokemon26 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon1)
			return true
		27 : 
			PSS.Pokemon27 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon27)
			return true
		28 : 
			PSS.Pokemon28 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon28)
			return true
		29 : 
			PSS.Pokemon29 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon29)
			return true
		30 : 
			PSS.Pokemon30 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon30)
			return true
		31 : 
			PSS.Pokemon31 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon31)
			return true
		32 : 
			PSS.Pokemon32 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon32)
			return true
		33 : 
			PSS.Pokemon33 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon33)
			return true
		34 : 
			PSS.Pokemon34 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon34)
			return true
		35 : 
			PSS.Pokemon35 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon35)
			return true
		36 : 
			PSS.Pokemon36 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon36)
			return true
		37 : 
			PSS.Pokemon37 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon37)
			return true
		38 : 
			PSS.Pokemon38 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon38)
			return true
		39 : 
			PSS.Pokemon39 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon39)
			return true
		40 : 
			PSS.Pokemon40 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon40)
			return true
		41 : 
			PSS.Pokemon41 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon41)
			return true
		42 : 
			PSS.Pokemon42 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon42)
			return true
		43 : 
			PSS.Pokemon43 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon43)
			return true
		44 : 
			PSS.Pokemon44 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon44)
			return true
		45 : 
			PSS.Pokemon45 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon45)
			return true
		46 : 
			PSS.Pokemon46 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon46)
			return true
		47 : 
			PSS.Pokemon47 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon47)
			return true
		48 : 
			PSS.Pokemon48 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon48)
			return true
		49 : 
			PSS.Pokemon49 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon49)
			return true
		50 : 
			PSS.Pokemon50 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon50)
			return true
		51 : 
			PSS.Pokemon51 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon51)
			return true
		52 : 
			PSS.Pokemon52 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon52)
			return true
		53 : 
			PSS.Pokemon53 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon53)
			return true
		54 : 
			PSS.Pokemon54 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon54)
			return true
		55 : 
			PSS.Pokemon55 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon55)
			return true
		56 : 
			PSS.Pokemon56 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon56)
			return true
		57 : 
			PSS.Pokemon57 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon57)
			return true
		58 : 
			PSS.Pokemon58 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon58)
			return true
		59 : 
			PSS.Pokemon59 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon59)
			return true
		60 : 
			PSS.Pokemon60 = EG.Pokemon1
			Pokemon.health(PSS.Pokemon60)
			return true
		_ : return false
func EndOfFight() :
	Pokemon.CheckLvlUp(PG.Pokemon1,Pokemon.CheckExpWin(PokemonEnnemi.PokemonEnnemi))
	PokemonPlayer.saveParameters(PG.Pokemon1)
	get_node("/root/FightScene/AnimationPlayer").play("EndOfFight")
	yield(get_node("/root/FightScene/AnimationPlayer"),"animation_finished")
	Cantmove = false
	Save.saveGame(false)
	PG.UnUsed = get_tree().change_scene(UIFight.SceneAfterFight)

