extends Area2D

export (Texture) var TheTexture
export (String) var Message

var ShowSomething
var UISpeackScene
var UISpeackAnimation
var Initialisation = false

func _process(delta):
	while !Initialisation :
		UISpeackScene = get_node(PG.ActualScene + "/GUITotal").get_node("UISpeackPopUp")
		UISpeackAnimation = get_node(PG.ActualScene + "/GUITotal").get_node("UISpeackPopUp/Show_Text")
		ShowSomething = get_node(PG.ActualScene + "/GUITotal").get_node("ShowSomething")
		if UISpeackScene != null and UISpeackAnimation != null and ShowSomething != null : Initialisation = true
		else : pass

func display_message() :
	UISpeack.ListOfTxt = [Message]
	UISpeackScene.display()
	yield(UISpeackAnimation,"animation_finished")
	yield(get_tree().create_timer(0.5),"timeout")
	UISpeackScene.hide()
	get_tree().paused = true
	ShowSomething.emit_signal("ShowTexture",TheTexture.get_load_path())
