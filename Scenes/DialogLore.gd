extends Node2D


var last_speaker: String

# Called when the node enters the scene tree for the first time.
func _ready():
	last_speaker = $DialogBox.get_current_speaker()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# TEMP
func _on_temp_timer_timeout():
	$DialogBox.disabled = not $DialogBox.disabled


func _on_dialog_box_on_next_line():
	var dialog_index = $DialogBox.get_dialog_index()
	if $DialogBox.get_current_speaker() == "captain":
		if last_speaker != "captain":
			$AnimationPlayer.play("down")
	elif $DialogBox.get_current_speaker() == "governador":
		if last_speaker != "governador":
			$AnimationPlayer.play("up")
	last_speaker = $DialogBox.get_current_speaker()


func _on_dialog_box_on_dialog_finished():
	print("terminou")
