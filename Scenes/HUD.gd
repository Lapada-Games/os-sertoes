extends CanvasLayer

signal wave_start
signal reset

func hide_stuff():
	$Store.visible = false
	$ControlButtons.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$HP.text = str(GameInfo.HP)
	$Store/Cash.text = "$" + str(GameInfo.get_cash())


func _on_play_button_pressed():
	hide_stuff()
	wave_start.emit()


func _on_reset_button_pressed():
	reset.emit()
