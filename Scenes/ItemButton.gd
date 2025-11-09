extends Control

@export var tower_stats: TowerStats

@onready var tooltip = get_tree().get_root().get_node("Map").get_node("HUD").get_node("ToolTip")

func _ready():
	$TextureButton/TextureRect.texture = tower_stats.texture
	$RichTextLabel.text = "$" + str(tower_stats.price)

func _on_texture_button_pressed():
	var tempTower = null
	if tower_stats.item_name == "Cangaceiro":
		tempTower = tower_stats.tower.instantiate()
	else:
		tempTower = tower_stats.tower.instantiate()
	tempTower.building = true
	get_tree().get_root().get_node("Map").get_node("Towers").add_child(tempTower)


func _on_texture_button_mouse_entered():
	tooltip.set_text("[center]" + tower_stats.item_name + "[/center]\n" + tower_stats.description)
	tooltip.visible = true


func _on_texture_button_mouse_exited():
	tooltip.visible = false
