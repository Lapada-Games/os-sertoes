class_name Tower
extends Area2D


@export var bullet = preload("res://Scenes/Bullet.tscn")
@export var bullet_effects: Array[BulletEffect]
#@export var attack_damage: int = 10
@export var attack_speed: float = 1.0
@export var range: float = 100.0
@export var price: int
@export var durability: int = 100

var enemies_in_range: Array[Node2D] = []
var current_target: Node2D = null
var time_since_last_shot: float = 0.0
var target_position: Vector2
var building = false:
	set(value):
		if building != value:
			building = value
			emit_signal("building_state_changed", building)
var can_place = true
var has_shooted = false

signal building_state_changed(is_building: bool)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Range/CollisionShape2D.shape.radius = range
	$Range/Circle.size = Vector2(range * 2, range * 2)
	$Range/Circle.position = Vector2(-range, -range)
	$Durability.max_value = durability
	$Durability.value = durability
	GameInfo.reset_hp()

func _process(delta):
	if not building:
		$Range/Circle.visible = false # TODO: replace this to somewhere else
		time_since_last_shot += delta
		if current_target == null:
			$Sprite2D.animation = "idle"
			find_new_target()
		
		if current_target != null:
			aim_to_target(current_target.global_position)
			
			if time_since_last_shot > (1.0 / attack_speed):
				shoot(current_target.global_position)
				time_since_last_shot = 0.0
	else:
		$Range/Circle.visible = true
		global_position = get_global_mouse_position()
		if not get_overlapping_areas().is_empty():
			can_place = false
			$Range/Circle.modulate = Color(1, 0, 0)
		else:
			can_place = true
			$Range/Circle.modulate = Color(1, 1, 1)
		
		if Input.is_action_just_pressed("click"):
			if can_place:
				building = false

func _on_range_body_entered(body):
	if body.name == "EnemyBody":
		enemies_in_range.append(body)

func _on_range_body_exited(body):
	if body in enemies_in_range:
		enemies_in_range.erase(body)
		if body == current_target:
			current_target = null

func shoot(target: Vector2):
	$Sprite2D.animation = "attack"
	$shoot_SFX.play()
	var tempbullet: Bullet = bullet.instantiate()
	tempbullet.target = current_target
	tempbullet.global_position = self.global_position
	tempbullet.effects = bullet_effects.duplicate()
	get_parent().add_child(tempbullet)

func find_new_target():
	# TODO: # Clean up the list by removing invalid/dead enemies
	if enemies_in_range.is_empty():
		current_target = null
		return
	current_target = enemies_in_range[0]
	

func aim_to_target(pos: Vector2):
	$Arrow.look_at(pos)
	var clamped_angle = wrapf($Arrow.rotation_degrees, 0, 360)
	if clamped_angle > 90 and clamped_angle < 273:
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	target_position = pos

func start_durability_timer():
	$DurabilityTimer.paused = false # idk if is necessary
	$DurabilityTimer.start()

func pause_durability_timer():
	$DurabilityTimer.paused = true

func _on_durability_timer_timeout():
	self.durability -= 1
	if self.durability <= 0:
		queue_free()
	$Durability.value = durability
