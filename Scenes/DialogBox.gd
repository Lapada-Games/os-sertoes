extends CanvasLayer

@export_file("*.json") var scene_text_file
@export var scene_to_go_after_end: PackedScene

signal on_next_line
signal on_dialog_finished

var dialogue = null
var index = 0
var finished = false
var disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	dialogue = load_json_file(scene_text_file).dialogue
	show_text()
	on_next_line.emit()
 
func load_json_file(path: String) -> Variant:
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		push_error("Failed to open file: %s" % path)
		return null

	var content := file.get_as_text()
	file.close()

	var json := JSON.new()
	var parse_result := json.parse(content)
	if parse_result != OK:
		push_error("JSON parse error in file %s: %s" % [path, json.get_error_message()])
		return null

	return json.data

func next_line():
	if disabled:
		return
	if index + 1 > dialogue.size() - 1:
		on_dialog_finished.emit()
		if scene_to_go_after_end:
			get_tree().change_scene_to_packed(scene_to_go_after_end)
		return
	index += 1
	show_text()
	on_next_line.emit()
	
func show_text():
	
	$RichTextLabel.visible_characters = 0
	$RichTextLabel.text = dialogue[index].text
	if dialogue[index].has("speaker"):
		$character.visible = true
		$character.texture = load("res://Assets/Characters/" + dialogue[index].speaker.to_lower() + ".png")
		if dialogue[index].has("flip"):
			$character.flip_h = not dialogue[index].flip
		else:
			$character.flip_h = true
		$Box.texture = load("res://Assets/Dialog/box-shrinked.png")
		
	else:
		$character.visible = false
		$Box.texture = load("res://Assets/Dialog/box.png")
		$RichTextLabel.size.x = 1220
	finished = false
	while $RichTextLabel.visible_characters < len($RichTextLabel.text) and not finished:
		if disabled:
			$RichTextLabel.visible_characters = 0
		$RichTextLabel.visible_characters += 1
		await get_tree().create_timer(0.04).timeout
	finished = true

func get_current_speaker():
	if dialogue[index].has("speaker"):
		return dialogue[index].speaker
	return null

func get_dialog_index():
	return self.index

func set_disabled(disabled: bool):
	self.disabled = disabled

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			next_line()
		else:
			# skips dialog animation
			$RichTextLabel.visible_characters = len($RichTextLabel.text)
