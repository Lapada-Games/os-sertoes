extends DialogBox

@export var max_figure_amount = 4
var figure_index = 1

func show_text():
	
	$RichTextLabel.visible_characters = 0
	$RichTextLabel.text = dialogue[index].text
	finished = false
	while $RichTextLabel.visible_characters < len($RichTextLabel.text) and not finished:
		if disabled:
			$RichTextLabel.visible_characters = 0
		$RichTextLabel.visible_characters += 1
		await get_tree().create_timer(0.04).timeout
	finished = true

func show_next_figure():
	if figure_index > max_figure_amount - 1:
		return
	$Figure.texture = load("res://Assets/LoreImages/" + str(figure_index) + ".png")
	figure_index += 1

func _on_on_next_line():
	if self.index != 0:
		$AnimationPlayer.play("page_flip_forward")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "page_flip_forward":
		$AnimationPlayer.play("RESET")
		if dialogue[index].has("image"):
			$Figure.texture = load(dialogue[index]["image"])
