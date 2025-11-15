extends BulletEffect
class_name FireEffect

@export var duration: float
@export var dps: int
@export var tick_rate: float

func apply_effect(target: Enemy):
	target.burn(duration, dps, tick_rate)
