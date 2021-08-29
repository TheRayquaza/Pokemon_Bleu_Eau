extends Popup


func showText(Text) :
	$display.stop()
	$display.play("display")
	$Label.text = Text
