extends Popup

onready var PokemonPlayer = get_node("/root/FightScene/PokemonPlayer")
onready var PokemonEnnemi = get_node("/root/FightScene/PokemonEnnemi")
onready var FightSceneBG = get_node("/root/FightScene/BG")
onready var FightSceneCercle1 = get_node("/root/FightScene/BG/CerclePlayer")
onready var FightSceneCercle2 = get_node("/root/FightScene/BG/CercleEnnemi")
onready var AllAnimation = get_node("/root/FightScene/AnimationPlayer")

func _ready():
#	Load Graphic
	FightSceneBG.color = UIFight.BGCOLOR
	FightSceneCercle1.texture = UIFight.CercleFight
	FightSceneCercle2.texture = UIFight.CercleFight

func changeText(Text) :
	$Text.text = Text
	$ShowText.play("Show_Text")

func _on_UIFight_tree_entered():
	self.visible = true
	get_node("/root/FightScene/MenuPokemon").visible = false
	Attaque.reload("Both")
	yield(get_tree().create_timer(0.1),"timeout")
#		1) Dresseur Fight
	if (UIFight.TypeOfFight == "FightDresseur") :
	#	Load Textures
		EG.loadTexture(get_node("/root/FightScene/Ennemi/Ennemi"))
	#	Animation EnterTree
		AllAnimation.play("LaunchFight-Dresseur-EnterTree")
		yield(AllAnimation,"animation_finished")
	#	Text
		changeText(UIFight.TxtIntro)
		yield($ShowText,"animation_finished")
		UIFight.PassTxt = false
		while(!UIFight.PassTxt) :
			yield(get_tree().create_timer(0.1),"timeout")
	#	Animation
		changeText(EG.EnnemiName + " envoie " + PokemonEnnemi.PokemonEnnemi.Name)
		AllAnimation.play("ChangePokemon-Ennemi-Normal")
		yield(AllAnimation,"animation_finished")
		yield(get_tree().create_timer(0.8), "timeout")
		get_node("/root/FightScene/UIListPokemonEnnemi").hide()
		changeText(PokemonPlayer.PokemonPlayer.Name + " ! Go !")
		AllAnimation.play("ChangePokemon-Player-EnterTree")
		yield(AllAnimation,"animation_finished")
#		2) Savage
	elif (UIFight.TypeOfFight == "Savage") :
	#	Animation EnterTree
		AllAnimation.play("LaunchFight-Savage-EnterTree")
		yield(AllAnimation,"animation_finished")
	#	Text
		changeText(UIFight.TxtIntro)
		yield($ShowText,"animation_finished")
		UIFight.PassTxt = false
		while(!UIFight.PassTxt) :
			yield(get_tree().create_timer(0.1),"timeout")
		changeText(PokemonPlayer.PokemonPlayer.Name + " ! Go !")
		AllAnimation.play("ChangePokemon-Player-EnterTree")
		yield(AllAnimation,"animation_finished")
#	UI pop and hide
	get_node("/root/FightScene/UIAction").popup()
#	Text UIAction
	changeText("Que va faire " + PokemonPlayer.PokemonPlayer.Name + " ?")
	UIFight.CantPassTxt = false

func _input(_event):
	if Input.is_action_pressed("ui_speack_accept") :
		if (UIFight.CantPassTxt) :
			pass
		elif ($Text.percent_visible != 1) :
			$ShowText.playback_speed = 5
		else :
			$ShowText.playback_speed = 1
			UIFight.PassTxt = true
