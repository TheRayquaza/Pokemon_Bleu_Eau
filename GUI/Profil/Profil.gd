extends ColorRect

var TempDisplay = true

func _input(event):
	if !visible :
		loadValues()
		TempDisplay = true
	elif visible :
		loadValues()
		if TempDisplay : 
			$BG1.visible = true
			TempDisplay = false

func _on_BG1_pressed():
	if $BG1.visible :
		$BG1.visible = false
		$BG2.visible = true
func _on_BG2_pressed():
	if $BG2.visible :
		$BG2.visible = false
		$BG1.visible = true
func _on_TextureButton_pressed():
	self.visible = false
	get_tree().paused = false
	PG.CantdisplayMenu = false

func loadValues() :
	$BG1/Name.text = PG.PlayerName
	$BG1/Argent.text = str(PG.Argent)
	$BG1/TempsDeJeu.text = str(PG.GameTime.Days) + " J / " + str(PG.GameTime.Hours) + " H / " + str(PG.GameTime.Minutes) + " M"
