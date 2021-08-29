extends StaticBody2D

export (String) var TXT1
export (String) var TXT2
export (String) var TXT3

var Initialisation = false
var UISpeackScene
var PCScene

func _process(delta):
	while !Initialisation :
		UISpeackScene = get_node(PG.ActualScene + "/GUITotal").get_node("UISpeackPopUp")
		PCScene = get_node(PG.ActualScene + "/GUITotal").get_node("PC-GUI")
		if UISpeackScene != null and PCScene != null : Initialisation = true
		else : pass

func display_message() :
	TXT1 = PG.PlayerName + " ouvre le PC !"
	UISpeack.ListOfTxt = [TXT1]
	UISpeackScene.display()
	yield(UISpeackScene.get_node("Show_Text"),"animation_finished")
	yield(get_tree().create_timer(0.5),"timeout")
	UISpeackScene.hide()
	PCScene.visible = true
	get_tree().paused = true
