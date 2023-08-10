extends Node2D

var screen_size
signal hit

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func _input(event):
	if event is InputEventMouseMotion:
		position.x = event.position.x
		position.x = clamp(position.x, 50, screen_size.x - 50)

func _on_body_entered(body):
	hit.emit()
	body.queue_free()
