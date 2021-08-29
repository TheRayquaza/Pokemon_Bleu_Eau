#     LINEAR PNJ : EXAMPLE

extends KinematicBody2D

signal loadPlayerParametre

export (String) var TXT
export (String) var TXTIntro
export (String) var EnnemiName
export (Texture) var TheTexture
export (Texture) var TheInFightTexture
export (Vector2) var Velocity
export (bool) var Activated

export (Dictionary) var POKEMON1 = {
	Name = "",
	Lvl = 0,
	Hp = 0,
	MaxHp = 0,
	Puissance = 0,
	Defense = 0,
	AttaqueSpecial = 0,
	DefenseSpecial = 0,
	Vitesse = 0,
	Experience = 0,
	LvlNeededToEvolve = 0,
	ExperienceNeededToLvlUp = 0,
	Statut = "",
	Type1 = "",
	Type2 = "",
	Attaque1 = "-",
	Attaque2 = "-",
	Attaque3 = "-",
	Attaque4 = "-",
	ActualPPAttaque1 = null,
	ActualPPAttaque2 = null,
	ActualPPAttaque3 = null,
	ActualPPAttaque4 = null}
export (Dictionary) var POKEMON2 = {
	Name = "",
	Lvl = 0,
	Hp = 0,
	MaxHp = 0,
	Puissance = 0,
	Defense = 0,
	AttaqueSpecial = 0,
	DefenseSpecial = 0,
	Vitesse = 0,
	Experience = 0,
	LvlNeededToEvolve = 0,
	ExperienceNeededToLvlUp = 0,
	Statut = "",
	Type1 = "",
	Type2 = "",
	Attaque1 = "-",
	Attaque2 = "-",
	Attaque3 = "-",
	Attaque4 = "-",
	ActualPPAttaque1 = null,
	ActualPPAttaque2 = null,
	ActualPPAttaque3 = null,
	ActualPPAttaque4 = null}
export (Dictionary) var POKEMON3 = {
	Name = "",
	Lvl = 0,
	Hp = 0,
	MaxHp = 0,
	Puissance = 0,
	Defense = 0,
	AttaqueSpecial = 0,
	DefenseSpecial = 0,
	Vitesse = 0,
	Experience = 0,
	LvlNeededToEvolve = 0,
	ExperienceNeededToLvlUp = 0,
	Statut = "",
	Type1 = "",
	Type2 = "",
	Attaque1 = "-",
	Attaque2 = "-",
	Attaque3 = "-",
	Attaque4 = "-",
	ActualPPAttaque1 = null,
	ActualPPAttaque2 = null,
	ActualPPAttaque3 = null,
	ActualPPAttaque4 = null}
export (Dictionary) var POKEMON4 = {
	Name = "",
	Lvl = 0,
	Hp = 0,
	MaxHp = 0,
	Puissance = 0,
	Defense = 0,
	AttaqueSpecial = 0,
	DefenseSpecial = 0,
	Vitesse = 0,
	Experience = 0,
	LvlNeededToEvolve = 0,
	ExperienceNeededToLvlUp = 0,
	Statut = "",
	Type1 = "",
	Type2 = "",
	Attaque1 = "-",
	Attaque2 = "-",
	Attaque3 = "-",
	Attaque4 = "-",
	ActualPPAttaque1 = null,
	ActualPPAttaque2 = null,
	ActualPPAttaque3 = null,
	ActualPPAttaque4 = null}
export (Dictionary) var POKEMON5 = {
	Name = "",
	Lvl = 0,
	Hp = 0,
	MaxHp = 0,
	Puissance = 0,
	Defense = 0,
	AttaqueSpecial = 0,
	DefenseSpecial = 0,
	Vitesse = 0,
	Experience = 0,
	LvlNeededToEvolve = 0,
	ExperienceNeededToLvlUp = 0,
	Statut = "",
	Type1 = "",
	Type2 = "",
	Attaque1 = "-",
	Attaque2 = "-",
	Attaque3 = "-",
	Attaque4 = "-",
	ActualPPAttaque1 = null,
	ActualPPAttaque2 = null,
	ActualPPAttaque3 = null,
	ActualPPAttaque4 = null}
export (Dictionary) var POKEMON6 = {
	Name = "",
	Lvl = 0,
	Hp = 0,
	MaxHp = 0,
	Puissance = 0,
	Defense = 0,
	AttaqueSpecial = 0,
	DefenseSpecial = 0,
	Vitesse = 0,
	Experience = 0,
	LvlNeededToEvolve = 0,
	ExperienceNeededToLvlUp = 0,
	Statut = "",
	Type1 = "",
	Type2 = "",
	Attaque1 = "-",
	Attaque2 = "-",
	Attaque3 = "-",
	Attaque4 = "-",
	ActualPPAttaque1 = null,
	ActualPPAttaque2 = null,
	ActualPPAttaque3 = null,
	ActualPPAttaque4 = null}

onready var player = get_node(PG.ActualScene + "/Player")
onready var UISpeackScene = get_node(PG.ActualScene + "/GUITotal").get_node("UISpeackPopUp")
onready var animationFight

var IsFightLaunch = false

func _ready():
	if TheTexture != null : $Sprite.texture = TheTexture
	animationFight = get_node(PG.ActualScene + "/GUITotal/Fight")

func _physics_process(_delta):
	if (IsFightLaunch) :
		PG.UnUsed = move_and_collide(Velocity)

func _on_LinearPNJ_tree_entered():
	IsFightLaunch = false
	$Exclamation.visible = false
	$Exclamation.stop()

func LaunchFight() :
#	Animation
	GetActivation()
	if Activated :
		$Exclamation.visible = true
		$Exclamation.play("Rouge")
		IsFightLaunch = true
		UIFight.IsFightLaunch = true
		for x in PG.PNJActivate :
			if x == EnnemiName :
				PG.PNJActivate[x] = false

func _on_Area2D_body_entered(body):
	if (IsFightLaunch and body == player) :
		loadParameters()
		UISpeackScene.display_a_txt(TXT)
		while (!UISpeack.PassTxt) :
			yield(get_tree().create_timer(0.1),"timeout")
			if (UISpeack.PassTxt) :
				IsFightLaunch = false
				UIFight.TxtIntro = TXTIntro
				UIFight.TypeOfFight = "FightDresseur"
				animationFight.play("LaunchingFight")
				PG.ActualScene = "/root/FightScene"
				yield(animationFight,"animation_finished")
				PG.UnUsed = get_tree().change_scene("res://Fight/FightScene.tscn")
func _on_Area2D2_body_entered(body):
	if (body == player) :
		LaunchFight()

func GetActivation() :
	if EnnemiName == null or EnnemiName == "" :
		Activated = false
	else :
		for x in PG.PNJActivate :
			if x == EnnemiName :
				Activated = PG.PNJActivate[x]

func loadParameters() :
#	Texture and Graphic
	EG.TextureFight = TheInFightTexture
	UIFight.CercleFight = load("res://img Pokemon/img Fight/Graphique/CercleFightWhite.png")
	UIFight.BGCOLOR = Color(1, 1, 1)
#	Pokemon
	if POKEMON1.Name == "" : EG.Pokemon1 = null
	else :  
		Pokemon.SetAllStats(POKEMON1,POKEMON1.Lvl,POKEMON1.Name)
		POKEMON1.Hp = POKEMON1.MaxHp
		EG.Pokemon1 = POKEMON1
	if POKEMON2.Name == "" : EG.Pokemon2 = null
	else : 
		Pokemon.SetAllStats(POKEMON2,POKEMON2.Lvl,POKEMON2.Name)
		POKEMON2.Hp = POKEMON2.MaxHp
		EG.Pokemon2 = POKEMON2
	if POKEMON3.Name == "" : EG.Pokemon3 = null
	else :
		Pokemon.SetAllStats(POKEMON3,POKEMON3.Lvl,POKEMON3.Name)
		POKEMON3.Hp = POKEMON3.MaxHp
		EG.Pokemon3 = POKEMON3
	if POKEMON4.Name == "" : EG.Pokemon4 = null
	else :
		Pokemon.SetAllStats(POKEMON4,POKEMON4.Lvl,POKEMON4.Name)
		POKEMON4.Hp = POKEMON4.MaxHp
		EG.Pokemon4 = POKEMON4
	if POKEMON5.Name == "" : EG.Pokemon5 = null
	else :  
		Pokemon.SetAllStats(POKEMON5,POKEMON5.Lvl,POKEMON5.Name)
		POKEMON5.Hp = POKEMON5.MaxHp
		EG.Pokemon5 = POKEMON5
	if POKEMON6.Name == "" : EG.Pokemon6 = null
	else :  
		Pokemon.SetAllStats(POKEMON6,POKEMON6.Lvl,POKEMON6.Name)
		POKEMON6.Hp = POKEMON6.MaxHp
		EG.Pokemon6 = POKEMON6
#	Information
	EG.EnnemiName = EnnemiName
