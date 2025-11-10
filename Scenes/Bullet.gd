extends CharacterBody2D

# TODO: remove these useless values. except for speed?
@export var speed = 300
@export var damage = 10
@export var type = "rock"
@export var effects = ["damage"] # TODO: change this to resources (component system)

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
			# TODO: change this to resources (component system)
			if "damage" in effects:
				target.get_parent().damage(damage)
			if "freeze" in effects:
				# TODO: create slow down function in enemy
				# that receives slow down value from effect resource
				target.get_parent().speed = 50 
			if "fire" in effects:
				target.get_parent().burn(3.0, 20, 1.0)
			queue_free()
		
