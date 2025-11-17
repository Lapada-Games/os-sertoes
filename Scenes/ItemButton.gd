extends Control

@export var tower_stats: ItemTowerStats
# TODO: this is a bad practice, so, change this later
@onready var tooltip = get_tree().get_root().get_node("Map").get_node("HUD").get_node("ToolTip")

func _ready():
	$TextureButton/TextureRect.texture = tower_stats.texture
	$RichTextLabel.text = "$" + str(tower_stats.price)

func _process(delta):
	pass

func _on_texture_button_pressed():
	var tempTower = null
	tempTower = tower_stats.tower.instantiate()
	GameInfo.subtract_cash(tower_stats.price)
	tempTower.building_state_changed.connect(get_parent().get_parent()._on_tower_building_state_changed)
	tempTower.building = true
	get_tree().get_root().get_node("Map").get_node("Towers").add_child(tempTower)


func _on_texture_button_mouse_entered():
	tooltip.set_text("[center]" + tower_stats.item_name + "[/center]\n" + tower_stats.description)
	tooltip.visible = true


func _on_texture_button_mouse_exited():
	tooltip.visible = false
