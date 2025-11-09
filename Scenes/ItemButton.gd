extends Control

# temp
@onready var tower = preload("res://Scenes/Tower.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_texture_button_pressed():
	var tempTower = tower.instantiate()
	tempTower.building = true
	get_parent().get_parent().get_parent().get_parent().add_child(tempTower)
