extends StaticBody2D

onready var player = get_node("/root/Map/Player")
onready var playerAnimation = get_node("/root/Map/Player/Animation")
onready var playerTexture = get_node("/root/Map/Player/TexturePlayer")
onready var animationGoSomeWhere = get_node("/root/Map/GUITotal").get_child(6)

export (String) var Scene

var IsIn = false
var Velocity = Vector2(0,-1)
var HaveToMove = false

func _physics_process(delta):
	if HaveToMove :
		player.move_and_collide(Velocity)
		playerAnimation.visible = true
		playerAnimation.play("Top")
		playerAnimation.position.y = playerAnimation.position.y - 1
		playerTexture.visible = false
func _on_Area2D_body_entered(body):
	if(body == player) :
		IsIn = true
func _on_Area2D_body_exited(body):
	if(body == player) :
		IsIn = false
func _input(event):
	if (Input.is_action_pressed("ui_up") and IsIn) :
		go_inside()

func go_inside() :
#	Animation
	$AnimatedSprite.play("open")
	yield(get_node("AnimatedSprite"),"animation_finished")
	HaveToMove = true
	$AnimatedSprite.play("close")
	yield(get_node("AnimatedSprite"),"animation_finished")
	animationGoSomeWhere.play("GoInside")
#	Save
	PG.Last_position = Vector2(player.GetActualPosition())
#	Scene
	PG.ActualScene = Scene
	yield(get_tree().create_timer(1), "timeout")
	PG.UnUsed = get_tree().change_scene(Scene)
