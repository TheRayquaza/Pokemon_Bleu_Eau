extends ColorRect

#VAR NODE
onready var player
onready var NodeTextureSelection
onready var PokemonEnnemi
onready var PokemonPlayer

#VAR SELECTION
var ActualSection
var ActualTextureSelection = ""
var UseObjectInFight = false
var NumberPokemonSelection = 0
#VAR FOR OBJECT AND USE THEM
var UsingObject = false
var ActualObject = ""
#SIGNALS
signal catchapokemon(PokeballBonus,PokeballName)
signal theobjecthasbeenused(ObjectName)

func _ready():
	if PG.ActualScene == "/root/FightScene" : 
		PokemonPlayer = get_node("/root/FightScene/PokemonPlayer")
		PokemonEnnemi = get_node("/root/FightScene/PokemonEnnemi")
	loadValues()
	$InformationText.text = ""
	ActualSection = "Medicaments"
	$MedicamentBox.visible = true
	$AnimationPlayer.play("IdleArrows")
	if PG.ActualScene != "/root/FightScene" : player = get_node(PG.ActualScene + "/Player")

func _process(delta):
	if visible :
		loadValues()

#IMPORTANT BUTTONS
func _on_ArrowLeft_pressed():
	loadValues()
	$InformationText.text = ""
	match ActualSection :
		null,"" :
			$MedicamentBox.visible = true
			ActualSection = "Medicaments"
		"Medicaments" :
			$BagShadow/Bag.texture = load("res://img Pokemon/img Bag/Graphic/BagLeft.png")
			$MedicamentBox.visible = false
			$ObjectBox.visible = true
			ActualSection = "Object"
		"Object" :
			$BagShadow/Bag.texture = load("res://img Pokemon/img Bag/Graphic/BagRight.png")
			$ObjectBox.visible = false
			$PokeballBox.visible = true
			ActualSection = "Pokeball"
		"Pokeball" :
			$BagShadow/Bag.texture = load("res://img Pokemon/img Bag/Graphic/BagMiddle.png")
			$PokeballBox.visible = false
			$RareObjectBox.visible = true
			ActualSection = "RareObject"
		"RareObject" :
			$BagShadow/Bag.texture = load("res://img Pokemon/img Bag/Graphic/BagLeft.png")
			$MedicamentBox.visible = true
			$RareObjectBox.visible = false
			ActualSection = "Medicaments"
func _on_ArrowRight_pressed():
	loadValues()
	$InformationText.text = ""
	match ActualSection :
		"Medicaments" :
			$BagShadow/Bag.texture = load("res://img Pokemon/img Bag/Graphic/BagMiddle.png")
			$MedicamentBox.visible = false
			$RareObjectBox.visible = true
			ActualSection = "RareObject"
		"RareObject" :
			$BagShadow/Bag.texture = load("res://img Pokemon/img Bag/Graphic/BagRight.png")
			$RareObjectBox.visible = false
			$PokeballBox.visible = true
			ActualSection = "Pokeball"
		"Pokeball" :
			$BagShadow/Bag.texture = load("res://img Pokemon/img Bag/Graphic/BagLeft.png")
			$ObjectBox.visible = true
			$PokeballBox.visible = false
			ActualSection = "Object"
		"Object" :
			$BagShadow/Bag.texture = load("res://img Pokemon/img Bag/Graphic/BagLeft.png")
			$ObjectBox.visible = false
			$MedicamentBox.visible = true
			ActualSection = "Medicaments"
func _on_SortirButton_pressed():
	loadValues()
	$InformationText.text = ""
	$AnimationPlayer.stop()
	$AnimationPlayer.play("IdleArrows")
	NodeTextureSelection.modulate = Color.white
	$ChoicePopup.hide()
func _on_UtiliserButton_pressed():
#	NOT IN FIGHT
	if (!UseObjectInFight) :
		match ActualObject :
			"Potion","SuperPotion","HyperPotion","Guerison","MaxPotion","Antidote","AntiPara","Reveil","AntiBrule","TotalSoin","Eau","Soda","Limonade","Lait","Rappel","RappelMax" :
				RepeatUse1()
			"Pokeball","SuperBall","HyperBall","FiletBall","FaibloBall","MasterBall" :
				pass
			"Carte" :
				$ChoicePopup.hide()
				$Carte.visible = true
			"ChaussuresDeCourse" :
				if (PG.IsShoesEquip) :
					PG.IsShoesEquip = false
					player.MOTION_SPEED = 2
				else :
					PG.IsShoesEquip = true
					player.MOTION_SPEED = 3
				quit_scene()
#	IN FIGHT
	elif (UseObjectInFight) :
		match ActualObject :
			"Potion","SuperPotion","HyperPotion","Guerison","MaxPotion","Antidote","AntiPara","Reveil","AntiBrule","TotalSoin","Eau","Soda","Limonade","Lait","Rappel","RappelMax" :
				RepeatUse1()
			"Pokeball","SuperBall","HyperBall","FiletBall","FaibloBall","MasterBall" :
				if UIFight.TypeOfFight == "FightDresseur" : pass
				else :
					match ActualObject :
						"Pokeball" : CatchAPokemonInFight(1,ActualObject)
						"SuperBall" : CatchAPokemonInFight(1.5,ActualObject)
						"HyperBall" : CatchAPokemonInFight(2,ActualObject)
						"FiletBall" : CatchAPokemonInFight(CalculFiletBallBonus(PokemonEnnemi.PokemonEnnemi.Type1,PokemonEnnemi.PokemonEnnemi.Type2),ActualObject)
						"FaibloBall" :  CatchAPokemonInFight(CalculFaibloBallBonus(PokemonEnnemi.PokemonEnnemi.Lvl),ActualObject)
						"MasterBall" : CatchAPokemonInFight(255,ActualObject)
func _on_JeterButton_pressed():
	if (!UseObjectInFight) :
		match ActualSection :
			"RareObject" :
				pass
			_ :
				$JeterPopup.popup()

func _on_LineEdit_text_entered(new_text):
	if (int(new_text)) :
		var temp : int = 0
		temp = GetDictionnaryValue(ActualObject)
		if temp < int(new_text) :
			$JeterPopup/LineEdit.text = "Trop Grand !"
		elif int(new_text) < 0 :
			$JeterPopup/LineEdit.text = "Erreur !"
		else :
			match ActualObject :
				"Potion" : PG.AllObject["NumberObject"].Potion -= int(new_text)
				"SuperPotion" : PG.AllObject["NumberObject"].SuperPotion-= int(new_text)
				"HyperPotion" : PG.AllObject["NumberObject"].HyperPotion-= int(new_text)
				"MaxPotion" : PG.AllObject["NumberObject"].MaxPotion-= int(new_text)
				"Guerison" : PG.AllObject["NumberObject"].Guerison-= int(new_text)
				"Rappel" : PG.AllObject["NumberObject"].Rappel-= int(new_text)
				"RappelMax" : PG.AllObject["NumberObject"].RappelMax-= int(new_text)
				"Antidote" : PG.AllObject["NumberObject"].Antidote-= int(new_text)
				"AntiPara" : PG.AllObject["NumberObject"].AntiPara-= int(new_text)
				"AntiBrule" : PG.AllObject["NumberObject"].AntiBrule-= int(new_text)
				"Reveil" : PG.AllObject["NumberObject"].Reveil-= int(new_text)
				"TotalSoin" : PG.AllObject["NumberObject"].TotalSoin-= int(new_text)
				"Eau" : PG.AllObject["NumberObject"].Eau -= int(new_text)
				"Soda" : PG.AllObject["NumberObject"].Soda -= int(new_text)
				"Limonade" : PG.AllObject["NumberObject"].Limonade -= int(new_text)
				"Lait" : PG.AllObject["NumberObject"].Lait -= int(new_text)
				"Pokeball" : PG.AllObject["NumberObject"].Pokeball -= int(new_text)
				"SuperBall" : PG.AllObject["NumberObject"].SuperBall -= int(new_text)
				"HyperBall" : PG.AllObject["NumberObject"].HyperBall -= int(new_text)
				"FiletBall" : PG.AllObject["NumberObject"].FiletBall -= int(new_text)
				"FaibloBall" : PG.AllObject["NumberObject"].FaibloBall -= int(new_text)
				"MasterBall" : PG.AllObject["NumberObject"].MasterBall -= int(new_text)
				"Repousse" : PG.AllObject["NumberObject"].Repousse -= int(new_text)
				"SuperRepousse" : PG.AllObject["NumberObject"].SuperRepousse -= int(new_text)
			$JeterPopup.hide()
		loadValues()
	else :
		$JeterPopup/LineEdit.text = "Erreur !"

#OTHERS BUTTON : Chaque bouton pressé s'affiche, load la variable ActualObject et affiche un texte
	#Medicaments
func _on_Potion_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/Potion/Potion"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/Potion/Potion"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure 20 PV d'un Pokemon")
		ActualObject = "Potion"
func _on_SuperPotion_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/SuperPotion/SuperPotion"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/SuperPotion/SuperPotion"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure 50 PV d'un Pokemon")
		ActualObject = "SuperPotion"
func _on_HyperPotion_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/HyperPotion/HyperPotion"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/HyperPotion/HyperPotion"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure 200 PV d'un Pokemon")
		ActualObject = "HyperPotion"
func _on_MaxPotion_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/MaxPotion/MaxPotion"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/MaxPotion/MaxPotion"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure tous les PV d'un Pokemon")
		ActualObject = "MaxPotion"
func _on_Guerison_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/Guerison/Guerison"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Potions/Guerison/Guerison"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure tous les PV d'un Pokémon et soigne tous ses problèmes de statut")
		ActualObject = "Guerison"
func _on_Rappel_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Rappels/Rappel/Rappel"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Rappels/Rappel/Rappel"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Ranime un Pokémon K.O. et restaure 50% de ses PV")
		ActualObject = "Rappel"
func _on_RappelMax_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Rappels/RappelMax/RappelMax"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Rappels/RappelMax/RappelMax"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Ranime un Pokémon K.O. et restaure tous ses PV")
		ActualObject = "RappelMax"
func _on_Antidote_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/Antidote/Antidote"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/Antidote/Antidote"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Soigne l'empoisonnement de votre pokemon")
		ActualObject = "Antidote"
func _on_AntiPara_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/AntiPara/AntiPara"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/AntiPara/AntiPara"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Soigne la paralysie de votre pokemon")
		ActualObject = "AntiPara"
func _on_AntiBrule_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/AntiBrule/AntiBrule"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/AntiBrule/AntiBrule"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Soigne la brulure de votre pokemon")
		ActualObject = "AntiBrule"
func _on_Reveil_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/Reveil/Reveil"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/Reveil/Reveil"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Soigne le sommeil de votre pokemon")
		ActualObject = "Reveil"
func _on_TotalSoin_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/TotalSoin/TotalSoin"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/TotalSoin/TotalSoin"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Soigne tous les problèmes de statut")
		ActualObject = "TotalSoin"
func _on_Eau_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Autres/Eau/Eau"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Autres/Eau/Eau"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure 50 PV d'un Pokémon")
		ActualObject = "Eau"
func _on_Soda_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Autres/Soda/Soda"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Autres/Soda/Soda"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure 60 PV d'un Pokémon")
		ActualObject = "Soda"
func _on_Limonade_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Autres/Limonade/Limonade"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Autres/Limonade/Limonade"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure 80 PV d'un Pokémon")
		ActualObject = "Limonade"
func _on_Lait_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Autres/Lait/Lait"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/MedicamentBox/ScrollContainer/VBoxContainer/Autres/Lait/Lait"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Restaure 100 PV d'un Pokémon")
		ActualObject = "Lait"

	#Pokeballs
func _on_Pokeball_pressed():
	if PG.ActualScene == "/root/FightScene" : ActualTextureSelection = PG.ActualScene +"/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/Pokeball/Pokeball"
	else : ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/Pokeball/Pokeball"
	if (get_node(ActualTextureSelection).modulate == Color.black) : pass
	else :
		Same("Permet de capturer des Pokémon")
		ActualObject = "Pokeball"
func _on_SuperBall_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/SuperBall/SuperBall"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/SuperBall/SuperBall"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Version améliorée de la Pokeball")
		ActualObject = "SuperBall"
func _on_HyperBall_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/HyperBall/HyperBall"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/HyperBall/HyperBall"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Version améliorée de la SuperBall")
		ActualObject = "HyperBall"
func _on_FiletBall_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/FiletBall/FiletBall"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/FiletBall/FiletBall"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Plus efficace sur les Pokémon Eau et Insecte")
		ActualObject = "FiletBall"
func _on_FaibloBall_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/FaibloBall/FaibloBall"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/FaibloBall/FaibloBall"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Plus le Pokémon est bas niveau, plus la Ball est efficace")
		ActualObject = "FaibloBall"
func _on_MasterBall_pressed():
	if PG.ActualScene == "/root/FightScene" :
		ActualTextureSelection = PG.ActualScene +"/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball3/MasterBall/MasterBall"
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/PokeballBox/ScrollContainer/VBoxContainer/Pokeball3/MasterBall/MasterBall"
	if (get_node(ActualTextureSelection).modulate == Color.black) :
		pass
	else :
		Same("Permet de capturer à coup sur un Pokemon")
		ActualObject = "MasterBall"

	#Objects
func _on_Repousse_pressed():
	if PG.ActualScene == "/root/FightScene" :
		pass
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/ObjectBox/ScrollContainer/VBoxContainer/Objet1/Repousse/Repousse"
		if (get_node(ActualTextureSelection).modulate == Color.black) :
			pass
		else :
			Same("Empeche la rencontre de Pokemon Ennemi pendant quelques instants")
			ActualObject = "Repousse"
func _on_SuperRepousse_pressed():
	if PG.ActualScene == "/root/FightScene" : pass
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/ObjectBox/ScrollContainer/VBoxContainer/Objet1/SuperRepousse/SuperRepousse"
		if (get_node(ActualTextureSelection).modulate == Color.black) : pass
		else :
			Same("Empeche la rencontre de Pokemon Ennemi pendant un plus long instant")
			ActualObject = "SuperRepousse"

	#RareObjects
func _on_Carte_pressed():
	if PG.ActualScene == "/root/FightScene" : pass
	else :
		ActualObject = "Carte"
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/RareObjectBox/ScrollContainer/VBoxContainer/ObjetsRares1/Carte/Carte"
		Same("Une carte très pratique indiquant votre position actuelle")
func _on_ChaussuresDeCourse_pressed():
	if PG.ActualScene == "/root/FightScene" : pass
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/RareObjectBox/ScrollContainer/VBoxContainer/ObjetsRares1/ChaussuresDeCourse/ChaussuresDeCourse"
		if (get_node(ActualTextureSelection).modulate == Color.black) : pass
		else :
			ActualObject = "ChaussuresDeCourse"
			Same("Permet de courir plus rapidement")
func _on_OrbeMysterieuse_pressed():
	if PG.ActualScene == "/root/FightScene" :pass
	else :
		ActualTextureSelection = PG.ActualScene +"/GUITotal/Bag/RareObjectBox/ScrollContainer/VBoxContainer/ObjetsRares1/OrbeMysterieuse/OrbeMysterieuse"
		if (get_node(ActualTextureSelection).modulate == Color.black) : pass
		else :
			ActualObject = "OrbeMysterieuse"
			Same("Une etrange orbe verte que Chen vous a donné lorsque vous avez commencé votre aventure")

#GRAPHIC AND LOADING FUNCTIONS
	#LOAD FUNCTIONS GRAPHIC
func loadValues() :
	SetNumberObject()
	#FOR ALL OBJECTS3
	$MedicamentBox/ScrollContainer/VBoxContainer/Potions/Potion/Number.text = "X" + str(PG.AllObject["NumberObject"].Potion)
	$MedicamentBox/ScrollContainer/VBoxContainer/Potions/SuperPotion/Number.text = "X" + str(PG.AllObject["NumberObject"].SuperPotion)
	$MedicamentBox/ScrollContainer/VBoxContainer/Potions/HyperPotion/Number.text = "X" + str(PG.AllObject["NumberObject"].HyperPotion)
	$MedicamentBox/ScrollContainer/VBoxContainer/Potions/MaxPotion/Number.text = "X" + str(PG.AllObject["NumberObject"].MaxPotion)
	$MedicamentBox/ScrollContainer/VBoxContainer/Potions/Guerison/Number.text = "X" + str(PG.AllObject["NumberObject"].Guerison)
	$MedicamentBox/ScrollContainer/VBoxContainer/Rappels/Rappel/Number.text = "X" + str(PG.AllObject["NumberObject"].Rappel)
	$MedicamentBox/ScrollContainer/VBoxContainer/Rappels/RappelMax/Number.text = "X" + str(PG.AllObject["NumberObject"].RappelMax)
	$MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/Antidote/Number.text = "X" + str(PG.AllObject["NumberObject"].Antidote)
	$MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/AntiPara/Number.text = "X" + str(PG.AllObject["NumberObject"].AntiPara)
	$MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/AntiBrule/Number.text = "X" + str(PG.AllObject["NumberObject"].AntiBrule)
	$MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/Reveil/Number.text = "X" + str(PG.AllObject["NumberObject"].Reveil)
	$MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/TotalSoin/Number.text = "X" + str(PG.AllObject["NumberObject"].TotalSoin)
	$MedicamentBox/ScrollContainer/VBoxContainer/Autres/Eau/Number.text = "X" + str(PG.AllObject["NumberObject"].Eau)
	$MedicamentBox/ScrollContainer/VBoxContainer/Autres/Soda/Number.text = "X" + str(PG.AllObject["NumberObject"].Soda)
	$MedicamentBox/ScrollContainer/VBoxContainer/Autres/Limonade/Number.text = "X" + str(PG.AllObject["NumberObject"].Limonade)
	$MedicamentBox/ScrollContainer/VBoxContainer/Autres/Lait/Number.text = "X" + str(PG.AllObject["NumberObject"].Lait)
	$PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/Pokeball/Number.text = "X" + str(PG.AllObject["NumberObject"].Pokeball)
	$PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/SuperBall/Number.text = "X" + str(PG.AllObject["NumberObject"].SuperBall)
	$PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/HyperBall/Number.text = "X" + str(PG.AllObject["NumberObject"].HyperBall)
	$PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/FiletBall/Number.text = "X" + str(PG.AllObject["NumberObject"].FiletBall)
	$PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/FaibloBall/Number.text = "X" + str(PG.AllObject["NumberObject"].FaibloBall)
	$PokeballBox/ScrollContainer/VBoxContainer/Pokeball3/MasterBall/Number.text = "X" + str(PG.AllObject["NumberObject"].MasterBall)
	$ObjectBox/ScrollContainer/VBoxContainer/Objet1/Repousse/Number.text = "X" + str(PG.AllObject["NumberObject"].Repousse)
	$ObjectBox/ScrollContainer/VBoxContainer/Objet1/SuperRepousse/Number.text = "X" + str(PG.AllObject["NumberObject"].SuperRepousse)
	for x in PG.AllObject["NumberObject"] :
		if PG.AllObject["NumberObject"][x] == 0 or PG.AllObject["NumberObject"][x] < 0  :
			SetAndGetModulate(str(x)).modulate = Color.black
	for x in PG.AllObject["Unlock"] :
		if !PG.AllObject["Unlock"][x] :
			SetAndGetModulate(str(x)).modulate = Color.black
	#FOR USEOBJECTPOPUP
	PG.ReloadDictionnary()
	for x in range(1,7) :
		var TheDico = PG.ListPokemon[x-1]
		var TheNode
		if PG.ActualScene== "/root/FightScene" : TheNode = PG.ActualScene + "/Bag/UseObjectPopup/Pokemon"+str(x)
		else : TheNode = PG.ActualScene + "/GUITotal/Bag/UseObjectPopup/Pokemon"+str(x)
		if TheDico == null : get_node(TheNode).visible = false
		else :
			if PG.ActualScene == "/root/FightScene" and x == 1 :
				get_node(TheNode + "/TextureOverworld").texture = Pokemon.GetImageOverworld(PokemonPlayer.PokemonPlayer.Name)
				get_node(TheNode + "/Name").text = PokemonPlayer.PokemonPlayer.Name
				get_node(TheNode + "/Life").text = str(PokemonPlayer.PokemonPlayer.Hp) + "/" + str(PokemonPlayer.PokemonPlayer.MaxHp)
				get_node(TheNode + "/Progress").max_value = PokemonPlayer.PokemonPlayer.MaxHp
				get_node(TheNode + "/Progress").value = PokemonPlayer.PokemonPlayer.Hp
				get_node(TheNode + "/Statut").texture = load("res://img Pokemon/img Animation/Animation - Statut/"+PokemonPlayer.PokemonPlayer.Statut+".png")
			else :
				get_node(TheNode + "/TextureOverworld").texture = Pokemon.GetImageOverworld(TheDico.Name)
				get_node(TheNode + "/Name").text = TheDico.Name
				get_node(TheNode + "/Life").text = str(TheDico.Hp) + "/" + str(TheDico.MaxHp)
				get_node(TheNode + "/Progress").max_value = TheDico.MaxHp
				get_node(TheNode + "/Progress").value = TheDico.Hp
				get_node(TheNode + "/Statut").texture = load("res://img Pokemon/img Animation/Animation - Statut/"+TheDico.Statut+".png")

	#CHECK COLORS FUCNTIONS
func SetAndGetModulate(x) :
	var ThePath
	match x :
		"Potion" : ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Potions/Potion/Potion
		"SuperPotion" : ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Potions/SuperPotion/SuperPotion
		"HyperPotion" : ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Potions/HyperPotion/HyperPotion
		"MaxPotion" : ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Potions/MaxPotion/MaxPotion
		"Guerison" : ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Potions/Guerison/Guerison
		"Rappel" : ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Rappels/Rappel/Rappel
		"RappelMax" : ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Rappels/RappelMax/RappelMax
		"Antidote" : ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/Antidote/Antidote
		"AntiPara" : ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/AntiPara/AntiPara
		"AntiBrule" : ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/AntiBrule/AntiBrule
		"Reveil" : ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/Reveil/Reveil
		"TotalSoin" : ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Antidotes/TotalSoin/TotalSoin
		"Eau" : ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Autres/Eau/Eau
		"Soda" : ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Autres/Soda/Soda
		"Limonade" : ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Autres/Limonade/Limonade
		"Lait" : ThePath = $MedicamentBox/ScrollContainer/VBoxContainer/Autres/Lait/Lait
		"Pokeball" : ThePath = $PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/Pokeball/Pokeball
		"SuperBall" : ThePath = $PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/SuperBall/SuperBall
		"HyperBall" : ThePath = $PokeballBox/ScrollContainer/VBoxContainer/Pokeball1/HyperBall/HyperBall
		"FiletBall" : ThePath = $PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/FiletBall/FiletBall
		"FaibloBall" : ThePath = $PokeballBox/ScrollContainer/VBoxContainer/Pokeball2/FaibloBall/FaibloBall
		"MasterBall" : ThePath = $PokeballBox/ScrollContainer/VBoxContainer/Pokeball3/MasterBall/MasterBall
		"Repousse" : ThePath = $ObjectBox/ScrollContainer/VBoxContainer/Objet1/Repousse/Repousse
		"SuperRepousse" : ThePath = $ObjectBox/ScrollContainer/VBoxContainer/Objet1/SuperRepousse/SuperRepousse
		"ChaussuresDeCourse" : ThePath = $RareObjectBox/ScrollContainer/VBoxContainer/ObjetsRares1/ChaussuresDeCourse/ChaussuresDeCourse
		"OrbeMysterieuse" : ThePath = $RareObjectBox/ScrollContainer/VBoxContainer/ObjetsRares1/OrbeMysterieuse/OrbeMysterieuse
	return ThePath
func SetNumberObject():
	for x in PG.AllObject["NumberObject"] :
		if PG.AllObject["NumberObject"][x] < 0  :
			PG.AllObject["NumberObject"][x] = 0
	#GET DICTIONNARY OBJECT
func GetDictionnaryValue(TheObject : String) :
	match TheObject :
		"Potion" : return PG.AllObject["NumberObject"].Potion
		"SuperPotion" : return PG.AllObject["NumberObject"].SuperPotion
		"HyperPotion" : return PG.AllObject["NumberObject"].HyperPotion
		"MaxPotion" : return PG.AllObject["NumberObject"].MaxPotion
		"Guerison" : return PG.AllObject["NumberObject"].Guerison
		"Rappel" : return PG.AllObject["NumberObject"].Rappel
		"RappelMax" : return PG.AllObject["NumberObject"].RappelMax
		"Antidote" : return PG.AllObject["NumberObject"].Antidote
		"AntiPara" : return PG.AllObject["NumberObject"].AntiPara
		"AntiBrule" : return PG.AllObject["NumberObject"].AntiBrule
		"Reveil" : return PG.AllObject["NumberObject"].Reveil
		"TotalSoin" : return PG.AllObject["NumberObject"].TotalSoin
		"Eau" : return PG.AllObject["NumberObject"].Eau
		"Soda" : return PG.AllObject["NumberObject"].Soda
		"Limonade" : return PG.AllObject["NumberObject"].Limonade
		"Lait" : return PG.AllObject["NumberObject"].Lait
		"Pokeball" : return PG.AllObject["NumberObject"].Pokeball
		"SuperBall" : return PG.AllObject["NumberObject"].SuperBall
		"HyperBall" : return PG.AllObject["NumberObject"].HyperBall
		"FiletBall" : return PG.AllObject["NumberObject"].FiletBall
		"FaibloBall" : return PG.AllObject["NumberObject"].FaibloBall
		"MasterBall" : return PG.AllObject["NumberObject"].MasterBall
		"Repousse" : return PG.AllObject["NumberObject"].Repousse
		"SuperRepousse" : return PG.AllObject["NumberObject"].SuperRepousse
func GetPokemonTarget() :
	match NumberPokemonSelection :
		1 : return PG.Pokemon1
		2 : return PG.Pokemon2
		3 : return PG.Pokemon3
		4 : return PG.Pokemon4
		5 : return PG.Pokemon5
		6 : return PG.Pokemon6
		_ : pass

#USE OBJECTS
	#MAIN FUNCTION
func UseAnObject(ThePokemon,StringObject) :
	match StringObject :
		"Potion" : APotion(StringObject,20)
		"SuperPotion" : APotion(StringObject,50)
		"HyperPotion": APotion(StringObject,200)
		"MaxPotion" : APotion(StringObject,ThePokemon.MaxHp-ThePokemon.Hp)
		"Guerison" : 
			APotion(StringObject,ThePokemon.MaxHp-ThePokemon.Hp)
			AnAndidote(StringObject,"",true)
		"Rappel" : ARevive(StringObject,2)
		"RappelMax" : ARevive(StringObject,1)
		"Antidote" : AnAndidote(StringObject,"Empoisonne",false)
		"AntiBrule" : AnAndidote(StringObject,"Brule",false)
		"Reveil" : AnAndidote(StringObject,"Endormi",false)
		"AntiPara" : AnAndidote(StringObject,"Paralyse",false)
		"TotalSoin" : AnAndidote(StringObject,"",true)
		"Eau" : APotion(StringObject,50)
		"Soda" : APotion(StringObject,60)
		"Limonade" : APotion(StringObject,80)
		"Lait" : APotion(StringObject,100)

	#SECONDARY OBJECTS
func APotion(StringObject,Number) :
	UsingObject = true
	if (str(CheckLife(GetPokemonTarget().Hp,GetPokemonTarget().MaxHp)) == "dead") :
		UsingObject = true
		GetPokemonTarget().Hp = 0
		$InformationText.text = "Impossible d'utiliser ce(tte) "+ StringObject + " sur un pokemon KO !"
	elif GetPokemonTarget().Hp == GetPokemonTarget().MaxHp :
		UsingObject = true
		$InformationText.text = StringObject + " ne fonctionne pas sur un pokemon en parfaite santé !"
	elif (!CheckLife(GetPokemonTarget().Hp,GetPokemonTarget().MaxHp)) :
		GetPokemonTarget().Hp += Number
		if GetPokemonTarget().Hp > GetPokemonTarget().MaxHp : GetPokemonTarget().Hp = GetPokemonTarget().MaxHp
		$UseObjectPopup.hide()
		$AnimationPlayer.stop()
		$ChoicePopup.hide()
		UsingObject = false
		ChangeObjectNumber(StringObject)
		quit_scene()
		if PG.ActualScene == "/root/FightScene" : emit_signal("theobjecthasbeenused",ActualObject)
		ActualObject = ""
	else : 
		UsingObject = true
		$InformationText.text = "Erreur !"
	loadValues()
	Save.saveGame(false)
func AnAndidote(StringObject,TheStatut,BoolStatut) : 
	UsingObject = true
	if TheStatut == GetPokemonTarget().Statut or BoolStatut :
		GetPokemonTarget().Statut = ""
		UsingObject = false
		$UseObjectPopup.hide()
		$AnimationPlayer.stop()
		$ChoicePopup.hide()
		UsingObject = false
		ChangeObjectNumber(StringObject)
		if PG.ActualScene == "/root/FightScene" : emit_signal("theobjecthasbeenused",ActualObject)
		ActualObject = ""
	else :
		$InformationText.text = StringObject + " ne fonctionne pas sur un pokemon avec ce statut !"
		UsingObject = true
	loadValues()
	Save.saveGame(false)
func ARevive(StringObject,Factor) :
	UsingObject = true
	if (str(CheckLife(GetPokemonTarget().Hp,GetPokemonTarget().MaxHp)) == "dead") :
		GetPokemonTarget().Hp = GetPokemonTarget().MaxHp/Factor
		$UseObjectPopup.hide()
		$AnimationPlayer.stop()
		$ChoicePopup.hide()
		UsingObject = false
		ChangeObjectNumber(StringObject)
		quit_scene()
		if PG.ActualScene == "/root/FightScene" : emit_signal("theobjecthasbeenused",ActualObject)
		ActualObject = ""
	else : 
		UsingObject = true
		$InformationText.text = StringObject + " ne fonctionne pas sur un pokemon en pleine forme !"
	loadValues()
	Save.saveGame(false)

	#OTHERS
func CheckLife(Life,MaxLife) :
	if Life <= 0 :
		return "dead"
	elif Life <= MaxLife :
		return false
	else :
		return true

#REPEAT ACTIONS
func quit_scene() :
	PG.CantdisplayMenu = false
	$ChoicePopup.hide()
	$JeterPopup.hide()
	$UseObjectPopup.hide()
	self.visible = false
	get_tree().paused = false

func Same(Text) :
	NodeTextureSelection = get_node(ActualTextureSelection)
	$ChoicePopup.popup()
	$InformationText.text = Text
	$AnimationPlayer.play("IdleSelectChoice")
func RepeatUse1() :
	$UseObjectPopup.popup()
	UsingObject = true
func CatchAPokemonInFight(PokeballBonus,PokeballName) :
	quit_scene()
	emit_signal("catchapokemon",PokeballBonus,PokeballName)
func CalculFiletBallBonus(Type1,Type2) :
	if Type1 == "Eau" or Type2 == "Eau" or Type1 == "Insecte" or Type2 == "Insecte" :
		return 3
	else : return 1
func CalculFaibloBallBonus(LvlEnnemi) :
	return (40-LvlEnnemi)/10
#ANIMATIONS
func AnimateSelectChoice() :
	NodeTextureSelection.modulate = Color.white
	yield(get_tree().create_timer(0.2),"timeout")
	NodeTextureSelection.modulate = Color.black
	yield(get_tree().create_timer(0.1),"timeout")
	NodeTextureSelection.modulate = Color.white
#SIGNAL FUNCTIONS
func ChangeObjectNumber(Name) :
	match Name:
		"Potion" : PG.AllObject["NumberObject"].Potion -= 1
		"SuperPotion" : PG.AllObject["NumberObject"].SuperPotion -= 1
		"HyperPotion" : PG.AllObject["NumberObject"].HyperPotion-= 1
		"MaxPotion" : PG.AllObject["NumberObject"].MaxPotion-= 1
		"Guerison" : PG.AllObject["NumberObject"].Guerison-= 1
		"Rappel" : PG.AllObject["NumberObject"].Rappel-= 1
		"RappelMax" : PG.AllObject["NumberObject"].RappelMax-= 1
		"Antidote" : PG.AllObject["NumberObject"].Antidote-= 1
		"AntiPara" : PG.AllObject["NumberObject"].AntiPara-= 1
		"AntiBrule" : PG.AllObject["NumberObject"].AntiBrule-= 1
		"Reveil" : PG.AllObject["NumberObject"].Reveil-= 1
		"TotalSoin" : PG.AllObject["NumberObject"].TotalSoin-= 1
		"Eau" :PG.AllObject["NumberObject"].Eau-= 1
		"Soda" :PG.AllObject["NumberObject"].Soda-= 1
		"Limonade" :PG.AllObject["NumberObject"].Limonade-= 1
		"Lait" :PG.AllObject["NumberObject"].Lait-= 1
		"Pokeball" :PG.AllObject["NumberObject"].Pokeball-= 1
		"SuperBall" :PG.AllObject["NumberObject"].SuperBall-= 1
		"HyperBall" :PG.AllObject["NumberObject"].HyperBall-= 1
		"FiletBall" :PG.AllObject["NumberObject"].FiletBall-= 1
		"FaibloBall" :PG.AllObject["NumberObject"].FaibloBall-= 1
		"MasterBall" :PG.AllObject["NumberObject"].MasterBall-= 1
		"Repousse" :PG.AllObject["NumberObject"].Repousse-= 1
		"SuperRepousse" :PG.AllObject["NumberObject"].SuperRepousse-= 1
	for x in PG.AllObject["NumberObject"] :
		if PG.AllObject["NumberObject"][x] == 0 or PG.AllObject["NumberObject"][x] < 0 :
			SetAndGetModulate(str(x)).modulate = Color.black

func _on_Outside_pressed():
	$UseObjectPopup.visible = false
	UseObjectInFight = false
	UsingObject = false
	$AnimationPlayer.stop()
	$ChoicePopup.hide()
	ActualObject = ""
func _on_OutsideButton_pressed():
	quit_scene()
	if PG.ActualScene == "/root/FightScene" :
		get_node("/root/FightScene/UIAction").Cantmove = false
		get_node("/root/FightScene/UIFight").visible = true
		get_node("/root/FightScene/UIAction").visible = true
		get_node("/root/FightScene/UIPokemonBox").visible = true
		get_node("/root/FightScene/UIPokemonBoxEnnemi").visible = true
#POKEMONS PRESSED
func _on_Pokemon1_pressed(): 
	NumberPokemonSelection = 1
	UseAnObject(GetPokemonTarget(),ActualObject)
func _on_Pokemon2_pressed(): 
	NumberPokemonSelection = 2
	UseAnObject(GetPokemonTarget(),ActualObject)
func _on_Pokemon3_pressed(): 
	NumberPokemonSelection = 3
	UseAnObject(GetPokemonTarget(),ActualObject)
func _on_Pokemon4_pressed(): 
	NumberPokemonSelection = 4
	UseAnObject(GetPokemonTarget(),ActualObject)
func _on_Pokemon5_pressed(): 
	NumberPokemonSelection = 5
	UseAnObject(GetPokemonTarget(),ActualObject)
func _on_Pokemon6_pressed(): 
	NumberPokemonSelection = 6
	UseAnObject(GetPokemonTarget(),ActualObject)
