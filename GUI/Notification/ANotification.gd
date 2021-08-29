extends Area2D

export (String) var NameNotification

onready var player = get_node(PG.ActualScene +"/Player")

func _ready():
	var Notification = get_node(PG.ActualScene + "/GUITotal/Notification")
	Notification.showText(PG.ActualPlace)

func _on_ANotification_body_entered(body):
	if body == player :
		get_node(PG.ActualScene + "/GUITotal/Notification").showText(NameNotification)
		PG.ActualPlace = NameNotification
