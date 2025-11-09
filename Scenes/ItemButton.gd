extends Control

@onready var tower = preload("res://Scenes/Tower.tscn")

@export var item_name = "Aldeã"
@export var description = "Aldeã"

@onready var tooltip = get_tree().get_root().get_node("Map").get_node("HUD").get_node("ToolTip")
signal _mouse_entered


func _on_texture_button_pressed():
	var tempTower = tower.instantiate()
	tempTower.building = true
	get_tree().get_root().get_node("Map").get_node("Towers").add_child(tempTower)


func _on_texture_button_mouse_entered():
	tooltip.set_text("[center]" + item_name + "[/center]\n" + description)
	tooltip.visible = true


func _on_texture_button_mouse_exited():
	tooltip.visible = false
