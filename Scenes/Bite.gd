extends Bullet

@onready var anim = $AnimatedSprite2D

func _ready():
	anim.play("Bite")
	$Range/CollisionShape2D.shape.radius = self.area_radius
