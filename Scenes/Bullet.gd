extends CharacterBody2D
class_name Bullet

@export var speed = 300
@export var effects: Array[BulletEffect]
@export var area_radius: int = 0
@export var sfx_name: String

var target: Node2D

func _ready():
	$Range/CollisionShape2D.shape.radius = self.area_radius

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
			if sfx_name:
				AudioManager.play_sfx(sfx_name)
			for e in effects:
				if self.area_radius > 0:
					var bodies = $Range.get_overlapping_bodies()
					for body in bodies:
						e.apply_effect(body.get_parent())
				else:
					e.apply_effect(target.get_parent())

			queue_free()
		
