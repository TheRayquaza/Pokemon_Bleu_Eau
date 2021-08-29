extends ProgressBar

func loading() :
	self.visible = true
	$AnimationPlayer.play("Loading")
	yield($AnimationPlayer,"animation_finished")
	self.visible = false
