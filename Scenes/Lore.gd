extends Node2D

var fade: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fade:
		$BookBox/Fade.visible = true
		$BookBox/Fade.color = Color(0, 0, 0, lerp($BookBox/Fade.color[3], 1.0, 1.333333 * delta))
		$AudioStreamPlayer.volume_db = lerp($AudioStreamPlayer.volume_db, -80.0, 0.333333 * delta)
		if $BookBox/Fade.color[3] >= 0.99:
			get_tree().change_scene_to_file("res://Scenes/DialogLore.tscn")


func _on_book_box_on_dialog_finished():
	fade = true
