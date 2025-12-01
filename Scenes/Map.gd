extends Node2D

@export var level_data: Level

var enemy = preload("res://Scenes/Soldier.tscn")
var wave_index = 0
var spawn_time = 1 # enemy per second
var wave_started = false
var enemy_counter = 0
var group_queues: Array = []
var enemies_defeated = 0
var remaining_time: int
var current_wave: Wave

func _ready():
	#if GameInfo.level >= 3:
		#get_tree().change_scene_to_file("res://Scenes/Menu.tscn")
	if GameInfo.level == 2:
		$Theme.stream = load("res://OST/battle_01.ogg")
	elif GameInfo.level == 4:
		$Theme.stream = load("res://OST/matadeira.mp3")
		
	#level_data = load("res://Resources/LevelData/Levels/Level" + str(GameInfo.level) + ".tres")
	current_wave = level_data.waves[wave_index]
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
	if GameInfo.level == 4:
		$MatadeiraZoomTimer.start()
	$HUD.play_wave_popup_animation(wave_index)
	wave_started = true
	current_wave = level_data.waves[wave_index]
	$Prebattle.stop()
	$Theme.play()
	for tower in $Towers.get_children().filter(func(e): return e is Tower):
		if GameInfo.level == 4:
			tower.durability *= 4
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
	
	# TODO: maybe change this later
	#if wave_index == int(len(level_data.waves) / 2):
		#TowerDatabase.increase_all_prices()
	$HUD.update_store_buttons()
	$SpawnTimer.stop()
	
	if wave_index + 1 > len(level_data.waves) - 1:
		GameInfo.next_level()
		call_deferred("change_scene", "res://Scenes/DialogLore.tscn")
		return
	enemy_counter = 0
	wave_index += 1
	current_wave = level_data.waves[wave_index]
	show_wave_arrows(true)

func spawn_enemy():
	enemy_counter += 1
	for group in group_queues:
		var enemy_queue = group["queue"]
		var enemy_index = group["index"]
		var path = group["path"]
		
		if enemy_index >= enemy_queue.size():
			continue # the group is finished
		
		var entry = enemy_queue[enemy_index]
		var tempEnemy = entry["enemy_type"].instantiate()
		get_node(path).add_child(tempEnemy)
		entry["remaining"] -= 1
		if entry["remaining"] <= 0:
			group["index"] += 1

func enemies_remaining() -> bool:
	var sum = 0
	for group in group_queues:
		var enemy_queue = group["queue"]
		for enemy in enemy_queue:
			sum += enemy["remaining"]
	return sum > 0

func show_wave_arrows(visible: bool):
	for group in current_wave.wave_groups:
		get_node(group.path).set_visibility(visible)

func get_total_tower_values():
	var sum: int = 0
	for tower in $Towers.get_children().filter(func(e): return e is Tower):
		sum += int(float(tower.durability) / float(tower.total_durability) * tower.paid_price)
	return sum
func _on_hud_wave_start():
	start_wave()

func _on_spawn_timer_timeout():
	spawn_enemy()

func _on_dialog_box_on_dialog_finished():
	$DialogBox.queue_free()


func _on_hud_reset():
	for tower in $Towers.get_children().filter(func(e): return e is Tower):
		# calculates the price based on the tower durability
		# the lower the durability, the lower the price
		var devalued_price = int(float(tower.durability) / float(tower.total_durability) * tower.paid_price)
		GameInfo.add_cash(devalued_price)
		tower.queue_free()
	$HUD.update_store_buttons()
	await get_tree().process_frame
	$HUD/ControlButtons/ResetButton.text = "Limpar\n(+$" + str(self.get_total_tower_values()) + ")"



func _on_path_2d_child_exiting_tree(node):
	if node.name == "Matadeira":
		$Fade.visible = true
		$HUD.visible = false
		var timer: Timer = Timer.new()
		timer.one_shot = true
		timer.timeout.connect(func(): get_tree().change_scene_to_file("res://Scenes/Credits.tscn"))
		add_child(timer)
		timer.start(1.5)
		return
	
	if not node is Enemy:
		return
	if GameInfo.HP < 1:
		# Move the scene change to the end of the frame
		call_deferred("change_scene", "res://Scenes/game_over.tscn")
		return # Stop the function here so we don't check the win condition
	
	await get_tree().process_frame # this line does some magic that makes the shit work (i guess)
	if $Path2D.all_enemies_defeated() and $Path2D2.all_enemies_defeated() and not enemies_remaining():
		print("ganhou!")
		end_wave()

func change_scene(scene_path: String):
	# A safety check to ensure we aren't already changing scenes
	if get_tree(): 
		get_tree().change_scene_to_file(scene_path)





func _on_matadeira_zoom_timer_timeout():
	$AnimationPlayer.play("zoom_matadeira")
