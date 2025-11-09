extends Control

@onready var tower = preload("res://Scenes/Tower.tscn")
@onready var tooltip = preload("res://Scenes/ToolTip.tscn")

@export var item_name = "Aldeã"
@export var description = "Aldeã"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	var tempTower = tower.instantiate()
	tempTower.building = true
	get_tree().get_root().get_node("Map").get_node("Towers").add_child(tempTower)


func _on_mouse_entered():
	print("vivo")
	var temptooltip = tooltip.instantiate()
	temptooltip.get_node("Text").text = "testeeeee"
	add_child(temptooltip)


func _on_mouse_exited():
	get_child(1).queue_free()
