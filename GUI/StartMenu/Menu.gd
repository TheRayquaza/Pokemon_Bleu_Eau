extends Control

func _on_Menu_tree_entered():
	$AnimationPlayer.play("BGAnimation")
func _input(event):
	if (Input.is_action_pressed("ui_accept")) :
		$AnimationPlayer.play("ChangeScene")
		yield($AnimationPlayer,"animation_finished")
		PG.UnUsed = get_tree().change_scene("res://Others/MenuSysteme/MenuSysteme.tscn")
