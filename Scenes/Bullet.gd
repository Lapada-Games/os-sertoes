extends CharacterBody2D


@export var target: Node2D
@export var speed = 300
@export var damage = 10

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
			target.get_parent().damage(damage)
			queue_free()
		
