extends Popup

var ActualLife

func ready() :
	ActualLife = PokemonEnnemi.PokemonEnnemi.Hp
	AnimationLoadLife.track_set_key_value(0,0,ActualLife)
	AnimationLoadLife.track_set_key_value(0,1,ActualLife)

onready var PokemonEnnemi = get_node("/root/FightScene/PokemonEnnemi")
onready var Name = get_node("/root/FightScene/UIPokemonBoxEnnemi/Name")
onready var Lvl = get_node("/root/FightScene/UIPokemonBoxEnnemi/Lvl")
onready var LifeProgress = get_node("LifeProgress")
onready var AnimationLoadLife = $AnimationPlayer.get_animation("LoadLife")

func load_values(NamePlayer,LvlPlayer,LifePlayer,MaxLifePlayer) :
	Name.text = NamePlayer
	Lvl.text = "N." + str(LvlPlayer)
	LifeProgress.value = LifePlayer
	LifeProgress.max_value = MaxLifePlayer
	AnimationLoadLife.track_set_key_value(0,0,ActualLife)
	AnimationLoadLife.track_set_key_value(0,1,LifePlayer)
	if LifePlayer >= MaxLifePlayer/2 : $LifeProgress.texture_progress = load("res://img Pokemon/img Fight/UIPokemonBox/TextureProgress-Green.png")
	elif LifePlayer < MaxLifePlayer/2 and LifePlayer > MaxLifePlayer/4 : $LifeProgress.texture_progress = load("res://img Pokemon/img Fight/UIPokemonBox/TextureProgress-Orange.png")
	elif LifePlayer < MaxLifePlayer/4 : $LifeProgress.texture_progress = load("res://img Pokemon/img Fight/UIPokemonBox/TextureProgress-Red.png")
	else : $LifeProgress.texture_progress = load("res://img Pokemon/img Fight/UIPokemonBox/TextureProgress-Green.png")
	if (ActualLife == LifePlayer) : pass
	else : 
		$AnimationPlayer.play("LoadLife")

func _on_UIAttaque_AboutLoadingValues():
	ActualLife = PokemonEnnemi.PokemonEnnemi.Hp
func _on_UIAttaque_ChangeStatutE(TheStatut):
	if TheStatut == "-" or TheStatut == "" :
		$Statut.texture = null
	else :
		$Statut.texture = load("res://img Pokemon/img Animation/Animation - Statut/" + TheStatut + ".png")
