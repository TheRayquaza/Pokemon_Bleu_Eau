#   STATIC PNJ : EXAMPLE
extends StaticBody2D

export (String) var TXT1
export (String) var TXT2
export (String) var TXT3

export (Texture) var TheTexture

onready var UISpeackScene = get_node(PG.ActualScene + "/GUITotal").get_node("UISpeackPopUp")

func _ready():
	if TheTexture != null : $Sprite.texture = TheTexture

func talk() :
	if TXT2 == "" :
		UISpeack.ListOfTxt = [TXT1]
	elif TXT3 == "" :
		UISpeack.ListOfTxt = [TXT1,TXT2]
	else :
		UISpeack.ListOfTxt = [TXT1,TXT2,TXT3]
	UISpeackScene.display()
