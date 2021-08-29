extends StaticBody2D

onready var UISpeackScene = get_node(PG.ActualScene + "/GUITotal").get_node("UISpeackPopUp")
onready var BlackMarket = get_node(PG.ActualScene + "/GUITotal").get_node("BlackMarket")

func display_message() :
	Save.saveGame(false)
	UISpeack.ListOfTxt = ["Je suis ici car j'ai de nouvelles offres ! Ecoutez bien !","Si je vous dis que je peux échanger vos pokémons contre de l'agent ! Ca vous tente ?"]
	UISpeackScene.display()
	yield(UISpeackScene.get_node("Show_Text"),"animation_finished")
	yield(UISpeackScene.get_node("Show_Text"),"animation_finished")
	yield(get_tree().create_timer(0.5),"timeout")
	UISpeack.PassTxt = true
	BlackMarket.visible = true
	get_tree().paused = true
