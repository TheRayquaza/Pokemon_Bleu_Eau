extends StaticBody2D

export (Texture) var TheTexture

func _ready():
	get_node("Sprite").texture = TheTexture
