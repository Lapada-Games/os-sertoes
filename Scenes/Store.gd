extends Panel

var is_building = false

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

func _on_tower_building_state_changed(_is_building):
	is_building = _is_building
	var buttons = $FlowContainer.get_children()
	for b in buttons:
		b.get_node("TextureButton").disabled = _is_building || GameInfo.get_cash() < b.tower_stats.price


func _on_hud_reset():
	var buttons = $FlowContainer.get_children()
	for b in buttons:
		b.get_node("TextureButton").disabled = GameInfo.get_cash() < b.tower_stats.price


func _on_visibility_changed():
	var buttons = $FlowContainer.get_children()
	for b in buttons:
		b.get_node("TextureButton").disabled = GameInfo.get_cash() < b.tower_stats.price
