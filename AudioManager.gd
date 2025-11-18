extends Node

@onready var splash: AudioStreamPlayer = $splash

func play_sfx(type: String):
	match type:
		"splash":
			splash.play()
