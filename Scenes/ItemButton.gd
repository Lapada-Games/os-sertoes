extends Control

@export var tower_scene: PackedScene
@export var button_texture: Texture2D
# TODO: this is a bad practice, so, change this later
@onready var tooltip = get_tree().get_root().get_node("Map").get_node("HUD").get_node("ToolTip")
@onready var tower_instance = tower_scene.instantiate() as Tower

func _ready():
	$TextureButton/TextureRect.texture = button_texture
	update_button()
	#print(tower_instance.tower_name)

func update_button():
	$RichTextLabel.text = "$" + str(TowerDatabase.get_tower_info(tower_instance.tower_name)["price"])

func _on_texture_button_pressed():
	GameInfo.subtract_cash(TowerDatabase.get_price(tower_instance.tower_name))
	var tempTower = tower_scene.instantiate()
	tempTower.building_state_changed.connect(get_parent().get_parent()._on_tower_building_state_changed)
	tempTower.building = true
	get_tree().get_root().get_node("Map").get_node("Towers").add_child(tempTower)


func _on_texture_button_mouse_entered():
	tooltip.set_text("[center]" + tower_instance.tower_name + "[/center]\n" + tower_instance.description)
	tooltip.visible = true


func _on_texture_button_mouse_exited():
	tooltip.visible = false
