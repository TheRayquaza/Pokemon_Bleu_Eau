extends StaticBody2D

export (String) var TXT1
export (String) var TXT2
export (String) var TXT3

export (Texture) var TheTexture

var UISpeackScene
var Initialisation = false

func _ready():
	if TheTexture != null :
		get_node("Sprite").texture = TheTexture

func _process(delta):
	while !Initialisation :
		UISpeackScene = get_node(PG.ActualScene + "/GUITotal").get_node("UISpeackPopUp")
		if UISpeackScene != null : Initialisation = true
		else : pass

func display_message():
	if TXT1 == "" : pass
	else :
		if PG.Badge.BadgeRoche : TXT2 = "Vainqueurs : " + EG.RivalName + "," + PG.PlayerName
		if !PG.Badge.BadgeRoche : TXT2 =  "Vainqueurs : " + EG.RivalName
		if TXT2 == "" :
			UISpeack.ListOfTxt = [TXT1]
		elif TXT3 == "" :
			UISpeack.ListOfTxt = [TXT1,TXT2]
		else :
			UISpeack.ListOfTxt = [TXT1,TXT2,TXT3]
		UISpeackScene.display()
