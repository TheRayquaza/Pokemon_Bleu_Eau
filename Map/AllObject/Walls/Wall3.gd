extends StaticBody2D

export (String) var Scene
export (String) var TheAction
export (String) var NodePosition

var animationGoSomeWhere
var IsIn = false
var Initialisation = false

func _process(delta):
	while !Initialisation :
		animationGoSomeWhere = get_node(PG.ActualScene + "/GUITotal/GoSomeWhere")
		if animationGoSomeWhere != null : Initialisation = true

func _on_Area2D_body_entered(body):
	IsIn = true
func _on_Area2D_body_exited(body):
	IsIn = false

func _input(event):
	if ((Input.is_action_just_pressed(TheAction) or (Input.is_action_pressed(TheAction))) and IsIn) :
		PG.CantMoveCauseChangingScene = true
		animationGoSomeWhere.play("GoInside")
		yield(animationGoSomeWhere,"animation_finished")
		PG.CantMoveCauseChangingScene = false
		if NodePosition != null :
			PG.NodePositionPath = NodePosition
		PG.UnUsed = get_tree().change_scene(Scene)
