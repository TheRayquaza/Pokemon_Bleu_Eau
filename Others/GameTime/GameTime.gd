extends Timer

var ms = 0
var s = 0

func _process(delta):
	if ms > 9 :
		s+=1
		ms = 0
	if s > 59 :
		s = 0
		PG.GameTime.Minutes += 1
	if PG.GameTime.Minutes > 59 :
		PG.GameTime.Minutes = 0
		PG.GameTime.Hours += 1
	if PG.GameTime.Hours > 24 :
		PG.GameTime.Hours = 0
		PG.GameTime.Days += 1

func _on_GameTime_timeout():
	ms += 1
