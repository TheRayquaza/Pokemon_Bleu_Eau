extends StaticBody2D

export (String) var TXT1
export (String) var TXT2
export (String) var TXT3

export (Texture) var TheTexture

onready var ShowSomething = get_node(PG.ActualScene + "/GUITotal/ShowSomething")

var UISpeackScene
var Initialisation = false

func _process(delta):
	while !Initialisation :
		UISpeackScene = get_node(PG.ActualScene + "/GUITotal").get_node("UISpeackPopUp")
		if UISpeackScene != null : Initialisation = true
		else : pass

func display_message():
	if TXT1 == "" : pass
	else :
		if TXT2 == "" :
			UISpeack.ListOfTxt = [TXT1]
		elif TXT3 == "" :
			UISpeack.ListOfTxt = [TXT1,TXT2]
		else :
			UISpeack.ListOfTxt = [TXT1,TXT2,TXT3]
		UISpeackScene.display()
		ShowSomething.emit_signal("ShowTexture",TheTexture.get_load_path())
