extends KinematicBody2D

export (float) var MOTION_SPEED = 2 # Pixels/second.

func _ready():
	PG.ActualScene = str(get_tree().current_scene.get_path())

#PROCESS ABOUT INTERRACTION

func _process(_delta):
	PG.Last_position = GetActualPosition()

#PROCESS ABOUT PHYSIC AND ANIMATION

func _physics_process(_delta):
	
	var motion : Vector2
	motion.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	motion.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	motion = motion.normalized() * MOTION_SPEED
	
	
	if motion != Vector2.ZERO :
		$RayCast2D.cast_to = motion.normalized() * 30
	if (Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_right")) or (Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_left")) or (Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_right")) or (Input.is_action_pressed("ui_up") and Input.is_action_pressed("ui_left") or (Input.is_action_pressed("ui_right") and Input.is_action_pressed("ui_left")) or (Input.is_action_pressed("ui_down") and Input.is_action_pressed("ui_up")) or (UIFight.IsFightLaunch) or (PG.CantMoveCauseChangingScene)) :
		$Animation.visible = false
		$Animation.stop()
		$TexturePlayer.visible = true
	elif PG.CantMoveCauseJumping :
		pass
	
	
	elif Input.is_action_pressed("ui_down") and PG.IsShoesEquip:
		PG.UnUsed = move_and_collide(motion)
		$Animation.visible = true
		$Animation.play("DownRun")
		$TexturePlayer.visible = false
		$TexturePlayer.texture = load("res://img Pokemon/img Map/Player Fixe/PlayerFace.png")
	elif Input.is_action_pressed("ui_down"):
		PG.UnUsed = move_and_collide(motion)
		$Animation.visible = true
		$Animation.play("Down")
		$TexturePlayer.visible = false
		$TexturePlayer.texture = load("res://img Pokemon/img Map/Player Fixe/PlayerFace.png")
	
	elif Input.is_action_pressed("ui_up") and PG.IsShoesEquip:
		PG.UnUsed = move_and_collide(motion,true)
		$Animation.visible = true
		$Animation.play("TopRun")
		$TexturePlayer.visible = false
		$TexturePlayer.texture = load("res://img Pokemon/img Map/Player Fixe/PlayerDos.png")
	elif Input.is_action_pressed("ui_up"):
		PG.UnUsed = move_and_collide(motion,true)
		$Animation.visible = true
		$Animation.play("Top")
		$TexturePlayer.visible = false
		$TexturePlayer.texture = load("res://img Pokemon/img Map/Player Fixe/PlayerDos.png")
	
	elif Input.is_action_pressed("ui_left") and PG.IsShoesEquip:
		PG.UnUsed = move_and_collide(motion)
		$Animation.visible = true
		$Animation.play("LeftRun")
		$TexturePlayer.visible = false
		$TexturePlayer.texture = load("res://img Pokemon/img Map/Player Fixe/PlayerLeft.png")
	elif Input.is_action_pressed("ui_left"):
		PG.UnUsed = move_and_collide(motion)
		$Animation.visible = true
		$Animation.play("Left")
		$TexturePlayer.visible = false
		$TexturePlayer.texture = load("res://img Pokemon/img Map/Player Fixe/PlayerLeft.png")
	
	elif Input.is_action_pressed("ui_right") and PG.IsShoesEquip:
		PG.UnUsed = move_and_collide(motion)
		$Animation.visible = true
		$Animation.play("RightRun")
		$TexturePlayer.visible = false
		$TexturePlayer.texture = load("res://img Pokemon/img Map/Player Fixe/PlayerRight.png")
	elif Input.is_action_pressed("ui_right"):
		PG.UnUsed = move_and_collide(motion)
		$Animation.visible = true
		$Animation.play("Right")
		$TexturePlayer.visible = false
		$TexturePlayer.texture = load("res://img Pokemon/img Map/Player Fixe/PlayerRight.png")
	
	else:
		$TexturePlayer.visible = true
		$Animation.visible = false
		$Animation.stop()

func _input(event):
	if (event.is_action_pressed("speack")) :
		var target = $RayCast2D.get_collider()
		if target != null :
			if target.is_in_group("StaticSpeack") :
				target.talk()
			if target.is_in_group("StaticMessage") :
				target.display_message()

#CONNECTION WITH OTHERS
#	ENVIRONNEMENT -> INTERN MAP

func GetActualPosition() :
	return self.position

func _on_Player_tree_entered():
	#UIFIGHT
	UIFight.SceneAfterFight = str(get_tree().current_scene.filename)
	UIFight.IsFightLaunch = false
	#Save Position
	PG.ActualScene = str(get_tree().current_scene.get_path())
	PG.ActualSceneFile = str(get_tree().current_scene.filename)
	#save on entering in a scene
	if Save.FirstTimeSave :
		Save.loadGame()
		Save.saveGame(false)
		Save.FirstTimeSave = false
	else : Save.saveGame(false)
	#Position
	if PG.NodePositionPath == "LastPosition" : self.position = PG.Last_position
	elif PG.ActualScene == "/root/Map" and PG.NodePositionPath != null :self.position = get_node("/root/Map/Positions/" + PG.NodePositionPath).position
	elif PG.ActualScene == "/root/ForetDeJade" and PG.NodePositionPath != null :self.position = get_node(PG.ActualScene + "/" + PG.NodePositionPath).position
	elif PG.ActualScene != null and PG.NodePositionPath != null and PG.NodePositionPath != "Spawn" : self.position = get_node(PG.ActualScene + "/" + PG.NodePositionPath).position
	elif PG.Last_position == Vector2(0,0) and PG.ActualScene == "/root/Map" : self.position = get_node("/root/Map/Positions/Spawn").position
	else : 
		self.position = Vector2(0,0)
	Save.saveGame(false)
