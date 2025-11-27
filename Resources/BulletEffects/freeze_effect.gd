extends BulletEffect
class_name FreezeEffect

@export var cooldown_percentage: float
@export var duration: float

func apply_effect(target: Enemy):
	target.wet(cooldown_percentage, duration)
