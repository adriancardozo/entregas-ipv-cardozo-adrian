extends Sprite
class_name Projectile

signal delete_requested(projectile)

var direction: Vector2
export (float) var speed

func _ready():
	set_physics_process(false)

func set_starting_values(starting_position: Vector2, direction: Vector2):
	global_position = starting_position
	self.direction = direction
	$Timer.start()
	set_physics_process(true)

func _physics_process(delta):
	if _is_over_viewport():
		emit_signal("delete_requested", self)
	position += direction*speed*delta

func _is_over_viewport():
	return global_position.x <= 0 or global_position.x >= get_viewport().get_size_override().x or  global_position.y <= 0 or global_position.y >= get_viewport().get_size_override().y
