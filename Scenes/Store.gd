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

func _on_tower_building_state_changed(_is_building):
	var buttons = $FlowContainer.get_children()
	for b in buttons:
		b.get_node("TextureButton").disabled = _is_building || GameInfo.get_cash() < b.tower_stats.price

	
#func _process(delta):
	#var buttons = $FlowContainer.get_children()
	#for b in buttons:
		#print(b.get_node("TextureButton").disabled)
# TODO: this is unoptimized, because every frame it is calling a O(n) function
# implement signals instead
#func _process(delta):
	## this disables the button whether the player is holding a tower or not
	#var buttons = $FlowContainer.get_children()
	#for b in buttons:
		#b.get_node("TextureButton").disabled = is_player_building_something()
