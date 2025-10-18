extends StaticBody2D

var Bullet = preload("res://Bullet.tscn")
var bulletDamage = 5
var balas = 3
var pathName
var currTargets = []
var recarregando = false
var curr

@onready var shoot_timer = $ShootTimer
	
func _on_torre_body_entered(body):
	if body.is_in_group("inimigos"):
		var tempArray = []
		currTargets = get_node("Torre").get_overlapping_bodies()
		for i in currTargets:
			if i.is_in_group("inimigos"):
				tempArray.append(i)
			
		var currTarget = null
		for i in tempArray:
			if currTarget == null:
				currTarget = i.get_node("../")
			else:
				if i.get_parent().get_progress() > currTarget.get_progress():
					currTarget = i.get_node("../")
				
		curr = currTarget
		pathName = currTarget.get_parent().name
		if balas > 0 and recarregando == false:
			var tempBullet = Bullet.instantiate()
			tempBullet.pathName = pathName
			tempBullet.bulletDamage = bulletDamage
			get_node("BulletContainer").call_deferred("add_child", tempBullet)
			tempBullet.global_position = $Aim.global_position
			balas = balas - 1
			print(balas)
		elif balas == 0 and recarregando == false:
			recarregando = true
			$timer.start()
		else:
			return

func _on_timer_timeout():
	balas = 3
	recarregando = false
	
	
func _on_tower_body_exited(body):
	
	pass


