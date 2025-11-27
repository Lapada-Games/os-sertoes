extends Node

@onready var splash: AudioStreamPlayer = $splash
@onready var fizz: AudioStreamPlayer = $fizz
@onready var pre_battle: AudioStreamPlayer = $pre_battle
@onready var battle01: AudioStreamPlayer = $battle_theme1
@onready var applause: AudioStreamPlayer = $applause
@onready var wave_start: AudioStreamPlayer = $wave_start

func play_sfx(type: String):
	match type:
		"splash":
			splash.play()
		"fizz":
			fizz.play()
		"applause":
			applause.play()
		"wave_start":
			wave_start.play()
