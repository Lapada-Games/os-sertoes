extends Control

@onready var tower = preload("res://Scenes/Tower.tscn")
@onready var tooltip = preload("res://Scenes/ToolTip.tscn")

@export var item_name = "Aldeã"
@export var description = "Aldeã"

var showing_tooltip = false
signal _mouse_entered

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if showing_tooltip:
		var temptooltip = tooltip.instantiate()
		temptooltip.get_node("Text").text = "[center]" + item_name + "[/center]\n" + description
		get_tree().get_root().get_node("Map").get_node("HUD").add_child(temptooltip)
		emit_signal("_mouse_entered")
		showing_tooltip = false


func _on_texture_button_pressed():
	var tempTower = tower.instantiate()
	tempTower.building = true
	get_tree().get_root().get_node("Map").get_node("Towers").add_child(tempTower)


#func _on_mouse_entered():
	#print("vivo")
	#var temptooltip = tooltip.instantiate()
	#temptooltip.get_node("Text").text = "testeeeee"
	#add_child(temptooltip)


func _on_texture_button_mouse_entered():
	showing_tooltip = true
	


func _on_texture_button_mouse_exited():
	showing_tooltip = false
	print("morra")
	get_tree().get_root().get_node("Map").get_node("HUD").get_node("ToolTip").queue_free()
