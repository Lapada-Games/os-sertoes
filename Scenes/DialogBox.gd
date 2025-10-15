extends CanvasLayer

@export var character_name: String = ""
@export_file("*.json") var scene_text_file


var dialogue = null
var index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	dialogue = load_json_file(scene_text_file).dialogue
	show_text()
 
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
	if index + 1 > dialogue.size() - 1:
		return
	index += 1
	show_text()
	
func show_text():
	$RichTextLabel.text = dialogue[index].text
	if dialogue[index].has("speaker"):
		$character.visible = true
		$character.texture = load("res://Assets/Characters/" + dialogue[index].speaker.to_lower() + ".png")
		$Box.texture = load("res://Assets/Dialog/box-shrinked.png")
		
	else:
		$character.visible = false
		$Box.texture = load("res://Assets/Dialog/box.png")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		next_line()
