extends Sprite

export (Texture) var TheTexture

func _ready():
	if TheTexture == null : pass
	else : self.texture = TheTexture
