extends Node

@onready var splash: AudioStreamPlayer = $splash
@onready var fizz: AudioStreamPlayer = $fizz

func play_sfx(type: String):
	match type:
		"splash":
			splash.play()
		"fizz":
			fizz.play()
