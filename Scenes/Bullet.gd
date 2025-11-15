extends CharacterBody2D
class_name Bullet

# TODO: remove these useless values. except for speed?
@export var speed = 300
@export var effects: Array[BulletEffect]

var target: Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_instance_valid(target):
		queue_free() # destroy if target is gone before bullet reaching it
		return
	
	if target != null:
		var direction = (target.global_position - global_position).normalized()
		velocity = direction * speed
	
		move_and_slide()
	
		if global_position.distance_to(target.global_position) < 10:
			for e in effects:
				e.apply_effect(target.get_parent())
			queue_free()
		
