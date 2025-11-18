extends Node2D
class_name Enemy

@export var speed = 100
@export var hp = 100
@export var reward_coins = 5
@export var world_damage = 1
var burning: bool = false
var is_wet: bool = false
var last_speed = speed

func _ready():
	$HP.max_value = hp
	$HP.value = hp

func _process(delta):
	if self.progress_ratio >= 1:
		GameInfo.HP -= world_damage
		queue_free()
	
	if rotation_degrees < -90:
		$EnemyBody/Sprite2D.flip_v = true
	else:
		$EnemyBody/Sprite2D.flip_v = false
	
	self.progress += speed * delta
	$HP.rotation = -rotation
	$HP.global_position = $EnemyBody.global_position + Vector2(0, 40)

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
		
	if is_wet:
		is_wet = false
		$WetTimer.stop()
	
	burning = true
	$BurnTimerDPS.wait_time = tick_rate
	$BurnTimerDPS.start(tick_rate)
	$BurnTimerTotal.start(duration)
	
	# TODO: add burning animation later
	self.modulate = Color(2, 1, 1)
	
	set_meta("burn_dps", dps)

func wet(speed: int, duration: int):
	if is_wet:
		$WetTimer.stop()
		$WetTimer.start()
		return
		
	if burning:
		burning = false
		$BurnTimerDPS.stop()
	
	set_speed(speed)
	is_wet = true
	self.modulate = Color(1, 1.5, 2)
	$WetTimer.start(duration)

func set_speed(speed: int):
	self.last_speed = self.speed
	self.speed = speed

func _on_burn_timer_dps_timeout():
	if has_meta("burn_dps"):
		var dps = get_meta("burn_dps")
		damage(dps)

func _on_burn_timer_total_timeout():
	burning = false
	self.modulate = Color(1, 1, 1)
	$BurnTimerDPS.stop()

func _on_wet_timer_timeout():
	is_wet = false
	self.modulate = Color(1, 1, 1)
	self.speed = self.last_speed
