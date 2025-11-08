class_name Enemy
extends Node2D

var speed = 100
var hp = 100

func _ready():
	$HP.value = hp

func _process(delta):
	self.progress += speed * delta
	$HP.rotation = -rotation
	$HP.global_position = $Enemy.global_position + Vector2(0, 40)

func damage(amount: int):
	hp -= amount
	if hp <= 0:
		queue_free()
	$HP.value = hp
