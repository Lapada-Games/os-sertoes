extends Node2D

# FOR DEBUG
var skip_dialog = false

func _ready():
	if skip_dialog:
		$DialogBox.queue_free()

func _on_spawn_timer_timeout():
	pass # Replace with function body.


func _on_dialog_box_on_dialog_finished():
	$DialogBox.queue_free()
