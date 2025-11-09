class_name Enemy
extends Node2D

@export var speed = 100
@export var hp = 100
@export var reward_coins = 50

func _ready():
	$HP.value = hp

func _process(delta):
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
		queue_free()
	$HP.value = hp
