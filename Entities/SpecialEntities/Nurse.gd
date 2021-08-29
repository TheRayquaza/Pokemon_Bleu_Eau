extends StaticBody2D

onready var UISpeackScene = get_node(PG.ActualScene + "/GUITotal").get_node("UISpeackPopUp")
onready var TheAnimation = get_node(PG.ActualScene + "/GUITotal").get_node("ChangeScene")

func talk() :
	UISpeack.ListOfTxt = ["Je vais prendre soin de vos Pokemons !"]
	UISpeackScene.display()
	PG.ReloadDictionnary()
	for x in PG.ListPokemon : if x != null :Pokemon.health(x)
	TheAnimation.play("Exit")
	yield(TheAnimation,"animation_finished")
	TheAnimation.play("Enter")
	yield(TheAnimation,"animation_finished")
	UISpeack.ListOfTxt = ["Voilà, vos pokemons sont en parfaite santé !","A bientot !"]
	UISpeackScene.display()
	Save.saveGame(false)
