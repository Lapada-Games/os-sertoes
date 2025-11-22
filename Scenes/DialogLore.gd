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
	get_tree().change_scene_to_file("res://Scenes/Map.tscn")


func _on_animation_player_animation_finished(anim_name):
	# Hard coded animation trigger
	#if anim_name == "up":
		#if $DialogBox.get_dialog_index() == 2:
			#$DialogBox.visible = false
			#$AnimationPlayer.play("table_hit")
			#return
	$DialogBox.visible = true
