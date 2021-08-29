extends StaticBody2D

onready var UISpeackScene = get_node(PG.ActualScene + "/GUITotal").get_node("UISpeackPopUp")
onready var TheTable = get_node(PG.ActualScene + "/GUITotal").get_node("PopupTableau")

export (String) var TXT1
export (String) var TXT2

func display_message():
	UISpeack.ListOfTxt = [TXT1,TXT2]
	UISpeackScene.display()
	while !UISpeackScene.get_node("Text").text == TXT2 :
		yield(get_tree().create_timer(0.1),"timeout")
	yield(UISpeackScene.get_node("Show_Text"),"animation_finished")
	TheTable.popup()
