extends Control

@onready var tower = preload("res://Scenes/Tower.tscn")
@onready var cangaceiro_tower = preload("res://Scenes/CangaceiroTower.tscn")

var item_name = null
var description = null

@onready var tooltip = get_tree().get_root().get_node("Map").get_node("HUD").get_node("ToolTip")

func setup(item_name: String, filename: String, description: String, price: int):
	self.item_name = item_name
	self.description = description
	$TextureButton/TextureRect.texture = load("res://Assets/Characters/sprites/" + filename)
	$RichTextLabel.text = "$" + str(price)

func _on_texture_button_pressed():
	var tempTower = null
	if item_name == "Cangaceiro":
		tempTower = cangaceiro_tower.instantiate()
	else:
		tempTower = tower.instantiate()
	tempTower.building = true
	get_tree().get_root().get_node("Map").get_node("Towers").add_child(tempTower)


func _on_texture_button_mouse_entered():
	tooltip.set_text("[center]" + item_name + "[/center]\n" + description)
	tooltip.visible = true


func _on_texture_button_mouse_exited():
	tooltip.visible = false
