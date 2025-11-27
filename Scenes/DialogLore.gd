extends Node2D


var last_speaker: String
var last_emotion: String
var fade: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$DialogBox.set_dialogue("res://Dialogs/before-level" + str(GameInfo.level) + ".json")
	last_speaker = $DialogBox.get_current_speaker()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if fade:
		$DialogBox.visible = false
		$Fade.color[3] += 0.5 * delta
		$Theme.volume_db = lerp($Theme.volume_db, -60.0, 0.3 * delta)
		if $Fade.color[3] > 0.9:
			get_tree().change_scene_to_file("res://Scenes/Map.tscn")
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
	fade = true


func _on_animation_player_animation_finished(anim_name):
	# Hard coded animation trigger
	var emotion = $DialogBox.get_dialog_emotion()
	if anim_name == "up" or anim_name == "down":
		if emotion == "surprised":
			$Sprite2D.texture = load("res://Assets/LoreImages/general_astonished.png")
			if last_emotion != emotion:
				$Theme.stream = load("res://OST/fear.mp3")
				$Theme.play()
		elif emotion == "angry":
			$Sprite2D.texture = load("res://Assets/LoreImages/general_angry.png")
			if last_emotion != emotion and last_emotion != "furious":
				$Theme.stream = load("res://OST/general_angry.mp3")
				$Theme.play()
		elif emotion == "furious":
			if last_emotion != emotion:
				$DialogBox.visible = false
				$AnimationPlayer.play("table_hit")
		elif emotion == "neutral":
			$Sprite2D.texture = load("res://Assets/LoreImages/general_neutral.png")
	else:
		$DialogBox.visible = true
	
	if emotion:
		last_emotion = emotion

