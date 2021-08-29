extends StaticBody2D

onready var UISpeackScene = get_node(PG.ActualScene + "/GUITotal").get_node("UISpeackPopUp")
onready var TheAnimation = get_node(PG.ActualScene + "/GUITotal").get_node("ChangeScene")

func talk() :
	UISpeack.ListOfTxt = ["Reposez-vous, toi et tes pokemons !"]
	UISpeackScene.display()
	yield(UISpeackScene.get_node("Show_Text"),"animation_finished")
	PG.ReloadDictionnary()
	for x in PG.ListPokemon : if x != null :Pokemon.health(x)
	TheAnimation.play("Exit")
	yield(TheAnimation,"animation_finished")
	TheAnimation.play("Enter")
	yield(TheAnimation,"animation_finished")
	Save.saveGame(false)
