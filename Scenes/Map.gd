extends Node2D

@export var level_data: Level

var enemy = preload("res://Scenes/Soldier.tscn")
var wave_index = 0
var spawn_time = 1 # enemy per second
var wave_started = false
var enemy_counter = 0
var group_queues: Array = []
var enemy_queue: Array = [] # queue for the first path2D node
var remaining_time: int
@onready var current_wave: Wave = level_data.waves[wave_index]
#@onready var arrows: Array[Node] = $Path2D.get_children().filter(func(e): return e.name.begins_with("Arrow")) + $Path2D2.get_children().filter(func(e): return e.name.begins_with("Arrow"))

# TODO: load level wave data based on the current level 
func _ready():
	if GameInfo.DEBUG:
		$DialogBox.queue_free()
	GameInfo.reset_hp()
	GameInfo.set_cash(level_data.cash)
	$HUD.update_store_buttons()
	show_wave_arrows(true)

func _process(delta):
	#move_arrows(delta)
	pass

func start_wave():
	wave_started = true
	current_wave = level_data.waves[wave_index]
	$Prebattle.stop()
	$Theme.play()
	for tower in $Towers.get_children().filter(func(e): return e is Tower):
		tower.start_durability_timer()
	show_wave_arrows(false)
	
	group_queues.clear()
	for group in current_wave.wave_groups:
		var queue = []
		for enemy in group.enemies:
			queue.append({
				"enemy_type": enemy.enemy_type,
				"remaining": enemy.quantity
			})
		group_queues.append({
			"queue": queue,
			"path": group.path,
			"index": 0
		})
	# starting the timer
	$SpawnTimer.wait_time = spawn_time
	$SpawnTimer.start()

func end_wave():
	wave_started = false
	$HUD.show_sidebar()
	# pausing the timer in each tower
	$Theme.stream_paused = true
	$Prebattle.play()
	AudioManager.play_sfx("applause")
	for tower in $Towers.get_children().filter(func(e): return e is Tower):
		tower.pause_durability_timer()
	
	# TODO: change this later
	if wave_index >= len(level_data.waves) / 2:
		TowerDatabase.increase_all_prices()
	$HUD.update_store_buttons()
	$SpawnTimer.stop()
	
	if wave_index + 1 > len(level_data.waves) - 1:
		call_deferred("change_scene", "res://Scenes/Menu.tscn")
		return
	enemy_counter = 0
	wave_index += 1
	current_wave = level_data.waves[wave_index]
	show_wave_arrows(true)

func spawn_enemy():
	for group in group_queues:
		var enemy_queue = group["queue"]
		var enemy_counter = group["index"]
		var path = group["path"]
		
		if enemy_counter >= enemy_queue.size():
			continue # the group is finished
		
		var entry = enemy_queue[enemy_counter]
		var tempEnemy = entry["enemy_type"].instantiate()
		get_node(path).add_child(tempEnemy)
		entry["remaining"] -= 1
		if entry["remaining"] <= 0:
			group["index"] += 1
	

func show_wave_arrows(visible: bool):
	for group in current_wave.wave_groups:
		get_node(group.path).set_visibility(visible)

func _on_hud_wave_start():
	start_wave()

func _on_spawn_timer_timeout():
	spawn_enemy()

func _on_dialog_box_on_dialog_finished():
	$DialogBox.queue_free()


func _on_hud_reset():
	for tower in $Towers.get_children():
		GameInfo.add_cash(TowerDatabase.get_price(tower.tower_name))
		tower.queue_free()
	$HUD.update_store_buttons()


func _on_path_2d_child_exiting_tree(node):
	if GameInfo.HP < 1:
		# Move the scene change to the end of the frame
		call_deferred("change_scene", "res://Scenes/game_over.tscn")
		return # Stop the function here so we don't check the win condition

	if $Path2D.all_enemies_defeated() and $Path2D2.all_enemies_defeated():
		print("ganhou!")
		end_wave()

func change_scene(scene_path: String):
	# A safety check to ensure we aren't already changing scenes
	if get_tree(): 
		get_tree().change_scene_to_file(scene_path)



