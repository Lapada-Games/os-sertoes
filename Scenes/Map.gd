extends Node2D

# There will be multiple waves per level
# Depending on the global level variable, the waves will be different each time
var waves = [
	[5, 10, 20],
	[3, 5, 10],
	[2, 3, 4]
]
var money = [100, 500, 1000]


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
