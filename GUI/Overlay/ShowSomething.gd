extends Popup

signal ShowTexture(ThePath)
signal ShowTextureCentered(ThePath)

func _input(event):
	if Input.is_action_pressed("ui_accept") and visible :
		self.hide()
		get_tree().paused = false

func _on_ShowSometing_ShowTexture(ThePath):
	$TextureToShow.texture = load(ThePath)
	self.popup()




