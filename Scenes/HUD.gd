extends CanvasLayer

signal wave_start
signal reset

func hide_sidebar():
	$Store.visible = false
	$ControlButtons.visible = false

func show_sidebar():
	$Store.visible = true
	$ControlButtons.visible = true

func play_wave_popup_animation(wave_number):
	match (wave_number + 1):
		1:
			$WaveCounter.text = "[center]Primeiro ataque[/center]"
		2:
			$WaveCounter.text = "[center]Segundo ataque[/center]"
		3:
			$WaveCounter.text = "[center]Terceiro ataque[/center]"
		4:
			$WaveCounter.text = "[center]Quarto ataque[/center]"
		5:
			$WaveCounter.text = "[center]Quinto ataque[/center]"
		6:
			$WaveCounter.text = "[center]Sexto ataque[/center]"
		_:
			$WaveCounter.text = "[center]Ataque " + str(wave_number + 1) + "[/center]"
	$AnimationPlayer.play("wave")

func _ready():
	$Day.text = "Dia " + str(GameInfo.level)

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


func _on_store_visibility_changed():
	$Store.update_buttons()


func _on_control_buttons_visibility_changed():
	await get_tree().process_frame
	$ControlButtons/ResetButton.text = "Limpar\n(+$" + str(get_parent().get_total_tower_values()) + ")"
