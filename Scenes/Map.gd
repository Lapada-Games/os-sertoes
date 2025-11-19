extends Node2D

var enemy = preload("res://Scenes/ShieldSoldier.tscn")
var current_level = GameInfo.level
var wave_index = 0 # this variable has to be local to the scene!
var spawn_time = 1 # enemy per second
@onready var arrows = $Path2D.get_children().filter(func(element): return element.name.begins_with("Arrow"))

var wave_started = false

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
	$SpawnTimer.wait_time = spawn_time
	$SpawnTimer.start()
	$Path2D/Arrow1.visible = false
	$Path2D/Arrow2.visible = false
	$Path2D/Arrow3.visible = false

func end_wave():
	wave_started = false
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

func _on_dialog_box_on_dialog_finished():
	$DialogBox.queue_free()


func _on_hud_reset():
	for tower in $Towers.get_children():
		tower.queue_free()
