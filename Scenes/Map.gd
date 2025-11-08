extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_path_2d_child_exiting_tree(node):
	if $Path2D.get_child_count() <= 1:
		print("ganhou!")
		# TODO: ganhar
