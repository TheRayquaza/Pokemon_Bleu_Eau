extends Popup

var array = []

#This function is used to display a unique TXT Easly (88 MIN - 83 MAJ)
#Expect one argument -> String
func display_a_txt(ATXT) :
	show_popup()
	UISpeack.PassTxt = false
	$Text.text = ATXT
	$Show_Text.play("Show_Text")
	while (!UISpeack.PassTxt) :
		yield(get_tree().create_timer(0.1), "timeout")
	hide_popup()

#This function is used to display multiple TXT with an array
func display() :
	show_popup()
	array = UISpeack.ListOfTxt
	for member in array :
		UISpeack.PassTxt = false
		$Text.text = member
		$Show_Text.play("Show_Text")
		while (!UISpeack.PassTxt) :
			yield(get_tree().create_timer(0.1),"timeout")
	hide_popup()

#Display Popup to screen
func show_popup() :
	self.popup()
	get_tree().paused = true

#Hide Popup to screen
func hide_popup() :
	self.hide()
	get_tree().paused = false

func _input(_event):
	if Input.is_action_pressed("ui_speack_accept") :
		if ($Text.percent_visible != 1) :
			$Show_Text.playback_speed = 10
		else :
			$Show_Text.playback_speed = 1
			UISpeack.PassTxt = true
