extends Node2D

@export var level_data: Level

var enemy = preload("res://Scenes/Soldier.tscn")
var wave_index = 0
var spawn_time = 1 # enemy per second
var wave_started = false
var enemy_counter = 0
var enemy_queue: Array = [] 

@onready var arrows = $Path2D.get_children().filter(func(element): return element.name.begins_with("Arrow"))
@onready var current_wave: Wave = level_data.waves[wave_index]



# TODO: load level wave data based on the current level 
func _ready():
	if GameInfo.DEBUG:
		$DialogBox.queue_free()

func _process(delta):
	if not wave_started:
		for arrow in arrows:
			arrow.progress += 100 * delta

func start_wave():
	wave_started = true
	$Music.stream = load("res://OST/battle_01.ogg")
	$Music.play()
	for tower in $Towers.get_children().filter(func(e): return e is Tower):
		tower.start_durability_timer()
	$Path2D/Arrow1.visible = false
	$Path2D/Arrow2.visible = false
	$Path2D/Arrow3.visible = false
	
	enemy_queue.clear()
	for entry in current_wave.enemies:
		enemy_queue.append({
			"scene": entry.enemy_type,
			"remaining": entry.quantity
		})
	# starting the timer
	$SpawnTimer.wait_time = spawn_time
	$SpawnTimer.start()

func end_wave():
	wave_started = false
	# pausing the timer in each tower
	for tower in $Towers.get_children().filter(func(e): return e is Tower):
		tower.pause_durability_timer()
	

func spawn_enemy():
	if enemy_counter >= enemy_queue.size():
		$SpawnTimer.stop()
		return
	
	var entry = enemy_queue[enemy_counter]
	var tempEnemy = entry["scene"].instantiate()
	$Path2D.add_child(tempEnemy)
	
	entry["remaining"] -= 1
	if entry["remaining"] <= 0:
		enemy_counter += 1


func _on_hud_wave_start():
	start_wave()

func _on_spawn_timer_timeout():
	spawn_enemy()

func _on_dialog_box_on_dialog_finished():
	$DialogBox.queue_free()


func _on_hud_reset():
	for tower in $Towers.get_children():
		tower.queue_free()


func _on_path_2d_child_exiting_tree(node):
	if GameInfo.HP <= 0:
		print("perdeu")
		end_wave()
	if len($Path2D.get_children().filter(func(element): return not element.name.begins_with("Arrow"))) <= 1:
		print("ganhou!")
		end_wave()
