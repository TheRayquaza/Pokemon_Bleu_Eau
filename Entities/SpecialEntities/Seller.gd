extends Area2D

onready var UISpeackScene = get_node(PG.ActualScene + "/GUITotal").get_node("UISpeackPopUp")
onready var TheAnimation = get_node(PG.ActualScene + "/GUITotal").get_node("ChangeScene")
onready var Shop = get_node(PG.ActualScene + "/GUITotal").get_node("Shop")

func display_message() :
	Save.saveGame(false)
	UISpeack.ListOfTxt = ["Que souhaitez-vous acheter ?"]
	UISpeackScene.display()
	TheAnimation.play("Exit")
	yield(TheAnimation,"animation_finished")
	Shop.visible = true
	get_tree().paused = true
	TheAnimation.play("Enter")
	yield(TheAnimation,"animation_finished")
