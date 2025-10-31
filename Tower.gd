extends Area2D

@export var attack_damage: int = 10
@export var attack_speed: float = 1.0
@export var range: float = 100.0


var enemies_in_range: Array[Node2D] = []
var current_target: Node2D = null
var time_since_last_shot: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Range/CollisionShape2D.shape.radius = range
	


func _physics_process(delta):
	
	if current_target != null:
		look_at(current_target.global_position)

func _on_range_body_entered(body):
	if body is Enemy:
		enemies_in_range.append(body)
		#temp
		current_target = enemies_in_range[0]

func _on_range_body_exited(body):
	if body in enemies_in_range:
		enemies_in_range.erase(body)
		if body == current_target:
			current_target = null
