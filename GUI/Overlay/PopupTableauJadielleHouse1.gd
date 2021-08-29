extends Popup

onready var UISpeackScene = get_node(PG.ActualScene + "/GUITotal").get_node("UISpeackPopUp")

var TXT1
var TXT2
var TXT3

var line = 1
var column = 1
var reading = false

func _input(event):
	if !visible : reading = false
	elif reading : pass
	elif Input.is_action_just_pressed("ui_accept") :
		if $Arrow6.visible : 
			self.hide()
		else :
			reading = true
			self.hide()
			yield(get_tree().create_timer(0.2),"timeout")
			display_message()
	elif Input.is_action_just_pressed("ui_down") and line + 1 < 3 : line += 1
	elif Input.is_action_just_pressed("ui_up") and line - 1 > 0 : line -= 1
	elif Input.is_action_just_pressed("ui_right") and column + 1 < 4 : column += 1
	elif Input.is_action_just_pressed("ui_left") and column - 1 > 0 : column -= 1
	ShowLoadAndSet(line,column)

func ShowLoadAndSet(TheLine,TheColumn) :
	match TheLine :
		1 :
			match TheColumn :
				1 :
					Allinvisble()
					$Arrow1.visible = true
					TXT1 = "Un Pokemon ne peut attaquer s'il est endormi !"
					TXT2 = "Un Pokemon reste endormi meme apres un combat."
					TXT3 = "Un reveil peut le remettre sur pied"
				2 :
					Allinvisble()
					$Arrow2.visible = true
					TXT1 = "Un Pokemon empoisonne voit son energie se vider doucement."
					TXT2 = "Le poison ne disparait pas apres un combat."
					TXT3 = "L'antidote soigne le poison !"
				3 :
					Allinvisble()
					$Arrow3.visible = true
					TXT1 = "La paralysie peut annuler certaines attaques !"
					TXT2 = "La paralysie ne disparait pas apres un combat."
					TXT3 = "L'Anti-para soigne toute paralysie !"
		2 :
			match TheColumn :
				1 :
					Allinvisble()
					$Arrow4.visible = true
					TXT1 = "La brulure reduit la puissance. Elle inflige aussi des degats continus."
					TXT2 = "La brulure ne disparait pas apres un combat."
					TXT3 = "L'anti-brule soigne les grands brules !"
				2 :
					Allinvisble()
					$Arrow5.visible = true
					TXT1 = "Un Pokemon gele reste immobile !"
					TXT2 = "Il reste gele meme apres la fin du combat."
					TXT3 = "Un Antigel peut rechauffer un Pokemon !"
				3 :
					Allinvisble()
					$Arrow6.visible = true
func Allinvisble() :
	$Arrow1.visible = false
	$Arrow2.visible = false
	$Arrow3.visible = false
	$Arrow4.visible = false
	$Arrow5.visible = false
	$Arrow6.visible = false

func display_message():
	UISpeack.ListOfTxt = [TXT1,TXT2,TXT3]
	UISpeackScene.display()
