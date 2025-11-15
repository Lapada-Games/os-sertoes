extends BulletEffect
class_name DamageEffect

@export var damage: int

func apply_effect(target: Enemy):
	target.damage(damage)
