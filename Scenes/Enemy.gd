extends Node2D
class_name Enemy

@export var speed = 100
@export var hp = 100
@export var reward_coins = 5
@export var world_damage = 1
var burning: bool = false

func _ready():
	$HP.max_value = hp
	$HP.value = hp

func _process(delta):
	if self.progress_ratio >= 1:
		GameInfo.HP -= world_damage
		queue_free()
	
	if rotation_degrees < -90:
		$Enemy/Sprite2D.flip_v = true
	else:
		$Enemy/Sprite2D.flip_v = false
	
	self.progress += speed * delta
	$HP.rotation = -rotation
	$HP.global_position = $Enemy.global_position + Vector2(0, 40)

func damage(amount: int):
	hp -= amount
	if hp <= 0:
		GameInfo.add_cash(self.reward_coins)
		queue_free()
	$HP.value = hp

func burn(duration: float, dps: int, tick_rate: float):
	if burning:
		$BurnTimerTotal.start()
		return
	
	burning = true
	$BurnTimerDPS.wait_time = tick_rate
	$BurnTimerDPS.start()
	$BurnTimerTotal.start(duration)
	
	# TODO: add burning animation later
	self.modulate = Color(2, 1, 1)
	
	set_meta("burn_dps", dps)

func set_speed(speed: int):
	self.speed = speed

func _on_burn_timer_dps_timeout():
	if has_meta("burn_dps"):
		var dps = get_meta("burn_dps")
		damage(dps)

func _on_burn_timer_total_timeout():
	burning = false
	self.modulate = Color(1, 1, 1)
	$BurnTimerDPS.stop()


