extends Control

var timeDelta = 0.0
var buttonRevealIndex = 0

var lore = false
var fade = false
var can_go_down = false
var can_go_up = false
var target = -800.0
var bg_speed = 0.15
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if fade:
		$Fade.visible = true
		$Fade.color = Color(0, 0, 0, lerp($Fade.color[3], 1.0, 1.333333 * delta))
		if $Fade.color[3] >= 0.99:
			get_tree().change_scene_to_file("res://Scenes/Credits.tscn")

	
	if lore:
		for button in $VBoxContainer.get_children():
			button.modulate = Color(1, 1, 1, lerp(button.modulate[3], 0.0, 2.0 * delta))
		$Logo.modulate = Color(1, 1, 1, lerp($Logo.modulate[3], 0.0, 2.0 * delta))
		if $BG.position.y > -2.0:
			get_tree().change_scene_to_file("res://Scenes/Lore.tscn")
	if timeDelta > 4.0:
		can_go_down = true
	if can_go_down:
		$Logo.position.y = lerp(float($Logo.position.y), 240.0, 1 * delta)
	$BG.position.y = lerp(float($BG.position.y), target, bg_speed * delta)
	
	if $Logo.position.y >= 200:
		if timeDelta > 0.4 and buttonRevealIndex < 3:
			$VBoxContainer.get_children()[buttonRevealIndex].visible = true
			if buttonRevealIndex != 1:
				$VBoxContainer.get_children()[buttonRevealIndex].disabled = false
			$VBoxContainer.get_children()[buttonRevealIndex].modulate = Color(1, 1, 1, 1)
			timeDelta = 0
			buttonRevealIndex += 1
			$appearSfx.play()
	timeDelta += delta


func _on_modo_historia_pressed():
	GameInfo.level = 1
	for button in $VBoxContainer.get_children():
		button.disabled = true
	$Theme.stop()
	$clickSfx.play()
	lore = true
	target = 0.0
	bg_speed = 2.0
	can_go_down = false


func _on_quit_pressed():
	get_tree().quit()



func _on_endless_pressed():
	for button in $VBoxContainer.get_children():
		button.disabled = true
	$Theme.stop()
	$clickSfx.play()
	fade = true
