extends Path2D

@export var arrow_color: Color
@onready var arrows = get_children().filter(func(e): return e.name.begins_with("Arrow"))

func _ready():
	for arrow in arrows:
		arrow.modulate = arrow_color

func _process(delta):
	for arrow in arrows:
		arrow.progress += 100 * delta

func set_visibility(visible: bool):
	for arrow in arrows:
		arrow.visible = visible

func all_enemies_defeated():
	return len(self.get_children().filter(func(element): return element is Enemy)) <= 0
