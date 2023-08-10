extends RigidBody2D

signal fruit_missed

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	position.x = 50 + (randi() % int(screen_size.x - 100))
	angular_velocity = (randi() % 10) - 5

func _on_visible_on_screen_notifier_2d_screen_exited():
	fruit_missed.emit()
	queue_free()
