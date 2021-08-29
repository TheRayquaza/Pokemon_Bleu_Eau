extends StaticBody2D

var player

var HaveToMove = false
var Velocity : Vector2

func _ready():
	if PG.ActualScene != "/root/FightScene" :
		player = get_node(PG.ActualScene + "/Player")

func _physics_process(delta):
	if HaveToMove :
		player.move_and_collide(Velocity)
		player.get_node("Animation").play("JumpAir")
		player.get_node("Animation").visible = true
		player.get_node("TexturePlayer").visible = false
func _on_Area2D_body_entered(body):
	if body == player :
		Velocity.y = 1.2
		PG.CantMoveCauseJumping = true
		HaveToMove = true


func _on_Area2D_body_exited(body):
	if body == player :
		PG.CantMoveCauseJumping = false
		HaveToMove = false
		player.get_node("Animation").visible = false
		player.get_node("TexturePlayer").visible = true
