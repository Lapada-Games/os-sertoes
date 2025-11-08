extends Area2D

@export var attack_damage: int = 10
@export var attack_speed: float = 1.0
@export var range: float = 100.0

const bullet = preload("res://Scenes/Bullet.tscn")
var enemies_in_range: Array[Node2D] = []
var current_target: Node2D = null
var time_since_last_shot: float = 0.0
var target_position: Vector2

var has_shooted = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Range/CollisionShape2D.shape.radius = range


func _process(delta):
	time_since_last_shot += delta
	if current_target == null:
		find_new_target()
	
	if current_target != null:
		aim_to_target(current_target.global_position)
		
		if time_since_last_shot > (1.0 / attack_speed):
			shoot(current_target.global_position)
			time_since_last_shot = 0.0

func _on_range_body_entered(body):
	if body.name == "Enemy":
		enemies_in_range.append(body)

func _on_range_body_exited(body):
	if body in enemies_in_range:
		enemies_in_range.erase(body)
		if body == current_target:
			current_target = null

func shoot(target: Vector2):
	var tempbullet = bullet.instantiate()
	tempbullet.target = current_target
	tempbullet.global_position = self.global_position
	tempbullet.damage = 50
	get_parent().add_child(tempbullet)

func find_new_target():
	# TODO: # Clean up the list by removing invalid/dead enemies
	if enemies_in_range.is_empty():
		current_target = null
		return
		
	current_target = enemies_in_range[0]
	

func aim_to_target(pos: Vector2):
	$Arrow.look_at(pos)
	target_position = pos



