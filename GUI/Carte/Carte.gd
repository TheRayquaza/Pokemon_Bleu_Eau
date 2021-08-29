extends TextureRect

func _process(delta):
	if visible :
		loadCurseur()

func loadCurseur() :
	match PG.ActualPlace :
		"Bourg-Palette" :
			$Curseur.rect_position = Vector2(255,430)
		"Argenta" :
			$Curseur.rect_position = Vector2(255,203)
		"Jadielle" :
			$Curseur.rect_position = Vector2(255,330)
		"Route 1" :
			$Curseur.rect_position = Vector2(255,385)
		"Route 2" :
			$Curseur.rect_position = Vector2(255,275)

func _on_Outside_pressed():
	self.visible = false
