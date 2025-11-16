extends Node2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_path_2d_child_exiting_tree(node):
	if $Path2D.get_child_count() <= 1:
		print("ganhou!")
		# TODO: ganhar
