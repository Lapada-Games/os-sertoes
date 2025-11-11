extends Control

var timeDelta = 0.0
var buttonRevealIndex = 0

var fade = false
var can_go_down = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fade:
		$Fade.visible = true
		$Fade.color = Color(0, 0, 0, lerp($Fade.color[3], 1.0, 0.01))
		if $Fade.color[3] >= 0.99:
			get_tree().change_scene_to_file("res://Scenes/Lore.tscn")
	if timeDelta > 4.0:
		can_go_down = true
	if can_go_down:
		$Logo.position.y = lerp(float($Logo.position.y), 240.0, 1 * delta)
	$BG.position.y = lerp(float($BG.position.y), -800.0, 0.1 * delta)
	
	if $Logo.position.y >= 200:
		if timeDelta > 0.4 and buttonRevealIndex < 3:
			$VBoxContainer.get_children()[buttonRevealIndex].modulate = Color(1, 1, 1, 1)
			timeDelta = 0
			buttonRevealIndex += 1
			$appearSfx.play()
	timeDelta += delta


func _on_modo_historia_pressed():
	for button in $VBoxContainer.get_children():
		button.disabled = true
	$Theme.stop()
	$clickSfx.play()
	fade = true


func _on_quit_pressed():
	get_tree().quit()

