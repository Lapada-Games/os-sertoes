extends Panel

var is_building = false

func _on_tower_building_state_changed(_is_building):
	is_building = _is_building
	var buttons = $FlowContainer.get_children()
	for b in buttons:
		if b.tower_instance:
			b.get_node("TextureButton").disabled = _is_building || GameInfo.get_cash() < TowerDatabase.get_price(b.tower_instance.tower_name)


func update_buttons():
	var buttons = $FlowContainer.get_children()
	for b in buttons:
		if b.tower_instance:
			b.get_node("TextureButton").disabled = GameInfo.get_cash() < TowerDatabase.get_price(b.tower_instance.tower_name)
			b.update_button()

func _on_visibility_changed():
	update_buttons()
