extends Node2D

var enemy = preload("res://Scenes/Soldier.tscn")
var current_level = GameInfo.level
var wave_index = 0
var spawn_time = 1 # enemy per second

func start_wave():
	$Music.stream = load("res://OST/battle_01.ogg")
	$Music.play()
	$SpawnTimer.wait_time = spawn_time
	$SpawnTimer.start()

func end_wave():
	if GameInfo.HP <= 0:
		print("perdeu")
	if $Path2D.get_child_count() <= 1:
		print("ganhou!")
		# TODO: ganhar

func spawn_enemy():
	var tempEnemy = enemy.instantiate()
	$Path2D.add_child(tempEnemy)


func _on_hud_wave_start():
	start_wave()


func _on_path_2d_child_exiting_tree(node):
	end_wave()


func _on_spawn_timer_timeout():
	spawn_enemy()
