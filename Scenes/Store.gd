extends Panel


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

func is_player_building_something():
	var towers = get_tree().get_root().get_node("Map").get_node("Towers").get_children()
	for t in towers:
		if t is Tower and t.building:
			return true
	return false


# Called when the node enters the scene tree for the first time.
func _ready():
	var item_info = load_json_file("res://prices.json")
	print(item_info[0].name)
	if item_info:
		for i in range(len($FlowContainer.get_children())):
			var child = $FlowContainer.get_children()[i]
			child.item_name = item_info[i].name
			child.description = item_info[i].description


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# this disables the button whether the player is holding a tower or not
	var buttons = $FlowContainer.get_children()
	for b in buttons:
		b.get_node("TextureButton").disabled = is_player_building_something()
