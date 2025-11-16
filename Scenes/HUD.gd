extends CanvasLayer

signal wave_start

func hide_stuff():
	$Store.visible = false
	$PlayButton.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HP.text = str(GameInfo.HP)
	$Store/Cash.text = "$" + str(GameInfo.get_cash())


func _on_play_button_pressed():
	hide_stuff()
	wave_start.emit()
