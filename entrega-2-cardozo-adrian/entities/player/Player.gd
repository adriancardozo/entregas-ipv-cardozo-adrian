extends Sprite

onready var cannon: Sprite = $Cannon
var velocity: Vector2 = Vector2.ZERO
export (float) var ACCELERATION: float = 20.0
export (float) var H_SPEED_LIMIT: float = 600.0 
export (float) var FRICTION_WEIGHT: float = 0.1

var speed = 200 #Pixeles
var projectile_container: Node

func set_projectile_container(container: Node):
	cannon.projectile_container = container
	projectile_container = container

func _physics_process(delta):
	_update_cannon_position()
	_process_shots()
	_update_position(delta)
	
func _update_cannon_position():
	var mouse_position: Vector2 = get_global_mouse_position()
	cannon.look_at(mouse_position)
	
func _process_shots():
	if Input.is_action_just_pressed("fire"):
		cannon.fire()
		
func _update_position(delta):
	var direction: int = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	if direction != 0:
		velocity.x = clamp(velocity.x + (direction * ACCELERATION), -H_SPEED_LIMIT, H_SPEED_LIMIT)
	else:
		velocity.x = lerp(velocity.x, 0, FRICTION_WEIGHT) if abs(velocity.x) > 1 else 0
	position += velocity * delta
