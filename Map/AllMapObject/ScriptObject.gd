extends StaticBody2D

var player
var playerAnimation
var playerTexture
var animationGoSomeWhere

export (String) var Scene
export (String) var NodePositionPath
export (String) var MoveToChange
var IsIn = false
var Velocity = Vector2(0,-1)
var HaveToMove = false

func _ready():
	if PG.ActualScene != "/root/FightScene" :
		player = get_node(PG.ActualScene + "/Player")
		playerAnimation = get_node(PG.ActualScene + "/Player/Animation")
		playerTexture = get_node(PG.ActualScene + "/Player/TexturePlayer")
		animationGoSomeWhere = get_node(PG.ActualScene + "/GUITotal/GoSomeWhere")

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
	if MoveToChange != null :
		if (Input.is_action_pressed(MoveToChange) and IsIn) :
			go_inside()

func go_inside() :
#	Animation
	PG.CantMoveCauseChangingScene = true
#	$AnimatedSprite.play("open")
#	yield(get_node("AnimatedSprite"),"animation_finished")
#	HaveToMove = true
#	$AnimatedSprite.play("close")
#	yield(get_node("AnimatedSprite"),"animation_finished")
	animationGoSomeWhere.play("GoInside")
#	Save Position
	PG.NodePositionPath = NodePositionPath
#	Scene
	yield(animationGoSomeWhere, "animation_finished")
	PG.CantMoveCauseChangingScene = false
	PG.UnUsed = get_tree().change_scene(Scene)
