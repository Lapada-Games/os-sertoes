extends CanvasLayer

signal wave_start
signal reset

func hide_sidebar():
	$Store.visible = false
	$ControlButtons.visible = false

func show_sidebar():
	$Store.visible = true
	$ControlButtons.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
# TODO: remove stuff that is not necessary to be executed every frame
func _process(delta):
	$HP.text = str(GameInfo.HP)
	$HBoxContainer/Cash.text = str(GameInfo.get_cash())
	if $Store.visible:
		$ControlButtons.visible = not $Store.is_building


func _on_play_button_pressed():
	hide_sidebar()
	wave_start.emit()
	
func update_store_buttons():
	$Store.update_buttons()

func _on_reset_button_pressed():
	reset.emit()
