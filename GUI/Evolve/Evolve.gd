extends Control

onready var AnimationEvolve = $AnimationPlayer.get_animation("Evolve")

func _process(delta):
	if PG.SomeoneEvolve and PG.NumberPokemonEvolve != 0 :
		PG.SomeoneEvolve = false
		self.visible = true
		get_tree().paused = true
		$AnimationPlayer.play("Evolve")
		AnimationEvolve.track_set_key_value(0,0,Pokemon.GetImageEvolve(PG.NumberPokemonEvolve))
		AnimationEvolve.track_set_key_value(0,1,Pokemon.GetImageEvolve(PG.NumberPokemonEvolve+1))
		yield($AnimationPlayer,"animation_finished")
		self.visible = false
		get_tree().paused = false
		PG.NumberPokemonEvolve = 0
