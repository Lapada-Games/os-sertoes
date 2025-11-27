extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_reiniciar_pressed():
	get_tree().change_scene_to_file("res://Scenes/Map.tscn")


func _on_sair_pressed():
	get_tree().quit()
