extends Area2D

onready var Player = get_node(PG.ActualScene + "/Player")
onready var animationFight = get_node(PG.ActualScene + "/GUITotal").get_node("Fight")
export (String) var pathScene
export var ListPokemon = [{Name = "",Lvl = 0,x = 0},{Name = "",Lvl = 0,x=0},{Name = "",Lvl = 0,x=0},{Name = "",Lvl = 0,x=0},{Name = "",Lvl = 0,x = 0},{Name = "",Lvl = 0,x=0},{Name = "",Lvl = 0,x = 0},{Name = "",Lvl = 0,x=0}]

var IsPlayerIn = false
var PokemonRNG

func _ready():
	IsPlayerIn = false
	PokemonRNG = 0

func _input(event):
	if IsPlayerIn :
		if (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")) :
			VerifyPokemon()

func _on_Area2D_body_entered(body):
	if (body == Player) :
		IsPlayerIn = true

func _on_Area2D_body_exited(body):
	IsPlayerIn = false
	PokemonRNG = 0

func VerifyPokemon() :
	var ARandom = RandomNumberGenerator.new()
	ARandom.randomize()
	var Random = ARandom.randi_range(0,ListPokemon.size() - 1)
	var RandomLaunch = ARandom.randf_range(0,1)
	PokemonRNG = (ListPokemon[Random].x) * 0.001
	
	if PokemonRNG >= RandomLaunch :
#		ALL FOR POSITIONS
		PG.Last_position = get_node(PG.ActualScene +"/Player").position
		PG.NodePositionPath = "LastPosition"
#		FIGHT
		UIFight.IsFightLaunch = true
		UIFight.CantPassTxt = false
		loadParameters(ListPokemon[Random].Name,ListPokemon[Random].Lvl)
		animationFight.play("LaunchingFight")
		yield(animationFight,"animation_finished")
#		SCENE
		PG.ActualScene = "/root/FightScene"
		PG.Last_position = Player.GetActualPosition()
		Save.saveGame(false)
		PokemonRNG = 0
		PG.UnUsed = get_tree().change_scene("res://Fight/FightScene.tscn")

func loadParameters(ThePokemon,TheLvl) :
#	Pokemon
	EG.Pokemon1 = {Name = ThePokemon, Lvl = TheLvl, Hp = null, MaxHp = null, Exp = null, Attaque1 = null, Attaque2 = null,Attaque3 = null,Attaque4 = null, ActualPPAttaque1 = null, ActualPPAttaque2 = null,ActualPPAttaque3 = null,ActualPPAttaque4 = null,Puissance = null,Defense = null,AttaqueSpecial = null,DefenseSpecial = null,Vitesse = null,Type1 = null,Type2 = null}
	Pokemon.SetAllStats(EG.Pokemon1,EG.Pokemon1.Lvl,EG.Pokemon1.Name)
	Pokemon.health(EG.Pokemon1)
#	Information
	EG.EnnemiName = ""
	UIFight.TypeOfFight = "Savage"
	UIFight.TxtIntro = "Un " + EG.Pokemon1.Name + " sauvage apparait !!"
#	Graphic
	UIFight.BGCOLOR = Color(0.847059, 0.941176, 0.847059)
	UIFight.CercleFight = load("res://img Pokemon/img Fight/Graphique/CercleFightHerbe.png")
	UIFight.SceneAfterFight = pathScene

