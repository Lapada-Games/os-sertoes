extends BulletEffect
class_name FreezeEffect

@export var speed: int
@export var duration: float

func apply_effect(target: Enemy):
	target.set_speed(speed)
